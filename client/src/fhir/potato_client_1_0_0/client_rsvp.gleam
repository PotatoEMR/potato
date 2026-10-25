////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) r4 client using rsvp

import fhir/potato_client_1_0_0/resource
import fhir/potato_client_1_0_0/sansio
import fhir/potato_client_1_0_0/search_param
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
/// `let pat = resource.patient_read("123", client)`
///
/// create client from server base url with fhirclient_new(base_url)`
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
  ErrSansio(err: sansio.ErrResponse)
}

pub fn err_to_string(err: Err) -> String {
  case err {
    ErrRsvp(err:) -> rsvp_err_to_string(err)
    ErrSansio(err:) -> sansio.err_response_to_string(err)
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
  resource_type: resource.ResourceType,
  resource_decoder: Decoder(r),
  client: FhirClient,
  handle_response: fn(Result(r, Err)) -> msg,
) -> Effect(msg) {
  let http_request =
    sansio.any_create_request(resource, resource_type, client.client)
  send_request_and_handle_response(
    http_request,
    resource_decoder,
    handle_response,
    client,
  )
}

fn any_read(
  id: String,
  resource_type: resource.ResourceType,
  resource_decoder: Decoder(r),
  client: FhirClient,
  handle_response: fn(Result(r, Err)) -> msg,
) -> Effect(msg) {
  let http_request = sansio.any_read_request(id, resource_type, client.client)
  send_request_and_handle_response(
    http_request,
    resource_decoder,
    handle_response,
    client,
  )
}

fn any_update(
  id: Option(String),
  resource: Json,
  resource_type: resource.ResourceType,
  resource_decoder: Decoder(r),
  client: FhirClient,
  handle_response: fn(Result(r, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let http_request =
    sansio.any_update_request(id, resource, resource_type, client.client)
  case http_request {
    Ok(http_request) ->
      Ok(send_request_and_handle_response(
        http_request,
        resource_decoder,
        handle_response,
        client,
      ))
    Error(_) -> Error(ErrNoId)
  }
}

pub fn any_delete(
  id: String,
  resource_type: resource.ResourceType,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Effect(msg) {
  let http_request = sansio.any_delete_request(id, resource_type, client.client)
  case client.client.print_sent_requests {
    sansio.LoggingOn -> http_request |> sansio.request_to_string |> io.println
    sansio.LoggingOff -> Nil
  }
  let handle_read = fn(
    response_result: Result(Response(String), rsvp.Error(String)),
  ) {
    case client.client.print_received_responses {
      sansio.LoggingOn ->
        case response_result {
          Ok(http_response) -> http_response |> sansio.response_to_string
          Error(err) -> err |> rsvp_err_to_string
        }
        |> io.println
      sansio.LoggingOff -> Nil
    }
    case response_result {
      Error(err) -> Error(ErrRsvp(err)) |> handle_response
      Ok(response) ->
        case sansio.delete_response(response) {
          Ok(operation_outcome_or_http) ->
            Ok(operation_outcome_or_http) |> handle_response
          Error(err) -> Error(ErrSansio(err)) |> handle_response
        }
    }
  }
  let handler = rsvp.expect_any_response(handle_read)
  http_request
  |> request.set_body(case http_request.body {
    None -> ""
    Some(body) -> json.to_string(body)
  })
  |> rsvp.send(handler)
}

/// write out search string manually, in case typed search params don't work
pub fn search_any(
  search_string: String,
  resource_type: resource.ResourceType,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  let http_request =
    sansio.any_search_request(search_string, resource_type, client.client)
  send_request_and_handle_response(
    http_request,
    resource.bundle_decoder(),
    handle_response,
    client,
  )
}

/// instead of failing whole decoder on bundle entry with invalid resource,
/// return valid resources alongside list of errors
pub fn search_any_forgiving(
  search_string: String,
  resource_type: resource.ResourceType,
  client: FhirClient,
  handle_response: fn(Result(resource.BundleForgiving, Err)) -> msg,
) -> Effect(msg) {
  let http_request =
    sansio.any_search_request(search_string, resource_type, client.client)
  send_request_and_handle_response(
    http_request,
    resource.bundle_decoder_forgiving(),
    handle_response,
    client,
  )
}

// run any operation string on any resource string, optionally using Parameters
pub fn operation_any(
  params params: Option(resource.Parameters),
  operation_name operation_name: String,
  resource_type resource_type: resource.ResourceType,
  resource_id resource_id: Option(String),
  resource_decoder resource_decoder: Decoder(resource),
  client client: FhirClient,
  handle_response handle_response: fn(Result(resource, Err)) -> msg,
) -> Effect(msg) {
  let http_request =
    sansio.any_operation_request(
      resource_type,
      resource_id,
      operation_name,
      params,
      client.client,
    )
  send_request_and_handle_response(
    http_request,
    resource_decoder,
    handle_response,
    client,
  )
}

pub fn batch(
  http_requests: List(Request(Option(Json))),
  bundle_type: sansio.PostBundleType,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  let http_request =
    sansio.batch_request(http_requests, bundle_type, client.client)
  send_request_and_handle_response(
    http_request,
    resource.bundle_decoder(),
    handle_response,
    client,
  )
}

fn send_request_and_handle_response(
  http_request: Request(Option(Json)),
  resource_decoder: Decoder(resource),
  handle_response: fn(Result(resource, Err)) -> msg,
  client: FhirClient,
) -> Effect(msg) {
  case client.client.print_sent_requests {
    sansio.LoggingOn -> http_request |> sansio.request_to_string |> io.println
    sansio.LoggingOff -> Nil
  }
  let handle_read = fn(
    response_result: Result(Response(String), rsvp.Error(String)),
  ) {
    case client.client.print_received_responses {
      sansio.LoggingOn ->
        case response_result {
          Ok(http_response) -> http_response |> sansio.response_to_string
          Error(err) -> err |> rsvp_err_to_string
        }
        |> io.println
      sansio.LoggingOff -> Nil
    }
    case response_result {
      Error(err) -> Error(ErrRsvp(err)) |> handle_response
      Ok(response) -> {
        case sansio.any_response(response, resource_decoder) {
          Ok(resource) -> Ok(resource) |> handle_response
          Error(err) -> Error(ErrSansio(err)) |> handle_response
        }
      }
    }
  }
  let handler = rsvp.expect_any_response(handle_read)
  http_request
  |> request.set_body(case http_request.body {
    None -> ""
    Some(body) -> json.to_string(body)
  })
  |> rsvp.send(handler)
}

fn rsvp_err_to_string(err: rsvp.Error(String)) -> String {
  case err {
    rsvp.BadBody -> "invalid http response body"
    rsvp.BadUrl(url) -> "invalid url: " <> url
    rsvp.HttpError(http_response) ->
      "http_response not 2xx: " <> sansio.response_to_string(http_response)
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
    rsvp.UnhandledResponse(http_response) ->
      "rsvp handler does not know how to handle response: "
      <> sansio.response_to_string(http_response)
  }
}

pub fn bundle_create(
  resource: resource.Bundle,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.bundle_to_json(resource),
    resource.ResourceTypeBundle,
    resource.bundle_decoder(),
    client,
    handle_response,
  )
}

pub fn bundle_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeBundle,
    resource.bundle_decoder(),
    client,
    handle_response,
  )
}

pub fn operationoutcome_create(
  resource: resource.Operationoutcome,
  client: FhirClient,
  handle_response: fn(Result(resource.Operationoutcome, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.operationoutcome_to_json(resource),
    resource.ResourceTypeOperationoutcome,
    resource.operationoutcome_decoder(),
    client,
    handle_response,
  )
}

pub fn operationoutcome_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.Operationoutcome, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeOperationoutcome,
    resource.operationoutcome_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_allergyintolerance_create(
  resource: resource.PotatoAllergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoAllergyintolerance, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_allergyintolerance_to_json(resource),
    resource.ResourceTypeAllergyintolerance,
    resource.potato_allergyintolerance_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_allergyintolerance_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoAllergyintolerance, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeAllergyintolerance,
    resource.potato_allergyintolerance_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_allergyintolerance_update(
  resource: resource.PotatoAllergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoAllergyintolerance, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_allergyintolerance_to_json(resource),
    resource.ResourceTypeAllergyintolerance,
    resource.potato_allergyintolerance_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_allergyintolerance_delete(
  resource: resource.PotatoAllergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resource.ResourceTypeAllergyintolerance,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potato_appointment_create(
  resource: resource.PotatoAppointment,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoAppointment, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_appointment_to_json(resource),
    resource.ResourceTypeAppointment,
    resource.potato_appointment_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_appointment_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoAppointment, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeAppointment,
    resource.potato_appointment_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_appointment_update(
  resource: resource.PotatoAppointment,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoAppointment, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_appointment_to_json(resource),
    resource.ResourceTypeAppointment,
    resource.potato_appointment_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_appointment_delete(
  resource: resource.PotatoAppointment,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resource.ResourceTypeAppointment,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potato_condition_create(
  resource: resource.PotatoCondition,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoCondition, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_condition_to_json(resource),
    resource.ResourceTypeCondition,
    resource.potato_condition_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_condition_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoCondition, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeCondition,
    resource.potato_condition_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_condition_update(
  resource: resource.PotatoCondition,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoCondition, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_condition_to_json(resource),
    resource.ResourceTypeCondition,
    resource.potato_condition_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_condition_delete(
  resource: resource.PotatoCondition,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resource.ResourceTypeCondition, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potato_documentreference_create(
  resource: resource.PotatoDocumentreference,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoDocumentreference, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_documentreference_to_json(resource),
    resource.ResourceTypeDocumentreference,
    resource.potato_documentreference_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_documentreference_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoDocumentreference, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeDocumentreference,
    resource.potato_documentreference_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_documentreference_update(
  resource: resource.PotatoDocumentreference,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoDocumentreference, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_documentreference_to_json(resource),
    resource.ResourceTypeDocumentreference,
    resource.potato_documentreference_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_documentreference_delete(
  resource: resource.PotatoDocumentreference,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resource.ResourceTypeDocumentreference,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potato_encounter_create(
  resource: resource.PotatoEncounter,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoEncounter, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_encounter_to_json(resource),
    resource.ResourceTypeEncounter,
    resource.potato_encounter_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_encounter_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoEncounter, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeEncounter,
    resource.potato_encounter_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_encounter_update(
  resource: resource.PotatoEncounter,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoEncounter, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_encounter_to_json(resource),
    resource.ResourceTypeEncounter,
    resource.potato_encounter_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_encounter_delete(
  resource: resource.PotatoEncounter,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resource.ResourceTypeEncounter, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn potato_immunization_create(
  resource: resource.PotatoImmunization,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoImmunization, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_immunization_to_json(resource),
    resource.ResourceTypeImmunization,
    resource.potato_immunization_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_immunization_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoImmunization, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeImmunization,
    resource.potato_immunization_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_immunization_update(
  resource: resource.PotatoImmunization,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoImmunization, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_immunization_to_json(resource),
    resource.ResourceTypeImmunization,
    resource.potato_immunization_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_immunization_delete(
  resource: resource.PotatoImmunization,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resource.ResourceTypeImmunization,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potato_medicationrequest_create(
  resource: resource.PotatoMedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoMedicationrequest, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_medicationrequest_to_json(resource),
    resource.ResourceTypeMedicationrequest,
    resource.potato_medicationrequest_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_medicationrequest_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoMedicationrequest, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeMedicationrequest,
    resource.potato_medicationrequest_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_medicationrequest_update(
  resource: resource.PotatoMedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoMedicationrequest, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_medicationrequest_to_json(resource),
    resource.ResourceTypeMedicationrequest,
    resource.potato_medicationrequest_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_medicationrequest_delete(
  resource: resource.PotatoMedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resource.ResourceTypeMedicationrequest,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potato_medicationstatement_create(
  resource: resource.PotatoMedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoMedicationstatement, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_medicationstatement_to_json(resource),
    resource.ResourceTypeMedicationstatement,
    resource.potato_medicationstatement_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_medicationstatement_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoMedicationstatement, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypeMedicationstatement,
    resource.potato_medicationstatement_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_medicationstatement_update(
  resource: resource.PotatoMedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoMedicationstatement, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_medicationstatement_to_json(resource),
    resource.ResourceTypeMedicationstatement,
    resource.potato_medicationstatement_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_medicationstatement_delete(
  resource: resource.PotatoMedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(
        id,
        resource.ResourceTypeMedicationstatement,
        client,
        handle_response,
      ))
    None -> Error(ErrNoId)
  }
}

pub fn potato_patient_create(
  resource: resource.PotatoPatient,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoPatient, Err)) -> msg,
) -> Effect(msg) {
  any_create(
    resource.potato_patient_to_json(resource),
    resource.ResourceTypePatient,
    resource.potato_patient_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_patient_read(
  id: String,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoPatient, Err)) -> msg,
) -> Effect(msg) {
  any_read(
    id,
    resource.ResourceTypePatient,
    resource.potato_patient_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_patient_update(
  resource: resource.PotatoPatient,
  client: FhirClient,
  handle_response: fn(Result(resource.PotatoPatient, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  any_update(
    id,
    resource.potato_patient_to_json(resource),
    resource.ResourceTypePatient,
    resource.potato_patient_decoder(),
    client,
    handle_response,
  )
}

pub fn potato_patient_delete(
  resource: resource.PotatoPatient,
  client: FhirClient,
  handle_response: fn(Result(sansio.OperationoutcomeOrHttp, Err)) -> msg,
) -> Result(Effect(msg), ErrNoId) {
  let id = resource.id
  case id {
    Some(id) ->
      Ok(any_delete(id, resource.ResourceTypePatient, client, handle_response))
    None -> Error(ErrNoId)
  }
}

pub fn bundle_search_bundled(
  search_param: search_param.Bundle,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("identifier", search_param.identifier),
    #("composition", search_param.composition),
    #("type", search_param.type_),
    #("message", search_param.message),
    #("timestamp", search_param.timestamp),
  ])
  |> search_any(resource.ResourceTypeBundle, client, handle_response)
}

pub fn bundle_search(
  search_param: search_param.Bundle,
  client: FhirClient,
  handle_response: fn(Result(List(resource.Bundle), Err)) -> msg,
) -> Effect(msg) {
  bundle_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) -> Ok({ bundle |> sansio.bundle_to_groupedresources }.bundle)
      Error(error) -> Error(error)
    })
  })
}

pub fn operationoutcome_search_bundled(
  _search_param: search_param.Operationoutcome,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([])
  |> search_any(resource.ResourceTypeOperationoutcome, client, handle_response)
}

pub fn operationoutcome_search(
  search_param: search_param.Operationoutcome,
  client: FhirClient,
  handle_response: fn(Result(List(resource.Operationoutcome), Err)) -> msg,
) -> Effect(msg) {
  operationoutcome_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.operationoutcome)
      Error(error) -> Error(error)
    })
  })
}

pub fn potato_allergyintolerance_search_bundled(
  search_param: search_param.PotatoAllergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("severity", search_param.severity),
    #("date", search_param.date),
    #("identifier", search_param.identifier),
    #("manifestation", search_param.manifestation),
    #("recorder", search_param.recorder),
    #("code", search_param.code),
    #("verification-status", search_param.verification_status),
    #("criticality", search_param.criticality),
    #("clinical-status", search_param.clinical_status),
    #("type", search_param.type_),
    #("onset", search_param.onset),
    #("route", search_param.route),
    #("asserter", search_param.asserter),
    #("patient", search_param.patient),
    #("category", search_param.category),
    #("last-date", search_param.last_date),
  ])
  |> search_any(
    resource.ResourceTypeAllergyintolerance,
    client,
    handle_response,
  )
}

pub fn potato_allergyintolerance_search(
  search_param: search_param.PotatoAllergyintolerance,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoAllergyintolerance), Err)) ->
    msg,
) -> Effect(msg) {
  potato_allergyintolerance_search_bundled(
    search_param,
    client,
    fn(http_response) {
      handle_response(case http_response {
        Ok(bundle) ->
          Ok(
            { bundle |> sansio.bundle_to_groupedresources }.potato_allergyintolerance,
          )
        Error(error) -> Error(error)
      })
    },
  )
}

pub fn potato_appointment_search_bundled(
  search_param: search_param.PotatoAppointment,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("date", search_param.date),
    #("identifier", search_param.identifier),
    #("specialty", search_param.specialty),
    #("service-category", search_param.service_category),
    #("practitioner", search_param.practitioner),
    #("part-status", search_param.part_status),
    #("appointment-type", search_param.appointment_type),
    #("service-type", search_param.service_type),
    #("slot", search_param.slot),
    #("reason-code", search_param.reason_code),
    #("actor", search_param.actor),
    #("based-on", search_param.based_on),
    #("patient", search_param.patient),
    #("reason-reference", search_param.reason_reference),
    #("supporting-info", search_param.supporting_info),
    #("location", search_param.location),
    #("status", search_param.status),
  ])
  |> search_any(resource.ResourceTypeAppointment, client, handle_response)
}

pub fn potato_appointment_search(
  search_param: search_param.PotatoAppointment,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoAppointment), Err)) -> msg,
) -> Effect(msg) {
  potato_appointment_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potato_appointment)
      Error(error) -> Error(error)
    })
  })
}

