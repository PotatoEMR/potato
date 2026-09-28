////[https://hl7.org/fhir/hl7_fhir_us_core_7_0_0](https://hl7.org/fhir/hl7_fhir_us_core_7_0_0) hl7_fhir_us_core_7_0_0 client using httpc

import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio.{type FhirClient}
import fhir/hl7_fhir_us_core_7_0_0/search_params
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
  ErrOperationoutcome(resources.Operationoutcome)
  ///could not make an update or delete request because resource has no id
  ErrNoId
}

pub fn err_to_string(err: Err) -> String {
  case err {
    ErrSansio(err:) ->
      case err {
        ErrParseJson(err) -> sansio.err_resp_to_string(sansio.ErrParseJson(err))
        ErrServer(err) -> sansio.err_resp_to_string(sansio.ErrServer(err))
        ErrOperationoutcome(err) ->
          sansio.err_resp_to_string(sansio.ErrOperationoutcome(err))
        ErrNoId -> sansio.err_req_to_string
      }
    ErrHttpc(err:) -> http_err_to_string(err)
  }
}

fn any_create(
  resource: Json,
  res_type: resources.ResourceType,
  resource_dec: Decoder(r),
  client: FhirClient,
) -> Result(r, Err) {
  let req = sansio.any_create_req(resource, res_type, client)
  sendreq_parseresource(req, resource_dec, client)
}

fn any_read(
  id: String,
  client: FhirClient,
  res_type: resources.ResourceType,
  resource_dec: Decoder(a),
) -> Result(a, Err) {
  let req = sansio.any_read_req(id, res_type, client)
  sendreq_parseresource(req, resource_dec, client)
}

fn any_update(
  id: Option(String),
  resource: Json,
  res_type: resources.ResourceType,
  res_dec: Decoder(r),
  client: FhirClient,
) -> Result(r, Err) {
  let req = sansio.any_update_req(id, resource, res_type, client)
  case req {
    Ok(req) -> sendreq_parseresource(req, res_dec, client)
    Error(_) -> Error(ErrSansio(ErrNoId))
    //can have error preparing update request if resource has no id
  }
}

