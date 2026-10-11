import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio
import fhir/hl7_fhir_us_core_7_0_0/search_params
import gleam/dict
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/uri.{type Uri}
import lustre
import lustre/attribute.{type Attribute} as a
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html as h
import lustre/event
import modem
import pages/no_specific_patient/calendar
import pages/no_specific_patient/register_patient
import pages/no_specific_patient/settings
import pages/patient/demographics
import pages/patient/growthchart
import pages/patient/overview
import pages/patient/vitals
import potato_ffi
import utils.{ue}

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}

// MODEL -----------------------------------------------------------------------

type Model(msg401) {
  Model(
    route: Route,
    search_patient: SearchPatient,
    client: client_rsvp.FhirClient(msg401),
    settings_theme: String,
  )
}

pub type SearchPatient {
  SearchPatient(text: String, visible: Bool, results: SearchPatientResults)
}

pub type SearchPatientResults {
  SearchPatientResultsPats(pats: List(resources.UsCorePatient))
  SearchPatientResultsErrMsg(err_msg: String)
  SearchPatientResultsLoadingMsg
  SearchPatientResultsEmptyMsg
}

// routes, uri_to_route type -> uri
// must stay in sync with Route uri -> type
// and in sync with labels in view

pub type Route {
  RoutePatient(id: String, patient: PatientLoad, page: RoutePatientPage)
  RouteNoSpecificPatient(page: RouteNoSpecificPatient)
}

pub type PatientLoad {
  PatientLoadStillLoading
  PatientLoadFound(data: PatientData)
  PatientLoadNotFound(String)
}

pub type PatientData {
  PatientData(patient: resources.UsCorePatient)
}

pub type RoutePatientPage {
  PatientOverview
  PatientDemographics
  PatientVitals
  PatientGrowthchart
}

pub type RouteNoSpecificPatient {
  Calendar
  RegisterPatient
  Settings
}

fn init(_) -> #(Model(Msg), Effect(Msg)) {
  let search_patient = SearchPatient("", False, SearchPatientResultsEmptyMsg)
  let assert Ok(client) = client_rsvp.fhirclient_new("127.0.0.1:3000/api")
  let client =
    client_rsvp.FhirClient(
      ..client,
      handle_unauthorized: Some(ServerReturned401),
    )
  // when user clicks a link in app, send msg to update fn
  let modem_effect =
    modem.init(fn(uri) { uri |> uri_to_route |> UserNavigatedTo })
  let assert Ok(route) = modem.initial_uri()
  let route = route |> uri_to_route
  let settings_theme = potato_ffi.get_theme()
  echo settings_theme
  let model = Model(route:, search_patient:, client:, settings_theme:)
  #(model, modem_effect)
}

// ROUTING ---------------------------------------------------------------------

pub fn href(route: Route) -> Attribute(msg) {
  route |> route_to_urlstring |> a.href
}

pub fn route_to_urlstring(route: Route) -> String {
  case route {
    RouteNoSpecificPatient(page:) ->
      case page {
        Calendar -> "/"
        Settings -> "/settings"
        RegisterPatient -> "/registerpatient"
      }
    RoutePatient(id:, patient:, page:) -> {
      let ending = case page {
        PatientOverview -> "overview"
        PatientDemographics -> "demographics"
        PatientVitals -> "vitals"
        PatientGrowthchart -> "growthchart"
      }
      "/patient/" <> id <> "/" <> ending
    }
  }
}

pub const pages_no_specific_patient: List(#(String, RouteNoSpecificPatient)) = [
  #("calendar", Calendar),
  #("settings", Settings),
  #("registerpatient", RegisterPatient),
]

pub const pages_patient: List(#(String, RoutePatientPage)) = [
  #("overview", PatientOverview),
  #("demographics", PatientDemographics),
  #("vitals", PatientVitals),
  #("growthchart", PatientGrowthchart),
]

pub fn uri_to_route(uri: Uri) -> Route {
  case uri.path_segments(uri.path) {
    [] -> RouteNoSpecificPatient(Calendar)
    [""] -> RouteNoSpecificPatient(Calendar)
    [page] ->
      case pages_no_specific_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RouteNoSpecificPatient(page:)
        Error(_) -> Calendar |> RouteNoSpecificPatient
      }
    ["patient", id, page] ->
      case pages_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RoutePatient(id:, patient: PatientLoadStillLoading, page:)
        Error(_) -> Calendar |> RouteNoSpecificPatient
      }
    _ -> Calendar |> RouteNoSpecificPatient
  }
}

