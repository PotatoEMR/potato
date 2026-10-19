import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/complex_types
import fhir/hl7_fhir_us_core_7_0_0/primitive_types
import fhir/hl7_fhir_us_core_7_0_0/resources.{type Appointment}
import fhir/hl7_fhir_us_core_7_0_0/search_params
import fhir/hl7_fhir_us_core_7_0_0/valuesets
import glaze/oat/button
import glaze/oat/dialog
import glaze/oat/form
import glaze/oat/table
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/order
import gleam/time/calendar
import gleam/time/duration
import gleam/time/timestamp
import lustre/attribute as a
import lustre/effect.{type Effect}
import lustre/element
import lustre/element/html as h
import lustre/event
import potato_ffi
import search_patient
import ui
import utils

const apt_id = "appointment-dialog"

pub type Model {
  Model(
    calendar: AppointmentList,
    choosing: Option(resources.Appointment),
    choose_schedule_patient: search_patient.Model,
    // name is just to show in disabled input; actual chosen patient for appointment is in actor Reference
    selected_patient_name: String,
    submit_error: Option(client_rsvp.Err),
  )
}

pub const new = Model(StillLoading, None, search_patient.new, "", None)

// currently doing calendar with just Appointment
// there is also Slot if we want to let ppl define availability
pub type AppointmentList {
  Appointments(apts: List(Appointment))
  LoadError(client_rsvp.Err)
  StillLoading
}

pub type Msg {
  ServerReturnedAppointments(Result(List(Appointment), client_rsvp.Err))
  UserClickedCalendarSlot(timestamp.Timestamp)
  SelectPatient(search_patient.Msg)
  UserClickedSchedule
  ServerReturnedClickSchedule(Result(Appointment, client_rsvp.Err))
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

pub fn update(
  model: Model,
  msg: Msg,
  client: client_rsvp.FhirClient,
  client_err_msg: fn(client_rsvp.Err) -> String,
  scheduler_id: String,
) -> #(Model, Effect(Msg)) {
  case msg {
    ServerReturnedAppointments(apts) -> #(
      Model(..model, calendar: case apts {
        Ok(apts) -> Appointments(apts)
        Error(err) -> LoadError(err)
      }),
      effect.none(),
    )
    UserClickedCalendarSlot(date) -> {
      // normally could open dialog directly with command on btn but doesn't work on table cell
      // want the cells directly clickable though, maybe should put a btn in them but this feels easier
      potato_ffi.open_dialog(apt_id)
      let cal = timestamp.to_calendar(date, calendar.utc_offset)
      let t = cal.1
      let time =
        primitive_types.Time(
          hour: t.hours,
          minute: t.minutes,
          second: t.seconds,
          // including sec and nanosec although it's probably just zero
          nanosec: Some(primitive_types.NanosecWithPrecision(
            t.nanoseconds,
            None,
          )),
        )
      let start =
        Some(primitive_types.Instant(
          date: cal.0,
          time:,
          // todo actual timezone?
          timezone: primitive_types.Z,
        ))
      // here assuming the person who schedules appointment is the practitioner doing it
      // obviously not necessarily true but whatever
      let practitioner_reference =
        complex_types.Reference(
          ..complex_types.reference_new(),
          reference: Some("Practitioner/" <> scheduler_id),
        )
      let practitioner_participant =
        resources.appointment_participant_new(
          status: valuesets.ParticipationstatusAccepted,
        )
      let practitioner_participant =
        resources.AppointmentParticipant(
          ..practitioner_participant,
          actor: Some(practitioner_reference),
        )
      let choosing =
        resources.appointment_new(
          participant: utils.as_list1(practitioner_participant),
          status: valuesets.AppointmentstatusBooked,
        )
      let choosing = Some(resources.Appointment(..choosing, start:))
      // technically we can have an appointment with no patient but idk if that is really a valid state
      let model = Model(..model, choosing:, selected_patient_name: "")
      #(model, effect.none())
    }
    SelectPatient(msg) -> {
      let #(choose_schedule_patient, search_effect, clicked_patient) =
        search_patient.update(
          model.choose_schedule_patient,
          msg,
          client,
          client_err_msg,
        )
      let idk = #(
        Model(..model, choose_schedule_patient:),
        effect.map(search_effect, SelectPatient),
      )
      case clicked_patient {
        None -> idk
        Some(clicked_patient) ->
          case clicked_patient.id {
            None -> idk
            Some(id) -> {
              let patient_reference =
                complex_types.Reference(
                  ..complex_types.reference_new(),
                  reference: Some("Patient/" <> id),
                )
              let choosing = case model.choosing {
                // would be weird to be here in open dialog with None choosing
                None -> None
                Some(choosing) -> {
                  let patient_participant =
                    resources.appointment_participant_new(
                      status: valuesets.ParticipationstatusAccepted,
                    )
                  let patient_participant =
                    resources.AppointmentParticipant(
                      ..patient_participant,
                      actor: Some(patient_reference),
                    )
                  // here we already have dctor as first participant so add patient
                  let participant =
                    complex_types.List1(choosing.participant.first, [
                      patient_participant,
                    ])
                  echo participant
                  Some(resources.Appointment(..choosing, participant:))
                }
              }
              let selected_patient_name =
                clicked_patient.name.first |> utils.humanname_to_string
              #(
                Model(..model, choosing:, selected_patient_name:),
                effect.none(),
              )
            }
          }
      }
    }
    UserClickedSchedule ->
      case model.choosing {
        None -> #(model, effect.none())
        Some(choosing) -> {
          let create_appointment =
            client_rsvp.appointment_create(
              choosing,
              client,
              ServerReturnedClickSchedule,
            )
          #(model, create_appointment)
        }
      }
    ServerReturnedClickSchedule(Error(err)) -> {
      let model = Model(..model, submit_error: Some(err))
      #(model, effect.none())
    }
    ServerReturnedClickSchedule(Ok(apt)) -> {
      // close dialog and maybe toast
      case model.calendar {
        Appointments(apts:) -> {
          let apts = [apt, ..apts]
          let model = Model(..model, calendar: Appointments(apts))
          #(model, effect.none())
        }
        LoadError(_) -> todo
        StillLoading -> todo
      }
    }
  }
}

