////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) complex types

import fhir/potato_client_1_0_0/primitive_types.{
  type DateTime, type Instant, type Time,
} as pt
import fhir/potato_client_1_0_0/valuesets
import gleam/bool
import gleam/dynamic/decode.{type Decoder}
import gleam/int
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result

pub fn decode_optional_string(
  name: String,
  next: fn(Option(String)) -> Decoder(a),
) -> Decoder(a) {
  decode.optional_field(name, None, decode.optional(decode.string), next)
}

pub fn decode_optional_bool(
  name: String,
  next: fn(Option(Bool)) -> Decoder(a),
) -> Decoder(a) {
  decode.optional_field(name, None, decode.optional(decode.bool), next)
}

pub type List1(a) {
  List1(first: a, rest: List(a))
}

pub fn list1_to_json(l: List1(a), tj: fn(a) -> Json) {
  json.array([l.first, ..l.rest], tj)
}

pub fn list1_decoder(
  name: String,
  inner: decode.Decoder(a),
  next: fn(List1(a)) -> decode.Decoder(b),
) -> decode.Decoder(b) {
  use lst <- decode.field(name, decode.list(inner))
  case lst {
    [first, ..rest] -> next(List1(first:, rest:))
    _ -> {
      use fail_decode_to_satisfy_gleam_type <- decode.field(name, inner)
      next(List1(first: fail_decode_to_satisfy_gleam_type, rest: []))
    }
  }
}

pub fn none_if_omitted(d: decode.Decoder(a)) -> decode.Decoder(Option(a)) {
  decode.one_of(d |> decode.map(Some), [decode.success(None)])
}

//std lib decode.float will NOT decode numbers without decimal point eg 4, only 4.0
pub fn decode_number() {
  decode.one_of(decode.float, [decode.map(decode.int, int.to_float)])
}

// Primitive and PrimitiveExtPart are used for decoding JSON
// but generic primitive extensions are NOT supported;
// the only supported primitive extensions are when profiles define them
// in which case they are generated as actual types
// for example
// pub type UsCoreQuestionnaireresponseQuestionnaire {
//   UsCoreQuestionnaireresponseQuestionnaire(
//     id: Option(String),
//     extension: List(ct.Extension),
//     questionnaire_display: Option(String),
//     url: Option(String),
//     value: Option(String),
//   )
// }
// so a user should never do anything with the Primitive type
pub fn optional_one_from_array_decoder(
  name: String,
  inner: decode.Decoder(a),
  next: fn(Option(a)) -> decode.Decoder(b),
) -> decode.Decoder(b) {
  use values <- decode.optional_field(name, [], decode.list(inner))
  case values {
    [] -> next(None)
    [value] -> next(Some(value))
    _ -> {
      use impossible_value <- decode.field(name, inner)
      next(Some(impossible_value))
    }
  }
}

pub type DiscriminatorMatch {
  DiscriminatorMatches
  DiscriminatorDifferent
}

pub type AttachmentOmitExtension {
  AttachmentOmitExtension(
    content_type: Option(String),
    creation: Option(DateTime),
    data: Option(String),
    hash: Option(String),
    id: Option(String),
    language: Option(String),
    size: Option(Int),
    title: Option(String),
    url: Option(String),
  )
}

pub fn attachment_omit_extension_new() -> AttachmentOmitExtension {
  AttachmentOmitExtension(
    content_type: None,
    creation: None,
    data: None,
    hash: None,
    id: None,
    language: None,
    size: None,
    title: None,
    url: None,
  )
}