fn user_navigated_to(route, model) {
  case route {
    RouteNoSpecificPatient(page:) -> #(Model(..model, route:), effect.none())
    RoutePatient(_patient, _page, id:) -> {
      // before getting all patient data, keep current patient data
      // so the sidebar and page will reload with new data if available
      // but will not blow away sidebar on every navigation while loading
      // instead keep patient from current route, and put in new route
      // at least until new patient data loads
      let existing_patient = case model.route {
        RouteNoSpecificPatient(_) -> PatientLoadStillLoading
        RoutePatient(existing_id, existing_patient, _existing_page) ->
          case id == existing_id {
            False -> PatientLoadStillLoading
            True -> existing_patient
          }
      }
      let route = RoutePatient(..route, patient: existing_patient)
      let model = Model(..model, route:)
      let pateverything =
        client_rsvp.search_any(
          "_id="
            <> id
            <> "&_revinclude=AllergyIntolerance:patient&_revinclude=DocumentReference:patient&_revinclude=Immunization:patient&_revinclude=MedicationRequest:patient&_revinclude=MedicationStatement:patient&_revinclude=Observation:patient&_revinclude=Condition:patient&_revinclude=Encounter:patient",
          resources.RtPatient,
          model.client,
          ServerReturnedPatientEverything,
        )
      #(model, pateverything)
    }
  }
}

// UPDATE ----------------------------------------------------------------------

type Msg {
  UserNavigatedTo(route: Route)
  // any unauthorized response
  ServerReturned401(err: sansio.ErrResp)
  // patient search
  UserTypedSearchPatient(String)
  ServerReturnedSearchPatients(
    Result(List(resources.UsCorePatient), client_rsvp.Err),
  )
  ServerReturnedPatientEverything(Result(resources.Bundle, client_rsvp.Err))
  // from page with no specific patient
  NspSettings(settings.Msg)
  // from patient page
}

fn update(model: Model(Msg), message: Msg) -> #(Model(Msg), Effect(Msg)) {
  case message {
    UserNavigatedTo(route:) -> user_navigated_to(route, model)
    ServerReturned401(_) -> {
      let assert Ok(url) = uri.parse("/auth/login")
      let send_to_login = modem.load(url)
      #(model, send_to_login)
    }
    UserTypedSearchPatient(search_text) -> {
      case search_text {
        "" -> {
          let model =
            model
            |> set_search_result(SearchPatientResultsEmptyMsg)
          #(model, effect.none())
        }
        _ -> {
          let search: Effect(Msg) =
            client_rsvp.us_core_patient_search(
              search_params.UsCorePatient(
                ..search_params.us_core_patient_new(),
                name: Some(search_text),
              ),
              model.client,
              ServerReturnedSearchPatients,
            )
          let model =
            Model(
              ..model,
              search_patient: SearchPatient(
                ..model.search_patient,
                visible: True,
                results: SearchPatientResultsLoadingMsg,
              ),
            )
          #(model, search)
        }
      }
    }
    ServerReturnedSearchPatients(patient_result) -> {
      let model =
        model
        |> set_search_result(case patient_result {
          Ok(patients) -> SearchPatientResultsPats(patients)
          Error(err) ->
            SearchPatientResultsErrMsg(
              "There was a problem getting patient search from FHIR server: "
              <> client_rsvp.err_to_string(err),
            )
        })
      #(model, effect.none())
    }
    ServerReturnedPatientEverything(patient_search_result) -> {
      let patient_info = case patient_search_result {
        Ok(pat_bundle) -> {
          let resources = sansio.bundle_to_groupedresources(pat_bundle)
          case resources.us_core_patient {
            [] -> PatientLoadNotFound("no patient found")
            [first, ..] ->
              PatientLoadFound(PatientData(
                patient: first,
                // patient_allergies: resources.allergyintolerance,
                // patient_documentreferences: resources.documentreference,
                // patient_encounters: resources.encounter,
                // patient_immunizations: resources.immunization,
                // patient_medications: resources.medication,
                // patient_medication_requests: resources.medicationrequest,
                // patient_medication_statements: resources.medicationstatement,
                // patient_observations: resources.observation,
              ))
          }
        }
        Error(err) -> PatientLoadNotFound(client_rsvp.err_to_string(err))
      }
      let model = case model.route {
        RouteNoSpecificPatient(_) -> model
        RoutePatient(_patient, id:, page:) -> {
          Model(..model, route: RoutePatient(id:, page:, patient: patient_info))
        }
      }
      #(model, effect.none())
    }
    NspSettings(msg) -> #(model, settings.update_effect(msg))
  }
}

