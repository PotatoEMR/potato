////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) r4 client using httpc

import fhir/potato_server_1_0_0/resource
import fhir/potato_server_1_0_0/sansio.{type FhirClient}
import fhir/potato_server_1_0_0/search_param
import gleam/dynamic/decode.{type Decoder}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/httpc
import gleam/io
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}

pub type Err {
  ErrHttpc(err: httpc.HttpError)
  ErrSansio(err: ErrFromSansio)
}

pub type ErrFromSansio {
  ///got json but could not parse it, probably a missing required field
  ErrParseJson(json.DecodeError)
  ///did not get resource json, often server eg nginx gives basic html response
  ErrServer(Response(String))
  ///got operationoutcome error from fhir server
  ErrOperationoutcome(resource.Operationoutcome)
  ///could not make an update or delete request because resource has no id
  ErrNoId
}

pub fn err_to_string(err: Err) -> String {
  case err {
    ErrSansio(err:) ->
      case err {
        ErrParseJson(err) ->
          sansio.err_response_to_string(sansio.ErrParseJson(err))
        ErrServer(err) -> sansio.err_response_to_string(sansio.ErrServer(err))
        ErrOperationoutcome(err) ->
          sansio.err_response_to_string(sansio.ErrOperationoutcome(err))
        ErrNoId -> sansio.err_request_to_string
      }
    ErrHttpc(err:) -> http_err_to_string(err)
  }
}

fn any_create(
  resource: Json,
  resource_type: resource.ResourceType,
  resource_decoder: Decoder(r),
  client: FhirClient,
) -> Result(r, Err) {
  let http_request = sansio.any_create_request(resource, resource_type, client)
  send_request_and_parse_resource(http_request, resource_decoder, client)
}

fn any_read(
  id: String,
  client: FhirClient,
  resource_type: resource.ResourceType,
  resource_decoder: Decoder(a),
) -> Result(a, Err) {
  let http_request = sansio.any_read_request(id, resource_type, client)
  send_request_and_parse_resource(http_request, resource_decoder, client)
}

fn any_update(
  id: Option(String),
  resource: Json,
  resource_type: resource.ResourceType,
  resource_decoder: Decoder(r),
  client: FhirClient,
) -> Result(r, Err) {
  let http_request =
    sansio.any_update_request(id, resource, resource_type, client)
  case http_request {
    Ok(http_request) ->
      send_request_and_parse_resource(http_request, resource_decoder, client)
    Error(_) -> Error(ErrSansio(ErrNoId))
    //can have error preparing update request if resource has no id
  }
}

pub fn any_delete(
  id: String,
  resource_type: resource.ResourceType,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHttp, Err) {
  let http_request = sansio.any_delete_request(id, resource_type, client)
  case httpc.send(http_request |> request.set_body("")) {
    Error(err) -> Error(ErrHttpc(err))
    Ok(http_response) ->
      case sansio.delete_response(http_response) {
        Ok(operation_outcome_or_http) -> Ok(operation_outcome_or_http)
        Error(err) ->
          Error(
            ErrSansio(case err {
              sansio.ErrParseJson(e) -> ErrParseJson(e)
              sansio.ErrServer(e) -> ErrServer(e)
              sansio.ErrOperationoutcome(e) -> ErrOperationoutcome(e)
            }),
          )
      }
  }
}

/// write out search string manually, in case typed search params don't work
pub fn search_any(
  search_string: String,
  resource_type: resource.ResourceType,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  sansio.any_search_request(search_string, resource_type, client)
  |> send_request_and_parse_resource(resource.bundle_decoder(), client)
}

/// get all resources in paginated bundle,
/// then stick them all in one bundle and pretend not paginated
///
/// fhirclient_httpc.search_any("name=e&_count=25", "Patient", client) |> fhirclient_httpc.all_pages(client)
pub fn all_pages(
  first_bundle: Result(resource.Bundle, Err),
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  case all_pages_loop(first_bundle, [], client) {
    Error(err) -> Error(err)
    Ok(#(last_bundle, bundles)) -> {
      let entries =
        list.fold(from: [], over: bundles, with: fn(acc, bundle) {
          list.append(bundle.entry, acc)
        })
      Ok(resource.Bundle(..last_bundle, entry: entries, link: []))
    }
  }
}

