////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) resources

import fhir/hl7_fhir_us_core_7_0_0/complex_types.{
  type List1, decode_number, list1_decoder, list1_to_json, none_if_omitted,
} as ct
import fhir/hl7_fhir_us_core_7_0_0/primitive_types.{
  type Date, type DateTime, type Instant, type Time,
} as pt
import fhir/hl7_fhir_us_core_7_0_0/valuesets
import gleam/bool
import gleam/dynamic/decode.{type Decoder}
import gleam/int
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Appointment#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Appointment#resource)
pub type Appointment {
  Appointment(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    text: Option(ct.Narrative),
    contained: List(Resource),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    identifier: List(ct.Identifier),
    status: valuesets.Appointmentstatus,
    cancelation_reason: Option(ct.Codeableconcept),
    service_category: List(ct.Codeableconcept),
    service_type: List(ct.Codeableconcept),
    specialty: List(ct.Codeableconcept),
    appointment_type: Option(ct.Codeableconcept),
    reason_code: List(ct.Codeableconcept),
    reason_reference: List(ct.Reference),
    priority: Option(Int),
    description: Option(String),
    supporting_information: List(ct.Reference),
    start: Option(Instant),
    end: Option(Instant),
    minutes_duration: Option(Int),
    slot: List(ct.Reference),
    created: Option(DateTime),
    comment: Option(String),
    patient_instruction: Option(String),
    based_on: List(ct.Reference),
    participant: List1(AppointmentParticipant),
    requested_period: List(ct.Period),
  )
}