pub fn potato_condition_search_bundled(
  search_param: search_param.PotatoCondition,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("severity", search_param.severity),
    #("evidence-detail", search_param.evidence_detail),
    #("identifier", search_param.identifier),
    #("onset-info", search_param.onset_info),
    #("recorded-date", search_param.recorded_date),
    #("code", search_param.code),
    #("evidence", search_param.evidence),
    #("subject", search_param.subject),
    #("verification-status", search_param.verification_status),
    #("clinical-status", search_param.clinical_status),
    #("encounter", search_param.encounter),
    #("onset-date", search_param.onset_date),
    #("abatement-date", search_param.abatement_date),
    #("asserter", search_param.asserter),
    #("stage", search_param.stage),
    #("abatement-string", search_param.abatement_string),
    #("patient", search_param.patient),
    #("onset-age", search_param.onset_age),
    #("abatement-age", search_param.abatement_age),
    #("category", search_param.category),
    #("body-site", search_param.body_site),
  ])
  |> search_any(resource.ResourceTypeCondition, client, handle_response)
}

pub fn potato_condition_search(
  search_param: search_param.PotatoCondition,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoCondition), Err)) -> msg,
) -> Effect(msg) {
  potato_condition_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potato_condition)
      Error(error) -> Error(error)
    })
  })
}

