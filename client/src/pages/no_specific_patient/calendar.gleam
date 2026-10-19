import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/primitive_types
import fhir/hl7_fhir_us_core_7_0_0/resources.{type Appointment}
import fhir/hl7_fhir_us_core_7_0_0/search_params
import fhir/hl7_fhir_us_core_7_0_0/valuesets
import glaze/oat/button
import glaze/oat/dialog
import glaze/oat/table
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/time/calendar
import gleam/time/duration
import gleam/time/timestamp
import lustre/attribute as a
import lustre/effect.{type Effect}
import lustre/element/html as h
import lustre/event
import potato_ffi
import ui
import utils

const apt_id = "appointment-dialog"

pub type Model {
  Model(calendar: AppointmentList, choosing: Option(resources.Appointment))
}

pub const new = Model(StillLoading, None)

// currently doing calendar with just Appointment
// there is also Slot if we want to let ppl define availability
pub type AppointmentList {
  Appointments(apts: List(Appointment))
  LoadError(client_rsvp.Err)
  StillLoading
}

pub type Msg {
  ServerReturnedAppointments(Result(List(Appointment), client_rsvp.Err))
  UserClickedCreateAppointment(timestamp.Timestamp)
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

pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    ServerReturnedAppointments(apts) -> #(
      Model(..model, calendar: case apts {
        Ok(apts) -> Appointments(apts)
        Error(err) -> LoadError(err)
      }),
      effect.none(),
    )
    UserClickedCreateAppointment(date) -> {
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
      let choosing =
        resources.appointment_new(
          participant: utils.as_list1(resources.appointment_participant_new(
            status: valuesets.ParticipationstatusAccepted,
          )),
          status: valuesets.AppointmentstatusBooked,
        )
      let choosing = Some(resources.Appointment(..choosing, start:))
      // technically we can have an appointment with no patient but idk if that is really a valid state
      let model = Model(..model, choosing:)
      #(model, effect.none())
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
                              event.on_click(UserClickedCreateAppointment(
                                cell_time,
                              )),
                              a.style("border", "1px solid"),
                              a.style("height", "50px"),
                            ],
                            [],
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
          dialog.form([], [
            dialog.header([], [dialog.title([], [h.text("Book Visit")])]),
            ui.vstack([
              ui.field("Patient", []),
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
            ]),
            dialog.footer([], [
              button.button([button.danger(), ..dialog.close_for(apt_id)], [
                h.text("Cancel"),
              ]),
              button.button([], [h.text("Schedule Appointment")]),
            ]),
          ]),
        ]),
      ])
    // h.p([], [h.text(now <> "num apts " <> int.to_string(list.length(apts)))])
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
