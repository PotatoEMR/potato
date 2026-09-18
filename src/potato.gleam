import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio
import fhir/hl7_fhir_us_core_7_0_0/search_params
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html as h
import lustre/event

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}

// MODEL -----------------------------------------------------------------------

type Model {
  Model(
    searched_patients: Result(List(resources.UsCorePatient), String),
    client: sansio.FhirClient,
  )
}

fn init(_) -> #(Model, Effect(Msg)) {
  let assert Ok(client) = sansio.fhirclient_new("https://r4.smarthealthit.org/")
  let model = Model(searched_patients: Ok([]), client:)
  #(model, effect.none())
}

// UPDATE ----------------------------------------------------------------------

type Msg {
  UserTypedSearchPatient(String)
  ServerReturnedSearchPatients(
    Result(List(resources.UsCorePatient), client_rsvp.Err),
  )
}

fn update(model: Model, message: Msg) -> #(Model, Effect(Msg)) {
  case message {
    ServerReturnedSearchPatients(patient_result) ->
      case patient_result {
        Ok(patients) -> {
          let model = Model(..model, searched_patients: Ok(patients))
          #(model, effect.none())
        }
        Error(err) -> {
          let model =
            Model(
              ..model,
              searched_patients: Error(client_rsvp.err_to_string(err)),
            )
          #(model, effect.none())
        }
      }
    UserTypedSearchPatient(search_text) -> {
      let search: Effect(Msg) =
        client_rsvp.us_core_patient_search(
          search_params.UsCorePatient(
            ..search_params.us_core_patient_new(),
            name: Some(search_text),
          ),
          model.client,
          ServerReturnedSearchPatients,
        )
      #(model, search)
    }
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  let patient_results = case model.searched_patients {
    Ok(patients) ->
      list.map(patients, fn(patient) {
        h.div([], [
          h.text(case patient.id {
            None -> "no id"
            Some(id) -> id
          }),
        ])
      })
    Error(err) -> [h.div([], [h.text(err)])]
  }
  h.main([], [
    h.input([event.on_input(UserTypedSearchPatient)]),
    ..patient_results
  ])
}
