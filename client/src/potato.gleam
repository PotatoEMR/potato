import fhir/potato_client_1_0_0/client_rsvp
import fhir/potato_client_1_0_0/resource
import fhir/potato_client_1_0_0/sansio
import glaze/oat/sidebar
import gleam/dict
import gleam/json
import gleam/option.{None, Some}
import gleam/uri.{type Uri}
import lustre
import lustre/attribute.{type Attribute} as a
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html as h
import modem
import pages/no_specific_patient/calendar
import pages/no_specific_patient/register_patient
import pages/no_specific_patient/settings
import search_patient
import shared

// import pages/patient/demographics
// import pages/patient/growthchart
// import pages/patient/overview
// import pages/patient/vitals
import potato_ffi
import utils

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
    main_search_patient: search_patient.Model,
    client: client_rsvp.FhirClient,
    client_err_msg: fn(client_rsvp.Err) -> String,
    shared_user: shared.SharedUser,
  )
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
  PatientData(patient: resource.PotatoPatient)
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
      main_search_patient: search_patient.new,
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
    RoutePatient(_patient, id:, page:) -> {
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
  #("calendar", RouteCalendar(calendar.new)),
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
    [] -> RouteNoSpecificPatient(RouteCalendar(calendar.new))
    [""] -> RouteNoSpecificPatient(RouteCalendar(calendar.new))
    [page] ->
      case pages_no_specific_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RouteNoSpecificPatient(page:)
        Error(_) -> RouteCalendar(calendar.new) |> RouteNoSpecificPatient
      }
    ["patient", id, page] ->
      case pages_patient |> dict.from_list |> dict.get(page) {
        Ok(page) -> RoutePatient(id:, patient: PatientLoadStillLoading, page:)
        Error(_) -> RouteCalendar(calendar.new) |> RouteNoSpecificPatient
      }
    // could put a 404 page here
    _ -> RouteCalendar(calendar.new) |> RouteNoSpecificPatient
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
          resource.ResourceTypePatient,
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
  // patient search
  MsgMainSearchPatient(search_patient.Msg)
  ServerReturnedPatientEverything(Result(resource.Bundle, client_rsvp.Err))
  // from page with no specific patient
  MsgSettings(settings.Msg)
  MsgCalendar(calendar.Msg)
  // from patient page
}

fn update(model: Model, message: Msg) -> #(Model, Effect(Msg)) {
  case message {
    UserNavigatedTo(route:) -> user_navigated_to(route, model)
    MsgMainSearchPatient(msg) -> {
      let #(main_search_patient, search_effect, clicked_patient) =
        search_patient.update(
          model.main_search_patient,
          msg,
          model.client,
          model.client_err_msg,
        )
      let idk = #(
        Model(..model, main_search_patient:),
        effect.map(search_effect, MsgMainSearchPatient),
      )
      case clicked_patient {
        None -> idk
        Some(clicked_patient) ->
          case clicked_patient.id {
            None -> idk
            Some(id) -> {
              let to_patient =
                UserNavigatedTo(RoutePatient(
                  id,
                  PatientLoadStillLoading,
                  PatientOverview,
                ))
              update(model, to_patient)
            }
          }
      }
    }
    ServerReturnedPatientEverything(patient_search_result) -> {
      let patient_info = case patient_search_result {
        Ok(pat_bundle) -> {
          let resources = sansio.bundle_to_groupedresources(pat_bundle)
          case resources.potato_patient {
            [] -> PatientLoadNotFound("no patient found")
            [first, ..] ->
              PatientLoadFound(PatientData(
                patient: first,
                // patient_allergies: resource.allergyintolerance,
                // patient_documentreferences: resource.documentreference,
                // patient_encounters: resource.encounter,
                // patient_immunizations: resource.immunization,
                // patient_medications: resource.medication,
                // patient_medication_requests: resource.medicationrequest,
                // patient_medication_statements: resource.medicationstatement,
                // patient_observations: resource.observation,
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
      case model.route {
        RouteNoSpecificPatient(RouteCalendar(page)) -> {
          let #(page, calendar_effect) =
            calendar.update(
              page,
              msg,
              model.client,
              model.client_err_msg,
              model.shared_user.id,
            )
          let route = RouteNoSpecificPatient(RouteCalendar(page))
          #(Model(..model, route:), effect.map(calendar_effect, MsgCalendar))
        }
        // if we get a calendar message while not on calendar page, just ignore it
        _ -> #(model, effect.none())
      }
      // let #(calendar, effect) = calendar.update(msg)
      // let model =
      //   Model(..model, route: RouteNoSpecificPatient(RouteCalendar(calendar)))
      // #(model, effect)
    }
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  sidebar.sidebar(h.div, [], [
    sidebar.topnav([], [
      search_patient.view(model.main_search_patient, "main-search-patient")
        |> element.map(MsgMainSearchPatient),
      h.a([href(RouteNoSpecificPatient(RouteCalendar(calendar.new)))], [
        h.text("📅 calendar"),
      ]),
      h.a([href(RouteNoSpecificPatient(RouteRegisterPatient))], [
        h.text("➕ register patient"),
      ]),
      h.a([href(RouteNoSpecificPatient(RouteSettings))], [
        h.text("⚙️ settings"),
      ]),
      // form instead of link because modem would take some more code to make logout link work
      // also maybe button better
      h.form([a.action("/auth/logout")], [
        h.button([], [h.text("➜] log out")]),
      ]),
      h.text(model.shared_user.name),
    ]),
    sidebar.aside([], [
      h.a([href(RouteNoSpecificPatient(RouteRegisterPatient))], [
        h.text("abcabcabc"),
      ]),
      h.p([], [h.text("hi")]),
      h.p([], [h.text("hi")]),
      h.p([], [h.text("hi")]),
      h.p([], [h.text("hi")]),
      h.p([], [h.text("hi")]),
      h.p([], [h.text("hi")]),
      h.p([], [h.text("hi")]),
    ]),
    h.main(
      [
        a.style("padding", "20px"),
        // a.style("flex", "1"),
      // a.style("min-width", "0"),
      // a.style("min-height", "0"),
      ],
      [
        case model.route {
          RouteNoSpecificPatient(page:) ->
            case page {
              RouteCalendar(m) ->
                calendar.view(m, model.client_err_msg)
                |> element.map(MsgCalendar)
              RouteRegisterPatient -> register_patient.view()
              RouteSettings ->
                settings.view(model.shared_user.settings_theme)
                |> element.map(MsgSettings)
            }
          RoutePatient(id, _patient, _page) -> h.text("todo " <> id)
        },
      ],
    ),
  ])
}
