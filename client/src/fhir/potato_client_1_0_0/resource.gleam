////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) resources

import fhir/potato_client_1_0_0/complex_type.{
  type List1, decode_optional_bool, decode_optional_string, list1_decoder,
  list1_to_json, none_if_omitted,
} as ct
import fhir/potato_client_1_0_0/primitive_type.{
  type Date, type DateTime, type Instant,
} as pt
import fhir/potato_client_1_0_0/valueset
import gleam/bool
import gleam/dynamic/decode.{type Decoder}
import gleam/int
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result

///[http://hl7.org/fhir/r4/StructureDefinition/Bundle#resource](http://hl7.org/fhir/r4/StructureDefinition/Bundle#resource)
pub type BundleLink {
  BundleLink(relation: String, url: String)
}

pub fn bundle_link_new(
  url url: String,
  relation relation: String,
) -> BundleLink {
  BundleLink(url:, relation:)
}

///[http://hl7.org/fhir/r4/StructureDefinition/Bundle#resource](http://hl7.org/fhir/r4/StructureDefinition/Bundle#resource)
pub type BundleEntry {
  BundleEntry(resource: Option(Resource))
}

pub fn bundle_entry_new() -> BundleEntry {
  BundleEntry(resource: None)
}

///[http://hl7.org/fhir/r4/StructureDefinition/Bundle#resource](http://hl7.org/fhir/r4/StructureDefinition/Bundle#resource)
pub type Bundle {
  Bundle(
    type_: valueset.BundleType,
    link: List(BundleLink),
    entry: List(BundleEntry),
  )
}

pub fn bundle_new(type_ type_: valueset.BundleType) -> Bundle {
  Bundle(entry: [], link: [], type_:)
}

pub fn bundle_to_json(bundle: Bundle) -> Json {
  let fields = [
    #("type", valueset.bundle_type_to_json(bundle.type_)),
  ]
  let fields = case bundle.entry {
    [] -> fields
    _ -> [#("entry", json.array(bundle.entry, bundle_entry_to_json)), ..fields]
  }
  let fields = case bundle.link {
    [] -> fields
    _ -> [#("link", json.array(bundle.link, bundle_link_to_json)), ..fields]
  }
  let fields = [#("resourceType", json.string("Bundle")), ..fields]
  json.object(fields)
}

pub fn bundle_decoder() -> Decoder(Bundle) {
  use <- decode.recursive
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
  use type_ <- decode.field("type", valueset.bundle_type_decoder())

  use resource_type <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    resource_type != "Bundle",
    decode.failure(bundle_new(type_:), "resourceType"),
  )
  decode.success(Bundle(entry:, link:, type_:))
}

pub type BundleForgiving {
  BundleForgiving(
    type_: valueset.BundleType,
    link: List(BundleLink),
    entry: List(BundleEntryForgiving),
  )
}

pub fn bundle_decoder_forgiving() -> Decoder(BundleForgiving) {
  use <- decode.recursive
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
  use type_ <- decode.field("type", valueset.bundle_type_decoder())

  use resource_type <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    resource_type != "Bundle",
    decode.failure(BundleForgiving(entry:, link:, type_:), "resourceType"),
  )
  decode.success(BundleForgiving(entry:, link:, type_:))
}

pub fn bundle_entry_to_json(bundle_entry: BundleEntry) -> Json {
  let fields = []
  let fields = case bundle_entry.resource {
    Some(v) -> [#("resource", to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn bundle_entry_decoder() -> Decoder(BundleEntry) {
  use <- decode.recursive
  use resource <- decode.optional_field(
    "resource",
    None,
    decode.optional(resource_decoder()),
  )
  decode.success(BundleEntry(resource:))
}

pub type BundleEntryForgiving {
  BundleEntryForgiving(
    resource: Option(Result(Resource, List(decode.DecodeError))),
  )
}

pub fn bundle_entry_decoder_forgiving() -> Decoder(BundleEntryForgiving) {
  use <- decode.recursive
  use resource <- decode.optional_field(
    "resource",
    None,
    decode.optional(
      decode.dynamic
      |> decode.map(fn(resource_json) {
        // decode.run returns Ok(resource) or Error(errs) as forgiving bundle decoder wants to preserve errors instead of failing whole bundle decoder
        decode.run(resource_json, resource_decoder())
      }),
    ),
  )
  decode.success(BundleEntryForgiving(resource:))
}

pub fn bundle_link_to_json(bundle_link: BundleLink) -> Json {
  let fields = [
    #("url", json.string(bundle_link.url)),
    #("relation", json.string(bundle_link.relation)),
  ]
  json.object(fields)
}

pub fn bundle_link_decoder() -> Decoder(BundleLink) {
  use <- decode.recursive
  use url <- decode.field("url", decode.string)
  use relation <- decode.field("relation", decode.string)
  decode.success(BundleLink(url:, relation:))
}

///[http://hl7.org/fhir/r4/StructureDefinition/OperationOutcome#resource](http://hl7.org/fhir/r4/StructureDefinition/OperationOutcome#resource)
pub type OperationoutcomeIssue {
  OperationoutcomeIssue(
    severity: valueset.IssueSeverity,
    code: valueset.IssueType,
  )
}

pub fn operationoutcome_issue_new(
  code code: valueset.IssueType,
  severity severity: valueset.IssueSeverity,
) -> OperationoutcomeIssue {
  OperationoutcomeIssue(code:, severity:)
}

///[http://hl7.org/fhir/r4/StructureDefinition/OperationOutcome#resource](http://hl7.org/fhir/r4/StructureDefinition/OperationOutcome#resource)
pub type Operationoutcome {
  Operationoutcome(issue: List1(OperationoutcomeIssue))
}

pub fn operationoutcome_new(
  issue issue: List1(OperationoutcomeIssue),
) -> Operationoutcome {
  Operationoutcome(issue:)
}

pub fn operationoutcome_to_json(operationoutcome: Operationoutcome) -> Json {
  let fields = [
    #(
      "issue",
      list1_to_json(operationoutcome.issue, operationoutcome_issue_to_json),
    ),
  ]
  let fields = [#("resourceType", json.string("OperationOutcome")), ..fields]
  json.object(fields)
}

pub fn operationoutcome_decoder() -> Decoder(Operationoutcome) {
  use <- decode.recursive
  use issue <- list1_decoder("issue", operationoutcome_issue_decoder())

  use resource_type <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    resource_type != "OperationOutcome",
    decode.failure(operationoutcome_new(issue:), "resourceType"),
  )
  decode.success(Operationoutcome(issue:))
}

pub fn operationoutcome_issue_to_json(
  operationoutcome_issue: OperationoutcomeIssue,
) -> Json {
  let fields = [
    #("code", valueset.issue_type_to_json(operationoutcome_issue.code)),
    #(
      "severity",
      valueset.issue_severity_to_json(operationoutcome_issue.severity),
    ),
  ]
  json.object(fields)
}

pub fn operationoutcome_issue_decoder() -> Decoder(OperationoutcomeIssue) {
  use <- decode.recursive
  use code <- decode.field("code", valueset.issue_type_decoder())
  use severity <- decode.field("severity", valueset.issue_severity_decoder())
  decode.success(OperationoutcomeIssue(code:, severity:))
}

///[http://hl7.org/fhir/r4/StructureDefinition/Parameters#resource](http://hl7.org/fhir/r4/StructureDefinition/Parameters#resource)
pub type Parameters {
  Parameters
}

pub fn parameters_new() -> Parameters {
  Parameters
}

pub fn parameters_to_json(_parameters: Parameters) -> Json {
  let fields = []
  let fields = [#("resourceType", json.string("Parameters")), ..fields]
  json.object(fields)
}

pub fn parameters_decoder() -> Decoder(Parameters) {
  use <- decode.recursive

  use resource_type <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    resource_type != "Parameters",
    decode.failure(parameters_new(), "resourceType"),
  )
  decode.success(Parameters)
}

pub type PotatoAllergyintolerance {
  PotatoAllergyintolerance(
    asserter: Option(ct.Potatoreference),
    category: List(valueset.AllergyintoleranceCategory),
    clinical_status: Option(
      ct.CodeableconceptPotatoAllergyintoleranceClinicalstatus,
    ),
    code: ct.Potatocodeableconcept,
    contained: List(Resource),
    criticality: Option(valueset.AllergyintoleranceCriticality),
    encounter: Option(ct.Potatoreference),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    last_occurrence: Option(DateTime),
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    onset: Option(PotatoAllergyintoleranceOnset),
    patient: ct.Potatoreference,
    reaction: List(PotatoAllergyintoleranceReaction),
    recorded_date: Option(DateTime),
    recorder: Option(ct.Potatoreference),
    text: Option(ct.Potatonarrative),
    type_: Option(valueset.AllergyintoleranceType),
    verification_status: Option(
      ct.CodeableconceptPotatoAllergyintoleranceVerificationstatus,
    ),
  )
}

pub fn potato_allergyintolerance_new(
  code code: ct.Potatocodeableconcept,
  patient patient: ct.Potatoreference,
) -> PotatoAllergyintolerance {
  PotatoAllergyintolerance(
    asserter: None,
    category: [],
    clinical_status: None,
    code:,
    contained: [],
    criticality: None,
    encounter: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    language: None,
    last_occurrence: None,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoAllergyIntolerance",
      ])
    }),
    note: [],
    onset: None,
    patient:,
    reaction: [],
    recorded_date: None,
    recorder: None,
    text: None,
    type_: None,
    verification_status: None,
  )
}

pub type PotatoAllergyintoleranceOnset {
  PotatoAllergyintoleranceOnsetDatetime(value: DateTime)
  PotatoAllergyintoleranceOnsetAge(value: ct.Potatoage)
  PotatoAllergyintoleranceOnsetPeriod(value: ct.Potatoperiod)
  PotatoAllergyintoleranceOnsetRange(value: ct.Potatorange)
  PotatoAllergyintoleranceOnsetString(value: String)
}

pub type PotatoAllergyintoleranceReaction {
  PotatoAllergyintoleranceReaction(
    description: Option(String),
    exposure_route: Option(ct.Potatocodeableconcept),
    id: Option(String),
    manifestation: List1(ct.Potatocodeableconcept),
    note: List(ct.Potatoannotation),
    onset: Option(DateTime),
    severity: Option(valueset.ReactionEventSeverity),
    substance: Option(ct.Potatocodeableconcept),
  )
}

pub fn potato_allergyintolerance_reaction_new(
  manifestation manifestation: List1(ct.Potatocodeableconcept),
) -> PotatoAllergyintoleranceReaction {
  PotatoAllergyintoleranceReaction(
    description: None,
    exposure_route: None,
    id: None,
    manifestation:,
    note: [],
    onset: None,
    severity: None,
    substance: None,
  )
}

