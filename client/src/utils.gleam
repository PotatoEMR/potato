import fhir/hl7_fhir_us_core_7_0_0/client_rsvp
import fhir/hl7_fhir_us_core_7_0_0/complex_types.{type List1} as ct
import fhir/hl7_fhir_us_core_7_0_0/primitive_types as pt
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/valuesets
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string
import rsvp

pub fn err_to_string(server_url: String) {
  fn(err: client_rsvp.Err) {
    case err {
      client_rsvp.ErrRsvp(rsvp.NetworkError) ->
        "could not connect to " <> server_url
      _ -> client_rsvp.err_to_string(err)
    }
  }
}

pub fn humannames_to_single_name_string(names: List1(ct.Humanname)) -> String {
  // for now just taking first name from list
  // i have code from old project comparing period starts
  // but could also compare period ends
  // also idk about converting to timestamp to do compare vs adding a compare fn to fhir datetime
  humanname_to_string(names.first)
}

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

pub fn ue(res: Result(String, a)) {
  result.unwrap(res, "")
}

pub fn first_zip(patient: resources.UsCorePatient) {
  patient.address
  |> list.find_map(fn(address) {
    case address.postal_code {
      None -> Error(Nil)
      Some(zip) -> Ok(zip)
    }
  })
  // might have multiple zip codes but whatever
}

// could sort by rank but again, whatever
pub fn first_phone(patient: resources.UsCorePatient) {
  patient.telecom
  |> list.find_map(fn(telecom) {
    case telecom.system {
      valuesets.ContactpointsystemPhone -> Ok(telecom.value)
      _ -> Error(Nil)
    }
  })
}

pub fn birth_date(patient: resources.UsCorePatient) {
  case patient.birth_date {
    None -> Error(Nil)
    // mary insists DD/MM/YYYY is right
    // but I will not give up on RFC3339,
    // which lexicographically sorts dates,
    // until more people complain
    Some(birth_date) -> Ok(pt.date_to_string(birth_date))
  }
}

pub fn mrn(patient: resources.UsCorePatient) {
  identifier_value_by_system_code(
    patient,
    "http://terminology.hl7.org/CodeSystem/v2-0203",
    "MR",
  )
}

pub fn ssn(patient: resources.UsCorePatient) {
  identifier_value_by_system_code(
    patient,
    "http://terminology.hl7.org/CodeSystem/v2-0203",
    "SS",
  )
}

pub fn identifier_value_by_system_code(
  patient: resources.UsCorePatient,
  find_system system: String,
  find_code code: String,
) {
  let identifiers = [patient.identifier.first, ..patient.identifier.rest]
  list.find_map(identifiers, fn(identifier) {
    case identifier.type_ {
      None -> Error(Nil)
      Some(type_) ->
        case
          has_system_code(
            one_of: type_.coding,
            has_system: system,
            and_code: code,
          )
        {
          True -> Ok(identifier.value)
          False -> Error(Nil)
        }
    }
  })
}

pub fn has_system_code(
  one_of codings: List(ct.Coding),
  has_system system: String,
  and_code code: String,
) {
  case
    list.find(codings, fn(coding) {
      coding.system == Some(system) && coding.code == Some(code)
    })
  {
    Ok(_) -> True
    Error(_) -> False
  }
}
// // for finding multiple systems there are definitely more efficient ways
// // than list.find one by one
// // but whatever
// pub fn identifier_string_by_system(
//   identifiers: List(ct.Identifier),
//   system: String,
// ) {
//   identifier_value_by_system(identifiers, system) |> result.unwrap("")
// }
//
// pub fn identifier_value_by_system(
//   identifiers: List(ct.Identifier),
//   system: String,
// ) {
//   case
//     list.find(identifiers, fn(identifier) { identifier.system == Some(system) })
//   {
//     Error(_) -> Error(Nil)
//     Ok(identifier) ->
//       case identifier.value {
//         None -> Error(Nil)
//         Some(value) -> Ok(value)
//       }
//   }
// }
