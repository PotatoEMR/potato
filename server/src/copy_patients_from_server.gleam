import fhir/hl7_fhir_us_core_7_0_0/client_httpc
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/uri

pub fn main() {
  let assert Ok(client) = sansio.fhirclient_new("https://r4.smarthealthit.org/")
  io.println("downloading from: " <> client.baseurl |> uri.to_string)
  io.println("downloading all patients, might take a bit")
  let assert Ok(patients) =
    client_httpc.search_any_forgiving("", resources.RtPatient, client)
    |> client_httpc.all_pages_forgiving(client)
  let valid_patients =
    patients.entry
    |> list.filter_map(fn(entry) {
      case entry.resource {
        Some(Ok(resources.ResourceUsCorePatient(pat))) -> Ok(pat)
        _ -> Error(Nil)
      }
    })
  io.println("creating patients on local fhir server")
  let assert Ok(client) = sansio.fhirclient_new("http://127.0.0.1:8080/fhir/")
  let assert Ok(batch_patient_create) =
    valid_patients
    |> list.map(fn(patient) {
      patient
      |> strip_references
      |> resources.us_core_patient_to_json
      |> sansio.any_create_req(resources.RtPatient, client)
    })
    |> client_httpc.batch(sansio.Transaction, client)
  let num = batch_patient_create.entry |> list.length |> int.to_string
  io.println("created " <> num <> " patients")
}

// not copying other references onto this server so hapi doesnt like if patient has them
// might also be references in contact or whatever idk
fn strip_references(from patient: resources.UsCorePatient) {
  resources.UsCorePatient(
    ..patient,
    general_practitioner: [],
    managing_organization: None,
  )
}