pub fn potato_documentreference_search_bundled(
  search_param: search_param.PotatoDocumentreference,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("date", search_param.date),
    #("subject", search_param.subject),
    #("description", search_param.description),
    #("language", search_param.language),
    #("type", search_param.type_),
    #("relation", search_param.relation),
    #("setting", search_param.setting),
    #("related", search_param.related),
    #("patient", search_param.patient),
    #("relationship", search_param.relationship),
    #("event", search_param.event),
    #("authenticator", search_param.authenticator),
    #("identifier", search_param.identifier),
    #("period", search_param.period),
    #("custodian", search_param.custodian),
    #("author", search_param.author),
    #("format", search_param.format),
    #("encounter", search_param.encounter),
    #("contenttype", search_param.contenttype),
    #("security-label", search_param.security_label),
    #("location", search_param.location),
    #("category", search_param.category),
    #("relatesto", search_param.relatesto),
    #("facility", search_param.facility),
    #("status", search_param.status),
  ])
  |> search_any(resource.ResourceTypeDocumentreference, client, handle_response)
}

pub fn potato_documentreference_search(
  search_param: search_param.PotatoDocumentreference,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoDocumentreference), Err)) ->
    msg,
) -> Effect(msg) {
  potato_documentreference_search_bundled(
    search_param,
    client,
    fn(http_response) {
      handle_response(case http_response {
        Ok(bundle) ->
          Ok(
            { bundle |> sansio.bundle_to_groupedresources }.potato_documentreference,
          )
        Error(error) -> Error(error)
      })
    },
  )
}

