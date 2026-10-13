import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources.{type Appointment}
import fhir/hl7_fhir_us_core_7_0_0/search_params
import gleam/int
import gleam/list
import gleam/option.{Some}
import lustre/effect
import lustre/element/html as h

// currently doing calendar with just Appointment
// there is also Slot if we want to let ppl define availability
pub type Model {
  Appointments(apts: List(Appointment))
  LoadError(client_rsvp.Err)
  StillLoading
}

pub type Msg {
  ServerReturnedAppointments(Result(List(Appointment), client_rsvp.Err))
}

pub fn load_appointments_effect(
  practitioner_id: String,
  client: client_rsvp.FhirClient,
) {
  let sp = search_params.appointment_new()
  let sp =
    search_params.Appointment(
      ..sp,
      practitioner: Some("Practitioner/" <> practitioner_id),
    )
  client_rsvp.appointment_search(sp, client, ServerReturnedAppointments)
}

pub fn update(msg: Msg) {
  case msg {
    ServerReturnedAppointments(Ok(apts)) -> #(Appointments(apts), effect.none())
    ServerReturnedAppointments(Error(err)) -> #(LoadError(err), effect.none())
  }
}

pub fn view(model: Model, err_to_string) {
  case model {
    LoadError(err) ->
      h.p([], [
        h.text("error loading calendar: " <> err_to_string(err)),
      ])
    StillLoading -> h.p([], [h.text("calendar loading...")])
    Appointments(apts:) ->
      h.p([], [h.text("num apts " <> int.to_string(list.length(apts)))])
  }
}