pub fn appointment_new(
  participant participant: List1(AppointmentParticipant),
  status status: valuesets.Appointmentstatus,
) -> Appointment {
  Appointment(
    requested_period: [],
    participant:,
    based_on: [],
    patient_instruction: None,
    comment: None,
    created: None,
    slot: [],
    minutes_duration: None,
    end: None,
    start: None,
    supporting_information: [],
    description: None,
    priority: None,
    reason_reference: [],
    reason_code: [],
    appointment_type: None,
    specialty: [],
    service_type: [],
    service_category: [],
    cancelation_reason: None,
    status:,
    identifier: [],
    modifier_extension: [],
    extension: [],
    contained: [],
    text: None,
    language: None,
    implicit_rules: None,
    meta: None,
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Appointment#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Appointment#resource)
pub type AppointmentParticipant {
  AppointmentParticipant(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    type_: List(ct.Codeableconcept),
    actor: Option(ct.Reference),
    required: Option(valuesets.Participantrequired),
    status: valuesets.Participationstatus,
    period: Option(ct.Period),
  )
}

pub fn appointment_participant_new(
  status status: valuesets.Participationstatus,
) -> AppointmentParticipant {
  AppointmentParticipant(
    period: None,
    status:,
    required: None,
    actor: None,
    type_: [],
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

pub fn appointment_participant_to_json(
  appointment_participant: AppointmentParticipant,
) -> Json {
  let fields = [
    #(
      "status",
      valuesets.participationstatus_to_json(appointment_participant.status),
    ),
  ]
  let fields = case appointment_participant.period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment_participant.required {
    Some(v) -> [
      #("required", valuesets.participantrequired_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case appointment_participant.actor {
    Some(v) -> [#("actor", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment_participant.type_ {
    [] -> fields
    _ -> [
      #(
        "type",
        json.array(appointment_participant.type_, ct.codeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment_participant.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(
          appointment_participant.modifier_extension,
          ct.extension_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case appointment_participant.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(appointment_participant.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment_participant.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn appointment_participant_decoder() -> Decoder(AppointmentParticipant) {
  use <- decode.recursive
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use status <- decode.field("status", valuesets.participationstatus_decoder())
  use required <- decode.optional_field(
    "required",
    None,
    decode.optional(valuesets.participantrequired_decoder()),
  )
  use actor <- decode.optional_field(
    "actor",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(AppointmentParticipant(
    period:,
    status:,
    required:,
    actor:,
    type_:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn appointment_to_json(appointment: Appointment) -> Json {
  let fields = [
    #(
      "participant",
      list1_to_json(appointment.participant, appointment_participant_to_json),
    ),
    #("status", valuesets.appointmentstatus_to_json(appointment.status)),
  ]
  let fields = case appointment.requested_period {
    [] -> fields
    _ -> [
      #(
        "requestedPeriod",
        json.array(appointment.requested_period, ct.period_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.based_on {
    [] -> fields
    _ -> [
      #("basedOn", json.array(appointment.based_on, ct.reference_to_json)),
      ..fields
    ]
  }
  let fields = case appointment.patient_instruction {
    Some(v) -> [#("patientInstruction", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.comment {
    Some(v) -> [#("comment", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.created {
    Some(v) -> [#("created", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.slot {
    [] -> fields
    _ -> [
      #("slot", json.array(appointment.slot, ct.reference_to_json)),
      ..fields
    ]
  }
  let fields = case appointment.minutes_duration {
    Some(v) -> [#("minutesDuration", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.end {
    Some(v) -> [#("end", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.start {
    Some(v) -> [#("start", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.supporting_information {
    [] -> fields
    _ -> [
      #(
        "supportingInformation",
        json.array(appointment.supporting_information, ct.reference_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.priority {
    Some(v) -> [#("priority", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.reason_reference {
    [] -> fields
    _ -> [
      #(
        "reasonReference",
        json.array(appointment.reason_reference, ct.reference_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.reason_code {
    [] -> fields
    _ -> [
      #(
        "reasonCode",
        json.array(appointment.reason_code, ct.codeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.appointment_type {
    Some(v) -> [#("appointmentType", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.specialty {
    [] -> fields
    _ -> [
      #(
        "specialty",
        json.array(appointment.specialty, ct.codeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.service_type {
    [] -> fields
    _ -> [
      #(
        "serviceType",
        json.array(appointment.service_type, ct.codeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.service_category {
    [] -> fields
    _ -> [
      #(
        "serviceCategory",
        json.array(appointment.service_category, ct.codeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.cancelation_reason {
    Some(v) -> [#("cancelationReason", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.identifier {
    [] -> fields
    _ -> [
      #("identifier", json.array(appointment.identifier, ct.identifier_to_json)),
      ..fields
    ]
  }
  let fields = case appointment.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(appointment.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case appointment.extension {
    [] -> fields
    _ -> [
      #("extension", json.array(appointment.extension, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case appointment.contained {
    [] -> fields
    _ -> [
      #("contained", json.array(appointment.contained, resource_to_json)),
      ..fields
    ]
  }
  let fields = case appointment.text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case appointment.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Appointment")), ..fields]
  json.object(fields)
}

pub fn appointment_decoder() -> Decoder(Appointment) {
  use <- decode.recursive
  use requested_period <- decode.optional_field(
    "requestedPeriod",
    [],
    decode.list(ct.period_decoder()),
  )
  use participant <- list1_decoder(
    "participant",
    appointment_participant_decoder(),
  )
  use based_on <- decode.optional_field(
    "basedOn",
    [],
    decode.list(ct.reference_decoder()),
  )
  use patient_instruction <- decode.optional_field(
    "patientInstruction",
    None,
    decode.optional(decode.string),
  )
  use comment <- decode.optional_field(
    "comment",
    None,
    decode.optional(decode.string),
  )
  use created <- decode.optional_field(
    "created",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use slot <- decode.optional_field(
    "slot",
    [],
    decode.list(ct.reference_decoder()),
  )
  use minutes_duration <- decode.optional_field(
    "minutesDuration",
    None,
    decode.optional(decode.int),
  )
  use end <- decode.optional_field(
    "end",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use start <- decode.optional_field(
    "start",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use supporting_information <- decode.optional_field(
    "supportingInformation",
    [],
    decode.list(ct.reference_decoder()),
  )
  use description <- decode.optional_field(
    "description",
    None,
    decode.optional(decode.string),
  )
  use priority <- decode.optional_field(
    "priority",
    None,
    decode.optional(decode.int),
  )
  use reason_reference <- decode.optional_field(
    "reasonReference",
    [],
    decode.list(ct.reference_decoder()),
  )
  use reason_code <- decode.optional_field(
    "reasonCode",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use appointment_type <- decode.optional_field(
    "appointmentType",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use specialty <- decode.optional_field(
    "specialty",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use service_type <- decode.optional_field(
    "serviceType",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use service_category <- decode.optional_field(
    "serviceCategory",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use cancelation_reason <- decode.optional_field(
    "cancelationReason",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use status <- decode.field("status", valuesets.appointmentstatus_decoder())
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.identifier_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.narrative_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Appointment",
    decode.failure(appointment_new(participant:, status:), "resourceType"),
  )
  decode.success(Appointment(
    requested_period:,
    participant:,
    based_on:,
    patient_instruction:,
    comment:,
    created:,
    slot:,
    minutes_duration:,
    end:,
    start:,
    supporting_information:,
    description:,
    priority:,
    reason_reference:,
    reason_code:,
    appointment_type:,
    specialty:,
    service_type:,
    service_category:,
    cancelation_reason:,
    status:,
    identifier:,
    modifier_extension:,
    extension:,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource)
pub type Bundle {
  Bundle(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    identifier: Option(ct.Identifier),
    type_: valuesets.Bundletype,
    timestamp: Option(Instant),
    total: Option(Int),
    link: List(BundleLink),
    entry: List(BundleEntry),
    signature: Option(ct.Signature),
  )
}

pub fn bundle_new(type_ type_: valuesets.Bundletype) -> Bundle {
  Bundle(
    signature: None,
    entry: [],
    link: [],
    total: None,
    timestamp: None,
    type_:,
    identifier: None,
    language: None,
    implicit_rules: None,
    meta: None,
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource)
pub type BundleLink {
  BundleLink(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    relation: String,
    url: String,
  )
}

pub fn bundle_link_new(
  url url: String,
  relation relation: String,
) -> BundleLink {
  BundleLink(url:, relation:, modifier_extension: [], extension: [], id: None)
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource)
pub type BundleEntry {
  BundleEntry(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    link: List(BundleLink),
    full_url: Option(String),
    resource: Option(Resource),
    search: Option(BundleEntrySearch),
    request: Option(BundleEntryRequest),
    response: Option(BundleEntryResponse),
  )
}

pub fn bundle_entry_new() -> BundleEntry {
  BundleEntry(
    response: None,
    request: None,
    search: None,
    resource: None,
    full_url: None,
    link: [],
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource)
pub type BundleEntrySearch {
  BundleEntrySearch(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    mode: Option(valuesets.Searchentrymode),
    score: Option(Float),
  )
}

pub fn bundle_entry_search_new() -> BundleEntrySearch {
  BundleEntrySearch(
    score: None,
    mode: None,
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource)
pub type BundleEntryRequest {
  BundleEntryRequest(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    method: valuesets.Httpverb,
    url: String,
    if_none_match: Option(String),
    if_modified_since: Option(Instant),
    if_match: Option(String),
    if_none_exist: Option(String),
  )
}

pub fn bundle_entry_request_new(
  url url: String,
  method method: valuesets.Httpverb,
) -> BundleEntryRequest {
  BundleEntryRequest(
    if_none_exist: None,
    if_match: None,
    if_modified_since: None,
    if_none_match: None,
    url:,
    method:,
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Bundle#resource)
pub type BundleEntryResponse {
  BundleEntryResponse(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    status: String,
    location: Option(String),
    etag: Option(String),
    last_modified: Option(Instant),
    outcome: Option(Resource),
  )
}

pub fn bundle_entry_response_new(status status: String) -> BundleEntryResponse {
  BundleEntryResponse(
    outcome: None,
    last_modified: None,
    etag: None,
    location: None,
    status:,
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

pub fn bundle_entry_response_to_json(
  bundle_entry_response: BundleEntryResponse,
) -> Json {
  let fields = [
    #("status", json.string(bundle_entry_response.status)),
  ]
  let fields = case bundle_entry_response.outcome {
    Some(v) -> [#("outcome", resource_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_response.last_modified {
    Some(v) -> [#("lastModified", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_response.etag {
    Some(v) -> [#("etag", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_response.location {
    Some(v) -> [#("location", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_response.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(
          bundle_entry_response.modifier_extension,
          ct.extension_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry_response.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(bundle_entry_response.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry_response.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn bundle_entry_response_decoder() -> Decoder(BundleEntryResponse) {
  use <- decode.recursive
  use outcome <- decode.optional_field(
    "outcome",
    None,
    decode.optional(resource_decoder()),
  )
  use last_modified <- decode.optional_field(
    "lastModified",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use etag <- decode.optional_field(
    "etag",
    None,
    decode.optional(decode.string),
  )
  use location <- decode.optional_field(
    "location",
    None,
    decode.optional(decode.string),
  )
  use status <- decode.field("status", decode.string)
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(BundleEntryResponse(
    outcome:,
    last_modified:,
    etag:,
    location:,
    status:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn bundle_entry_request_to_json(
  bundle_entry_request: BundleEntryRequest,
) -> Json {
  let fields = [
    #("url", json.string(bundle_entry_request.url)),
    #("method", valuesets.httpverb_to_json(bundle_entry_request.method)),
  ]
  let fields = case bundle_entry_request.if_none_exist {
    Some(v) -> [#("ifNoneExist", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_request.if_match {
    Some(v) -> [#("ifMatch", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_request.if_modified_since {
    Some(v) -> [#("ifModifiedSince", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_request.if_none_match {
    Some(v) -> [#("ifNoneMatch", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_request.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(
          bundle_entry_request.modifier_extension,
          ct.extension_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry_request.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(bundle_entry_request.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry_request.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn bundle_entry_request_decoder() -> Decoder(BundleEntryRequest) {
  use <- decode.recursive
  use if_none_exist <- decode.optional_field(
    "ifNoneExist",
    None,
    decode.optional(decode.string),
  )
  use if_match <- decode.optional_field(
    "ifMatch",
    None,
    decode.optional(decode.string),
  )
  use if_modified_since <- decode.optional_field(
    "ifModifiedSince",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use if_none_match <- decode.optional_field(
    "ifNoneMatch",
    None,
    decode.optional(decode.string),
  )
  use url <- decode.field("url", decode.string)
  use method <- decode.field("method", valuesets.httpverb_decoder())
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(BundleEntryRequest(
    if_none_exist:,
    if_match:,
    if_modified_since:,
    if_none_match:,
    url:,
    method:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn bundle_entry_search_to_json(
  bundle_entry_search: BundleEntrySearch,
) -> Json {
  let fields = []
  let fields = case bundle_entry_search.score {
    Some(v) -> [#("score", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_search.mode {
    Some(v) -> [#("mode", valuesets.searchentrymode_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry_search.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(bundle_entry_search.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry_search.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(bundle_entry_search.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry_search.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn bundle_entry_search_decoder() -> Decoder(BundleEntrySearch) {
  use <- decode.recursive
  use score <- decode.optional_field(
    "score",
    None,
    decode.optional(decode_number()),
  )
  use mode <- decode.optional_field(
    "mode",
    None,
    decode.optional(valuesets.searchentrymode_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(BundleEntrySearch(
    score:,
    mode:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn bundle_entry_to_json(bundle_entry: BundleEntry) -> Json {
  let fields = []
  let fields = case bundle_entry.response {
    Some(v) -> [#("response", bundle_entry_response_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry.request {
    Some(v) -> [#("request", bundle_entry_request_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry.search {
    Some(v) -> [#("search", bundle_entry_search_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry.resource {
    Some(v) -> [#("resource", resource_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry.full_url {
    Some(v) -> [#("fullUrl", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle_entry.link {
    [] -> fields
    _ -> [
      #("link", json.array(bundle_entry.link, bundle_link_to_json)),
      ..fields
    ]
  }
  let fields = case bundle_entry.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(bundle_entry.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case bundle_entry.extension {
    [] -> fields
    _ -> [
      #("extension", json.array(bundle_entry.extension, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case bundle_entry.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn bundle_entry_decoder() -> Decoder(BundleEntry) {
  use <- decode.recursive
  use response <- decode.optional_field(
    "response",
    None,
    decode.optional(bundle_entry_response_decoder()),
  )
  use request <- decode.optional_field(
    "request",
    None,
    decode.optional(bundle_entry_request_decoder()),
  )
  use search <- decode.optional_field(
    "search",
    None,
    decode.optional(bundle_entry_search_decoder()),
  )
  use resource <- decode.optional_field(
    "resource",
    None,
    decode.optional(resource_decoder()),
  )
  use full_url <- decode.optional_field(
    "fullUrl",
    None,
    decode.optional(decode.string),
  )
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(bundle_link_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(BundleEntry(
    response:,
    request:,
    search:,
    resource:,
    full_url:,
    link:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub type BundleEntryForgiving {
  BundleEntryForgiving(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    link: List(BundleLink),
    full_url: Option(String),
    resource: Option(Result(Resource, List(decode.DecodeError))),
    search: Option(BundleEntrySearch),
    request: Option(BundleEntryRequest),
    response: Option(BundleEntryResponse),
  )
}

pub fn bundle_entry_decoder_forgiving() -> Decoder(BundleEntryForgiving) {
  use <- decode.recursive
  use response <- decode.optional_field(
    "response",
    None,
    decode.optional(bundle_entry_response_decoder()),
  )
  use request <- decode.optional_field(
    "request",
    None,
    decode.optional(bundle_entry_request_decoder()),
  )
  use search <- decode.optional_field(
    "search",
    None,
    decode.optional(bundle_entry_search_decoder()),
  )
  use resource <- decode.optional_field(
    "resource",
    None,
    decode.optional(
      decode.one_of(resource_decoder() |> decode.map(Ok), [
        decode.dynamic
        |> decode.map(fn(res_json) { decode.run(res_json, resource_decoder()) }),
      ]),
    ),
  )
  use full_url <- decode.optional_field(
    "fullUrl",
    None,
    decode.optional(decode.string),
  )
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(bundle_link_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(BundleEntryForgiving(
    response:,
    request:,
    search:,
    resource:,
    full_url:,
    link:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn bundle_link_to_json(bundle_link: BundleLink) -> Json {
  let fields = [
    #("url", json.string(bundle_link.url)),
    #("relation", json.string(bundle_link.relation)),
  ]
  let fields = case bundle_link.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(bundle_link.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case bundle_link.extension {
    [] -> fields
    _ -> [
      #("extension", json.array(bundle_link.extension, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case bundle_link.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn bundle_link_decoder() -> Decoder(BundleLink) {
  use <- decode.recursive
  use url <- decode.field("url", decode.string)
  use relation <- decode.field("relation", decode.string)
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(BundleLink(
    url:,
    relation:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn bundle_to_json(bundle: Bundle) -> Json {
  let fields = [
    #("type", valuesets.bundletype_to_json(bundle.type_)),
  ]
  let fields = case bundle.signature {
    Some(v) -> [#("signature", ct.signature_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.entry {
    [] -> fields
    _ -> [#("entry", json.array(bundle.entry, bundle_entry_to_json)), ..fields]
  }
  let fields = case bundle.link {
    [] -> fields
    _ -> [#("link", json.array(bundle.link, bundle_link_to_json)), ..fields]
  }
  let fields = case bundle.total {
    Some(v) -> [#("total", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.timestamp {
    Some(v) -> [#("timestamp", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.identifier {
    Some(v) -> [#("identifier", ct.identifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case bundle.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Bundle")), ..fields]
  json.object(fields)
}

pub fn bundle_decoder() -> Decoder(Bundle) {
  use <- decode.recursive
  use signature <- decode.optional_field(
    "signature",
    None,
    decode.optional(ct.signature_decoder()),
  )
  use entry <- decode.optional_field(
    "entry",
    [],
    decode.list(bundle_entry_decoder()),
  )
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(bundle_link_decoder()),
  )
  use total <- decode.optional_field("total", None, decode.optional(decode.int))
  use timestamp <- decode.optional_field(
    "timestamp",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use type_ <- decode.field("type", valuesets.bundletype_decoder())
  use identifier <- decode.optional_field(
    "identifier",
    None,
    decode.optional(ct.identifier_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Bundle",
    decode.failure(bundle_new(type_:), "resourceType"),
  )
  decode.success(Bundle(
    signature:,
    entry:,
    link:,
    total:,
    timestamp:,
    type_:,
    identifier:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

pub type BundleForgiving {
  BundleForgiving(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    identifier: Option(ct.Identifier),
    type_: valuesets.Bundletype,
    timestamp: Option(Instant),
    total: Option(Int),
    link: List(BundleLink),
    entry: List(BundleEntryForgiving),
    signature: Option(ct.Signature),
  )
}

pub fn bundle_decoder_forgiving() -> Decoder(BundleForgiving) {
  use <- decode.recursive
  use signature <- decode.optional_field(
    "signature",
    None,
    decode.optional(ct.signature_decoder()),
  )
  use entry <- decode.optional_field(
    "entry",
    [],
    decode.list(bundle_entry_decoder_forgiving()),
  )
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(bundle_link_decoder()),
  )
  use total <- decode.optional_field("total", None, decode.optional(decode.int))
  use timestamp <- decode.optional_field(
    "timestamp",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use type_ <- decode.field("type", valuesets.bundletype_decoder())
  use identifier <- decode.optional_field(
    "identifier",
    None,
    decode.optional(ct.identifier_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Bundle",
    decode.failure(
      BundleForgiving(
        signature:,
        entry:,
        link:,
        total:,
        timestamp:,
        type_:,
        identifier:,
        language:,
        implicit_rules:,
        meta:,
        id:,
      ),
      "resourceType",
    ),
  )
  decode.success(BundleForgiving(
    signature:,
    entry:,
    link:,
    total:,
    timestamp:,
    type_:,
    identifier:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/OperationOutcome#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/OperationOutcome#resource)
pub type Operationoutcome {
  Operationoutcome(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    text: Option(ct.Narrative),
    contained: List(Resource),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    issue: List1(OperationoutcomeIssue),
  )
}

pub fn operationoutcome_new(
  issue issue: List1(OperationoutcomeIssue),
) -> Operationoutcome {
  Operationoutcome(
    issue:,
    modifier_extension: [],
    extension: [],
    contained: [],
    text: None,
    language: None,
    implicit_rules: None,
    meta: None,
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/OperationOutcome#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/OperationOutcome#resource)
pub type OperationoutcomeIssue {
  OperationoutcomeIssue(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    severity: valuesets.Issueseverity,
    code: valuesets.Issuetype,
    details: Option(ct.Codeableconcept),
    diagnostics: Option(String),
    location: List(String),
    expression: List(String),
  )
}

pub fn operationoutcome_issue_new(
  code code: valuesets.Issuetype,
  severity severity: valuesets.Issueseverity,
) -> OperationoutcomeIssue {
  OperationoutcomeIssue(
    expression: [],
    location: [],
    diagnostics: None,
    details: None,
    code:,
    severity:,
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

pub fn operationoutcome_issue_to_json(
  operationoutcome_issue: OperationoutcomeIssue,
) -> Json {
  let fields = [
    #("code", valuesets.issuetype_to_json(operationoutcome_issue.code)),
    #(
      "severity",
      valuesets.issueseverity_to_json(operationoutcome_issue.severity),
    ),
  ]
  let fields = case operationoutcome_issue.expression {
    [] -> fields
    _ -> [
      #(
        "expression",
        json.array(operationoutcome_issue.expression, json.string),
      ),
      ..fields
    ]
  }
  let fields = case operationoutcome_issue.location {
    [] -> fields
    _ -> [
      #("location", json.array(operationoutcome_issue.location, json.string)),
      ..fields
    ]
  }
  let fields = case operationoutcome_issue.diagnostics {
    Some(v) -> [#("diagnostics", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case operationoutcome_issue.details {
    Some(v) -> [#("details", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case operationoutcome_issue.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(
          operationoutcome_issue.modifier_extension,
          ct.extension_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case operationoutcome_issue.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(operationoutcome_issue.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case operationoutcome_issue.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn operationoutcome_issue_decoder() -> Decoder(OperationoutcomeIssue) {
  use <- decode.recursive
  use expression <- decode.optional_field(
    "expression",
    [],
    decode.list(decode.string),
  )
  use location <- decode.optional_field(
    "location",
    [],
    decode.list(decode.string),
  )
  use diagnostics <- decode.optional_field(
    "diagnostics",
    None,
    decode.optional(decode.string),
  )
  use details <- decode.optional_field(
    "details",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use code <- decode.field("code", valuesets.issuetype_decoder())
  use severity <- decode.field("severity", valuesets.issueseverity_decoder())
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(OperationoutcomeIssue(
    expression:,
    location:,
    diagnostics:,
    details:,
    code:,
    severity:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn operationoutcome_to_json(operationoutcome: Operationoutcome) -> Json {
  let fields = [
    #(
      "issue",
      list1_to_json(operationoutcome.issue, operationoutcome_issue_to_json),
    ),
  ]
  let fields = case operationoutcome.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(operationoutcome.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case operationoutcome.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(operationoutcome.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case operationoutcome.contained {
    [] -> fields
    _ -> [
      #("contained", json.array(operationoutcome.contained, resource_to_json)),
      ..fields
    ]
  }
  let fields = case operationoutcome.text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case operationoutcome.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case operationoutcome.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case operationoutcome.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case operationoutcome.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("OperationOutcome")), ..fields]
  json.object(fields)
}

pub fn operationoutcome_decoder() -> Decoder(Operationoutcome) {
  use <- decode.recursive
  use issue <- list1_decoder("issue", operationoutcome_issue_decoder())
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.narrative_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "OperationOutcome",
    decode.failure(operationoutcome_new(issue:), "resourceType"),
  )
  decode.success(Operationoutcome(
    issue:,
    modifier_extension:,
    extension:,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Parameters#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Parameters#resource)
pub type Parameters {
  Parameters(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    parameter: List(ParametersParameter),
  )
}

pub fn parameters_new() -> Parameters {
  Parameters(
    parameter: [],
    language: None,
    implicit_rules: None,
    meta: None,
    id: None,
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Parameters#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Parameters#resource)
pub type ParametersParameter {
  ParametersParameter(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    name: String,
    value: Option(ParametersParameterValue),
    resource: Option(Resource),
    part: List(ParametersParameter),
  )
}

///[http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Parameters#resource](http://hl7.org/fhir/hl7_fhir_us_core_7_0_0/StructureDefinition/Parameters#resource)
pub type ParametersParameterValue {
  ParametersParameterValueBase64binary(value: String)
  ParametersParameterValueBoolean(value: Bool)
  ParametersParameterValueCanonical(value: String)
  ParametersParameterValueCode(value: String)
  ParametersParameterValueDate(value: Date)
  ParametersParameterValueDatetime(value: DateTime)
  ParametersParameterValueDecimal(value: Float)
  ParametersParameterValueId(value: String)
  ParametersParameterValueInstant(value: Instant)
  ParametersParameterValueInteger(value: Int)
  ParametersParameterValueMarkdown(value: String)
  ParametersParameterValueOid(value: String)
  ParametersParameterValuePositiveint(value: Int)
  ParametersParameterValueString(value: String)
  ParametersParameterValueTime(value: Time)
  ParametersParameterValueUnsignedint(value: Int)
  ParametersParameterValueUri(value: String)
  ParametersParameterValueUrl(value: String)
  ParametersParameterValueUuid(value: String)
  ParametersParameterValueAddress(value: ct.Address)
  ParametersParameterValueAge(value: ct.Age)
  ParametersParameterValueAnnotation(value: ct.Annotation)
  ParametersParameterValueAttachment(value: ct.Attachment)
  ParametersParameterValueCodeableconcept(value: ct.Codeableconcept)
  ParametersParameterValueCoding(value: ct.Coding)
  ParametersParameterValueContactpoint(value: ct.Contactpoint)
  ParametersParameterValueCount(value: ct.Count)
  ParametersParameterValueDistance(value: ct.Distance)
  ParametersParameterValueDuration(value: ct.Duration)
  ParametersParameterValueHumanname(value: ct.Humanname)
  ParametersParameterValueIdentifier(value: ct.Identifier)
  ParametersParameterValueMoney(value: ct.Money)
  ParametersParameterValuePeriod(value: ct.Period)
  ParametersParameterValueQuantity(value: ct.Quantity)
  ParametersParameterValueRange(value: ct.Range)
  ParametersParameterValueRatio(value: ct.Ratio)
  ParametersParameterValueReference(value: ct.Reference)
  ParametersParameterValueSampleddata(value: ct.Sampleddata)
  ParametersParameterValueSignature(value: ct.Signature)
  ParametersParameterValueTiming(value: ct.Timing)
  ParametersParameterValueContactdetail(value: ct.Contactdetail)
  ParametersParameterValueContributor(value: ct.Contributor)
  ParametersParameterValueDatarequirement(value: ct.Datarequirement)
  ParametersParameterValueExpression(value: ct.Expression)
  ParametersParameterValueParameterdefinition(value: ct.Parameterdefinition)
  ParametersParameterValueRelatedartifact(value: ct.Relatedartifact)
  ParametersParameterValueTriggerdefinition(value: ct.Triggerdefinition)
  ParametersParameterValueUsagecontext(value: ct.Usagecontext)
  ParametersParameterValueDosage(value: ct.Dosage)
  ParametersParameterValueMeta(value: ct.Meta)
}

pub fn parameters_parameter_value_to_json(
  elt: ParametersParameterValue,
) -> Json {
  case elt {
    ParametersParameterValueBase64binary(v) -> json.string(v)
    ParametersParameterValueBoolean(v) -> json.bool(v)
    ParametersParameterValueCanonical(v) -> json.string(v)
    ParametersParameterValueCode(v) -> json.string(v)
    ParametersParameterValueDate(v) -> pt.date_to_json(v)
    ParametersParameterValueDatetime(v) -> pt.datetime_to_json(v)
    ParametersParameterValueDecimal(v) -> json.float(v)
    ParametersParameterValueId(v) -> json.string(v)
    ParametersParameterValueInstant(v) -> pt.instant_to_json(v)
    ParametersParameterValueInteger(v) -> json.int(v)
    ParametersParameterValueMarkdown(v) -> json.string(v)
    ParametersParameterValueOid(v) -> json.string(v)
    ParametersParameterValuePositiveint(v) -> json.int(v)
    ParametersParameterValueString(v) -> json.string(v)
    ParametersParameterValueTime(v) -> pt.time_to_json(v)
    ParametersParameterValueUnsignedint(v) -> json.int(v)
    ParametersParameterValueUri(v) -> json.string(v)
    ParametersParameterValueUrl(v) -> json.string(v)
    ParametersParameterValueUuid(v) -> json.string(v)
    ParametersParameterValueAddress(v) -> ct.address_to_json(v)
    ParametersParameterValueAge(v) -> ct.age_to_json(v)
    ParametersParameterValueAnnotation(v) -> ct.annotation_to_json(v)
    ParametersParameterValueAttachment(v) -> ct.attachment_to_json(v)
    ParametersParameterValueCodeableconcept(v) -> ct.codeableconcept_to_json(v)
    ParametersParameterValueCoding(v) -> ct.coding_to_json(v)
    ParametersParameterValueContactpoint(v) -> ct.contactpoint_to_json(v)
    ParametersParameterValueCount(v) -> ct.count_to_json(v)
    ParametersParameterValueDistance(v) -> ct.distance_to_json(v)
    ParametersParameterValueDuration(v) -> ct.duration_to_json(v)
    ParametersParameterValueHumanname(v) -> ct.humanname_to_json(v)
    ParametersParameterValueIdentifier(v) -> ct.identifier_to_json(v)
    ParametersParameterValueMoney(v) -> ct.money_to_json(v)
    ParametersParameterValuePeriod(v) -> ct.period_to_json(v)
    ParametersParameterValueQuantity(v) -> ct.quantity_to_json(v)
    ParametersParameterValueRange(v) -> ct.range_to_json(v)
    ParametersParameterValueRatio(v) -> ct.ratio_to_json(v)
    ParametersParameterValueReference(v) -> ct.reference_to_json(v)
    ParametersParameterValueSampleddata(v) -> ct.sampleddata_to_json(v)
    ParametersParameterValueSignature(v) -> ct.signature_to_json(v)
    ParametersParameterValueTiming(v) -> ct.timing_to_json(v)
    ParametersParameterValueContactdetail(v) -> ct.contactdetail_to_json(v)
    ParametersParameterValueContributor(v) -> ct.contributor_to_json(v)
    ParametersParameterValueDatarequirement(v) -> ct.datarequirement_to_json(v)
    ParametersParameterValueExpression(v) -> ct.expression_to_json(v)
    ParametersParameterValueParameterdefinition(v) ->
      ct.parameterdefinition_to_json(v)
    ParametersParameterValueRelatedartifact(v) -> ct.relatedartifact_to_json(v)
    ParametersParameterValueTriggerdefinition(v) ->
      ct.triggerdefinition_to_json(v)
    ParametersParameterValueUsagecontext(v) -> ct.usagecontext_to_json(v)
    ParametersParameterValueDosage(v) -> ct.dosage_to_json(v)
    ParametersParameterValueMeta(v) -> ct.meta_to_json(v)
  }
}

pub fn parameters_parameter_value_decoder() -> Decoder(ParametersParameterValue) {
  decode.one_of(
    decode.field("valueBase64Binary", decode.string, decode.success)
      |> decode.map(ParametersParameterValueBase64binary),
    [
      decode.field("valueBoolean", decode.bool, decode.success)
        |> decode.map(ParametersParameterValueBoolean),
      decode.field("valueCanonical", decode.string, decode.success)
        |> decode.map(ParametersParameterValueCanonical),
      decode.field("valueCode", decode.string, decode.success)
        |> decode.map(ParametersParameterValueCode),
      decode.field("valueDate", pt.date_decoder(), decode.success)
        |> decode.map(ParametersParameterValueDate),
      decode.field("valueDateTime", pt.datetime_decoder(), decode.success)
        |> decode.map(ParametersParameterValueDatetime),
      decode.field("valueDecimal", decode_number(), decode.success)
        |> decode.map(ParametersParameterValueDecimal),
      decode.field("valueId", decode.string, decode.success)
        |> decode.map(ParametersParameterValueId),
      decode.field("valueInstant", pt.instant_decoder(), decode.success)
        |> decode.map(ParametersParameterValueInstant),
      decode.field("valueInteger", decode.int, decode.success)
        |> decode.map(ParametersParameterValueInteger),
      decode.field("valueMarkdown", decode.string, decode.success)
        |> decode.map(ParametersParameterValueMarkdown),
      decode.field("valueOid", decode.string, decode.success)
        |> decode.map(ParametersParameterValueOid),
      decode.field("valuePositiveInt", decode.int, decode.success)
        |> decode.map(ParametersParameterValuePositiveint),
      decode.field("valueString", decode.string, decode.success)
        |> decode.map(ParametersParameterValueString),
      decode.field("valueTime", pt.time_decoder(), decode.success)
        |> decode.map(ParametersParameterValueTime),
      decode.field("valueUnsignedInt", decode.int, decode.success)
        |> decode.map(ParametersParameterValueUnsignedint),
      decode.field("valueUri", decode.string, decode.success)
        |> decode.map(ParametersParameterValueUri),
      decode.field("valueUrl", decode.string, decode.success)
        |> decode.map(ParametersParameterValueUrl),
      decode.field("valueUuid", decode.string, decode.success)
        |> decode.map(ParametersParameterValueUuid),
      decode.field("valueAddress", ct.address_decoder(), decode.success)
        |> decode.map(ParametersParameterValueAddress),
      decode.field("valueAge", ct.age_decoder(), decode.success)
        |> decode.map(ParametersParameterValueAge),
      decode.field("valueAnnotation", ct.annotation_decoder(), decode.success)
        |> decode.map(ParametersParameterValueAnnotation),
      decode.field("valueAttachment", ct.attachment_decoder(), decode.success)
        |> decode.map(ParametersParameterValueAttachment),
      decode.field(
        "valueCodeableConcept",
        ct.codeableconcept_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueCodeableconcept),
      decode.field("valueCoding", ct.coding_decoder(), decode.success)
        |> decode.map(ParametersParameterValueCoding),
      decode.field(
        "valueContactPoint",
        ct.contactpoint_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueContactpoint),
      decode.field("valueCount", ct.count_decoder(), decode.success)
        |> decode.map(ParametersParameterValueCount),
      decode.field("valueDistance", ct.distance_decoder(), decode.success)
        |> decode.map(ParametersParameterValueDistance),
      decode.field("valueDuration", ct.duration_decoder(), decode.success)
        |> decode.map(ParametersParameterValueDuration),
      decode.field("valueHumanName", ct.humanname_decoder(), decode.success)
        |> decode.map(ParametersParameterValueHumanname),
      decode.field("valueIdentifier", ct.identifier_decoder(), decode.success)
        |> decode.map(ParametersParameterValueIdentifier),
      decode.field("valueMoney", ct.money_decoder(), decode.success)
        |> decode.map(ParametersParameterValueMoney),
      decode.field("valuePeriod", ct.period_decoder(), decode.success)
        |> decode.map(ParametersParameterValuePeriod),
      decode.field("valueQuantity", ct.quantity_decoder(), decode.success)
        |> decode.map(ParametersParameterValueQuantity),
      decode.field("valueRange", ct.range_decoder(), decode.success)
        |> decode.map(ParametersParameterValueRange),
      decode.field("valueRatio", ct.ratio_decoder(), decode.success)
        |> decode.map(ParametersParameterValueRatio),
      decode.field("valueReference", ct.reference_decoder(), decode.success)
        |> decode.map(ParametersParameterValueReference),
      decode.field("valueSampledData", ct.sampleddata_decoder(), decode.success)
        |> decode.map(ParametersParameterValueSampleddata),
      decode.field("valueSignature", ct.signature_decoder(), decode.success)
        |> decode.map(ParametersParameterValueSignature),
      decode.field("valueTiming", ct.timing_decoder(), decode.success)
        |> decode.map(ParametersParameterValueTiming),
      decode.field(
        "valueContactDetail",
        ct.contactdetail_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueContactdetail),
      decode.field("valueContributor", ct.contributor_decoder(), decode.success)
        |> decode.map(ParametersParameterValueContributor),
      decode.field(
        "valueDataRequirement",
        ct.datarequirement_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueDatarequirement),
      decode.field("valueExpression", ct.expression_decoder(), decode.success)
        |> decode.map(ParametersParameterValueExpression),
      decode.field(
        "valueParameterDefinition",
        ct.parameterdefinition_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueParameterdefinition),
      decode.field(
        "valueRelatedArtifact",
        ct.relatedartifact_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueRelatedartifact),
      decode.field(
        "valueTriggerDefinition",
        ct.triggerdefinition_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueTriggerdefinition),
      decode.field(
        "valueUsageContext",
        ct.usagecontext_decoder(),
        decode.success,
      )
        |> decode.map(ParametersParameterValueUsagecontext),
      decode.field("valueDosage", ct.dosage_decoder(), decode.success)
        |> decode.map(ParametersParameterValueDosage),
      decode.field("valueMeta", ct.meta_decoder(), decode.success)
        |> decode.map(ParametersParameterValueMeta),
    ],
  )
}

pub fn parameters_parameter_new(name name: String) -> ParametersParameter {
  ParametersParameter(
    part: [],
    resource: None,
    value: None,
    name:,
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

pub fn parameters_parameter_to_json(
  parameters_parameter: ParametersParameter,
) -> Json {
  let fields = [
    #("name", json.string(parameters_parameter.name)),
  ]
  let fields = case parameters_parameter.part {
    [] -> fields
    _ -> [
      #(
        "part",
        json.array(parameters_parameter.part, parameters_parameter_to_json),
      ),
      ..fields
    ]
  }
  let fields = case parameters_parameter.resource {
    Some(v) -> [#("resource", resource_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case parameters_parameter.value {
    Some(v) -> [
      #(
        "value"
          <> case v {
          ParametersParameterValueBase64binary(_) -> "Base64Binary"
          ParametersParameterValueBoolean(_) -> "Boolean"
          ParametersParameterValueCanonical(_) -> "Canonical"
          ParametersParameterValueCode(_) -> "Code"
          ParametersParameterValueDate(_) -> "Date"
          ParametersParameterValueDatetime(_) -> "DateTime"
          ParametersParameterValueDecimal(_) -> "Decimal"
          ParametersParameterValueId(_) -> "Id"
          ParametersParameterValueInstant(_) -> "Instant"
          ParametersParameterValueInteger(_) -> "Integer"
          ParametersParameterValueMarkdown(_) -> "Markdown"
          ParametersParameterValueOid(_) -> "Oid"
          ParametersParameterValuePositiveint(_) -> "PositiveInt"
          ParametersParameterValueString(_) -> "String"
          ParametersParameterValueTime(_) -> "Time"
          ParametersParameterValueUnsignedint(_) -> "UnsignedInt"
          ParametersParameterValueUri(_) -> "Uri"
          ParametersParameterValueUrl(_) -> "Url"
          ParametersParameterValueUuid(_) -> "Uuid"
          ParametersParameterValueAddress(_) -> "Address"
          ParametersParameterValueAge(_) -> "Age"
          ParametersParameterValueAnnotation(_) -> "Annotation"
          ParametersParameterValueAttachment(_) -> "Attachment"
          ParametersParameterValueCodeableconcept(_) -> "CodeableConcept"
          ParametersParameterValueCoding(_) -> "Coding"
          ParametersParameterValueContactpoint(_) -> "ContactPoint"
          ParametersParameterValueCount(_) -> "Count"
          ParametersParameterValueDistance(_) -> "Distance"
          ParametersParameterValueDuration(_) -> "Duration"
          ParametersParameterValueHumanname(_) -> "HumanName"
          ParametersParameterValueIdentifier(_) -> "Identifier"
          ParametersParameterValueMoney(_) -> "Money"
          ParametersParameterValuePeriod(_) -> "Period"
          ParametersParameterValueQuantity(_) -> "Quantity"
          ParametersParameterValueRange(_) -> "Range"
          ParametersParameterValueRatio(_) -> "Ratio"
          ParametersParameterValueReference(_) -> "Reference"
          ParametersParameterValueSampleddata(_) -> "SampledData"
          ParametersParameterValueSignature(_) -> "Signature"
          ParametersParameterValueTiming(_) -> "Timing"
          ParametersParameterValueContactdetail(_) -> "ContactDetail"
          ParametersParameterValueContributor(_) -> "Contributor"
          ParametersParameterValueDatarequirement(_) -> "DataRequirement"
          ParametersParameterValueExpression(_) -> "Expression"
          ParametersParameterValueParameterdefinition(_) ->
            "ParameterDefinition"
          ParametersParameterValueRelatedartifact(_) -> "RelatedArtifact"
          ParametersParameterValueTriggerdefinition(_) -> "TriggerDefinition"
          ParametersParameterValueUsagecontext(_) -> "UsageContext"
          ParametersParameterValueDosage(_) -> "Dosage"
          ParametersParameterValueMeta(_) -> "Meta"
        },
        parameters_parameter_value_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case parameters_parameter.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(
          parameters_parameter.modifier_extension,
          ct.extension_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case parameters_parameter.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(parameters_parameter.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case parameters_parameter.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn parameters_parameter_decoder() -> Decoder(ParametersParameter) {
  use <- decode.recursive
  use part <- decode.optional_field(
    "part",
    [],
    decode.list(parameters_parameter_decoder()),
  )
  use resource <- decode.optional_field(
    "resource",
    None,
    decode.optional(resource_decoder()),
  )
  use value <- decode.then(
    none_if_omitted(parameters_parameter_value_decoder()),
  )
  use name <- decode.field("name", decode.string)
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.success(ParametersParameter(
    part:,
    resource:,
    value:,
    name:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn parameters_to_json(parameters: Parameters) -> Json {
  let fields = []
  let fields = case parameters.parameter {
    [] -> fields
    _ -> [
      #(
        "parameter",
        json.array(parameters.parameter, parameters_parameter_to_json),
      ),
      ..fields
    ]
  }
  let fields = case parameters.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case parameters.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case parameters.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case parameters.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Parameters")), ..fields]
  json.object(fields)
}

pub fn parameters_decoder() -> Decoder(Parameters) {
  use <- decode.recursive
  use parameter <- decode.optional_field(
    "parameter",
    [],
    decode.list(parameters_parameter_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Parameters",
    decode.failure(parameters_new(), "resourceType"),
  )
  decode.success(Parameters(parameter:, language:, implicit_rules:, meta:, id:))
}

pub type UsCoreAllergyintolerance {
  UsCoreAllergyintolerance(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    text: Option(ct.Narrative),
    contained: List(Resource),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    identifier: List(ct.Identifier),
    clinical_status: Option(
      ct.BoundCodeableconcept(valuesets.Allergyintoleranceclinical),
    ),
    verification_status: Option(
      ct.BoundCodeableconcept(valuesets.Allergyintoleranceverification),
    ),
    type_: Option(valuesets.Allergyintolerancetype),
    category: List(valuesets.Allergyintolerancecategory),
    criticality: Option(valuesets.Allergyintolerancecriticality),
    code: ct.Codeableconcept,
    patient: ct.Reference,
    encounter: Option(ct.Reference),
    onset: Option(UsCoreAllergyintoleranceOnset),
    recorded_date: Option(DateTime),
    recorder: Option(ct.Reference),
    asserter: Option(ct.Reference),
    last_occurrence: Option(DateTime),
    note: List(ct.Annotation),
    reaction: List(UsCoreAllergyintoleranceReaction),
  )
}

pub fn us_core_allergyintolerance_new(
  code code: ct.Codeableconcept,
  patient patient: ct.Reference,
) -> UsCoreAllergyintolerance {
  UsCoreAllergyintolerance(
    id: None,
    meta: Some({
      let meta = ct.meta_new()
      ct.Meta(..meta, profile: [
        "http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance",
      ])
    }),
    implicit_rules: None,
    language: None,
    text: None,
    contained: [],
    extension: [],
    modifier_extension: [],
    identifier: [],
    clinical_status: None,
    verification_status: None,
    type_: None,
    category: [],
    criticality: None,
    code:,
    patient:,
    encounter: None,
    onset: None,
    recorded_date: None,
    recorder: None,
    asserter: None,
    last_occurrence: None,
    note: [],
    reaction: [],
  )
}

pub type UsCoreAllergyintoleranceOnset {
  UsCoreAllergyintoleranceOnsetDatetime(value: DateTime)
  UsCoreAllergyintoleranceOnsetAge(value: ct.Age)
  UsCoreAllergyintoleranceOnsetPeriod(value: ct.Period)
  UsCoreAllergyintoleranceOnsetRange(value: ct.Range)
  UsCoreAllergyintoleranceOnsetString(value: String)
}

pub type UsCoreAllergyintoleranceReaction {
  UsCoreAllergyintoleranceReaction(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    substance: Option(ct.Codeableconcept),
    manifestation: List1(ct.Codeableconcept),
    description: Option(String),
    onset: Option(DateTime),
    severity: Option(valuesets.Reactioneventseverity),
    exposure_route: Option(ct.Codeableconcept),
    note: List(ct.Annotation),
  )
}

pub fn us_core_allergyintolerance_reaction_new(
  manifestation manifestation: List1(ct.Codeableconcept),
) -> UsCoreAllergyintoleranceReaction {
  UsCoreAllergyintoleranceReaction(
    id: None,
    extension: [],
    modifier_extension: [],
    substance: None,
    manifestation:,
    description: None,
    onset: None,
    severity: None,
    exposure_route: None,
    note: [],
  )
}

pub fn us_core_allergyintolerance_to_json(
  us_core_allergyintolerance: UsCoreAllergyintolerance,
) -> Json {
  let fields = [
    #("patient", ct.reference_to_json(us_core_allergyintolerance.patient)),
    #("code", ct.codeableconcept_to_json(us_core_allergyintolerance.code)),
  ]
  let fields = case us_core_allergyintolerance.reaction {
    [] -> fields
    values -> [
      #(
        "reaction",
        json.array(values, us_core_allergyintolerance_reaction_to_json),
      ),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance.note {
    [] -> fields
    values -> [#("note", json.array(values, ct.annotation_to_json)), ..fields]
  }
  let fields = case us_core_allergyintolerance.last_occurrence {
    Some(v) -> [#("lastOccurrence", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.asserter {
    Some(v) -> [#("asserter", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.recorder {
    Some(v) -> [#("recorder", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.recorded_date {
    Some(v) -> [#("recordedDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.onset {
    Some(v) -> [
      #(
        "onset"
          <> case v {
          UsCoreAllergyintoleranceOnsetDatetime(_) -> "DateTime"
          UsCoreAllergyintoleranceOnsetAge(_) -> "Age"
          UsCoreAllergyintoleranceOnsetPeriod(_) -> "Period"
          UsCoreAllergyintoleranceOnsetRange(_) -> "Range"
          UsCoreAllergyintoleranceOnsetString(_) -> "String"
        },
        us_core_allergyintolerance_onset_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.encounter {
    Some(v) -> [#("encounter", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.criticality {
    Some(v) -> [
      #("criticality", valuesets.allergyintolerancecriticality_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.category {
    [] -> fields
    values -> [
      #(
        "category",
        json.array(values, valuesets.allergyintolerancecategory_to_json),
      ),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance.type_ {
    Some(v) -> [
      #("type", valuesets.allergyintolerancetype_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.verification_status {
    Some(v) -> [
      #(
        "verificationStatus",
        ct.bound_codeableconcept_to_json(
          v,
          valuesets.allergyintoleranceverification_to_code,
          valuesets.allergyintoleranceverification_system,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.clinical_status {
    Some(v) -> [
      #(
        "clinicalStatus",
        ct.bound_codeableconcept_to_json(
          v,
          valuesets.allergyintoleranceclinical_to_code,
          valuesets.allergyintoleranceclinical_system,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.identifier_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance.modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance.extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case us_core_allergyintolerance.text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("AllergyIntolerance")), ..fields]
  json.object(fields)
}

pub fn us_core_allergyintolerance_onset_to_json(
  value: UsCoreAllergyintoleranceOnset,
) -> Json {
  case value {
    UsCoreAllergyintoleranceOnsetDatetime(value) -> pt.datetime_to_json(value)
    UsCoreAllergyintoleranceOnsetAge(value) -> ct.age_to_json(value)
    UsCoreAllergyintoleranceOnsetPeriod(value) -> ct.period_to_json(value)
    UsCoreAllergyintoleranceOnsetRange(value) -> ct.range_to_json(value)
    UsCoreAllergyintoleranceOnsetString(value) -> json.string(value)
  }
}

pub fn us_core_allergyintolerance_reaction_to_json(
  us_core_allergyintolerance_reaction: UsCoreAllergyintoleranceReaction,
) -> Json {
  let fields = [
    #(
      "manifestation",
      list1_to_json(
        us_core_allergyintolerance_reaction.manifestation,
        ct.codeableconcept_to_json,
      ),
    ),
  ]
  let fields = case us_core_allergyintolerance_reaction.note {
    [] -> fields
    values -> [#("note", json.array(values, ct.annotation_to_json)), ..fields]
  }
  let fields = case us_core_allergyintolerance_reaction.exposure_route {
    Some(v) -> [#("exposureRoute", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance_reaction.severity {
    Some(v) -> [
      #("severity", valuesets.reactioneventseverity_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_allergyintolerance_reaction.onset {
    Some(v) -> [#("onset", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance_reaction.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance_reaction.substance {
    Some(v) -> [#("substance", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_allergyintolerance_reaction.modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance_reaction.extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_allergyintolerance_reaction.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type UsCorePatient {
  UsCorePatient(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    text: Option(ct.Narrative),
    contained: List(Resource),
    extension: List(ct.Extension),
    race: Option(ct.UsCoreRace),
    ethnicity: Option(ct.UsCoreEthnicity),
    tribal_affiliation: List(ct.UsCoreTribalAffiliation),
    birthsex: Option(valuesets.Two16840111376214102124),
    sex: Option(String),
    gender_identity: List(ct.Codeableconcept),
    modifier_extension: List(ct.Extension),
    identifier: List1(ct.IdentifierRequiredSystemValue),
    active: Option(Bool),
    name: List1(ct.Humanname),
    telecom: List(ct.ContactpointUsCorePatientTelecom),
    gender: valuesets.Administrativegender,
    birth_date: Option(Date),
    deceased: Option(UsCorePatientDeceased),
    address: List(ct.Address),
    marital_status: Option(ct.Codeableconcept),
    multiple_birth: Option(UsCorePatientMultiplebirth),
    photo: List(ct.Attachment),
    contact: List(UsCorePatientContact),
    communication: List(UsCorePatientCommunication),
    general_practitioner: List(ct.Reference),
    managing_organization: Option(ct.Reference),
    link: List(UsCorePatientLink),
  )
}

pub fn us_core_patient_new(
  identifier identifier: List1(ct.IdentifierRequiredSystemValue),
  name name: List1(ct.Humanname),
  gender gender: valuesets.Administrativegender,
) -> UsCorePatient {
  UsCorePatient(
    id: None,
    meta: Some({
      let meta = ct.meta_new()
      ct.Meta(..meta, profile: [
        "http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient",
      ])
    }),
    implicit_rules: None,
    language: None,
    text: None,
    contained: [],
    extension: [],
    race: None,
    ethnicity: None,
    tribal_affiliation: [],
    birthsex: None,
    sex: None,
    gender_identity: [],
    modifier_extension: [],
    identifier:,
    active: None,
    name:,
    telecom: [],
    gender:,
    birth_date: None,
    deceased: None,
    address: [],
    marital_status: None,
    multiple_birth: None,
    photo: [],
    contact: [],
    communication: [],
    general_practitioner: [],
    managing_organization: None,
    link: [],
  )
}

pub type UsCorePatientMultiplebirth {
  UsCorePatientMultiplebirthBoolean(value: Bool)
  UsCorePatientMultiplebirthInteger(value: Int)
}

pub type UsCorePatientDeceased {
  UsCorePatientDeceasedBoolean(value: Bool)
  UsCorePatientDeceasedDatetime(value: DateTime)
}

pub type UsCorePatientCommunication {
  UsCorePatientCommunication(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    language: ct.Codeableconcept,
    preferred: Option(Bool),
  )
}

pub fn us_core_patient_communication_new(
  language language: ct.Codeableconcept,
) -> UsCorePatientCommunication {
  UsCorePatientCommunication(
    id: None,
    extension: [],
    modifier_extension: [],
    language:,
    preferred: None,
  )
}

pub type UsCorePatientContact {
  UsCorePatientContact(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    relationship: List(ct.Codeableconcept),
    name: Option(ct.Humanname),
    telecom: List(ct.Contactpoint),
    address: Option(ct.Address),
    gender: Option(valuesets.Administrativegender),
    organization: Option(ct.Reference),
    period: Option(ct.Period),
  )
}

pub fn us_core_patient_contact_new() -> UsCorePatientContact {
  UsCorePatientContact(
    id: None,
    extension: [],
    modifier_extension: [],
    relationship: [],
    name: None,
    telecom: [],
    address: None,
    gender: None,
    organization: None,
    period: None,
  )
}

pub type UsCorePatientLink {
  UsCorePatientLink(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    other: ct.Reference,
    type_: valuesets.Linktype,
  )
}

pub fn us_core_patient_link_new(
  other other: ct.Reference,
  type_ type_: valuesets.Linktype,
) -> UsCorePatientLink {
  UsCorePatientLink(
    id: None,
    extension: [],
    modifier_extension: [],
    other:,
    type_:,
  )
}

pub fn us_core_patient_to_json(us_core_patient: UsCorePatient) -> Json {
  let fields = [
    #("gender", valuesets.administrativegender_to_json(us_core_patient.gender)),
    #("name", list1_to_json(us_core_patient.name, ct.humanname_to_json)),
    #(
      "identifier",
      list1_to_json(us_core_patient.identifier, fn(value) {
        ct.identifier_required_system_value_to_json(value)
      }),
    ),
  ]
  let fields = case us_core_patient.link {
    [] -> fields
    values -> [
      #("link", json.array(values, us_core_patient_link_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient.managing_organization {
    Some(v) -> [#("managingOrganization", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.general_practitioner {
    [] -> fields
    values -> [
      #("generalPractitioner", json.array(values, ct.reference_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient.communication {
    [] -> fields
    values -> [
      #(
        "communication",
        json.array(values, us_core_patient_communication_to_json),
      ),
      ..fields
    ]
  }
  let fields = case us_core_patient.contact {
    [] -> fields
    values -> [
      #("contact", json.array(values, us_core_patient_contact_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient.photo {
    [] -> fields
    values -> [#("photo", json.array(values, ct.attachment_to_json)), ..fields]
  }
  let fields = case us_core_patient.multiple_birth {
    Some(v) -> [
      #(
        "multipleBirth"
          <> case v {
          UsCorePatientMultiplebirthBoolean(_) -> "Boolean"
          UsCorePatientMultiplebirthInteger(_) -> "Integer"
        },
        us_core_patient_multiplebirth_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_patient.marital_status {
    Some(v) -> [#("maritalStatus", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.address {
    [] -> fields
    values -> [#("address", json.array(values, ct.address_to_json)), ..fields]
  }
  let fields = case us_core_patient.deceased {
    Some(v) -> [
      #(
        "deceased"
          <> case v {
          UsCorePatientDeceasedBoolean(_) -> "Boolean"
          UsCorePatientDeceasedDatetime(_) -> "DateTime"
        },
        us_core_patient_deceased_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_patient.birth_date {
    Some(v) -> [#("birthDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.telecom {
    [] -> fields
    values -> [
      #(
        "telecom",
        json.array(values, ct.contactpoint_us_core_patient_telecom_to_json),
      ),
      ..fields
    ]
  }
  let fields = case us_core_patient.active {
    Some(v) -> [#("active", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let slice_values =
    list.flatten([
      list.map(us_core_patient.gender_identity, fn(value) {
        json.object([
          #(
            "url",
            json.string(
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-genderIdentity",
            ),
          ),
          #("valueCodeableConcept", ct.codeableconcept_to_json(value)),
        ])
      }),
      case us_core_patient.sex {
        Some(value) -> [
          json.object([
            #(
              "url",
              json.string(
                "http://hl7.org/fhir/us/core/StructureDefinition/us-core-sex",
              ),
            ),
            #("valueCode", json.string(value)),
          ]),
        ]
        None -> []
      },
      case us_core_patient.birthsex {
        Some(value) -> [
          json.object([
            #(
              "url",
              json.string(
                "http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex",
              ),
            ),
            #("valueCode", valuesets.two16840111376214102124_to_json(value)),
          ]),
        ]
        None -> []
      },
      list.map(us_core_patient.tribal_affiliation, fn(value) {
        ct.us_core_tribal_affiliation_to_json(
          value,
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation",
        )
      }),
      case us_core_patient.ethnicity {
        Some(value) -> [
          ct.us_core_ethnicity_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity",
          ),
        ]
        None -> []
      },
      case us_core_patient.race {
        Some(value) -> [
          ct.us_core_race_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race",
          ),
        ]
        None -> []
      },
      list.map(us_core_patient.extension, fn(value) {
        ct.extension_to_json(value)
      }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("extension", json.preprocessed_array(values)), ..fields]
  }
  let fields = case us_core_patient.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case us_core_patient.text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Patient")), ..fields]
  json.object(fields)
}

pub fn us_core_patient_deceased_to_json(value: UsCorePatientDeceased) -> Json {
  case value {
    UsCorePatientDeceasedBoolean(value) -> json.bool(value)
    UsCorePatientDeceasedDatetime(value) -> pt.datetime_to_json(value)
  }
}

pub fn us_core_patient_multiplebirth_to_json(
  value: UsCorePatientMultiplebirth,
) -> Json {
  case value {
    UsCorePatientMultiplebirthBoolean(value) -> json.bool(value)
    UsCorePatientMultiplebirthInteger(value) -> json.int(value)
  }
}

pub fn us_core_patient_communication_to_json(
  us_core_patient_communication: UsCorePatientCommunication,
) -> Json {
  let fields = [
    #(
      "language",
      ct.codeableconcept_to_json(us_core_patient_communication.language),
    ),
  ]
  let fields = case us_core_patient_communication.preferred {
    Some(v) -> [#("preferred", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient_communication.modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_communication.extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_communication.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_patient_contact_to_json(
  us_core_patient_contact: UsCorePatientContact,
) -> Json {
  let fields = []
  let fields = case us_core_patient_contact.period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient_contact.organization {
    Some(v) -> [#("organization", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient_contact.gender {
    Some(v) -> [
      #("gender", valuesets.administrativegender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case us_core_patient_contact.address {
    Some(v) -> [#("address", ct.address_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient_contact.telecom {
    [] -> fields
    values -> [
      #("telecom", json.array(values, ct.contactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_contact.name {
    Some(v) -> [#("name", ct.humanname_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case us_core_patient_contact.relationship {
    [] -> fields
    values -> [
      #("relationship", json.array(values, ct.codeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_contact.modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_contact.extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_contact.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_patient_link_to_json(
  us_core_patient_link: UsCorePatientLink,
) -> Json {
  let fields = [
    #("type", valuesets.linktype_to_json(us_core_patient_link.type_)),
    #("other", ct.reference_to_json(us_core_patient_link.other)),
  ]
  let fields = case us_core_patient_link.modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_link.extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case us_core_patient_link.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_allergyintolerance_reaction_decoder() -> Decoder(
  UsCoreAllergyintoleranceReaction,
) {
  use <- decode.recursive
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.annotation_decoder()),
  )
  use exposure_route <- decode.optional_field(
    "exposureRoute",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use severity <- decode.optional_field(
    "severity",
    None,
    decode.optional(valuesets.reactioneventseverity_decoder()),
  )
  use onset <- decode.optional_field(
    "onset",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use description <- decode.optional_field(
    "description",
    None,
    decode.optional(decode.string),
  )
  use manifestation <- list1_decoder(
    "manifestation",
    ct.codeableconcept_decoder(),
  )
  use substance <- decode.optional_field(
    "substance",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCoreAllergyintoleranceReaction(
      note:,
      exposure_route:,
      severity:,
      onset:,
      description:,
      manifestation:,
      substance:,
      modifier_extension:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_allergyintolerance_onset_decoder() -> Decoder(
  UsCoreAllergyintoleranceOnset,
) {
  decode.one_of(
    decode.field("onsetDateTime", pt.datetime_decoder(), decode.success)
      |> decode.map(UsCoreAllergyintoleranceOnsetDatetime),
    [
      decode.field("onsetAge", ct.age_decoder(), decode.success)
        |> decode.map(UsCoreAllergyintoleranceOnsetAge),
      decode.field("onsetPeriod", ct.period_decoder(), decode.success)
        |> decode.map(UsCoreAllergyintoleranceOnsetPeriod),
      decode.field("onsetRange", ct.range_decoder(), decode.success)
        |> decode.map(UsCoreAllergyintoleranceOnsetRange),
      decode.field("onsetString", decode.string, decode.success)
        |> decode.map(UsCoreAllergyintoleranceOnsetString),
    ],
  )
}

pub fn us_core_allergyintolerance_decoder() -> Decoder(UsCoreAllergyintolerance) {
  use <- decode.recursive
  use reaction <- decode.optional_field(
    "reaction",
    [],
    decode.list(us_core_allergyintolerance_reaction_decoder()),
  )
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.annotation_decoder()),
  )
  use last_occurrence <- decode.optional_field(
    "lastOccurrence",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use asserter <- decode.optional_field(
    "asserter",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use recorder <- decode.optional_field(
    "recorder",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use recorded_date <- decode.optional_field(
    "recordedDate",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use onset <- decode.then(
    none_if_omitted(us_core_allergyintolerance_onset_decoder()),
  )
  use encounter <- decode.optional_field(
    "encounter",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use patient <- decode.field("patient", ct.reference_decoder())
  use code <- decode.field("code", ct.codeableconcept_decoder())
  use criticality <- decode.optional_field(
    "criticality",
    None,
    decode.optional(valuesets.allergyintolerancecriticality_decoder()),
  )
  use category <- decode.optional_field(
    "category",
    [],
    decode.list(valuesets.allergyintolerancecategory_decoder()),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(valuesets.allergyintolerancetype_decoder()),
  )
  use verification_status <- decode.optional_field(
    "verificationStatus",
    None,
    decode.optional(ct.bound_codeableconcept_decoder(
      valuesets.allergyintoleranceverification_from_code_and_system,
      valuesets.AllergyintoleranceverificationUnconfirmed,
    )),
  )
  use clinical_status <- decode.optional_field(
    "clinicalStatus",
    None,
    decode.optional(ct.bound_codeableconcept_decoder(
      valuesets.allergyintoleranceclinical_from_code_and_system,
      valuesets.AllergyintoleranceclinicalActive,
    )),
  )
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.identifier_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.narrative_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCoreAllergyintolerance(
      reaction:,
      note:,
      last_occurrence:,
      asserter:,
      recorder:,
      recorded_date:,
      onset:,
      encounter:,
      patient:,
      code:,
      criticality:,
      category:,
      type_:,
      verification_status:,
      clinical_status:,
      identifier:,
      modifier_extension:,
      extension:,
      contained:,
      text:,
      language:,
      implicit_rules:,
      meta:,
      id:,
    )
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.dynamic, fn(raw) {
      case decode.run(raw, decode.string) {
        Error(errors) ->
          decode.failure(Nil, "AllergyIntolerance")
          |> decode.map_errors(fn(_) { errors })
        Ok(value) ->
          case value == "AllergyIntolerance" {
            True -> decode.success(Nil)
            False ->
              decode.failure(Nil, "AllergyIntolerance")
              |> decode.map_errors(fn(errors) {
                list.map(errors, fn(error) {
                  decode.DecodeError(..error, found: value)
                })
              })
          }
      }
    }),
  )
  decode.success(placeholder)
}

type UsCoreEthnicityExtensionAccumulator {
  UsCoreEthnicityExtensionAccumulator(
    text: Option(String),
    detailed: List(ct.BoundCoding(valuesets.Detailedethnicity)),
    omb_category: Option(ct.BoundCoding(valuesets.Ombethnicitycategory)),
    open: List(ct.Extension),
  )
}

type UsCoreEthnicityParsedExtensionSlice {
  UsCoreEthnicityParsedExtensionSliceText(Option(String), String)
  UsCoreEthnicityParsedExtensionSliceDetailed(
    Option(String),
    ct.BoundCoding(valuesets.Detailedethnicity),
  )
  UsCoreEthnicityParsedExtensionSliceOmbcategory(
    Option(String),
    ct.BoundCoding(valuesets.Ombethnicitycategory),
  )
  UsCoreEthnicityParsedExtensionSliceOpen(ct.Extension)
}

fn parse_us_core_ethnicity_child() -> Decoder(
  Result(UsCoreEthnicityParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "text" ->
        decode.field("valueString", decode.string, decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreEthnicityParsedExtensionSliceText(id, value)
          })
        })
      "detailed" ->
        decode.field(
          "valueCoding",
          ct.bound_coding_decoder(
            valuesets.detailedethnicity_from_code_and_system,
            valuesets.Detailedethnicity10009,
          ),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreEthnicityParsedExtensionSliceDetailed(id, value)
          })
        })
      "ombCategory" ->
        decode.field(
          "valueCoding",
          ct.bound_coding_decoder(
            valuesets.ombethnicitycategory_from_code_and_system,
            valuesets.Ombethnicitycategory21352,
          ),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreEthnicityParsedExtensionSliceOmbcategory(id, value)
          })
        })
      _ ->
        ct.extension_decoder()
        |> decode.map(fn(value) {
          Ok(UsCoreEthnicityParsedExtensionSliceOpen(value))
        })
    },
    decode.success,
  )
}

fn parse_us_core_ethnicity() -> Decoder(Result(ct.UsCoreEthnicity, String)) {
  use children <- decode.field(
    "extension",
    decode.list(parse_us_core_ethnicity_child()),
  )
  decode.success({
    let accumulator: Result(UsCoreEthnicityExtensionAccumulator, String) =
      list.fold(
        children,
        Ok(UsCoreEthnicityExtensionAccumulator(None, [], None, [])),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    UsCoreEthnicityParsedExtensionSliceText(_id, value) ->
                      Ok(
                        UsCoreEthnicityExtensionAccumulator(
                          ..accumulator,
                          text: Some(value),
                        ),
                      )
                    UsCoreEthnicityParsedExtensionSliceDetailed(_id, value) ->
                      Ok(
                        UsCoreEthnicityExtensionAccumulator(
                          ..accumulator,
                          detailed: [value, ..accumulator.detailed],
                        ),
                      )
                    UsCoreEthnicityParsedExtensionSliceOmbcategory(_id, value) ->
                      Ok(
                        UsCoreEthnicityExtensionAccumulator(
                          ..accumulator,
                          omb_category: Some(value),
                        ),
                      )
                    UsCoreEthnicityParsedExtensionSliceOpen(child) ->
                      Ok(
                        UsCoreEthnicityExtensionAccumulator(
                          ..accumulator,
                          open: [child, ..accumulator.open],
                        ),
                      )
                  }
              }
          }
        },
      )
    case accumulator {
      Error(reason) -> Error(reason)
      Ok(accumulator) ->
        case accumulator.text {
          None -> Error("required extension text")
          Some(text) ->
            Ok(ct.UsCoreEthnicity(
              extension: list.reverse(accumulator.open),
              text:,
              detailed: list.reverse(accumulator.detailed),
              omb_category: accumulator.omb_category,
            ))
        }
    }
  })
}

type UsCoreRaceExtensionAccumulator {
  UsCoreRaceExtensionAccumulator(
    text: Option(String),
    detailed: List(ct.BoundCoding(valuesets.Detailedrace)),
    omb_category: List(ct.BoundCoding(valuesets.Ombracecategory)),
    open: List(ct.Extension),
  )
}

type UsCoreRaceParsedExtensionSlice {
  UsCoreRaceParsedExtensionSliceText(Option(String), String)
  UsCoreRaceParsedExtensionSliceDetailed(
    Option(String),
    ct.BoundCoding(valuesets.Detailedrace),
  )
  UsCoreRaceParsedExtensionSliceOmbcategory(
    Option(String),
    ct.BoundCoding(valuesets.Ombracecategory),
  )
  UsCoreRaceParsedExtensionSliceOpen(ct.Extension)
}

fn parse_us_core_race_child() -> Decoder(
  Result(UsCoreRaceParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "text" ->
        decode.field("valueString", decode.string, decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreRaceParsedExtensionSliceText(id, value)
          })
        })
      "detailed" ->
        decode.field(
          "valueCoding",
          ct.bound_coding_decoder(
            valuesets.detailedrace_from_code_and_system,
            valuesets.Detailedrace10009,
          ),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreRaceParsedExtensionSliceDetailed(id, value)
          })
        })
      "ombCategory" ->
        decode.field(
          "valueCoding",
          ct.bound_coding_decoder(
            valuesets.ombracecategory_from_code_and_system,
            valuesets.Ombracecategory10025,
          ),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreRaceParsedExtensionSliceOmbcategory(id, value)
          })
        })
      _ ->
        ct.extension_decoder()
        |> decode.map(fn(value) {
          Ok(UsCoreRaceParsedExtensionSliceOpen(value))
        })
    },
    decode.success,
  )
}

fn parse_us_core_race() -> Decoder(Result(ct.UsCoreRace, String)) {
  use children <- decode.field(
    "extension",
    decode.list(parse_us_core_race_child()),
  )
  decode.success({
    let accumulator: Result(UsCoreRaceExtensionAccumulator, String) =
      list.fold(
        children,
        Ok(UsCoreRaceExtensionAccumulator(None, [], [], [])),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    UsCoreRaceParsedExtensionSliceText(_id, value) ->
                      Ok(
                        UsCoreRaceExtensionAccumulator(
                          ..accumulator,
                          text: Some(value),
                        ),
                      )
                    UsCoreRaceParsedExtensionSliceDetailed(_id, value) ->
                      Ok(
                        UsCoreRaceExtensionAccumulator(..accumulator, detailed: [
                          value,
                          ..accumulator.detailed
                        ]),
                      )
                    UsCoreRaceParsedExtensionSliceOmbcategory(_id, value) ->
                      Ok(
                        UsCoreRaceExtensionAccumulator(
                          ..accumulator,
                          omb_category: [value, ..accumulator.omb_category],
                        ),
                      )
                    UsCoreRaceParsedExtensionSliceOpen(child) ->
                      Ok(
                        UsCoreRaceExtensionAccumulator(..accumulator, open: [
                          child,
                          ..accumulator.open
                        ]),
                      )
                  }
              }
          }
        },
      )
    case accumulator {
      Error(reason) -> Error(reason)
      Ok(accumulator) ->
        case accumulator.text {
          None -> Error("required extension text")
          Some(text) ->
            Ok(ct.UsCoreRace(
              extension: list.reverse(accumulator.open),
              text:,
              detailed: list.reverse(accumulator.detailed),
              omb_category: list.reverse(accumulator.omb_category),
            ))
        }
    }
  })
}

type UsCoreTribalAffiliationExtensionAccumulator {
  UsCoreTribalAffiliationExtensionAccumulator(
    is_enrolled: Option(Bool),
    tribal_affiliation: Option(ct.Codeableconcept),
    open: List(ct.Extension),
  )
}

type UsCoreTribalAffiliationParsedExtensionSlice {
  UsCoreTribalAffiliationParsedExtensionSliceIsenrolled(Option(String), Bool)
  UsCoreTribalAffiliationParsedExtensionSliceTribalaffiliation(
    Option(String),
    ct.Codeableconcept,
  )
  UsCoreTribalAffiliationParsedExtensionSliceOpen(ct.Extension)
}

fn parse_us_core_tribal_affiliation_child() -> Decoder(
  Result(UsCoreTribalAffiliationParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "isEnrolled" ->
        decode.field("valueBoolean", decode.bool, decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreTribalAffiliationParsedExtensionSliceIsenrolled(id, value)
          })
        })
      "tribalAffiliation" ->
        decode.field(
          "valueCodeableConcept",
          ct.codeableconcept_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCoreTribalAffiliationParsedExtensionSliceTribalaffiliation(
              id,
              value,
            )
          })
        })
      _ ->
        ct.extension_decoder()
        |> decode.map(fn(value) {
          Ok(UsCoreTribalAffiliationParsedExtensionSliceOpen(value))
        })
    },
    decode.success,
  )
}

fn parse_us_core_tribal_affiliation() -> Decoder(
  Result(ct.UsCoreTribalAffiliation, String),
) {
  use children <- decode.field(
    "extension",
    decode.list(parse_us_core_tribal_affiliation_child()),
  )
  decode.success({
    let accumulator: Result(UsCoreTribalAffiliationExtensionAccumulator, String) =
      list.fold(
        children,
        Ok(UsCoreTribalAffiliationExtensionAccumulator(None, None, [])),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    UsCoreTribalAffiliationParsedExtensionSliceIsenrolled(
                      _id,
                      value,
                    ) ->
                      Ok(
                        UsCoreTribalAffiliationExtensionAccumulator(
                          ..accumulator,
                          is_enrolled: Some(value),
                        ),
                      )
                    UsCoreTribalAffiliationParsedExtensionSliceTribalaffiliation(
                      _id,
                      value,
                    ) ->
                      Ok(
                        UsCoreTribalAffiliationExtensionAccumulator(
                          ..accumulator,
                          tribal_affiliation: Some(value),
                        ),
                      )
                    UsCoreTribalAffiliationParsedExtensionSliceOpen(child) ->
                      Ok(
                        UsCoreTribalAffiliationExtensionAccumulator(
                          ..accumulator,
                          open: [child, ..accumulator.open],
                        ),
                      )
                  }
              }
          }
        },
      )
    case accumulator {
      Error(reason) -> Error(reason)
      Ok(accumulator) ->
        case accumulator.tribal_affiliation {
          None -> Error("required extension tribal_affiliation")
          Some(tribal_affiliation) ->
            Ok(ct.UsCoreTribalAffiliation(
              extension: list.reverse(accumulator.open),
              is_enrolled: accumulator.is_enrolled,
              tribal_affiliation:,
            ))
        }
    }
  })
}

type UsCorePatientExtensionSliceAccumulator {
  UsCorePatientExtensionSliceAccumulator(
    gender_identity: List(ct.Codeableconcept),
    sex: Option(String),
    birthsex: Option(valuesets.Two16840111376214102124),
    tribal_affiliation: List(ct.UsCoreTribalAffiliation),
    ethnicity: Option(ct.UsCoreEthnicity),
    race: Option(ct.UsCoreRace),
    open: List(ct.Extension),
  )
}

pub type UsCorePatientParsedExtensionSlice {
  UsCorePatientParsedExtensionSliceGenderidentity(ct.Codeableconcept)
  UsCorePatientParsedExtensionSliceSex(String)
  UsCorePatientParsedExtensionSliceBirthsex(valuesets.Two16840111376214102124)
  UsCorePatientParsedExtensionSliceTribalaffiliation(ct.UsCoreTribalAffiliation)
  UsCorePatientParsedExtensionSliceEthnicity(ct.UsCoreEthnicity)
  UsCorePatientParsedExtensionSliceRace(ct.UsCoreRace)
  UsCorePatientParsedExtensionSliceOpen(ct.Extension)
}

type UsCorePatientExtensionSlices {
  UsCorePatientExtensionSlices(
    gender_identity: List(ct.Codeableconcept),
    sex: Option(String),
    birthsex: Option(valuesets.Two16840111376214102124),
    tribal_affiliation: List(ct.UsCoreTribalAffiliation),
    ethnicity: Option(ct.UsCoreEthnicity),
    race: Option(ct.UsCoreRace),
    open: List(ct.Extension),
  )
}

pub fn us_core_patient_link_decoder() -> Decoder(UsCorePatientLink) {
  use <- decode.recursive
  use type_ <- decode.field("type", valuesets.linktype_decoder())
  use other <- decode.field("other", ct.reference_decoder())
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePatientLink(type_:, other:, modifier_extension:, extension:, id:)
  decode.success(placeholder)
}

pub fn us_core_patient_contact_decoder() -> Decoder(UsCorePatientContact) {
  use <- decode.recursive
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use organization <- decode.optional_field(
    "organization",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use gender <- decode.optional_field(
    "gender",
    None,
    decode.optional(valuesets.administrativegender_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    None,
    decode.optional(ct.address_decoder()),
  )
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.contactpoint_decoder()),
  )
  use name <- decode.optional_field(
    "name",
    None,
    decode.optional(ct.humanname_decoder()),
  )
  use relationship <- decode.optional_field(
    "relationship",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePatientContact(
      period:,
      organization:,
      gender:,
      address:,
      telecom:,
      name:,
      relationship:,
      modifier_extension:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_patient_communication_decoder() -> Decoder(
  UsCorePatientCommunication,
) {
  use <- decode.recursive
  use preferred <- decode.optional_field(
    "preferred",
    None,
    decode.optional(decode.bool),
  )
  use language <- decode.field("language", ct.codeableconcept_decoder())
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePatientCommunication(
      preferred:,
      language:,
      modifier_extension:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_patient_multiplebirth_decoder() -> Decoder(
  UsCorePatientMultiplebirth,
) {
  decode.one_of(
    decode.field("multipleBirthBoolean", decode.bool, decode.success)
      |> decode.map(UsCorePatientMultiplebirthBoolean),
    [
      decode.field("multipleBirthInteger", decode.int, decode.success)
      |> decode.map(UsCorePatientMultiplebirthInteger),
    ],
  )
}

pub fn us_core_patient_deceased_decoder() -> Decoder(UsCorePatientDeceased) {
  decode.one_of(
    decode.field("deceasedBoolean", decode.bool, decode.success)
      |> decode.map(UsCorePatientDeceasedBoolean),
    [
      decode.field("deceasedDateTime", pt.datetime_decoder(), decode.success)
      |> decode.map(UsCorePatientDeceasedDatetime),
    ],
  )
}

pub fn us_core_patient_extension_slice_decoder() -> Decoder(
  Result(UsCorePatientParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use _id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-genderIdentity" ->
        decode.field(
          "valueCodeableConcept",
          ct.codeableconcept_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCorePatientParsedExtensionSliceGenderidentity(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-sex" ->
        decode.field("valueCode", decode.string, decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCorePatientParsedExtensionSliceSex(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex" ->
        decode.field(
          "valueCode",
          valuesets.two16840111376214102124_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCorePatientParsedExtensionSliceBirthsex(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation" ->
        parse_us_core_tribal_affiliation()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCorePatientParsedExtensionSliceTribalaffiliation(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity" ->
        parse_us_core_ethnicity()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCorePatientParsedExtensionSliceEthnicity(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race" ->
        parse_us_core_race()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            UsCorePatientParsedExtensionSliceRace(value)
          })
        })
      _ ->
        ct.extension_decoder()
        |> decode.map(fn(value) {
          Ok(UsCorePatientParsedExtensionSliceOpen(value))
        })
    },
    decode.success,
  )
}

pub fn us_core_patient_decoder() -> Decoder(UsCorePatient) {
  use <- decode.recursive
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(us_core_patient_link_decoder()),
  )
  use managing_organization <- decode.optional_field(
    "managingOrganization",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use general_practitioner <- decode.optional_field(
    "generalPractitioner",
    [],
    decode.list(ct.reference_decoder()),
  )
  use communication <- decode.optional_field(
    "communication",
    [],
    decode.list(us_core_patient_communication_decoder()),
  )
  use contact <- decode.optional_field(
    "contact",
    [],
    decode.list(us_core_patient_contact_decoder()),
  )
  use photo <- decode.optional_field(
    "photo",
    [],
    decode.list(ct.attachment_decoder()),
  )
  use multiple_birth <- decode.then(
    none_if_omitted(us_core_patient_multiplebirth_decoder()),
  )
  use marital_status <- decode.optional_field(
    "maritalStatus",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    [],
    decode.list(ct.address_decoder()),
  )
  use deceased <- decode.then(
    none_if_omitted(us_core_patient_deceased_decoder()),
  )
  use birth_date <- decode.optional_field(
    "birthDate",
    None,
    decode.optional(pt.date_decoder()),
  )
  use gender <- decode.field("gender", valuesets.administrativegender_decoder())
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.contactpoint_us_core_patient_telecom_decoder()),
  )
  use name <- list1_decoder("name", ct.humanname_decoder())
  use active <- decode.optional_field(
    "active",
    None,
    decode.optional(decode.bool),
  )
  use identifier <- list1_decoder(
    "identifier",
    decode.then(decode.dynamic, fn(raw) {
      case
        decode.run(raw, {
          use _ <- decode.then({
            use fields <- decode.then(decode.dict(decode.string, decode.dynamic))
            let _ = fields
            decode.success(Nil)
          })
          use _ <- decode.field("system", decode.string)
          use _ <- decode.field("value", decode.string)
          decode.success(Nil)
        })
      {
        Ok(_) ->
          ct.identifier_decoder()
          |> decode.then(fn(value) {
            case ct.identifier_required_system_value_from_identifier(value) {
              Ok(value) -> decode.success(value)
              Error(_) ->
                decode.failure(
                  ct.identifier_required_system_value_new(system: "", value: ""),
                  "ct.IdentifierRequiredSystemValue",
                )
            }
          })
        Error(errors) ->
          decode.failure(
            ct.identifier_required_system_value_new(system: "", value: ""),
            "ct.IdentifierRequiredSystemValue",
          )
          |> decode.map_errors(fn(_) { errors })
      }
    }),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension_base_values <- decode.optional_field(
    "extension",
    [],
    decode.list(us_core_patient_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(
        UsCorePatientExtensionSliceAccumulator(
          [],
          None,
          None,
          [],
          None,
          None,
          [],
        ),
      ),
      fn(accumulator_result, parsed, index) {
        case accumulator_result {
          Error(errors) -> Error(errors)
          Ok(accumulator) ->
            case parsed {
              Error(reason) ->
                Error([
                  decode.DecodeError(
                    expected: "profile extension",
                    found: reason,
                    path: ["extension", int.to_string(index)],
                  ),
                ])
              Ok(slice) ->
                case slice {
                  UsCorePatientParsedExtensionSliceGenderidentity(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        gender_identity: [value, ..accumulator.gender_identity],
                      ),
                    )
                  UsCorePatientParsedExtensionSliceSex(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        sex: Some(value),
                      ),
                    )
                  UsCorePatientParsedExtensionSliceBirthsex(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        birthsex: Some(value),
                      ),
                    )
                  UsCorePatientParsedExtensionSliceTribalaffiliation(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        tribal_affiliation: [
                          value,
                          ..accumulator.tribal_affiliation
                        ],
                      ),
                    )
                  UsCorePatientParsedExtensionSliceEthnicity(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        ethnicity: Some(value),
                      ),
                    )
                  UsCorePatientParsedExtensionSliceRace(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        race: Some(value),
                      ),
                    )
                  UsCorePatientParsedExtensionSliceOpen(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        open: [value, ..accumulator.open],
                      ),
                    )
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(UsCorePatientExtensionSlices(
        gender_identity: list.reverse(accumulator.gender_identity),
        sex: accumulator.sex,
        birthsex: accumulator.birthsex,
        tribal_affiliation: list.reverse(accumulator.tribal_affiliation),
        ethnicity: accumulator.ethnicity,
        race: accumulator.race,
        open: list.reverse(accumulator.open),
      ))
    Error(errors) -> Error(errors)
  }
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.narrative_decoder()),
  )
  use language <- decode.optional_field(
    "language",
    None,
    decode.optional(decode.string),
  )
  use implicit_rules <- decode.optional_field(
    "implicitRules",
    None,
    decode.optional(decode.string),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let extension_slices_decoder = case extension_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        UsCorePatientExtensionSlices([], None, None, [], None, None, []),
        "UsCorePatient slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.dynamic, fn(raw) {
      case decode.run(raw, decode.string) {
        Error(errors) ->
          decode.failure(Nil, "Patient") |> decode.map_errors(fn(_) { errors })
        Ok(value) ->
          case value == "Patient" {
            True -> decode.success(Nil)
            False ->
              decode.failure(Nil, "Patient")
              |> decode.map_errors(fn(errors) {
                list.map(errors, fn(error) {
                  decode.DecodeError(..error, found: value)
                })
              })
          }
      }
    }),
  )
  use extension_slices <- decode.then(extension_slices_decoder)
  decode.success(UsCorePatient(
    link:,
    managing_organization:,
    general_practitioner:,
    communication:,
    contact:,
    photo:,
    multiple_birth:,
    marital_status:,
    address:,
    deceased:,
    birth_date:,
    gender:,
    telecom:,
    name:,
    active:,
    identifier:,
    modifier_extension:,
    gender_identity: extension_slices.gender_identity,
    sex: extension_slices.sex,
    birthsex: extension_slices.birthsex,
    tribal_affiliation: extension_slices.tribal_affiliation,
    ethnicity: extension_slices.ethnicity,
    race: extension_slices.race,
    extension: extension_slices.open,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

pub type ResourceType {
  RtAppointment
  RtBundle
  RtOperationoutcome
  RtParameters
  RtAllergyintolerance
  RtPatient
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    RtAppointment -> "Appointment"
    RtBundle -> "Bundle"
    RtOperationoutcome -> "OperationOutcome"
    RtParameters -> "Parameters"
    RtAllergyintolerance -> "AllergyIntolerance"
    RtPatient -> "Patient"
  }
}

pub type Resource {
  ResourceAppointment(Appointment)
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourceUsCoreAllergyintolerance(UsCoreAllergyintolerance)
  ResourceUsCorePatient(UsCorePatient)
}

pub fn resource_to_json(resource: Resource) {
  case resource {
    ResourceAppointment(resource) -> appointment_to_json(resource)
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourceUsCoreAllergyintolerance(resource) ->
      us_core_allergyintolerance_to_json(resource)
    ResourceUsCorePatient(resource) -> us_core_patient_to_json(resource)
  }
}

pub fn resource_decoder() -> Decoder(Resource) {
  use tag <- decode.field("resourceType", decode.string)
  case tag {
    "Appointment" -> appointment_decoder() |> decode.map(ResourceAppointment)
    "Bundle" -> bundle_decoder() |> decode.map(ResourceBundle)
    "OperationOutcome" ->
      operationoutcome_decoder() |> decode.map(ResourceOperationoutcome)
    "Parameters" -> parameters_decoder() |> decode.map(ResourceParameters)
    "AllergyIntolerance" ->
      us_core_allergyintolerance_decoder()
      |> decode.map(ResourceUsCoreAllergyintolerance)
    "Patient" -> us_core_patient_decoder() |> decode.map(ResourceUsCorePatient)
    _ ->
      decode.failure(ResourceParameters(parameters_new()), expected: "")
      |> decode.map_errors(fn(_errors) {
        [
          decode.DecodeError(
            expected: "one of Account, ActivityDefinition, AdverseEvent, AllergyIntolerance... or any resource name",
            found: tag,
            path: ["resourceType"],
          ),
        ]
      })
  }
  |> decode.map_errors(fn(errors) {
    list.map(errors, fn(error) {
      decode.DecodeError(..error, path: ["(" <> tag <> ")", ..error.path])
    })
  })
}
