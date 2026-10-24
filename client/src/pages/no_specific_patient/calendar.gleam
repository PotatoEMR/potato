import fhir/potato_client_1_0_0/client_rsvp
import fhir/potato_client_1_0_0/complex_types
import fhir/potato_client_1_0_0/primitive_types
import fhir/potato_client_1_0_0/resources.{type Potatoappointment}
import fhir/potato_client_1_0_0/search_params
import fhir/potato_client_1_0_0/valuesets
import glaze/oat/button
import glaze/oat/dialog
import glaze/oat/form
import glaze/oat/table
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/order
import gleam/result
import gleam/string
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
    choosing: Option(resources.Potatoappointment),
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
  Appointments(apts: List(Potatoappointment))
  LoadError(client_rsvp.Err)
  StillLoading
}

pub type Msg {
  ServerReturnedAppointments(Result(List(Potatoappointment), client_rsvp.Err))
  UserClickedCalendarSlot(timestamp.Timestamp)
  UserEnterStart(String)
  UserEnterEnd(String)
  UserSelectPatient(search_patient.Msg)
  UserEnterComment(String)
  UserClickedSchedule
  ServerReturnedClickSchedule(Result(Potatoappointment, client_rsvp.Err))
}

pub fn load_appointments_effect(
  practitioner_id: String,
  client: client_rsvp.FhirClient,
) {
  let sp = search_params.potatoappointment_new()
  let sp =
    search_params.Potatoappointment(
      ..sp,
      practitioner: Some("Practitioner/" <> practitioner_id),
    )
  client_rsvp.potatoappointment_search(sp, client, ServerReturnedAppointments)
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
        complex_types.Potatoreference(
          ..complex_types.potatoreference_new(),
          reference: Some("Practitioner/" <> scheduler_id),
        )
      let practitioner_participant =
        resources.potatoappointment_participant_new(
          status: valuesets.ParticipationstatusAccepted,
        )
      let practitioner_participant =
        resources.PotatoappointmentParticipant(
          ..practitioner_participant,
          actor: Some(practitioner_reference),
        )
      let choosing =
        resources.potatoappointment_new(
          participant: utils.as_list1(practitioner_participant),
          status: valuesets.AppointmentstatusBooked,
        )
      let choosing = Some(resources.Potatoappointment(..choosing, start:))
      // technically we can have an appointment with no patient but idk if that is really a valid state
      let model = Model(..model, choosing:, selected_patient_name: "")
      #(model, effect.none())
    }
    UserSelectPatient(msg) -> {
      let #(choose_schedule_patient, search_effect, clicked_patient) =
        search_patient.update(
          model.choose_schedule_patient,
          msg,
          client,
          client_err_msg,
        )
      let idk = #(
        Model(..model, choose_schedule_patient:),
        effect.map(search_effect, UserSelectPatient),
      )
      case clicked_patient {
        None -> idk
        Some(clicked_patient) ->
          case clicked_patient.id {
            None -> idk
            Some(id) -> {
              let patient_reference =
                complex_types.Potatoreference(
                  ..complex_types.potatoreference_new(),
                  reference: Some("Patient/" <> id),
                )
              let choosing = case model.choosing {
                // would be weird to be here in open dialog with None choosing
                None -> None
                Some(choosing) -> {
                  let patient_participant =
                    resources.potatoappointment_participant_new(
                      status: valuesets.ParticipationstatusAccepted,
                    )
                  let patient_participant =
                    resources.PotatoappointmentParticipant(
                      ..patient_participant,
                      actor: Some(patient_reference),
                    )
                  // here we already have dctor as first participant so add patient
                  let participant =
                    complex_types.List1(choosing.participant.first, [
                      patient_participant,
                    ])
                  echo participant
                  Some(resources.Potatoappointment(..choosing, participant:))
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
    // clearly a lot of duplication here, will clean up later maybe
    UserEnterStart(start) ->
      case model.choosing {
        None -> #(model, effect.none())
        Some(choosing) -> {
          let date = start |> string.slice(0, 10) |> primitive_types.parse_date
          let model = case date {
            Ok(primitive_types.YearMonthDay(year:, month:, day:)) -> {
              let date = calendar.Date(year:, month:, day:)
              let time =
                start
                |> string.slice(11, string.length(start))
                |> primitive_types.parse_time
                |> result.unwrap(primitive_types.Time(
                  hour: 0,
                  minute: 0,
                  second: 0,
                  nanosec: None,
                ))
              // timezone idk
              let timezone = primitive_types.Z
              let start = Some(primitive_types.Instant(date:, time:, timezone:))
              let choosing =
                Some(resources.Potatoappointment(..choosing, start:))
              Model(..model, choosing:)
            }
            _ -> model
          }
          #(model, effect.none())
        }
      }
    UserEnterEnd(end) ->
      case model.choosing {
        None -> #(model, effect.none())
        Some(choosing) -> {
          let date = end |> string.slice(0, 10) |> primitive_types.parse_date
          let model = case date {
            Ok(primitive_types.YearMonthDay(year:, month:, day:)) -> {
              let date = calendar.Date(year:, month:, day:)
              let time =
                end
                |> string.slice(11, string.length(end))
                |> primitive_types.parse_time
                |> result.unwrap(primitive_types.Time(
                  hour: 0,
                  minute: 0,
                  second: 0,
                  nanosec: None,
                ))
              // timezone idk
              let timezone = primitive_types.Z
              let end = Some(primitive_types.Instant(date:, time:, timezone:))
              let choosing = Some(resources.Potatoappointment(..choosing, end:))
              Model(..model, choosing:)
            }
            _ -> model
          }
          #(model, effect.none())
        }
      }
    UserEnterComment(comment) ->
      case model.choosing {
        None -> #(model, effect.none())
        Some(choosing) -> {
          let choosing =
            Some(
              resources.Potatoappointment(..choosing, comment: Some(comment)),
            )
          let model = Model(..model, choosing:)
          #(model, effect.none())
        }
      }
    UserClickedSchedule ->
      case model.choosing {
        None -> #(model, effect.none())
        Some(choosing) -> {
          let create_appointment =
            client_rsvp.potatoappointment_create(
              choosing,
              client,
              ServerReturnedClickSchedule,
            )
          #(model, create_appointment)
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
            a.class("highlight-one-cell"),
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
                                  case
                                    timestamp.compare(apt_time, cell_start_time),
                                    timestamp.compare(apt_time, cell_end_time)
                                  {
                                    order.Gt, order.Lt | order.Eq, order.Lt ->
                                      Ok(
                                        h.div([], [
                                          h.text(
                                            case apt.start {
                                              None -> "?"
                                              Some(start) ->
                                                primitive_types.instant_to_string(
                                                  start,
                                                )
                                            }
                                            <> " - "
                                            <> case apt.end {
                                              None -> "?"
                                              Some(end) ->
                                                primitive_types.instant_to_string(
                                                  end,
                                                )
                                            },
                                          ),
                                          h.br([]),
                                          h.text(
                                            apt.comment |> option.unwrap(""),
                                          ),
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
                |> element.map(UserSelectPatient),
              ui.field("Patient", [
                a.disabled(True),
                a.value(model.selected_patient_name),
              ]),
            ]),
            ui.field("Start", [
              event.on_input(UserEnterStart),
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
            ui.field("End", [
              a.type_("datetime-local"),
              event.on_input(UserEnterEnd),
              case model.choosing {
                None -> a.none()
                Some(appointment) ->
                  case appointment.end {
                    None -> a.none()
                    Some(end) -> ui.instant_to_datetime_local(end)
                  }
              },
            ]),
            ui.field("Comment", [
              event.on_input(UserEnterComment),
              case model.choosing {
                None -> a.none()
                Some(appointment) ->
                  case appointment.comment {
                    None -> a.none()
                    Some(comment) -> a.value(comment)
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
