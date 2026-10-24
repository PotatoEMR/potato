////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) r4 client using rsvp

import fhir/potato_client_1_0_0/resources
import fhir/potato_client_1_0_0/sansio
import fhir/potato_client_1_0_0/search_params
import gleam/dynamic/decode.{type Decoder}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import lustre/effect.{type Effect}
import rsvp

/// FHIR client for sending http requests to server such as
/// `let pat = resources.patient_read("123", client)`
///
/// create client from server base url with fhirclient_new(baseurl)`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("r4.smarthealthit.org/")`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("https://r4.smarthealthit.org/")`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("https://hapi.fhir.org/baseR4")`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("127.0.0.1:8000")`
/// 
/// rsvp client wraps sansio client
pub type FhirClient {
  FhirClient(client: sansio.FhirClient)
}

/// creates a new client from server base url
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("r4.smarthealthit.org/")`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("https://r4.smarthealthit.org/")`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("https://hapi.fhir.org/baseR4")`
///
/// `let assert Ok(client) = client_rsvp.fhirclient_new("127.0.0.1:8000")`
pub fn fhirclient_new(
  server_base_url in_url: String,
) -> Result(FhirClient, sansio.ErrBaseUrl) {
  case sansio.fhirclient_new(in_url) {
    Ok(client) -> Ok(FhirClient(client:))
    Error(err) -> Error(err)
  }
}

pub type Err {
  ErrRsvp(err: rsvp.Error(String))
  ErrSansio(err: sansio.ErrResp)
}

pub fn err_to_string(err: Err) -> String {
  case err {
    ErrRsvp(err:) -> rsvp_err_to_string(err)
    ErrSansio(err:) -> sansio.err_resp_to_string(err)
  }
}

/// When using rsvp, if you attempt update or delete a resource with no id,
/// we do not even send the request or give you an effect to use.
/// Instead of an effect you get just Error(ErrNoId)
pub type ErrNoId {
  ErrNoId
}

fn any_create(
  resource: Json,
  res_type: resources.ResourceType,
  resource_dec: Decoder(r),
  client: FhirClient,
  handle_response: fn(Result(r, Err)) -> msg,
) -> Effect(msg) {
  let req = sansio.any_create_req(resource, res_type, client.client)
  sendreq_handleresponse(req, resource_dec, handle_response, client)
}

fn any_read(
  id: String,
  res_type: resources.ResourceType,
  resource_dec: Decoder(r),
  client: FhirClient,
  handle_response: fn(Result(r, Err)) -> msg,
) -> Effect(msg) {
  let req = sansio.any_read_req(id, res_type, client.client)
  sendreq_handleresponse(req, resource_dec, handle_response, client)
}

fn any_update(
  id: Option(String),
  resource: Json,
  res_type: resources.ResourceType,
  resource_dec: Decoder(r),
  client: FhirClient,
  handle_response: fn(Result(r, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let req = sansio.any_update_req(id, resource, res_type, client.client)
  case req {
    Ok(req) ->
      Ok(sendreq_handleresponse(req, resource_dec, handle_response, client))
    Error(_) -> Error(ErrNoId)
  }
}

pub fn any_delete(
  id: String,
  res_type: resources.ResourceType,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Effect(msg) {
  let req = sansio.any_delete_req(id, res_type, client.client)
  case client.client.print_sent_requests {
    sansio.LoggingOn -> req |> sansio.req_to_string |> io.println
    sansio.LoggingOff -> Nil
  }
  let handle_read = fn(
    response_result: Result(Response(String), rsvp.Error(String)),
  ) {
    case client.client.print_received_responses {
      sansio.LoggingOn ->
        case response_result {
          Ok(resp) -> resp |> sansio.resp_to_string
          Error(err) -> err |> rsvp_err_to_string
        }
        |> io.println
      sansio.LoggingOff -> Nil
    }
    case response_result {
      Error(err) -> Error(ErrRsvp(err)) |> handle_response
      Ok(response) ->
        case sansio.delete_response(response) {
          Ok(oo_or_http) -> Ok(oo_or_http) |> handle_response
          Error(err) -> Error(ErrSansio(err)) |> handle_response
        }
    }
  }
  let handler = rsvp.expect_any_response(handle_read)
  req
  |> request.set_body(case req.body {
    None -> ""
    Some(body) -> json.to_string(body)
  })
  |> rsvp.send(handler)
}

/// write out search string manually, in case typed search params don't work
pub fn search_any(
  search_string: String,
  res_type: resources.ResourceType,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  let req = sansio.any_search_req(search_string, res_type, client.client)
  sendreq_handleresponse(
    req,
    resources.bundle_decoder(),
    handle_response,
    client,
  )
}

/// instead of failing whole decoder on bundle entry with invalid resource,
/// return valid resources alongside list of errors
pub fn search_any_forgiving(
  search_string: String,
  res_type: resources.ResourceType,
  client: FhirClient,
  handle_response: fn(Result(resources.BundleForgiving, Err)) -> msg,
) -> Effect(msg) {
  let req = sansio.any_search_req(search_string, res_type, client.client)
  sendreq_handleresponse(
    req,
    resources.bundle_decoder_forgiving(),
    handle_response,
    client,
  )
}

// run any operation string on any resource string, optionally using Parameters
pub fn operation_any(
  params params: Option(resources.Parameters),
  operation_name operation_name: String,
  res_type res_type: resources.ResourceType,
  res_id res_id: Option(String),
  res_decoder res_decoder: Decoder(res),
  client client: FhirClient,
  handle_response handle_response: fn(Result(res, Err)) -> msg,
) -> Effect(msg) {
  let req =
    sansio.any_operation_req(
      res_type,
      res_id,
      operation_name,
      params,
      client.client,
    )
  sendreq_handleresponse(req, res_decoder, handle_response, client)
}

pub fn batch(
  reqs: List(Request(Option(Json))),
  bundle_type: sansio.PostBundleType,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  let req = sansio.batch_req(reqs, bundle_type, client.client)
  sendreq_handleresponse(
    req,
    resources.bundle_decoder(),
    handle_response,
    client,
  )
}

fn sendreq_handleresponse(
  req: Request(Option(Json)),
  res_dec: Decoder(resource),
  handle_response: fn(Result(resource, Err)) -> msg,
  client: FhirClient,
) -> Effect(msg) {
  case client.client.print_sent_requests {
    sansio.LoggingOn -> req |> sansio.req_to_string |> io.println
    sansio.LoggingOff -> Nil
  }
  let handle_read = fn(
    response_result: Result(Response(String), rsvp.Error(String)),
  ) {
    case client.client.print_received_responses {
      sansio.LoggingOn ->
        case response_result {
          Ok(resp) -> resp |> sansio.resp_to_string
          Error(err) -> err |> rsvp_err_to_string
        }
        |> io.println
      sansio.LoggingOff -> Nil
    }
    case response_result {
      Error(err) -> Error(ErrRsvp(err)) |> handle_response
      Ok(response) -> {
        case sansio.any_response(response, res_dec) {
          Ok(res) -> Ok(res) |> handle_response
          Error(err) -> Error(ErrSansio(err)) |> handle_response
        }
      }
    }
  }
  let handler = rsvp.expect_any_response(handle_read)
  req
  |> request.set_body(case req.body {
    None -> ""
    Some(body) -> json.to_string(body)
  })
  |> rsvp.send(handler)
}

fn rsvp_err_to_string(err: rsvp.Error(String)) -> String {
  case err {
    rsvp.BadBody -> "invalid http response body"
    rsvp.BadUrl(url) -> "invalid url: " <> url
    rsvp.HttpError(resp) -> "resp not 2xx: " <> sansio.resp_to_string(resp)
    rsvp.JsonError(err) ->
      "err decoding json: "
      <> case err {
        json.UnexpectedEndOfInput -> "unexpected end of input"
        json.UnexpectedByte(err) -> "unexpected byte: " <> err
        json.UnexpectedSequence(err) -> "unexpected sequence " <> err
        json.UnableToDecode(errors) ->
          "unable to decode: "
          <> list.map(errors, fn(error) {
            "expected "
            <> error.expected
            <> " but found "
            <> error.found
            <> " at "
            <> string.join(error.path, "/")
          })
          |> string.join("\n")
      }
    rsvp.NetworkError ->
      "network error, http request could not connect to server"
    rsvp.UnhandledResponse(resp) ->
      "rsvp handler does not know how to handle response: "
      <> sansio.resp_to_string(resp)
  }
}

pub fn bundle_create(
  resource: resources.Bundle,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.bundle_to_json(resource),
    resources.RtBundle,
    resources.bundle_decoder(),
    client,
    handle_response,
  )
}

pub fn bundle_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtBundle,
    resources.bundle_decoder(),
    client,
    handle_response,
  )
}

pub fn operationoutcome_create(
  resource: resources.Operationoutcome,
  client: FhirClient,
  handle_response: fn(Result(resources.Operationoutcome, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.operationoutcome_to_json(resource),
    resources.RtOperationoutcome,
    resources.operationoutcome_decoder(),
    client,
    handle_response,
  )
}

pub fn operationoutcome_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Operationoutcome, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtOperationoutcome,
    resources.operationoutcome_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoallergyintolerance_create(
  resource: resources.Potatoallergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoallergyintolerance, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatoallergyintolerance_to_json(resource),
    resources.RtAllergyintolerance,
    resources.potatoallergyintolerance_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoallergyintolerance_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoallergyintolerance, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtAllergyintolerance,
    resources.potatoallergyintolerance_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoallergyintolerance_update(
  resource: resources.Potatoallergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoallergyintolerance, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatoallergyintolerance_to_json(resource),
    resources.RtAllergyintolerance,
    resources.potatoallergyintolerance_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoallergyintolerance_delete(
  resource: resources.Potatoallergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtAllergyintolerance, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatoappointment_create(
  resource: resources.Potatoappointment,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoappointment, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatoappointment_to_json(resource),
    resources.RtAppointment,
    resources.potatoappointment_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoappointment_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoappointment, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtAppointment,
    resources.potatoappointment_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoappointment_update(
  resource: resources.Potatoappointment,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoappointment, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatoappointment_to_json(resource),
    resources.RtAppointment,
    resources.potatoappointment_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoappointment_delete(
  resource: resources.Potatoappointment,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtAppointment, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatocondition_create(
  resource: resources.Potatocondition,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatocondition, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatocondition_to_json(resource),
    resources.RtCondition,
    resources.potatocondition_decoder(),
    client,
    handle_response,
  )
}

pub fn potatocondition_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatocondition, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtCondition,
    resources.potatocondition_decoder(),
    client,
    handle_response,
  )
}

pub fn potatocondition_update(
  resource: resources.Potatocondition,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatocondition, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatocondition_to_json(resource),
    resources.RtCondition,
    resources.potatocondition_decoder(),
    client,
    handle_response,
  )
}

pub fn potatocondition_delete(
  resource: resources.Potatocondition,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtCondition, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatodocumentreference_create(
  resource: resources.Potatodocumentreference,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatodocumentreference, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatodocumentreference_to_json(resource),
    resources.RtDocumentreference,
    resources.potatodocumentreference_decoder(),
    client,
    handle_response,
  )
}

pub fn potatodocumentreference_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatodocumentreference, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtDocumentreference,
    resources.potatodocumentreference_decoder(),
    client,
    handle_response,
  )
}

pub fn potatodocumentreference_update(
  resource: resources.Potatodocumentreference,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatodocumentreference, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatodocumentreference_to_json(resource),
    resources.RtDocumentreference,
    resources.potatodocumentreference_decoder(),
    client,
    handle_response,
  )
}

pub fn potatodocumentreference_delete(
  resource: resources.Potatodocumentreference,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtDocumentreference, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatoencounter_create(
  resource: resources.Potatoencounter,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoencounter, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatoencounter_to_json(resource),
    resources.RtEncounter,
    resources.potatoencounter_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoencounter_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoencounter, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtEncounter,
    resources.potatoencounter_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoencounter_update(
  resource: resources.Potatoencounter,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoencounter, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatoencounter_to_json(resource),
    resources.RtEncounter,
    resources.potatoencounter_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoencounter_delete(
  resource: resources.Potatoencounter,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtEncounter, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatoimmunization_create(
  resource: resources.Potatoimmunization,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoimmunization, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatoimmunization_to_json(resource),
    resources.RtImmunization,
    resources.potatoimmunization_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoimmunization_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoimmunization, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtImmunization,
    resources.potatoimmunization_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoimmunization_update(
  resource: resources.Potatoimmunization,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatoimmunization, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatoimmunization_to_json(resource),
    resources.RtImmunization,
    resources.potatoimmunization_decoder(),
    client,
    handle_response,
  )
}

pub fn potatoimmunization_delete(
  resource: resources.Potatoimmunization,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtImmunization, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatomedicationrequest_create(
  resource: resources.Potatomedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatomedicationrequest, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatomedicationrequest_to_json(resource),
    resources.RtMedicationrequest,
    resources.potatomedicationrequest_decoder(),
    client,
    handle_response,
  )
}

pub fn potatomedicationrequest_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatomedicationrequest, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtMedicationrequest,
    resources.potatomedicationrequest_decoder(),
    client,
    handle_response,
  )
}

pub fn potatomedicationrequest_update(
  resource: resources.Potatomedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatomedicationrequest, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatomedicationrequest_to_json(resource),
    resources.RtMedicationrequest,
    resources.potatomedicationrequest_decoder(),
    client,
    handle_response,
  )
}

pub fn potatomedicationrequest_delete(
  resource: resources.Potatomedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resources.RtMedicationrequest, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potatomedicationstatement_create(
  resource: resources.Potatomedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatomedicationstatement, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatomedicationstatement_to_json(resource),
    resources.RtMedicationstatement,
    resources.potatomedicationstatement_decoder(),
    client,
    handle_response,
  )
}

pub fn potatomedicationstatement_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatomedicationstatement, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtMedicationstatement,
    resources.potatomedicationstatement_decoder(),
    client,
    handle_response,
  )
}

pub fn potatomedicationstatement_update(
  resource: resources.Potatomedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatomedicationstatement, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatomedicationstatement_to_json(resource),
    resources.RtMedicationstatement,
    resources.potatomedicationstatement_decoder(),
    client,
    handle_response,
  )
}

pub fn potatomedicationstatement_delete(
  resource: resources.Potatomedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resources.RtMedicationstatement,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potatopatient_create(
  resource: resources.Potatopatient,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatopatient, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resources.potatopatient_to_json(resource),
    resources.RtPatient,
    resources.potatopatient_decoder(),
    client,
    handle_response,
  )
}

pub fn potatopatient_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatopatient, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resources.RtPatient,
    resources.potatopatient_decoder(),
    client,
    handle_response,
  )
}

pub fn potatopatient_update(
  resource: resources.Potatopatient,
  client: FhirClient,
  handle_response: fn(Result(resources.Potatopatient, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resources.potatopatient_to_json(resource),
    resources.RtPatient,
    resources.potatopatient_decoder(),
    client,
    handle_response,
  )
}

pub fn potatopatient_delete(
  resource: resources.Potatopatient,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHTTP, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) -> Ok(any_delete(id, resources.RtPatient, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn bundle_search_bundled(
  sp: search_params.Bundle,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("identifier", sp.identifier),
    #("composition", sp.composition),
    #("type", sp.type_),
    #("message", sp.message),
    #("timestamp", sp.timestamp),
  ])
  |> search_any(resources.RtBundle, client, handle_response)
}

pub fn bundle_search(
  sp: search_params.Bundle,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Bundle), Err)) -> msg,
) -> Effect(msg) {
  bundle_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) -> Ok({ bundle |> sansio.bundle_to_groupedresources }.bundle)
      Error(error) -> Error(error)
    })
  })
}

pub fn operationoutcome_search_bundled(
  _sp: search_params.Operationoutcome,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([])
  |> search_any(resources.RtOperationoutcome, client, handle_response)
}

pub fn operationoutcome_search(
  sp: search_params.Operationoutcome,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Operationoutcome), Err)) -> msg,
) -> Effect(msg) {
  operationoutcome_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.operationoutcome)
      Error(error) -> Error(error)
    })
  })
}

pub fn potatoallergyintolerance_search_bundled(
  sp: search_params.Potatoallergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("severity", sp.severity),
    #("date", sp.date),
    #("identifier", sp.identifier),
    #("manifestation", sp.manifestation),
    #("recorder", sp.recorder),
    #("code", sp.code),
    #("verification-status", sp.verification_status),
    #("criticality", sp.criticality),
    #("clinical-status", sp.clinical_status),
    #("type", sp.type_),
    #("onset", sp.onset),
    #("route", sp.route),
    #("asserter", sp.asserter),
    #("patient", sp.patient),
    #("category", sp.category),
    #("last-date", sp.last_date),
  ])
  |> search_any(resources.RtAllergyintolerance, client, handle_response)
}

pub fn potatoallergyintolerance_search(
  sp: search_params.Potatoallergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatoallergyintolerance), Err)) ->
    msg,
) -> Effect(msg) {
  potatoallergyintolerance_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok(
          { bundle |> sansio.bundle_to_groupedresources }.potatoallergyintolerance,
        )
      Error(error) -> Error(error)
    })
  })
}

pub fn potatoappointment_search_bundled(
  sp: search_params.Potatoappointment,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("date", sp.date),
    #("identifier", sp.identifier),
    #("specialty", sp.specialty),
    #("service-category", sp.service_category),
    #("practitioner", sp.practitioner),
    #("part-status", sp.part_status),
    #("appointment-type", sp.appointment_type),
    #("service-type", sp.service_type),
    #("slot", sp.slot),
    #("reason-code", sp.reason_code),
    #("actor", sp.actor),
    #("based-on", sp.based_on),
    #("patient", sp.patient),
    #("reason-reference", sp.reason_reference),
    #("supporting-info", sp.supporting_info),
    #("location", sp.location),
    #("status", sp.status),
  ])
  |> search_any(resources.RtAppointment, client, handle_response)
}

pub fn potatoappointment_search(
  sp: search_params.Potatoappointment,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatoappointment), Err)) -> msg,
) -> Effect(msg) {
  potatoappointment_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potatoappointment)
      Error(error) -> Error(error)
    })
  })
}

pub fn potatocondition_search_bundled(
  sp: search_params.Potatocondition,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("severity", sp.severity),
    #("evidence-detail", sp.evidence_detail),
    #("identifier", sp.identifier),
    #("onset-info", sp.onset_info),
    #("recorded-date", sp.recorded_date),
    #("code", sp.code),
    #("evidence", sp.evidence),
    #("subject", sp.subject),
    #("verification-status", sp.verification_status),
    #("clinical-status", sp.clinical_status),
    #("encounter", sp.encounter),
    #("onset-date", sp.onset_date),
    #("abatement-date", sp.abatement_date),
    #("asserter", sp.asserter),
    #("stage", sp.stage),
    #("abatement-string", sp.abatement_string),
    #("patient", sp.patient),
    #("onset-age", sp.onset_age),
    #("abatement-age", sp.abatement_age),
    #("category", sp.category),
    #("body-site", sp.body_site),
  ])
  |> search_any(resources.RtCondition, client, handle_response)
}

pub fn potatocondition_search(
  sp: search_params.Potatocondition,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatocondition), Err)) -> msg,
) -> Effect(msg) {
  potatocondition_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potatocondition)
      Error(error) -> Error(error)
    })
  })
}

pub fn potatodocumentreference_search_bundled(
  sp: search_params.Potatodocumentreference,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("date", sp.date),
    #("subject", sp.subject),
    #("description", sp.description),
    #("language", sp.language),
    #("type", sp.type_),
    #("relation", sp.relation),
    #("setting", sp.setting),
    #("related", sp.related),
    #("patient", sp.patient),
    #("relationship", sp.relationship),
    #("event", sp.event),
    #("authenticator", sp.authenticator),
    #("identifier", sp.identifier),
    #("period", sp.period),
    #("custodian", sp.custodian),
    #("author", sp.author),
    #("format", sp.format),
    #("encounter", sp.encounter),
    #("contenttype", sp.contenttype),
    #("security-label", sp.security_label),
    #("location", sp.location),
    #("category", sp.category),
    #("relatesto", sp.relatesto),
    #("facility", sp.facility),
    #("status", sp.status),
  ])
  |> search_any(resources.RtDocumentreference, client, handle_response)
}

pub fn potatodocumentreference_search(
  sp: search_params.Potatodocumentreference,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatodocumentreference), Err)) ->
    msg,
) -> Effect(msg) {
  potatodocumentreference_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok(
          { bundle |> sansio.bundle_to_groupedresources }.potatodocumentreference,
        )
      Error(error) -> Error(error)
    })
  })
}

pub fn potatoencounter_search_bundled(
  sp: search_params.Potatoencounter,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("date", sp.date),
    #("identifier", sp.identifier),
    #("participant-type", sp.participant_type),
    #("practitioner", sp.practitioner),
    #("subject", sp.subject),
    #("length", sp.length),
    #("episode-of-care", sp.episode_of_care),
    #("diagnosis", sp.diagnosis),
    #("appointment", sp.appointment),
    #("part-of", sp.part_of),
    #("type", sp.type_),
    #("reason-code", sp.reason_code),
    #("participant", sp.participant),
    #("based-on", sp.based_on),
    #("patient", sp.patient),
    #("reason-reference", sp.reason_reference),
    #("location-period", sp.location_period),
    #("location", sp.location),
    #("service-provider", sp.service_provider),
    #("special-arrangement", sp.special_arrangement),
    #("class", sp.class),
    #("account", sp.account),
    #("status", sp.status),
  ])
  |> search_any(resources.RtEncounter, client, handle_response)
}

pub fn potatoencounter_search(
  sp: search_params.Potatoencounter,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatoencounter), Err)) -> msg,
) -> Effect(msg) {
  potatoencounter_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potatoencounter)
      Error(error) -> Error(error)
    })
  })
}

pub fn potatoimmunization_search_bundled(
  sp: search_params.Potatoimmunization,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("date", sp.date),
    #("identifier", sp.identifier),
    #("performer", sp.performer),
    #("reaction", sp.reaction),
    #("lot-number", sp.lot_number),
    #("status-reason", sp.status_reason),
    #("reason-code", sp.reason_code),
    #("manufacturer", sp.manufacturer),
    #("target-disease", sp.target_disease),
    #("patient", sp.patient),
    #("series", sp.series),
    #("vaccine-code", sp.vaccine_code),
    #("reason-reference", sp.reason_reference),
    #("location", sp.location),
    #("status", sp.status),
    #("reaction-date", sp.reaction_date),
  ])
  |> search_any(resources.RtImmunization, client, handle_response)
}

pub fn potatoimmunization_search(
  sp: search_params.Potatoimmunization,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatoimmunization), Err)) -> msg,
) -> Effect(msg) {
  potatoimmunization_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potatoimmunization)
      Error(error) -> Error(error)
    })
  })
}

pub fn potatomedicationrequest_search_bundled(
  sp: search_params.Potatomedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("requester", sp.requester),
    #("date", sp.date),
    #("identifier", sp.identifier),
    #("intended-dispenser", sp.intended_dispenser),
    #("authoredon", sp.authoredon),
    #("code", sp.code),
    #("subject", sp.subject),
    #("medication", sp.medication),
    #("encounter", sp.encounter),
    #("priority", sp.priority),
    #("intent", sp.intent),
    #("patient", sp.patient),
    #("intended-performer", sp.intended_performer),
    #("intended-performertype", sp.intended_performertype),
    #("category", sp.category),
    #("status", sp.status),
  ])
  |> search_any(resources.RtMedicationrequest, client, handle_response)
}

pub fn potatomedicationrequest_search(
  sp: search_params.Potatomedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatomedicationrequest), Err)) ->
    msg,
) -> Effect(msg) {
  potatomedicationrequest_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok(
          { bundle |> sansio.bundle_to_groupedresources }.potatomedicationrequest,
        )
      Error(error) -> Error(error)
    })
  })
}

pub fn potatomedicationstatement_search_bundled(
  sp: search_params.Potatomedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("identifier", sp.identifier),
    #("effective", sp.effective),
    #("code", sp.code),
    #("subject", sp.subject),
    #("patient", sp.patient),
    #("context", sp.context),
    #("medication", sp.medication),
    #("part-of", sp.part_of),
    #("source", sp.source),
    #("category", sp.category),
    #("status", sp.status),
  ])
  |> search_any(resources.RtMedicationstatement, client, handle_response)
}

pub fn potatomedicationstatement_search(
  sp: search_params.Potatomedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatomedicationstatement), Err)) ->
    msg,
) -> Effect(msg) {
  potatomedicationstatement_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok(
          { bundle |> sansio.bundle_to_groupedresources }.potatomedicationstatement,
        )
      Error(error) -> Error(error)
    })
  })
}

pub fn potatopatient_search_bundled(
  sp: search_params.Potatopatient,
  client: FhirClient,
  handle_response: fn(Result(resources.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_params.to_string([
    #("identifier", sp.identifier),
    #("given", sp.given),
    #("address", sp.address),
    #("birthdate", sp.birthdate),
    #("deceased", sp.deceased),
    #("address-state", sp.address_state),
    #("gender", sp.gender),
    #("general-practitioner", sp.general_practitioner),
    #("link", sp.link),
    #("active", sp.active),
    #("language", sp.language),
    #("address-postalcode", sp.address_postalcode),
    #("address-country", sp.address_country),
    #("death-date", sp.death_date),
    #("phonetic", sp.phonetic),
    #("phone", sp.phone),
    #("organization", sp.organization),
    #("name", sp.name),
    #("address-use", sp.address_use),
    #("telecom", sp.telecom),
    #("family", sp.family),
    #("address-city", sp.address_city),
    #("email", sp.email),
  ])
  |> search_any(resources.RtPatient, client, handle_response)
}

pub fn potatopatient_search(
  sp: search_params.Potatopatient,
  client: FhirClient,
  handle_response: fn(Result(List(resources.Potatopatient), Err)) -> msg,
) -> Effect(msg) {
  potatopatient_search_bundled(sp, client, fn(resp) {
    handle_response(case resp {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potatopatient)
      Error(error) -> Error(error)
    })
  })
}