pub fn potato_encounter_search_bundled(
  search_param: search_param.PotatoEncounter,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("date", search_param.date),
    #("identifier", search_param.identifier),
    #("participant-type", search_param.participant_type),
    #("practitioner", search_param.practitioner),
    #("subject", search_param.subject),
    #("length", search_param.length),
    #("episode-of-care", search_param.episode_of_care),
    #("diagnosis", search_param.diagnosis),
    #("appointment", search_param.appointment),
    #("part-of", search_param.part_of),
    #("type", search_param.type_),
    #("reason-code", search_param.reason_code),
    #("participant", search_param.participant),
    #("based-on", search_param.based_on),
    #("patient", search_param.patient),
    #("reason-reference", search_param.reason_reference),
    #("location-period", search_param.location_period),
    #("location", search_param.location),
    #("service-provider", search_param.service_provider),
    #("special-arrangement", search_param.special_arrangement),
    #("class", search_param.class),
    #("account", search_param.account),
    #("status", search_param.status),
  ])
  |> search_any(resource.ResourceTypeEncounter, client, handle_response)
}

pub fn potato_encounter_search(
  search_param: search_param.PotatoEncounter,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoEncounter), Err)) -> msg,
) -> Effect(msg) {
  potato_encounter_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potato_encounter)
      Error(error) -> Error(error)
    })
  })
}