/// searchs each bundle and returns list
/// also returns last bundle individually
/// because all_pages smushes everything in there
fn all_pages_loop(
  current_bundle: Result(resource.Bundle, Err),
  acc_bundles: List(resource.Bundle),
  client: FhirClient,
) -> Result(#(resource.Bundle, List(resource.Bundle)), Err) {
  case current_bundle {
    Error(err) -> Error(err)
    Ok(current_bundle) -> {
      let acc_bundles = [current_bundle, ..acc_bundles]
      case sansio.bundle_next_page_request(current_bundle, client) {
        // Error(_) -> reached last page
        Error(_) -> Ok(#(current_bundle, acc_bundles))
        Ok(http_request) -> {
          let next =
            send_request_and_parse_resource(
              http_request,
              resource.bundle_decoder(),
              client,
            )
          all_pages_loop(next, acc_bundles, client)
        }
      }
    }
  }
}

pub fn all_pages_forgiving(
  first_bundle: Result(resource.BundleForgiving, Err),
  client: FhirClient,
) -> Result(resource.BundleForgiving, Err) {
  case all_pages_loop_forgiving(first_bundle, [], client) {
    Error(err) -> Error(err)
    Ok(#(last_bundle, bundles)) -> {
      let entries =
        list.fold(from: [], over: bundles, with: fn(acc, bundle) {
          list.append(bundle.entry, acc)
        })
      Ok(resource.BundleForgiving(..last_bundle, entry: entries, link: []))
    }
  }
}

// arguably very duplicated, maybe should be combined somehow
fn all_pages_loop_forgiving(
  current_bundle: Result(resource.BundleForgiving, Err),
  acc_bundles: List(resource.BundleForgiving),
  client: FhirClient,
) -> Result(#(resource.BundleForgiving, List(resource.BundleForgiving)), Err) {
  case current_bundle {
    Error(err) -> Error(err)
    Ok(current_bundle) -> {
      let acc_bundles = [current_bundle, ..acc_bundles]
      case sansio.bundle_next_page_request_forgiving(current_bundle, client) {
        // Error(_) -> reached last page
        Error(_) -> Ok(#(current_bundle, acc_bundles))
        Ok(http_request) -> {
          let next =
            send_request_and_parse_resource(
              http_request,
              resource.bundle_decoder_forgiving(),
              client,
            )
          all_pages_loop_forgiving(next, acc_bundles, client)
        }
      }
    }
  }
}

/// instead of failing whole decoder on bundle entry with invalid resource,
/// return valid resources alongside list of errors
pub fn search_any_forgiving(
  search_string: String,
  resource_type: resource.ResourceType,
  client: FhirClient,
) -> Result(resource.BundleForgiving, Err) {
  sansio.any_search_request(search_string, resource_type, client)
  |> send_request_and_parse_resource(
    resource.bundle_decoder_forgiving(),
    client,
  )
}

/// run any operation string on any resource type, optionally using Parameters
pub fn operation_any(
  params params: Option(resource.Parameters),
  operation_name operation_name: String,
  resource_type resource_type: resource.ResourceType,
  resource_id resource_id: Option(String),
  resource_decoder resource_decoder: Decoder(resource),
  client client: FhirClient,
) -> Result(resource, Err) {
  let http_request =
    sansio.any_operation_request(
      resource_type,
      resource_id,
      operation_name,
      params,
      client,
    )
  send_request_and_parse_resource(http_request, resource_decoder, client)
}

pub fn batch(
  http_requests: List(Request(Option(Json))),
  bundle_type: sansio.PostBundleType,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  let http_request = sansio.batch_request(http_requests, bundle_type, client)
  send_request_and_parse_resource(
    http_request,
    resource.bundle_decoder(),
    client,
  )
}

fn send_request_and_parse_resource(
  http_request: Request(Option(Json)),
  resource_decoder: Decoder(r),
  client: sansio.FhirClient,
) -> Result(r, Err) {
  case client.print_sent_requests {
    sansio.LoggingOn -> http_request |> sansio.request_to_string |> io.println
    sansio.LoggingOff -> Nil
  }
  let http_request =
    request.set_body(http_request, case http_request.body {
      None -> ""
      Some(body) -> json.to_string(body)
    })
  let http_response = httpc.send(http_request)
  case client.print_received_responses {
    sansio.LoggingOn ->
      case http_response {
        Ok(http_response) -> http_response |> sansio.response_to_string
        Error(err) -> err |> http_err_to_string
      }
      |> io.println
    sansio.LoggingOff -> Nil
  }
  case http_response {
    Error(err) -> Error(ErrHttpc(err))
    Ok(http_response) ->
      case sansio.any_response(http_response, resource_decoder) {
        Ok(resource) -> Ok(resource)
        Error(err) ->
          Error(
            ErrSansio(case err {
              sansio.ErrParseJson(e) -> ErrParseJson(e)
              sansio.ErrServer(e) -> ErrServer(e)
              sansio.ErrOperationoutcome(e) -> ErrOperationoutcome(e)
            }),
          )
      }
  }
}

fn http_err_to_string(err: httpc.HttpError) -> String {
  case err {
    httpc.InvalidUtf8Response -> "non-UTF-8 data in response"
    httpc.FailedToConnect(ip4:, ip6:) ->
      "could not connect to host: ip4 "
      <> connect_err_to_string(ip4)
      <> ", ip6 "
      <> connect_err_to_string(ip6)
    httpc.ResponseTimeout -> "timed out waiting for response"
  }
}

fn connect_err_to_string(err: httpc.ConnectError) -> String {
  case err {
    httpc.Posix(code:) -> "posix code " <> code
    httpc.TlsAlert(code:, detail:) ->
      "TLS alert code " <> code <> " and detail " <> detail
  }
}

pub fn bundle_create(
  resource: resource.Bundle,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  any_create(
    resource.bundle_to_json(resource),
    resource.ResourceTypeBundle,
    resource.bundle_decoder(),
    client,
  )
}

pub fn bundle_read(
  id: String,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  any_read(id, client, resource.ResourceTypeBundle, resource.bundle_decoder())
}

pub fn operationoutcome_create(
  resource: resource.Operationoutcome,
  client: FhirClient,
) -> Result(resource.Operationoutcome, Err) {
  any_create(
    resource.operationoutcome_to_json(resource),
    resource.ResourceTypeOperationoutcome,
    resource.operationoutcome_decoder(),
    client,
  )
}

pub fn operationoutcome_read(
  id: String,
  client: FhirClient,
) -> Result(resource.Operationoutcome, Err) {
  any_read(
    id,
    client,
    resource.ResourceTypeOperationoutcome,
    resource.operationoutcome_decoder(),
  )
}

pub fn potatoserver_practitioner_create(
  resource: resource.PotatoserverPractitioner,
  client: FhirClient,
) -> Result(resource.PotatoserverPractitioner, Err) {
  any_create(
    resource.potatoserver_practitioner_to_json(resource),
    resource.ResourceTypePractitioner,
    resource.potatoserver_practitioner_decoder(),
    client,
  )
}

pub fn potatoserver_practitioner_read(
  id: String,
  client: FhirClient,
) -> Result(resource.PotatoserverPractitioner, Err) {
  any_read(
    id,
    client,
    resource.ResourceTypePractitioner,
    resource.potatoserver_practitioner_decoder(),
  )
}

pub fn potatoserver_practitioner_update(
  resource: resource.PotatoserverPractitioner,
  client: FhirClient,
) -> Result(resource.PotatoserverPractitioner, Err) {
  let id = resource.id
  any_update(
    id,
    resource.potatoserver_practitioner_to_json(resource),
    resource.ResourceTypePractitioner,
    resource.potatoserver_practitioner_decoder(),
    client,
  )
}

pub fn potatoserver_practitioner_delete(
  resource: resource.PotatoserverPractitioner,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHttp, Err) {
  let id = resource.id
  case id {
    Some(id) -> any_delete(id, resource.ResourceTypePractitioner, client)
    None -> Error(ErrSansio(ErrNoId))
  }
}

pub fn bundle_search_bundled(
  search_param: search_param.Bundle,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  search_param.to_string([
    #("identifier", search_param.identifier),
    #("composition", search_param.composition),
    #("type", search_param.type_),
    #("message", search_param.message),
    #("timestamp", search_param.timestamp),
  ])
  |> search_any(resource.ResourceTypeBundle, client)
}

pub fn bundle_search(
  search_param: search_param.Bundle,
  client: FhirClient,
) -> Result(List(resource.Bundle), Err) {
  case bundle_search_bundled(search_param, client) {
    Ok(bundle) -> Ok({ bundle |> sansio.bundle_to_groupedresources }.bundle)
    Error(error) -> Error(error)
  }
}

pub fn operationoutcome_search_bundled(
  _search_param: search_param.Operationoutcome,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  search_param.to_string([])
  |> search_any(resource.ResourceTypeOperationoutcome, client)
}

pub fn operationoutcome_search(
  search_param: search_param.Operationoutcome,
  client: FhirClient,
) -> Result(List(resource.Operationoutcome), Err) {
  case operationoutcome_search_bundled(search_param, client) {
    Ok(bundle) ->
      Ok({ bundle |> sansio.bundle_to_groupedresources }.operationoutcome)
    Error(error) -> Error(error)
  }
}

pub fn potatoserver_practitioner_search_bundled(
  search_param: search_param.PotatoserverPractitioner,
  client: FhirClient,
) -> Result(resource.Bundle, Err) {
  search_param.to_string([
    #("identifier", search_param.identifier),
    #("given", search_param.given),
    #("address", search_param.address),
    #("address-state", search_param.address_state),
    #("gender", search_param.gender),
    #("active", search_param.active),
    #("address-postalcode", search_param.address_postalcode),
    #("address-country", search_param.address_country),
    #("phonetic", search_param.phonetic),
    #("phone", search_param.phone),
    #("name", search_param.name),
    #("address-use", search_param.address_use),
    #("telecom", search_param.telecom),
    #("family", search_param.family),
    #("address-city", search_param.address_city),
    #("communication", search_param.communication),
    #("email", search_param.email),
  ])
  |> search_any(resource.ResourceTypePractitioner, client)
}

pub fn potatoserver_practitioner_search(
  search_param: search_param.PotatoserverPractitioner,
  client: FhirClient,
) -> Result(List(resource.PotatoserverPractitioner), Err) {
  case potatoserver_practitioner_search_bundled(search_param, client) {
    Ok(bundle) ->
      Ok(
        { bundle |> sansio.bundle_to_groupedresources }.potatoserver_practitioner,
      )
    Error(error) -> Error(error)
  }
}