pub fn attachment_omit_extension_decoder() -> Decoder(AttachmentOmitExtension) {
  use <- decode.recursive
  use decoded_content_type <- decode_optional_string("contentType")
  use decoded_creation <- decode.optional_field(
    "creation",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use decoded_data <- decode_optional_string("data")
  use decoded_hash <- decode_optional_string("hash")
  use decoded_id <- decode_optional_string("id")
  use decoded_language <- decode_optional_string("language")
  use decoded_size <- decode.optional_field(
    "size",
    None,
    decode.optional(decode.int),
  )
  use decoded_title <- decode_optional_string("title")
  use decoded_url <- decode_optional_string("url")
  decode.success(AttachmentOmitExtension(
    content_type: decoded_content_type,
    creation: decoded_creation,
    data: decoded_data,
    hash: decoded_hash,
    id: decoded_id,
    language: decoded_language,
    size: decoded_size,
    title: decoded_title,
    url: decoded_url,
  ))
}

pub fn attachment_omit_extension_to_json(
  source: AttachmentOmitExtension,
) -> Json {
  let fields = []
  let fields = case source.content_type {
    Some(value) -> [#("contentType", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.creation {
    Some(value) -> [#("creation", pt.datetime_to_json(value)), ..fields]
    None -> fields
  }
  let fields = case source.data {
    Some(value) -> [#("data", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.hash {
    Some(value) -> [#("hash", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.id {
    Some(value) -> [#("id", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.language {
    Some(value) -> [#("language", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.size {
    Some(value) -> [#("size", json.int(value)), ..fields]
    None -> fields
  }
  let fields = case source.title {
    Some(value) -> [#("title", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.url {
    Some(value) -> [#("url", json.string(value)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodingOmitExtension {
  CodingOmitExtension(
    code: Option(String),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn coding_omit_extension_new() -> CodingOmitExtension {
  CodingOmitExtension(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn coding_omit_extension_decoder() -> Decoder(CodingOmitExtension) {
  use <- decode.recursive
  use decoded_code <- decode_optional_string("code")
  use decoded_display <- decode_optional_string("display")
  use decoded_id <- decode_optional_string("id")
  use decoded_system <- decode_optional_string("system")
  use decoded_user_selected <- decode_optional_bool("userSelected")
  use decoded_version <- decode_optional_string("version")
  decode.success(CodingOmitExtension(
    code: decoded_code,
    display: decoded_display,
    id: decoded_id,
    system: decoded_system,
    user_selected: decoded_user_selected,
    version: decoded_version,
  ))
}

pub fn coding_omit_extension_to_json(source: CodingOmitExtension) -> Json {
  let fields = []
  let fields = case source.code {
    Some(value) -> [#("code", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.display {
    Some(value) -> [#("display", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.id {
    Some(value) -> [#("id", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.system {
    Some(value) -> [#("system", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.user_selected {
    Some(value) -> [#("userSelected", json.bool(value)), ..fields]
    None -> fields
  }
  let fields = case source.version {
    Some(value) -> [#("version", json.string(value)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type PeriodOmitExtension {
  PeriodOmitExtension(
    end: Option(DateTime),
    id: Option(String),
    start: Option(DateTime),
  )
}

pub fn period_omit_extension_new() -> PeriodOmitExtension {
  PeriodOmitExtension(end: None, id: None, start: None)
}

pub fn period_omit_extension_decoder() -> Decoder(PeriodOmitExtension) {
  use <- decode.recursive
  use decoded_end <- decode.optional_field(
    "end",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use decoded_id <- decode_optional_string("id")
  use decoded_start <- decode.optional_field(
    "start",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  decode.success(PeriodOmitExtension(
    end: decoded_end,
    id: decoded_id,
    start: decoded_start,
  ))
}

pub fn period_omit_extension_to_json(source: PeriodOmitExtension) -> Json {
  let fields = []
  let fields = case source.end {
    Some(value) -> [#("end", pt.datetime_to_json(value)), ..fields]
    None -> fields
  }
  let fields = case source.id {
    Some(value) -> [#("id", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.start {
    Some(value) -> [#("start", pt.datetime_to_json(value)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type QuantityOmitExtensionComparator {
  QuantityOmitExtensionComparator(
    code: Option(String),
    id: Option(String),
    system: Option(String),
    unit: Option(String),
    value: Option(Float),
  )
}

pub fn quantity_omit_extension_comparator_new() -> QuantityOmitExtensionComparator {
  QuantityOmitExtensionComparator(
    code: None,
    id: None,
    system: None,
    unit: None,
    value: None,
  )
}

pub fn quantity_omit_extension_comparator_decoder() -> Decoder(
  QuantityOmitExtensionComparator,
) {
  use <- decode.recursive
  use decoded_code <- decode_optional_string("code")
  use decoded_id <- decode_optional_string("id")
  use decoded_system <- decode_optional_string("system")
  use decoded_unit <- decode_optional_string("unit")
  use decoded_value <- decode.optional_field(
    "value",
    None,
    decode.optional(decode_number()),
  )
  decode.success(QuantityOmitExtensionComparator(
    code: decoded_code,
    id: decoded_id,
    system: decoded_system,
    unit: decoded_unit,
    value: decoded_value,
  ))
}

pub fn quantity_omit_extension_comparator_to_json(
  source: QuantityOmitExtensionComparator,
) -> Json {
  let fields = []
  let fields = case source.code {
    Some(value) -> [#("code", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.id {
    Some(value) -> [#("id", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.system {
    Some(value) -> [#("system", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.unit {
    Some(value) -> [#("unit", json.string(value)), ..fields]
    None -> fields
  }
  let fields = case source.value {
    Some(value) -> [#("value", json.float(value)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoethnicity {
  Potatoethnicity(
    text: String,
    detailed: List(CodingPotatoethnicityExtensionDetailedValue),
    omb_category: Option(CodingPotatoethnicityExtensionOmbcategoryValue),
  )
}

pub fn potatoethnicity_new(text text: String) -> Potatoethnicity {
  Potatoethnicity(text:, detailed: [], omb_category: None)
}

pub fn potatoethnicity_to_json(value: Potatoethnicity, url: String) -> Json {
  let children = []
  let children = [
    json.object([
      #("url", json.string("text")),
      #("valueString", json.string(value.text)),
    ]),
    ..children
  ]
  let children =
    list.append(
      list.map(value.detailed, fn(value) {
        json.object([
          #("url", json.string("detailed")),
          #(
            "valueCoding",
            coding_potatoethnicity_extension_detailed_value_to_json(value),
          ),
        ])
      }),
      children,
    )
  let children = case value.omb_category {
    Some(value) -> [
      json.object([
        #("url", json.string("ombCategory")),
        #(
          "valueCoding",
          coding_potatoethnicity_extension_ombcategory_value_to_json(value),
        ),
      ]),
      ..children
    ]
    None -> children
  }
  json.object([
    #("url", json.string(url)),
    #("extension", json.preprocessed_array(children)),
  ])
}

pub type Potatomedicationadherence {
  Potatomedicationadherence(
    information_source: List(Potatocodeableconcept),
    date_asserted: DateTime,
    medication_adherence: Potatocodeableconcept,
  )
}

pub fn potatomedicationadherence_new(
  date_asserted date_asserted: DateTime,
  medication_adherence medication_adherence: Potatocodeableconcept,
) -> Potatomedicationadherence {
  Potatomedicationadherence(
    information_source: [],
    date_asserted:,
    medication_adherence:,
  )
}

pub fn potatomedicationadherence_to_json(
  value: Potatomedicationadherence,
  url: String,
) -> Json {
  let children = []
  let children =
    list.append(
      list.map(value.information_source, fn(value) {
        json.object([
          #("url", json.string("informationSource")),
          #("valueCodeableConcept", potatocodeableconcept_to_json(value)),
        ])
      }),
      children,
    )
  let children = [
    json.object([
      #("url", json.string("dateAsserted")),
      #("valueDateTime", pt.datetime_to_json(value.date_asserted)),
    ]),
    ..children
  ]
  let children = [
    json.object([
      #("url", json.string("medicationAdherence")),
      #(
        "valueCodeableConcept",
        potatocodeableconcept_to_json(value.medication_adherence),
      ),
    ]),
    ..children
  ]
  json.object([
    #("url", json.string(url)),
    #("extension", json.preprocessed_array(children)),
  ])
}

pub type Potatorace {
  Potatorace(
    text: String,
    detailed: List(CodingPotatoraceExtensionDetailedValue),
    // TODO enforce max somehow
    omb_category: List(CodingPotatoraceExtensionOmbcategoryValue),
  )
}

pub fn potatorace_new(text text: String) -> Potatorace {
  Potatorace(text:, detailed: [], omb_category: [])
}

pub fn potatorace_to_json(value: Potatorace, url: String) -> Json {
  let children = []
  let children = [
    json.object([
      #("url", json.string("text")),
      #("valueString", json.string(value.text)),
    ]),
    ..children
  ]
  let children =
    list.append(
      list.map(value.detailed, fn(value) {
        json.object([
          #("url", json.string("detailed")),
          #(
            "valueCoding",
            coding_potatorace_extension_detailed_value_to_json(value),
          ),
        ])
      }),
      children,
    )
  let children =
    list.append(
      list.map(value.omb_category, fn(value) {
        json.object([
          #("url", json.string("ombCategory")),
          #(
            "valueCoding",
            coding_potatorace_extension_ombcategory_value_to_json(value),
          ),
        ])
      }),
      children,
    )
  json.object([
    #("url", json.string(url)),
    #("extension", json.preprocessed_array(children)),
  ])
}

pub type Potatotribalaffiliation {
  Potatotribalaffiliation(
    is_enrolled: Option(Bool),
    tribal_affiliation: Potatocodeableconcept,
  )
}

pub fn potatotribalaffiliation_new(
  tribal_affiliation tribal_affiliation: Potatocodeableconcept,
) -> Potatotribalaffiliation {
  Potatotribalaffiliation(is_enrolled: None, tribal_affiliation:)
}

pub fn potatotribalaffiliation_to_json(
  value: Potatotribalaffiliation,
  url: String,
) -> Json {
  let children = []
  let children = case value.is_enrolled {
    Some(value) -> [
      json.object([
        #("url", json.string("isEnrolled")),
        #("valueBoolean", json.bool(value)),
      ]),
      ..children
    ]
    None -> children
  }
  let children = [
    json.object([
      #("url", json.string("tribalAffiliation")),
      #(
        "valueCodeableConcept",
        potatocodeableconcept_to_json(value.tribal_affiliation),
      ),
    ]),
    ..children
  ]
  json.object([
    #("url", json.string(url)),
    #("extension", json.preprocessed_array(children)),
  ])
}

pub type Potatoaddress {
  Potatoaddress(
    city: Option(String),
    country: Option(String),
    district: Option(String),
    id: Option(String),
    line: List(String),
    period: Option(Potatoperiod),
    postal_code: Option(String),
    state: Option(String),
    text: Option(String),
    type_: Option(valuesets.Addresstype),
    use_: Option(valuesets.Addressuse),
  )
}

pub fn potatoaddress_new() -> Potatoaddress {
  Potatoaddress(
    city: None,
    country: None,
    district: None,
    id: None,
    line: [],
    period: None,
    postal_code: None,
    state: None,
    text: None,
    type_: None,
    use_: None,
  )
}

pub fn potatoaddress_to_json(potatoaddress: Potatoaddress) -> Json {
  let fields = []
  let fields = case potatoaddress.use_ {
    Some(v) -> [#("use", valuesets.addressuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.type_ {
    Some(v) -> [#("type", valuesets.addresstype_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.state {
    Some(v) -> [#("state", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.postal_code {
    Some(v) -> [#("postalCode", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.period {
    Some(v) -> [#("period", potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.line {
    [] -> fields
    values -> [#("line", json.array(values, json.string)), ..fields]
  }
  let fields = case potatoaddress.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.district {
    Some(v) -> [#("district", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.country {
    Some(v) -> [#("country", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoaddress.city {
    Some(v) -> [#("city", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoage {
  Potatoage(
    code: Option(String),
    comparator: Option(valuesets.Quantitycomparator),
    id: Option(String),
    system: Option(String),
    unit: Option(String),
    value: Option(Float),
  )
}

pub fn potatoage_new() -> Potatoage {
  Potatoage(
    code: None,
    comparator: None,
    id: None,
    system: None,
    unit: None,
    value: None,
  )
}

pub fn potatoage_to_json(potatoage: Potatoage) -> Json {
  let fields = []
  let fields = case potatoage.value {
    Some(v) -> [#("value", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatoage.unit {
    Some(v) -> [#("unit", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoage.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoage.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoage.comparator {
    Some(v) -> [
      #("comparator", valuesets.quantitycomparator_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoage.code {
    Some(v) -> [#("code", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoannotation {
  Potatoannotation(
    author: Option(PotatoannotationAuthor),
    id: Option(String),
    text: String,
    time: Option(DateTime),
  )
}

pub fn potatoannotation_new(text text: String) -> Potatoannotation {
  Potatoannotation(author: None, id: None, text:, time: None)
}

pub type PotatoannotationAuthor {
  PotatoannotationAuthorReference(value: Potatoreference)
  PotatoannotationAuthorString(value: String)
}

pub fn potatoannotation_to_json(potatoannotation: Potatoannotation) -> Json {
  let fields = [
    #("text", json.string(potatoannotation.text)),
  ]
  let fields = case potatoannotation.time {
    Some(v) -> [#("time", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoannotation.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoannotation.author {
    Some(v) -> [
      #(
        "author"
          <> case v {
          PotatoannotationAuthorReference(_) -> "Reference"
          PotatoannotationAuthorString(_) -> "String"
        },
        potatoannotation_author_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoannotation_author_to_json(value: PotatoannotationAuthor) -> Json {
  case value {
    PotatoannotationAuthorReference(value) -> potatoreference_to_json(value)
    PotatoannotationAuthorString(value) -> json.string(value)
  }
}

pub type Potatoattachment {
  Potatoattachment(
    content_type: Option(String),
    creation: Option(DateTime),
    data: Option(String),
    hash: Option(String),
    id: Option(String),
    language: Option(String),
    size: Option(Int),
    title: Option(String),
    url: Option(String),
  )
}

pub fn potatoattachment_new() -> Potatoattachment {
  Potatoattachment(
    content_type: None,
    creation: None,
    data: None,
    hash: None,
    id: None,
    language: None,
    size: None,
    title: None,
    url: None,
  )
}

pub fn potatoattachment_to_json(potatoattachment: Potatoattachment) -> Json {
  let fields = []
  let fields = case potatoattachment.url {
    Some(v) -> [#("url", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.title {
    Some(v) -> [#("title", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.size {
    Some(v) -> [#("size", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.hash {
    Some(v) -> [#("hash", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.data {
    Some(v) -> [#("data", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.creation {
    Some(v) -> [#("creation", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoattachment.content_type {
    Some(v) -> [#("contentType", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatocodeableconcept {
  Potatocodeableconcept(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn potatocodeableconcept_new() -> Potatocodeableconcept {
  Potatocodeableconcept(coding: [], id: None, text: None)
}

pub fn potatocodeableconcept_to_json(
  potatocodeableconcept: Potatocodeableconcept,
) -> Json {
  let fields = []
  let fields = case potatocodeableconcept.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocodeableconcept.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocodeableconcept.coding {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub type Potatocoding {
  Potatocoding(
    code: Option(String),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn potatocoding_new() -> Potatocoding {
  Potatocoding(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn potatocoding_to_json(potatocoding: Potatocoding) -> Json {
  let fields = []
  let fields = case potatocoding.version {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocoding.user_selected {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potatocoding.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocoding.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocoding.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocoding.code {
    Some(v) -> [#("code", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatocontactpoint {
  Potatocontactpoint(
    id: Option(String),
    period: Option(Potatoperiod),
    rank: Option(Int),
    system: Option(valuesets.Contactpointsystem),
    use_: Option(valuesets.Contactpointuse),
    value: Option(String),
  )
}

pub fn potatocontactpoint_new() -> Potatocontactpoint {
  Potatocontactpoint(
    id: None,
    period: None,
    rank: None,
    system: None,
    use_: None,
    value: None,
  )
}

pub fn potatocontactpoint_to_json(
  potatocontactpoint: Potatocontactpoint,
) -> Json {
  let fields = []
  let fields = case potatocontactpoint.value {
    Some(v) -> [#("value", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocontactpoint.use_ {
    Some(v) -> [#("use", valuesets.contactpointuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocontactpoint.system {
    Some(v) -> [#("system", valuesets.contactpointsystem_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocontactpoint.rank {
    Some(v) -> [#("rank", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatocontactpoint.period {
    Some(v) -> [#("period", potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocontactpoint.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatodosage {
  Potatodosage(
    additional_instruction: List(Potatocodeableconcept),
    as_needed: Option(PotatodosageAsneeded),
    dose_and_rate: List(PotatodosageDoseandrate),
    id: Option(String),
    max_dose_per_administration: Option(Potatosimplequantity),
    max_dose_per_lifetime: Option(Potatosimplequantity),
    max_dose_per_period: Option(Potatoratio),
    method: Option(Potatocodeableconcept),
    patient_instruction: Option(String),
    route: Option(Potatocodeableconcept),
    sequence: Option(Int),
    site: Option(Potatocodeableconcept),
    text: Option(String),
    timing: Option(Potatotiming),
  )
}

pub fn potatodosage_new() -> Potatodosage {
  Potatodosage(
    additional_instruction: [],
    as_needed: None,
    dose_and_rate: [],
    id: None,
    max_dose_per_administration: None,
    max_dose_per_lifetime: None,
    max_dose_per_period: None,
    method: None,
    patient_instruction: None,
    route: None,
    sequence: None,
    site: None,
    text: None,
    timing: None,
  )
}

pub type PotatodosageAsneeded {
  PotatodosageAsneededBoolean(value: Bool)
  PotatodosageAsneededCodeableconcept(value: Potatocodeableconcept)
}

pub type PotatodosageDoseandrate {
  PotatodosageDoseandrate(
    dose: Option(PotatodosageDoseandrateDose),
    id: Option(String),
    rate: Option(PotatodosageDoseandrateRate),
    type_: Option(Potatocodeableconcept),
  )
}

pub fn potatodosage_doseandrate_new() -> PotatodosageDoseandrate {
  PotatodosageDoseandrate(dose: None, id: None, rate: None, type_: None)
}

pub type PotatodosageDoseandrateRate {
  PotatodosageDoseandrateRateRatio(value: Potatoratio)
  PotatodosageDoseandrateRateRange(value: Potatorange)
  PotatodosageDoseandrateRateQuantity(value: Potatosimplequantity)
}

pub type PotatodosageDoseandrateDose {
  PotatodosageDoseandrateDoseRange(value: Potatorange)
  PotatodosageDoseandrateDoseQuantity(value: Potatosimplequantity)
}

pub fn potatodosage_to_json(potatodosage: Potatodosage) -> Json {
  let fields = []
  let fields = case potatodosage.timing {
    Some(v) -> [#("timing", potatotiming_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.site {
    Some(v) -> [#("site", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.sequence {
    Some(v) -> [#("sequence", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.route {
    Some(v) -> [#("route", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.patient_instruction {
    Some(v) -> [#("patientInstruction", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.method {
    Some(v) -> [#("method", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.max_dose_per_period {
    Some(v) -> [#("maxDosePerPeriod", potatoratio_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.max_dose_per_lifetime {
    Some(v) -> [
      #("maxDosePerLifetime", potatosimplequantity_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodosage.max_dose_per_administration {
    Some(v) -> [
      #("maxDosePerAdministration", potatosimplequantity_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodosage.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage.dose_and_rate {
    [] -> fields
    values -> [
      #("doseAndRate", json.array(values, potatodosage_doseandrate_to_json)),
      ..fields
    ]
  }
  let fields = case potatodosage.as_needed {
    Some(v) -> [
      #(
        "asNeeded"
          <> case v {
          PotatodosageAsneededBoolean(_) -> "Boolean"
          PotatodosageAsneededCodeableconcept(_) -> "CodeableConcept"
        },
        potatodosage_asneeded_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodosage.additional_instruction {
    [] -> fields
    values -> [
      #(
        "additionalInstruction",
        json.array(values, potatocodeableconcept_to_json),
      ),
      ..fields
    ]
  }
  json.object(fields)
}

pub fn potatodosage_asneeded_to_json(value: PotatodosageAsneeded) -> Json {
  case value {
    PotatodosageAsneededBoolean(value) -> json.bool(value)
    PotatodosageAsneededCodeableconcept(value) ->
      potatocodeableconcept_to_json(value)
  }
}

pub fn potatodosage_doseandrate_to_json(
  potatodosage_doseandrate: PotatodosageDoseandrate,
) -> Json {
  let fields = []
  let fields = case potatodosage_doseandrate.type_ {
    Some(v) -> [#("type", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage_doseandrate.rate {
    Some(v) -> [
      #(
        "rate"
          <> case v {
          PotatodosageDoseandrateRateRatio(_) -> "Ratio"
          PotatodosageDoseandrateRateRange(_) -> "Range"
          PotatodosageDoseandrateRateQuantity(_) -> "Quantity"
        },
        potatodosage_doseandrate_rate_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodosage_doseandrate.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodosage_doseandrate.dose {
    Some(v) -> [
      #(
        "dose"
          <> case v {
          PotatodosageDoseandrateDoseRange(_) -> "Range"
          PotatodosageDoseandrateDoseQuantity(_) -> "Quantity"
        },
        potatodosage_doseandrate_dose_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn potatodosage_doseandrate_dose_to_json(
  value: PotatodosageDoseandrateDose,
) -> Json {
  case value {
    PotatodosageDoseandrateDoseRange(value) -> potatorange_to_json(value)
    PotatodosageDoseandrateDoseQuantity(value) ->
      potatosimplequantity_to_json(value)
  }
}

pub fn potatodosage_doseandrate_rate_to_json(
  value: PotatodosageDoseandrateRate,
) -> Json {
  case value {
    PotatodosageDoseandrateRateRatio(value) -> potatoratio_to_json(value)
    PotatodosageDoseandrateRateRange(value) -> potatorange_to_json(value)
    PotatodosageDoseandrateRateQuantity(value) ->
      potatosimplequantity_to_json(value)
  }
}

pub type Potatoduration {
  Potatoduration(
    code: Option(String),
    comparator: Option(valuesets.Quantitycomparator),
    id: Option(String),
    system: Option(String),
    unit: Option(String),
    value: Option(Float),
  )
}

pub fn potatoduration_new() -> Potatoduration {
  Potatoduration(
    code: None,
    comparator: None,
    id: None,
    system: None,
    unit: None,
    value: None,
  )
}

pub fn potatoduration_to_json(potatoduration: Potatoduration) -> Json {
  let fields = []
  let fields = case potatoduration.value {
    Some(v) -> [#("value", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatoduration.unit {
    Some(v) -> [#("unit", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoduration.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoduration.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoduration.comparator {
    Some(v) -> [
      #("comparator", valuesets.quantitycomparator_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoduration.code {
    Some(v) -> [#("code", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatohumanname {
  Potatohumanname(
    family: Option(String),
    given: List(String),
    id: Option(String),
    period: Option(Potatoperiod),
    prefix: List(String),
    suffix: List(String),
    text: Option(String),
    use_: Option(valuesets.Nameuse),
  )
}

pub fn potatohumanname_new() -> Potatohumanname {
  Potatohumanname(
    family: None,
    given: [],
    id: None,
    period: None,
    prefix: [],
    suffix: [],
    text: None,
    use_: None,
  )
}

pub fn potatohumanname_to_json(potatohumanname: Potatohumanname) -> Json {
  let fields = []
  let fields = case potatohumanname.use_ {
    Some(v) -> [#("use", valuesets.nameuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatohumanname.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatohumanname.suffix {
    [] -> fields
    values -> [#("suffix", json.array(values, json.string)), ..fields]
  }
  let fields = case potatohumanname.prefix {
    [] -> fields
    values -> [#("prefix", json.array(values, json.string)), ..fields]
  }
  let fields = case potatohumanname.period {
    Some(v) -> [#("period", potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatohumanname.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatohumanname.given {
    [] -> fields
    values -> [#("given", json.array(values, json.string)), ..fields]
  }
  let fields = case potatohumanname.family {
    Some(v) -> [#("family", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoidentifier {
  Potatoidentifier(
    assigner: Option(Potatoreference),
    id: Option(String),
    period: Option(Potatoperiod),
    system: Option(String),
    type_: Option(Potatocodeableconcept),
    use_: Option(valuesets.Identifieruse),
    value: Option(String),
  )
}

pub fn potatoidentifier_new() -> Potatoidentifier {
  Potatoidentifier(
    assigner: None,
    id: None,
    period: None,
    system: None,
    type_: None,
    use_: None,
    value: None,
  )
}

pub fn potatoidentifier_to_json(potatoidentifier: Potatoidentifier) -> Json {
  let fields = []
  let fields = case potatoidentifier.value {
    Some(v) -> [#("value", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoidentifier.use_ {
    Some(v) -> [#("use", valuesets.identifieruse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoidentifier.type_ {
    Some(v) -> [#("type", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoidentifier.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoidentifier.period {
    Some(v) -> [#("period", potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoidentifier.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoidentifier.assigner {
    Some(v) -> [#("assigner", potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatometa {
  Potatometa(
    id: Option(String),
    last_updated: Option(Instant),
    profile: List(String),
    security: List(Potatocoding),
    source: Option(String),
    tag: List(Potatocoding),
    version_id: Option(String),
  )
}

pub fn potatometa_new() -> Potatometa {
  Potatometa(
    id: None,
    last_updated: None,
    profile: [],
    security: [],
    source: None,
    tag: [],
    version_id: None,
  )
}

pub fn potatometa_to_json(potatometa: Potatometa) -> Json {
  let fields = []
  let fields = case potatometa.version_id {
    Some(v) -> [#("versionId", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatometa.tag {
    [] -> fields
    values -> [#("tag", json.array(values, potatocoding_to_json)), ..fields]
  }
  let fields = case potatometa.source {
    Some(v) -> [#("source", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatometa.security {
    [] -> fields
    values -> [
      #("security", json.array(values, potatocoding_to_json)),
      ..fields
    ]
  }
  let fields = case potatometa.profile {
    [] -> fields
    values -> [#("profile", json.array(values, json.string)), ..fields]
  }
  let fields = case potatometa.last_updated {
    Some(v) -> [#("lastUpdated", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatometa.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatonarrative {
  Potatonarrative(
    div: String,
    id: Option(String),
    status: valuesets.Narrativestatus,
  )
}

pub fn potatonarrative_new(
  div div: String,
  status status: valuesets.Narrativestatus,
) -> Potatonarrative {
  Potatonarrative(div:, id: None, status:)
}

pub fn potatonarrative_to_json(potatonarrative: Potatonarrative) -> Json {
  let fields = [
    #("status", valuesets.narrativestatus_to_json(potatonarrative.status)),
    #("div", json.string(potatonarrative.div)),
  ]
  let fields = case potatonarrative.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoperiod {
  Potatoperiod(
    end: Option(DateTime),
    id: Option(String),
    start: Option(DateTime),
  )
}

pub fn potatoperiod_new() -> Potatoperiod {
  Potatoperiod(end: None, id: None, start: None)
}

pub fn potatoperiod_to_json(potatoperiod: Potatoperiod) -> Json {
  let fields = []
  let fields = case potatoperiod.start {
    Some(v) -> [#("start", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoperiod.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoperiod.end {
    Some(v) -> [#("end", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoquantity {
  Potatoquantity(
    code: Option(String),
    comparator: Option(valuesets.Quantitycomparator),
    id: Option(String),
    system: Option(String),
    unit: Option(String),
    value: Option(Float),
  )
}

pub fn potatoquantity_new() -> Potatoquantity {
  Potatoquantity(
    code: None,
    comparator: None,
    id: None,
    system: None,
    unit: None,
    value: None,
  )
}

pub fn potatoquantity_to_json(potatoquantity: Potatoquantity) -> Json {
  let fields = []
  let fields = case potatoquantity.value {
    Some(v) -> [#("value", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatoquantity.unit {
    Some(v) -> [#("unit", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoquantity.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoquantity.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoquantity.comparator {
    Some(v) -> [
      #("comparator", valuesets.quantitycomparator_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoquantity.code {
    Some(v) -> [#("code", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatorange {
  Potatorange(
    high: Option(Potatosimplequantity),
    id: Option(String),
    low: Option(Potatosimplequantity),
  )
}

pub fn potatorange_new() -> Potatorange {
  Potatorange(high: None, id: None, low: None)
}

pub fn potatorange_to_json(potatorange: Potatorange) -> Json {
  let fields = []
  let fields = case potatorange.low {
    Some(v) -> [#("low", potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatorange.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatorange.high {
    Some(v) -> [#("high", potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoratio {
  Potatoratio(
    denominator: Option(Potatoquantity),
    id: Option(String),
    numerator: Option(Potatoquantity),
  )
}

pub fn potatoratio_new() -> Potatoratio {
  Potatoratio(denominator: None, id: None, numerator: None)
}

pub fn potatoratio_to_json(potatoratio: Potatoratio) -> Json {
  let fields = []
  let fields = case potatoratio.numerator {
    Some(v) -> [#("numerator", potatoquantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoratio.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoratio.denominator {
    Some(v) -> [#("denominator", potatoquantity_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoreference {
  Potatoreference(
    display: Option(String),
    id: Option(String),
    identifier: Option(Potatoidentifier),
    reference: Option(String),
    type_: Option(String),
  )
}

pub fn potatoreference_new() -> Potatoreference {
  Potatoreference(
    display: None,
    id: None,
    identifier: None,
    reference: None,
    type_: None,
  )
}

pub fn potatoreference_to_json(potatoreference: Potatoreference) -> Json {
  let fields = []
  let fields = case potatoreference.type_ {
    Some(v) -> [#("type", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoreference.reference {
    Some(v) -> [#("reference", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoreference.identifier {
    Some(v) -> [#("identifier", potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoreference.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoreference.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatosimplequantity {
  Potatosimplequantity(
    code: Option(String),
    id: Option(String),
    system: Option(String),
    unit: Option(String),
    value: Option(Float),
  )
}

pub fn potatosimplequantity_new() -> Potatosimplequantity {
  Potatosimplequantity(
    code: None,
    id: None,
    system: None,
    unit: None,
    value: None,
  )
}

pub fn potatosimplequantity_to_json(
  potatosimplequantity: Potatosimplequantity,
) -> Json {
  let fields = []
  let fields = case potatosimplequantity.value {
    Some(v) -> [#("value", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatosimplequantity.unit {
    Some(v) -> [#("unit", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatosimplequantity.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatosimplequantity.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatosimplequantity.code {
    Some(v) -> [#("code", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatotiming {
  Potatotiming(
    code: Option(Potatocodeableconcept),
    event: List(DateTime),
    id: Option(String),
    repeat: Option(PotatotimingRepeat),
  )
}

pub fn potatotiming_new() -> Potatotiming {
  Potatotiming(code: None, event: [], id: None, repeat: None)
}

pub type PotatotimingRepeat {
  PotatotimingRepeat(
    bounds: Option(PotatotimingRepeatBounds),
    count: Option(Int),
    count_max: Option(Int),
    day_of_week: List(valuesets.Daysofweek),
    duration: Option(Float),
    duration_max: Option(Float),
    duration_unit: Option(valuesets.Unitsoftime),
    frequency: Option(Int),
    frequency_max: Option(Int),
    id: Option(String),
    offset: Option(Int),
    period: Option(Float),
    period_max: Option(Float),
    period_unit: Option(valuesets.Unitsoftime),
    time_of_day: List(Time),
    when: List(valuesets.Eventtiming),
  )
}

pub fn potatotiming_repeat_new() -> PotatotimingRepeat {
  PotatotimingRepeat(
    bounds: None,
    count: None,
    count_max: None,
    day_of_week: [],
    duration: None,
    duration_max: None,
    duration_unit: None,
    frequency: None,
    frequency_max: None,
    id: None,
    offset: None,
    period: None,
    period_max: None,
    period_unit: None,
    time_of_day: [],
    when: [],
  )
}

pub type PotatotimingRepeatBounds {
  PotatotimingRepeatBoundsDuration(value: Potatoduration)
  PotatotimingRepeatBoundsRange(value: Potatorange)
  PotatotimingRepeatBoundsPeriod(value: Potatoperiod)
}

pub fn potatotiming_to_json(potatotiming: Potatotiming) -> Json {
  let fields = []
  let fields = case potatotiming.repeat {
    Some(v) -> [#("repeat", potatotiming_repeat_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming.event {
    [] -> fields
    values -> [#("event", json.array(values, pt.datetime_to_json)), ..fields]
  }
  let fields = case potatotiming.code {
    Some(v) -> [#("code", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatotiming_repeat_to_json(
  potatotiming_repeat: PotatotimingRepeat,
) -> Json {
  let fields = []
  let fields = case potatotiming_repeat.when {
    [] -> fields
    values -> [
      #("when", json.array(values, valuesets.eventtiming_to_json)),
      ..fields
    ]
  }
  let fields = case potatotiming_repeat.time_of_day {
    [] -> fields
    values -> [#("timeOfDay", json.array(values, pt.time_to_json)), ..fields]
  }
  let fields = case potatotiming_repeat.period_unit {
    Some(v) -> [#("periodUnit", valuesets.unitsoftime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.period_max {
    Some(v) -> [#("periodMax", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.period {
    Some(v) -> [#("period", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.offset {
    Some(v) -> [#("offset", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.frequency_max {
    Some(v) -> [#("frequencyMax", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.frequency {
    Some(v) -> [#("frequency", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.duration_unit {
    Some(v) -> [#("durationUnit", valuesets.unitsoftime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.duration_max {
    Some(v) -> [#("durationMax", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.duration {
    Some(v) -> [#("duration", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.day_of_week {
    [] -> fields
    values -> [
      #("dayOfWeek", json.array(values, valuesets.daysofweek_to_json)),
      ..fields
    ]
  }
  let fields = case potatotiming_repeat.count_max {
    Some(v) -> [#("countMax", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.count {
    Some(v) -> [#("count", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatotiming_repeat.bounds {
    Some(v) -> [
      #(
        "bounds"
          <> case v {
          PotatotimingRepeatBoundsDuration(_) -> "Duration"
          PotatotimingRepeatBoundsRange(_) -> "Range"
          PotatotimingRepeatBoundsPeriod(_) -> "Period"
        },
        potatotiming_repeat_bounds_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn potatotiming_repeat_bounds_to_json(
  value: PotatotimingRepeatBounds,
) -> Json {
  case value {
    PotatotimingRepeatBoundsDuration(value) -> potatoduration_to_json(value)
    PotatotimingRepeatBoundsRange(value) -> potatorange_to_json(value)
    PotatotimingRepeatBoundsPeriod(value) -> potatoperiod_to_json(value)
  }
}

pub type AddressPotatopatientAddress {
  AddressPotatopatientAddress(
    city: Option(String),
    country: Option(String),
    district: Option(String),
    id: Option(String),
    line: List(String),
    period: Option(PeriodOmitExtension),
    postal_code: Option(String),
    state: Option(String),
    text: Option(String),
    type_: Option(valuesets.Addresstype),
    use_: Option(valuesets.Addressuse),
  )
}

pub fn address_potatopatient_address_new() -> AddressPotatopatientAddress {
  AddressPotatopatientAddress(
    city: None,
    country: None,
    district: None,
    id: None,
    line: [],
    period: None,
    postal_code: None,
    state: None,
    text: None,
    type_: None,
    use_: None,
  )
}

pub fn address_potatopatient_address_to_json(
  address_potatopatient_address: AddressPotatopatientAddress,
) -> Json {
  let fields = []
  let fields = case address_potatopatient_address.use_ {
    Some(v) -> [#("use", valuesets.addressuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.type_ {
    Some(v) -> [#("type", valuesets.addresstype_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.state {
    Some(v) -> [#("state", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.postal_code {
    Some(v) -> [#("postalCode", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.period {
    Some(v) -> [#("period", period_omit_extension_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.line {
    [] -> fields
    values -> [#("line", json.array(values, json.string)), ..fields]
  }
  let fields = case address_potatopatient_address.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.district {
    Some(v) -> [#("district", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.country {
    Some(v) -> [#("country", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case address_potatopatient_address.city {
    Some(v) -> [#("city", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatoallergyintoleranceClinicalstatus {
  CodeableconceptPotatoallergyintoleranceClinicalstatus(
    coding: List(CodingOmitExtension),
    required: List1(
      CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
    ),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatoallergyintolerance_clinicalstatus_new(
  required required: List1(
    CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
  ),
) -> CodeableconceptPotatoallergyintoleranceClinicalstatus {
  CodeableconceptPotatoallergyintoleranceClinicalstatus(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired {
  CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired(
    code: Option(valuesets.Allergyintoleranceclinical),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_new() -> CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired {
  CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatoallergyintolerance_clinicalstatus_to_json(
  codeableconcept_potatoallergyintolerance_clinicalstatus: CodeableconceptPotatoallergyintoleranceClinicalstatus,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case codeableconcept_potatoallergyintolerance_clinicalstatus.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_to_json(
          codeableconcept_potatoallergyintolerance_clinicalstatus.required.first,
        ),
        ..list.map(
          codeableconcept_potatoallergyintolerance_clinicalstatus.required.rest,
          fn(value) {
            codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatoallergyintolerance_clinicalstatus.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_to_json(
  codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required: CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required.code
  {
    Some(v) -> [
      #("code", valuesets.allergyintoleranceclinical_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatoallergyintoleranceVerificationstatus {
  CodeableconceptPotatoallergyintoleranceVerificationstatus(
    coding: List(CodingOmitExtension),
    required: List1(
      CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
    ),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatoallergyintolerance_verificationstatus_new(
  required required: List1(
    CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
  ),
) -> CodeableconceptPotatoallergyintoleranceVerificationstatus {
  CodeableconceptPotatoallergyintoleranceVerificationstatus(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired {
  CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired(
    code: Option(valuesets.Allergyintoleranceverification),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_new() -> CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired {
  CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatoallergyintolerance_verificationstatus_to_json(
  codeableconcept_potatoallergyintolerance_verificationstatus: CodeableconceptPotatoallergyintoleranceVerificationstatus,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_to_json(
          codeableconcept_potatoallergyintolerance_verificationstatus.required.first,
        ),
        ..list.map(
          codeableconcept_potatoallergyintolerance_verificationstatus.required.rest,
          fn(value) {
            codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatoallergyintolerance_verificationstatus.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_to_json(
  codeableconcept_potatoallergyintolerance_verificationstatus_coding_required: CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatoallergyintolerance_verificationstatus_coding_required.code
  {
    Some(v) -> [
      #("code", valuesets.allergyintoleranceverification_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatoconditionCategoryScreeningAssessment {
  CodeableconceptPotatoconditionCategoryScreeningAssessment(
    coding: List(CodingOmitExtension),
    required: List1(
      CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
    ),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatocondition_category_screening_assessment_new(
  required required: List1(
    CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
  ),
) -> CodeableconceptPotatoconditionCategoryScreeningAssessment {
  CodeableconceptPotatoconditionCategoryScreeningAssessment(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired {
  CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired(
    code: Option(valuesets.Uscorescreeningassessmentconditioncategory),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatocondition_category_screening_assessment_coding_required_new() -> CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired {
  CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatocondition_category_screening_assessment_to_json(
  codeableconcept_potatocondition_category_screening_assessment: CodeableconceptPotatoconditionCategoryScreeningAssessment,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatocondition_category_screening_assessment_coding_required_to_json(
          codeableconcept_potatocondition_category_screening_assessment.required.first,
        ),
        ..list.map(
          codeableconcept_potatocondition_category_screening_assessment.required.rest,
          fn(value) {
            codeableconcept_potatocondition_category_screening_assessment_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatocondition_category_screening_assessment.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatocondition_category_screening_assessment_coding_required_to_json(
  codeableconcept_potatocondition_category_screening_assessment_coding_required: CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_screening_assessment_coding_required.code
  {
    Some(v) -> [
      #("code", valuesets.uscorescreeningassessmentconditioncategory_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatoconditionCategoryUsCore {
  CodeableconceptPotatoconditionCategoryUsCore(
    coding: List(CodingOmitExtension),
    required: List1(CodeableconceptPotatoconditionCategoryUsCoreCodingRequired),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatocondition_category_us_core_new(
  required required: List1(
    CodeableconceptPotatoconditionCategoryUsCoreCodingRequired,
  ),
) -> CodeableconceptPotatoconditionCategoryUsCore {
  CodeableconceptPotatoconditionCategoryUsCore(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatoconditionCategoryUsCoreCodingRequired {
  CodeableconceptPotatoconditionCategoryUsCoreCodingRequired(
    code: Option(valuesets.Uscoreproblemorhealthconcern),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatocondition_category_us_core_coding_required_new() -> CodeableconceptPotatoconditionCategoryUsCoreCodingRequired {
  CodeableconceptPotatoconditionCategoryUsCoreCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatocondition_category_us_core_to_json(
  codeableconcept_potatocondition_category_us_core: CodeableconceptPotatoconditionCategoryUsCore,
) -> Json {
  let fields = []
  let fields = case codeableconcept_potatocondition_category_us_core.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case codeableconcept_potatocondition_category_us_core.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatocondition_category_us_core_coding_required_to_json(
          codeableconcept_potatocondition_category_us_core.required.first,
        ),
        ..list.map(
          codeableconcept_potatocondition_category_us_core.required.rest,
          fn(value) {
            codeableconcept_potatocondition_category_us_core_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatocondition_category_us_core.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatocondition_category_us_core_coding_required_to_json(
  codeableconcept_potatocondition_category_us_core_coding_required: CodeableconceptPotatoconditionCategoryUsCoreCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatocondition_category_us_core_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_us_core_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_us_core_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_us_core_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_us_core_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_category_us_core_coding_required.code
  {
    Some(v) -> [
      #("code", valuesets.uscoreproblemorhealthconcern_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatoconditionClinicalstatus {
  CodeableconceptPotatoconditionClinicalstatus(
    coding: List(CodingOmitExtension),
    required: List1(CodeableconceptPotatoconditionClinicalstatusCodingRequired),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatocondition_clinicalstatus_new(
  required required: List1(
    CodeableconceptPotatoconditionClinicalstatusCodingRequired,
  ),
) -> CodeableconceptPotatoconditionClinicalstatus {
  CodeableconceptPotatoconditionClinicalstatus(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatoconditionClinicalstatusCodingRequired {
  CodeableconceptPotatoconditionClinicalstatusCodingRequired(
    code: Option(valuesets.Conditionclinical),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatocondition_clinicalstatus_coding_required_new() -> CodeableconceptPotatoconditionClinicalstatusCodingRequired {
  CodeableconceptPotatoconditionClinicalstatusCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatocondition_clinicalstatus_to_json(
  codeableconcept_potatocondition_clinicalstatus: CodeableconceptPotatoconditionClinicalstatus,
) -> Json {
  let fields = []
  let fields = case codeableconcept_potatocondition_clinicalstatus.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case codeableconcept_potatocondition_clinicalstatus.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatocondition_clinicalstatus_coding_required_to_json(
          codeableconcept_potatocondition_clinicalstatus.required.first,
        ),
        ..list.map(
          codeableconcept_potatocondition_clinicalstatus.required.rest,
          fn(value) {
            codeableconcept_potatocondition_clinicalstatus_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(codeableconcept_potatocondition_clinicalstatus.coding, fn(value) {
        fn(value) { coding_omit_extension_to_json(value) }(value)
      }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatocondition_clinicalstatus_coding_required_to_json(
  codeableconcept_potatocondition_clinicalstatus_coding_required: CodeableconceptPotatoconditionClinicalstatusCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatocondition_clinicalstatus_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_clinicalstatus_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_clinicalstatus_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_clinicalstatus_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_clinicalstatus_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_clinicalstatus_coding_required.code
  {
    Some(v) -> [#("code", valuesets.conditionclinical_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatoconditionVerificationstatus {
  CodeableconceptPotatoconditionVerificationstatus(
    coding: List(CodingOmitExtension),
    required: List1(
      CodeableconceptPotatoconditionVerificationstatusCodingRequired,
    ),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatocondition_verificationstatus_new(
  required required: List1(
    CodeableconceptPotatoconditionVerificationstatusCodingRequired,
  ),
) -> CodeableconceptPotatoconditionVerificationstatus {
  CodeableconceptPotatoconditionVerificationstatus(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatoconditionVerificationstatusCodingRequired {
  CodeableconceptPotatoconditionVerificationstatusCodingRequired(
    code: Option(valuesets.Conditionverstatus),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatocondition_verificationstatus_coding_required_new() -> CodeableconceptPotatoconditionVerificationstatusCodingRequired {
  CodeableconceptPotatoconditionVerificationstatusCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatocondition_verificationstatus_to_json(
  codeableconcept_potatocondition_verificationstatus: CodeableconceptPotatoconditionVerificationstatus,
) -> Json {
  let fields = []
  let fields = case codeableconcept_potatocondition_verificationstatus.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case codeableconcept_potatocondition_verificationstatus.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatocondition_verificationstatus_coding_required_to_json(
          codeableconcept_potatocondition_verificationstatus.required.first,
        ),
        ..list.map(
          codeableconcept_potatocondition_verificationstatus.required.rest,
          fn(value) {
            codeableconcept_potatocondition_verificationstatus_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatocondition_verificationstatus.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatocondition_verificationstatus_coding_required_to_json(
  codeableconcept_potatocondition_verificationstatus_coding_required: CodeableconceptPotatoconditionVerificationstatusCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatocondition_verificationstatus_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_verificationstatus_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_verificationstatus_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_verificationstatus_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_verificationstatus_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatocondition_verificationstatus_coding_required.code
  {
    Some(v) -> [#("code", valuesets.conditionverstatus_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatodocumentreferenceCategoryUscore {
  CodeableconceptPotatodocumentreferenceCategoryUscore(
    coding: List(CodingOmitExtension),
    required: List1(
      CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
    ),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatodocumentreference_category_uscore_new(
  required required: List1(
    CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
  ),
) -> CodeableconceptPotatodocumentreferenceCategoryUscore {
  CodeableconceptPotatodocumentreferenceCategoryUscore(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired {
  CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired(
    code: Option(valuesets.Uscoredocumentreferencecategory),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatodocumentreference_category_uscore_coding_required_new() -> CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired {
  CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatodocumentreference_category_uscore_to_json(
  codeableconcept_potatodocumentreference_category_uscore: CodeableconceptPotatodocumentreferenceCategoryUscore,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case codeableconcept_potatodocumentreference_category_uscore.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatodocumentreference_category_uscore_coding_required_to_json(
          codeableconcept_potatodocumentreference_category_uscore.required.first,
        ),
        ..list.map(
          codeableconcept_potatodocumentreference_category_uscore.required.rest,
          fn(value) {
            codeableconcept_potatodocumentreference_category_uscore_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatodocumentreference_category_uscore.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatodocumentreference_category_uscore_coding_required_to_json(
  codeableconcept_potatodocumentreference_category_uscore_coding_required: CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatodocumentreference_category_uscore_coding_required.code
  {
    Some(v) -> [
      #("code", valuesets.uscoredocumentreferencecategory_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub type CodeableconceptPotatomedicationrequestCategoryUsCore {
  CodeableconceptPotatomedicationrequestCategoryUsCore(
    coding: List(CodingOmitExtension),
    required: List1(
      CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
    ),
    id: Option(String),
    text: Option(String),
  )
}

pub fn codeableconcept_potatomedicationrequest_category_us_core_new(
  required required: List1(
    CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
  ),
) -> CodeableconceptPotatomedicationrequestCategoryUsCore {
  CodeableconceptPotatomedicationrequestCategoryUsCore(
    coding: [],
    required:,
    id: None,
    text: None,
  )
}

pub type CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired {
  CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired(
    code: Option(valuesets.Medicationrequestcategory),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn codeableconcept_potatomedicationrequest_category_us_core_coding_required_new() -> CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired {
  CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn codeableconcept_potatomedicationrequest_category_us_core_to_json(
  codeableconcept_potatomedicationrequest_category_us_core: CodeableconceptPotatomedicationrequestCategoryUsCore,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        codeableconcept_potatomedicationrequest_category_us_core_coding_required_to_json(
          codeableconcept_potatomedicationrequest_category_us_core.required.first,
        ),
        ..list.map(
          codeableconcept_potatomedicationrequest_category_us_core.required.rest,
          fn(value) {
            codeableconcept_potatomedicationrequest_category_us_core_coding_required_to_json(
              value,
            )
          },
        )
      ],
      list.map(
        codeableconcept_potatomedicationrequest_category_us_core.coding,
        fn(value) { fn(value) { coding_omit_extension_to_json(value) }(value) },
      ),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("coding", json.preprocessed_array(values)), ..fields]
  }
  json.object(fields)
}

pub fn codeableconcept_potatomedicationrequest_category_us_core_coding_required_to_json(
  codeableconcept_potatomedicationrequest_category_us_core_coding_required: CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
) -> Json {
  let fields = []
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core_coding_required.version
  {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core_coding_required.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core_coding_required.system
  {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core_coding_required.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core_coding_required.display
  {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    codeableconcept_potatomedicationrequest_category_us_core_coding_required.code
  {
    Some(v) -> [
      #("code", valuesets.medicationrequestcategory_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub type CodingPotatoethnicityExtensionDetailedValue {
  CodingPotatoethnicityExtensionDetailedValue(
    code: Option(valuesets.Detailedethnicity),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn coding_potatoethnicity_extension_detailed_value_new() -> CodingPotatoethnicityExtensionDetailedValue {
  CodingPotatoethnicityExtensionDetailedValue(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn coding_potatoethnicity_extension_detailed_value_to_json(
  coding_potatoethnicity_extension_detailed_value: CodingPotatoethnicityExtensionDetailedValue,
) -> Json {
  let fields = []
  let fields = case coding_potatoethnicity_extension_detailed_value.version {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    coding_potatoethnicity_extension_detailed_value.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_detailed_value.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_detailed_value.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_detailed_value.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_detailed_value.code {
    Some(v) -> [#("code", valuesets.detailedethnicity_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodingPotatoethnicityExtensionOmbcategoryValue {
  CodingPotatoethnicityExtensionOmbcategoryValue(
    code: Option(valuesets.Ombethnicitycategory),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn coding_potatoethnicity_extension_ombcategory_value_new() -> CodingPotatoethnicityExtensionOmbcategoryValue {
  CodingPotatoethnicityExtensionOmbcategoryValue(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn coding_potatoethnicity_extension_ombcategory_value_to_json(
  coding_potatoethnicity_extension_ombcategory_value: CodingPotatoethnicityExtensionOmbcategoryValue,
) -> Json {
  let fields = []
  let fields = case coding_potatoethnicity_extension_ombcategory_value.version {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    coding_potatoethnicity_extension_ombcategory_value.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_ombcategory_value.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_ombcategory_value.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_ombcategory_value.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatoethnicity_extension_ombcategory_value.code {
    Some(v) -> [#("code", valuesets.ombethnicitycategory_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodingPotatoraceExtensionDetailedValue {
  CodingPotatoraceExtensionDetailedValue(
    code: Option(valuesets.Detailedrace),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn coding_potatorace_extension_detailed_value_new() -> CodingPotatoraceExtensionDetailedValue {
  CodingPotatoraceExtensionDetailedValue(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn coding_potatorace_extension_detailed_value_to_json(
  coding_potatorace_extension_detailed_value: CodingPotatoraceExtensionDetailedValue,
) -> Json {
  let fields = []
  let fields = case coding_potatorace_extension_detailed_value.version {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_detailed_value.user_selected {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_detailed_value.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_detailed_value.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_detailed_value.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_detailed_value.code {
    Some(v) -> [#("code", valuesets.detailedrace_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type CodingPotatoraceExtensionOmbcategoryValue {
  CodingPotatoraceExtensionOmbcategoryValue(
    code: Option(valuesets.Ombracecategory),
    display: Option(String),
    id: Option(String),
    system: Option(String),
    user_selected: Option(Bool),
    version: Option(String),
  )
}

pub fn coding_potatorace_extension_ombcategory_value_new() -> CodingPotatoraceExtensionOmbcategoryValue {
  CodingPotatoraceExtensionOmbcategoryValue(
    code: None,
    display: None,
    id: None,
    system: None,
    user_selected: None,
    version: None,
  )
}

pub fn coding_potatorace_extension_ombcategory_value_to_json(
  coding_potatorace_extension_ombcategory_value: CodingPotatoraceExtensionOmbcategoryValue,
) -> Json {
  let fields = []
  let fields = case coding_potatorace_extension_ombcategory_value.version {
    Some(v) -> [#("version", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    coding_potatorace_extension_ombcategory_value.user_selected
  {
    Some(v) -> [#("userSelected", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_ombcategory_value.system {
    Some(v) -> [#("system", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_ombcategory_value.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_ombcategory_value.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case coding_potatorace_extension_ombcategory_value.code {
    Some(v) -> [#("code", valuesets.ombracecategory_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type ContactpointPotatopatientTelecom {
  ContactpointPotatopatientTelecom(
    id: Option(String),
    period: Option(PeriodOmitExtension),
    rank: Option(Int),
    system: valuesets.Contactpointsystem,
    use_: Option(valuesets.Contactpointuse),
    value: String,
  )
}

pub fn contactpoint_potatopatient_telecom_new(
  system system: valuesets.Contactpointsystem,
  value value: String,
) -> ContactpointPotatopatientTelecom {
  ContactpointPotatopatientTelecom(
    id: None,
    period: None,
    rank: None,
    system:,
    use_: None,
    value:,
  )
}

pub fn contactpoint_potatopatient_telecom_to_json(
  contactpoint_potatopatient_telecom: ContactpointPotatopatientTelecom,
) -> Json {
  let fields = [
    #("value", json.string(contactpoint_potatopatient_telecom.value)),
    #(
      "system",
      valuesets.contactpointsystem_to_json(
        contactpoint_potatopatient_telecom.system,
      ),
    ),
  ]
  let fields = case contactpoint_potatopatient_telecom.use_ {
    Some(v) -> [#("use", valuesets.contactpointuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case contactpoint_potatopatient_telecom.rank {
    Some(v) -> [#("rank", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case contactpoint_potatopatient_telecom.period {
    Some(v) -> [#("period", period_omit_extension_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case contactpoint_potatopatient_telecom.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type DosagePotatomedicationrequestDosageinstruction {
  DosagePotatomedicationrequestDosageinstruction(
    additional_instruction: List(
      DosagePotatomedicationrequestDosageinstructionAdditionalinstruction,
    ),
    as_needed: Option(DosagePotatomedicationrequestDosageinstructionAsneeded),
    dose_and_rate: List(
      DosagePotatomedicationrequestDosageinstructionDoseandrate,
    ),
    id: Option(String),
    max_dose_per_administration: Option(QuantityOmitExtensionComparator),
    max_dose_per_lifetime: Option(QuantityOmitExtensionComparator),
    max_dose_per_period: Option(
      DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod,
    ),
    method: Option(DosagePotatomedicationrequestDosageinstructionMethod),
    patient_instruction: Option(String),
    route: Option(DosagePotatomedicationrequestDosageinstructionRoute),
    sequence: Option(Int),
    site: Option(DosagePotatomedicationrequestDosageinstructionSite),
    text: Option(String),
    timing: Option(DosagePotatomedicationrequestDosageinstructionTiming),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_new() -> DosagePotatomedicationrequestDosageinstruction {
  DosagePotatomedicationrequestDosageinstruction(
    additional_instruction: [],
    as_needed: None,
    dose_and_rate: [],
    id: None,
    max_dose_per_administration: None,
    max_dose_per_lifetime: None,
    max_dose_per_period: None,
    method: None,
    patient_instruction: None,
    route: None,
    sequence: None,
    site: None,
    text: None,
    timing: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionAsneeded {
  DosagePotatomedicationrequestDosageinstructionAsneededBoolean(value: Bool)
  DosagePotatomedicationrequestDosageinstructionAsneededCodeableconcept(
    value: Potatocodeableconcept,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionAdditionalinstruction {
  DosagePotatomedicationrequestDosageinstructionAdditionalinstruction(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_additionalinstruction_new() -> DosagePotatomedicationrequestDosageinstructionAdditionalinstruction {
  DosagePotatomedicationrequestDosageinstructionAdditionalinstruction(
    coding: [],
    id: None,
    text: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionDoseandrate {
  DosagePotatomedicationrequestDosageinstructionDoseandrate(
    dose: Option(DosagePotatomedicationrequestDosageinstructionDoseandrateDose),
    id: Option(String),
    rate: Option(DosagePotatomedicationrequestDosageinstructionDoseandrateRate),
    type_: Option(DosagePotatomedicationrequestDosageinstructionDoseandrateType),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_new() -> DosagePotatomedicationrequestDosageinstructionDoseandrate {
  DosagePotatomedicationrequestDosageinstructionDoseandrate(
    dose: None,
    id: None,
    rate: None,
    type_: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionDoseandrateRate {
  DosagePotatomedicationrequestDosageinstructionDoseandrateRateRatio(
    value: Potatoratio,
  )
  DosagePotatomedicationrequestDosageinstructionDoseandrateRateRange(
    value: Potatorange,
  )
  DosagePotatomedicationrequestDosageinstructionDoseandrateRateQuantity(
    value: Potatosimplequantity,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionDoseandrateDose {
  DosagePotatomedicationrequestDosageinstructionDoseandrateDoseQuantity(
    value: Potatosimplequantity,
  )
  DosagePotatomedicationrequestDosageinstructionDoseandrateDoseRange(
    value: Potatorange,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionDoseandrateType {
  DosagePotatomedicationrequestDosageinstructionDoseandrateType(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_type_new() -> DosagePotatomedicationrequestDosageinstructionDoseandrateType {
  DosagePotatomedicationrequestDosageinstructionDoseandrateType(
    coding: [],
    id: None,
    text: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod {
  DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod(
    denominator: Option(Potatoquantity),
    id: Option(String),
    numerator: Option(Potatoquantity),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod_new() -> DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod {
  DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod(
    denominator: None,
    id: None,
    numerator: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionMethod {
  DosagePotatomedicationrequestDosageinstructionMethod(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_method_new() -> DosagePotatomedicationrequestDosageinstructionMethod {
  DosagePotatomedicationrequestDosageinstructionMethod(
    coding: [],
    id: None,
    text: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionRoute {
  DosagePotatomedicationrequestDosageinstructionRoute(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_route_new() -> DosagePotatomedicationrequestDosageinstructionRoute {
  DosagePotatomedicationrequestDosageinstructionRoute(
    coding: [],
    id: None,
    text: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionSite {
  DosagePotatomedicationrequestDosageinstructionSite(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_site_new() -> DosagePotatomedicationrequestDosageinstructionSite {
  DosagePotatomedicationrequestDosageinstructionSite(
    coding: [],
    id: None,
    text: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionTiming {
  DosagePotatomedicationrequestDosageinstructionTiming(
    code: Option(Potatocodeableconcept),
    event: List(DateTime),
    id: Option(String),
    repeat: Option(DosagePotatomedicationrequestDosageinstructionTimingRepeat),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_new() -> DosagePotatomedicationrequestDosageinstructionTiming {
  DosagePotatomedicationrequestDosageinstructionTiming(
    code: None,
    event: [],
    id: None,
    repeat: None,
  )
}

pub type DosagePotatomedicationrequestDosageinstructionTimingRepeat {
  DosagePotatomedicationrequestDosageinstructionTimingRepeat(
    bounds: Option(
      DosagePotatomedicationrequestDosageinstructionTimingRepeatBounds,
    ),
    count: Option(Int),
    count_max: Option(Int),
    day_of_week: List(valuesets.Daysofweek),
    duration: Option(Float),
    duration_max: Option(Float),
    duration_unit: Option(valuesets.Unitsoftime),
    frequency: Option(Int),
    frequency_max: Option(Int),
    id: Option(String),
    offset: Option(Int),
    period: Option(Float),
    period_max: Option(Float),
    period_unit: Option(valuesets.Unitsoftime),
    time_of_day: List(Time),
    when: List(valuesets.Eventtiming),
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_repeat_new() -> DosagePotatomedicationrequestDosageinstructionTimingRepeat {
  DosagePotatomedicationrequestDosageinstructionTimingRepeat(
    bounds: None,
    count: None,
    count_max: None,
    day_of_week: [],
    duration: None,
    duration_max: None,
    duration_unit: None,
    frequency: None,
    frequency_max: None,
    id: None,
    offset: None,
    period: None,
    period_max: None,
    period_unit: None,
    time_of_day: [],
    when: [],
  )
}

pub type DosagePotatomedicationrequestDosageinstructionTimingRepeatBounds {
  DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsDuration(
    value: Potatoduration,
  )
  DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsRange(
    value: Potatorange,
  )
  DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsPeriod(
    value: Potatoperiod,
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_to_json(
  dosage_potatomedicationrequest_dosageinstruction: DosagePotatomedicationrequestDosageinstruction,
) -> Json {
  let fields = []
  let fields = case dosage_potatomedicationrequest_dosageinstruction.timing {
    Some(v) -> [
      #(
        "timing",
        dosage_potatomedicationrequest_dosageinstruction_timing_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.site {
    Some(v) -> [
      #(
        "site",
        dosage_potatomedicationrequest_dosageinstruction_site_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.sequence {
    Some(v) -> [#("sequence", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.route {
    Some(v) -> [
      #(
        "route",
        dosage_potatomedicationrequest_dosageinstruction_route_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction.patient_instruction
  {
    Some(v) -> [#("patientInstruction", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.method {
    Some(v) -> [
      #(
        "method",
        dosage_potatomedicationrequest_dosageinstruction_method_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction.max_dose_per_period
  {
    Some(v) -> [
      #(
        "maxDosePerPeriod",
        dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction.max_dose_per_lifetime
  {
    Some(v) -> [
      #("maxDosePerLifetime", quantity_omit_extension_comparator_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction.max_dose_per_administration
  {
    Some(v) -> [
      #(
        "maxDosePerAdministration",
        quantity_omit_extension_comparator_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction.dose_and_rate
  {
    [] -> fields
    values -> [
      #(
        "doseAndRate",
        json.array(
          values,
          dosage_potatomedicationrequest_dosageinstruction_doseandrate_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction.as_needed {
    Some(v) -> [
      #(
        "asNeeded"
          <> case v {
          DosagePotatomedicationrequestDosageinstructionAsneededBoolean(_) ->
            "Boolean"
          DosagePotatomedicationrequestDosageinstructionAsneededCodeableconcept(
            _,
          ) -> "CodeableConcept"
        },
        dosage_potatomedicationrequest_dosageinstruction_asneeded_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction.additional_instruction
  {
    [] -> fields
    values -> [
      #(
        "additionalInstruction",
        json.array(
          values,
          dosage_potatomedicationrequest_dosageinstruction_additionalinstruction_to_json,
        ),
      ),
      ..fields
    ]
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_asneeded_to_json(
  value: DosagePotatomedicationrequestDosageinstructionAsneeded,
) -> Json {
  case value {
    DosagePotatomedicationrequestDosageinstructionAsneededBoolean(value) ->
      json.bool(value)
    DosagePotatomedicationrequestDosageinstructionAsneededCodeableconcept(value) ->
      potatocodeableconcept_to_json(value)
  }
}

pub fn dosage_potatomedicationrequest_dosageinstruction_additionalinstruction_to_json(
  dosage_potatomedicationrequest_dosageinstruction_additionalinstruction: DosagePotatomedicationrequestDosageinstructionAdditionalinstruction,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_additionalinstruction.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_additionalinstruction.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_additionalinstruction.coding
  {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_to_json(
  dosage_potatomedicationrequest_dosageinstruction_doseandrate: DosagePotatomedicationrequestDosageinstructionDoseandrate,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate.type_
  {
    Some(v) -> [
      #(
        "type",
        dosage_potatomedicationrequest_dosageinstruction_doseandrate_type_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate.rate
  {
    Some(v) -> [
      #(
        "rate"
          <> case v {
          DosagePotatomedicationrequestDosageinstructionDoseandrateRateRatio(_) ->
            "Ratio"
          DosagePotatomedicationrequestDosageinstructionDoseandrateRateRange(_) ->
            "Range"
          DosagePotatomedicationrequestDosageinstructionDoseandrateRateQuantity(
            _,
          ) -> "Quantity"
        },
        dosage_potatomedicationrequest_dosageinstruction_doseandrate_rate_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate.dose
  {
    Some(v) -> [
      #(
        "dose"
          <> case v {
          DosagePotatomedicationrequestDosageinstructionDoseandrateDoseQuantity(
            _,
          ) -> "Quantity"
          DosagePotatomedicationrequestDosageinstructionDoseandrateDoseRange(_) ->
            "Range"
        },
        dosage_potatomedicationrequest_dosageinstruction_doseandrate_dose_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_dose_to_json(
  value: DosagePotatomedicationrequestDosageinstructionDoseandrateDose,
) -> Json {
  case value {
    DosagePotatomedicationrequestDosageinstructionDoseandrateDoseQuantity(value) ->
      potatosimplequantity_to_json(value)
    DosagePotatomedicationrequestDosageinstructionDoseandrateDoseRange(value) ->
      potatorange_to_json(value)
  }
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_rate_to_json(
  value: DosagePotatomedicationrequestDosageinstructionDoseandrateRate,
) -> Json {
  case value {
    DosagePotatomedicationrequestDosageinstructionDoseandrateRateRatio(value) ->
      potatoratio_to_json(value)
    DosagePotatomedicationrequestDosageinstructionDoseandrateRateRange(value) ->
      potatorange_to_json(value)
    DosagePotatomedicationrequestDosageinstructionDoseandrateRateQuantity(value) ->
      potatosimplequantity_to_json(value)
  }
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_type_to_json(
  dosage_potatomedicationrequest_dosageinstruction_doseandrate_type: DosagePotatomedicationrequestDosageinstructionDoseandrateType,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate_type.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate_type.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_doseandrate_type.coding
  {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod_to_json(
  dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod: DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod.numerator
  {
    Some(v) -> [#("numerator", potatoquantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod.denominator
  {
    Some(v) -> [#("denominator", potatoquantity_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_method_to_json(
  dosage_potatomedicationrequest_dosageinstruction_method: DosagePotatomedicationrequestDosageinstructionMethod,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_method.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction_method.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_method.coding
  {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_route_to_json(
  dosage_potatomedicationrequest_dosageinstruction_route: DosagePotatomedicationrequestDosageinstructionRoute,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_route.text
  {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction_route.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_route.coding
  {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_site_to_json(
  dosage_potatomedicationrequest_dosageinstruction_site: DosagePotatomedicationrequestDosageinstructionSite,
) -> Json {
  let fields = []
  let fields = case dosage_potatomedicationrequest_dosageinstruction_site.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction_site.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_site.coding
  {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_to_json(
  dosage_potatomedicationrequest_dosageinstruction_timing: DosagePotatomedicationrequestDosageinstructionTiming,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing.repeat
  {
    Some(v) -> [
      #(
        "repeat",
        dosage_potatomedicationrequest_dosageinstruction_timing_repeat_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case dosage_potatomedicationrequest_dosageinstruction_timing.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing.event
  {
    [] -> fields
    values -> [#("event", json.array(values, pt.datetime_to_json)), ..fields]
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing.code
  {
    Some(v) -> [#("code", potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_repeat_to_json(
  dosage_potatomedicationrequest_dosageinstruction_timing_repeat: DosagePotatomedicationrequestDosageinstructionTimingRepeat,
) -> Json {
  let fields = []
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.when
  {
    [] -> fields
    values -> [
      #("when", json.array(values, valuesets.eventtiming_to_json)),
      ..fields
    ]
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.time_of_day
  {
    [] -> fields
    values -> [#("timeOfDay", json.array(values, pt.time_to_json)), ..fields]
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.period_unit
  {
    Some(v) -> [#("periodUnit", valuesets.unitsoftime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.period_max
  {
    Some(v) -> [#("periodMax", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.period
  {
    Some(v) -> [#("period", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.offset
  {
    Some(v) -> [#("offset", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.id
  {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.frequency_max
  {
    Some(v) -> [#("frequencyMax", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.frequency
  {
    Some(v) -> [#("frequency", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.duration_unit
  {
    Some(v) -> [#("durationUnit", valuesets.unitsoftime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.duration_max
  {
    Some(v) -> [#("durationMax", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.duration
  {
    Some(v) -> [#("duration", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.day_of_week
  {
    [] -> fields
    values -> [
      #("dayOfWeek", json.array(values, valuesets.daysofweek_to_json)),
      ..fields
    ]
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.count_max
  {
    Some(v) -> [#("countMax", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.count
  {
    Some(v) -> [#("count", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case
    dosage_potatomedicationrequest_dosageinstruction_timing_repeat.bounds
  {
    Some(v) -> [
      #(
        "bounds"
          <> case v {
          DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsDuration(
            _,
          ) -> "Duration"
          DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsRange(
            _,
          ) -> "Range"
          DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsPeriod(
            _,
          ) -> "Period"
        },
        dosage_potatomedicationrequest_dosageinstruction_timing_repeat_bounds_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_repeat_bounds_to_json(
  value: DosagePotatomedicationrequestDosageinstructionTimingRepeatBounds,
) -> Json {
  case value {
    DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsDuration(
      value,
    ) -> potatoduration_to_json(value)
    DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsRange(value) ->
      potatorange_to_json(value)
    DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsPeriod(
      value,
    ) -> potatoperiod_to_json(value)
  }
}

pub type HumannamePotatopatientName {
  HumannamePotatopatientName(
    family: Option(String),
    given: List(String),
    id: Option(String),
    period: Option(PeriodOmitExtension),
    prefix: List(String),
    suffix: List(String),
    text: Option(String),
    use_: Option(valuesets.Nameuse),
  )
}

pub fn humanname_potatopatient_name_new() -> HumannamePotatopatientName {
  HumannamePotatopatientName(
    family: None,
    given: [],
    id: None,
    period: None,
    prefix: [],
    suffix: [],
    text: None,
    use_: None,
  )
}

pub fn humanname_potatopatient_name_to_json(
  humanname_potatopatient_name: HumannamePotatopatientName,
) -> Json {
  let fields = []
  let fields = case humanname_potatopatient_name.use_ {
    Some(v) -> [#("use", valuesets.nameuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case humanname_potatopatient_name.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case humanname_potatopatient_name.suffix {
    [] -> fields
    values -> [#("suffix", json.array(values, json.string)), ..fields]
  }
  let fields = case humanname_potatopatient_name.prefix {
    [] -> fields
    values -> [#("prefix", json.array(values, json.string)), ..fields]
  }
  let fields = case humanname_potatopatient_name.period {
    Some(v) -> [#("period", period_omit_extension_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case humanname_potatopatient_name.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case humanname_potatopatient_name.given {
    [] -> fields
    values -> [#("given", json.array(values, json.string)), ..fields]
  }
  let fields = case humanname_potatopatient_name.family {
    Some(v) -> [#("family", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type IdentifierPotatoencounterIdentifier {
  IdentifierPotatoencounterIdentifier(
    assigner: Option(IdentifierPotatoencounterIdentifierAssigner),
    id: Option(String),
    period: Option(PeriodOmitExtension),
    system: String,
    type_: Option(IdentifierPotatoencounterIdentifierType),
    use_: Option(valuesets.Identifieruse),
    value: String,
  )
}

pub fn identifier_potatoencounter_identifier_new(
  system system: String,
  value value: String,
) -> IdentifierPotatoencounterIdentifier {
  IdentifierPotatoencounterIdentifier(
    assigner: None,
    id: None,
    period: None,
    system:,
    type_: None,
    use_: None,
    value:,
  )
}

pub type IdentifierPotatoencounterIdentifierAssigner {
  IdentifierPotatoencounterIdentifierAssigner(
    display: Option(String),
    id: Option(String),
    identifier: Option(Potatoidentifier),
    reference: Option(String),
    type_: Option(String),
  )
}

pub fn identifier_potatoencounter_identifier_assigner_new() -> IdentifierPotatoencounterIdentifierAssigner {
  IdentifierPotatoencounterIdentifierAssigner(
    display: None,
    id: None,
    identifier: None,
    reference: None,
    type_: None,
  )
}

pub type IdentifierPotatoencounterIdentifierType {
  IdentifierPotatoencounterIdentifierType(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn identifier_potatoencounter_identifier_type_new() -> IdentifierPotatoencounterIdentifierType {
  IdentifierPotatoencounterIdentifierType(coding: [], id: None, text: None)
}

pub fn identifier_potatoencounter_identifier_to_json(
  identifier_potatoencounter_identifier: IdentifierPotatoencounterIdentifier,
) -> Json {
  let fields = [
    #("value", json.string(identifier_potatoencounter_identifier.value)),
    #("system", json.string(identifier_potatoencounter_identifier.system)),
  ]
  let fields = case identifier_potatoencounter_identifier.use_ {
    Some(v) -> [#("use", valuesets.identifieruse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier.type_ {
    Some(v) -> [
      #("type", identifier_potatoencounter_identifier_type_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier.period {
    Some(v) -> [#("period", period_omit_extension_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier.assigner {
    Some(v) -> [
      #("assigner", identifier_potatoencounter_identifier_assigner_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn identifier_potatoencounter_identifier_assigner_to_json(
  identifier_potatoencounter_identifier_assigner: IdentifierPotatoencounterIdentifierAssigner,
) -> Json {
  let fields = []
  let fields = case identifier_potatoencounter_identifier_assigner.type_ {
    Some(v) -> [#("type", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier_assigner.reference {
    Some(v) -> [#("reference", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier_assigner.identifier {
    Some(v) -> [#("identifier", potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier_assigner.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier_assigner.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn identifier_potatoencounter_identifier_type_to_json(
  identifier_potatoencounter_identifier_type: IdentifierPotatoencounterIdentifierType,
) -> Json {
  let fields = []
  let fields = case identifier_potatoencounter_identifier_type.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier_type.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatoencounter_identifier_type.coding {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub type IdentifierPotatopatientIdentifier {
  IdentifierPotatopatientIdentifier(
    assigner: Option(IdentifierPotatopatientIdentifierAssigner),
    id: Option(String),
    period: Option(PeriodOmitExtension),
    system: String,
    type_: Option(IdentifierPotatopatientIdentifierType),
    use_: Option(valuesets.Identifieruse),
    value: String,
  )
}

pub fn identifier_potatopatient_identifier_new(
  system system: String,
  value value: String,
) -> IdentifierPotatopatientIdentifier {
  IdentifierPotatopatientIdentifier(
    assigner: None,
    id: None,
    period: None,
    system:,
    type_: None,
    use_: None,
    value:,
  )
}

pub type IdentifierPotatopatientIdentifierAssigner {
  IdentifierPotatopatientIdentifierAssigner(
    display: Option(String),
    id: Option(String),
    identifier: Option(Potatoidentifier),
    reference: Option(String),
    type_: Option(String),
  )
}

pub fn identifier_potatopatient_identifier_assigner_new() -> IdentifierPotatopatientIdentifierAssigner {
  IdentifierPotatopatientIdentifierAssigner(
    display: None,
    id: None,
    identifier: None,
    reference: None,
    type_: None,
  )
}

pub type IdentifierPotatopatientIdentifierType {
  IdentifierPotatopatientIdentifierType(
    coding: List(Potatocoding),
    id: Option(String),
    text: Option(String),
  )
}

pub fn identifier_potatopatient_identifier_type_new() -> IdentifierPotatopatientIdentifierType {
  IdentifierPotatopatientIdentifierType(coding: [], id: None, text: None)
}

pub fn identifier_potatopatient_identifier_to_json(
  identifier_potatopatient_identifier: IdentifierPotatopatientIdentifier,
) -> Json {
  let fields = [
    #("value", json.string(identifier_potatopatient_identifier.value)),
    #("system", json.string(identifier_potatopatient_identifier.system)),
  ]
  let fields = case identifier_potatopatient_identifier.use_ {
    Some(v) -> [#("use", valuesets.identifieruse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier.type_ {
    Some(v) -> [
      #("type", identifier_potatopatient_identifier_type_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier.period {
    Some(v) -> [#("period", period_omit_extension_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier.assigner {
    Some(v) -> [
      #("assigner", identifier_potatopatient_identifier_assigner_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn identifier_potatopatient_identifier_assigner_to_json(
  identifier_potatopatient_identifier_assigner: IdentifierPotatopatientIdentifierAssigner,
) -> Json {
  let fields = []
  let fields = case identifier_potatopatient_identifier_assigner.type_ {
    Some(v) -> [#("type", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier_assigner.reference {
    Some(v) -> [#("reference", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier_assigner.identifier {
    Some(v) -> [#("identifier", potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier_assigner.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier_assigner.display {
    Some(v) -> [#("display", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn identifier_potatopatient_identifier_type_to_json(
  identifier_potatopatient_identifier_type: IdentifierPotatopatientIdentifierType,
) -> Json {
  let fields = []
  let fields = case identifier_potatopatient_identifier_type.text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier_type.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case identifier_potatopatient_identifier_type.coding {
    [] -> fields
    values -> [#("coding", json.array(values, potatocoding_to_json)), ..fields]
  }
  json.object(fields)
}

pub type MetaPotatoconditionMeta {
  MetaPotatoconditionMeta(
    id: Option(String),
    last_updated: Option(Instant),
    profile: List(String),
    security: List(CodingOmitExtension),
    source: Option(String),
    tag: List(CodingOmitExtension),
    version_id: Option(String),
  )
}

pub fn meta_potatocondition_meta_new() -> MetaPotatoconditionMeta {
  MetaPotatoconditionMeta(
    id: None,
    last_updated: None,
    profile: [],
    security: [],
    source: None,
    tag: [],
    version_id: None,
  )
}

pub fn meta_potatocondition_meta_to_json(
  meta_potatocondition_meta: MetaPotatoconditionMeta,
) -> Json {
  let fields = []
  let fields = case meta_potatocondition_meta.version_id {
    Some(v) -> [#("versionId", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta_potatocondition_meta.tag {
    [] -> fields
    values -> [
      #(
        "tag",
        json.array(values, fn(value) { coding_omit_extension_to_json(value) }),
      ),
      ..fields
    ]
  }
  let fields = case meta_potatocondition_meta.source {
    Some(v) -> [#("source", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta_potatocondition_meta.security {
    [] -> fields
    values -> [
      #(
        "security",
        json.array(values, fn(value) { coding_omit_extension_to_json(value) }),
      ),
      ..fields
    ]
  }
  let fields = case meta_potatocondition_meta.profile {
    [] -> fields
    values -> [#("profile", json.array(values, json.string)), ..fields]
  }
  let fields = case meta_potatocondition_meta.last_updated {
    Some(v) -> [#("lastUpdated", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case meta_potatocondition_meta.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type MetaPotatoencounterMeta {
  MetaPotatoencounterMeta(
    id: Option(String),
    last_updated: Option(Instant),
    profile: List(String),
    security: List(CodingOmitExtension),
    source: Option(String),
    tag: List(CodingOmitExtension),
    version_id: Option(String),
  )
}

pub fn meta_potatoencounter_meta_new() -> MetaPotatoencounterMeta {
  MetaPotatoencounterMeta(
    id: None,
    last_updated: None,
    profile: [],
    security: [],
    source: None,
    tag: [],
    version_id: None,
  )
}

pub fn meta_potatoencounter_meta_to_json(
  meta_potatoencounter_meta: MetaPotatoencounterMeta,
) -> Json {
  let fields = []
  let fields = case meta_potatoencounter_meta.version_id {
    Some(v) -> [#("versionId", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta_potatoencounter_meta.tag {
    [] -> fields
    values -> [
      #(
        "tag",
        json.array(values, fn(value) { coding_omit_extension_to_json(value) }),
      ),
      ..fields
    ]
  }
  let fields = case meta_potatoencounter_meta.source {
    Some(v) -> [#("source", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta_potatoencounter_meta.security {
    [] -> fields
    values -> [
      #(
        "security",
        json.array(values, fn(value) { coding_omit_extension_to_json(value) }),
      ),
      ..fields
    ]
  }
  let fields = case meta_potatoencounter_meta.profile {
    [] -> fields
    values -> [#("profile", json.array(values, json.string)), ..fields]
  }
  let fields = case meta_potatoencounter_meta.last_updated {
    Some(v) -> [#("lastUpdated", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case meta_potatoencounter_meta.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoaddress_decoder() -> Decoder(Potatoaddress) {
  use <- decode.recursive
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.addressuse_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(valuesets.addresstype_decoder()),
  )
  use text <- decode_optional_string("text")
  use state <- decode_optional_string("state")
  use postal_code <- decode_optional_string("postalCode")
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(potatoperiod_decoder()),
  )
  use line <- decode.optional_field("line", [], decode.list(decode.string))
  use id <- decode_optional_string("id")
  use district <- decode_optional_string("district")
  use country <- decode_optional_string("country")
  use city <- decode_optional_string("city")
  let placeholder =
    Potatoaddress(
      use_:,
      type_:,
      text:,
      state:,
      postal_code:,
      period:,
      line:,
      id:,
      district:,
      country:,
      city:,
    )
  decode.success(placeholder)
}

pub fn potatoage_decoder() -> Decoder(Potatoage) {
  use <- decode.recursive
  use value <- decode.optional_field(
    "value",
    None,
    decode.optional(decode_number()),
  )
  use unit <- decode_optional_string("unit")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use comparator <- decode.optional_field(
    "comparator",
    None,
    decode.optional(valuesets.quantitycomparator_decoder()),
  )
  use code <- decode_optional_string("code")
  let placeholder = Potatoage(value:, unit:, system:, id:, comparator:, code:)
  decode.success(placeholder)
}

pub fn potatoannotation_author_decoder() -> Decoder(PotatoannotationAuthor) {
  decode.one_of(
    {
      use value <- decode.field("authorReference", potatoreference_decoder())
      decode.success(PotatoannotationAuthorReference(value))
    },
    [
      {
        use value <- decode.field("authorString", decode.string)
        decode.success(PotatoannotationAuthorString(value))
      },
    ],
  )
}

pub fn potatoannotation_decoder() -> Decoder(Potatoannotation) {
  use <- decode.recursive
  use time <- decode.optional_field(
    "time",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use text <- decode.field("text", decode.string)
  use id <- decode_optional_string("id")
  use author <- decode.then(none_if_omitted(potatoannotation_author_decoder()))
  let placeholder = Potatoannotation(time:, text:, id:, author:)
  decode.success(placeholder)
}

pub fn potatoattachment_decoder() -> Decoder(Potatoattachment) {
  use <- decode.recursive
  use url <- decode_optional_string("url")
  use title <- decode_optional_string("title")
  use size <- decode.optional_field("size", None, decode.optional(decode.int))
  use language <- decode_optional_string("language")
  use id <- decode_optional_string("id")
  use hash <- decode_optional_string("hash")
  use data <- decode_optional_string("data")
  use creation <- decode.optional_field(
    "creation",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use content_type <- decode_optional_string("contentType")
  let placeholder =
    Potatoattachment(
      url:,
      title:,
      size:,
      language:,
      id:,
      hash:,
      data:,
      creation:,
      content_type:,
    )
  decode.success(placeholder)
}

pub fn potatocodeableconcept_decoder() -> Decoder(Potatocodeableconcept) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder = Potatocodeableconcept(text:, id:, coding:)
  decode.success(placeholder)
}

pub fn potatocoding_decoder() -> Decoder(Potatocoding) {
  use <- decode.recursive
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode_optional_string("code")
  let placeholder =
    Potatocoding(version:, user_selected:, system:, id:, display:, code:)
  decode.success(placeholder)
}

pub fn potatocontactpoint_decoder() -> Decoder(Potatocontactpoint) {
  use <- decode.recursive
  use value <- decode_optional_string("value")
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.contactpointuse_decoder()),
  )
  use system <- decode.optional_field(
    "system",
    None,
    decode.optional(valuesets.contactpointsystem_decoder()),
  )
  use rank <- decode.optional_field("rank", None, decode.optional(decode.int))
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(potatoperiod_decoder()),
  )
  use id <- decode_optional_string("id")
  let placeholder =
    Potatocontactpoint(value:, use_:, system:, rank:, period:, id:)
  decode.success(placeholder)
}

pub fn potatodosage_doseandrate_rate_decoder() -> Decoder(
  PotatodosageDoseandrateRate,
) {
  decode.one_of(
    {
      use value <- decode.field("rateRatio", potatoratio_decoder())
      decode.success(PotatodosageDoseandrateRateRatio(value))
    },
    [
      {
        use value <- decode.field("rateRange", potatorange_decoder())
        decode.success(PotatodosageDoseandrateRateRange(value))
      },
      {
        use value <- decode.field(
          "rateQuantity",
          potatosimplequantity_decoder(),
        )
        decode.success(PotatodosageDoseandrateRateQuantity(value))
      },
    ],
  )
}

pub fn potatodosage_doseandrate_dose_decoder() -> Decoder(
  PotatodosageDoseandrateDose,
) {
  decode.one_of(
    {
      use value <- decode.field("doseRange", potatorange_decoder())
      decode.success(PotatodosageDoseandrateDoseRange(value))
    },
    [
      {
        use value <- decode.field(
          "doseQuantity",
          potatosimplequantity_decoder(),
        )
        decode.success(PotatodosageDoseandrateDoseQuantity(value))
      },
    ],
  )
}

pub fn potatodosage_doseandrate_decoder() -> Decoder(PotatodosageDoseandrate) {
  use <- decode.recursive
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  use rate <- decode.then(
    none_if_omitted(potatodosage_doseandrate_rate_decoder()),
  )
  use id <- decode_optional_string("id")
  use dose <- decode.then(
    none_if_omitted(potatodosage_doseandrate_dose_decoder()),
  )
  let placeholder = PotatodosageDoseandrate(type_:, rate:, id:, dose:)
  decode.success(placeholder)
}

pub fn potatodosage_asneeded_decoder() -> Decoder(PotatodosageAsneeded) {
  decode.one_of(
    {
      use value <- decode.field("asNeededBoolean", decode.bool)
      decode.success(PotatodosageAsneededBoolean(value))
    },
    [
      {
        use value <- decode.field(
          "asNeededCodeableConcept",
          potatocodeableconcept_decoder(),
        )
        decode.success(PotatodosageAsneededCodeableconcept(value))
      },
    ],
  )
}

pub fn potatodosage_decoder() -> Decoder(Potatodosage) {
  use <- decode.recursive
  use timing <- decode.optional_field(
    "timing",
    None,
    decode.optional(potatotiming_decoder()),
  )
  use text <- decode_optional_string("text")
  use site <- decode.optional_field(
    "site",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  use sequence <- decode.optional_field(
    "sequence",
    None,
    decode.optional(decode.int),
  )
  use route <- decode.optional_field(
    "route",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  use patient_instruction <- decode_optional_string("patientInstruction")
  use method <- decode.optional_field(
    "method",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  use max_dose_per_period <- decode.optional_field(
    "maxDosePerPeriod",
    None,
    decode.optional(potatoratio_decoder()),
  )
  use max_dose_per_lifetime <- decode.optional_field(
    "maxDosePerLifetime",
    None,
    decode.optional(potatosimplequantity_decoder()),
  )
  use max_dose_per_administration <- decode.optional_field(
    "maxDosePerAdministration",
    None,
    decode.optional(potatosimplequantity_decoder()),
  )
  use id <- decode_optional_string("id")
  use dose_and_rate <- decode.optional_field(
    "doseAndRate",
    [],
    decode.list(potatodosage_doseandrate_decoder()),
  )
  use as_needed <- decode.then(none_if_omitted(potatodosage_asneeded_decoder()))
  use additional_instruction <- decode.optional_field(
    "additionalInstruction",
    [],
    decode.list(potatocodeableconcept_decoder()),
  )
  let placeholder =
    Potatodosage(
      timing:,
      text:,
      site:,
      sequence:,
      route:,
      patient_instruction:,
      method:,
      max_dose_per_period:,
      max_dose_per_lifetime:,
      max_dose_per_administration:,
      id:,
      dose_and_rate:,
      as_needed:,
      additional_instruction:,
    )
  decode.success(placeholder)
}

pub fn potatoduration_decoder() -> Decoder(Potatoduration) {
  use <- decode.recursive
  use value <- decode.optional_field(
    "value",
    None,
    decode.optional(decode_number()),
  )
  use unit <- decode_optional_string("unit")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use comparator <- decode.optional_field(
    "comparator",
    None,
    decode.optional(valuesets.quantitycomparator_decoder()),
  )
  use code <- decode_optional_string("code")
  let placeholder =
    Potatoduration(value:, unit:, system:, id:, comparator:, code:)
  decode.success(placeholder)
}

pub fn potatohumanname_decoder() -> Decoder(Potatohumanname) {
  use <- decode.recursive
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.nameuse_decoder()),
  )
  use text <- decode_optional_string("text")
  use suffix <- decode.optional_field("suffix", [], decode.list(decode.string))
  use prefix <- decode.optional_field("prefix", [], decode.list(decode.string))
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(potatoperiod_decoder()),
  )
  use id <- decode_optional_string("id")
  use given <- decode.optional_field("given", [], decode.list(decode.string))
  use family <- decode_optional_string("family")
  let placeholder =
    Potatohumanname(
      use_:,
      text:,
      suffix:,
      prefix:,
      period:,
      id:,
      given:,
      family:,
    )
  decode.success(placeholder)
}

pub fn potatoidentifier_decoder() -> Decoder(Potatoidentifier) {
  use <- decode.recursive
  use value <- decode_optional_string("value")
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.identifieruse_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  use system <- decode_optional_string("system")
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(potatoperiod_decoder()),
  )
  use id <- decode_optional_string("id")
  use assigner <- decode.optional_field(
    "assigner",
    None,
    decode.optional(potatoreference_decoder()),
  )
  let placeholder =
    Potatoidentifier(value:, use_:, type_:, system:, period:, id:, assigner:)
  decode.success(placeholder)
}

pub fn potatometa_decoder() -> Decoder(Potatometa) {
  use <- decode.recursive
  use version_id <- decode_optional_string("versionId")
  use tag <- decode.optional_field(
    "tag",
    [],
    decode.list(potatocoding_decoder()),
  )
  use source <- decode_optional_string("source")
  use security <- decode.optional_field(
    "security",
    [],
    decode.list(potatocoding_decoder()),
  )
  use profile <- decode.optional_field(
    "profile",
    [],
    decode.list(decode.string),
  )
  use last_updated <- decode.optional_field(
    "lastUpdated",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use id <- decode_optional_string("id")
  let placeholder =
    Potatometa(
      version_id:,
      tag:,
      source:,
      security:,
      profile:,
      last_updated:,
      id:,
    )
  decode.success(placeholder)
}

pub fn potatonarrative_decoder() -> Decoder(Potatonarrative) {
  use <- decode.recursive
  use status <- decode.field("status", valuesets.narrativestatus_decoder())
  use id <- decode_optional_string("id")
  use div <- decode.field("div", decode.string)
  let placeholder = Potatonarrative(status:, id:, div:)
  decode.success(placeholder)
}

pub fn potatoperiod_decoder() -> Decoder(Potatoperiod) {
  use <- decode.recursive
  use start <- decode.optional_field(
    "start",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use id <- decode_optional_string("id")
  use end <- decode.optional_field(
    "end",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  let placeholder = Potatoperiod(start:, id:, end:)
  decode.success(placeholder)
}

pub fn potatoquantity_decoder() -> Decoder(Potatoquantity) {
  use <- decode.recursive
  use value <- decode.optional_field(
    "value",
    None,
    decode.optional(decode_number()),
  )
  use unit <- decode_optional_string("unit")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use comparator <- decode.optional_field(
    "comparator",
    None,
    decode.optional(valuesets.quantitycomparator_decoder()),
  )
  use code <- decode_optional_string("code")
  let placeholder =
    Potatoquantity(value:, unit:, system:, id:, comparator:, code:)
  decode.success(placeholder)
}

pub fn potatorange_decoder() -> Decoder(Potatorange) {
  use <- decode.recursive
  use low <- decode.optional_field(
    "low",
    None,
    decode.optional(potatosimplequantity_decoder()),
  )
  use id <- decode_optional_string("id")
  use high <- decode.optional_field(
    "high",
    None,
    decode.optional(potatosimplequantity_decoder()),
  )
  let placeholder = Potatorange(low:, id:, high:)
  decode.success(placeholder)
}

pub fn potatoratio_decoder() -> Decoder(Potatoratio) {
  use <- decode.recursive
  use numerator <- decode.optional_field(
    "numerator",
    None,
    decode.optional(potatoquantity_decoder()),
  )
  use id <- decode_optional_string("id")
  use denominator <- decode.optional_field(
    "denominator",
    None,
    decode.optional(potatoquantity_decoder()),
  )
  let placeholder = Potatoratio(numerator:, id:, denominator:)
  decode.success(placeholder)
}

pub fn potatoreference_decoder() -> Decoder(Potatoreference) {
  use <- decode.recursive
  use type_ <- decode_optional_string("type")
  use reference <- decode_optional_string("reference")
  use identifier <- decode.optional_field(
    "identifier",
    None,
    decode.optional(potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  let placeholder =
    Potatoreference(type_:, reference:, identifier:, id:, display:)
  decode.success(placeholder)
}

pub fn potatosimplequantity_decoder() -> Decoder(Potatosimplequantity) {
  use <- decode.recursive
  use value <- decode.optional_field(
    "value",
    None,
    decode.optional(decode_number()),
  )
  use unit <- decode_optional_string("unit")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use code <- decode_optional_string("code")
  let placeholder = Potatosimplequantity(value:, unit:, system:, id:, code:)
  decode.success(placeholder)
}

pub fn potatotiming_repeat_bounds_decoder() -> Decoder(PotatotimingRepeatBounds) {
  decode.one_of(
    {
      use value <- decode.field("boundsDuration", potatoduration_decoder())
      decode.success(PotatotimingRepeatBoundsDuration(value))
    },
    [
      {
        use value <- decode.field("boundsRange", potatorange_decoder())
        decode.success(PotatotimingRepeatBoundsRange(value))
      },
      {
        use value <- decode.field("boundsPeriod", potatoperiod_decoder())
        decode.success(PotatotimingRepeatBoundsPeriod(value))
      },
    ],
  )
}

pub fn potatotiming_repeat_decoder() -> Decoder(PotatotimingRepeat) {
  use <- decode.recursive
  use when <- decode.optional_field(
    "when",
    [],
    decode.list(valuesets.eventtiming_decoder()),
  )
  use time_of_day <- decode.optional_field(
    "timeOfDay",
    [],
    decode.list(pt.time_decoder()),
  )
  use period_unit <- decode.optional_field(
    "periodUnit",
    None,
    decode.optional(valuesets.unitsoftime_decoder()),
  )
  use period_max <- decode.optional_field(
    "periodMax",
    None,
    decode.optional(decode_number()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(decode_number()),
  )
  use offset <- decode.optional_field(
    "offset",
    None,
    decode.optional(decode.int),
  )
  use id <- decode_optional_string("id")
  use frequency_max <- decode.optional_field(
    "frequencyMax",
    None,
    decode.optional(decode.int),
  )
  use frequency <- decode.optional_field(
    "frequency",
    None,
    decode.optional(decode.int),
  )
  use duration_unit <- decode.optional_field(
    "durationUnit",
    None,
    decode.optional(valuesets.unitsoftime_decoder()),
  )
  use duration_max <- decode.optional_field(
    "durationMax",
    None,
    decode.optional(decode_number()),
  )
  use duration <- decode.optional_field(
    "duration",
    None,
    decode.optional(decode_number()),
  )
  use day_of_week <- decode.optional_field(
    "dayOfWeek",
    [],
    decode.list(valuesets.daysofweek_decoder()),
  )
  use count_max <- decode.optional_field(
    "countMax",
    None,
    decode.optional(decode.int),
  )
  use count <- decode.optional_field("count", None, decode.optional(decode.int))
  use bounds <- decode.then(
    none_if_omitted(potatotiming_repeat_bounds_decoder()),
  )
  let placeholder =
    PotatotimingRepeat(
      when:,
      time_of_day:,
      period_unit:,
      period_max:,
      period:,
      offset:,
      id:,
      frequency_max:,
      frequency:,
      duration_unit:,
      duration_max:,
      duration:,
      day_of_week:,
      count_max:,
      count:,
      bounds:,
    )
  decode.success(placeholder)
}

pub fn potatotiming_decoder() -> Decoder(Potatotiming) {
  use <- decode.recursive
  use repeat <- decode.optional_field(
    "repeat",
    None,
    decode.optional(potatotiming_repeat_decoder()),
  )
  use id <- decode_optional_string("id")
  use event <- decode.optional_field(
    "event",
    [],
    decode.list(pt.datetime_decoder()),
  )
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  let placeholder = Potatotiming(repeat:, id:, event:, code:)
  decode.success(placeholder)
}

pub fn address_potatopatient_address_decoder() -> Decoder(
  AddressPotatopatientAddress,
) {
  use <- decode.recursive
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.addressuse_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(valuesets.addresstype_decoder()),
  )
  use text <- decode_optional_string("text")
  use state <- decode_optional_string("state")
  use postal_code <- decode_optional_string("postalCode")
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(period_omit_extension_decoder()),
  )
  use line <- decode.optional_field("line", [], decode.list(decode.string))
  use id <- decode_optional_string("id")
  use district <- decode_optional_string("district")
  use country <- decode_optional_string("country")
  use city <- decode_optional_string("city")
  let placeholder =
    AddressPotatopatientAddress(
      use_:,
      type_:,
      text:,
      state:,
      postal_code:,
      period:,
      line:,
      id:,
      district:,
      country:,
      city:,
    )
  decode.success(placeholder)
}

type CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSliceAccumulator {
  CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSliceAccumulator(
    required: List(
      CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSlice {
  CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSliceRequired(
    CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
  )
  CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSlices {
  CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSlices(
    required: List1(
      CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_decoder() -> Decoder(
  CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case
        valuesets.allergyintoleranceclinical_from_code_and_system(code, system)
      {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.allergyintoleranceclinical_decoder()),
  )
  let placeholder =
    CodeableconceptPotatoallergyintoleranceClinicalstatusCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatoallergyintolerance_clinicalstatus_decoder() -> Decoder(
  CodeableconceptPotatoallergyintoleranceClinicalstatus,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(
              valuesets.allergyintoleranceclinical_from_code_and_system(
                code,
                system,
              ),
            ),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSliceAccumulator(
        [],
        [],
      ),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatoallergyintoleranceClinicalstatusParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSlices(
          required:,
          open:,
        ))
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatoallergyintoleranceClinicalstatusCodingSlices(
          required: List1(
            first: codeableconcept_potatoallergyintolerance_clinicalstatus_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatoallergyintoleranceClinicalstatus slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatoallergyintoleranceClinicalstatus(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSliceAccumulator {
  CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSliceAccumulator(
    required: List(
      CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSlice {
  CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSliceRequired(
    CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
  )
  CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSlices {
  CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSlices(
    required: List1(
      CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_decoder() -> Decoder(
  CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case
        valuesets.allergyintoleranceverification_from_code_and_system(
          code,
          system,
        )
      {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.allergyintoleranceverification_decoder()),
  )
  let placeholder =
    CodeableconceptPotatoallergyintoleranceVerificationstatusCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatoallergyintolerance_verificationstatus_decoder() -> Decoder(
  CodeableconceptPotatoallergyintoleranceVerificationstatus,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(
              valuesets.allergyintoleranceverification_from_code_and_system(
                code,
                system,
              ),
            ),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSliceAccumulator(
        [],
        [],
      ),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatoallergyintoleranceVerificationstatusParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(
          CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSlices(
            required:,
            open:,
          ),
        )
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatoallergyintoleranceVerificationstatusCodingSlices(
          required: List1(
            first: codeableconcept_potatoallergyintolerance_verificationstatus_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatoallergyintoleranceVerificationstatus slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatoallergyintoleranceVerificationstatus(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSliceAccumulator {
  CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSliceAccumulator(
    required: List(
      CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSlice {
  CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSliceRequired(
    CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
  )
  CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSlices {
  CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSlices(
    required: List1(
      CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatocondition_category_screening_assessment_coding_required_decoder() -> Decoder(
  CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case
        valuesets.uscorescreeningassessmentconditioncategory_from_code_and_system(
          code,
          system,
        )
      {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(
      valuesets.uscorescreeningassessmentconditioncategory_decoder(),
    ),
  )
  let placeholder =
    CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatocondition_category_screening_assessment_decoder() -> Decoder(
  CodeableconceptPotatoconditionCategoryScreeningAssessment,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(
              valuesets.uscorescreeningassessmentconditioncategory_from_code_and_system(
                code,
                system,
              ),
            ),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatocondition_category_screening_assessment_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatocondition_category_screening_assessment_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSliceAccumulator(
        [],
        [],
      ),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatoconditionCategoryScreeningAssessmentParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(
          CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSlices(
            required:,
            open:,
          ),
        )
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatoconditionCategoryScreeningAssessmentCodingSlices(
          required: List1(
            first: codeableconcept_potatocondition_category_screening_assessment_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatoconditionCategoryScreeningAssessment slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatoconditionCategoryScreeningAssessment(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatoconditionCategoryUsCoreCodingSliceAccumulator {
  CodeableconceptPotatoconditionCategoryUsCoreCodingSliceAccumulator(
    required: List(CodeableconceptPotatoconditionCategoryUsCoreCodingRequired),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSlice {
  CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSliceRequired(
    CodeableconceptPotatoconditionCategoryUsCoreCodingRequired,
  )
  CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatoconditionCategoryUsCoreCodingSlices {
  CodeableconceptPotatoconditionCategoryUsCoreCodingSlices(
    required: List1(CodeableconceptPotatoconditionCategoryUsCoreCodingRequired),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatocondition_category_us_core_coding_required_decoder() -> Decoder(
  CodeableconceptPotatoconditionCategoryUsCoreCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case
        valuesets.uscoreproblemorhealthconcern_from_code_and_system(
          code,
          system,
        )
      {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.uscoreproblemorhealthconcern_decoder()),
  )
  let placeholder =
    CodeableconceptPotatoconditionCategoryUsCoreCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatocondition_category_us_core_decoder() -> Decoder(
  CodeableconceptPotatoconditionCategoryUsCore,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(
              valuesets.uscoreproblemorhealthconcern_from_code_and_system(
                code,
                system,
              ),
            ),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatocondition_category_us_core_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatocondition_category_us_core_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatoconditionCategoryUsCoreCodingSliceAccumulator([], []),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatoconditionCategoryUsCoreCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatoconditionCategoryUsCoreParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatoconditionCategoryUsCoreCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(CodeableconceptPotatoconditionCategoryUsCoreCodingSlices(
          required:,
          open:,
        ))
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatoconditionCategoryUsCoreCodingSlices(
          required: List1(
            first: codeableconcept_potatocondition_category_us_core_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatoconditionCategoryUsCore slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatoconditionCategoryUsCore(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatoconditionClinicalstatusCodingSliceAccumulator {
  CodeableconceptPotatoconditionClinicalstatusCodingSliceAccumulator(
    required: List(CodeableconceptPotatoconditionClinicalstatusCodingRequired),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatoconditionClinicalstatusParsedCodingSlice {
  CodeableconceptPotatoconditionClinicalstatusParsedCodingSliceRequired(
    CodeableconceptPotatoconditionClinicalstatusCodingRequired,
  )
  CodeableconceptPotatoconditionClinicalstatusParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatoconditionClinicalstatusCodingSlices {
  CodeableconceptPotatoconditionClinicalstatusCodingSlices(
    required: List1(CodeableconceptPotatoconditionClinicalstatusCodingRequired),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatocondition_clinicalstatus_coding_required_decoder() -> Decoder(
  CodeableconceptPotatoconditionClinicalstatusCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case valuesets.conditionclinical_from_code_and_system(code, system) {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.conditionclinical_decoder()),
  )
  let placeholder =
    CodeableconceptPotatoconditionClinicalstatusCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatocondition_clinicalstatus_decoder() -> Decoder(
  CodeableconceptPotatoconditionClinicalstatus,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(valuesets.conditionclinical_from_code_and_system(
              code,
              system,
            )),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatocondition_clinicalstatus_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatocondition_clinicalstatus_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionClinicalstatusParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionClinicalstatusParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatoconditionClinicalstatusCodingSliceAccumulator([], []),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatoconditionClinicalstatusParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatoconditionClinicalstatusCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatoconditionClinicalstatusParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatoconditionClinicalstatusCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(CodeableconceptPotatoconditionClinicalstatusCodingSlices(
          required:,
          open:,
        ))
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatoconditionClinicalstatusCodingSlices(
          required: List1(
            first: codeableconcept_potatocondition_clinicalstatus_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatoconditionClinicalstatus slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatoconditionClinicalstatus(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatoconditionVerificationstatusCodingSliceAccumulator {
  CodeableconceptPotatoconditionVerificationstatusCodingSliceAccumulator(
    required: List(
      CodeableconceptPotatoconditionVerificationstatusCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatoconditionVerificationstatusParsedCodingSlice {
  CodeableconceptPotatoconditionVerificationstatusParsedCodingSliceRequired(
    CodeableconceptPotatoconditionVerificationstatusCodingRequired,
  )
  CodeableconceptPotatoconditionVerificationstatusParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatoconditionVerificationstatusCodingSlices {
  CodeableconceptPotatoconditionVerificationstatusCodingSlices(
    required: List1(
      CodeableconceptPotatoconditionVerificationstatusCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatocondition_verificationstatus_coding_required_decoder() -> Decoder(
  CodeableconceptPotatoconditionVerificationstatusCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case valuesets.conditionverstatus_from_code_and_system(code, system) {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.conditionverstatus_decoder()),
  )
  let placeholder =
    CodeableconceptPotatoconditionVerificationstatusCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatocondition_verificationstatus_decoder() -> Decoder(
  CodeableconceptPotatoconditionVerificationstatus,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(valuesets.conditionverstatus_from_code_and_system(
              code,
              system,
            )),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatocondition_verificationstatus_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatocondition_verificationstatus_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionVerificationstatusParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatoconditionVerificationstatusParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatoconditionVerificationstatusCodingSliceAccumulator(
        [],
        [],
      ),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatoconditionVerificationstatusParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatoconditionVerificationstatusCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatoconditionVerificationstatusParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatoconditionVerificationstatusCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(CodeableconceptPotatoconditionVerificationstatusCodingSlices(
          required:,
          open:,
        ))
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatoconditionVerificationstatusCodingSlices(
          required: List1(
            first: codeableconcept_potatocondition_verificationstatus_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatoconditionVerificationstatus slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatoconditionVerificationstatus(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSliceAccumulator {
  CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSliceAccumulator(
    required: List(
      CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSlice {
  CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSliceRequired(
    CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
  )
  CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSlices {
  CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSlices(
    required: List1(
      CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatodocumentreference_category_uscore_coding_required_decoder() -> Decoder(
  CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case
        valuesets.uscoredocumentreferencecategory_from_code_and_system(
          code,
          system,
        )
      {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.uscoredocumentreferencecategory_decoder()),
  )
  let placeholder =
    CodeableconceptPotatodocumentreferenceCategoryUscoreCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatodocumentreference_category_uscore_decoder() -> Decoder(
  CodeableconceptPotatodocumentreferenceCategoryUscore,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(
              valuesets.uscoredocumentreferencecategory_from_code_and_system(
                code,
                system,
              ),
            ),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatodocumentreference_category_uscore_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatodocumentreference_category_uscore_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSliceAccumulator(
        [],
        [],
      ),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatodocumentreferenceCategoryUscoreParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSlices(
          required:,
          open:,
        ))
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatodocumentreferenceCategoryUscoreCodingSlices(
          required: List1(
            first: codeableconcept_potatodocumentreference_category_uscore_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatodocumentreferenceCategoryUscore slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatodocumentreferenceCategoryUscore(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

type CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSliceAccumulator {
  CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSliceAccumulator(
    required: List(
      CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

type CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSlice {
  CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSliceRequired(
    CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
  )
  CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSliceOpen(
    CodingOmitExtension,
  )
}

type CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSlices {
  CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSlices(
    required: List1(
      CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
    ),
    open: List(CodingOmitExtension),
  )
}

pub fn codeableconcept_potatomedicationrequest_category_us_core_coding_required_decoder() -> Decoder(
  CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case
        valuesets.medicationrequestcategory_from_code_and_system(code, system)
      {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.medicationrequestcategory_decoder()),
  )
  let placeholder =
    CodeableconceptPotatomedicationrequestCategoryUsCoreCodingRequired(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn codeableconcept_potatomedicationrequest_category_us_core_decoder() -> Decoder(
  CodeableconceptPotatomedicationrequestCategoryUsCore,
) {
  use <- decode.recursive
  use binding_matches <- decode.field(
    "coding",
    decode.list(
      decode.one_of(
        {
          use code <- decode.field("code", decode.string)
          use system <- decode.field("system", decode.string)
          decode.success(
            result.is_ok(
              valuesets.medicationrequestcategory_from_code_and_system(
                code,
                system,
              ),
            ),
          )
        },
        [decode.success(False)],
      ),
    ),
  )
  use _ <- decode.then(case list.any(binding_matches, fn(matches) { matches }) {
    True -> decode.success(Nil)
    False ->
      decode.failure(
        Nil,
        "need a coding with code + system from required ValueSet",
      )
  })
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding_base_values <- decode.optional_field(
    "coding",
    [],
    decode.list({
      use coding_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            coding_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      codeableconcept_potatomedicationrequest_category_us_core_coding_required_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(DiscriminatorDifferent),
              )
              decode.success(DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> DiscriminatorDifferent
        }
      {
        DiscriminatorMatches ->
          codeableconcept_potatomedicationrequest_category_us_core_coding_required_decoder()
          |> decode.map(
            CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSliceRequired,
          )
        DiscriminatorDifferent ->
          coding_omit_extension_decoder()
          |> decode.map(
            CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSliceOpen,
          )
      }
    }),
  )
  let coding_accumulator =
    list.index_fold(
      coding_base_values,
      CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSliceAccumulator(
        [],
        [],
      ),
      fn(accumulator, parsed, _index) {
        case parsed {
          CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSliceRequired(
            value,
          ) ->
            CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSliceAccumulator(
              ..accumulator,
              required: [value, ..accumulator.required],
            )
          CodeableconceptPotatomedicationrequestCategoryUsCoreParsedCodingSliceOpen(
            value,
          ) ->
            CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let coding_slices = {
    let accumulator = coding_accumulator
    let required = case list.reverse(accumulator.required) {
      [first, ..rest] -> Ok(List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 required coding",
            found: "0 required codings",
            path: ["coding", "required"],
          ),
        ])
    }
    let open = Ok(list.reverse(accumulator.open))
    case required, open {
      Ok(required), Ok(open) ->
        Ok(CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSlices(
          required:,
          open:,
        ))
      _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(required, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  let coding_slices_decoder = case coding_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        CodeableconceptPotatomedicationrequestCategoryUsCoreCodingSlices(
          required: List1(
            first: codeableconcept_potatomedicationrequest_category_us_core_coding_required_new(),
            rest: [],
          ),
          open: [],
        ),
        "CodeableconceptPotatomedicationrequestCategoryUsCore slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use coding_slices <- decode.then(coding_slices_decoder)
  decode.success(CodeableconceptPotatomedicationrequestCategoryUsCore(
    text:,
    id:,
    required: coding_slices.required,
    coding: coding_slices.open,
  ))
}

pub fn coding_potatoethnicity_extension_detailed_value_decoder() -> Decoder(
  CodingPotatoethnicityExtensionDetailedValue,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case valuesets.detailedethnicity_from_code_and_system(code, system) {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.detailedethnicity_decoder()),
  )
  let placeholder =
    CodingPotatoethnicityExtensionDetailedValue(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn coding_potatoethnicity_extension_ombcategory_value_decoder() -> Decoder(
  CodingPotatoethnicityExtensionOmbcategoryValue,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case valuesets.ombethnicitycategory_from_code_and_system(code, system) {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.ombethnicitycategory_decoder()),
  )
  let placeholder =
    CodingPotatoethnicityExtensionOmbcategoryValue(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn coding_potatorace_extension_detailed_value_decoder() -> Decoder(
  CodingPotatoraceExtensionDetailedValue,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case valuesets.detailedrace_from_code_and_system(code, system) {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.detailedrace_decoder()),
  )
  let placeholder =
    CodingPotatoraceExtensionDetailedValue(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn coding_potatorace_extension_ombcategory_value_decoder() -> Decoder(
  CodingPotatoraceExtensionOmbcategoryValue,
) {
  use <- decode.recursive
  use binding_code <- decode.optional_field(
    "code",
    None,
    decode.optional(decode.string),
  )
  use binding_system <- decode.optional_field(
    "system",
    None,
    decode.optional(decode.string),
  )
  use _ <- decode.then(case binding_code, binding_system {
    Some(code), Some(system) ->
      case valuesets.ombracecategory_from_code_and_system(code, system) {
        Ok(_) -> decode.success(Nil)
        Error(_) ->
          decode.failure(Nil, "need code + system from required ValueSet")
      }
    _, _ -> decode.failure(Nil, "need code + system from required ValueSet")
  })
  use version <- decode_optional_string("version")
  use user_selected <- decode_optional_bool("userSelected")
  use system <- decode_optional_string("system")
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(valuesets.ombracecategory_decoder()),
  )
  let placeholder =
    CodingPotatoraceExtensionOmbcategoryValue(
      version:,
      user_selected:,
      system:,
      id:,
      display:,
      code:,
    )
  decode.success(placeholder)
}

pub fn contactpoint_potatopatient_telecom_decoder() -> Decoder(
  ContactpointPotatopatientTelecom,
) {
  use <- decode.recursive
  use value <- decode.field("value", decode.string)
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.contactpointuse_decoder()),
  )
  use system <- decode.field("system", valuesets.contactpointsystem_decoder())
  use rank <- decode.optional_field("rank", None, decode.optional(decode.int))
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(period_omit_extension_decoder()),
  )
  use id <- decode_optional_string("id")
  let placeholder =
    ContactpointPotatopatientTelecom(
      value:,
      use_:,
      system:,
      rank:,
      period:,
      id:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_repeat_bounds_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionTimingRepeatBounds,
) {
  decode.one_of(
    {
      use value <- decode.field("boundsDuration", potatoduration_decoder())
      decode.success(
        DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsDuration(
          value,
        ),
      )
    },
    [
      {
        use value <- decode.field("boundsRange", potatorange_decoder())
        decode.success(
          DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsRange(
            value,
          ),
        )
      },
      {
        use value <- decode.field("boundsPeriod", potatoperiod_decoder())
        decode.success(
          DosagePotatomedicationrequestDosageinstructionTimingRepeatBoundsPeriod(
            value,
          ),
        )
      },
    ],
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_repeat_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionTimingRepeat,
) {
  use <- decode.recursive
  use when <- decode.optional_field(
    "when",
    [],
    decode.list(valuesets.eventtiming_decoder()),
  )
  use time_of_day <- decode.optional_field(
    "timeOfDay",
    [],
    decode.list(pt.time_decoder()),
  )
  use period_unit <- decode.optional_field(
    "periodUnit",
    None,
    decode.optional(valuesets.unitsoftime_decoder()),
  )
  use period_max <- decode.optional_field(
    "periodMax",
    None,
    decode.optional(decode_number()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(decode_number()),
  )
  use offset <- decode.optional_field(
    "offset",
    None,
    decode.optional(decode.int),
  )
  use id <- decode_optional_string("id")
  use frequency_max <- decode.optional_field(
    "frequencyMax",
    None,
    decode.optional(decode.int),
  )
  use frequency <- decode.optional_field(
    "frequency",
    None,
    decode.optional(decode.int),
  )
  use duration_unit <- decode.optional_field(
    "durationUnit",
    None,
    decode.optional(valuesets.unitsoftime_decoder()),
  )
  use duration_max <- decode.optional_field(
    "durationMax",
    None,
    decode.optional(decode_number()),
  )
  use duration <- decode.optional_field(
    "duration",
    None,
    decode.optional(decode_number()),
  )
  use day_of_week <- decode.optional_field(
    "dayOfWeek",
    [],
    decode.list(valuesets.daysofweek_decoder()),
  )
  use count_max <- decode.optional_field(
    "countMax",
    None,
    decode.optional(decode.int),
  )
  use count <- decode.optional_field("count", None, decode.optional(decode.int))
  use bounds <- decode.then(
    none_if_omitted(
      dosage_potatomedicationrequest_dosageinstruction_timing_repeat_bounds_decoder(),
    ),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionTimingRepeat(
      when:,
      time_of_day:,
      period_unit:,
      period_max:,
      period:,
      offset:,
      id:,
      frequency_max:,
      frequency:,
      duration_unit:,
      duration_max:,
      duration:,
      day_of_week:,
      count_max:,
      count:,
      bounds:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_timing_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionTiming,
) {
  use <- decode.recursive
  use repeat <- decode.optional_field(
    "repeat",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_timing_repeat_decoder(),
    ),
  )
  use id <- decode_optional_string("id")
  use event <- decode.optional_field(
    "event",
    [],
    decode.list(pt.datetime_decoder()),
  )
  use code <- decode.optional_field(
    "code",
    None,
    decode.optional(potatocodeableconcept_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionTiming(
      repeat:,
      id:,
      event:,
      code:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_site_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionSite,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionSite(text:, id:, coding:)
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_route_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionRoute,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionRoute(text:, id:, coding:)
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_method_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionMethod,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionMethod(text:, id:, coding:)
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod,
) {
  use <- decode.recursive
  use numerator <- decode.optional_field(
    "numerator",
    None,
    decode.optional(potatoquantity_decoder()),
  )
  use id <- decode_optional_string("id")
  use denominator <- decode.optional_field(
    "denominator",
    None,
    decode.optional(potatoquantity_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionMaxdoseperperiod(
      numerator:,
      id:,
      denominator:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_type_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionDoseandrateType,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionDoseandrateType(
      text:,
      id:,
      coding:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_rate_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionDoseandrateRate,
) {
  decode.one_of(
    {
      use value <- decode.field("rateRatio", potatoratio_decoder())
      decode.success(
        DosagePotatomedicationrequestDosageinstructionDoseandrateRateRatio(
          value,
        ),
      )
    },
    [
      {
        use value <- decode.field("rateRange", potatorange_decoder())
        decode.success(
          DosagePotatomedicationrequestDosageinstructionDoseandrateRateRange(
            value,
          ),
        )
      },
      {
        use value <- decode.field(
          "rateQuantity",
          potatosimplequantity_decoder(),
        )
        decode.success(
          DosagePotatomedicationrequestDosageinstructionDoseandrateRateQuantity(
            value,
          ),
        )
      },
    ],
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_dose_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionDoseandrateDose,
) {
  decode.one_of(
    {
      use value <- decode.field("doseQuantity", potatosimplequantity_decoder())
      decode.success(
        DosagePotatomedicationrequestDosageinstructionDoseandrateDoseQuantity(
          value,
        ),
      )
    },
    [
      {
        use value <- decode.field("doseRange", potatorange_decoder())
        decode.success(
          DosagePotatomedicationrequestDosageinstructionDoseandrateDoseRange(
            value,
          ),
        )
      },
    ],
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_doseandrate_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionDoseandrate,
) {
  use <- decode.recursive
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_doseandrate_type_decoder(),
    ),
  )
  use rate <- decode.then(
    none_if_omitted(
      dosage_potatomedicationrequest_dosageinstruction_doseandrate_rate_decoder(),
    ),
  )
  use id <- decode_optional_string("id")
  use dose <- decode.then(
    none_if_omitted(
      dosage_potatomedicationrequest_dosageinstruction_doseandrate_dose_decoder(),
    ),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionDoseandrate(
      type_:,
      rate:,
      id:,
      dose:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_additionalinstruction_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionAdditionalinstruction,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstructionAdditionalinstruction(
      text:,
      id:,
      coding:,
    )
  decode.success(placeholder)
}

pub fn dosage_potatomedicationrequest_dosageinstruction_asneeded_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstructionAsneeded,
) {
  decode.one_of(
    {
      use value <- decode.field("asNeededBoolean", decode.bool)
      decode.success(
        DosagePotatomedicationrequestDosageinstructionAsneededBoolean(value),
      )
    },
    [
      {
        use value <- decode.field(
          "asNeededCodeableConcept",
          potatocodeableconcept_decoder(),
        )
        decode.success(
          DosagePotatomedicationrequestDosageinstructionAsneededCodeableconcept(
            value,
          ),
        )
      },
    ],
  )
}

pub fn dosage_potatomedicationrequest_dosageinstruction_decoder() -> Decoder(
  DosagePotatomedicationrequestDosageinstruction,
) {
  use <- decode.recursive
  use timing <- decode.optional_field(
    "timing",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_timing_decoder(),
    ),
  )
  use text <- decode_optional_string("text")
  use site <- decode.optional_field(
    "site",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_site_decoder(),
    ),
  )
  use sequence <- decode.optional_field(
    "sequence",
    None,
    decode.optional(decode.int),
  )
  use route <- decode.optional_field(
    "route",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_route_decoder(),
    ),
  )
  use patient_instruction <- decode_optional_string("patientInstruction")
  use method <- decode.optional_field(
    "method",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_method_decoder(),
    ),
  )
  use max_dose_per_period <- decode.optional_field(
    "maxDosePerPeriod",
    None,
    decode.optional(
      dosage_potatomedicationrequest_dosageinstruction_maxdoseperperiod_decoder(),
    ),
  )
  use max_dose_per_lifetime <- decode.optional_field(
    "maxDosePerLifetime",
    None,
    decode.optional(quantity_omit_extension_comparator_decoder()),
  )
  use max_dose_per_administration <- decode.optional_field(
    "maxDosePerAdministration",
    None,
    decode.optional(quantity_omit_extension_comparator_decoder()),
  )
  use id <- decode_optional_string("id")
  use dose_and_rate <- decode.optional_field(
    "doseAndRate",
    [],
    decode.list(
      dosage_potatomedicationrequest_dosageinstruction_doseandrate_decoder(),
    ),
  )
  use as_needed <- decode.then(
    none_if_omitted(
      dosage_potatomedicationrequest_dosageinstruction_asneeded_decoder(),
    ),
  )
  use additional_instruction <- decode.optional_field(
    "additionalInstruction",
    [],
    decode.list(
      dosage_potatomedicationrequest_dosageinstruction_additionalinstruction_decoder(),
    ),
  )
  let placeholder =
    DosagePotatomedicationrequestDosageinstruction(
      timing:,
      text:,
      site:,
      sequence:,
      route:,
      patient_instruction:,
      method:,
      max_dose_per_period:,
      max_dose_per_lifetime:,
      max_dose_per_administration:,
      id:,
      dose_and_rate:,
      as_needed:,
      additional_instruction:,
    )
  decode.success(placeholder)
}

pub fn humanname_potatopatient_name_decoder() -> Decoder(
  HumannamePotatopatientName,
) {
  use <- decode.recursive
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.nameuse_decoder()),
  )
  use text <- decode_optional_string("text")
  use suffix <- decode.optional_field("suffix", [], decode.list(decode.string))
  use prefix <- decode.optional_field("prefix", [], decode.list(decode.string))
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(period_omit_extension_decoder()),
  )
  use id <- decode_optional_string("id")
  use given <- decode.optional_field("given", [], decode.list(decode.string))
  use family <- decode_optional_string("family")
  let placeholder =
    HumannamePotatopatientName(
      use_:,
      text:,
      suffix:,
      prefix:,
      period:,
      id:,
      given:,
      family:,
    )
  decode.success(placeholder)
}

pub fn identifier_potatoencounter_identifier_type_decoder() -> Decoder(
  IdentifierPotatoencounterIdentifierType,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder = IdentifierPotatoencounterIdentifierType(text:, id:, coding:)
  decode.success(placeholder)
}

pub fn identifier_potatoencounter_identifier_assigner_decoder() -> Decoder(
  IdentifierPotatoencounterIdentifierAssigner,
) {
  use <- decode.recursive
  use type_ <- decode_optional_string("type")
  use reference <- decode_optional_string("reference")
  use identifier <- decode.optional_field(
    "identifier",
    None,
    decode.optional(potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  let placeholder =
    IdentifierPotatoencounterIdentifierAssigner(
      type_:,
      reference:,
      identifier:,
      id:,
      display:,
    )
  decode.success(placeholder)
}

pub fn identifier_potatoencounter_identifier_decoder() -> Decoder(
  IdentifierPotatoencounterIdentifier,
) {
  use <- decode.recursive
  use value <- decode.field("value", decode.string)
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.identifieruse_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(identifier_potatoencounter_identifier_type_decoder()),
  )
  use system <- decode.field("system", decode.string)
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(period_omit_extension_decoder()),
  )
  use id <- decode_optional_string("id")
  use assigner <- decode.optional_field(
    "assigner",
    None,
    decode.optional(identifier_potatoencounter_identifier_assigner_decoder()),
  )
  let placeholder =
    IdentifierPotatoencounterIdentifier(
      value:,
      use_:,
      type_:,
      system:,
      period:,
      id:,
      assigner:,
    )
  decode.success(placeholder)
}

pub fn identifier_potatopatient_identifier_type_decoder() -> Decoder(
  IdentifierPotatopatientIdentifierType,
) {
  use <- decode.recursive
  use text <- decode_optional_string("text")
  use id <- decode_optional_string("id")
  use coding <- decode.optional_field(
    "coding",
    [],
    decode.list(potatocoding_decoder()),
  )
  let placeholder = IdentifierPotatopatientIdentifierType(text:, id:, coding:)
  decode.success(placeholder)
}

pub fn identifier_potatopatient_identifier_assigner_decoder() -> Decoder(
  IdentifierPotatopatientIdentifierAssigner,
) {
  use <- decode.recursive
  use type_ <- decode_optional_string("type")
  use reference <- decode_optional_string("reference")
  use identifier <- decode.optional_field(
    "identifier",
    None,
    decode.optional(potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use display <- decode_optional_string("display")
  let placeholder =
    IdentifierPotatopatientIdentifierAssigner(
      type_:,
      reference:,
      identifier:,
      id:,
      display:,
    )
  decode.success(placeholder)
}

pub fn identifier_potatopatient_identifier_decoder() -> Decoder(
  IdentifierPotatopatientIdentifier,
) {
  use <- decode.recursive
  use value <- decode.field("value", decode.string)
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.identifieruse_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(identifier_potatopatient_identifier_type_decoder()),
  )
  use system <- decode.field("system", decode.string)
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(period_omit_extension_decoder()),
  )
  use id <- decode_optional_string("id")
  use assigner <- decode.optional_field(
    "assigner",
    None,
    decode.optional(identifier_potatopatient_identifier_assigner_decoder()),
  )
  let placeholder =
    IdentifierPotatopatientIdentifier(
      value:,
      use_:,
      type_:,
      system:,
      period:,
      id:,
      assigner:,
    )
  decode.success(placeholder)
}

pub fn meta_potatocondition_meta_decoder() -> Decoder(MetaPotatoconditionMeta) {
  use <- decode.recursive
  use version_id <- decode_optional_string("versionId")
  use tag <- decode.optional_field(
    "tag",
    [],
    decode.list(coding_omit_extension_decoder()),
  )
  use source <- decode_optional_string("source")
  use security <- decode.optional_field(
    "security",
    [],
    decode.list(coding_omit_extension_decoder()),
  )
  use profile <- decode.optional_field(
    "profile",
    [],
    decode.list(decode.string),
  )
  use last_updated <- decode.optional_field(
    "lastUpdated",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use id <- decode_optional_string("id")
  let placeholder =
    MetaPotatoconditionMeta(
      version_id:,
      tag:,
      source:,
      security:,
      profile:,
      last_updated:,
      id:,
    )
  decode.success(placeholder)
}

pub fn meta_potatoencounter_meta_decoder() -> Decoder(MetaPotatoencounterMeta) {
  use <- decode.recursive
  use version_id <- decode_optional_string("versionId")
  use tag <- decode.optional_field(
    "tag",
    [],
    decode.list(coding_omit_extension_decoder()),
  )
  use source <- decode_optional_string("source")
  use security <- decode.optional_field(
    "security",
    [],
    decode.list(coding_omit_extension_decoder()),
  )
  use profile <- decode.optional_field(
    "profile",
    [],
    decode.list(decode.string),
  )
  use last_updated <- decode.optional_field(
    "lastUpdated",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use id <- decode_optional_string("id")
  let placeholder =
    MetaPotatoencounterMeta(
      version_id:,
      tag:,
      source:,
      security:,
      profile:,
      last_updated:,
      id:,
    )
  decode.success(placeholder)
}