pub fn potato_immunization_search_bundled(
  search_param: search_param.PotatoImmunization,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("date", search_param.date),
    #("identifier", search_param.identifier),
    #("performer", search_param.performer),
    #("reaction", search_param.reaction),
    #("lot-number", search_param.lot_number),
    #("status-reason", search_param.status_reason),
    #("reason-code", search_param.reason_code),
    #("manufacturer", search_param.manufacturer),
    #("target-disease", search_param.target_disease),
    #("patient", search_param.patient),
    #("series", search_param.series),
    #("vaccine-code", search_param.vaccine_code),
    #("reason-reference", search_param.reason_reference),
    #("location", search_param.location),
    #("status", search_param.status),
    #("reaction-date", search_param.reaction_date),
  ])
  |> search_any(resource.ResourceTypeImmunization, client, handle_response)
}

pub fn potato_immunization_search(
  search_param: search_param.PotatoImmunization,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoImmunization), Err)) -> msg,
) -> Effect(msg) {
  potato_immunization_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potato_immunization)
      Error(error) -> Error(error)
    })
  })
}

pub fn potato_medicationrequest_search_bundled(
  search_param: search_param.PotatoMedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("requester", search_param.requester),
    #("date", search_param.date),
    #("identifier", search_param.identifier),
    #("intended-dispenser", search_param.intended_dispenser),
    #("authoredon", search_param.authoredon),
    #("code", search_param.code),
    #("subject", search_param.subject),
    #("medication", search_param.medication),
    #("encounter", search_param.encounter),
    #("priority", search_param.priority),
    #("intent", search_param.intent),
    #("patient", search_param.patient),
    #("intended-performer", search_param.intended_performer),
    #("intended-performertype", search_param.intended_performertype),
    #("category", search_param.category),
    #("status", search_param.status),
  ])
  |> search_any(resource.ResourceTypeMedicationrequest, client, handle_response)
}

