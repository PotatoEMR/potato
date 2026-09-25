import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio
import fhir/hl7_fhir_us_core_7_0_0/search_params
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

// MAIN ------------------------------------------------------------------------

pub fn main() {
  // when user clicks a link in app, send msg to update fn
  let modem_effect =
    modem.init(fn(uri) { uri |> uri_to_route |> UserNavigatedTo })
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}

// MODEL -----------------------------------------------------------------------

type Model {
  Model(
    route: Route,
    searched_patients: Result(List(resources.UsCorePatient), String),
    client: sansio.FhirClient,
  )
}

fn init(_) -> #(Model, Effect(Msg)) {
  let assert Ok(client) = sansio.fhirclient_new("127.0.0.1:8080/fhir")
  let model = Model(route: RouteNoId(Index), searched_patients: Ok([]), client:)
  #(model, effect.none())
}

// ROUTING ---------------------------------------------------------------------

pub type Route {
  RouteNoId(page: RouteNoId)
}

pub type RouteNoId {
  Index
  NotFound(notfound: String)
}

pub fn href(route: Route) -> Attribute(msg) {
  route |> route_to_urlstring |> a.href
}

pub fn route_to_urlstring(route: Route) -> String {
  case route {
    RouteNoId(page:) ->
      case page {
        Index -> "/"
        NotFound(_) -> "/"
      }
  }
}

pub fn uri_to_route(uri: Uri) -> Route {
  case uri.path_segments(uri.path) {
    [] -> RouteNoId(Index)
    [""] -> RouteNoId(Index)
    _ -> uri |> uri.to_string |> NotFound |> RouteNoId
  }
}

// UPDATE ----------------------------------------------------------------------

type Msg {
  UserNavigatedTo(route: Route)
  UserTypedSearchPatient(String)
  ServerReturnedSearchPatients(
    Result(List(resources.UsCorePatient), client_rsvp.Err),
  )
}

fn update(model: Model, message: Msg) -> #(Model, Effect(Msg)) {
  case message {
    UserNavigatedTo(route:) ->
      case route {
        RouteNoId(page:) -> #(Model(..model, route:), effect.none())
      }
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
