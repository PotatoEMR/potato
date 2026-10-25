////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) r4 search params

import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/uri

pub fn to_string(params: List(#(String, Option(String)))) -> String {
  list.fold(
    from: [],
    over: params,
    with: fn(acc, param: #(String, Option(String))) {
      case param.1 {
        None -> acc
        Some(p) -> [#(param.0, p), ..acc]
      }
    },
  )
  |> list.reverse
  |> uri.query_to_string
}

pub type Bundle {
  Bundle(
    identifier: Option(String),
    composition: Option(String),
    type_: Option(String),
    message: Option(String),
    timestamp: Option(String),
  )
}

pub type Operationoutcome {
  Operationoutcome
}

pub type Patient {
  Patient(
    identifier: Option(String),
    given: Option(String),
    address: Option(String),
    birthdate: Option(String),
    deceased: Option(String),
    address_state: Option(String),
    gender: Option(String),
    general_practitioner: Option(String),
    link: Option(String),
    active: Option(String),
    language: Option(String),
    address_postalcode: Option(String),
    address_country: Option(String),
    death_date: Option(String),
    phonetic: Option(String),
    phone: Option(String),
    organization: Option(String),
    name: Option(String),
    address_use: Option(String),
    telecom: Option(String),
    family: Option(String),
    address_city: Option(String),
    email: Option(String),
  )
}

pub fn bundle_new() -> Bundle {
  Bundle(None, None, None, None, None)
}

pub fn operationoutcome_new() -> Operationoutcome {
  Operationoutcome
}

pub fn patient_new() -> Patient {
  Patient(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}