fn set_search_result(model: Model(msg401), results: SearchPatientResults) {
  Model(
    ..model,
    search_patient: SearchPatient(..model.search_patient, results:),
  )
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model(Msg)) -> Element(Msg) {
  let patient_results = case model.search_patient.results {
    SearchPatientResultsPats(pats:) ->
      h.table([], [
        table_head(["", "Name", "MRN", "Birth Date", "Zip", "SSN", "Phone"]),
        ..list.map(pats, fn(patient) {
          table_row([
            "pic todo",
            utils.humannames_to_single_name_string(patient.name),
            patient |> utils.mrn |> ue,
            patient |> utils.birth_date |> ue,
            patient |> utils.first_zip |> ue,
            patient |> utils.ssn |> ue,
            patient |> utils.first_phone |> ue,
          ])
        })
      ])
    SearchPatientResultsErrMsg(err_msg:) -> h.div([], [h.text(err_msg)])
    SearchPatientResultsLoadingMsg -> h.div([], [h.text("loading...")])
    SearchPatientResultsEmptyMsg -> h.div([], [h.text("no results")])
  }
  h.div(
    [
      a.style("width", "100%"),
      a.style("height", "100%"),
      a.style("display", "flex"),
      a.style("flex-direction", "column"),
    ],
    [
      h.nav(
        [
          a.style("width", "100%"),
          a.style("display", "flex"),
          a.style("gap", "10px"),
        ],
        [
          h.button(
            [
              a.command("show-modal"),
              a.commandfor("search-patient-dialog"),
            ],
            [h.text("search patient")],
          ),
          h.dialog([a.closedby("any"), a.id("search-patient-dialog")], [
            h.header([], [
              h.button(
                [a.commandfor("search-patient-dialog"), a.command("close")],
                [
                  h.text("close"),
                ],
              ),
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
            patient_results,
          ]),
          h.a([href(RouteNoSpecificPatient(Calendar))], [
            h.text("calendar"),
          ]),
          h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
            h.text("register"),
            h.br([]),
            h.text("patient"),
          ]),
          h.a([href(RouteNoSpecificPatient(Settings))], [
            h.text("settings"),
          ]),
          // form instead of link because modem would take some more code to make logout link work
          // also maybe button better
          h.form([a.action("/auth/logout")], [
            h.button([], [h.text("log out")]),
          ]),
        ],
      ),
      h.div(
        [
          a.style("height", "100%"),
          a.style("width", "100%"),
          a.style("display", "flex"),
          a.style("gap", "5px"),
          a.style("flex", "1"),
        ],
        [
          h.div(
            [
              a.style("display", "flex"),
              a.style("flex-direction", "column"),
              a.style("flex-shrink", "0"),
              a.style("height", "100%"),
            ],
            [
              h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.a([href(RouteNoSpecificPatient(RegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.p([], [h.text("hi")]),
            ],
          ),
          h.main([a.style("flex", "1"), a.style("min-width", "0")], [
            case model.route {
              RouteNoSpecificPatient(page:) ->
                case page {
                  Calendar -> calendar.view()
                  RegisterPatient -> register_patient.view()
                  Settings ->
                    settings.view(model.settings_theme)
                    |> element.map(NspSettings)
                }
              RoutePatient(id:, patient:, page:) -> todo
            },
          ]),
        ],
      ),
    ],
  )
}

fn table_head(headers: List(String)) -> Element(Msg) {
  h.tr([], list.map(headers, fn(header) { h.th([], [h.text(header)]) }))
}

fn table_row(items: List(String)) -> Element(Msg) {
  h.tr([], list.map(items, fn(item) { h.td([], [h.text(item)]) }))
}
