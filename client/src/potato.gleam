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
import utils

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
  NotFound(notfound: String)
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
  let model =
    Model(route: RouteNoSpecificPatient(Calendar), search_patient:, client:)
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
        RegisterPatient -> todo
        NotFound(_) -> "/notfound"
      }
    RoutePatient(id:, patient:, page:) -> {
      let ending = case page {
        PatientOverview -> todo
        PatientDemographics -> todo
        PatientVitals -> todo
        PatientGrowthchart -> todo
      }
      "/patient/" <> id <> "/" <> ending
    }
  }
}

pub const pages_no_specific_patient: List(#(String, RouteNoSpecificPatient)) = [
  #("calendar", Calendar),
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
        Error(_) -> uri |> uri.to_string |> NotFound |> RouteNoSpecificPatient
      }
    ["patient", id, page] ->
      case pages_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RoutePatient(id:, patient: PatientLoadStillLoading, page:)
        Error(_) -> uri |> uri.to_string |> NotFound |> RouteNoSpecificPatient
      }
    _ -> uri |> uri.to_string |> NotFound |> RouteNoSpecificPatient
  }
}

fn user_navigated_to(route, model) {
  case route {
    RouteNoSpecificPatient(page:) -> #(Model(..model, route:), effect.none())
    RoutePatient(id:, patient:, page:) -> todo
  }
}

// UPDATE ----------------------------------------------------------------------

type Msg {
  UserNavigatedTo(route: Route)
  // any unauthorized response
  ServerReturned401(err: sansio.ErrResp)
  // patient search
  UserFocusedSearch
  UserBlurredSearch
  UserTypedSearchPatient(String)
  ServerReturnedSearchPatients(
    Result(List(resources.UsCorePatient), client_rsvp.Err),
  )
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
        "" ->
          model
          |> set_search_result(SearchPatientResultsEmptyMsg)
          |> model_no_effect
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
            model
            |> set_search_result(SearchPatientResultsLoadingMsg)
            |> set_search_visible(True)
          #(model, search)
        }
      }
    }
    ServerReturnedSearchPatients(patient_result) ->
      model
      |> set_search_result(case patient_result {
        Ok(patients) -> SearchPatientResultsPats(patients)
        Error(err) ->
          SearchPatientResultsErrMsg(
            "There was a problem getting patient search from FHIR server: "
            <> client_rsvp.err_to_string(err),
          )
      })
      |> model_no_effect
    UserFocusedSearch -> model |> set_search_visible(True) |> model_no_effect
    UserBlurredSearch -> model |> set_search_visible(False) |> model_no_effect
  }
}

fn set_search_result(model: Model(msg401), results: SearchPatientResults) {
  Model(
    ..model,
    search_patient: SearchPatient(..model.search_patient, results:),
  )
}

fn set_search_visible(model: Model(msg401), visible: Bool) {
  Model(
    ..model,
    search_patient: SearchPatient(..model.search_patient, visible:),
  )
}

fn model_no_effect(model: Model(msg401)) {
  #(model, effect.none())
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model(Msg)) -> Element(Msg) {
  let patient_results = case model.search_patient.results {
    SearchPatientResultsPats(pats:) ->
      list.map(pats, fn(patient) {
        h.div([], [h.text(utils.humannames_to_single_name_string(patient.name))])
      })
    SearchPatientResultsErrMsg(err_msg:) -> [h.div([], [h.text(err_msg)])]
    SearchPatientResultsLoadingMsg -> [h.div([], [h.text("loading...")])]
    SearchPatientResultsEmptyMsg -> []
  }
  h.div([], [
    h.nav(nav_style(), [
      h.label(
        [
          a.for("search-patient"),
          a.style("background-color", "red"),
          a.style("padding", "5px"),
        ],
        [
          h.input([
            a.id("search-patient"),
            event.on_input(UserTypedSearchPatient),
          ]),
        ],
      ),
      ..patient_results
    ]),
    h.nav(nav_style(), [
      h.a([], [h.text("abcabcabc")]),
      h.a([], [h.text("abcabcabc")]),
      h.a([], [h.text("abcabcabc")]),
      h.a([], [h.text("abcabcabc")]),
      h.a([], [h.text("abcabcabc")]),
      h.a([], [h.text("abcabcabc")]),
    ]),
    h.main([], [h.text("main")]),
  ])
}

fn nav_style() {
  [
    a.styles([
      #("display", "flex"),
      #("gap", "5px"),
      #("border-bottom", "1px solid black"),
    ]),
  ]
}
