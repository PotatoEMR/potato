import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio
import fhir/hl7_fhir_us_core_7_0_0/search_params
import gleam/dict
import gleam/json
import gleam/list
import gleam/option.{Some}
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
import shared

// import pages/patient/demographics
// import pages/patient/growthchart
// import pages/patient/overview
// import pages/patient/vitals
import potato_ffi
import utils.{ue}

// MAIN ------------------------------------------------------------------------

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}

// MODEL -----------------------------------------------------------------------

type Model {
  Model(
    route: Route,
    search_patient: SearchPatient,
    client: client_rsvp.FhirClient,
    client_err_msg: fn(client_rsvp.Err) -> String,
    shared_user: shared.SharedUser,
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
  RouteCalendar(calendar.Model)
  RouteRegisterPatient
  RouteSettings
}

const server_url = "127.0.0.1:4000/api"

fn init(_: a) -> #(Model, Effect(Msg)) {
  let search_patient = SearchPatient("", False, SearchPatientResultsEmptyMsg)
  let assert Ok(client) = client_rsvp.fhirclient_new(server_url)
  // when user clicks a link in app, send msg to update fn
  let modem_effect =
    modem.init(fn(uri) { uri |> uri_to_route |> UserNavigatedTo })
  let assert Ok(route) = modem.initial_uri()
  let route = route |> uri_to_route
  // it is not ok to load without shared user from server, and should never happen
  let assert Ok(shared_user) =
    potato_ffi.get_text_content("script[type='application/json']")
  let assert Ok(shared_user) =
    json.parse(shared_user, shared.shared_user_decoder())

  let client_error_msg = utils.err_to_string(server_url)
  let model =
    Model(
      route:,
      search_patient:,
      client:,
      client_err_msg: client_error_msg,
      shared_user:,
    )
  let #(model, firstload_effect) = user_navigated_to(route, model)
  #(model, effect.batch([modem_effect, firstload_effect]))
}

// ROUTING ---------------------------------------------------------------------

pub fn href(route: Route) -> Attribute(msg) {
  route |> route_to_urlstring |> a.href
}

pub fn route_to_urlstring(route: Route) -> String {
  case route {
    RouteNoSpecificPatient(page:) ->
      case page {
        RouteCalendar(_) -> "/"
        RouteSettings -> "/settings"
        RouteRegisterPatient -> "/registerpatient"
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
  #("calendar", RouteCalendar(calendar.StillLoading)),
  #("settings", RouteSettings),
  #("registerpatient", RouteRegisterPatient),
]

pub const pages_patient: List(#(String, RoutePatientPage)) = [
  #("overview", PatientOverview),
  #("demographics", PatientDemographics),
  #("vitals", PatientVitals),
  #("growthchart", PatientGrowthchart),
]

pub fn uri_to_route(uri: Uri) -> Route {
  case uri.path_segments(uri.path) {
    [] -> RouteNoSpecificPatient(RouteCalendar(calendar.StillLoading))
    [""] -> RouteNoSpecificPatient(RouteCalendar(calendar.StillLoading))
    [page] ->
      case pages_no_specific_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RouteNoSpecificPatient(page:)
        Error(_) ->
          RouteCalendar(calendar.StillLoading) |> RouteNoSpecificPatient
      }
    ["patient", id, page] ->
      case pages_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RoutePatient(id:, patient: PatientLoadStillLoading, page:)
        Error(_) ->
          RouteCalendar(calendar.StillLoading) |> RouteNoSpecificPatient
      }
    _ -> RouteCalendar(calendar.StillLoading) |> RouteNoSpecificPatient
  }
}

fn user_navigated_to(route: Route, model: Model) -> #(Model, Effect(Msg)) {
  case route {
    RouteNoSpecificPatient(page:) -> {
      let load_page_effect = case page {
        RouteCalendar(_) ->
          calendar.load_appointments_effect(model.shared_user.id, model.client)
          |> effect.map(MsgCalendar)
        RouteRegisterPatient -> effect.none()
        RouteSettings -> effect.none()
      }
      #(Model(..model, route:), load_page_effect)
    }
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
  MsgSettings(settings.Msg)
  MsgCalendar(calendar.Msg)
  // from patient page
}

fn update(model: Model, message: Msg) -> #(Model, Effect(Msg)) {
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
              <> model.client_err_msg(err),
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
        Error(err) -> PatientLoadNotFound(model.client_err_msg(err))
      }
      let model = case model.route {
        RouteNoSpecificPatient(_) -> model
        RoutePatient(_patient, id:, page:) -> {
          Model(..model, route: RoutePatient(id:, page:, patient: patient_info))
        }
      }
      #(model, effect.none())
    }
    MsgSettings(msg) -> #(model, settings.update_effect(msg))
    MsgCalendar(msg) -> {
      let #(calendar, effect) = calendar.update(msg)
      let model =
        Model(..model, route: RouteNoSpecificPatient(RouteCalendar(calendar)))
      #(model, effect)
    }
  }
}

fn set_search_result(model: Model, results: SearchPatientResults) -> Model {
  Model(
    ..model,
    search_patient: SearchPatient(..model.search_patient, results:),
  )
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
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
          h.a(
            [href(RouteNoSpecificPatient(RouteCalendar(calendar.StillLoading)))],
            [
              h.text("📅 calendar"),
            ],
          ),
          h.a([href(RouteNoSpecificPatient(RouteRegisterPatient))], [
            h.text("➕ register patient"),
          ]),
          h.a([href(RouteNoSpecificPatient(RouteSettings))], [
            h.text("⚙️ settings"),
          ]),
          // form instead of link because modem would take some more code to make logout link work
          // also maybe button better
          h.form([a.action("/auth/logout")], [
            h.button([], [h.text("log out")]),
          ]),
          h.text(model.shared_user.name),
        ],
      ),
      h.div(
        [
          a.style("display", "flex"),
          a.style("gap", "5px"),
          a.style("flex", "1"),
          a.style("min-height", "0"),
        ],
        [
          h.div(
            [
              a.style("display", "flex"),
              a.style("flex-direction", "column"),
              a.style("flex-shrink", "0"),
            ],
            [
              h.a([href(RouteNoSpecificPatient(RouteRegisterPatient))], [
                h.text("abcabcabc"),
              ]),
              h.p([], [h.text("hi")]),
            ],
          ),
          h.main(
            [
              a.style("flex", "1"),
              a.style("min-width", "0"),
              a.style("min-height", "0"),
              a.style("overflow", "auto"),
            ],
            [
              case model.route {
                RouteNoSpecificPatient(page:) ->
                  case page {
                    RouteCalendar(m) -> calendar.view(m, model.client_err_msg)
                    RouteRegisterPatient -> register_patient.view()
                    RouteSettings ->
                      settings.view(model.shared_user.settings_theme)
                      |> element.map(MsgSettings)
                  }
                RoutePatient(id:, patient:, page:) -> todo
              },
            ],
          ),
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