pub fn potato_medicationrequest_search(
  search_param: search_param.PotatoMedicationrequest,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoMedicationrequest), Err)) ->
    msg,
) -> Effect(msg) {
  potato_medicationrequest_search_bundled(
    search_param,
    client,
    fn(http_response) {
      handle_response(case http_response {
        Ok(bundle) ->
          Ok(
            { bundle |> sansio.bundle_to_groupedresources }.potato_medicationrequest,
          )
        Error(error) -> Error(error)
      })
    },
  )
}

pub fn potato_medicationstatement_search_bundled(
  search_param: search_param.PotatoMedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("identifier", search_param.identifier),
    #("effective", search_param.effective),
    #("code", search_param.code),
    #("subject", search_param.subject),
    #("patient", search_param.patient),
    #("context", search_param.context),
    #("medication", search_param.medication),
    #("part-of", search_param.part_of),
    #("source", search_param.source),
    #("category", search_param.category),
    #("status", search_param.status),
  ])
  |> search_any(
    resource.ResourceTypeMedicationstatement,
    client,
    handle_response,
  )
}

pub fn potato_medicationstatement_search(
  search_param: search_param.PotatoMedicationstatement,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoMedicationstatement), Err)) ->
    msg,
) -> Effect(msg) {
  potato_medicationstatement_search_bundled(
    search_param,
    client,
    fn(http_response) {
      handle_response(case http_response {
        Ok(bundle) ->
          Ok(
            { bundle |> sansio.bundle_to_groupedresources }.potato_medicationstatement,
          )
        Error(error) -> Error(error)
      })
    },
  )
}

