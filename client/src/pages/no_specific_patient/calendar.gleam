import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources.{type Appointment}
import fhir/hl7_fhir_us_core_7_0_0/search_params
import gleam/option.{Some}
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
  client: client_rsvp.FhirClient(Msg),
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
    ServerReturnedAppointments(Ok(apts)) -> todo
    ServerReturnedAppointments(Error(err)) -> todo
  }
}

pub fn view() {
  h.p([], [h.text("appointment list and calendar")])
}
