import fhir/hl7_fhir_us_core_7_0_0/complex_types as ct
import fhir/hl7_fhir_us_core_7_0_0/primitive_types as pt
import gleam/option.{type Option, None, Some}
import gleam/string

pub fn humanname_to_string(name: ct.Humanname) -> String {
  case name.text {
    Some(txt) -> txt
    None -> {
      let prefixes = name.prefix |> string.join(" ")
      let given = name.given |> string.join(" ")
      let family = case name.family {
        Some(f) -> f
        None -> ""
      }
      let suffixes = name.suffix |> string.join(" ")
      let period = case name.period {
        Some(p) ->
          string.concat([
            "(",
            case p.start {
              Some(s) -> s |> pt.datetime_to_string
              None -> "?"
            },
            " - ",
            case p.end {
              Some(e) -> e |> pt.datetime_to_string
              None -> "now"
            },
            ")",
          ])
        None -> ""
      }
      string.join([prefixes, given, family, suffixes, period], " ")
    }
  }
}