pub fn potato_allergyintolerance_to_json(
  potato_allergyintolerance: PotatoAllergyintolerance,
) -> Json {
  let fields = [
    #("patient", ct.potatoreference_to_json(potato_allergyintolerance.patient)),
    #("code", ct.potatocodeableconcept_to_json(potato_allergyintolerance.code)),
  ]
  let fields = case potato_allergyintolerance.verification_status {
    Some(v) -> [
      #(
        "verificationStatus",
        ct.codeableconcept_potato_allergyintolerance_verificationstatus_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_allergyintolerance.type_ {
    Some(v) -> [
      #("type", valueset.allergyintolerance_type_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_allergyintolerance.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.recorder {
    Some(v) -> [#("recorder", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.recorded_date {
    Some(v) -> [#("recordedDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.reaction {
    [] -> fields
    values -> [
      #(
        "reaction",
        json.array(values, potato_allergyintolerance_reaction_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_allergyintolerance.onset {
    Some(v) -> [potato_allergyintolerance_onset_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potato_allergyintolerance.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.last_occurrence {
    Some(v) -> [#("lastOccurrence", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_allergyintolerance.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance.criticality {
    Some(v) -> [
      #("criticality", valueset.allergyintolerance_criticality_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_allergyintolerance.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_allergyintolerance.clinical_status {
    Some(v) -> [
      #(
        "clinicalStatus",
        ct.codeableconcept_potato_allergyintolerance_clinicalstatus_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_allergyintolerance.category {
    [] -> fields
    values -> [
      #(
        "category",
        json.array(values, valueset.allergyintolerance_category_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_allergyintolerance.asserter {
    Some(v) -> [#("asserter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("AllergyIntolerance")), ..fields]
  json.object(fields)
}

pub fn potato_allergyintolerance_onset_to_json_field(
  value: PotatoAllergyintoleranceOnset,
) -> #(String, Json) {
  case value {
    PotatoAllergyintoleranceOnsetDatetime(value) -> #(
      "onsetDateTime",
      pt.datetime_to_json(value),
    )
    PotatoAllergyintoleranceOnsetAge(value) -> #(
      "onsetAge",
      ct.potatoage_to_json(value),
    )
    PotatoAllergyintoleranceOnsetPeriod(value) -> #(
      "onsetPeriod",
      ct.potatoperiod_to_json(value),
    )
    PotatoAllergyintoleranceOnsetRange(value) -> #(
      "onsetRange",
      ct.potatorange_to_json(value),
    )
    PotatoAllergyintoleranceOnsetString(value) -> #(
      "onsetString",
      json.string(value),
    )
  }
}

pub fn potato_allergyintolerance_reaction_to_json(
  potato_allergyintolerance_reaction: PotatoAllergyintoleranceReaction,
) -> Json {
  let fields = [
    #(
      "manifestation",
      list1_to_json(
        potato_allergyintolerance_reaction.manifestation,
        ct.potatocodeableconcept_to_json,
      ),
    ),
  ]
  let fields = case potato_allergyintolerance_reaction.substance {
    Some(v) -> [#("substance", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance_reaction.severity {
    Some(v) -> [
      #("severity", valueset.reaction_event_severity_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_allergyintolerance_reaction.onset {
    Some(v) -> [#("onset", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance_reaction.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potato_allergyintolerance_reaction.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_allergyintolerance_reaction.exposure_route {
    Some(v) -> [
      #("exposureRoute", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_allergyintolerance_reaction.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type PotatoAppointment {
  PotatoAppointment(
    appointment_type: Option(ct.Potatocodeableconcept),
    based_on: List(ct.Potatoreference),
    cancelation_reason: Option(ct.Potatocodeableconcept),
    comment: Option(String),
    contained: List(Resource),
    created: Option(DateTime),
    description: Option(String),
    end: Option(Instant),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    meta: Option(ct.Potatometa),
    minutes_duration: Option(Int),
    participant: List1(PotatoAppointmentParticipant),
    patient_instruction: Option(String),
    priority: Option(Int),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    requested_period: List(ct.Potatoperiod),
    service_category: List(ct.Potatocodeableconcept),
    service_type: List(ct.Potatocodeableconcept),
    slot: List(ct.Potatoreference),
    specialty: List(ct.Potatocodeableconcept),
    start: Option(Instant),
    status: valueset.Appointmentstatus,
    supporting_information: List(ct.Potatoreference),
    text: Option(ct.Potatonarrative),
  )
}

pub fn potato_appointment_new(
  participant participant: List1(PotatoAppointmentParticipant),
  status status: valueset.Appointmentstatus,
) -> PotatoAppointment {
  PotatoAppointment(
    appointment_type: None,
    based_on: [],
    cancelation_reason: None,
    comment: None,
    contained: [],
    created: None,
    description: None,
    end: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    language: None,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoAppointment",
      ])
    }),
    minutes_duration: None,
    participant:,
    patient_instruction: None,
    priority: None,
    reason_code: [],
    reason_reference: [],
    requested_period: [],
    service_category: [],
    service_type: [],
    slot: [],
    specialty: [],
    start: None,
    status:,
    supporting_information: [],
    text: None,
  )
}

pub type PotatoAppointmentParticipant {
  PotatoAppointmentParticipant(
    actor: Option(ct.Potatoreference),
    id: Option(String),
    period: Option(ct.Potatoperiod),
    required: Option(valueset.Participantrequired),
    status: valueset.Participationstatus,
    type_: List(ct.Potatocodeableconcept),
  )
}

pub fn potato_appointment_participant_new(
  status status: valueset.Participationstatus,
) -> PotatoAppointmentParticipant {
  PotatoAppointmentParticipant(
    actor: None,
    id: None,
    period: None,
    required: None,
    status:,
    type_: [],
  )
}

pub fn potato_appointment_to_json(
  potato_appointment: PotatoAppointment,
) -> Json {
  let fields = [
    #("status", valueset.appointmentstatus_to_json(potato_appointment.status)),
    #(
      "participant",
      list1_to_json(
        potato_appointment.participant,
        potato_appointment_participant_to_json,
      ),
    ),
  ]
  let fields = case potato_appointment.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.supporting_information {
    [] -> fields
    values -> [
      #("supportingInformation", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.start {
    Some(v) -> [#("start", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.specialty {
    [] -> fields
    values -> [
      #("specialty", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.slot {
    [] -> fields
    values -> [
      #("slot", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.service_type {
    [] -> fields
    values -> [
      #("serviceType", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.service_category {
    [] -> fields
    values -> [
      #("serviceCategory", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.requested_period {
    [] -> fields
    values -> [
      #("requestedPeriod", json.array(values, ct.potatoperiod_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.priority {
    Some(v) -> [#("priority", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.patient_instruction {
    Some(v) -> [#("patientInstruction", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.minutes_duration {
    Some(v) -> [#("minutesDuration", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.end {
    Some(v) -> [#("end", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.created {
    Some(v) -> [#("created", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_appointment.comment {
    Some(v) -> [#("comment", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment.cancelation_reason {
    Some(v) -> [
      #("cancelationReason", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_appointment.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment.appointment_type {
    Some(v) -> [
      #("appointmentType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Appointment")), ..fields]
  json.object(fields)
}

pub fn potato_appointment_participant_to_json(
  potato_appointment_participant: PotatoAppointmentParticipant,
) -> Json {
  let fields = [
    #(
      "status",
      valueset.participationstatus_to_json(
        potato_appointment_participant.status,
      ),
    ),
  ]
  let fields = case potato_appointment_participant.type_ {
    [] -> fields
    values -> [
      #("type", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_appointment_participant.required {
    Some(v) -> [
      #("required", valueset.participantrequired_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_appointment_participant.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment_participant.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_appointment_participant.actor {
    Some(v) -> [#("actor", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type PotatoCondition {
  PotatoCondition(
    abatement: Option(PotatoConditionAbatement),
    asserter: Option(ct.Potatoreference),
    body_site: List(ct.Potatocodeableconcept),
    category: List(ct.Potatocodeableconcept),
    screening_assessment: List(
      ct.CodeableconceptPotatoConditionCategoryScreeningAssessment,
    ),
    us_core: List1(ct.CodeableconceptPotatoConditionCategoryUsCore),
    clinical_status: Option(ct.CodeableconceptPotatoConditionClinicalstatus),
    code: ct.Potatocodeableconcept,
    contained: List(Resource),
    encounter: Option(ct.Potatoreference),
    evidence: List(PotatoConditionEvidence),
    asserted_date: Option(DateTime),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    meta: Option(ct.MetaPotatoConditionMeta),
    note: List(ct.Potatoannotation),
    onset: Option(PotatoConditionOnset),
    recorded_date: Option(DateTime),
    recorder: Option(ct.Potatoreference),
    severity: Option(ct.Potatocodeableconcept),
    stage: List(PotatoConditionStage),
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
    verification_status: Option(
      ct.CodeableconceptPotatoConditionVerificationstatus,
    ),
  )
}

pub fn potato_condition_new(
  us_core us_core: List1(ct.CodeableconceptPotatoConditionCategoryUsCore),
  code code: ct.Potatocodeableconcept,
  subject subject: ct.Potatoreference,
) -> PotatoCondition {
  PotatoCondition(
    abatement: None,
    asserter: None,
    body_site: [],
    category: [],
    screening_assessment: [],
    us_core:,
    clinical_status: None,
    code:,
    contained: [],
    encounter: None,
    evidence: [],
    asserted_date: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    language: None,
    meta: Some({
      let meta = ct.meta_potato_condition_meta_new()
      ct.MetaPotatoConditionMeta(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoCondition",
      ])
    }),
    note: [],
    onset: None,
    recorded_date: None,
    recorder: None,
    severity: None,
    stage: [],
    subject:,
    text: None,
    verification_status: None,
  )
}

pub type PotatoConditionOnset {
  PotatoConditionOnsetDatetime(value: DateTime)
  PotatoConditionOnsetAge(value: ct.Potatoage)
  PotatoConditionOnsetPeriod(value: ct.Potatoperiod)
  PotatoConditionOnsetRange(value: ct.Potatorange)
  PotatoConditionOnsetString(value: String)
}

pub type PotatoConditionAbatement {
  PotatoConditionAbatementDatetime(value: DateTime)
  PotatoConditionAbatementAge(value: ct.Potatoage)
  PotatoConditionAbatementPeriod(value: ct.Potatoperiod)
  PotatoConditionAbatementRange(value: ct.Potatorange)
  PotatoConditionAbatementString(value: String)
}

pub type PotatoConditionEvidence {
  PotatoConditionEvidence(
    code: List(ct.Potatocodeableconcept),
    detail: List(ct.Potatoreference),
    id: Option(String),
  )
}

pub fn potato_condition_evidence_new() -> PotatoConditionEvidence {
  PotatoConditionEvidence(code: [], detail: [], id: None)
}

pub type PotatoConditionStage {
  PotatoConditionStage(
    assessment: List(ct.Potatoreference),
    id: Option(String),
    summary: Option(ct.Potatocodeableconcept),
    type_: Option(ct.Potatocodeableconcept),
  )
}

pub fn potato_condition_stage_new() -> PotatoConditionStage {
  PotatoConditionStage(assessment: [], id: None, summary: None, type_: None)
}

pub fn potato_condition_to_json(potato_condition: PotatoCondition) -> Json {
  let fields = [
    #("subject", ct.potatoreference_to_json(potato_condition.subject)),
    #("code", ct.potatocodeableconcept_to_json(potato_condition.code)),
  ]
  let fields = case potato_condition.verification_status {
    Some(v) -> [
      #(
        "verificationStatus",
        ct.codeableconcept_potato_condition_verificationstatus_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_condition.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.stage {
    [] -> fields
    values -> [
      #("stage", json.array(values, potato_condition_stage_to_json)),
      ..fields
    ]
  }
  let fields = case potato_condition.severity {
    Some(v) -> [#("severity", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.recorder {
    Some(v) -> [#("recorder", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.recorded_date {
    Some(v) -> [#("recordedDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.onset {
    Some(v) -> [potato_condition_onset_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case potato_condition.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potato_condition.meta {
    Some(v) -> [#("meta", ct.meta_potato_condition_meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_condition.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      case potato_condition.asserted_date {
        Some(value) -> [
          json.object([
            #(
              "url",
              json.string(
                "http://hl7.org/fhir/StructureDefinition/condition-assertedDate",
              ),
            ),
            #("valueDateTime", pt.datetime_to_json(value)),
          ]),
        ]
        None -> []
      },
      [],
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("extension", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potato_condition.evidence {
    [] -> fields
    values -> [
      #("evidence", json.array(values, potato_condition_evidence_to_json)),
      ..fields
    ]
  }
  let fields = case potato_condition.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_condition.clinical_status {
    Some(v) -> [
      #(
        "clinicalStatus",
        ct.codeableconcept_potato_condition_clinicalstatus_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        ct.codeableconcept_potato_condition_category_us_core_to_json(
          potato_condition.us_core.first,
        ),
        ..list.map(potato_condition.us_core.rest, fn(value) {
          ct.codeableconcept_potato_condition_category_us_core_to_json(value)
        })
      ],
      list.map(potato_condition.screening_assessment, fn(value) {
        ct.codeableconcept_potato_condition_category_screening_assessment_to_json(
          value,
        )
      }),
      list.map(potato_condition.category, fn(value) {
        ct.potatocodeableconcept_to_json(value)
      }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("category", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potato_condition.body_site {
    [] -> fields
    values -> [
      #("bodySite", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_condition.asserter {
    Some(v) -> [#("asserter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition.abatement {
    Some(v) -> [potato_condition_abatement_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Condition")), ..fields]
  json.object(fields)
}

pub fn potato_condition_abatement_to_json_field(
  value: PotatoConditionAbatement,
) -> #(String, Json) {
  case value {
    PotatoConditionAbatementDatetime(value) -> #(
      "abatementDateTime",
      pt.datetime_to_json(value),
    )
    PotatoConditionAbatementAge(value) -> #(
      "abatementAge",
      ct.potatoage_to_json(value),
    )
    PotatoConditionAbatementPeriod(value) -> #(
      "abatementPeriod",
      ct.potatoperiod_to_json(value),
    )
    PotatoConditionAbatementRange(value) -> #(
      "abatementRange",
      ct.potatorange_to_json(value),
    )
    PotatoConditionAbatementString(value) -> #(
      "abatementString",
      json.string(value),
    )
  }
}

pub fn potato_condition_onset_to_json_field(
  value: PotatoConditionOnset,
) -> #(String, Json) {
  case value {
    PotatoConditionOnsetDatetime(value) -> #(
      "onsetDateTime",
      pt.datetime_to_json(value),
    )
    PotatoConditionOnsetAge(value) -> #("onsetAge", ct.potatoage_to_json(value))
    PotatoConditionOnsetPeriod(value) -> #(
      "onsetPeriod",
      ct.potatoperiod_to_json(value),
    )
    PotatoConditionOnsetRange(value) -> #(
      "onsetRange",
      ct.potatorange_to_json(value),
    )
    PotatoConditionOnsetString(value) -> #("onsetString", json.string(value))
  }
}

pub fn potato_condition_evidence_to_json(
  potato_condition_evidence: PotatoConditionEvidence,
) -> Json {
  let fields = []
  let fields = case potato_condition_evidence.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition_evidence.detail {
    [] -> fields
    values -> [
      #("detail", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_condition_evidence.code {
    [] -> fields
    values -> [
      #("code", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  json.object(fields)
}

pub fn potato_condition_stage_to_json(
  potato_condition_stage: PotatoConditionStage,
) -> Json {
  let fields = []
  let fields = case potato_condition_stage.type_ {
    Some(v) -> [#("type", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition_stage.summary {
    Some(v) -> [#("summary", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition_stage.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_condition_stage.assessment {
    [] -> fields
    values -> [
      #("assessment", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  json.object(fields)
}

pub type PotatoDocumentreference {
  PotatoDocumentreference(
    authenticator: Option(ct.Potatoreference),
    author: List(ct.Potatoreference),
    category: List1(PotatoDocumentreferenceCategory),
    contained: List(Resource),
    content: List1(PotatoDocumentreferenceContent),
    context: Option(PotatoDocumentreferenceContext),
    custodian: Option(ct.Potatoreference),
    date: Option(Instant),
    description: Option(String),
    doc_status: Option(valueset.CompositionStatus),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    master_identifier: Option(ct.Potatoidentifier),
    meta: Option(ct.Potatometa),
    relates_to: List(PotatoDocumentreferenceRelatesto),
    security_label: List(ct.Potatocodeableconcept),
    status: valueset.DocumentreferenceStatus,
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
    type_: ct.Potatocodeableconcept,
  )
}

pub fn potato_documentreference_new(
  category category: List1(PotatoDocumentreferenceCategory),
  content content: List1(PotatoDocumentreferenceContent),
  status status: valueset.DocumentreferenceStatus,
  subject subject: ct.Potatoreference,
  type_ type_: ct.Potatocodeableconcept,
) -> PotatoDocumentreference {
  PotatoDocumentreference(
    authenticator: None,
    author: [],
    category:,
    contained: [],
    content:,
    context: None,
    custodian: None,
    date: None,
    description: None,
    doc_status: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    language: None,
    master_identifier: None,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoDocumentReference",
      ])
    }),
    relates_to: [],
    security_label: [],
    status:,
    subject:,
    text: None,
    type_:,
  )
}

pub type PotatoDocumentreferenceCategory {
  PotatoDocumentreferenceCategoryUscore(
    value: ct.CodeableconceptPotatoDocumentreferenceCategoryUscore,
  )
  PotatoDocumentreferenceCategoryOpen(value: ct.Potatocodeableconcept)
}

pub type PotatoDocumentreferenceContent {
  PotatoDocumentreferenceContent(
    attachment: ct.AttachmentOmitExtension,
    format: Option(ct.Potatocoding),
    id: Option(String),
  )
}

pub fn potato_documentreference_content_new(
  attachment attachment: ct.AttachmentOmitExtension,
) -> PotatoDocumentreferenceContent {
  PotatoDocumentreferenceContent(attachment:, format: None, id: None)
}

pub type PotatoDocumentreferenceContext {
  PotatoDocumentreferenceContext(
    encounter: Option(ct.Potatoreference),
    event: List(ct.Potatocodeableconcept),
    facility_type: Option(ct.Potatocodeableconcept),
    id: Option(String),
    period: Option(ct.Potatoperiod),
    practice_setting: Option(ct.Potatocodeableconcept),
    related: List(ct.Potatoreference),
    source_patient_info: Option(ct.Potatoreference),
  )
}

pub fn potato_documentreference_context_new() -> PotatoDocumentreferenceContext {
  PotatoDocumentreferenceContext(
    encounter: None,
    event: [],
    facility_type: None,
    id: None,
    period: None,
    practice_setting: None,
    related: [],
    source_patient_info: None,
  )
}

pub type PotatoDocumentreferenceRelatesto {
  PotatoDocumentreferenceRelatesto(
    code: valueset.DocumentRelationshipType,
    id: Option(String),
    target: ct.Potatoreference,
  )
}

pub fn potato_documentreference_relatesto_new(
  code code: valueset.DocumentRelationshipType,
  target target: ct.Potatoreference,
) -> PotatoDocumentreferenceRelatesto {
  PotatoDocumentreferenceRelatesto(code:, id: None, target:)
}

pub fn potato_documentreference_to_json(
  potato_documentreference: PotatoDocumentreference,
) -> Json {
  let fields = [
    #("type", ct.potatocodeableconcept_to_json(potato_documentreference.type_)),
    #("subject", ct.potatoreference_to_json(potato_documentreference.subject)),
    #(
      "status",
      valueset.documentreference_status_to_json(potato_documentreference.status),
    ),
    #(
      "content",
      list1_to_json(
        potato_documentreference.content,
        potato_documentreference_content_to_json,
      ),
    ),
    #(
      "category",
      list1_to_json(
        potato_documentreference.category,
        potato_documentreference_category_to_json,
      ),
    ),
  ]
  let fields = case potato_documentreference.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.security_label {
    [] -> fields
    values -> [
      #("securityLabel", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_documentreference.relates_to {
    [] -> fields
    values -> [
      #(
        "relatesTo",
        json.array(values, potato_documentreference_relatesto_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_documentreference.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.master_identifier {
    Some(v) -> [#("masterIdentifier", ct.potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_documentreference.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.doc_status {
    Some(v) -> [
      #("docStatus", valueset.composition_status_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_documentreference.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.date {
    Some(v) -> [#("date", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.custodian {
    Some(v) -> [#("custodian", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference.context {
    Some(v) -> [
      #("context", potato_documentreference_context_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_documentreference.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_documentreference.author {
    [] -> fields
    values -> [
      #("author", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_documentreference.authenticator {
    Some(v) -> [#("authenticator", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("DocumentReference")), ..fields]
  json.object(fields)
}

pub fn potato_documentreference_category_to_json(
  value: PotatoDocumentreferenceCategory,
) -> Json {
  case value {
    PotatoDocumentreferenceCategoryUscore(value) ->
      ct.codeableconcept_potato_documentreference_category_uscore_to_json(value)
    PotatoDocumentreferenceCategoryOpen(value) ->
      ct.potatocodeableconcept_to_json(value)
  }
}

pub fn potato_documentreference_content_to_json(
  potato_documentreference_content: PotatoDocumentreferenceContent,
) -> Json {
  let fields = [
    #(
      "attachment",
      ct.attachment_omit_extension_to_json(
        potato_documentreference_content.attachment,
      ),
    ),
  ]
  let fields = case potato_documentreference_content.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference_content.format {
    Some(v) -> [#("format", ct.potatocoding_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_documentreference_context_to_json(
  potato_documentreference_context: PotatoDocumentreferenceContext,
) -> Json {
  let fields = []
  let fields = case potato_documentreference_context.source_patient_info {
    Some(v) -> [#("sourcePatientInfo", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference_context.related {
    [] -> fields
    values -> [
      #("related", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_documentreference_context.practice_setting {
    Some(v) -> [
      #("practiceSetting", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_documentreference_context.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference_context.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_documentreference_context.facility_type {
    Some(v) -> [
      #("facilityType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_documentreference_context.event {
    [] -> fields
    values -> [
      #("event", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_documentreference_context.encounter {
    Some(v) -> [
      #("encounter", json.array([v], ct.potatoreference_to_json)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_documentreference_relatesto_to_json(
  potato_documentreference_relatesto: PotatoDocumentreferenceRelatesto,
) -> Json {
  let fields = [
    #(
      "target",
      ct.potatoreference_to_json(potato_documentreference_relatesto.target),
    ),
    #(
      "code",
      valueset.document_relationship_type_to_json(
        potato_documentreference_relatesto.code,
      ),
    ),
  ]
  let fields = case potato_documentreference_relatesto.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type PotatoEncounter {
  PotatoEncounter(
    account: List(ct.Potatoreference),
    appointment: List(ct.Potatoreference),
    based_on: List(ct.Potatoreference),
    class: ct.Potatocoding,
    class_history: List(PotatoEncounterClasshistory),
    contained: List(Resource),
    diagnosis: List(PotatoEncounterDiagnosis),
    episode_of_care: List(ct.Potatoreference),
    hospitalization: Option(PotatoEncounterHospitalization),
    id: Option(String),
    identifier: List(ct.IdentifierPotatoEncounterIdentifier),
    implicit_rules: Option(String),
    language: Option(String),
    length: Option(ct.Potatoduration),
    location: List(PotatoEncounterLocation),
    meta: Option(ct.MetaPotatoEncounterMeta),
    part_of: Option(ct.Potatoreference),
    participant: List(PotatoEncounterParticipant),
    period: Option(ct.Potatoperiod),
    priority: Option(ct.Potatocodeableconcept),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    service_provider: Option(ct.Potatoreference),
    service_type: Option(ct.Potatocodeableconcept),
    status: valueset.EncounterStatus,
    status_history: List(PotatoEncounterStatushistory),
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
    type_: List1(ct.Potatocodeableconcept),
  )
}

pub fn potato_encounter_new(
  class class: ct.Potatocoding,
  status status: valueset.EncounterStatus,
  subject subject: ct.Potatoreference,
  type_ type_: List1(ct.Potatocodeableconcept),
) -> PotatoEncounter {
  PotatoEncounter(
    account: [],
    appointment: [],
    based_on: [],
    class:,
    class_history: [],
    contained: [],
    diagnosis: [],
    episode_of_care: [],
    hospitalization: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    language: None,
    length: None,
    location: [],
    meta: Some({
      let meta = ct.meta_potato_encounter_meta_new()
      ct.MetaPotatoEncounterMeta(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoEncounter",
      ])
    }),
    part_of: None,
    participant: [],
    period: None,
    priority: None,
    reason_code: [],
    reason_reference: [],
    service_provider: None,
    service_type: None,
    status:,
    status_history: [],
    subject:,
    text: None,
    type_:,
  )
}

pub type PotatoEncounterClasshistory {
  PotatoEncounterClasshistory(
    class: ct.Potatocoding,
    id: Option(String),
    period: ct.Potatoperiod,
  )
}

pub fn potato_encounter_classhistory_new(
  class class: ct.Potatocoding,
  period period: ct.Potatoperiod,
) -> PotatoEncounterClasshistory {
  PotatoEncounterClasshistory(class:, id: None, period:)
}

pub type PotatoEncounterDiagnosis {
  PotatoEncounterDiagnosis(
    condition: ct.Potatoreference,
    id: Option(String),
    rank: Option(Int),
    use_: Option(ct.Potatocodeableconcept),
  )
}

pub fn potato_encounter_diagnosis_new(
  condition condition: ct.Potatoreference,
) -> PotatoEncounterDiagnosis {
  PotatoEncounterDiagnosis(condition:, id: None, rank: None, use_: None)
}

pub type PotatoEncounterHospitalization {
  PotatoEncounterHospitalization(
    admit_source: Option(ct.Potatocodeableconcept),
    destination: Option(ct.Potatoreference),
    diet_preference: List(ct.Potatocodeableconcept),
    discharge_disposition: Option(ct.Potatocodeableconcept),
    id: Option(String),
    origin: Option(ct.Potatoreference),
    pre_admission_identifier: Option(ct.Potatoidentifier),
    re_admission: Option(ct.Potatocodeableconcept),
    special_arrangement: List(ct.Potatocodeableconcept),
    special_courtesy: List(ct.Potatocodeableconcept),
  )
}

pub fn potato_encounter_hospitalization_new() -> PotatoEncounterHospitalization {
  PotatoEncounterHospitalization(
    admit_source: None,
    destination: None,
    diet_preference: [],
    discharge_disposition: None,
    id: None,
    origin: None,
    pre_admission_identifier: None,
    re_admission: None,
    special_arrangement: [],
    special_courtesy: [],
  )
}

pub type PotatoEncounterLocation {
  PotatoEncounterLocation(
    id: Option(String),
    location: ct.Potatoreference,
    period: Option(ct.Potatoperiod),
    physical_type: Option(ct.Potatocodeableconcept),
    status: Option(valueset.EncounterLocationStatus),
  )
}

pub fn potato_encounter_location_new(
  location location: ct.Potatoreference,
) -> PotatoEncounterLocation {
  PotatoEncounterLocation(
    id: None,
    location:,
    period: None,
    physical_type: None,
    status: None,
  )
}

pub type PotatoEncounterParticipant {
  PotatoEncounterParticipant(
    id: Option(String),
    individual: Option(ct.Potatoreference),
    period: Option(ct.Potatoperiod),
    type_: List(ct.Potatocodeableconcept),
  )
}

pub fn potato_encounter_participant_new() -> PotatoEncounterParticipant {
  PotatoEncounterParticipant(
    id: None,
    individual: None,
    period: None,
    type_: [],
  )
}

pub type PotatoEncounterStatushistory {
  PotatoEncounterStatushistory(
    id: Option(String),
    period: ct.Potatoperiod,
    status: valueset.EncounterStatus,
  )
}

pub fn potato_encounter_statushistory_new(
  period period: ct.Potatoperiod,
  status status: valueset.EncounterStatus,
) -> PotatoEncounterStatushistory {
  PotatoEncounterStatushistory(id: None, period:, status:)
}

pub fn potato_encounter_to_json(potato_encounter: PotatoEncounter) -> Json {
  let fields = [
    #(
      "type",
      list1_to_json(potato_encounter.type_, ct.potatocodeableconcept_to_json),
    ),
    #("subject", ct.potatoreference_to_json(potato_encounter.subject)),
    #("status", valueset.encounter_status_to_json(potato_encounter.status)),
    #("class", ct.potatocoding_to_json(potato_encounter.class)),
  ]
  let fields = case potato_encounter.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.status_history {
    [] -> fields
    values -> [
      #(
        "statusHistory",
        json.array(values, potato_encounter_statushistory_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_encounter.service_type {
    Some(v) -> [#("serviceType", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.service_provider {
    Some(v) -> [#("serviceProvider", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.priority {
    Some(v) -> [#("priority", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.participant {
    [] -> fields
    values -> [
      #("participant", json.array(values, potato_encounter_participant_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.part_of {
    Some(v) -> [#("partOf", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.meta {
    Some(v) -> [#("meta", ct.meta_potato_encounter_meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.location {
    [] -> fields
    values -> [
      #("location", json.array(values, potato_encounter_location_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.length {
    Some(v) -> [#("length", ct.potatoduration_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.identifier {
    [] -> fields
    values -> [
      #(
        "identifier",
        json.array(values, ct.identifier_potato_encounter_identifier_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_encounter.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter.hospitalization {
    Some(v) -> [
      #("hospitalization", potato_encounter_hospitalization_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_encounter.episode_of_care {
    [] -> fields
    values -> [
      #("episodeOfCare", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.diagnosis {
    [] -> fields
    values -> [
      #("diagnosis", json.array(values, potato_encounter_diagnosis_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_encounter.class_history {
    [] -> fields
    values -> [
      #(
        "classHistory",
        json.array(values, potato_encounter_classhistory_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_encounter.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.appointment {
    [] -> fields
    values -> [
      #("appointment", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter.account {
    [] -> fields
    values -> [
      #("account", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = [#("resourceType", json.string("Encounter")), ..fields]
  json.object(fields)
}

pub fn potato_encounter_classhistory_to_json(
  potato_encounter_classhistory: PotatoEncounterClasshistory,
) -> Json {
  let fields = [
    #("period", ct.potatoperiod_to_json(potato_encounter_classhistory.period)),
    #("class", ct.potatocoding_to_json(potato_encounter_classhistory.class)),
  ]
  let fields = case potato_encounter_classhistory.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_encounter_diagnosis_to_json(
  potato_encounter_diagnosis: PotatoEncounterDiagnosis,
) -> Json {
  let fields = [
    #(
      "condition",
      ct.potatoreference_to_json(potato_encounter_diagnosis.condition),
    ),
  ]
  let fields = case potato_encounter_diagnosis.use_ {
    Some(v) -> [#("use", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_diagnosis.rank {
    Some(v) -> [#("rank", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_diagnosis.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_encounter_hospitalization_to_json(
  potato_encounter_hospitalization: PotatoEncounterHospitalization,
) -> Json {
  let fields = []
  let fields = case potato_encounter_hospitalization.special_courtesy {
    [] -> fields
    values -> [
      #("specialCourtesy", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter_hospitalization.special_arrangement {
    [] -> fields
    values -> [
      #(
        "specialArrangement",
        json.array(values, ct.potatocodeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_encounter_hospitalization.re_admission {
    Some(v) -> [#("reAdmission", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_hospitalization.pre_admission_identifier {
    Some(v) -> [
      #("preAdmissionIdentifier", ct.potatoidentifier_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_encounter_hospitalization.origin {
    Some(v) -> [#("origin", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_hospitalization.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_hospitalization.discharge_disposition {
    Some(v) -> [
      #("dischargeDisposition", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_encounter_hospitalization.diet_preference {
    [] -> fields
    values -> [
      #("dietPreference", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter_hospitalization.destination {
    Some(v) -> [#("destination", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_hospitalization.admit_source {
    Some(v) -> [#("admitSource", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_encounter_location_to_json(
  potato_encounter_location: PotatoEncounterLocation,
) -> Json {
  let fields = [
    #(
      "location",
      ct.potatoreference_to_json(potato_encounter_location.location),
    ),
  ]
  let fields = case potato_encounter_location.status {
    Some(v) -> [
      #("status", valueset.encounter_location_status_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_encounter_location.physical_type {
    Some(v) -> [
      #("physicalType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_encounter_location.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_location.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_encounter_participant_to_json(
  potato_encounter_participant: PotatoEncounterParticipant,
) -> Json {
  let fields = []
  let fields = case potato_encounter_participant.type_ {
    [] -> fields
    values -> [
      #("type", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_encounter_participant.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_participant.individual {
    Some(v) -> [#("individual", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_encounter_participant.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_encounter_statushistory_to_json(
  potato_encounter_statushistory: PotatoEncounterStatushistory,
) -> Json {
  let fields = [
    #(
      "status",
      valueset.encounter_status_to_json(potato_encounter_statushistory.status),
    ),
    #("period", ct.potatoperiod_to_json(potato_encounter_statushistory.period)),
  ]
  let fields = case potato_encounter_statushistory.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type PotatoImmunization {
  PotatoImmunization(
    contained: List(Resource),
    dose_quantity: Option(ct.Potatosimplequantity),
    education: List(PotatoImmunizationEducation),
    encounter: Option(ct.Potatoreference),
    expiration_date: Option(Date),
    funding_source: Option(ct.Potatocodeableconcept),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    is_subpotent: Option(Bool),
    language: Option(String),
    location: Option(ct.Potatoreference),
    lot_number: Option(String),
    manufacturer: Option(ct.Potatoreference),
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    occurrence: PotatoImmunizationOccurrence,
    patient: ct.Potatoreference,
    performer: List(PotatoImmunizationPerformer),
    primary_source: Option(Bool),
    program_eligibility: List(ct.Potatocodeableconcept),
    protocol_applied: List(PotatoImmunizationProtocolapplied),
    reaction: List(PotatoImmunizationReaction),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    recorded: Option(DateTime),
    report_origin: Option(ct.Potatocodeableconcept),
    route: Option(ct.Potatocodeableconcept),
    site: Option(ct.Potatocodeableconcept),
    status: valueset.ImmunizationStatus,
    status_reason: Option(ct.Potatocodeableconcept),
    subpotent_reason: List(ct.Potatocodeableconcept),
    text: Option(ct.Potatonarrative),
    vaccine_code: ct.Potatocodeableconcept,
  )
}

pub fn potato_immunization_new(
  occurrence occurrence: PotatoImmunizationOccurrence,
  patient patient: ct.Potatoreference,
  status status: valueset.ImmunizationStatus,
  vaccine_code vaccine_code: ct.Potatocodeableconcept,
) -> PotatoImmunization {
  PotatoImmunization(
    contained: [],
    dose_quantity: None,
    education: [],
    encounter: None,
    expiration_date: None,
    funding_source: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    is_subpotent: None,
    language: None,
    location: None,
    lot_number: None,
    manufacturer: None,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoImmunization",
      ])
    }),
    note: [],
    occurrence:,
    patient:,
    performer: [],
    primary_source: None,
    program_eligibility: [],
    protocol_applied: [],
    reaction: [],
    reason_code: [],
    reason_reference: [],
    recorded: None,
    report_origin: None,
    route: None,
    site: None,
    status:,
    status_reason: None,
    subpotent_reason: [],
    text: None,
    vaccine_code:,
  )
}

pub type PotatoImmunizationOccurrence {
  PotatoImmunizationOccurrenceDatetime(value: DateTime)
  PotatoImmunizationOccurrenceString(value: String)
}

pub type PotatoImmunizationEducation {
  PotatoImmunizationEducation(
    document_type: Option(String),
    id: Option(String),
    presentation_date: Option(DateTime),
    publication_date: Option(DateTime),
    reference: Option(String),
  )
}

pub fn potato_immunization_education_new() -> PotatoImmunizationEducation {
  PotatoImmunizationEducation(
    document_type: None,
    id: None,
    presentation_date: None,
    publication_date: None,
    reference: None,
  )
}

pub type PotatoImmunizationPerformer {
  PotatoImmunizationPerformer(
    actor: ct.Potatoreference,
    function: Option(ct.Potatocodeableconcept),
    id: Option(String),
  )
}

pub fn potato_immunization_performer_new(
  actor actor: ct.Potatoreference,
) -> PotatoImmunizationPerformer {
  PotatoImmunizationPerformer(actor:, function: None, id: None)
}

pub type PotatoImmunizationProtocolapplied {
  PotatoImmunizationProtocolapplied(
    authority: Option(ct.Potatoreference),
    dose_number: PotatoImmunizationProtocolappliedDosenumber,
    id: Option(String),
    series: Option(String),
    series_doses: Option(PotatoImmunizationProtocolappliedSeriesdoses),
    target_disease: List(ct.Potatocodeableconcept),
  )
}

pub fn potato_immunization_protocolapplied_new(
  dose_number dose_number: PotatoImmunizationProtocolappliedDosenumber,
) -> PotatoImmunizationProtocolapplied {
  PotatoImmunizationProtocolapplied(
    authority: None,
    dose_number:,
    id: None,
    series: None,
    series_doses: None,
    target_disease: [],
  )
}

pub type PotatoImmunizationProtocolappliedSeriesdoses {
  PotatoImmunizationProtocolappliedSeriesdosesPositiveint(value: Int)
  PotatoImmunizationProtocolappliedSeriesdosesString(value: String)
}

pub type PotatoImmunizationProtocolappliedDosenumber {
  PotatoImmunizationProtocolappliedDosenumberPositiveint(value: Int)
  PotatoImmunizationProtocolappliedDosenumberString(value: String)
}

pub type PotatoImmunizationReaction {
  PotatoImmunizationReaction(
    date: Option(DateTime),
    detail: Option(ct.Potatoreference),
    id: Option(String),
    reported: Option(Bool),
  )
}

pub fn potato_immunization_reaction_new() -> PotatoImmunizationReaction {
  PotatoImmunizationReaction(date: None, detail: None, id: None, reported: None)
}

pub fn potato_immunization_to_json(
  potato_immunization: PotatoImmunization,
) -> Json {
  let fields = [
    #(
      "vaccineCode",
      ct.potatocodeableconcept_to_json(potato_immunization.vaccine_code),
    ),
    #(
      "status",
      valueset.immunization_status_to_json(potato_immunization.status),
    ),
    #("patient", ct.potatoreference_to_json(potato_immunization.patient)),
    potato_immunization_occurrence_to_json_field(potato_immunization.occurrence),
  ]
  let fields = case potato_immunization.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.subpotent_reason {
    [] -> fields
    values -> [
      #("subpotentReason", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.status_reason {
    Some(v) -> [
      #("statusReason", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_immunization.site {
    Some(v) -> [#("site", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.route {
    Some(v) -> [#("route", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.report_origin {
    Some(v) -> [
      #("reportOrigin", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_immunization.recorded {
    Some(v) -> [#("recorded", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.reaction {
    [] -> fields
    values -> [
      #("reaction", json.array(values, potato_immunization_reaction_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.protocol_applied {
    [] -> fields
    values -> [
      #(
        "protocolApplied",
        json.array(values, potato_immunization_protocolapplied_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_immunization.program_eligibility {
    [] -> fields
    values -> [
      #(
        "programEligibility",
        json.array(values, ct.potatocodeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_immunization.primary_source {
    Some(v) -> [#("primarySource", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.performer {
    [] -> fields
    values -> [
      #("performer", json.array(values, potato_immunization_performer_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.manufacturer {
    Some(v) -> [#("manufacturer", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.lot_number {
    Some(v) -> [#("lotNumber", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.location {
    Some(v) -> [#("location", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.is_subpotent {
    Some(v) -> [#("isSubpotent", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.funding_source {
    Some(v) -> [
      #("fundingSource", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_immunization.expiration_date {
    Some(v) -> [#("expirationDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.education {
    [] -> fields
    values -> [
      #("education", json.array(values, potato_immunization_education_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization.dose_quantity {
    Some(v) -> [#("doseQuantity", ct.potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = [#("resourceType", json.string("Immunization")), ..fields]
  json.object(fields)
}

pub fn potato_immunization_occurrence_to_json_field(
  value: PotatoImmunizationOccurrence,
) -> #(String, Json) {
  case value {
    PotatoImmunizationOccurrenceDatetime(value) -> #(
      "occurrenceDateTime",
      pt.datetime_to_json(value),
    )
    PotatoImmunizationOccurrenceString(value) -> #(
      "occurrenceString",
      json.string(value),
    )
  }
}

pub fn potato_immunization_education_to_json(
  potato_immunization_education: PotatoImmunizationEducation,
) -> Json {
  let fields = []
  let fields = case potato_immunization_education.reference {
    Some(v) -> [#("reference", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_education.publication_date {
    Some(v) -> [#("publicationDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_education.presentation_date {
    Some(v) -> [#("presentationDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_education.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_education.document_type {
    Some(v) -> [#("documentType", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_immunization_performer_to_json(
  potato_immunization_performer: PotatoImmunizationPerformer,
) -> Json {
  let fields = [
    #("actor", ct.potatoreference_to_json(potato_immunization_performer.actor)),
  ]
  let fields = case potato_immunization_performer.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_performer.function {
    Some(v) -> [#("function", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_immunization_protocolapplied_to_json(
  potato_immunization_protocolapplied: PotatoImmunizationProtocolapplied,
) -> Json {
  let fields = [
    potato_immunization_protocolapplied_dosenumber_to_json_field(
      potato_immunization_protocolapplied.dose_number,
    ),
  ]
  let fields = case potato_immunization_protocolapplied.target_disease {
    [] -> fields
    values -> [
      #("targetDisease", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_immunization_protocolapplied.series_doses {
    Some(v) -> [
      potato_immunization_protocolapplied_seriesdoses_to_json_field(v),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_immunization_protocolapplied.series {
    Some(v) -> [#("series", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_protocolapplied.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_protocolapplied.authority {
    Some(v) -> [#("authority", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_immunization_protocolapplied_dosenumber_to_json_field(
  value: PotatoImmunizationProtocolappliedDosenumber,
) -> #(String, Json) {
  case value {
    PotatoImmunizationProtocolappliedDosenumberPositiveint(value) -> #(
      "doseNumberPositiveInt",
      json.int(value),
    )
    PotatoImmunizationProtocolappliedDosenumberString(value) -> #(
      "doseNumberString",
      json.string(value),
    )
  }
}

pub fn potato_immunization_protocolapplied_seriesdoses_to_json_field(
  value: PotatoImmunizationProtocolappliedSeriesdoses,
) -> #(String, Json) {
  case value {
    PotatoImmunizationProtocolappliedSeriesdosesPositiveint(value) -> #(
      "seriesDosesPositiveInt",
      json.int(value),
    )
    PotatoImmunizationProtocolappliedSeriesdosesString(value) -> #(
      "seriesDosesString",
      json.string(value),
    )
  }
}

pub fn potato_immunization_reaction_to_json(
  potato_immunization_reaction: PotatoImmunizationReaction,
) -> Json {
  let fields = []
  let fields = case potato_immunization_reaction.reported {
    Some(v) -> [#("reported", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_reaction.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_reaction.detail {
    Some(v) -> [#("detail", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_immunization_reaction.date {
    Some(v) -> [#("date", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type PotatoMedicationrequest {
  PotatoMedicationrequest(
    authored_on: Option(DateTime),
    based_on: List(ct.Potatoreference),
    category: List(ct.Potatocodeableconcept),
    us_core: List(ct.CodeableconceptPotatoMedicationrequestCategoryUsCore),
    contained: List(Resource),
    course_of_therapy_type: Option(ct.Potatocodeableconcept),
    detected_issue: List(ct.Potatoreference),
    dispense_request: Option(PotatoMedicationrequestDispenserequest),
    do_not_perform: Option(Bool),
    dosage_instruction: List(ct.DosagePotatoMedicationrequestDosageinstruction),
    encounter: Option(ct.Potatoreference),
    event_history: List(ct.Potatoreference),
    medication_adherence: List(ct.Potatomedicationadherence),
    group_identifier: Option(ct.Potatoidentifier),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    instantiates_canonical: List(String),
    instantiates_uri: List(String),
    insurance: List(ct.Potatoreference),
    intent: valueset.MedicationrequestIntent,
    language: Option(String),
    medication: PotatoMedicationrequestMedication,
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    performer: Option(ct.Potatoreference),
    performer_type: Option(ct.Potatocodeableconcept),
    prior_prescription: Option(ct.Potatoreference),
    priority: Option(valueset.RequestPriority),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    recorder: Option(ct.Potatoreference),
    reported: Option(PotatoMedicationrequestReported),
    requester: Option(ct.Potatoreference),
    status: valueset.MedicationrequestStatus,
    status_reason: Option(ct.Potatocodeableconcept),
    subject: ct.Potatoreference,
    substitution: Option(PotatoMedicationrequestSubstitution),
    supporting_information: List(ct.Potatoreference),
    text: Option(ct.Potatonarrative),
  )
}

pub fn potato_medicationrequest_new(
  intent intent: valueset.MedicationrequestIntent,
  medication medication: PotatoMedicationrequestMedication,
  status status: valueset.MedicationrequestStatus,
  subject subject: ct.Potatoreference,
) -> PotatoMedicationrequest {
  PotatoMedicationrequest(
    authored_on: None,
    based_on: [],
    category: [],
    us_core: [],
    contained: [],
    course_of_therapy_type: None,
    detected_issue: [],
    dispense_request: None,
    do_not_perform: None,
    dosage_instruction: [],
    encounter: None,
    event_history: [],
    medication_adherence: [],
    group_identifier: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    instantiates_canonical: [],
    instantiates_uri: [],
    insurance: [],
    intent:,
    language: None,
    medication:,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoMedicationRequest",
      ])
    }),
    note: [],
    performer: None,
    performer_type: None,
    prior_prescription: None,
    priority: None,
    reason_code: [],
    reason_reference: [],
    recorder: None,
    reported: None,
    requester: None,
    status:,
    status_reason: None,
    subject:,
    substitution: None,
    supporting_information: [],
    text: None,
  )
}

pub type PotatoMedicationrequestReported {
  PotatoMedicationrequestReportedBoolean(value: Bool)
  PotatoMedicationrequestReportedReference(value: ct.Potatoreference)
}

pub type PotatoMedicationrequestMedication {
  PotatoMedicationrequestMedicationCodeableconcept(
    value: ct.Potatocodeableconcept,
  )
  PotatoMedicationrequestMedicationReference(value: ct.Potatoreference)
}

pub type PotatoMedicationrequestDispenserequest {
  PotatoMedicationrequestDispenserequest(
    dispense_interval: Option(ct.Potatoduration),
    expected_supply_duration: Option(ct.Potatoduration),
    id: Option(String),
    initial_fill: Option(PotatoMedicationrequestDispenserequestInitialfill),
    number_of_repeats_allowed: Option(Int),
    performer: Option(ct.Potatoreference),
    quantity: Option(ct.Potatosimplequantity),
    validity_period: Option(ct.Potatoperiod),
  )
}

pub fn potato_medicationrequest_dispenserequest_new() -> PotatoMedicationrequestDispenserequest {
  PotatoMedicationrequestDispenserequest(
    dispense_interval: None,
    expected_supply_duration: None,
    id: None,
    initial_fill: None,
    number_of_repeats_allowed: None,
    performer: None,
    quantity: None,
    validity_period: None,
  )
}

pub type PotatoMedicationrequestDispenserequestInitialfill {
  PotatoMedicationrequestDispenserequestInitialfill(
    duration: Option(ct.Potatoduration),
    id: Option(String),
    quantity: Option(ct.Potatosimplequantity),
  )
}

pub fn potato_medicationrequest_dispenserequest_initialfill_new() -> PotatoMedicationrequestDispenserequestInitialfill {
  PotatoMedicationrequestDispenserequestInitialfill(
    duration: None,
    id: None,
    quantity: None,
  )
}

pub type PotatoMedicationrequestSubstitution {
  PotatoMedicationrequestSubstitution(
    allowed: PotatoMedicationrequestSubstitutionAllowed,
    id: Option(String),
    reason: Option(ct.Potatocodeableconcept),
  )
}

pub fn potato_medicationrequest_substitution_new(
  allowed allowed: PotatoMedicationrequestSubstitutionAllowed,
) -> PotatoMedicationrequestSubstitution {
  PotatoMedicationrequestSubstitution(allowed:, id: None, reason: None)
}

pub type PotatoMedicationrequestSubstitutionAllowed {
  PotatoMedicationrequestSubstitutionAllowedBoolean(value: Bool)
  PotatoMedicationrequestSubstitutionAllowedCodeableconcept(
    value: ct.Potatocodeableconcept,
  )
}

pub fn potato_medicationrequest_to_json(
  potato_medicationrequest: PotatoMedicationrequest,
) -> Json {
  let fields = [
    #("subject", ct.potatoreference_to_json(potato_medicationrequest.subject)),
    #(
      "status",
      valueset.medicationrequest_status_to_json(potato_medicationrequest.status),
    ),
    potato_medicationrequest_medication_to_json_field(
      potato_medicationrequest.medication,
    ),
    #(
      "intent",
      valueset.medicationrequest_intent_to_json(potato_medicationrequest.intent),
    ),
  ]
  let fields = case potato_medicationrequest.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.supporting_information {
    [] -> fields
    values -> [
      #("supportingInformation", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.substitution {
    Some(v) -> [
      #("substitution", potato_medicationrequest_substitution_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest.status_reason {
    Some(v) -> [
      #("statusReason", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest.requester {
    Some(v) -> [#("requester", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.reported {
    Some(v) -> [potato_medicationrequest_reported_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.recorder {
    Some(v) -> [#("recorder", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.priority {
    Some(v) -> [#("priority", valueset.request_priority_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.prior_prescription {
    Some(v) -> [#("priorPrescription", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.performer_type {
    Some(v) -> [
      #("performerType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest.performer {
    Some(v) -> [#("performer", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.insurance {
    [] -> fields
    values -> [
      #("insurance", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.instantiates_uri {
    [] -> fields
    values -> [#("instantiatesUri", json.array(values, json.string)), ..fields]
  }
  let fields = case potato_medicationrequest.instantiates_canonical {
    [] -> fields
    values -> [
      #("instantiatesCanonical", json.array(values, json.string)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.group_identifier {
    Some(v) -> [#("groupIdentifier", ct.potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      list.map(potato_medicationrequest.medication_adherence, fn(value) {
        ct.potatomedicationadherence_to_json(
          value,
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication-adherence",
        )
      }),
      [],
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("extension", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potato_medicationrequest.event_history {
    [] -> fields
    values -> [
      #("eventHistory", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.dosage_instruction {
    [] -> fields
    values -> [
      #(
        "dosageInstruction",
        json.array(
          values,
          ct.dosage_potato_medicationrequest_dosageinstruction_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.do_not_perform {
    Some(v) -> [#("doNotPerform", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest.dispense_request {
    Some(v) -> [
      #("dispenseRequest", potato_medicationrequest_dispenserequest_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest.detected_issue {
    [] -> fields
    values -> [
      #("detectedIssue", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.course_of_therapy_type {
    Some(v) -> [
      #("courseOfTherapyType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let slice_values =
    list.flatten([
      list.map(potato_medicationrequest.us_core, fn(value) {
        ct.codeableconcept_potato_medicationrequest_category_us_core_to_json(
          value,
        )
      }),
      list.map(potato_medicationrequest.category, fn(value) {
        ct.potatocodeableconcept_to_json(value)
      }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("category", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potato_medicationrequest.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationrequest.authored_on {
    Some(v) -> [#("authoredOn", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("MedicationRequest")), ..fields]
  json.object(fields)
}

pub fn potato_medicationrequest_medication_to_json_field(
  value: PotatoMedicationrequestMedication,
) -> #(String, Json) {
  case value {
    PotatoMedicationrequestMedicationCodeableconcept(value) -> #(
      "medicationCodeableConcept",
      ct.potatocodeableconcept_to_json(value),
    )
    PotatoMedicationrequestMedicationReference(value) -> #(
      "medicationReference",
      ct.potatoreference_to_json(value),
    )
  }
}

pub fn potato_medicationrequest_reported_to_json_field(
  value: PotatoMedicationrequestReported,
) -> #(String, Json) {
  case value {
    PotatoMedicationrequestReportedBoolean(value) -> #(
      "reportedBoolean",
      json.bool(value),
    )
    PotatoMedicationrequestReportedReference(value) -> #(
      "reportedReference",
      ct.potatoreference_to_json(value),
    )
  }
}

pub fn potato_medicationrequest_dispenserequest_to_json(
  potato_medicationrequest_dispenserequest: PotatoMedicationrequestDispenserequest,
) -> Json {
  let fields = []
  let fields = case potato_medicationrequest_dispenserequest.validity_period {
    Some(v) -> [#("validityPeriod", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest_dispenserequest.quantity {
    Some(v) -> [#("quantity", ct.potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest_dispenserequest.performer {
    Some(v) -> [#("performer", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case
    potato_medicationrequest_dispenserequest.number_of_repeats_allowed
  {
    Some(v) -> [#("numberOfRepeatsAllowed", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest_dispenserequest.initial_fill {
    Some(v) -> [
      #(
        "initialFill",
        potato_medicationrequest_dispenserequest_initialfill_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest_dispenserequest.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    potato_medicationrequest_dispenserequest.expected_supply_duration
  {
    Some(v) -> [
      #("expectedSupplyDuration", ct.potatoduration_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_medicationrequest_dispenserequest.dispense_interval {
    Some(v) -> [#("dispenseInterval", ct.potatoduration_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_medicationrequest_dispenserequest_initialfill_to_json(
  potato_medicationrequest_dispenserequest_initialfill: PotatoMedicationrequestDispenserequestInitialfill,
) -> Json {
  let fields = []
  let fields = case
    potato_medicationrequest_dispenserequest_initialfill.quantity
  {
    Some(v) -> [#("quantity", ct.potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest_dispenserequest_initialfill.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    potato_medicationrequest_dispenserequest_initialfill.duration
  {
    Some(v) -> [#("duration", ct.potatoduration_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_medicationrequest_substitution_to_json(
  potato_medicationrequest_substitution: PotatoMedicationrequestSubstitution,
) -> Json {
  let fields = [
    potato_medicationrequest_substitution_allowed_to_json_field(
      potato_medicationrequest_substitution.allowed,
    ),
  ]
  let fields = case potato_medicationrequest_substitution.reason {
    Some(v) -> [#("reason", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationrequest_substitution.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_medicationrequest_substitution_allowed_to_json_field(
  value: PotatoMedicationrequestSubstitutionAllowed,
) -> #(String, Json) {
  case value {
    PotatoMedicationrequestSubstitutionAllowedBoolean(value) -> #(
      "allowedBoolean",
      json.bool(value),
    )
    PotatoMedicationrequestSubstitutionAllowedCodeableconcept(value) -> #(
      "allowedCodeableConcept",
      ct.potatocodeableconcept_to_json(value),
    )
  }
}

pub type PotatoMedicationstatement {
  PotatoMedicationstatement(
    based_on: List(ct.Potatoreference),
    category: Option(ct.Potatocodeableconcept),
    contained: List(Resource),
    context: Option(ct.Potatoreference),
    date_asserted: Option(DateTime),
    derived_from: List(ct.Potatoreference),
    dosage: List(ct.Potatodosage),
    effective: Option(PotatoMedicationstatementEffective),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    information_source: Option(ct.Potatoreference),
    language: Option(String),
    medication: PotatoMedicationstatementMedication,
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    part_of: List(ct.Potatoreference),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    status: valueset.MedicationstatementStatus,
    status_reason: List(ct.Potatocodeableconcept),
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
  )
}

pub fn potato_medicationstatement_new(
  medication medication: PotatoMedicationstatementMedication,
  status status: valueset.MedicationstatementStatus,
  subject subject: ct.Potatoreference,
) -> PotatoMedicationstatement {
  PotatoMedicationstatement(
    based_on: [],
    category: None,
    contained: [],
    context: None,
    date_asserted: None,
    derived_from: [],
    dosage: [],
    effective: None,
    id: None,
    identifier: [],
    implicit_rules: None,
    information_source: None,
    language: None,
    medication:,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoMedicationStatement",
      ])
    }),
    note: [],
    part_of: [],
    reason_code: [],
    reason_reference: [],
    status:,
    status_reason: [],
    subject:,
    text: None,
  )
}

pub type PotatoMedicationstatementMedication {
  PotatoMedicationstatementMedicationCodeableconcept(
    value: ct.Potatocodeableconcept,
  )
  PotatoMedicationstatementMedicationReference(value: ct.Potatoreference)
}

pub type PotatoMedicationstatementEffective {
  PotatoMedicationstatementEffectiveDatetime(value: DateTime)
  PotatoMedicationstatementEffectivePeriod(value: ct.Potatoperiod)
}

pub fn potato_medicationstatement_to_json(
  potato_medicationstatement: PotatoMedicationstatement,
) -> Json {
  let fields = [
    #("subject", ct.potatoreference_to_json(potato_medicationstatement.subject)),
    #(
      "status",
      valueset.medicationstatement_status_to_json(
        potato_medicationstatement.status,
      ),
    ),
    potato_medicationstatement_medication_to_json_field(
      potato_medicationstatement.medication,
    ),
  ]
  let fields = case potato_medicationstatement.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.status_reason {
    [] -> fields
    values -> [
      #("statusReason", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.part_of {
    [] -> fields
    values -> [
      #("partOf", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.information_source {
    Some(v) -> [#("informationSource", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.effective {
    Some(v) -> [potato_medicationstatement_effective_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.dosage {
    [] -> fields
    values -> [
      #("dosage", json.array(values, ct.potatodosage_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.derived_from {
    [] -> fields
    values -> [
      #("derivedFrom", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potato_medicationstatement.date_asserted {
    Some(v) -> [#("dateAsserted", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.context {
    Some(v) -> [#("context", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_medicationstatement.category {
    Some(v) -> [#("category", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_medicationstatement.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = [#("resourceType", json.string("MedicationStatement")), ..fields]
  json.object(fields)
}

pub fn potato_medicationstatement_effective_to_json_field(
  value: PotatoMedicationstatementEffective,
) -> #(String, Json) {
  case value {
    PotatoMedicationstatementEffectiveDatetime(value) -> #(
      "effectiveDateTime",
      pt.datetime_to_json(value),
    )
    PotatoMedicationstatementEffectivePeriod(value) -> #(
      "effectivePeriod",
      ct.potatoperiod_to_json(value),
    )
  }
}

pub fn potato_medicationstatement_medication_to_json_field(
  value: PotatoMedicationstatementMedication,
) -> #(String, Json) {
  case value {
    PotatoMedicationstatementMedicationCodeableconcept(value) -> #(
      "medicationCodeableConcept",
      ct.potatocodeableconcept_to_json(value),
    )
    PotatoMedicationstatementMedicationReference(value) -> #(
      "medicationReference",
      ct.potatoreference_to_json(value),
    )
  }
}

pub type PotatoPatient {
  PotatoPatient(
    active: Option(Bool),
    address: List(ct.AddressPotatoPatientAddress),
    birth_date: Option(Date),
    communication: List(PotatoPatientCommunication),
    contact: List(PotatoPatientContact),
    contained: List(Resource),
    deceased: Option(PotatoPatientDeceased),
    birthsex: Option(valueset.Two16840111376214102124),
    ethnicity: Option(ct.Potatoethnicity),
    gender_identity: List(ct.Potatocodeableconcept),
    race: Option(ct.Potatorace),
    sex: Option(String),
    tribal_affiliation: List(ct.Potatotribalaffiliation),
    gender: valueset.AdministrativeGender,
    general_practitioner: List(ct.Potatoreference),
    id: Option(String),
    identifier: List1(ct.IdentifierPotatoPatientIdentifier),
    implicit_rules: Option(String),
    language: Option(String),
    link: List(PotatoPatientLink),
    managing_organization: Option(ct.Potatoreference),
    marital_status: Option(ct.Potatocodeableconcept),
    meta: Option(ct.Potatometa),
    multiple_birth: Option(PotatoPatientMultiplebirth),
    name: List1(ct.HumannamePotatoPatientName),
    photo: List(ct.Potatoattachment),
    telecom: List(ct.ContactpointPotatoPatientTelecom),
    text: Option(ct.Potatonarrative),
  )
}

pub fn potato_patient_new(
  gender gender: valueset.AdministrativeGender,
  identifier identifier: List1(ct.IdentifierPotatoPatientIdentifier),
  name name: List1(ct.HumannamePotatoPatientName),
) -> PotatoPatient {
  PotatoPatient(
    active: None,
    address: [],
    birth_date: None,
    communication: [],
    contact: [],
    contained: [],
    deceased: None,
    birthsex: None,
    ethnicity: None,
    gender_identity: [],
    race: None,
    sex: None,
    tribal_affiliation: [],
    gender:,
    general_practitioner: [],
    id: None,
    identifier:,
    implicit_rules: None,
    language: None,
    link: [],
    managing_organization: None,
    marital_status: None,
    meta: Some({
      let meta = ct.potatometa_new()
      ct.Potatometa(..meta, profile: [
        "https://potatoemr.com/fhir/StructureDefinition/PotatoPatient",
      ])
    }),
    multiple_birth: None,
    name:,
    photo: [],
    telecom: [],
    text: None,
  )
}

pub type PotatoPatientMultiplebirth {
  PotatoPatientMultiplebirthBoolean(value: Bool)
  PotatoPatientMultiplebirthInteger(value: Int)
}

pub type PotatoPatientDeceased {
  PotatoPatientDeceasedBoolean(value: Bool)
  PotatoPatientDeceasedDatetime(value: DateTime)
}

pub type PotatoPatientCommunication {
  PotatoPatientCommunication(
    id: Option(String),
    language: ct.Potatocodeableconcept,
    preferred: Option(Bool),
  )
}

pub fn potato_patient_communication_new(
  language language: ct.Potatocodeableconcept,
) -> PotatoPatientCommunication {
  PotatoPatientCommunication(id: None, language:, preferred: None)
}

pub type PotatoPatientContact {
  PotatoPatientContact(
    address: Option(ct.Potatoaddress),
    gender: Option(valueset.AdministrativeGender),
    id: Option(String),
    name: Option(ct.Potatohumanname),
    organization: Option(ct.Potatoreference),
    period: Option(ct.Potatoperiod),
    relationship: List(ct.Potatocodeableconcept),
    telecom: List(ct.Potatocontactpoint),
  )
}

pub fn potato_patient_contact_new() -> PotatoPatientContact {
  PotatoPatientContact(
    address: None,
    gender: None,
    id: None,
    name: None,
    organization: None,
    period: None,
    relationship: [],
    telecom: [],
  )
}

pub type PotatoPatientLink {
  PotatoPatientLink(
    id: Option(String),
    other: ct.Potatoreference,
    type_: valueset.LinkType,
  )
}

pub fn potato_patient_link_new(
  other other: ct.Potatoreference,
  type_ type_: valueset.LinkType,
) -> PotatoPatientLink {
  PotatoPatientLink(id: None, other:, type_:)
}

pub fn potato_patient_to_json(potato_patient: PotatoPatient) -> Json {
  let fields = [
    #(
      "name",
      list1_to_json(
        potato_patient.name,
        ct.humanname_potato_patient_name_to_json,
      ),
    ),
    #(
      "identifier",
      list1_to_json(
        potato_patient.identifier,
        ct.identifier_potato_patient_identifier_to_json,
      ),
    ),
    #("gender", valueset.administrative_gender_to_json(potato_patient.gender)),
  ]
  let fields = case potato_patient.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient.telecom {
    [] -> fields
    values -> [
      #(
        "telecom",
        json.array(values, ct.contactpoint_potato_patient_telecom_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_patient.photo {
    [] -> fields
    values -> [
      #("photo", json.array(values, ct.potatoattachment_to_json)),
      ..fields
    ]
  }
  let fields = case potato_patient.multiple_birth {
    Some(v) -> [potato_patient_multiplebirth_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case potato_patient.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient.marital_status {
    Some(v) -> [
      #("maritalStatus", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_patient.managing_organization {
    Some(v) -> [
      #("managingOrganization", ct.potatoreference_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_patient.link {
    [] -> fields
    values -> [
      #("link", json.array(values, potato_patient_link_to_json)),
      ..fields
    ]
  }
  let fields = case potato_patient.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient.general_practitioner {
    [] -> fields
    values -> [
      #("generalPractitioner", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let slice_values =
    list.flatten([
      list.map(potato_patient.tribal_affiliation, fn(value) {
        ct.potatotribalaffiliation_to_json(
          value,
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation",
        )
      }),
      case potato_patient.sex {
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
      case potato_patient.race {
        Some(value) -> [
          ct.potatorace_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race",
          ),
        ]
        None -> []
      },
      list.map(potato_patient.gender_identity, fn(value) {
        json.object([
          #(
            "url",
            json.string(
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-genderIdentity",
            ),
          ),
          #("valueCodeableConcept", ct.potatocodeableconcept_to_json(value)),
        ])
      }),
      case potato_patient.ethnicity {
        Some(value) -> [
          ct.potatoethnicity_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity",
          ),
        ]
        None -> []
      },
      case potato_patient.birthsex {
        Some(value) -> [
          json.object([
            #(
              "url",
              json.string(
                "http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex",
              ),
            ),
            #("valueCode", valueset.two16840111376214102124_to_json(value)),
          ]),
        ]
        None -> []
      },
      [],
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("extension", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potato_patient.deceased {
    Some(v) -> [potato_patient_deceased_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case potato_patient.contained {
    [] -> fields
    values -> [#("contained", json.array(values, to_json)), ..fields]
  }
  let fields = case potato_patient.contact {
    [] -> fields
    values -> [
      #("contact", json.array(values, potato_patient_contact_to_json)),
      ..fields
    ]
  }
  let fields = case potato_patient.communication {
    [] -> fields
    values -> [
      #(
        "communication",
        json.array(values, potato_patient_communication_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_patient.birth_date {
    Some(v) -> [#("birthDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient.address {
    [] -> fields
    values -> [
      #(
        "address",
        json.array(values, ct.address_potato_patient_address_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potato_patient.active {
    Some(v) -> [#("active", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Patient")), ..fields]
  json.object(fields)
}

pub fn potato_patient_deceased_to_json_field(
  value: PotatoPatientDeceased,
) -> #(String, Json) {
  case value {
    PotatoPatientDeceasedBoolean(value) -> #(
      "deceasedBoolean",
      json.bool(value),
    )
    PotatoPatientDeceasedDatetime(value) -> #(
      "deceasedDateTime",
      pt.datetime_to_json(value),
    )
  }
}

pub fn potato_patient_multiplebirth_to_json_field(
  value: PotatoPatientMultiplebirth,
) -> #(String, Json) {
  case value {
    PotatoPatientMultiplebirthBoolean(value) -> #(
      "multipleBirthBoolean",
      json.bool(value),
    )
    PotatoPatientMultiplebirthInteger(value) -> #(
      "multipleBirthInteger",
      json.int(value),
    )
  }
}

pub fn potato_patient_communication_to_json(
  potato_patient_communication: PotatoPatientCommunication,
) -> Json {
  let fields = [
    #(
      "language",
      ct.potatocodeableconcept_to_json(potato_patient_communication.language),
    ),
  ]
  let fields = case potato_patient_communication.preferred {
    Some(v) -> [#("preferred", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient_communication.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_patient_contact_to_json(
  potato_patient_contact: PotatoPatientContact,
) -> Json {
  let fields = []
  let fields = case potato_patient_contact.telecom {
    [] -> fields
    values -> [
      #("telecom", json.array(values, ct.potatocontactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case potato_patient_contact.relationship {
    [] -> fields
    values -> [
      #("relationship", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potato_patient_contact.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient_contact.organization {
    Some(v) -> [#("organization", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient_contact.name {
    Some(v) -> [#("name", ct.potatohumanname_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient_contact.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potato_patient_contact.gender {
    Some(v) -> [
      #("gender", valueset.administrative_gender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potato_patient_contact.address {
    Some(v) -> [#("address", ct.potatoaddress_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_patient_link_to_json(
  potato_patient_link: PotatoPatientLink,
) -> Json {
  let fields = [
    #("type", valueset.link_type_to_json(potato_patient_link.type_)),
    #("other", ct.potatoreference_to_json(potato_patient_link.other)),
  ]
  let fields = case potato_patient_link.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potato_allergyintolerance_reaction_decoder() -> Decoder(
  PotatoAllergyintoleranceReaction,
) {
  use <- decode.recursive
  use substance <- decode.optional_field(
    "substance",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use severity <- decode.optional_field(
    "severity",
    None,
    decode.optional(valueset.reaction_event_severity_decoder()),
  )
  use onset <- decode.optional_field(
    "onset",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use manifestation <- list1_decoder(
    "manifestation",
    ct.potatocodeableconcept_decoder(),
  )
  use id <- decode_optional_string("id")
  use exposure_route <- decode.optional_field(
    "exposureRoute",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use description <- decode_optional_string("description")
  let placeholder =
    PotatoAllergyintoleranceReaction(
      substance:,
      severity:,
      onset:,
      note:,
      manifestation:,
      id:,
      exposure_route:,
      description:,
    )
  decode.success(placeholder)
}

pub fn potato_allergyintolerance_onset_decoder() -> Decoder(
  PotatoAllergyintoleranceOnset,
) {
  decode.one_of(
    {
      use value <- decode.field("onsetDateTime", pt.datetime_decoder())
      decode.success(PotatoAllergyintoleranceOnsetDatetime(value))
    },
    [
      {
        use value <- decode.field("onsetAge", ct.potatoage_decoder())
        decode.success(PotatoAllergyintoleranceOnsetAge(value))
      },
      {
        use value <- decode.field("onsetPeriod", ct.potatoperiod_decoder())
        decode.success(PotatoAllergyintoleranceOnsetPeriod(value))
      },
      {
        use value <- decode.field("onsetRange", ct.potatorange_decoder())
        decode.success(PotatoAllergyintoleranceOnsetRange(value))
      },
      {
        use value <- decode.field("onsetString", decode.string)
        decode.success(PotatoAllergyintoleranceOnsetString(value))
      },
    ],
  )
}

pub fn potato_allergyintolerance_decoder() -> Decoder(PotatoAllergyintolerance) {
  use <- decode.recursive
  use verification_status <- decode.optional_field(
    "verificationStatus",
    None,
    decode.optional(
      ct.codeableconcept_potato_allergyintolerance_verificationstatus_decoder(),
    ),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(valueset.allergyintolerance_type_decoder()),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use recorder <- decode.optional_field(
    "recorder",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use recorded_date <- decode.optional_field(
    "recordedDate",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use reaction <- decode.optional_field(
    "reaction",
    [],
    decode.list(potato_allergyintolerance_reaction_decoder()),
  )
  use patient <- decode.field("patient", ct.potatoreference_decoder())
  use onset <- decode.then(
    none_if_omitted(potato_allergyintolerance_onset_decoder()),
  )
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use last_occurrence <- decode.optional_field(
    "lastOccurrence",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use encounter <- decode.optional_field(
    "encounter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use criticality <- decode.optional_field(
    "criticality",
    None,
    decode.optional(valueset.allergyintolerance_criticality_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use code <- decode.field("code", ct.potatocodeableconcept_decoder())
  use clinical_status <- decode.optional_field(
    "clinicalStatus",
    None,
    decode.optional(
      ct.codeableconcept_potato_allergyintolerance_clinicalstatus_decoder(),
    ),
  )
  use category <- decode.optional_field(
    "category",
    [],
    decode.list(valueset.allergyintolerance_category_decoder()),
  )
  use asserter <- decode.optional_field(
    "asserter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  let placeholder =
    PotatoAllergyintolerance(
      verification_status:,
      type_:,
      text:,
      recorder:,
      recorded_date:,
      reaction:,
      patient:,
      onset:,
      note:,
      meta:,
      last_occurrence:,
      language:,
      implicit_rules:,
      identifier:,
      id:,
      encounter:,
      criticality:,
      contained:,
      code:,
      clinical_status:,
      category:,
      asserter:,
    )
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
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
    }),
  )
  decode.success(placeholder)
}

pub fn potato_appointment_participant_decoder() -> Decoder(
  PotatoAppointmentParticipant,
) {
  use <- decode.recursive
  use type_ <- decode.optional_field(
    "type",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use status <- decode.field("status", valueset.participationstatus_decoder())
  use required <- decode.optional_field(
    "required",
    None,
    decode.optional(valueset.participantrequired_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use id <- decode_optional_string("id")
  use actor <- decode.optional_field(
    "actor",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  let placeholder =
    PotatoAppointmentParticipant(
      type_:,
      status:,
      required:,
      period:,
      id:,
      actor:,
    )
  decode.success(placeholder)
}

pub fn potato_appointment_decoder() -> Decoder(PotatoAppointment) {
  use <- decode.recursive
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use supporting_information <- decode.optional_field(
    "supportingInformation",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use status <- decode.field("status", valueset.appointmentstatus_decoder())
  use start <- decode.optional_field(
    "start",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use specialty <- decode.optional_field(
    "specialty",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use slot <- decode.optional_field(
    "slot",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use service_type <- decode.optional_field(
    "serviceType",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use service_category <- decode.optional_field(
    "serviceCategory",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use requested_period <- decode.optional_field(
    "requestedPeriod",
    [],
    decode.list(ct.potatoperiod_decoder()),
  )
  use reason_reference <- decode.optional_field(
    "reasonReference",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use reason_code <- decode.optional_field(
    "reasonCode",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use priority <- decode.optional_field(
    "priority",
    None,
    decode.optional(decode.int),
  )
  use patient_instruction <- decode_optional_string("patientInstruction")
  use participant <- list1_decoder(
    "participant",
    potato_appointment_participant_decoder(),
  )
  use minutes_duration <- decode.optional_field(
    "minutesDuration",
    None,
    decode.optional(decode.int),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use end <- decode.optional_field(
    "end",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use description <- decode_optional_string("description")
  use created <- decode.optional_field(
    "created",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use comment <- decode_optional_string("comment")
  use cancelation_reason <- decode.optional_field(
    "cancelationReason",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use based_on <- decode.optional_field(
    "basedOn",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use appointment_type <- decode.optional_field(
    "appointmentType",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  let placeholder =
    PotatoAppointment(
      text:,
      supporting_information:,
      status:,
      start:,
      specialty:,
      slot:,
      service_type:,
      service_category:,
      requested_period:,
      reason_reference:,
      reason_code:,
      priority:,
      patient_instruction:,
      participant:,
      minutes_duration:,
      meta:,
      language:,
      implicit_rules:,
      identifier:,
      id:,
      end:,
      description:,
      created:,
      contained:,
      comment:,
      cancelation_reason:,
      based_on:,
      appointment_type:,
    )
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "Appointment" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "Appointment")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  decode.success(placeholder)
}

type PotatoConditionExtensionSliceAccumulator {
  PotatoConditionExtensionSliceAccumulator(asserted_date: Option(DateTime))
}

pub type PotatoConditionParsedExtensionSlice {
  PotatoConditionParsedExtensionSliceAsserteddate(DateTime)
  PotatoConditionParsedExtensionSliceIgnored
}

type PotatoConditionExtensionSlices {
  PotatoConditionExtensionSlices(asserted_date: Option(DateTime))
}

type PotatoConditionCategorySliceAccumulator {
  PotatoConditionCategorySliceAccumulator(
    us_core: List(ct.CodeableconceptPotatoConditionCategoryUsCore),
    screening_assessment: List(
      ct.CodeableconceptPotatoConditionCategoryScreeningAssessment,
    ),
    open: List(ct.Potatocodeableconcept),
  )
}

type PotatoConditionParsedCategorySlice {
  PotatoConditionParsedCategorySliceUsCore(
    ct.CodeableconceptPotatoConditionCategoryUsCore,
  )
  PotatoConditionParsedCategorySliceScreeningAssessment(
    ct.CodeableconceptPotatoConditionCategoryScreeningAssessment,
  )
  PotatoConditionParsedCategorySliceOpen(ct.Potatocodeableconcept)
}

type PotatoConditionCategorySlices {
  PotatoConditionCategorySlices(
    us_core: List1(ct.CodeableconceptPotatoConditionCategoryUsCore),
    screening_assessment: List(
      ct.CodeableconceptPotatoConditionCategoryScreeningAssessment,
    ),
    open: List(ct.Potatocodeableconcept),
  )
}

pub fn potato_condition_stage_decoder() -> Decoder(PotatoConditionStage) {
  use <- decode.recursive
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use summary <- decode.optional_field(
    "summary",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use id <- decode_optional_string("id")
  use assessment <- decode.optional_field(
    "assessment",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  let placeholder = PotatoConditionStage(type_:, summary:, id:, assessment:)
  decode.success(placeholder)
}

pub fn potato_condition_evidence_decoder() -> Decoder(PotatoConditionEvidence) {
  use <- decode.recursive
  use id <- decode_optional_string("id")
  use detail <- decode.optional_field(
    "detail",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use code <- decode.optional_field(
    "code",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  let placeholder = PotatoConditionEvidence(id:, detail:, code:)
  decode.success(placeholder)
}

pub fn potato_condition_onset_decoder() -> Decoder(PotatoConditionOnset) {
  decode.one_of(
    {
      use value <- decode.field("onsetDateTime", pt.datetime_decoder())
      decode.success(PotatoConditionOnsetDatetime(value))
    },
    [
      {
        use value <- decode.field("onsetAge", ct.potatoage_decoder())
        decode.success(PotatoConditionOnsetAge(value))
      },
      {
        use value <- decode.field("onsetPeriod", ct.potatoperiod_decoder())
        decode.success(PotatoConditionOnsetPeriod(value))
      },
      {
        use value <- decode.field("onsetRange", ct.potatorange_decoder())
        decode.success(PotatoConditionOnsetRange(value))
      },
      {
        use value <- decode.field("onsetString", decode.string)
        decode.success(PotatoConditionOnsetString(value))
      },
    ],
  )
}

pub fn potato_condition_extension_slice_decoder() -> Decoder(
  Result(PotatoConditionParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use _id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "http://hl7.org/fhir/StructureDefinition/condition-assertedDate" ->
        decode.field("valueDateTime", pt.datetime_decoder(), decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoConditionParsedExtensionSliceAsserteddate(value)
          })
        })
      _ -> decode.success(Ok(PotatoConditionParsedExtensionSliceIgnored))
    },
    decode.success,
  )
}

pub fn potato_condition_abatement_decoder() -> Decoder(PotatoConditionAbatement) {
  decode.one_of(
    {
      use value <- decode.field("abatementDateTime", pt.datetime_decoder())
      decode.success(PotatoConditionAbatementDatetime(value))
    },
    [
      {
        use value <- decode.field("abatementAge", ct.potatoage_decoder())
        decode.success(PotatoConditionAbatementAge(value))
      },
      {
        use value <- decode.field("abatementPeriod", ct.potatoperiod_decoder())
        decode.success(PotatoConditionAbatementPeriod(value))
      },
      {
        use value <- decode.field("abatementRange", ct.potatorange_decoder())
        decode.success(PotatoConditionAbatementRange(value))
      },
      {
        use value <- decode.field("abatementString", decode.string)
        decode.success(PotatoConditionAbatementString(value))
      },
    ],
  )
}

pub fn potato_condition_decoder() -> Decoder(PotatoCondition) {
  use <- decode.recursive
  use verification_status <- decode.optional_field(
    "verificationStatus",
    None,
    decode.optional(
      ct.codeableconcept_potato_condition_verificationstatus_decoder(),
    ),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use subject <- decode.field("subject", ct.potatoreference_decoder())
  use stage <- decode.optional_field(
    "stage",
    [],
    decode.list(potato_condition_stage_decoder()),
  )
  use severity <- decode.optional_field(
    "severity",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use recorder <- decode.optional_field(
    "recorder",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use recorded_date <- decode.optional_field(
    "recordedDate",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use onset <- decode.then(none_if_omitted(potato_condition_onset_decoder()))
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_potato_condition_meta_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use extension_base_values <- decode.optional_field(
    "extension",
    [],
    decode.list(potato_condition_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(PotatoConditionExtensionSliceAccumulator(None)),
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
                  PotatoConditionParsedExtensionSliceAsserteddate(value) ->
                    Ok(
                      PotatoConditionExtensionSliceAccumulator(
                        asserted_date: Some(value),
                      ),
                    )
                  PotatoConditionParsedExtensionSliceIgnored -> Ok(accumulator)
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(PotatoConditionExtensionSlices(
        asserted_date: accumulator.asserted_date,
      ))
    Error(errors) -> Error(errors)
  }
  use evidence <- decode.optional_field(
    "evidence",
    [],
    decode.list(potato_condition_evidence_decoder()),
  )
  use encounter <- decode.optional_field(
    "encounter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use code <- decode.field("code", ct.potatocodeableconcept_decoder())
  use clinical_status <- decode.optional_field(
    "clinicalStatus",
    None,
    decode.optional(
      ct.codeableconcept_potato_condition_clinicalstatus_decoder(),
    ),
  )
  use category_base_values <- decode.optional_field(
    "category",
    [],
    decode.list({
      use category_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            category_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      ct.codeableconcept_potato_condition_category_us_core_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(ct.DiscriminatorDifferent),
              )
              decode.success(ct.DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> ct.DiscriminatorDifferent
        }
      {
        ct.DiscriminatorMatches ->
          ct.codeableconcept_potato_condition_category_us_core_decoder()
          |> decode.map(PotatoConditionParsedCategorySliceUsCore)
        ct.DiscriminatorDifferent ->
          case
            case
              decode.run(
                category_raw,
                decode.then(decode.dynamic, fn(value) {
                  use <- bool.guard(
                    !{
                      case
                        decode.run(
                          value,
                          ct.codeableconcept_potato_condition_category_screening_assessment_decoder(),
                        )
                      {
                        Ok(_) -> True
                        Error(_) -> False
                      }
                    },
                    decode.success(ct.DiscriminatorDifferent),
                  )
                  decode.success(ct.DiscriminatorMatches)
                }),
              )
            {
              Ok(matched) -> matched
              Error(_) -> ct.DiscriminatorDifferent
            }
          {
            ct.DiscriminatorMatches ->
              ct.codeableconcept_potato_condition_category_screening_assessment_decoder()
              |> decode.map(
                PotatoConditionParsedCategorySliceScreeningAssessment,
              )
            ct.DiscriminatorDifferent ->
              ct.potatocodeableconcept_decoder()
              |> decode.map(PotatoConditionParsedCategorySliceOpen)
          }
      }
    }),
  )
  let category_accumulator =
    list.index_fold(
      category_base_values,
      PotatoConditionCategorySliceAccumulator([], [], []),
      fn(accumulator, parsed, _index) {
        case parsed {
          PotatoConditionParsedCategorySliceUsCore(value) ->
            PotatoConditionCategorySliceAccumulator(..accumulator, us_core: [
              value,
              ..accumulator.us_core
            ])
          PotatoConditionParsedCategorySliceScreeningAssessment(value) ->
            PotatoConditionCategorySliceAccumulator(
              ..accumulator,
              screening_assessment: [value, ..accumulator.screening_assessment],
            )
          PotatoConditionParsedCategorySliceOpen(value) ->
            PotatoConditionCategorySliceAccumulator(..accumulator, open: [
              value,
              ..accumulator.open
            ])
        }
      },
    )
  let category_slices = {
    let accumulator = category_accumulator
    let us_core = case list.reverse(accumulator.us_core) {
      [first, ..rest] -> Ok(ct.List1(first:, rest:))
      [] ->
        Error([
          decode.DecodeError(
            expected: "1 us-core category",
            found: "0 us-core categorys",
            path: ["category", "us-core"],
          ),
        ])
    }
    let screening_assessment =
      Ok(list.reverse(accumulator.screening_assessment))
    let open = Ok(list.reverse(accumulator.open))
    case us_core, screening_assessment, open {
      Ok(us_core), Ok(screening_assessment), Ok(open) ->
        Ok(PotatoConditionCategorySlices(us_core:, screening_assessment:, open:))
      _, _, _ ->
        Error(
          list.flatten([
            result.unwrap_error(us_core, []),
            result.unwrap_error(screening_assessment, []),
            result.unwrap_error(open, []),
          ]),
        )
    }
  }
  use body_site <- decode.optional_field(
    "bodySite",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use asserter <- decode.optional_field(
    "asserter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use abatement <- decode.then(
    none_if_omitted(potato_condition_abatement_decoder()),
  )
  let category_slices_decoder = case category_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatoConditionCategorySlices(
          us_core: ct.List1(
            first: ct.codeableconcept_potato_condition_category_us_core_new(
              required: ct.List1(
                first: ct.codeableconcept_potato_condition_category_us_core_coding_required_new(),
                rest: [],
              ),
            ),
            rest: [],
          ),
          screening_assessment: [],
          open: [],
        ),
        "PotatoCondition slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  let extension_slices_decoder = case extension_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatoConditionExtensionSlices(None),
        "PotatoCondition slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "Condition" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "Condition")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  use category_slices <- decode.then(category_slices_decoder)
  use extension_slices <- decode.then(extension_slices_decoder)
  decode.success(PotatoCondition(
    verification_status:,
    text:,
    subject:,
    stage:,
    severity:,
    recorder:,
    recorded_date:,
    onset:,
    note:,
    meta:,
    language:,
    implicit_rules:,
    identifier:,
    id:,
    asserted_date: extension_slices.asserted_date,
    evidence:,
    encounter:,
    contained:,
    code:,
    clinical_status:,
    us_core: category_slices.us_core,
    screening_assessment: category_slices.screening_assessment,
    category: category_slices.open,
    body_site:,
    asserter:,
    abatement:,
  ))
}

type PotatoDocumentreferenceCategorySliceAccumulator {
  PotatoDocumentreferenceCategorySliceAccumulator(
    values: List(PotatoDocumentreferenceCategory),
  )
}

pub fn potato_documentreference_relatesto_decoder() -> Decoder(
  PotatoDocumentreferenceRelatesto,
) {
  use <- decode.recursive
  use target <- decode.field("target", ct.potatoreference_decoder())
  use id <- decode_optional_string("id")
  use code <- decode.field(
    "code",
    valueset.document_relationship_type_decoder(),
  )
  let placeholder = PotatoDocumentreferenceRelatesto(target:, id:, code:)
  decode.success(placeholder)
}

pub fn potato_documentreference_context_decoder() -> Decoder(
  PotatoDocumentreferenceContext,
) {
  use <- decode.recursive
  use source_patient_info <- decode.optional_field(
    "sourcePatientInfo",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use related <- decode.optional_field(
    "related",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use practice_setting <- decode.optional_field(
    "practiceSetting",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use id <- decode_optional_string("id")
  use facility_type <- decode.optional_field(
    "facilityType",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use event <- decode.optional_field(
    "event",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use encounter <- ct.optional_one_from_array_decoder(
    "encounter",
    ct.potatoreference_decoder(),
  )
  let placeholder =
    PotatoDocumentreferenceContext(
      source_patient_info:,
      related:,
      practice_setting:,
      period:,
      id:,
      facility_type:,
      event:,
      encounter:,
    )
  decode.success(placeholder)
}

pub fn potato_documentreference_content_decoder() -> Decoder(
  PotatoDocumentreferenceContent,
) {
  use <- decode.recursive
  use id <- decode_optional_string("id")
  use format <- decode.optional_field(
    "format",
    None,
    decode.optional(ct.potatocoding_decoder()),
  )
  use attachment <- decode.field(
    "attachment",
    ct.attachment_omit_extension_decoder(),
  )
  let placeholder = PotatoDocumentreferenceContent(id:, format:, attachment:)
  decode.success(placeholder)
}

pub fn potato_documentreference_decoder() -> Decoder(PotatoDocumentreference) {
  use <- decode.recursive
  use type_ <- decode.field("type", ct.potatocodeableconcept_decoder())
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use subject <- decode.field("subject", ct.potatoreference_decoder())
  use status <- decode.field(
    "status",
    valueset.documentreference_status_decoder(),
  )
  use security_label <- decode.optional_field(
    "securityLabel",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use relates_to <- decode.optional_field(
    "relatesTo",
    [],
    decode.list(potato_documentreference_relatesto_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use master_identifier <- decode.optional_field(
    "masterIdentifier",
    None,
    decode.optional(ct.potatoidentifier_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use doc_status <- decode.optional_field(
    "docStatus",
    None,
    decode.optional(valueset.composition_status_decoder()),
  )
  use description <- decode_optional_string("description")
  use date <- decode.optional_field(
    "date",
    None,
    decode.optional(pt.instant_decoder()),
  )
  use custodian <- decode.optional_field(
    "custodian",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use context <- decode.optional_field(
    "context",
    None,
    decode.optional(potato_documentreference_context_decoder()),
  )
  use content <- list1_decoder(
    "content",
    potato_documentreference_content_decoder(),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use category_base_values <- decode.optional_field(
    "category",
    [],
    decode.list({
      use category_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            category_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      ct.codeableconcept_potato_documentreference_category_uscore_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(ct.DiscriminatorDifferent),
              )
              decode.success(ct.DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> ct.DiscriminatorDifferent
        }
      {
        ct.DiscriminatorMatches ->
          ct.codeableconcept_potato_documentreference_category_uscore_decoder()
          |> decode.map(PotatoDocumentreferenceCategoryUscore)
        ct.DiscriminatorDifferent ->
          ct.potatocodeableconcept_decoder()
          |> decode.map(PotatoDocumentreferenceCategoryOpen)
      }
    }),
  )
  let category_accumulator =
    list.index_fold(
      category_base_values,
      PotatoDocumentreferenceCategorySliceAccumulator([]),
      fn(accumulator, parsed, _index) {
        case parsed {
          value ->
            PotatoDocumentreferenceCategorySliceAccumulator([
              value,
              ..accumulator.values
            ])
        }
      },
    )
  let category_slices = case category_accumulator {
    PotatoDocumentreferenceCategorySliceAccumulator(values:) ->
      case list.reverse(values) {
        [first, ..rest] -> Ok(ct.List1(first:, rest:))
        [] ->
          Error([
            decode.DecodeError(
              expected: "at least 1 category",
              found: int.to_string(list.length(list.reverse(values)))
                <> " categorys",
              path: ["category"],
            ),
          ])
      }
  }
  use author <- decode.optional_field(
    "author",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use authenticator <- decode.optional_field(
    "authenticator",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  let category_slices_decoder = case category_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        ct.List1(
          first: PotatoDocumentreferenceCategoryOpen(
            ct.potatocodeableconcept_new(),
          ),
          rest: [],
        ),
        "PotatoDocumentreference slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "DocumentReference" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "DocumentReference")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  use category_slices <- decode.then(category_slices_decoder)
  decode.success(PotatoDocumentreference(
    type_:,
    text:,
    subject:,
    status:,
    security_label:,
    relates_to:,
    meta:,
    master_identifier:,
    language:,
    implicit_rules:,
    identifier:,
    id:,
    doc_status:,
    description:,
    date:,
    custodian:,
    context:,
    content:,
    contained:,
    category: category_slices,
    author:,
    authenticator:,
  ))
}

pub fn potato_encounter_statushistory_decoder() -> Decoder(
  PotatoEncounterStatushistory,
) {
  use <- decode.recursive
  use status <- decode.field("status", valueset.encounter_status_decoder())
  use period <- decode.field("period", ct.potatoperiod_decoder())
  use id <- decode_optional_string("id")
  let placeholder = PotatoEncounterStatushistory(status:, period:, id:)
  decode.success(placeholder)
}

pub fn potato_encounter_participant_decoder() -> Decoder(
  PotatoEncounterParticipant,
) {
  use <- decode.recursive
  use type_ <- decode.optional_field(
    "type",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use individual <- decode.optional_field(
    "individual",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use id <- decode_optional_string("id")
  let placeholder =
    PotatoEncounterParticipant(type_:, period:, individual:, id:)
  decode.success(placeholder)
}

pub fn potato_encounter_location_decoder() -> Decoder(PotatoEncounterLocation) {
  use <- decode.recursive
  use status <- decode.optional_field(
    "status",
    None,
    decode.optional(valueset.encounter_location_status_decoder()),
  )
  use physical_type <- decode.optional_field(
    "physicalType",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use location <- decode.field("location", ct.potatoreference_decoder())
  use id <- decode_optional_string("id")
  let placeholder =
    PotatoEncounterLocation(status:, physical_type:, period:, location:, id:)
  decode.success(placeholder)
}

pub fn potato_encounter_hospitalization_decoder() -> Decoder(
  PotatoEncounterHospitalization,
) {
  use <- decode.recursive
  use special_courtesy <- decode.optional_field(
    "specialCourtesy",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use special_arrangement <- decode.optional_field(
    "specialArrangement",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use re_admission <- decode.optional_field(
    "reAdmission",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use pre_admission_identifier <- decode.optional_field(
    "preAdmissionIdentifier",
    None,
    decode.optional(ct.potatoidentifier_decoder()),
  )
  use origin <- decode.optional_field(
    "origin",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use id <- decode_optional_string("id")
  use discharge_disposition <- decode.optional_field(
    "dischargeDisposition",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use diet_preference <- decode.optional_field(
    "dietPreference",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use destination <- decode.optional_field(
    "destination",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use admit_source <- decode.optional_field(
    "admitSource",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  let placeholder =
    PotatoEncounterHospitalization(
      special_courtesy:,
      special_arrangement:,
      re_admission:,
      pre_admission_identifier:,
      origin:,
      id:,
      discharge_disposition:,
      diet_preference:,
      destination:,
      admit_source:,
    )
  decode.success(placeholder)
}

pub fn potato_encounter_diagnosis_decoder() -> Decoder(PotatoEncounterDiagnosis) {
  use <- decode.recursive
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use rank <- decode.optional_field("rank", None, decode.optional(decode.int))
  use id <- decode_optional_string("id")
  use condition <- decode.field("condition", ct.potatoreference_decoder())
  let placeholder = PotatoEncounterDiagnosis(use_:, rank:, id:, condition:)
  decode.success(placeholder)
}

pub fn potato_encounter_classhistory_decoder() -> Decoder(
  PotatoEncounterClasshistory,
) {
  use <- decode.recursive
  use period <- decode.field("period", ct.potatoperiod_decoder())
  use id <- decode_optional_string("id")
  use class <- decode.field("class", ct.potatocoding_decoder())
  let placeholder = PotatoEncounterClasshistory(period:, id:, class:)
  decode.success(placeholder)
}

pub fn potato_encounter_decoder() -> Decoder(PotatoEncounter) {
  use <- decode.recursive
  use type_ <- list1_decoder("type", ct.potatocodeableconcept_decoder())
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use subject <- decode.field("subject", ct.potatoreference_decoder())
  use status_history <- decode.optional_field(
    "statusHistory",
    [],
    decode.list(potato_encounter_statushistory_decoder()),
  )
  use status <- decode.field("status", valueset.encounter_status_decoder())
  use service_type <- decode.optional_field(
    "serviceType",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use service_provider <- decode.optional_field(
    "serviceProvider",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use reason_reference <- decode.optional_field(
    "reasonReference",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use reason_code <- decode.optional_field(
    "reasonCode",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use priority <- decode.optional_field(
    "priority",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use participant <- decode.optional_field(
    "participant",
    [],
    decode.list(potato_encounter_participant_decoder()),
  )
  use part_of <- decode.optional_field(
    "partOf",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_potato_encounter_meta_decoder()),
  )
  use location <- decode.optional_field(
    "location",
    [],
    decode.list(potato_encounter_location_decoder()),
  )
  use length <- decode.optional_field(
    "length",
    None,
    decode.optional(ct.potatoduration_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.identifier_potato_encounter_identifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use hospitalization <- decode.optional_field(
    "hospitalization",
    None,
    decode.optional(potato_encounter_hospitalization_decoder()),
  )
  use episode_of_care <- decode.optional_field(
    "episodeOfCare",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use diagnosis <- decode.optional_field(
    "diagnosis",
    [],
    decode.list(potato_encounter_diagnosis_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use class_history <- decode.optional_field(
    "classHistory",
    [],
    decode.list(potato_encounter_classhistory_decoder()),
  )
  use class <- decode.field("class", ct.potatocoding_decoder())
  use based_on <- decode.optional_field(
    "basedOn",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use appointment <- decode.optional_field(
    "appointment",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use account <- decode.optional_field(
    "account",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  let placeholder =
    PotatoEncounter(
      type_:,
      text:,
      subject:,
      status_history:,
      status:,
      service_type:,
      service_provider:,
      reason_reference:,
      reason_code:,
      priority:,
      period:,
      participant:,
      part_of:,
      meta:,
      location:,
      length:,
      language:,
      implicit_rules:,
      identifier:,
      id:,
      hospitalization:,
      episode_of_care:,
      diagnosis:,
      contained:,
      class_history:,
      class:,
      based_on:,
      appointment:,
      account:,
    )
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "Encounter" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "Encounter")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  decode.success(placeholder)
}

pub fn potato_immunization_reaction_decoder() -> Decoder(
  PotatoImmunizationReaction,
) {
  use <- decode.recursive
  use reported <- decode_optional_bool("reported")
  use id <- decode_optional_string("id")
  use detail <- decode.optional_field(
    "detail",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use date <- decode.optional_field(
    "date",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  let placeholder = PotatoImmunizationReaction(reported:, id:, detail:, date:)
  decode.success(placeholder)
}

pub fn potato_immunization_protocolapplied_seriesdoses_decoder() -> Decoder(
  PotatoImmunizationProtocolappliedSeriesdoses,
) {
  decode.one_of(
    {
      use value <- decode.field("seriesDosesPositiveInt", decode.int)
      decode.success(PotatoImmunizationProtocolappliedSeriesdosesPositiveint(
        value,
      ))
    },
    [
      {
        use value <- decode.field("seriesDosesString", decode.string)
        decode.success(PotatoImmunizationProtocolappliedSeriesdosesString(value))
      },
    ],
  )
}

pub fn potato_immunization_protocolapplied_dosenumber_decoder() -> Decoder(
  PotatoImmunizationProtocolappliedDosenumber,
) {
  decode.one_of(
    {
      use value <- decode.field("doseNumberPositiveInt", decode.int)
      decode.success(PotatoImmunizationProtocolappliedDosenumberPositiveint(
        value,
      ))
    },
    [
      {
        use value <- decode.field("doseNumberString", decode.string)
        decode.success(PotatoImmunizationProtocolappliedDosenumberString(value))
      },
    ],
  )
}

pub fn potato_immunization_protocolapplied_decoder() -> Decoder(
  PotatoImmunizationProtocolapplied,
) {
  use <- decode.recursive
  use target_disease <- decode.optional_field(
    "targetDisease",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use series_doses <- decode.then(
    none_if_omitted(potato_immunization_protocolapplied_seriesdoses_decoder()),
  )
  use series <- decode_optional_string("series")
  use id <- decode_optional_string("id")
  use dose_number <- decode.then(
    potato_immunization_protocolapplied_dosenumber_decoder(),
  )
  use authority <- decode.optional_field(
    "authority",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  let placeholder =
    PotatoImmunizationProtocolapplied(
      target_disease:,
      series_doses:,
      series:,
      id:,
      dose_number:,
      authority:,
    )
  decode.success(placeholder)
}

pub fn potato_immunization_performer_decoder() -> Decoder(
  PotatoImmunizationPerformer,
) {
  use <- decode.recursive
  use id <- decode_optional_string("id")
  use function <- decode.optional_field(
    "function",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use actor <- decode.field("actor", ct.potatoreference_decoder())
  let placeholder = PotatoImmunizationPerformer(id:, function:, actor:)
  decode.success(placeholder)
}

pub fn potato_immunization_education_decoder() -> Decoder(
  PotatoImmunizationEducation,
) {
  use <- decode.recursive
  use reference <- decode_optional_string("reference")
  use publication_date <- decode.optional_field(
    "publicationDate",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use presentation_date <- decode.optional_field(
    "presentationDate",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use id <- decode_optional_string("id")
  use document_type <- decode_optional_string("documentType")
  let placeholder =
    PotatoImmunizationEducation(
      reference:,
      publication_date:,
      presentation_date:,
      id:,
      document_type:,
    )
  decode.success(placeholder)
}

pub fn potato_immunization_occurrence_decoder() -> Decoder(
  PotatoImmunizationOccurrence,
) {
  decode.one_of(
    {
      use value <- decode.field("occurrenceDateTime", pt.datetime_decoder())
      decode.success(PotatoImmunizationOccurrenceDatetime(value))
    },
    [
      {
        use value <- decode.field("occurrenceString", decode.string)
        decode.success(PotatoImmunizationOccurrenceString(value))
      },
    ],
  )
}

pub fn potato_immunization_decoder() -> Decoder(PotatoImmunization) {
  use <- decode.recursive
  use vaccine_code <- decode.field(
    "vaccineCode",
    ct.potatocodeableconcept_decoder(),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use subpotent_reason <- decode.optional_field(
    "subpotentReason",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use status_reason <- decode.optional_field(
    "statusReason",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use status <- decode.field("status", valueset.immunization_status_decoder())
  use site <- decode.optional_field(
    "site",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use route <- decode.optional_field(
    "route",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use report_origin <- decode.optional_field(
    "reportOrigin",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use recorded <- decode.optional_field(
    "recorded",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use reason_reference <- decode.optional_field(
    "reasonReference",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use reason_code <- decode.optional_field(
    "reasonCode",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use reaction <- decode.optional_field(
    "reaction",
    [],
    decode.list(potato_immunization_reaction_decoder()),
  )
  use protocol_applied <- decode.optional_field(
    "protocolApplied",
    [],
    decode.list(potato_immunization_protocolapplied_decoder()),
  )
  use program_eligibility <- decode.optional_field(
    "programEligibility",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use primary_source <- decode_optional_bool("primarySource")
  use performer <- decode.optional_field(
    "performer",
    [],
    decode.list(potato_immunization_performer_decoder()),
  )
  use patient <- decode.field("patient", ct.potatoreference_decoder())
  use occurrence <- decode.then(potato_immunization_occurrence_decoder())
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use manufacturer <- decode.optional_field(
    "manufacturer",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use lot_number <- decode_optional_string("lotNumber")
  use location <- decode.optional_field(
    "location",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use language <- decode_optional_string("language")
  use is_subpotent <- decode_optional_bool("isSubpotent")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use funding_source <- decode.optional_field(
    "fundingSource",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use expiration_date <- decode.optional_field(
    "expirationDate",
    None,
    decode.optional(pt.date_decoder()),
  )
  use encounter <- decode.optional_field(
    "encounter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use education <- decode.optional_field(
    "education",
    [],
    decode.list(potato_immunization_education_decoder()),
  )
  use dose_quantity <- decode.optional_field(
    "doseQuantity",
    None,
    decode.optional(ct.potatosimplequantity_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  let placeholder =
    PotatoImmunization(
      vaccine_code:,
      text:,
      subpotent_reason:,
      status_reason:,
      status:,
      site:,
      route:,
      report_origin:,
      recorded:,
      reason_reference:,
      reason_code:,
      reaction:,
      protocol_applied:,
      program_eligibility:,
      primary_source:,
      performer:,
      patient:,
      occurrence:,
      note:,
      meta:,
      manufacturer:,
      lot_number:,
      location:,
      language:,
      is_subpotent:,
      implicit_rules:,
      identifier:,
      id:,
      funding_source:,
      expiration_date:,
      encounter:,
      education:,
      dose_quantity:,
      contained:,
    )
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "Immunization" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "Immunization")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  decode.success(placeholder)
}

type PotatomedicationadherenceExtensionAccumulator {
  PotatomedicationadherenceExtensionAccumulator(
    information_source: List(ct.Potatocodeableconcept),
    date_asserted: Option(DateTime),
    medication_adherence: Option(ct.Potatocodeableconcept),
  )
}

type PotatomedicationadherenceParsedExtensionSlice {
  PotatomedicationadherenceParsedExtensionSliceInformationsource(
    Option(String),
    ct.Potatocodeableconcept,
  )
  PotatomedicationadherenceParsedExtensionSliceDateasserted(
    Option(String),
    DateTime,
  )
  PotatomedicationadherenceParsedExtensionSliceMedicationadherence(
    Option(String),
    ct.Potatocodeableconcept,
  )
}

fn parse_potatomedicationadherence_child() -> Decoder(
  Result(PotatomedicationadherenceParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "informationSource" ->
        decode.field(
          "valueCodeableConcept",
          ct.potatocodeableconcept_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatomedicationadherenceParsedExtensionSliceInformationsource(
              id,
              value,
            )
          })
        })
      "dateAsserted" ->
        decode.field("valueDateTime", pt.datetime_decoder(), decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatomedicationadherenceParsedExtensionSliceDateasserted(id, value)
          })
        })
      "medicationAdherence" ->
        decode.field(
          "valueCodeableConcept",
          ct.potatocodeableconcept_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatomedicationadherenceParsedExtensionSliceMedicationadherence(
              id,
              value,
            )
          })
        })
      _ -> decode.failure(Error("unmatched extension"), "one permitted slice")
    },
    decode.success,
  )
}

fn parse_potatomedicationadherence() -> Decoder(
  Result(ct.Potatomedicationadherence, String),
) {
  use children <- decode.field(
    "extension",
    decode.list(parse_potatomedicationadherence_child()),
  )
  decode.success({
    let accumulator: Result(
      PotatomedicationadherenceExtensionAccumulator,
      String,
    ) =
      list.fold(
        children,
        Ok(PotatomedicationadherenceExtensionAccumulator([], None, None)),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    PotatomedicationadherenceParsedExtensionSliceInformationsource(
                      _id,
                      value,
                    ) ->
                      Ok(
                        PotatomedicationadherenceExtensionAccumulator(
                          ..accumulator,
                          information_source: [
                            value,
                            ..accumulator.information_source
                          ],
                        ),
                      )
                    PotatomedicationadherenceParsedExtensionSliceDateasserted(
                      _id,
                      value,
                    ) ->
                      Ok(
                        PotatomedicationadherenceExtensionAccumulator(
                          ..accumulator,
                          date_asserted: Some(value),
                        ),
                      )
                    PotatomedicationadherenceParsedExtensionSliceMedicationadherence(
                      _id,
                      value,
                    ) ->
                      Ok(
                        PotatomedicationadherenceExtensionAccumulator(
                          ..accumulator,
                          medication_adherence: Some(value),
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
        case accumulator.date_asserted {
          None -> Error("required extension date_asserted")
          Some(date_asserted) ->
            case accumulator.medication_adherence {
              None -> Error("required extension medication_adherence")
              Some(medication_adherence) ->
                Ok(ct.Potatomedicationadherence(
                  information_source: list.reverse(
                    accumulator.information_source,
                  ),
                  date_asserted:,
                  medication_adherence:,
                ))
            }
        }
    }
  })
}

type PotatoMedicationrequestExtensionSliceAccumulator {
  PotatoMedicationrequestExtensionSliceAccumulator(
    medication_adherence: List(ct.Potatomedicationadherence),
  )
}

pub type PotatoMedicationrequestParsedExtensionSlice {
  PotatoMedicationrequestParsedExtensionSliceMedicationadherence(
    ct.Potatomedicationadherence,
  )
  PotatoMedicationrequestParsedExtensionSliceIgnored
}

type PotatoMedicationrequestExtensionSlices {
  PotatoMedicationrequestExtensionSlices(
    medication_adherence: List(ct.Potatomedicationadherence),
  )
}

type PotatoMedicationrequestCategorySliceAccumulator {
  PotatoMedicationrequestCategorySliceAccumulator(
    us_core: List(ct.CodeableconceptPotatoMedicationrequestCategoryUsCore),
    open: List(ct.Potatocodeableconcept),
  )
}

type PotatoMedicationrequestParsedCategorySlice {
  PotatoMedicationrequestParsedCategorySliceUsCore(
    ct.CodeableconceptPotatoMedicationrequestCategoryUsCore,
  )
  PotatoMedicationrequestParsedCategorySliceOpen(ct.Potatocodeableconcept)
}

type PotatoMedicationrequestCategorySlices {
  PotatoMedicationrequestCategorySlices(
    us_core: List(ct.CodeableconceptPotatoMedicationrequestCategoryUsCore),
    open: List(ct.Potatocodeableconcept),
  )
}

pub fn potato_medicationrequest_substitution_allowed_decoder() -> Decoder(
  PotatoMedicationrequestSubstitutionAllowed,
) {
  decode.one_of(
    {
      use value <- decode.field("allowedBoolean", decode.bool)
      decode.success(PotatoMedicationrequestSubstitutionAllowedBoolean(value))
    },
    [
      {
        use value <- decode.field(
          "allowedCodeableConcept",
          ct.potatocodeableconcept_decoder(),
        )
        decode.success(
          PotatoMedicationrequestSubstitutionAllowedCodeableconcept(value),
        )
      },
    ],
  )
}

pub fn potato_medicationrequest_substitution_decoder() -> Decoder(
  PotatoMedicationrequestSubstitution,
) {
  use <- decode.recursive
  use reason <- decode.optional_field(
    "reason",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use id <- decode_optional_string("id")
  use allowed <- decode.then(
    potato_medicationrequest_substitution_allowed_decoder(),
  )
  let placeholder = PotatoMedicationrequestSubstitution(reason:, id:, allowed:)
  decode.success(placeholder)
}

pub fn potato_medicationrequest_dispenserequest_initialfill_decoder() -> Decoder(
  PotatoMedicationrequestDispenserequestInitialfill,
) {
  use <- decode.recursive
  use quantity <- decode.optional_field(
    "quantity",
    None,
    decode.optional(ct.potatosimplequantity_decoder()),
  )
  use id <- decode_optional_string("id")
  use duration <- decode.optional_field(
    "duration",
    None,
    decode.optional(ct.potatoduration_decoder()),
  )
  let placeholder =
    PotatoMedicationrequestDispenserequestInitialfill(quantity:, id:, duration:)
  decode.success(placeholder)
}

pub fn potato_medicationrequest_dispenserequest_decoder() -> Decoder(
  PotatoMedicationrequestDispenserequest,
) {
  use <- decode.recursive
  use validity_period <- decode.optional_field(
    "validityPeriod",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use quantity <- decode.optional_field(
    "quantity",
    None,
    decode.optional(ct.potatosimplequantity_decoder()),
  )
  use performer <- decode.optional_field(
    "performer",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use number_of_repeats_allowed <- decode.optional_field(
    "numberOfRepeatsAllowed",
    None,
    decode.optional(decode.int),
  )
  use initial_fill <- decode.optional_field(
    "initialFill",
    None,
    decode.optional(
      potato_medicationrequest_dispenserequest_initialfill_decoder(),
    ),
  )
  use id <- decode_optional_string("id")
  use expected_supply_duration <- decode.optional_field(
    "expectedSupplyDuration",
    None,
    decode.optional(ct.potatoduration_decoder()),
  )
  use dispense_interval <- decode.optional_field(
    "dispenseInterval",
    None,
    decode.optional(ct.potatoduration_decoder()),
  )
  let placeholder =
    PotatoMedicationrequestDispenserequest(
      validity_period:,
      quantity:,
      performer:,
      number_of_repeats_allowed:,
      initial_fill:,
      id:,
      expected_supply_duration:,
      dispense_interval:,
    )
  decode.success(placeholder)
}

pub fn potato_medicationrequest_reported_decoder() -> Decoder(
  PotatoMedicationrequestReported,
) {
  decode.one_of(
    {
      use value <- decode.field("reportedBoolean", decode.bool)
      decode.success(PotatoMedicationrequestReportedBoolean(value))
    },
    [
      {
        use value <- decode.field(
          "reportedReference",
          ct.potatoreference_decoder(),
        )
        decode.success(PotatoMedicationrequestReportedReference(value))
      },
    ],
  )
}

pub fn potato_medicationrequest_medication_decoder() -> Decoder(
  PotatoMedicationrequestMedication,
) {
  decode.one_of(
    {
      use value <- decode.field(
        "medicationCodeableConcept",
        ct.potatocodeableconcept_decoder(),
      )
      decode.success(PotatoMedicationrequestMedicationCodeableconcept(value))
    },
    [
      {
        use value <- decode.field(
          "medicationReference",
          ct.potatoreference_decoder(),
        )
        decode.success(PotatoMedicationrequestMedicationReference(value))
      },
    ],
  )
}

pub fn potato_medicationrequest_extension_slice_decoder() -> Decoder(
  Result(PotatoMedicationrequestParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use _id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication-adherence" ->
        parse_potatomedicationadherence()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoMedicationrequestParsedExtensionSliceMedicationadherence(
              value,
            )
          })
        })
      _ ->
        decode.success(Ok(PotatoMedicationrequestParsedExtensionSliceIgnored))
    },
    decode.success,
  )
}

pub fn potato_medicationrequest_decoder() -> Decoder(PotatoMedicationrequest) {
  use <- decode.recursive
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use supporting_information <- decode.optional_field(
    "supportingInformation",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use substitution <- decode.optional_field(
    "substitution",
    None,
    decode.optional(potato_medicationrequest_substitution_decoder()),
  )
  use subject <- decode.field("subject", ct.potatoreference_decoder())
  use status_reason <- decode.optional_field(
    "statusReason",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use status <- decode.field(
    "status",
    valueset.medicationrequest_status_decoder(),
  )
  use requester <- decode.optional_field(
    "requester",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use reported <- decode.then(
    none_if_omitted(potato_medicationrequest_reported_decoder()),
  )
  use recorder <- decode.optional_field(
    "recorder",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use reason_reference <- decode.optional_field(
    "reasonReference",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use reason_code <- decode.optional_field(
    "reasonCode",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use priority <- decode.optional_field(
    "priority",
    None,
    decode.optional(valueset.request_priority_decoder()),
  )
  use prior_prescription <- decode.optional_field(
    "priorPrescription",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use performer_type <- decode.optional_field(
    "performerType",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use performer <- decode.optional_field(
    "performer",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use medication <- decode.then(potato_medicationrequest_medication_decoder())
  use language <- decode_optional_string("language")
  use intent <- decode.field(
    "intent",
    valueset.medicationrequest_intent_decoder(),
  )
  use insurance <- decode.optional_field(
    "insurance",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use instantiates_uri <- decode.optional_field(
    "instantiatesUri",
    [],
    decode.list(decode.string),
  )
  use instantiates_canonical <- decode.optional_field(
    "instantiatesCanonical",
    [],
    decode.list(decode.string),
  )
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use group_identifier <- decode.optional_field(
    "groupIdentifier",
    None,
    decode.optional(ct.potatoidentifier_decoder()),
  )
  use extension_base_values <- decode.optional_field(
    "extension",
    [],
    decode.list(potato_medicationrequest_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(PotatoMedicationrequestExtensionSliceAccumulator([])),
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
                  PotatoMedicationrequestParsedExtensionSliceMedicationadherence(
                    value,
                  ) ->
                    Ok(
                      PotatoMedicationrequestExtensionSliceAccumulator(
                        medication_adherence: [
                          value,
                          ..accumulator.medication_adherence
                        ],
                      ),
                    )
                  PotatoMedicationrequestParsedExtensionSliceIgnored ->
                    Ok(accumulator)
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(
        PotatoMedicationrequestExtensionSlices(
          medication_adherence: list.reverse(accumulator.medication_adherence),
        ),
      )
    Error(errors) -> Error(errors)
  }
  use event_history <- decode.optional_field(
    "eventHistory",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use encounter <- decode.optional_field(
    "encounter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use dosage_instruction <- decode.optional_field(
    "dosageInstruction",
    [],
    decode.list(ct.dosage_potato_medicationrequest_dosageinstruction_decoder()),
  )
  use do_not_perform <- decode_optional_bool("doNotPerform")
  use dispense_request <- decode.optional_field(
    "dispenseRequest",
    None,
    decode.optional(potato_medicationrequest_dispenserequest_decoder()),
  )
  use detected_issue <- decode.optional_field(
    "detectedIssue",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use course_of_therapy_type <- decode.optional_field(
    "courseOfTherapyType",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use category_base_values <- decode.optional_field(
    "category",
    [],
    decode.list({
      use category_raw <- decode.then(decode.dynamic)
      case
        case
          decode.run(
            category_raw,
            decode.then(decode.dynamic, fn(value) {
              use <- bool.guard(
                !{
                  case
                    decode.run(
                      value,
                      ct.codeableconcept_potato_medicationrequest_category_us_core_decoder(),
                    )
                  {
                    Ok(_) -> True
                    Error(_) -> False
                  }
                },
                decode.success(ct.DiscriminatorDifferent),
              )
              decode.success(ct.DiscriminatorMatches)
            }),
          )
        {
          Ok(matched) -> matched
          Error(_) -> ct.DiscriminatorDifferent
        }
      {
        ct.DiscriminatorMatches ->
          ct.codeableconcept_potato_medicationrequest_category_us_core_decoder()
          |> decode.map(PotatoMedicationrequestParsedCategorySliceUsCore)
        ct.DiscriminatorDifferent ->
          ct.potatocodeableconcept_decoder()
          |> decode.map(PotatoMedicationrequestParsedCategorySliceOpen)
      }
    }),
  )
  let category_accumulator =
    list.index_fold(
      category_base_values,
      PotatoMedicationrequestCategorySliceAccumulator([], []),
      fn(accumulator, parsed, _index) {
        case parsed {
          PotatoMedicationrequestParsedCategorySliceUsCore(value) ->
            PotatoMedicationrequestCategorySliceAccumulator(
              ..accumulator,
              us_core: [value, ..accumulator.us_core],
            )
          PotatoMedicationrequestParsedCategorySliceOpen(value) ->
            PotatoMedicationrequestCategorySliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let category_slices =
    PotatoMedicationrequestCategorySlices(
      us_core: list.reverse(category_accumulator.us_core),
      open: list.reverse(category_accumulator.open),
    )
  use based_on <- decode.optional_field(
    "basedOn",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use authored_on <- decode.optional_field(
    "authoredOn",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  let extension_slices_decoder = case extension_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatoMedicationrequestExtensionSlices([]),
        "PotatoMedicationrequest slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "MedicationRequest" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "MedicationRequest")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  use extension_slices <- decode.then(extension_slices_decoder)
  decode.success(PotatoMedicationrequest(
    text:,
    supporting_information:,
    substitution:,
    subject:,
    status_reason:,
    status:,
    requester:,
    reported:,
    recorder:,
    reason_reference:,
    reason_code:,
    priority:,
    prior_prescription:,
    performer_type:,
    performer:,
    note:,
    meta:,
    medication:,
    language:,
    intent:,
    insurance:,
    instantiates_uri:,
    instantiates_canonical:,
    implicit_rules:,
    identifier:,
    id:,
    group_identifier:,
    medication_adherence: extension_slices.medication_adherence,
    event_history:,
    encounter:,
    dosage_instruction:,
    do_not_perform:,
    dispense_request:,
    detected_issue:,
    course_of_therapy_type:,
    contained:,
    us_core: category_slices.us_core,
    category: category_slices.open,
    based_on:,
    authored_on:,
  ))
}

pub fn potato_medicationstatement_medication_decoder() -> Decoder(
  PotatoMedicationstatementMedication,
) {
  decode.one_of(
    {
      use value <- decode.field(
        "medicationCodeableConcept",
        ct.potatocodeableconcept_decoder(),
      )
      decode.success(PotatoMedicationstatementMedicationCodeableconcept(value))
    },
    [
      {
        use value <- decode.field(
          "medicationReference",
          ct.potatoreference_decoder(),
        )
        decode.success(PotatoMedicationstatementMedicationReference(value))
      },
    ],
  )
}

pub fn potato_medicationstatement_effective_decoder() -> Decoder(
  PotatoMedicationstatementEffective,
) {
  decode.one_of(
    {
      use value <- decode.field("effectiveDateTime", pt.datetime_decoder())
      decode.success(PotatoMedicationstatementEffectiveDatetime(value))
    },
    [
      {
        use value <- decode.field("effectivePeriod", ct.potatoperiod_decoder())
        decode.success(PotatoMedicationstatementEffectivePeriod(value))
      },
    ],
  )
}

pub fn potato_medicationstatement_decoder() -> Decoder(
  PotatoMedicationstatement,
) {
  use <- decode.recursive
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use subject <- decode.field("subject", ct.potatoreference_decoder())
  use status_reason <- decode.optional_field(
    "statusReason",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use status <- decode.field(
    "status",
    valueset.medicationstatement_status_decoder(),
  )
  use reason_reference <- decode.optional_field(
    "reasonReference",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use reason_code <- decode.optional_field(
    "reasonCode",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use part_of <- decode.optional_field(
    "partOf",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use medication <- decode.then(potato_medicationstatement_medication_decoder())
  use language <- decode_optional_string("language")
  use information_source <- decode.optional_field(
    "informationSource",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- decode.optional_field(
    "identifier",
    [],
    decode.list(ct.potatoidentifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use effective <- decode.then(
    none_if_omitted(potato_medicationstatement_effective_decoder()),
  )
  use dosage <- decode.optional_field(
    "dosage",
    [],
    decode.list(ct.potatodosage_decoder()),
  )
  use derived_from <- decode.optional_field(
    "derivedFrom",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use date_asserted <- decode.optional_field(
    "dateAsserted",
    None,
    decode.optional(pt.datetime_decoder()),
  )
  use context <- decode.optional_field(
    "context",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use category <- decode.optional_field(
    "category",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use based_on <- decode.optional_field(
    "basedOn",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  let placeholder =
    PotatoMedicationstatement(
      text:,
      subject:,
      status_reason:,
      status:,
      reason_reference:,
      reason_code:,
      part_of:,
      note:,
      meta:,
      medication:,
      language:,
      information_source:,
      implicit_rules:,
      identifier:,
      id:,
      effective:,
      dosage:,
      derived_from:,
      date_asserted:,
      context:,
      contained:,
      category:,
      based_on:,
    )
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "MedicationStatement" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "MedicationStatement")
          |> decode.map_errors(fn(errors) {
            list.map(errors, fn(error) {
              decode.DecodeError(..error, found: value)
            })
          })
      }
    }),
  )
  decode.success(placeholder)
}

type PotatoethnicityExtensionAccumulator {
  PotatoethnicityExtensionAccumulator(
    text: Option(String),
    detailed: List(ct.CodingPotatoethnicityExtensionDetailedValue),
    omb_category: Option(ct.CodingPotatoethnicityExtensionOmbcategoryValue),
  )
}

type PotatoethnicityParsedExtensionSlice {
  PotatoethnicityParsedExtensionSliceText(Option(String), String)
  PotatoethnicityParsedExtensionSliceDetailed(
    Option(String),
    ct.CodingPotatoethnicityExtensionDetailedValue,
  )
  PotatoethnicityParsedExtensionSliceOmbcategory(
    Option(String),
    ct.CodingPotatoethnicityExtensionOmbcategoryValue,
  )
}

fn parse_potatoethnicity_child() -> Decoder(
  Result(PotatoethnicityParsedExtensionSlice, String),
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
            PotatoethnicityParsedExtensionSliceText(id, value)
          })
        })
      "detailed" ->
        decode.field(
          "valueCoding",
          ct.coding_potatoethnicity_extension_detailed_value_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoethnicityParsedExtensionSliceDetailed(id, value)
          })
        })
      "ombCategory" ->
        decode.field(
          "valueCoding",
          ct.coding_potatoethnicity_extension_ombcategory_value_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoethnicityParsedExtensionSliceOmbcategory(id, value)
          })
        })
      _ -> decode.failure(Error("unmatched extension"), "one permitted slice")
    },
    decode.success,
  )
}

fn parse_potatoethnicity() -> Decoder(Result(ct.Potatoethnicity, String)) {
  use children <- decode.field(
    "extension",
    decode.list(parse_potatoethnicity_child()),
  )
  decode.success({
    let accumulator: Result(PotatoethnicityExtensionAccumulator, String) =
      list.fold(
        children,
        Ok(PotatoethnicityExtensionAccumulator(None, [], None)),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    PotatoethnicityParsedExtensionSliceText(_id, value) ->
                      Ok(
                        PotatoethnicityExtensionAccumulator(
                          ..accumulator,
                          text: Some(value),
                        ),
                      )
                    PotatoethnicityParsedExtensionSliceDetailed(_id, value) ->
                      Ok(
                        PotatoethnicityExtensionAccumulator(
                          ..accumulator,
                          detailed: [value, ..accumulator.detailed],
                        ),
                      )
                    PotatoethnicityParsedExtensionSliceOmbcategory(_id, value) ->
                      Ok(
                        PotatoethnicityExtensionAccumulator(
                          ..accumulator,
                          omb_category: Some(value),
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
            Ok(ct.Potatoethnicity(
              text:,
              detailed: list.reverse(accumulator.detailed),
              omb_category: accumulator.omb_category,
            ))
        }
    }
  })
}

type PotatoraceExtensionAccumulator {
  PotatoraceExtensionAccumulator(
    text: Option(String),
    detailed: List(ct.CodingPotatoraceExtensionDetailedValue),
    omb_category: List(ct.CodingPotatoraceExtensionOmbcategoryValue),
  )
}

type PotatoraceParsedExtensionSlice {
  PotatoraceParsedExtensionSliceText(Option(String), String)
  PotatoraceParsedExtensionSliceDetailed(
    Option(String),
    ct.CodingPotatoraceExtensionDetailedValue,
  )
  PotatoraceParsedExtensionSliceOmbcategory(
    Option(String),
    ct.CodingPotatoraceExtensionOmbcategoryValue,
  )
}

fn parse_potatorace_child() -> Decoder(
  Result(PotatoraceParsedExtensionSlice, String),
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
            PotatoraceParsedExtensionSliceText(id, value)
          })
        })
      "detailed" ->
        decode.field(
          "valueCoding",
          ct.coding_potatorace_extension_detailed_value_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoraceParsedExtensionSliceDetailed(id, value)
          })
        })
      "ombCategory" ->
        decode.field(
          "valueCoding",
          ct.coding_potatorace_extension_ombcategory_value_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoraceParsedExtensionSliceOmbcategory(id, value)
          })
        })
      _ -> decode.failure(Error("unmatched extension"), "one permitted slice")
    },
    decode.success,
  )
}

fn parse_potatorace() -> Decoder(Result(ct.Potatorace, String)) {
  use children <- decode.field(
    "extension",
    decode.list(parse_potatorace_child()),
  )
  decode.success({
    let accumulator: Result(PotatoraceExtensionAccumulator, String) =
      list.fold(
        children,
        Ok(PotatoraceExtensionAccumulator(None, [], [])),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    PotatoraceParsedExtensionSliceText(_id, value) ->
                      Ok(
                        PotatoraceExtensionAccumulator(
                          ..accumulator,
                          text: Some(value),
                        ),
                      )
                    PotatoraceParsedExtensionSliceDetailed(_id, value) ->
                      Ok(
                        PotatoraceExtensionAccumulator(..accumulator, detailed: [
                          value,
                          ..accumulator.detailed
                        ]),
                      )
                    PotatoraceParsedExtensionSliceOmbcategory(_id, value) ->
                      Ok(
                        PotatoraceExtensionAccumulator(
                          ..accumulator,
                          omb_category: [value, ..accumulator.omb_category],
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
            Ok(ct.Potatorace(
              text:,
              detailed: list.reverse(accumulator.detailed),
              omb_category: list.reverse(accumulator.omb_category),
            ))
        }
    }
  })
}

type PotatotribalaffiliationExtensionAccumulator {
  PotatotribalaffiliationExtensionAccumulator(
    is_enrolled: Option(Bool),
    tribal_affiliation: Option(ct.Potatocodeableconcept),
  )
}

type PotatotribalaffiliationParsedExtensionSlice {
  PotatotribalaffiliationParsedExtensionSliceIsenrolled(Option(String), Bool)
  PotatotribalaffiliationParsedExtensionSliceTribalaffiliation(
    Option(String),
    ct.Potatocodeableconcept,
  )
}

fn parse_potatotribalaffiliation_child() -> Decoder(
  Result(PotatotribalaffiliationParsedExtensionSlice, String),
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
            PotatotribalaffiliationParsedExtensionSliceIsenrolled(id, value)
          })
        })
      "tribalAffiliation" ->
        decode.field(
          "valueCodeableConcept",
          ct.potatocodeableconcept_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatotribalaffiliationParsedExtensionSliceTribalaffiliation(
              id,
              value,
            )
          })
        })
      _ -> decode.failure(Error("unmatched extension"), "one permitted slice")
    },
    decode.success,
  )
}

fn parse_potatotribalaffiliation() -> Decoder(
  Result(ct.Potatotribalaffiliation, String),
) {
  use children <- decode.field(
    "extension",
    decode.list(parse_potatotribalaffiliation_child()),
  )
  decode.success({
    let accumulator: Result(PotatotribalaffiliationExtensionAccumulator, String) =
      list.fold(
        children,
        Ok(PotatotribalaffiliationExtensionAccumulator(None, None)),
        fn(accumulator_result, child) {
          case accumulator_result {
            Error(reason) -> Error(reason)
            Ok(accumulator) ->
              case child {
                Error(reason) -> Error(reason)
                Ok(slice) ->
                  case slice {
                    PotatotribalaffiliationParsedExtensionSliceIsenrolled(
                      _id,
                      value,
                    ) ->
                      Ok(
                        PotatotribalaffiliationExtensionAccumulator(
                          ..accumulator,
                          is_enrolled: Some(value),
                        ),
                      )
                    PotatotribalaffiliationParsedExtensionSliceTribalaffiliation(
                      _id,
                      value,
                    ) ->
                      Ok(
                        PotatotribalaffiliationExtensionAccumulator(
                          ..accumulator,
                          tribal_affiliation: Some(value),
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
            Ok(ct.Potatotribalaffiliation(
              is_enrolled: accumulator.is_enrolled,
              tribal_affiliation:,
            ))
        }
    }
  })
}

type PotatoPatientExtensionSliceAccumulator {
  PotatoPatientExtensionSliceAccumulator(
    tribal_affiliation: List(ct.Potatotribalaffiliation),
    sex: Option(String),
    race: Option(ct.Potatorace),
    gender_identity: List(ct.Potatocodeableconcept),
    ethnicity: Option(ct.Potatoethnicity),
    birthsex: Option(valueset.Two16840111376214102124),
  )
}

pub type PotatoPatientParsedExtensionSlice {
  PotatoPatientParsedExtensionSliceTribalaffiliation(ct.Potatotribalaffiliation)
  PotatoPatientParsedExtensionSliceSex(String)
  PotatoPatientParsedExtensionSliceRace(ct.Potatorace)
  PotatoPatientParsedExtensionSliceGenderidentity(ct.Potatocodeableconcept)
  PotatoPatientParsedExtensionSliceEthnicity(ct.Potatoethnicity)
  PotatoPatientParsedExtensionSliceBirthsex(valueset.Two16840111376214102124)
  PotatoPatientParsedExtensionSliceIgnored
}

type PotatoPatientExtensionSlices {
  PotatoPatientExtensionSlices(
    tribal_affiliation: List(ct.Potatotribalaffiliation),
    sex: Option(String),
    race: Option(ct.Potatorace),
    gender_identity: List(ct.Potatocodeableconcept),
    ethnicity: Option(ct.Potatoethnicity),
    birthsex: Option(valueset.Two16840111376214102124),
  )
}

pub fn potato_patient_link_decoder() -> Decoder(PotatoPatientLink) {
  use <- decode.recursive
  use type_ <- decode.field("type", valueset.link_type_decoder())
  use other <- decode.field("other", ct.potatoreference_decoder())
  use id <- decode_optional_string("id")
  let placeholder = PotatoPatientLink(type_:, other:, id:)
  decode.success(placeholder)
}

pub fn potato_patient_contact_decoder() -> Decoder(PotatoPatientContact) {
  use <- decode.recursive
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.potatocontactpoint_decoder()),
  )
  use relationship <- decode.optional_field(
    "relationship",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.potatoperiod_decoder()),
  )
  use organization <- decode.optional_field(
    "organization",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use name <- decode.optional_field(
    "name",
    None,
    decode.optional(ct.potatohumanname_decoder()),
  )
  use id <- decode_optional_string("id")
  use gender <- decode.optional_field(
    "gender",
    None,
    decode.optional(valueset.administrative_gender_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    None,
    decode.optional(ct.potatoaddress_decoder()),
  )
  let placeholder =
    PotatoPatientContact(
      telecom:,
      relationship:,
      period:,
      organization:,
      name:,
      id:,
      gender:,
      address:,
    )
  decode.success(placeholder)
}

pub fn potato_patient_communication_decoder() -> Decoder(
  PotatoPatientCommunication,
) {
  use <- decode.recursive
  use preferred <- decode_optional_bool("preferred")
  use language <- decode.field("language", ct.potatocodeableconcept_decoder())
  use id <- decode_optional_string("id")
  let placeholder = PotatoPatientCommunication(preferred:, language:, id:)
  decode.success(placeholder)
}

pub fn potato_patient_multiplebirth_decoder() -> Decoder(
  PotatoPatientMultiplebirth,
) {
  decode.one_of(
    {
      use value <- decode.field("multipleBirthBoolean", decode.bool)
      decode.success(PotatoPatientMultiplebirthBoolean(value))
    },
    [
      {
        use value <- decode.field("multipleBirthInteger", decode.int)
        decode.success(PotatoPatientMultiplebirthInteger(value))
      },
    ],
  )
}

pub fn potato_patient_extension_slice_decoder() -> Decoder(
  Result(PotatoPatientParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use _id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation" ->
        parse_potatotribalaffiliation()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoPatientParsedExtensionSliceTribalaffiliation(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-sex" ->
        decode.field("valueCode", decode.string, decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoPatientParsedExtensionSliceSex(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race" ->
        parse_potatorace()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoPatientParsedExtensionSliceRace(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-genderIdentity" ->
        decode.field(
          "valueCodeableConcept",
          ct.potatocodeableconcept_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoPatientParsedExtensionSliceGenderidentity(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity" ->
        parse_potatoethnicity()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoPatientParsedExtensionSliceEthnicity(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex" ->
        decode.field(
          "valueCode",
          valueset.two16840111376214102124_decoder(),
          decode.success,
        )
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatoPatientParsedExtensionSliceBirthsex(value)
          })
        })
      _ -> decode.success(Ok(PotatoPatientParsedExtensionSliceIgnored))
    },
    decode.success,
  )
}

pub fn potato_patient_deceased_decoder() -> Decoder(PotatoPatientDeceased) {
  decode.one_of(
    {
      use value <- decode.field("deceasedBoolean", decode.bool)
      decode.success(PotatoPatientDeceasedBoolean(value))
    },
    [
      {
        use value <- decode.field("deceasedDateTime", pt.datetime_decoder())
        decode.success(PotatoPatientDeceasedDatetime(value))
      },
    ],
  )
}

pub fn potato_patient_decoder() -> Decoder(PotatoPatient) {
  use <- decode.recursive
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.contactpoint_potato_patient_telecom_decoder()),
  )
  use photo <- decode.optional_field(
    "photo",
    [],
    decode.list(ct.potatoattachment_decoder()),
  )
  use name <- list1_decoder("name", ct.humanname_potato_patient_name_decoder())
  use multiple_birth <- decode.then(
    none_if_omitted(potato_patient_multiplebirth_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.potatometa_decoder()),
  )
  use marital_status <- decode.optional_field(
    "maritalStatus",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use managing_organization <- decode.optional_field(
    "managingOrganization",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(potato_patient_link_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- list1_decoder(
    "identifier",
    ct.identifier_potato_patient_identifier_decoder(),
  )
  use id <- decode_optional_string("id")
  use general_practitioner <- decode.optional_field(
    "generalPractitioner",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use gender <- decode.field("gender", valueset.administrative_gender_decoder())
  use extension_base_values <- decode.optional_field(
    "extension",
    [],
    decode.list(potato_patient_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(PotatoPatientExtensionSliceAccumulator([], None, None, [], None, None)),
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
                  PotatoPatientParsedExtensionSliceTribalaffiliation(value) ->
                    Ok(
                      PotatoPatientExtensionSliceAccumulator(
                        ..accumulator,
                        tribal_affiliation: [
                          value,
                          ..accumulator.tribal_affiliation
                        ],
                      ),
                    )
                  PotatoPatientParsedExtensionSliceSex(value) ->
                    Ok(
                      PotatoPatientExtensionSliceAccumulator(
                        ..accumulator,
                        sex: Some(value),
                      ),
                    )
                  PotatoPatientParsedExtensionSliceRace(value) ->
                    Ok(
                      PotatoPatientExtensionSliceAccumulator(
                        ..accumulator,
                        race: Some(value),
                      ),
                    )
                  PotatoPatientParsedExtensionSliceGenderidentity(value) ->
                    Ok(
                      PotatoPatientExtensionSliceAccumulator(
                        ..accumulator,
                        gender_identity: [value, ..accumulator.gender_identity],
                      ),
                    )
                  PotatoPatientParsedExtensionSliceEthnicity(value) ->
                    Ok(
                      PotatoPatientExtensionSliceAccumulator(
                        ..accumulator,
                        ethnicity: Some(value),
                      ),
                    )
                  PotatoPatientParsedExtensionSliceBirthsex(value) ->
                    Ok(
                      PotatoPatientExtensionSliceAccumulator(
                        ..accumulator,
                        birthsex: Some(value),
                      ),
                    )
                  PotatoPatientParsedExtensionSliceIgnored -> Ok(accumulator)
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(PotatoPatientExtensionSlices(
        tribal_affiliation: list.reverse(accumulator.tribal_affiliation),
        sex: accumulator.sex,
        race: accumulator.race,
        gender_identity: list.reverse(accumulator.gender_identity),
        ethnicity: accumulator.ethnicity,
        birthsex: accumulator.birthsex,
      ))
    Error(errors) -> Error(errors)
  }
  use deceased <- decode.then(
    none_if_omitted(potato_patient_deceased_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use contact <- decode.optional_field(
    "contact",
    [],
    decode.list(potato_patient_contact_decoder()),
  )
  use communication <- decode.optional_field(
    "communication",
    [],
    decode.list(potato_patient_communication_decoder()),
  )
  use birth_date <- decode.optional_field(
    "birthDate",
    None,
    decode.optional(pt.date_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    [],
    decode.list(ct.address_potato_patient_address_decoder()),
  )
  use active <- decode_optional_bool("active")
  let extension_slices_decoder = case extension_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatoPatientExtensionSlices([], None, None, [], None, None),
        "PotatoPatient slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
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
    }),
  )
  use extension_slices <- decode.then(extension_slices_decoder)
  decode.success(PotatoPatient(
    text:,
    telecom:,
    photo:,
    name:,
    multiple_birth:,
    meta:,
    marital_status:,
    managing_organization:,
    link:,
    language:,
    implicit_rules:,
    identifier:,
    id:,
    general_practitioner:,
    gender:,
    tribal_affiliation: extension_slices.tribal_affiliation,
    sex: extension_slices.sex,
    race: extension_slices.race,
    gender_identity: extension_slices.gender_identity,
    ethnicity: extension_slices.ethnicity,
    birthsex: extension_slices.birthsex,
    deceased:,
    contained:,
    contact:,
    communication:,
    birth_date:,
    address:,
    active:,
  ))
}

pub type ResourceType {
  ResourceTypeBundle
  ResourceTypeOperationoutcome
  ResourceTypeParameters
  ResourceTypeAllergyintolerance
  ResourceTypeAppointment
  ResourceTypeCondition
  ResourceTypeDocumentreference
  ResourceTypeEncounter
  ResourceTypeImmunization
  ResourceTypeMedicationrequest
  ResourceTypeMedicationstatement
  ResourceTypePatient
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    ResourceTypeBundle -> "Bundle"
    ResourceTypeOperationoutcome -> "OperationOutcome"
    ResourceTypeParameters -> "Parameters"
    ResourceTypeAllergyintolerance -> "AllergyIntolerance"
    ResourceTypeAppointment -> "Appointment"
    ResourceTypeCondition -> "Condition"
    ResourceTypeDocumentreference -> "DocumentReference"
    ResourceTypeEncounter -> "Encounter"
    ResourceTypeImmunization -> "Immunization"
    ResourceTypeMedicationrequest -> "MedicationRequest"
    ResourceTypeMedicationstatement -> "MedicationStatement"
    ResourceTypePatient -> "Patient"
  }
}

pub type Resource {
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourcePotatoAllergyintolerance(PotatoAllergyintolerance)
  ResourcePotatoAppointment(PotatoAppointment)
  ResourcePotatoCondition(PotatoCondition)
  ResourcePotatoDocumentreference(PotatoDocumentreference)
  ResourcePotatoEncounter(PotatoEncounter)
  ResourcePotatoImmunization(PotatoImmunization)
  ResourcePotatoMedicationrequest(PotatoMedicationrequest)
  ResourcePotatoMedicationstatement(PotatoMedicationstatement)
  ResourcePotatoPatient(PotatoPatient)
}

pub fn to_json(resource: Resource) -> Json {
  case resource {
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourcePotatoAllergyintolerance(resource) ->
      potato_allergyintolerance_to_json(resource)
    ResourcePotatoAppointment(resource) -> potato_appointment_to_json(resource)
    ResourcePotatoCondition(resource) -> potato_condition_to_json(resource)
    ResourcePotatoDocumentreference(resource) ->
      potato_documentreference_to_json(resource)
    ResourcePotatoEncounter(resource) -> potato_encounter_to_json(resource)
    ResourcePotatoImmunization(resource) ->
      potato_immunization_to_json(resource)
    ResourcePotatoMedicationrequest(resource) ->
      potato_medicationrequest_to_json(resource)
    ResourcePotatoMedicationstatement(resource) ->
      potato_medicationstatement_to_json(resource)
    ResourcePotatoPatient(resource) -> potato_patient_to_json(resource)
  }
}

pub fn resource_decoder() -> Decoder(Resource) {
  use tag <- decode.field("resourceType", decode.string)
  case tag {
    "Bundle" -> bundle_decoder() |> decode.map(ResourceBundle)
    "OperationOutcome" ->
      operationoutcome_decoder() |> decode.map(ResourceOperationoutcome)
    "Parameters" -> parameters_decoder() |> decode.map(ResourceParameters)
    "AllergyIntolerance" ->
      potato_allergyintolerance_decoder()
      |> decode.map(ResourcePotatoAllergyintolerance)
    "Appointment" ->
      potato_appointment_decoder() |> decode.map(ResourcePotatoAppointment)
    "Condition" ->
      potato_condition_decoder() |> decode.map(ResourcePotatoCondition)
    "DocumentReference" ->
      potato_documentreference_decoder()
      |> decode.map(ResourcePotatoDocumentreference)
    "Encounter" ->
      potato_encounter_decoder() |> decode.map(ResourcePotatoEncounter)
    "Immunization" ->
      potato_immunization_decoder() |> decode.map(ResourcePotatoImmunization)
    "MedicationRequest" ->
      potato_medicationrequest_decoder()
      |> decode.map(ResourcePotatoMedicationrequest)
    "MedicationStatement" ->
      potato_medicationstatement_decoder()
      |> decode.map(ResourcePotatoMedicationstatement)
    "Patient" -> potato_patient_decoder() |> decode.map(ResourcePotatoPatient)
    _ ->
      bundle_decoder()
      |> decode.map(ResourceBundle)
      |> decode.then(fn(value) { decode.failure(value, expected: "") })
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