pub fn potato_patient_search_bundled(
  search_param: search_param.PotatoPatient,
  client: FhirClient,
  handle_response: fn(Result(resource.Bundle, Err)) -> msg,
) -> Effect(msg) {
  search_param.to_string([
    #("identifier", search_param.identifier),
    #("given", search_param.given),
    #("address", search_param.address),
    #("birthdate", search_param.birthdate),
    #("deceased", search_param.deceased),
    #("address-state", search_param.address_state),
    #("gender", search_param.gender),
    #("general-practitioner", search_param.general_practitioner),
    #("link", search_param.link),
    #("active", search_param.active),
    #("language", search_param.language),
    #("address-postalcode", search_param.address_postalcode),
    #("address-country", search_param.address_country),
    #("death-date", search_param.death_date),
    #("phonetic", search_param.phonetic),
    #("phone", search_param.phone),
    #("organization", search_param.organization),
    #("name", search_param.name),
    #("address-use", search_param.address_use),
    #("telecom", search_param.telecom),
    #("family", search_param.family),
    #("address-city", search_param.address_city),
    #("email", search_param.email),
  ])
  |> search_any(resource.ResourceTypePatient, client, handle_response)
}

pub fn potato_patient_search(
  search_param: search_param.PotatoPatient,
  client: FhirClient,
  handle_response: fn(Result(List(resource.PotatoPatient), Err)) -> msg,
) -> Effect(msg) {
  potato_patient_search_bundled(search_param, client, fn(http_response) {
    handle_response(case http_response {
      Ok(bundle) ->
        Ok({ bundle |> sansio.bundle_to_groupedresources }.potato_patient)
      Error(error) -> Error(error)
    })
  })
}
