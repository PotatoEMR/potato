import fhir/potato_client_1_0_0/client_rsvp
import fhir/potato_client_1_0_0/resources
import fhir/potato_client_1_0_0/search_params
import glaze/oat/table
import gleam/list
import gleam/option.{None, Some}
import lustre/attribute as a
import lustre/effect.{type Effect}
import lustre/element/html as h
import lustre/event
import utils.{ue}

// search and select patient for whatever purpose
// use by:
//  add search_patient.Model to model
//  add search_patient.Msg as message variant
//  in update fn, handle clicked_patient
//  in view, open dialog button comes from search_patient.view(model.search_pat_xyz) |> element.map(MsgXyzSearchPatient)
// elm locality of behavior kind of sucks idk? but the type safety is really nice it does all snap together eventually

// model

pub type Model {
  Model(search_patient: SearchPatient)
}

pub const new = Model(SearchPatient("", SearchPatientResultsEmptyMsg))

pub type SearchPatient {
  SearchPatient(text: String, results: SearchPatientResults)
}

pub type SearchPatientResults {
  SearchPatientResultsPats(pats: List(resources.Potatopatient))
  SearchPatientResultsErrMsg(err_msg: String)
  SearchPatientResultsLoadingMsg
  SearchPatientResultsEmptyMsg
}

// update

pub type Msg {
  UserTypedSearchPatient(String)
  ServerReturnedSearchPatients(
    Result(List(resources.Potatopatient), client_rsvp.Err),
  )
  UserClickedPatient(patient: resources.Potatopatient)
}

// in addition to returning a search patient model and effect,
// this also returns a patient if the user clicked to select a patient
// typically the convention is to return error but I feel like option makes more sense here idk
pub fn update(
  model: Model,
  msg: Msg,
  client: client_rsvp.FhirClient,
  client_err_msg: fn(client_rsvp.Err) -> String,
) -> #(Model, Effect(Msg), option.Option(resources.Potatopatient)) {
  case msg {
    UserTypedSearchPatient(search_text) -> {
      case search_text {
        "" -> {
          let model =
            model
            |> set_search_result(SearchPatientResultsEmptyMsg)
          #(model, effect.none(), None)
        }
        _ -> {
          let search: Effect(Msg) =
            client_rsvp.potatopatient_search(
              search_params.Potatopatient(
                ..search_params.potatopatient_new(),
                name: Some(search_text),
              ),
              client,
              ServerReturnedSearchPatients,
            )
          let model =
            Model(
              search_patient: SearchPatient(
                ..model.search_patient,
                results: SearchPatientResultsLoadingMsg,
              ),
            )
          #(model, search, None)
        }
      }
    }
    ServerReturnedSearchPatients(patient_result) -> {
      let model =
        model
        |> set_search_result(case patient_result {
          Ok([]) -> SearchPatientResultsEmptyMsg
          Ok(patients) -> SearchPatientResultsPats(patients)
          Error(err) ->
            SearchPatientResultsErrMsg(
              "There was a problem getting patient search from FHIR server: "
              <> client_err_msg(err),
            )
        })
      #(model, effect.none(), None)
    }
    UserClickedPatient(patient:) -> {
      #(model, effect.none(), Some(patient))
    }
  }
}

fn set_search_result(model: Model, results: SearchPatientResults) -> Model {
  Model(
    ..model,
    search_patient: SearchPatient(..model.search_patient, results:),
  )
}

// view

pub fn view(model: Model, unique_id: String) {
  h.div([], [
    h.button(
      [
        a.command("show-modal"),
        a.commandfor(unique_id),
      ],
      [
        h.text("🔍 search patient"),
      ],
    ),
    h.dialog([a.closedby("any"), a.id(unique_id)], [
      h.header([], [
        h.button([a.commandfor(unique_id), a.command("close")], [
          h.text("close"),
        ]),
      ]),
      h.label(
        [
          a.for("search-patient"),
        ],
        [
          h.text("Name"),
          h.input([
            a.id("search-patient"),
            event.on_input(UserTypedSearchPatient),
          ]),
        ],
      ),
      case model.search_patient.results {
        SearchPatientResultsPats(pats:) ->
          table.container([], [
            table.table([], [
              table.thead(
                [],
                patient_column_headers([
                  "",
                  "Name",
                  "MRN",
                  "Birth Date",
                  "Zip",
                  "SSN",
                  "Phone",
                ]),
              ),
              table.tbody(
                [],
                list.map(pats, fn(patient) {
                  clickable_patient_row(patient, [
                    "pic todo",
                    utils.humannames_to_single_name_string(patient.name),
                    patient |> utils.mrn |> ue,
                    patient |> utils.birth_date |> ue,
                    patient |> utils.first_zip |> ue,
                    patient |> utils.ssn |> ue,
                    patient |> utils.first_phone |> ue,
                  ])
                }),
              ),
            ]),
          ])
        SearchPatientResultsErrMsg(err_msg:) -> h.div([], [h.text(err_msg)])
        SearchPatientResultsLoadingMsg -> h.div([], [h.text("loading...")])
        SearchPatientResultsEmptyMsg -> h.div([], [h.text("no results")])
      },
    ]),
  ])
}

fn patient_column_headers(headers: List(String)) {
  list.map(headers, fn(header) { table.th([], [h.text(header)]) })
}

fn clickable_patient_row(
  patient: resources.Potatopatient,
  items: List(String),
) {
  table.tr(
    [],
    list.map(items, fn(item) {
      table.td([event.on_click(UserClickedPatient(patient))], [h.text(item)])
    }),
  )
}