pub fn view(model: Model, err_to_string) {
  let now = timestamp.system_time()
  // idk if this utc offset is correct for system_time
  let now_calendar = timestamp.to_calendar(now, calendar.utc_offset)
  let now_date = now_calendar.0
  let day_of_week = calendar.day_of_week(now_date)
  let first_sunday_offset = case day_of_week {
    calendar.Sunday -> 0
    calendar.Monday -> -1
    calendar.Tuesday -> -2
    calendar.Wednesday -> -3
    calendar.Thursday -> -4
    calendar.Friday -> -5
    calendar.Saturday -> -6
  }
  let first_sunday_date =
    calendar.Date(..now_date, day: now_date.day - first_sunday_offset)
  let first_sunday_12am =
    timestamp.from_calendar(
      first_sunday_date,
      calendar.TimeOfDay(0, 0, 0, 0),
      duration.empty,
    )

  case model.calendar {
    LoadError(err) ->
      h.p([], [
        h.text("error loading calendar: " <> err_to_string(err)),
      ])
    StillLoading -> h.p([], [h.text("calendar loading...")])
    Appointments(apts:) ->
      table.container([], [
        h.style(
          [],
          // can't do hover style inline
          // oat puts hover on row, but for calendar we want it on individual cell, and not first hour cell
          "
              .highlight-one-cell tbody tr {
                    &:hover {
                        background-color: transparent;
                    }
                }
              .highlight-one-cell tbody td:not(:first-child) {
                  transition: background-color var(--transition-fast);
                  &:hover {
                      background-color: rgb(from var(--muted) r g b / .5)
                  }
              }
          ",
        ),
        table.table(
          [
            a.class("higlight-one-cell"),
            a.style("table-layout", "fixed"),
            a.style("width", "100%"),
          ],
          [
            h.thead(
              [
                a.style("border", "0px"),
              ],
              [
                h.tr(
                  [],
                  [
                    "Sun",
                    "Mon",
                    "Tue",
                    "Wed",
                    "Thu",
                    "Fri",
                    "Sat",
                  ]
                    |> list.map(day_column_head)
                    // first empty because we have times in first col
                    |> list.prepend(
                      h.th(
                        [
                          a.style("width", "5em"),
                        ],
                        [],
                      ),
                    ),
                ),
              ],
            ),
            h.tbody(
              [],
              list.reverse(
                int.range(from: 0, to: 24, with: [], run: fn(acc, hour_num) {
                  let hour = case hour_num {
                    0 -> "12 AM"
                    12 -> "12 PM"
                    _ ->
                      case hour_num < 12 {
                        True -> int.to_string(hour_num) <> " AM"
                        False -> int.to_string(hour_num - 12) <> " PM"
                      }
                  }
                  let hour =
                    h.td(
                      [
                        a.style("white-space", "nowrap"),
                        a.style("vertical-align", "top"),
                        a.style("padding-top", "0"),
                        a.style("position", "relative"),
                        a.style("top", "-0.7em"),
                        a.style("text-align", "right"),
                        a.style("border", "0px"),
                      ],
                      [h.text(hour)],
                    )
                  let hour_row =
                    h.tr([a.style("border", "0px")], [
                      hour,
                      ..int.range(0, 7, [], fn(day_acc, day_num) {
                        let day_reverse_idk = 6 - day_num
                        // 24 for col (day of week)
                        let hours = 24 * day_reverse_idk
                        // n for cell (hour of day)
                        let hours = hours + hour_num
                        let cell_time =
                          first_sunday_12am
                          |> timestamp.add(duration.hours(hours))
                        let cell =
                          h.td(
                            [
                              event.on_click(UserClickedCalendarSlot(cell_time)),
                              a.style("border", "1px solid"),
                              a.style("height", "50px"),
                            ],
                            // there must be a more efficient way of distributing appts around the calendar, but whatever
                            list.filter_map(apts, fn(apt) {
                              case apt.start {
                                None -> Error(Nil)
                                Some(start) -> {
                                  let apt_time =
                                    timestamp.from_calendar(
                                      start.date,
                                      calendar.TimeOfDay(
                                        start.time.hour,
                                        start.time.minute,
                                        start.time.second,
                                        0,
                                      ),
                                      duration.empty,
                                    )
                                  let cell_start_time =
                                    timestamp.from_calendar(
                                      first_sunday_date,
                                      calendar.TimeOfDay(hours, 0, 0, 0),
                                      duration.empty,
                                    )
                                  let cell_end_time =
                                    cell_start_time
                                    |> timestamp.add(duration.hours(1))
                                  echo "hi"
                                  echo apt_time
                                  echo cell_start_time
                                  echo cell_end_time
                                  case
                                    timestamp.compare(apt_time, cell_start_time),
                                    timestamp.compare(apt_time, cell_end_time)
                                  {
                                    order.Gt, order.Lt | order.Eq, order.Lt ->
                                      Ok(
                                        h.div([], [
                                          h.text(case apt.participant.rest {
                                            [patient] ->
                                              case patient.actor {
                                                Some(ref) ->
                                                  case ref.reference {
                                                    Some(ref) -> ref
                                                    None -> "idk 3"
                                                  }
                                                None -> "idk 2"
                                              }
                                            _ -> "idk 1"
                                          }),
                                        ]),
                                      )
                                    _, _ -> Error(Nil)
                                  }
                                }
                              }
                            }),
                          )
                        [cell, ..day_acc]
                      })
                    ])
                  [hour_row, ..acc]
                }),
              ),
            ),
          ],
        ),
        dialog.dialog([dialog.id(apt_id), dialog.closed_by_any()], [
          dialog.header([], [dialog.title([], [h.text("Book Visit")])]),
          ui.vstack([
            h.div([], [
              search_patient.view(
                model.choose_schedule_patient,
                "calendar-search-patient",
              )
                |> element.map(SelectPatient),
              ui.field("Patient", [
                a.disabled(True),
                a.value(model.selected_patient_name),
              ]),
            ]),
            ui.field("Time", [
              a.type_("datetime-local"),
              case model.choosing {
                None -> a.none()
                Some(appointment) ->
                  case appointment.start {
                    None -> a.none()
                    Some(start) -> ui.instant_to_datetime_local(start)
                  }
              },
            ]),
            h.div([form.error()], [
              h.text(case model.submit_error {
                None -> ""
                Some(err) -> err_to_string(err)
              }),
            ]),
          ]),
          dialog.footer([], [
            button.button([button.danger(), ..dialog.close_for(apt_id)], [
              h.text("Cancel"),
            ]),
            button.button([event.on_click(UserClickedSchedule)], [
              h.text("Schedule Appointment"),
            ]),
          ]),
        ]),
      ])
  }
}

fn day_column_head(day: String) {
  h.th(
    [
      a.style("position", "sticky"),
      a.style("top", "0"),
      a.style("z-index", "2"),
      a.style("width", "120px"),
      a.style("box-sizing", "border-box"),
      a.style("border", "0px"),
    ],
    [h.text(day)],
  )
}
