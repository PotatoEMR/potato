import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/resources.{type Appointment}
import fhir/hl7_fhir_us_core_7_0_0/search_params
import gleam/int
import gleam/list
import gleam/option.{Some}
import gleam/time/calendar
import gleam/time/timestamp
import lustre/attribute as a
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
  let now = timestamp.system_time() |> timestamp.to_http_date
  case model {
    LoadError(err) ->
      h.p([], [
        h.text("error loading calendar: " <> err_to_string(err)),
      ])
    StillLoading -> h.p([], [h.text("calendar loading...")])
    Appointments(apts:) ->
      h.div(
        [
          // so that scrollbar goes on table right instead of all the way to page right
          a.styles([
            #("width", "max-content"),
            #("max-width", "100%"),
            #("height", "100%"),
            #("overflow", "auto;"),
            #("scrollbar-gutter", "stable"),
            #("padding-right", "5px"),
          ]),
        ],
        [
          h.table(
            [
              a.style("table-layout", "fixed"),
              // 120 * 7 = 840 for days
              // + 70 for hour
              // might be a better way idk 
              a.style("width", "940px"),
              a.style("border-collapse", "collapse"),
            ],
            [
              h.tr(
                [],
                [
                  "Mon",
                  "Tue",
                  "Wed",
                  "Thu",
                  "Fri",
                  "Sat",
                  "Sun",
                ]
                  |> list.map(day_column_head)
                  // first empty because we have times in first col
                  |> list.prepend(h.th([a.style("border", "0")], [])),
              ),
              ..list.reverse(
                int.range(from: 0, to: 24, with: [], run: fn(acc, num) {
                  let hour = case num {
                    0 -> "12 AM"
                    12 -> "12 PM"
                    _ ->
                      case num < 12 {
                        True -> int.to_string(num) <> " AM"
                        False -> int.to_string(num - 12) <> " PM"
                      }
                  }
                  let hour =
                    h.td(
                      [
                        a.style("width", "100px"),
                        a.style("min-width", "100px"),
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
                    h.tr([], [
                      hour,
                      ..list.repeat(
                        h.td([a.style("border", "1px solid currentColor")], []),
                        7,
                      )
                    ])
                  [hour_row, ..acc]
                }),
              )
            ],
          ),
        ],
      )
    // h.p([], [h.text(now <> "num apts " <> int.to_string(list.length(apts)))])
  }
}

fn day_column_head(day: String) {
  h.th(
    [
      a.style("background-color", "Canvas"),
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
