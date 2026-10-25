////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) complex types

import gleam/dynamic/decode.{type Decoder}
import gleam/json.{type Json}
import gleam/option.{type Option, None, Some}

pub fn decode_optional_string(
  name: String,
  next: fn(Option(String)) -> Decoder(a),
) -> Decoder(a) {
  decode.optional_field(name, None, decode.optional(decode.string), next)
}

pub type List1(a) {
  List1(first: a, rest: List(a))
}

pub fn list1_to_json(l: List1(a), to_json: fn(a) -> Json) -> Json {
  json.array([l.first, ..l.rest], to_json)
}

pub fn list1_decoder(
  name: String,
  inner: decode.Decoder(a),
  next: fn(List1(a)) -> decode.Decoder(b),
) -> decode.Decoder(b) {
  use items <- decode.field(name, decode.list(inner))
  case items {
    [first, ..rest] -> next(List1(first:, rest:))
    _ -> {
      use fail_decode_to_satisfy_gleam_type <- decode.field(name, inner)
      next(List1(first: fail_decode_to_satisfy_gleam_type, rest: []))
    }
  }
}

pub type HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod {
  HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod(
    family: String,
    given: List(String),
    text: Option(String),
  )
}

pub fn humanname_required_family_omit_id_extension_use_prefix_suffix_period_new(
  family family: String,
) -> HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod {
  HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod(
    family:,
    given: [],
    text: None,
  )
}

pub fn humanname_required_family_omit_id_extension_use_prefix_suffix_period_decoder() -> Decoder(
  HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod,
) {
  use <- decode.recursive
  use decoded_family <- decode.field("family", decode.string)
  use decoded_given <- decode.optional_field(
    "given",
    [],
    decode.list(decode.string),
  )
  use decoded_text <- decode_optional_string("text")
  decode.success(HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod(
    family: decoded_family,
    given: decoded_given,
    text: decoded_text,
  ))
}

pub fn humanname_required_family_omit_id_extension_use_prefix_suffix_period_to_json(
  source: HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod,
) -> Json {
  let fields = []
  let value = source.family
  let fields = [#("family", json.string(value)), ..fields]
  let fields = case source.given {
    [] -> fields
    values -> [
      #("given", json.array(values, fn(value) { json.string(value) })),
      ..fields
    ]
  }
  let fields = case source.text {
    Some(value) -> [#("text", json.string(value)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner {
  IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner(
    system: String,
    value: String,
  )
}

pub fn identifier_required_system_value_omit_id_extension_use_type_period_assigner_new(
  system system: String,
  value value: String,
) -> IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner {
  IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner(
    system:,
    value:,
  )
}

pub fn identifier_required_system_value_omit_id_extension_use_type_period_assigner_decoder() -> Decoder(
  IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner,
) {
  use <- decode.recursive
  use decoded_system <- decode.field("system", decode.string)
  use decoded_value <- decode.field("value", decode.string)
  decode.success(
    IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner(
      system: decoded_system,
      value: decoded_value,
    ),
  )
}

pub fn identifier_required_system_value_omit_id_extension_use_type_period_assigner_to_json(
  source: IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner,
) -> Json {
  let fields = []
  let value = source.system
  let fields = [#("system", json.string(value)), ..fields]
  let value = source.value
  let fields = [#("value", json.string(value)), ..fields]
  json.object(fields)
}