pub fn any_delete(
  id: String,
  res_type: resources.ResourceType,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHTTP, Err) {
  let req = sansio.any_delete_req(id, res_type, client)
  case httpc.send(req |> request.set_body("")) {
    Error(err) -> Error(ErrHttpc(err))
    Ok(resp) ->
      case sansio.delete_response(resp) {
        Ok(oo_or_http) -> Ok(oo_or_http)
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
  res_type: resources.ResourceType,
  client: FhirClient,
) -> Result(resources.Bundle, Err) {
  sansio.any_search_req(search_string, res_type, client)
  |> sendreq_parseresource(resources.bundle_decoder(), client)
}

/// get all resources in paginated bundle,
/// then stick them all in one bundle and pretend not paginated
///
/// fhirclient_httpc.search_any("name=e&_count=25", "Patient", client) |> fhirclient_httpc.all_pages(client)
pub fn all_pages(
  first_bundle: Result(resources.Bundle, Err),
  client: FhirClient,
) -> Result(resources.Bundle, Err) {
  case all_pages_loop(first_bundle, [], client) {
    Error(err) -> Error(err)
    Ok(#(last_bundle, bundles)) -> {
      let entries =
        list.fold(from: [], over: bundles, with: fn(acc, bundle) {
          list.append(bundle.entry, acc)
        })
      Ok(resources.Bundle(..last_bundle, entry: entries, link: []))
    }
  }
}

/// searchs each bundle and returns list
/// also returns last bundle individually
/// because all_pages smushes everything in there
fn all_pages_loop(
  curr_bundle: Result(resources.Bundle, Err),
  acc_bundles: List(resources.Bundle),
  client: FhirClient,
) -> Result(#(resources.Bundle, List(resources.Bundle)), Err) {
  case curr_bundle {
    Error(err) -> Error(err)
    Ok(curr_bundle) -> {
      let acc_bundles = [curr_bundle, ..acc_bundles]
      case sansio.bundle_next_page_req(curr_bundle, client) {
        // Error(_) -> reached last page
        Error(_) -> Ok(#(curr_bundle, acc_bundles))
        Ok(req) -> {
          let next =
            sendreq_parseresource(req, resources.bundle_decoder(), client)
          all_pages_loop(next, acc_bundles, client)
        }
      }
    }
  }
}

pub fn all_pages_forgiving(
  first_bundle: Result(resources.BundleForgiving, Err),
  client: FhirClient,
) -> Result(resources.BundleForgiving, Err) {
  case all_pages_loop_forgiving(first_bundle, [], client) {
    Error(err) -> Error(err)
    Ok(#(last_bundle, bundles)) -> {
      let entries =
        list.fold(from: [], over: bundles, with: fn(acc, bundle) {
          list.append(bundle.entry, acc)
        })
      Ok(resources.BundleForgiving(..last_bundle, entry: entries, link: []))
    }
  }
}

// arguably very duplicated, maybe should be combined somehow
fn all_pages_loop_forgiving(
  curr_bundle: Result(resources.BundleForgiving, Err),
  acc_bundles: List(resources.BundleForgiving),
  client: FhirClient,
) -> Result(#(resources.BundleForgiving, List(resources.BundleForgiving)), Err) {
  case curr_bundle {
    Error(err) -> Error(err)
    Ok(curr_bundle) -> {
      let acc_bundles = [curr_bundle, ..acc_bundles]
      case sansio.bundle_next_page_req_forgiving(curr_bundle, client) {
        // Error(_) -> reached last page
        Error(_) -> Ok(#(curr_bundle, acc_bundles))
        Ok(req) -> {
          let next =
            sendreq_parseresource(
              req,
              resources.bundle_decoder_forgiving(),
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
  res_type: resources.ResourceType,
  client: FhirClient,
) -> Result(resources.BundleForgiving, Err) {
  sansio.any_search_req(search_string, res_type, client)
  |> sendreq_parseresource(resources.bundle_decoder_forgiving(), client)
}

/// run any operation string on any resource type, optionally using Parameters
pub fn operation_any(
  params params: Option(resources.Parameters),
  operation_name operation_name: String,
  res_type res_type: resources.ResourceType,
  res_id res_id: Option(String),
  res_decoder res_decoder: Decoder(res),
  client client: FhirClient,
) -> Result(res, Err) {
  let req =
    sansio.any_operation_req(res_type, res_id, operation_name, params, client)
  sendreq_parseresource(req, res_decoder, client)
}

pub fn batch(
  reqs: List(Request(Option(Json))),
  bundle_type: sansio.PostBundleType,
  client: FhirClient,
) -> Result(resources.Bundle, Err) {
  let req = sansio.batch_req(reqs, bundle_type, client)
  sendreq_parseresource(req, resources.bundle_decoder(), client)
}

fn sendreq_parseresource(
  req: Request(Option(Json)),
  res_dec: Decoder(r),
  client: sansio.FhirClient,
) -> Result(r, Err) {
  case client.print_sent_requests {
    sansio.LoggingOn -> req |> sansio.req_to_string |> io.println
    sansio.LoggingOff -> Nil
  }
  let req =
    request.set_body(req, case req.body {
      None -> ""
      Some(body) -> json.to_string(body)
    })
  let resp = httpc.send(req)
  case client.print_received_responses {
    sansio.LoggingOn ->
      case resp {
        Ok(resp) -> resp |> sansio.resp_to_string
        Error(err) -> err |> http_err_to_string
      }
      |> io.println
    sansio.LoggingOff -> Nil
  }
  case resp {
    Error(err) -> Error(ErrHttpc(err))
    Ok(resp) ->
      case sansio.any_response(resp, res_dec) {
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

fn http_err_to_string(err: httpc.HttpError) {
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
  resource: resources.Bundle,
  client: FhirClient,
) -> Result(resources.Bundle, Err) {
  any_create(
    resources.bundle_to_json(resource),
    resources.RtBundle,
    resources.bundle_decoder(),
    client,
  )
}

pub fn bundle_read(
  id: String,
  client: FhirClient,
) -> Result(resources.Bundle, Err) {
  any_read(id, client, resources.RtBundle, resources.bundle_decoder())
}

pub fn bundle_update(
  resource: resources.Bundle,
  client: FhirClient,
) -> Result(resources.Bundle, Err) {
  any_update(
    resource.id,
    resources.bundle_to_json(resource),
    resources.RtBundle,
    resources.bundle_decoder(),
    client,
  )
}

pub fn bundle_delete(
  resource: resources.Bundle,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHTTP, Err) {
  case resource.id {
    Some(id) -> any_delete(id, resources.RtBundle, client)
    None -> Error(ErrSansio(ErrNoId))
  }
}

pub fn operationoutcome_create(
  resource: resources.Operationoutcome,
  client: FhirClient,
) -> Result(resources.Operationoutcome, Err) {
  any_create(
    resources.operationoutcome_to_json(resource),
    resources.RtOperationoutcome,
    resources.operationoutcome_decoder(),
    client,
  )
}

pub fn operationoutcome_read(
  id: String,
  client: FhirClient,
) -> Result(resources.Operationoutcome, Err) {
  any_read(
    id,
    client,
    resources.RtOperationoutcome,
    resources.operationoutcome_decoder(),
  )
}

pub fn operationoutcome_update(
  resource: resources.Operationoutcome,
  client: FhirClient,
) -> Result(resources.Operationoutcome, Err) {
  any_update(
    resource.id,
    resources.operationoutcome_to_json(resource),
    resources.RtOperationoutcome,
    resources.operationoutcome_decoder(),
    client,
  )
}

pub fn operationoutcome_delete(
  resource: resources.Operationoutcome,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHTTP, Err) {
  case resource.id {
    Some(id) -> any_delete(id, resources.RtOperationoutcome, client)
    None -> Error(ErrSansio(ErrNoId))
  }
}

pub fn us_core_patient_create(
  resource: resources.UsCorePatient,
  client: FhirClient,
) -> Result(resources.UsCorePatient, Err) {
  any_create(
    resources.us_core_patient_to_json(resource),
    resources.RtPatient,
    resources.us_core_patient_decoder(),
    client,
  )
}

pub fn us_core_patient_read(
  id: String,
  client: FhirClient,
) -> Result(resources.UsCorePatient, Err) {
  any_read(id, client, resources.RtPatient, resources.us_core_patient_decoder())
}

pub fn us_core_patient_update(
  resource: resources.UsCorePatient,
  client: FhirClient,
) -> Result(resources.UsCorePatient, Err) {
  any_update(
    resource.id,
    resources.us_core_patient_to_json(resource),
    resources.RtPatient,
    resources.us_core_patient_decoder(),
    client,
  )
}

pub fn us_core_patient_delete(
  resource: resources.UsCorePatient,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHTTP, Err) {
  case resource.id {
    Some(id) -> any_delete(id, resources.RtPatient, client)
    None -> Error(ErrSansio(ErrNoId))
  }
}

pub fn us_core_practitioner_create(
  resource: resources.UsCorePractitioner,
  client: FhirClient,
) -> Result(resources.UsCorePractitioner, Err) {
  any_create(
    resources.us_core_practitioner_to_json(resource),
    resources.RtPractitioner,
    resources.us_core_practitioner_decoder(),
    client,
  )
}

pub fn us_core_practitioner_read(
  id: String,
  client: FhirClient,
) -> Result(resources.UsCorePractitioner, Err) {
  any_read(
    id,
    client,
    resources.RtPractitioner,
    resources.us_core_practitioner_decoder(),
  )
}

pub fn us_core_practitioner_update(
  resource: resources.UsCorePractitioner,
  client: FhirClient,
) -> Result(resources.UsCorePractitioner, Err) {
  any_update(
    resource.id,
    resources.us_core_practitioner_to_json(resource),
    resources.RtPractitioner,
    resources.us_core_practitioner_decoder(),
    client,
  )
}

pub fn us_core_practitioner_delete(
  resource: resources.UsCorePractitioner,
  client: FhirClient,
) -> Result(sansio.OperationoutcomeOrHTTP, Err) {
  case resource.id {
    Some(id) -> any_delete(id, resources.RtPractitioner, client)
    None -> Error(ErrSansio(ErrNoId))
  }
}

pub fn bundle_search_bundled(sp: search_params.Bundle, client: FhirClient) {
  search_params.to_string([
    #("identifier", sp.identifier),
    #("composition", sp.composition),
    #("type", sp.type_),
    #("message", sp.message),
    #("timestamp", sp.timestamp),
  ])
  |> search_any(resources.RtBundle, client)
}

pub fn bundle_search(
  sp: search_params.Bundle,
  client: FhirClient,
) -> Result(List(resources.Bundle), Err) {
  case bundle_search_bundled(sp, client) {
    Ok(bundle) -> Ok({ bundle |> sansio.bundle_to_groupedresources }.bundle)
    Error(error) -> Error(error)
  }
}

pub fn operationoutcome_search_bundled(
  _sp: search_params.Operationoutcome,
  client: FhirClient,
) {
  search_params.to_string([])
  |> search_any(resources.RtOperationoutcome, client)
}

pub fn operationoutcome_search(
  sp: search_params.Operationoutcome,
  client: FhirClient,
) -> Result(List(resources.Operationoutcome), Err) {
  case operationoutcome_search_bundled(sp, client) {
    Ok(bundle) ->
      Ok({ bundle |> sansio.bundle_to_groupedresources }.operationoutcome)
    Error(error) -> Error(error)
  }
}

pub fn us_core_patient_search_bundled(
  sp: search_params.UsCorePatient,
  client: FhirClient,
) {
  search_params.to_string([
    #("_id", sp.id),
    #("birthdate", sp.birthdate),
    #("death-date", sp.death_date),
    #("family", sp.family),
    #("gender", sp.gender),
    #("given", sp.given),
    #("identifier", sp.identifier),
    #("name", sp.name),
  ])
  |> search_any(resources.RtPatient, client)
}

pub fn us_core_patient_search(
  sp: search_params.UsCorePatient,
  client: FhirClient,
) -> Result(List(resources.UsCorePatient), Err) {
  case us_core_patient_search_bundled(sp, client) {
    Ok(bundle) ->
      Ok({ bundle |> sansio.bundle_to_groupedresources }.us_core_patient)
    Error(error) -> Error(error)
  }
}

pub fn us_core_practitioner_search_bundled(
  sp: search_params.UsCorePractitioner,
  client: FhirClient,
) {
  search_params.to_string([
    #("_id", sp.id),
    #("identifier", sp.identifier),
    #("name", sp.name),
  ])
  |> search_any(resources.RtPractitioner, client)
}

pub fn us_core_practitioner_search(
  sp: search_params.UsCorePractitioner,
  client: FhirClient,
) -> Result(List(resources.UsCorePractitioner), Err) {
  case us_core_practitioner_search_bundled(sp, client) {
    Ok(bundle) ->
      Ok({ bundle |> sansio.bundle_to_groupedresources }.us_core_practitioner)
    Error(error) -> Error(error)
  }
}
