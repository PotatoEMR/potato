////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) resources

import fhir/potato_client_1_0_0/complex_types.{
  type List1, decode_optional_bool, decode_optional_string, list1_decoder,
  list1_to_json, none_if_omitted,
} as ct
import fhir/potato_client_1_0_0/primitive_types.{
  type Date, type DateTime, type Instant,
} as pt
import fhir/potato_client_1_0_0/valuesets
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
    type_: valuesets.Bundletype,
    link: List(BundleLink),
    entry: List(BundleEntry),
  )
}

pub fn bundle_new(type_ type_: valuesets.Bundletype) -> Bundle {
  Bundle(entry: [], link: [], type_:)
}

pub fn bundle_to_json(bundle: Bundle) -> Json {
  let fields = [
    #("type", valuesets.bundletype_to_json(bundle.type_)),
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
  use type_ <- decode.field("type", valuesets.bundletype_decoder())

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Bundle",
    decode.failure(bundle_new(type_:), "resourceType"),
  )
  decode.success(Bundle(entry:, link:, type_:))
}

pub type BundleForgiving {
  BundleForgiving(
    type_: valuesets.Bundletype,
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
  use type_ <- decode.field("type", valuesets.bundletype_decoder())

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Bundle",
    decode.failure(BundleForgiving(entry:, link:, type_:), "resourceType"),
  )
  decode.success(BundleForgiving(entry:, link:, type_:))
}

pub fn bundle_entry_to_json(bundle_entry: BundleEntry) -> Json {
  let fields = []
  let fields = case bundle_entry.resource {
    Some(v) -> [#("resource", resource_to_json(v)), ..fields]
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
      decode.one_of(resource_decoder() |> decode.map(Ok), [
        decode.dynamic
        |> decode.map(fn(res_json) { decode.run(res_json, resource_decoder()) }),
      ]),
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
    severity: valuesets.Issueseverity,
    code: valuesets.Issuetype,
  )
}

pub fn operationoutcome_issue_new(
  code code: valuesets.Issuetype,
  severity severity: valuesets.Issueseverity,
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

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "OperationOutcome",
    decode.failure(operationoutcome_new(issue:), "resourceType"),
  )
  decode.success(Operationoutcome(issue:))
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
  json.object(fields)
}

pub fn operationoutcome_issue_decoder() -> Decoder(OperationoutcomeIssue) {
  use <- decode.recursive
  use code <- decode.field("code", valuesets.issuetype_decoder())
  use severity <- decode.field("severity", valuesets.issueseverity_decoder())
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

  use rt <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    rt != "Parameters",
    decode.failure(parameters_new(), "resourceType"),
  )
  decode.success(Parameters)
}

pub type Potatoallergyintolerance {
  Potatoallergyintolerance(
    asserter: Option(ct.Potatoreference),
    category: List(valuesets.Allergyintolerancecategory),
    clinical_status: Option(
      ct.CodeableconceptPotatoallergyintoleranceClinicalstatus,
    ),
    code: ct.Potatocodeableconcept,
    contained: List(Resource),
    criticality: Option(valuesets.Allergyintolerancecriticality),
    encounter: Option(ct.Potatoreference),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    last_occurrence: Option(DateTime),
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    onset: Option(PotatoallergyintoleranceOnset),
    patient: ct.Potatoreference,
    reaction: List(PotatoallergyintoleranceReaction),
    recorded_date: Option(DateTime),
    recorder: Option(ct.Potatoreference),
    text: Option(ct.Potatonarrative),
    type_: Option(valuesets.Allergyintolerancetype),
    verification_status: Option(
      ct.CodeableconceptPotatoallergyintoleranceVerificationstatus,
    ),
  )
}

pub fn potatoallergyintolerance_new(
  code code: ct.Potatocodeableconcept,
  patient patient: ct.Potatoreference,
) -> Potatoallergyintolerance {
  Potatoallergyintolerance(
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

pub type PotatoallergyintoleranceOnset {
  PotatoallergyintoleranceOnsetDatetime(value: DateTime)
  PotatoallergyintoleranceOnsetAge(value: ct.Potatoage)
  PotatoallergyintoleranceOnsetPeriod(value: ct.Potatoperiod)
  PotatoallergyintoleranceOnsetRange(value: ct.Potatorange)
  PotatoallergyintoleranceOnsetString(value: String)
}

pub type PotatoallergyintoleranceReaction {
  PotatoallergyintoleranceReaction(
    description: Option(String),
    exposure_route: Option(ct.Potatocodeableconcept),
    id: Option(String),
    manifestation: List1(ct.Potatocodeableconcept),
    note: List(ct.Potatoannotation),
    onset: Option(DateTime),
    severity: Option(valuesets.Reactioneventseverity),
    substance: Option(ct.Potatocodeableconcept),
  )
}

pub fn potatoallergyintolerance_reaction_new(
  manifestation manifestation: List1(ct.Potatocodeableconcept),
) -> PotatoallergyintoleranceReaction {
  PotatoallergyintoleranceReaction(
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

pub fn potatoallergyintolerance_to_json(
  potatoallergyintolerance: Potatoallergyintolerance,
) -> Json {
  let fields = [
    #("patient", ct.potatoreference_to_json(potatoallergyintolerance.patient)),
    #("code", ct.potatocodeableconcept_to_json(potatoallergyintolerance.code)),
  ]
  let fields = case potatoallergyintolerance.verification_status {
    Some(v) -> [
      #(
        "verificationStatus",
        ct.codeableconcept_potatoallergyintolerance_verificationstatus_to_json(
          v,
        ),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance.type_ {
    Some(v) -> [
      #("type", valuesets.allergyintolerancetype_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.recorder {
    Some(v) -> [#("recorder", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.recorded_date {
    Some(v) -> [#("recordedDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.reaction {
    [] -> fields
    values -> [
      #(
        "reaction",
        json.array(values, potatoallergyintolerance_reaction_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoallergyintolerance.onset {
    Some(v) -> [
      #(
        "onset"
          <> case v {
          PotatoallergyintoleranceOnsetDatetime(_) -> "DateTime"
          PotatoallergyintoleranceOnsetAge(_) -> "Age"
          PotatoallergyintoleranceOnsetPeriod(_) -> "Period"
          PotatoallergyintoleranceOnsetRange(_) -> "Range"
          PotatoallergyintoleranceOnsetString(_) -> "String"
        },
        potatoallergyintolerance_onset_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potatoallergyintolerance.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.last_occurrence {
    Some(v) -> [#("lastOccurrence", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatoallergyintolerance.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance.criticality {
    Some(v) -> [
      #("criticality", valuesets.allergyintolerancecriticality_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatoallergyintolerance.clinical_status {
    Some(v) -> [
      #(
        "clinicalStatus",
        ct.codeableconcept_potatoallergyintolerance_clinicalstatus_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance.category {
    [] -> fields
    values -> [
      #(
        "category",
        json.array(values, valuesets.allergyintolerancecategory_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoallergyintolerance.asserter {
    Some(v) -> [#("asserter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("AllergyIntolerance")), ..fields]
  json.object(fields)
}

pub fn potatoallergyintolerance_onset_to_json(
  value: PotatoallergyintoleranceOnset,
) -> Json {
  case value {
    PotatoallergyintoleranceOnsetDatetime(value) -> pt.datetime_to_json(value)
    PotatoallergyintoleranceOnsetAge(value) -> ct.potatoage_to_json(value)
    PotatoallergyintoleranceOnsetPeriod(value) -> ct.potatoperiod_to_json(value)
    PotatoallergyintoleranceOnsetRange(value) -> ct.potatorange_to_json(value)
    PotatoallergyintoleranceOnsetString(value) -> json.string(value)
  }
}

pub fn potatoallergyintolerance_reaction_to_json(
  potatoallergyintolerance_reaction: PotatoallergyintoleranceReaction,
) -> Json {
  let fields = [
    #(
      "manifestation",
      list1_to_json(
        potatoallergyintolerance_reaction.manifestation,
        ct.potatocodeableconcept_to_json,
      ),
    ),
  ]
  let fields = case potatoallergyintolerance_reaction.substance {
    Some(v) -> [#("substance", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance_reaction.severity {
    Some(v) -> [
      #("severity", valuesets.reactioneventseverity_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance_reaction.onset {
    Some(v) -> [#("onset", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance_reaction.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potatoallergyintolerance_reaction.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoallergyintolerance_reaction.exposure_route {
    Some(v) -> [
      #("exposureRoute", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoallergyintolerance_reaction.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoappointment {
  Potatoappointment(
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
    participant: List1(PotatoappointmentParticipant),
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
    status: valuesets.Appointmentstatus,
    supporting_information: List(ct.Potatoreference),
    text: Option(ct.Potatonarrative),
  )
}

pub fn potatoappointment_new(
  participant participant: List1(PotatoappointmentParticipant),
  status status: valuesets.Appointmentstatus,
) -> Potatoappointment {
  Potatoappointment(
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

pub type PotatoappointmentParticipant {
  PotatoappointmentParticipant(
    actor: Option(ct.Potatoreference),
    id: Option(String),
    period: Option(ct.Potatoperiod),
    required: Option(valuesets.Participantrequired),
    status: valuesets.Participationstatus,
    type_: List(ct.Potatocodeableconcept),
  )
}

pub fn potatoappointment_participant_new(
  status status: valuesets.Participationstatus,
) -> PotatoappointmentParticipant {
  PotatoappointmentParticipant(
    actor: None,
    id: None,
    period: None,
    required: None,
    status:,
    type_: [],
  )
}

pub fn potatoappointment_to_json(potatoappointment: Potatoappointment) -> Json {
  let fields = [
    #("status", valuesets.appointmentstatus_to_json(potatoappointment.status)),
    #(
      "participant",
      list1_to_json(
        potatoappointment.participant,
        potatoappointment_participant_to_json,
      ),
    ),
  ]
  let fields = case potatoappointment.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.supporting_information {
    [] -> fields
    values -> [
      #("supportingInformation", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.start {
    Some(v) -> [#("start", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.specialty {
    [] -> fields
    values -> [
      #("specialty", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.slot {
    [] -> fields
    values -> [
      #("slot", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.service_type {
    [] -> fields
    values -> [
      #("serviceType", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.service_category {
    [] -> fields
    values -> [
      #("serviceCategory", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.requested_period {
    [] -> fields
    values -> [
      #("requestedPeriod", json.array(values, ct.potatoperiod_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.priority {
    Some(v) -> [#("priority", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.patient_instruction {
    Some(v) -> [#("patientInstruction", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.minutes_duration {
    Some(v) -> [#("minutesDuration", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.end {
    Some(v) -> [#("end", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.created {
    Some(v) -> [#("created", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatoappointment.comment {
    Some(v) -> [#("comment", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment.cancelation_reason {
    Some(v) -> [
      #("cancelationReason", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoappointment.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment.appointment_type {
    Some(v) -> [
      #("appointmentType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Appointment")), ..fields]
  json.object(fields)
}

pub fn potatoappointment_participant_to_json(
  potatoappointment_participant: PotatoappointmentParticipant,
) -> Json {
  let fields = [
    #(
      "status",
      valuesets.participationstatus_to_json(
        potatoappointment_participant.status,
      ),
    ),
  ]
  let fields = case potatoappointment_participant.type_ {
    [] -> fields
    values -> [
      #("type", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoappointment_participant.required {
    Some(v) -> [
      #("required", valuesets.participantrequired_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoappointment_participant.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment_participant.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoappointment_participant.actor {
    Some(v) -> [#("actor", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatocondition {
  Potatocondition(
    abatement: Option(PotatoconditionAbatement),
    asserter: Option(ct.Potatoreference),
    body_site: List(ct.Potatocodeableconcept),
    category: List(ct.Potatocodeableconcept),
    screening_assessment: List(
      ct.CodeableconceptPotatoconditionCategoryScreeningAssessment,
    ),
    us_core: List1(ct.CodeableconceptPotatoconditionCategoryUsCore),
    clinical_status: Option(ct.CodeableconceptPotatoconditionClinicalstatus),
    code: ct.Potatocodeableconcept,
    contained: List(Resource),
    encounter: Option(ct.Potatoreference),
    evidence: List(PotatoconditionEvidence),
    asserted_date: Option(DateTime),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    meta: Option(ct.MetaPotatoconditionMeta),
    note: List(ct.Potatoannotation),
    onset: Option(PotatoconditionOnset),
    recorded_date: Option(DateTime),
    recorder: Option(ct.Potatoreference),
    severity: Option(ct.Potatocodeableconcept),
    stage: List(PotatoconditionStage),
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
    verification_status: Option(
      ct.CodeableconceptPotatoconditionVerificationstatus,
    ),
  )
}

pub fn potatocondition_new(
  us_core us_core: List1(ct.CodeableconceptPotatoconditionCategoryUsCore),
  code code: ct.Potatocodeableconcept,
  subject subject: ct.Potatoreference,
) -> Potatocondition {
  Potatocondition(
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
      let meta = ct.meta_potatocondition_meta_new()
      ct.MetaPotatoconditionMeta(..meta, profile: [
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

pub type PotatoconditionOnset {
  PotatoconditionOnsetDatetime(value: DateTime)
  PotatoconditionOnsetAge(value: ct.Potatoage)
  PotatoconditionOnsetPeriod(value: ct.Potatoperiod)
  PotatoconditionOnsetRange(value: ct.Potatorange)
  PotatoconditionOnsetString(value: String)
}

pub type PotatoconditionAbatement {
  PotatoconditionAbatementDatetime(value: DateTime)
  PotatoconditionAbatementAge(value: ct.Potatoage)
  PotatoconditionAbatementPeriod(value: ct.Potatoperiod)
  PotatoconditionAbatementRange(value: ct.Potatorange)
  PotatoconditionAbatementString(value: String)
}

pub type PotatoconditionEvidence {
  PotatoconditionEvidence(
    code: List(ct.Potatocodeableconcept),
    detail: List(ct.Potatoreference),
    id: Option(String),
  )
}

pub fn potatocondition_evidence_new() -> PotatoconditionEvidence {
  PotatoconditionEvidence(code: [], detail: [], id: None)
}

pub type PotatoconditionStage {
  PotatoconditionStage(
    assessment: List(ct.Potatoreference),
    id: Option(String),
    summary: Option(ct.Potatocodeableconcept),
    type_: Option(ct.Potatocodeableconcept),
  )
}

pub fn potatocondition_stage_new() -> PotatoconditionStage {
  PotatoconditionStage(assessment: [], id: None, summary: None, type_: None)
}

pub fn potatocondition_to_json(potatocondition: Potatocondition) -> Json {
  let fields = [
    #("subject", ct.potatoreference_to_json(potatocondition.subject)),
    #("code", ct.potatocodeableconcept_to_json(potatocondition.code)),
  ]
  let fields = case potatocondition.verification_status {
    Some(v) -> [
      #(
        "verificationStatus",
        ct.codeableconcept_potatocondition_verificationstatus_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatocondition.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.stage {
    [] -> fields
    values -> [
      #("stage", json.array(values, potatocondition_stage_to_json)),
      ..fields
    ]
  }
  let fields = case potatocondition.severity {
    Some(v) -> [#("severity", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.recorder {
    Some(v) -> [#("recorder", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.recorded_date {
    Some(v) -> [#("recordedDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.onset {
    Some(v) -> [
      #(
        "onset"
          <> case v {
          PotatoconditionOnsetDatetime(_) -> "DateTime"
          PotatoconditionOnsetAge(_) -> "Age"
          PotatoconditionOnsetPeriod(_) -> "Period"
          PotatoconditionOnsetRange(_) -> "Range"
          PotatoconditionOnsetString(_) -> "String"
        },
        potatocondition_onset_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatocondition.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potatocondition.meta {
    Some(v) -> [#("meta", ct.meta_potatocondition_meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatocondition.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      case potatocondition.asserted_date {
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
  let fields = case potatocondition.evidence {
    [] -> fields
    values -> [
      #("evidence", json.array(values, potatocondition_evidence_to_json)),
      ..fields
    ]
  }
  let fields = case potatocondition.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatocondition.clinical_status {
    Some(v) -> [
      #(
        "clinicalStatus",
        ct.codeableconcept_potatocondition_clinicalstatus_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let slice_values =
    list.flatten([
      [
        ct.codeableconcept_potatocondition_category_us_core_to_json(
          potatocondition.us_core.first,
        ),
        ..list.map(potatocondition.us_core.rest, fn(value) {
          ct.codeableconcept_potatocondition_category_us_core_to_json(value)
        })
      ],
      list.map(potatocondition.screening_assessment, fn(value) {
        ct.codeableconcept_potatocondition_category_screening_assessment_to_json(
          value,
        )
      }),
      list.map(potatocondition.category, fn(value) {
        ct.potatocodeableconcept_to_json(value)
      }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("category", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potatocondition.body_site {
    [] -> fields
    values -> [
      #("bodySite", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatocondition.asserter {
    Some(v) -> [#("asserter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition.abatement {
    Some(v) -> [
      #(
        "abatement"
          <> case v {
          PotatoconditionAbatementDatetime(_) -> "DateTime"
          PotatoconditionAbatementAge(_) -> "Age"
          PotatoconditionAbatementPeriod(_) -> "Period"
          PotatoconditionAbatementRange(_) -> "Range"
          PotatoconditionAbatementString(_) -> "String"
        },
        potatocondition_abatement_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Condition")), ..fields]
  json.object(fields)
}

pub fn potatocondition_abatement_to_json(
  value: PotatoconditionAbatement,
) -> Json {
  case value {
    PotatoconditionAbatementDatetime(value) -> pt.datetime_to_json(value)
    PotatoconditionAbatementAge(value) -> ct.potatoage_to_json(value)
    PotatoconditionAbatementPeriod(value) -> ct.potatoperiod_to_json(value)
    PotatoconditionAbatementRange(value) -> ct.potatorange_to_json(value)
    PotatoconditionAbatementString(value) -> json.string(value)
  }
}

pub fn potatocondition_onset_to_json(value: PotatoconditionOnset) -> Json {
  case value {
    PotatoconditionOnsetDatetime(value) -> pt.datetime_to_json(value)
    PotatoconditionOnsetAge(value) -> ct.potatoage_to_json(value)
    PotatoconditionOnsetPeriod(value) -> ct.potatoperiod_to_json(value)
    PotatoconditionOnsetRange(value) -> ct.potatorange_to_json(value)
    PotatoconditionOnsetString(value) -> json.string(value)
  }
}

pub fn potatocondition_evidence_to_json(
  potatocondition_evidence: PotatoconditionEvidence,
) -> Json {
  let fields = []
  let fields = case potatocondition_evidence.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition_evidence.detail {
    [] -> fields
    values -> [
      #("detail", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatocondition_evidence.code {
    [] -> fields
    values -> [
      #("code", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  json.object(fields)
}

pub fn potatocondition_stage_to_json(
  potatocondition_stage: PotatoconditionStage,
) -> Json {
  let fields = []
  let fields = case potatocondition_stage.type_ {
    Some(v) -> [#("type", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition_stage.summary {
    Some(v) -> [#("summary", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition_stage.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatocondition_stage.assessment {
    [] -> fields
    values -> [
      #("assessment", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  json.object(fields)
}

pub type Potatodocumentreference {
  Potatodocumentreference(
    authenticator: Option(ct.Potatoreference),
    author: List(ct.Potatoreference),
    category: List1(PotatodocumentreferenceCategory),
    contained: List(Resource),
    content: List1(PotatodocumentreferenceContent),
    context: Option(PotatodocumentreferenceContext),
    custodian: Option(ct.Potatoreference),
    date: Option(Instant),
    description: Option(String),
    doc_status: Option(valuesets.Compositionstatus),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    language: Option(String),
    master_identifier: Option(ct.Potatoidentifier),
    meta: Option(ct.Potatometa),
    relates_to: List(PotatodocumentreferenceRelatesto),
    security_label: List(ct.Potatocodeableconcept),
    status: valuesets.Documentreferencestatus,
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
    type_: ct.Potatocodeableconcept,
  )
}

pub fn potatodocumentreference_new(
  category category: List1(PotatodocumentreferenceCategory),
  content content: List1(PotatodocumentreferenceContent),
  status status: valuesets.Documentreferencestatus,
  subject subject: ct.Potatoreference,
  type_ type_: ct.Potatocodeableconcept,
) -> Potatodocumentreference {
  Potatodocumentreference(
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

pub type PotatodocumentreferenceCategory {
  PotatodocumentreferenceCategoryUscore(
    value: ct.CodeableconceptPotatodocumentreferenceCategoryUscore,
  )
  PotatodocumentreferenceCategoryOpen(value: ct.Potatocodeableconcept)
}

pub type PotatodocumentreferenceContent {
  PotatodocumentreferenceContent(
    attachment: ct.AttachmentOmitExtension,
    format: Option(ct.Potatocoding),
    id: Option(String),
  )
}

pub fn potatodocumentreference_content_new(
  attachment attachment: ct.AttachmentOmitExtension,
) -> PotatodocumentreferenceContent {
  PotatodocumentreferenceContent(attachment:, format: None, id: None)
}

pub type PotatodocumentreferenceContext {
  PotatodocumentreferenceContext(
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

pub fn potatodocumentreference_context_new() -> PotatodocumentreferenceContext {
  PotatodocumentreferenceContext(
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

pub type PotatodocumentreferenceRelatesto {
  PotatodocumentreferenceRelatesto(
    code: valuesets.Documentrelationshiptype,
    id: Option(String),
    target: ct.Potatoreference,
  )
}

pub fn potatodocumentreference_relatesto_new(
  code code: valuesets.Documentrelationshiptype,
  target target: ct.Potatoreference,
) -> PotatodocumentreferenceRelatesto {
  PotatodocumentreferenceRelatesto(code:, id: None, target:)
}

pub fn potatodocumentreference_to_json(
  potatodocumentreference: Potatodocumentreference,
) -> Json {
  let fields = [
    #("type", ct.potatocodeableconcept_to_json(potatodocumentreference.type_)),
    #("subject", ct.potatoreference_to_json(potatodocumentreference.subject)),
    #(
      "status",
      valuesets.documentreferencestatus_to_json(potatodocumentreference.status),
    ),
    #(
      "content",
      list1_to_json(
        potatodocumentreference.content,
        potatodocumentreference_content_to_json,
      ),
    ),
    #(
      "category",
      list1_to_json(
        potatodocumentreference.category,
        potatodocumentreference_category_to_json,
      ),
    ),
  ]
  let fields = case potatodocumentreference.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.security_label {
    [] -> fields
    values -> [
      #("securityLabel", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatodocumentreference.relates_to {
    [] -> fields
    values -> [
      #(
        "relatesTo",
        json.array(values, potatodocumentreference_relatesto_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatodocumentreference.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.master_identifier {
    Some(v) -> [#("masterIdentifier", ct.potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatodocumentreference.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.doc_status {
    Some(v) -> [
      #("docStatus", valuesets.compositionstatus_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodocumentreference.description {
    Some(v) -> [#("description", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.date {
    Some(v) -> [#("date", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.custodian {
    Some(v) -> [#("custodian", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference.context {
    Some(v) -> [
      #("context", potatodocumentreference_context_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodocumentreference.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatodocumentreference.author {
    [] -> fields
    values -> [
      #("author", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatodocumentreference.authenticator {
    Some(v) -> [#("authenticator", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("DocumentReference")), ..fields]
  json.object(fields)
}

pub fn potatodocumentreference_category_to_json(
  value: PotatodocumentreferenceCategory,
) -> Json {
  case value {
    PotatodocumentreferenceCategoryUscore(value) ->
      ct.codeableconcept_potatodocumentreference_category_uscore_to_json(value)
    PotatodocumentreferenceCategoryOpen(value) ->
      ct.potatocodeableconcept_to_json(value)
  }
}

pub fn potatodocumentreference_content_to_json(
  potatodocumentreference_content: PotatodocumentreferenceContent,
) -> Json {
  let fields = [
    #(
      "attachment",
      ct.attachment_omit_extension_to_json(
        potatodocumentreference_content.attachment,
      ),
    ),
  ]
  let fields = case potatodocumentreference_content.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference_content.format {
    Some(v) -> [#("format", ct.potatocoding_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatodocumentreference_context_to_json(
  potatodocumentreference_context: PotatodocumentreferenceContext,
) -> Json {
  let fields = []
  let fields = case potatodocumentreference_context.source_patient_info {
    Some(v) -> [#("sourcePatientInfo", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference_context.related {
    [] -> fields
    values -> [
      #("related", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatodocumentreference_context.practice_setting {
    Some(v) -> [
      #("practiceSetting", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodocumentreference_context.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference_context.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatodocumentreference_context.facility_type {
    Some(v) -> [
      #("facilityType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatodocumentreference_context.event {
    [] -> fields
    values -> [
      #("event", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatodocumentreference_context.encounter {
    Some(v) -> [
      #("encounter", json.array([v], ct.potatoreference_to_json)),
      ..fields
    ]
    None -> fields
  }
  json.object(fields)
}

pub fn potatodocumentreference_relatesto_to_json(
  potatodocumentreference_relatesto: PotatodocumentreferenceRelatesto,
) -> Json {
  let fields = [
    #(
      "target",
      ct.potatoreference_to_json(potatodocumentreference_relatesto.target),
    ),
    #(
      "code",
      valuesets.documentrelationshiptype_to_json(
        potatodocumentreference_relatesto.code,
      ),
    ),
  ]
  let fields = case potatodocumentreference_relatesto.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoencounter {
  Potatoencounter(
    account: List(ct.Potatoreference),
    appointment: List(ct.Potatoreference),
    based_on: List(ct.Potatoreference),
    class: ct.Potatocoding,
    class_history: List(PotatoencounterClasshistory),
    contained: List(Resource),
    diagnosis: List(PotatoencounterDiagnosis),
    episode_of_care: List(ct.Potatoreference),
    hospitalization: Option(PotatoencounterHospitalization),
    id: Option(String),
    identifier: List(ct.IdentifierPotatoencounterIdentifier),
    implicit_rules: Option(String),
    language: Option(String),
    length: Option(ct.Potatoduration),
    location: List(PotatoencounterLocation),
    meta: Option(ct.MetaPotatoencounterMeta),
    part_of: Option(ct.Potatoreference),
    participant: List(PotatoencounterParticipant),
    period: Option(ct.Potatoperiod),
    priority: Option(ct.Potatocodeableconcept),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    service_provider: Option(ct.Potatoreference),
    service_type: Option(ct.Potatocodeableconcept),
    status: valuesets.Encounterstatus,
    status_history: List(PotatoencounterStatushistory),
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
    type_: List1(ct.Potatocodeableconcept),
  )
}

pub fn potatoencounter_new(
  class class: ct.Potatocoding,
  status status: valuesets.Encounterstatus,
  subject subject: ct.Potatoreference,
  type_ type_: List1(ct.Potatocodeableconcept),
) -> Potatoencounter {
  Potatoencounter(
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
      let meta = ct.meta_potatoencounter_meta_new()
      ct.MetaPotatoencounterMeta(..meta, profile: [
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

pub type PotatoencounterClasshistory {
  PotatoencounterClasshistory(
    class: ct.Potatocoding,
    id: Option(String),
    period: ct.Potatoperiod,
  )
}

pub fn potatoencounter_classhistory_new(
  class class: ct.Potatocoding,
  period period: ct.Potatoperiod,
) -> PotatoencounterClasshistory {
  PotatoencounterClasshistory(class:, id: None, period:)
}

pub type PotatoencounterDiagnosis {
  PotatoencounterDiagnosis(
    condition: ct.Potatoreference,
    id: Option(String),
    rank: Option(Int),
    use_: Option(ct.Potatocodeableconcept),
  )
}

pub fn potatoencounter_diagnosis_new(
  condition condition: ct.Potatoreference,
) -> PotatoencounterDiagnosis {
  PotatoencounterDiagnosis(condition:, id: None, rank: None, use_: None)
}

pub type PotatoencounterHospitalization {
  PotatoencounterHospitalization(
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

pub fn potatoencounter_hospitalization_new() -> PotatoencounterHospitalization {
  PotatoencounterHospitalization(
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

pub type PotatoencounterLocation {
  PotatoencounterLocation(
    id: Option(String),
    location: ct.Potatoreference,
    period: Option(ct.Potatoperiod),
    physical_type: Option(ct.Potatocodeableconcept),
    status: Option(valuesets.Encounterlocationstatus),
  )
}

pub fn potatoencounter_location_new(
  location location: ct.Potatoreference,
) -> PotatoencounterLocation {
  PotatoencounterLocation(
    id: None,
    location:,
    period: None,
    physical_type: None,
    status: None,
  )
}

pub type PotatoencounterParticipant {
  PotatoencounterParticipant(
    id: Option(String),
    individual: Option(ct.Potatoreference),
    period: Option(ct.Potatoperiod),
    type_: List(ct.Potatocodeableconcept),
  )
}

pub fn potatoencounter_participant_new() -> PotatoencounterParticipant {
  PotatoencounterParticipant(
    id: None,
    individual: None,
    period: None,
    type_: [],
  )
}

pub type PotatoencounterStatushistory {
  PotatoencounterStatushistory(
    id: Option(String),
    period: ct.Potatoperiod,
    status: valuesets.Encounterstatus,
  )
}

pub fn potatoencounter_statushistory_new(
  period period: ct.Potatoperiod,
  status status: valuesets.Encounterstatus,
) -> PotatoencounterStatushistory {
  PotatoencounterStatushistory(id: None, period:, status:)
}

pub fn potatoencounter_to_json(potatoencounter: Potatoencounter) -> Json {
  let fields = [
    #(
      "type",
      list1_to_json(potatoencounter.type_, ct.potatocodeableconcept_to_json),
    ),
    #("subject", ct.potatoreference_to_json(potatoencounter.subject)),
    #("status", valuesets.encounterstatus_to_json(potatoencounter.status)),
    #("class", ct.potatocoding_to_json(potatoencounter.class)),
  ]
  let fields = case potatoencounter.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.status_history {
    [] -> fields
    values -> [
      #(
        "statusHistory",
        json.array(values, potatoencounter_statushistory_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoencounter.service_type {
    Some(v) -> [#("serviceType", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.service_provider {
    Some(v) -> [#("serviceProvider", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.priority {
    Some(v) -> [#("priority", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.participant {
    [] -> fields
    values -> [
      #("participant", json.array(values, potatoencounter_participant_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.part_of {
    Some(v) -> [#("partOf", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.meta {
    Some(v) -> [#("meta", ct.meta_potatoencounter_meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.location {
    [] -> fields
    values -> [
      #("location", json.array(values, potatoencounter_location_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.length {
    Some(v) -> [#("length", ct.potatoduration_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.identifier {
    [] -> fields
    values -> [
      #(
        "identifier",
        json.array(values, ct.identifier_potatoencounter_identifier_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoencounter.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter.hospitalization {
    Some(v) -> [
      #("hospitalization", potatoencounter_hospitalization_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoencounter.episode_of_care {
    [] -> fields
    values -> [
      #("episodeOfCare", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.diagnosis {
    [] -> fields
    values -> [
      #("diagnosis", json.array(values, potatoencounter_diagnosis_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatoencounter.class_history {
    [] -> fields
    values -> [
      #(
        "classHistory",
        json.array(values, potatoencounter_classhistory_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoencounter.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.appointment {
    [] -> fields
    values -> [
      #("appointment", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter.account {
    [] -> fields
    values -> [
      #("account", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = [#("resourceType", json.string("Encounter")), ..fields]
  json.object(fields)
}

pub fn potatoencounter_classhistory_to_json(
  potatoencounter_classhistory: PotatoencounterClasshistory,
) -> Json {
  let fields = [
    #("period", ct.potatoperiod_to_json(potatoencounter_classhistory.period)),
    #("class", ct.potatocoding_to_json(potatoencounter_classhistory.class)),
  ]
  let fields = case potatoencounter_classhistory.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoencounter_diagnosis_to_json(
  potatoencounter_diagnosis: PotatoencounterDiagnosis,
) -> Json {
  let fields = [
    #(
      "condition",
      ct.potatoreference_to_json(potatoencounter_diagnosis.condition),
    ),
  ]
  let fields = case potatoencounter_diagnosis.use_ {
    Some(v) -> [#("use", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_diagnosis.rank {
    Some(v) -> [#("rank", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_diagnosis.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoencounter_hospitalization_to_json(
  potatoencounter_hospitalization: PotatoencounterHospitalization,
) -> Json {
  let fields = []
  let fields = case potatoencounter_hospitalization.special_courtesy {
    [] -> fields
    values -> [
      #("specialCourtesy", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter_hospitalization.special_arrangement {
    [] -> fields
    values -> [
      #(
        "specialArrangement",
        json.array(values, ct.potatocodeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoencounter_hospitalization.re_admission {
    Some(v) -> [#("reAdmission", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_hospitalization.pre_admission_identifier {
    Some(v) -> [
      #("preAdmissionIdentifier", ct.potatoidentifier_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoencounter_hospitalization.origin {
    Some(v) -> [#("origin", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_hospitalization.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_hospitalization.discharge_disposition {
    Some(v) -> [
      #("dischargeDisposition", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoencounter_hospitalization.diet_preference {
    [] -> fields
    values -> [
      #("dietPreference", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter_hospitalization.destination {
    Some(v) -> [#("destination", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_hospitalization.admit_source {
    Some(v) -> [#("admitSource", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoencounter_location_to_json(
  potatoencounter_location: PotatoencounterLocation,
) -> Json {
  let fields = [
    #("location", ct.potatoreference_to_json(potatoencounter_location.location)),
  ]
  let fields = case potatoencounter_location.status {
    Some(v) -> [
      #("status", valuesets.encounterlocationstatus_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoencounter_location.physical_type {
    Some(v) -> [
      #("physicalType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoencounter_location.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_location.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoencounter_participant_to_json(
  potatoencounter_participant: PotatoencounterParticipant,
) -> Json {
  let fields = []
  let fields = case potatoencounter_participant.type_ {
    [] -> fields
    values -> [
      #("type", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoencounter_participant.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_participant.individual {
    Some(v) -> [#("individual", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoencounter_participant.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoencounter_statushistory_to_json(
  potatoencounter_statushistory: PotatoencounterStatushistory,
) -> Json {
  let fields = [
    #(
      "status",
      valuesets.encounterstatus_to_json(potatoencounter_statushistory.status),
    ),
    #("period", ct.potatoperiod_to_json(potatoencounter_statushistory.period)),
  ]
  let fields = case potatoencounter_statushistory.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatoimmunization {
  Potatoimmunization(
    contained: List(Resource),
    dose_quantity: Option(ct.Potatosimplequantity),
    education: List(PotatoimmunizationEducation),
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
    occurrence: PotatoimmunizationOccurrence,
    patient: ct.Potatoreference,
    performer: List(PotatoimmunizationPerformer),
    primary_source: Option(Bool),
    program_eligibility: List(ct.Potatocodeableconcept),
    protocol_applied: List(PotatoimmunizationProtocolapplied),
    reaction: List(PotatoimmunizationReaction),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    recorded: Option(DateTime),
    report_origin: Option(ct.Potatocodeableconcept),
    route: Option(ct.Potatocodeableconcept),
    site: Option(ct.Potatocodeableconcept),
    status: valuesets.Immunizationstatus,
    status_reason: Option(ct.Potatocodeableconcept),
    subpotent_reason: List(ct.Potatocodeableconcept),
    text: Option(ct.Potatonarrative),
    vaccine_code: ct.Potatocodeableconcept,
  )
}

pub fn potatoimmunization_new(
  occurrence occurrence: PotatoimmunizationOccurrence,
  patient patient: ct.Potatoreference,
  status status: valuesets.Immunizationstatus,
  vaccine_code vaccine_code: ct.Potatocodeableconcept,
) -> Potatoimmunization {
  Potatoimmunization(
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

pub type PotatoimmunizationOccurrence {
  PotatoimmunizationOccurrenceDatetime(value: DateTime)
  PotatoimmunizationOccurrenceString(value: String)
}

pub type PotatoimmunizationEducation {
  PotatoimmunizationEducation(
    document_type: Option(String),
    id: Option(String),
    presentation_date: Option(DateTime),
    publication_date: Option(DateTime),
    reference: Option(String),
  )
}

pub fn potatoimmunization_education_new() -> PotatoimmunizationEducation {
  PotatoimmunizationEducation(
    document_type: None,
    id: None,
    presentation_date: None,
    publication_date: None,
    reference: None,
  )
}

pub type PotatoimmunizationPerformer {
  PotatoimmunizationPerformer(
    actor: ct.Potatoreference,
    function: Option(ct.Potatocodeableconcept),
    id: Option(String),
  )
}

pub fn potatoimmunization_performer_new(
  actor actor: ct.Potatoreference,
) -> PotatoimmunizationPerformer {
  PotatoimmunizationPerformer(actor:, function: None, id: None)
}

pub type PotatoimmunizationProtocolapplied {
  PotatoimmunizationProtocolapplied(
    authority: Option(ct.Potatoreference),
    dose_number: PotatoimmunizationProtocolappliedDosenumber,
    id: Option(String),
    series: Option(String),
    series_doses: Option(PotatoimmunizationProtocolappliedSeriesdoses),
    target_disease: List(ct.Potatocodeableconcept),
  )
}

pub fn potatoimmunization_protocolapplied_new(
  dose_number dose_number: PotatoimmunizationProtocolappliedDosenumber,
) -> PotatoimmunizationProtocolapplied {
  PotatoimmunizationProtocolapplied(
    authority: None,
    dose_number:,
    id: None,
    series: None,
    series_doses: None,
    target_disease: [],
  )
}

pub type PotatoimmunizationProtocolappliedSeriesdoses {
  PotatoimmunizationProtocolappliedSeriesdosesPositiveint(value: Int)
  PotatoimmunizationProtocolappliedSeriesdosesString(value: String)
}

pub type PotatoimmunizationProtocolappliedDosenumber {
  PotatoimmunizationProtocolappliedDosenumberPositiveint(value: Int)
  PotatoimmunizationProtocolappliedDosenumberString(value: String)
}

pub type PotatoimmunizationReaction {
  PotatoimmunizationReaction(
    date: Option(DateTime),
    detail: Option(ct.Potatoreference),
    id: Option(String),
    reported: Option(Bool),
  )
}

pub fn potatoimmunization_reaction_new() -> PotatoimmunizationReaction {
  PotatoimmunizationReaction(date: None, detail: None, id: None, reported: None)
}

pub fn potatoimmunization_to_json(
  potatoimmunization: Potatoimmunization,
) -> Json {
  let fields = [
    #(
      "vaccineCode",
      ct.potatocodeableconcept_to_json(potatoimmunization.vaccine_code),
    ),
    #("status", valuesets.immunizationstatus_to_json(potatoimmunization.status)),
    #("patient", ct.potatoreference_to_json(potatoimmunization.patient)),
    #(
      "occurrence"
        <> case potatoimmunization.occurrence {
        PotatoimmunizationOccurrenceDatetime(_) -> "DateTime"
        PotatoimmunizationOccurrenceString(_) -> "String"
      },
      potatoimmunization_occurrence_to_json(potatoimmunization.occurrence),
    ),
  ]
  let fields = case potatoimmunization.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.subpotent_reason {
    [] -> fields
    values -> [
      #("subpotentReason", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.status_reason {
    Some(v) -> [
      #("statusReason", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoimmunization.site {
    Some(v) -> [#("site", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.route {
    Some(v) -> [#("route", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.report_origin {
    Some(v) -> [
      #("reportOrigin", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoimmunization.recorded {
    Some(v) -> [#("recorded", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.reaction {
    [] -> fields
    values -> [
      #("reaction", json.array(values, potatoimmunization_reaction_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.protocol_applied {
    [] -> fields
    values -> [
      #(
        "protocolApplied",
        json.array(values, potatoimmunization_protocolapplied_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoimmunization.program_eligibility {
    [] -> fields
    values -> [
      #(
        "programEligibility",
        json.array(values, ct.potatocodeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatoimmunization.primary_source {
    Some(v) -> [#("primarySource", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.performer {
    [] -> fields
    values -> [
      #("performer", json.array(values, potatoimmunization_performer_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.manufacturer {
    Some(v) -> [#("manufacturer", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.lot_number {
    Some(v) -> [#("lotNumber", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.location {
    Some(v) -> [#("location", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.is_subpotent {
    Some(v) -> [#("isSubpotent", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.funding_source {
    Some(v) -> [
      #("fundingSource", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoimmunization.expiration_date {
    Some(v) -> [#("expirationDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.education {
    [] -> fields
    values -> [
      #("education", json.array(values, potatoimmunization_education_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization.dose_quantity {
    Some(v) -> [#("doseQuantity", ct.potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = [#("resourceType", json.string("Immunization")), ..fields]
  json.object(fields)
}

pub fn potatoimmunization_occurrence_to_json(
  value: PotatoimmunizationOccurrence,
) -> Json {
  case value {
    PotatoimmunizationOccurrenceDatetime(value) -> pt.datetime_to_json(value)
    PotatoimmunizationOccurrenceString(value) -> json.string(value)
  }
}

pub fn potatoimmunization_education_to_json(
  potatoimmunization_education: PotatoimmunizationEducation,
) -> Json {
  let fields = []
  let fields = case potatoimmunization_education.reference {
    Some(v) -> [#("reference", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_education.publication_date {
    Some(v) -> [#("publicationDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_education.presentation_date {
    Some(v) -> [#("presentationDate", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_education.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_education.document_type {
    Some(v) -> [#("documentType", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoimmunization_performer_to_json(
  potatoimmunization_performer: PotatoimmunizationPerformer,
) -> Json {
  let fields = [
    #("actor", ct.potatoreference_to_json(potatoimmunization_performer.actor)),
  ]
  let fields = case potatoimmunization_performer.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_performer.function {
    Some(v) -> [#("function", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoimmunization_protocolapplied_to_json(
  potatoimmunization_protocolapplied: PotatoimmunizationProtocolapplied,
) -> Json {
  let fields = [
    #(
      "doseNumber"
        <> case potatoimmunization_protocolapplied.dose_number {
        PotatoimmunizationProtocolappliedDosenumberPositiveint(_) ->
          "PositiveInt"
        PotatoimmunizationProtocolappliedDosenumberString(_) -> "String"
      },
      potatoimmunization_protocolapplied_dosenumber_to_json(
        potatoimmunization_protocolapplied.dose_number,
      ),
    ),
  ]
  let fields = case potatoimmunization_protocolapplied.target_disease {
    [] -> fields
    values -> [
      #("targetDisease", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatoimmunization_protocolapplied.series_doses {
    Some(v) -> [
      #(
        "seriesDoses"
          <> case v {
          PotatoimmunizationProtocolappliedSeriesdosesPositiveint(_) ->
            "PositiveInt"
          PotatoimmunizationProtocolappliedSeriesdosesString(_) -> "String"
        },
        potatoimmunization_protocolapplied_seriesdoses_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatoimmunization_protocolapplied.series {
    Some(v) -> [#("series", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_protocolapplied.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_protocolapplied.authority {
    Some(v) -> [#("authority", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoimmunization_protocolapplied_dosenumber_to_json(
  value: PotatoimmunizationProtocolappliedDosenumber,
) -> Json {
  case value {
    PotatoimmunizationProtocolappliedDosenumberPositiveint(value) ->
      json.int(value)
    PotatoimmunizationProtocolappliedDosenumberString(value) ->
      json.string(value)
  }
}

pub fn potatoimmunization_protocolapplied_seriesdoses_to_json(
  value: PotatoimmunizationProtocolappliedSeriesdoses,
) -> Json {
  case value {
    PotatoimmunizationProtocolappliedSeriesdosesPositiveint(value) ->
      json.int(value)
    PotatoimmunizationProtocolappliedSeriesdosesString(value) ->
      json.string(value)
  }
}

pub fn potatoimmunization_reaction_to_json(
  potatoimmunization_reaction: PotatoimmunizationReaction,
) -> Json {
  let fields = []
  let fields = case potatoimmunization_reaction.reported {
    Some(v) -> [#("reported", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_reaction.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_reaction.detail {
    Some(v) -> [#("detail", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatoimmunization_reaction.date {
    Some(v) -> [#("date", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub type Potatomedicationrequest {
  Potatomedicationrequest(
    authored_on: Option(DateTime),
    based_on: List(ct.Potatoreference),
    category: List(ct.Potatocodeableconcept),
    us_core: List(ct.CodeableconceptPotatomedicationrequestCategoryUsCore),
    contained: List(Resource),
    course_of_therapy_type: Option(ct.Potatocodeableconcept),
    detected_issue: List(ct.Potatoreference),
    dispense_request: Option(PotatomedicationrequestDispenserequest),
    do_not_perform: Option(Bool),
    dosage_instruction: List(ct.DosagePotatomedicationrequestDosageinstruction),
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
    intent: valuesets.Medicationrequestintent,
    language: Option(String),
    medication: PotatomedicationrequestMedication,
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    performer: Option(ct.Potatoreference),
    performer_type: Option(ct.Potatocodeableconcept),
    prior_prescription: Option(ct.Potatoreference),
    priority: Option(valuesets.Requestpriority),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    recorder: Option(ct.Potatoreference),
    reported: Option(PotatomedicationrequestReported),
    requester: Option(ct.Potatoreference),
    status: valuesets.Medicationrequeststatus,
    status_reason: Option(ct.Potatocodeableconcept),
    subject: ct.Potatoreference,
    substitution: Option(PotatomedicationrequestSubstitution),
    supporting_information: List(ct.Potatoreference),
    text: Option(ct.Potatonarrative),
  )
}

pub fn potatomedicationrequest_new(
  intent intent: valuesets.Medicationrequestintent,
  medication medication: PotatomedicationrequestMedication,
  status status: valuesets.Medicationrequeststatus,
  subject subject: ct.Potatoreference,
) -> Potatomedicationrequest {
  Potatomedicationrequest(
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

pub type PotatomedicationrequestReported {
  PotatomedicationrequestReportedBoolean(value: Bool)
  PotatomedicationrequestReportedReference(value: ct.Potatoreference)
}

pub type PotatomedicationrequestMedication {
  PotatomedicationrequestMedicationCodeableconcept(
    value: ct.Potatocodeableconcept,
  )
  PotatomedicationrequestMedicationReference(value: ct.Potatoreference)
}

pub type PotatomedicationrequestDispenserequest {
  PotatomedicationrequestDispenserequest(
    dispense_interval: Option(ct.Potatoduration),
    expected_supply_duration: Option(ct.Potatoduration),
    id: Option(String),
    initial_fill: Option(PotatomedicationrequestDispenserequestInitialfill),
    number_of_repeats_allowed: Option(Int),
    performer: Option(ct.Potatoreference),
    quantity: Option(ct.Potatosimplequantity),
    validity_period: Option(ct.Potatoperiod),
  )
}

pub fn potatomedicationrequest_dispenserequest_new() -> PotatomedicationrequestDispenserequest {
  PotatomedicationrequestDispenserequest(
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

pub type PotatomedicationrequestDispenserequestInitialfill {
  PotatomedicationrequestDispenserequestInitialfill(
    duration: Option(ct.Potatoduration),
    id: Option(String),
    quantity: Option(ct.Potatosimplequantity),
  )
}

pub fn potatomedicationrequest_dispenserequest_initialfill_new() -> PotatomedicationrequestDispenserequestInitialfill {
  PotatomedicationrequestDispenserequestInitialfill(
    duration: None,
    id: None,
    quantity: None,
  )
}

pub type PotatomedicationrequestSubstitution {
  PotatomedicationrequestSubstitution(
    allowed: PotatomedicationrequestSubstitutionAllowed,
    id: Option(String),
    reason: Option(ct.Potatocodeableconcept),
  )
}

pub fn potatomedicationrequest_substitution_new(
  allowed allowed: PotatomedicationrequestSubstitutionAllowed,
) -> PotatomedicationrequestSubstitution {
  PotatomedicationrequestSubstitution(allowed:, id: None, reason: None)
}

pub type PotatomedicationrequestSubstitutionAllowed {
  PotatomedicationrequestSubstitutionAllowedBoolean(value: Bool)
  PotatomedicationrequestSubstitutionAllowedCodeableconcept(
    value: ct.Potatocodeableconcept,
  )
}

pub fn potatomedicationrequest_to_json(
  potatomedicationrequest: Potatomedicationrequest,
) -> Json {
  let fields = [
    #("subject", ct.potatoreference_to_json(potatomedicationrequest.subject)),
    #(
      "status",
      valuesets.medicationrequeststatus_to_json(potatomedicationrequest.status),
    ),
    #(
      "medication"
        <> case potatomedicationrequest.medication {
        PotatomedicationrequestMedicationCodeableconcept(_) -> "CodeableConcept"
        PotatomedicationrequestMedicationReference(_) -> "Reference"
      },
      potatomedicationrequest_medication_to_json(
        potatomedicationrequest.medication,
      ),
    ),
    #(
      "intent",
      valuesets.medicationrequestintent_to_json(potatomedicationrequest.intent),
    ),
  ]
  let fields = case potatomedicationrequest.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.supporting_information {
    [] -> fields
    values -> [
      #("supportingInformation", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.substitution {
    Some(v) -> [
      #("substitution", potatomedicationrequest_substitution_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest.status_reason {
    Some(v) -> [
      #("statusReason", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest.requester {
    Some(v) -> [#("requester", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.reported {
    Some(v) -> [
      #(
        "reported"
          <> case v {
          PotatomedicationrequestReportedBoolean(_) -> "Boolean"
          PotatomedicationrequestReportedReference(_) -> "Reference"
        },
        potatomedicationrequest_reported_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest.recorder {
    Some(v) -> [#("recorder", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.priority {
    Some(v) -> [#("priority", valuesets.requestpriority_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.prior_prescription {
    Some(v) -> [#("priorPrescription", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.performer_type {
    Some(v) -> [
      #("performerType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest.performer {
    Some(v) -> [#("performer", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.insurance {
    [] -> fields
    values -> [
      #("insurance", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.instantiates_uri {
    [] -> fields
    values -> [#("instantiatesUri", json.array(values, json.string)), ..fields]
  }
  let fields = case potatomedicationrequest.instantiates_canonical {
    [] -> fields
    values -> [
      #("instantiatesCanonical", json.array(values, json.string)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.group_identifier {
    Some(v) -> [#("groupIdentifier", ct.potatoidentifier_to_json(v)), ..fields]
    None -> fields
  }
  let slice_values =
    list.flatten([
      list.map(potatomedicationrequest.medication_adherence, fn(value) {
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
  let fields = case potatomedicationrequest.event_history {
    [] -> fields
    values -> [
      #("eventHistory", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.encounter {
    Some(v) -> [#("encounter", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.dosage_instruction {
    [] -> fields
    values -> [
      #(
        "dosageInstruction",
        json.array(
          values,
          ct.dosage_potatomedicationrequest_dosageinstruction_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.do_not_perform {
    Some(v) -> [#("doNotPerform", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest.dispense_request {
    Some(v) -> [
      #("dispenseRequest", potatomedicationrequest_dispenserequest_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest.detected_issue {
    [] -> fields
    values -> [
      #("detectedIssue", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.course_of_therapy_type {
    Some(v) -> [
      #("courseOfTherapyType", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let slice_values =
    list.flatten([
      list.map(potatomedicationrequest.us_core, fn(value) {
        ct.codeableconcept_potatomedicationrequest_category_us_core_to_json(
          value,
        )
      }),
      list.map(potatomedicationrequest.category, fn(value) {
        ct.potatocodeableconcept_to_json(value)
      }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("category", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potatomedicationrequest.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationrequest.authored_on {
    Some(v) -> [#("authoredOn", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("MedicationRequest")), ..fields]
  json.object(fields)
}

pub fn potatomedicationrequest_medication_to_json(
  value: PotatomedicationrequestMedication,
) -> Json {
  case value {
    PotatomedicationrequestMedicationCodeableconcept(value) ->
      ct.potatocodeableconcept_to_json(value)
    PotatomedicationrequestMedicationReference(value) ->
      ct.potatoreference_to_json(value)
  }
}

pub fn potatomedicationrequest_reported_to_json(
  value: PotatomedicationrequestReported,
) -> Json {
  case value {
    PotatomedicationrequestReportedBoolean(value) -> json.bool(value)
    PotatomedicationrequestReportedReference(value) ->
      ct.potatoreference_to_json(value)
  }
}

pub fn potatomedicationrequest_dispenserequest_to_json(
  potatomedicationrequest_dispenserequest: PotatomedicationrequestDispenserequest,
) -> Json {
  let fields = []
  let fields = case potatomedicationrequest_dispenserequest.validity_period {
    Some(v) -> [#("validityPeriod", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest_dispenserequest.quantity {
    Some(v) -> [#("quantity", ct.potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest_dispenserequest.performer {
    Some(v) -> [#("performer", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case
    potatomedicationrequest_dispenserequest.number_of_repeats_allowed
  {
    Some(v) -> [#("numberOfRepeatsAllowed", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest_dispenserequest.initial_fill {
    Some(v) -> [
      #(
        "initialFill",
        potatomedicationrequest_dispenserequest_initialfill_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest_dispenserequest.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    potatomedicationrequest_dispenserequest.expected_supply_duration
  {
    Some(v) -> [
      #("expectedSupplyDuration", ct.potatoduration_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationrequest_dispenserequest.dispense_interval {
    Some(v) -> [#("dispenseInterval", ct.potatoduration_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatomedicationrequest_dispenserequest_initialfill_to_json(
  potatomedicationrequest_dispenserequest_initialfill: PotatomedicationrequestDispenserequestInitialfill,
) -> Json {
  let fields = []
  let fields = case
    potatomedicationrequest_dispenserequest_initialfill.quantity
  {
    Some(v) -> [#("quantity", ct.potatosimplequantity_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest_dispenserequest_initialfill.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case
    potatomedicationrequest_dispenserequest_initialfill.duration
  {
    Some(v) -> [#("duration", ct.potatoduration_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatomedicationrequest_substitution_to_json(
  potatomedicationrequest_substitution: PotatomedicationrequestSubstitution,
) -> Json {
  let fields = [
    #(
      "allowed"
        <> case potatomedicationrequest_substitution.allowed {
        PotatomedicationrequestSubstitutionAllowedBoolean(_) -> "Boolean"
        PotatomedicationrequestSubstitutionAllowedCodeableconcept(_) ->
          "CodeableConcept"
      },
      potatomedicationrequest_substitution_allowed_to_json(
        potatomedicationrequest_substitution.allowed,
      ),
    ),
  ]
  let fields = case potatomedicationrequest_substitution.reason {
    Some(v) -> [#("reason", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationrequest_substitution.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatomedicationrequest_substitution_allowed_to_json(
  value: PotatomedicationrequestSubstitutionAllowed,
) -> Json {
  case value {
    PotatomedicationrequestSubstitutionAllowedBoolean(value) -> json.bool(value)
    PotatomedicationrequestSubstitutionAllowedCodeableconcept(value) ->
      ct.potatocodeableconcept_to_json(value)
  }
}

pub type Potatomedicationstatement {
  Potatomedicationstatement(
    based_on: List(ct.Potatoreference),
    category: Option(ct.Potatocodeableconcept),
    contained: List(Resource),
    context: Option(ct.Potatoreference),
    date_asserted: Option(DateTime),
    derived_from: List(ct.Potatoreference),
    dosage: List(ct.Potatodosage),
    effective: Option(PotatomedicationstatementEffective),
    id: Option(String),
    identifier: List(ct.Potatoidentifier),
    implicit_rules: Option(String),
    information_source: Option(ct.Potatoreference),
    language: Option(String),
    medication: PotatomedicationstatementMedication,
    meta: Option(ct.Potatometa),
    note: List(ct.Potatoannotation),
    part_of: List(ct.Potatoreference),
    reason_code: List(ct.Potatocodeableconcept),
    reason_reference: List(ct.Potatoreference),
    status: valuesets.Medicationstatementstatus,
    status_reason: List(ct.Potatocodeableconcept),
    subject: ct.Potatoreference,
    text: Option(ct.Potatonarrative),
  )
}

pub fn potatomedicationstatement_new(
  medication medication: PotatomedicationstatementMedication,
  status status: valuesets.Medicationstatementstatus,
  subject subject: ct.Potatoreference,
) -> Potatomedicationstatement {
  Potatomedicationstatement(
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

pub type PotatomedicationstatementMedication {
  PotatomedicationstatementMedicationCodeableconcept(
    value: ct.Potatocodeableconcept,
  )
  PotatomedicationstatementMedicationReference(value: ct.Potatoreference)
}

pub type PotatomedicationstatementEffective {
  PotatomedicationstatementEffectiveDatetime(value: DateTime)
  PotatomedicationstatementEffectivePeriod(value: ct.Potatoperiod)
}

pub fn potatomedicationstatement_to_json(
  potatomedicationstatement: Potatomedicationstatement,
) -> Json {
  let fields = [
    #("subject", ct.potatoreference_to_json(potatomedicationstatement.subject)),
    #(
      "status",
      valuesets.medicationstatementstatus_to_json(
        potatomedicationstatement.status,
      ),
    ),
    #(
      "medication"
        <> case potatomedicationstatement.medication {
        PotatomedicationstatementMedicationCodeableconcept(_) ->
          "CodeableConcept"
        PotatomedicationstatementMedicationReference(_) -> "Reference"
      },
      potatomedicationstatement_medication_to_json(
        potatomedicationstatement.medication,
      ),
    ),
  ]
  let fields = case potatomedicationstatement.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.status_reason {
    [] -> fields
    values -> [
      #("statusReason", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.reason_reference {
    [] -> fields
    values -> [
      #("reasonReference", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.reason_code {
    [] -> fields
    values -> [
      #("reasonCode", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.part_of {
    [] -> fields
    values -> [
      #("partOf", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.note {
    [] -> fields
    values -> [
      #("note", json.array(values, ct.potatoannotation_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.information_source {
    Some(v) -> [#("informationSource", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.potatoidentifier_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.effective {
    Some(v) -> [
      #(
        "effective"
          <> case v {
          PotatomedicationstatementEffectiveDatetime(_) -> "DateTime"
          PotatomedicationstatementEffectivePeriod(_) -> "Period"
        },
        potatomedicationstatement_effective_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatomedicationstatement.dosage {
    [] -> fields
    values -> [
      #("dosage", json.array(values, ct.potatodosage_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.derived_from {
    [] -> fields
    values -> [
      #("derivedFrom", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = case potatomedicationstatement.date_asserted {
    Some(v) -> [#("dateAsserted", pt.datetime_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.context {
    Some(v) -> [#("context", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatomedicationstatement.category {
    Some(v) -> [#("category", ct.potatocodeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatomedicationstatement.based_on {
    [] -> fields
    values -> [
      #("basedOn", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let fields = [#("resourceType", json.string("MedicationStatement")), ..fields]
  json.object(fields)
}

pub fn potatomedicationstatement_effective_to_json(
  value: PotatomedicationstatementEffective,
) -> Json {
  case value {
    PotatomedicationstatementEffectiveDatetime(value) ->
      pt.datetime_to_json(value)
    PotatomedicationstatementEffectivePeriod(value) ->
      ct.potatoperiod_to_json(value)
  }
}

pub fn potatomedicationstatement_medication_to_json(
  value: PotatomedicationstatementMedication,
) -> Json {
  case value {
    PotatomedicationstatementMedicationCodeableconcept(value) ->
      ct.potatocodeableconcept_to_json(value)
    PotatomedicationstatementMedicationReference(value) ->
      ct.potatoreference_to_json(value)
  }
}

pub type Potatopatient {
  Potatopatient(
    active: Option(Bool),
    address: List(ct.AddressPotatopatientAddress),
    birth_date: Option(Date),
    communication: List(PotatopatientCommunication),
    contact: List(PotatopatientContact),
    contained: List(Resource),
    deceased: Option(PotatopatientDeceased),
    birthsex: Option(valuesets.Two16840111376214102124),
    ethnicity: Option(ct.Potatoethnicity),
    gender_identity: List(ct.Potatocodeableconcept),
    race: Option(ct.Potatorace),
    sex: Option(String),
    tribal_affiliation: List(ct.Potatotribalaffiliation),
    gender: valuesets.Administrativegender,
    general_practitioner: List(ct.Potatoreference),
    id: Option(String),
    identifier: List1(ct.IdentifierPotatopatientIdentifier),
    implicit_rules: Option(String),
    language: Option(String),
    link: List(PotatopatientLink),
    managing_organization: Option(ct.Potatoreference),
    marital_status: Option(ct.Potatocodeableconcept),
    meta: Option(ct.Potatometa),
    multiple_birth: Option(PotatopatientMultiplebirth),
    name: List1(ct.HumannamePotatopatientName),
    photo: List(ct.Potatoattachment),
    telecom: List(ct.ContactpointPotatopatientTelecom),
    text: Option(ct.Potatonarrative),
  )
}

pub fn potatopatient_new(
  gender gender: valuesets.Administrativegender,
  identifier identifier: List1(ct.IdentifierPotatopatientIdentifier),
  name name: List1(ct.HumannamePotatopatientName),
) -> Potatopatient {
  Potatopatient(
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

pub type PotatopatientMultiplebirth {
  PotatopatientMultiplebirthBoolean(value: Bool)
  PotatopatientMultiplebirthInteger(value: Int)
}

pub type PotatopatientDeceased {
  PotatopatientDeceasedBoolean(value: Bool)
  PotatopatientDeceasedDatetime(value: DateTime)
}

pub type PotatopatientCommunication {
  PotatopatientCommunication(
    id: Option(String),
    language: ct.Potatocodeableconcept,
    preferred: Option(Bool),
  )
}

pub fn potatopatient_communication_new(
  language language: ct.Potatocodeableconcept,
) -> PotatopatientCommunication {
  PotatopatientCommunication(id: None, language:, preferred: None)
}

pub type PotatopatientContact {
  PotatopatientContact(
    address: Option(ct.Potatoaddress),
    gender: Option(valuesets.Administrativegender),
    id: Option(String),
    name: Option(ct.Potatohumanname),
    organization: Option(ct.Potatoreference),
    period: Option(ct.Potatoperiod),
    relationship: List(ct.Potatocodeableconcept),
    telecom: List(ct.Potatocontactpoint),
  )
}

pub fn potatopatient_contact_new() -> PotatopatientContact {
  PotatopatientContact(
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

pub type PotatopatientLink {
  PotatopatientLink(
    id: Option(String),
    other: ct.Potatoreference,
    type_: valuesets.Linktype,
  )
}

pub fn potatopatient_link_new(
  other other: ct.Potatoreference,
  type_ type_: valuesets.Linktype,
) -> PotatopatientLink {
  PotatopatientLink(id: None, other:, type_:)
}

pub fn potatopatient_to_json(potatopatient: Potatopatient) -> Json {
  let fields = [
    #(
      "name",
      list1_to_json(potatopatient.name, ct.humanname_potatopatient_name_to_json),
    ),
    #(
      "identifier",
      list1_to_json(
        potatopatient.identifier,
        ct.identifier_potatopatient_identifier_to_json,
      ),
    ),
    #("gender", valuesets.administrativegender_to_json(potatopatient.gender)),
  ]
  let fields = case potatopatient.text {
    Some(v) -> [#("text", ct.potatonarrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient.telecom {
    [] -> fields
    values -> [
      #(
        "telecom",
        json.array(values, ct.contactpoint_potatopatient_telecom_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatopatient.photo {
    [] -> fields
    values -> [
      #("photo", json.array(values, ct.potatoattachment_to_json)),
      ..fields
    ]
  }
  let fields = case potatopatient.multiple_birth {
    Some(v) -> [
      #(
        "multipleBirth"
          <> case v {
          PotatopatientMultiplebirthBoolean(_) -> "Boolean"
          PotatopatientMultiplebirthInteger(_) -> "Integer"
        },
        potatopatient_multiplebirth_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatopatient.meta {
    Some(v) -> [#("meta", ct.potatometa_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient.marital_status {
    Some(v) -> [
      #("maritalStatus", ct.potatocodeableconcept_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatopatient.managing_organization {
    Some(v) -> [
      #("managingOrganization", ct.potatoreference_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatopatient.link {
    [] -> fields
    values -> [
      #("link", json.array(values, potatopatient_link_to_json)),
      ..fields
    ]
  }
  let fields = case potatopatient.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient.general_practitioner {
    [] -> fields
    values -> [
      #("generalPractitioner", json.array(values, ct.potatoreference_to_json)),
      ..fields
    ]
  }
  let slice_values =
    list.flatten([
      list.map(potatopatient.tribal_affiliation, fn(value) {
        ct.potatotribalaffiliation_to_json(
          value,
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation",
        )
      }),
      case potatopatient.sex {
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
      case potatopatient.race {
        Some(value) -> [
          ct.potatorace_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race",
          ),
        ]
        None -> []
      },
      list.map(potatopatient.gender_identity, fn(value) {
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
      case potatopatient.ethnicity {
        Some(value) -> [
          ct.potatoethnicity_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity",
          ),
        ]
        None -> []
      },
      case potatopatient.birthsex {
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
      [],
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("extension", json.preprocessed_array(values)), ..fields]
  }
  let fields = case potatopatient.deceased {
    Some(v) -> [
      #(
        "deceased"
          <> case v {
          PotatopatientDeceasedBoolean(_) -> "Boolean"
          PotatopatientDeceasedDatetime(_) -> "DateTime"
        },
        potatopatient_deceased_to_json(v),
      ),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatopatient.contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case potatopatient.contact {
    [] -> fields
    values -> [
      #("contact", json.array(values, potatopatient_contact_to_json)),
      ..fields
    ]
  }
  let fields = case potatopatient.communication {
    [] -> fields
    values -> [
      #(
        "communication",
        json.array(values, potatopatient_communication_to_json),
      ),
      ..fields
    ]
  }
  let fields = case potatopatient.birth_date {
    Some(v) -> [#("birthDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient.address {
    [] -> fields
    values -> [
      #("address", json.array(values, ct.address_potatopatient_address_to_json)),
      ..fields
    ]
  }
  let fields = case potatopatient.active {
    Some(v) -> [#("active", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Patient")), ..fields]
  json.object(fields)
}

pub fn potatopatient_deceased_to_json(value: PotatopatientDeceased) -> Json {
  case value {
    PotatopatientDeceasedBoolean(value) -> json.bool(value)
    PotatopatientDeceasedDatetime(value) -> pt.datetime_to_json(value)
  }
}

pub fn potatopatient_multiplebirth_to_json(
  value: PotatopatientMultiplebirth,
) -> Json {
  case value {
    PotatopatientMultiplebirthBoolean(value) -> json.bool(value)
    PotatopatientMultiplebirthInteger(value) -> json.int(value)
  }
}

pub fn potatopatient_communication_to_json(
  potatopatient_communication: PotatopatientCommunication,
) -> Json {
  let fields = [
    #(
      "language",
      ct.potatocodeableconcept_to_json(potatopatient_communication.language),
    ),
  ]
  let fields = case potatopatient_communication.preferred {
    Some(v) -> [#("preferred", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient_communication.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatopatient_contact_to_json(
  potatopatient_contact: PotatopatientContact,
) -> Json {
  let fields = []
  let fields = case potatopatient_contact.telecom {
    [] -> fields
    values -> [
      #("telecom", json.array(values, ct.potatocontactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case potatopatient_contact.relationship {
    [] -> fields
    values -> [
      #("relationship", json.array(values, ct.potatocodeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case potatopatient_contact.period {
    Some(v) -> [#("period", ct.potatoperiod_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient_contact.organization {
    Some(v) -> [#("organization", ct.potatoreference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient_contact.name {
    Some(v) -> [#("name", ct.potatohumanname_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient_contact.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case potatopatient_contact.gender {
    Some(v) -> [
      #("gender", valuesets.administrativegender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case potatopatient_contact.address {
    Some(v) -> [#("address", ct.potatoaddress_to_json(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatopatient_link_to_json(
  potatopatient_link: PotatopatientLink,
) -> Json {
  let fields = [
    #("type", valuesets.linktype_to_json(potatopatient_link.type_)),
    #("other", ct.potatoreference_to_json(potatopatient_link.other)),
  ]
  let fields = case potatopatient_link.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn potatoallergyintolerance_reaction_decoder() -> Decoder(
  PotatoallergyintoleranceReaction,
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
    decode.optional(valuesets.reactioneventseverity_decoder()),
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
    PotatoallergyintoleranceReaction(
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

pub fn potatoallergyintolerance_onset_decoder() -> Decoder(
  PotatoallergyintoleranceOnset,
) {
  decode.one_of(
    {
      use value <- decode.field("onsetDateTime", pt.datetime_decoder())
      decode.success(PotatoallergyintoleranceOnsetDatetime(value))
    },
    [
      {
        use value <- decode.field("onsetAge", ct.potatoage_decoder())
        decode.success(PotatoallergyintoleranceOnsetAge(value))
      },
      {
        use value <- decode.field("onsetPeriod", ct.potatoperiod_decoder())
        decode.success(PotatoallergyintoleranceOnsetPeriod(value))
      },
      {
        use value <- decode.field("onsetRange", ct.potatorange_decoder())
        decode.success(PotatoallergyintoleranceOnsetRange(value))
      },
      {
        use value <- decode.field("onsetString", decode.string)
        decode.success(PotatoallergyintoleranceOnsetString(value))
      },
    ],
  )
}

pub fn potatoallergyintolerance_decoder() -> Decoder(Potatoallergyintolerance) {
  use <- decode.recursive
  use verification_status <- decode.optional_field(
    "verificationStatus",
    None,
    decode.optional(
      ct.codeableconcept_potatoallergyintolerance_verificationstatus_decoder(),
    ),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(valuesets.allergyintolerancetype_decoder()),
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
    decode.list(potatoallergyintolerance_reaction_decoder()),
  )
  use patient <- decode.field("patient", ct.potatoreference_decoder())
  use onset <- decode.then(
    none_if_omitted(potatoallergyintolerance_onset_decoder()),
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
    decode.optional(valuesets.allergyintolerancecriticality_decoder()),
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
      ct.codeableconcept_potatoallergyintolerance_clinicalstatus_decoder(),
    ),
  )
  use category <- decode.optional_field(
    "category",
    [],
    decode.list(valuesets.allergyintolerancecategory_decoder()),
  )
  use asserter <- decode.optional_field(
    "asserter",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  let placeholder =
    Potatoallergyintolerance(
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

pub fn potatoappointment_participant_decoder() -> Decoder(
  PotatoappointmentParticipant,
) {
  use <- decode.recursive
  use type_ <- decode.optional_field(
    "type",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use status <- decode.field("status", valuesets.participationstatus_decoder())
  use required <- decode.optional_field(
    "required",
    None,
    decode.optional(valuesets.participantrequired_decoder()),
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
    PotatoappointmentParticipant(
      type_:,
      status:,
      required:,
      period:,
      id:,
      actor:,
    )
  decode.success(placeholder)
}

pub fn potatoappointment_decoder() -> Decoder(Potatoappointment) {
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
  use status <- decode.field("status", valuesets.appointmentstatus_decoder())
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
    potatoappointment_participant_decoder(),
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
    Potatoappointment(
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

type PotatoconditionExtensionSliceAccumulator {
  PotatoconditionExtensionSliceAccumulator(asserted_date: Option(DateTime))
}

pub type PotatoconditionParsedExtensionSlice {
  PotatoconditionParsedExtensionSliceAsserteddate(DateTime)
  PotatoconditionParsedExtensionSliceIgnored
}

type PotatoconditionExtensionSlices {
  PotatoconditionExtensionSlices(asserted_date: Option(DateTime))
}

type PotatoconditionCategorySliceAccumulator {
  PotatoconditionCategorySliceAccumulator(
    us_core: List(ct.CodeableconceptPotatoconditionCategoryUsCore),
    screening_assessment: List(
      ct.CodeableconceptPotatoconditionCategoryScreeningAssessment,
    ),
    open: List(ct.Potatocodeableconcept),
  )
}

type PotatoconditionParsedCategorySlice {
  PotatoconditionParsedCategorySliceUsCore(
    ct.CodeableconceptPotatoconditionCategoryUsCore,
  )
  PotatoconditionParsedCategorySliceScreeningAssessment(
    ct.CodeableconceptPotatoconditionCategoryScreeningAssessment,
  )
  PotatoconditionParsedCategorySliceOpen(ct.Potatocodeableconcept)
}

type PotatoconditionCategorySlices {
  PotatoconditionCategorySlices(
    us_core: List1(ct.CodeableconceptPotatoconditionCategoryUsCore),
    screening_assessment: List(
      ct.CodeableconceptPotatoconditionCategoryScreeningAssessment,
    ),
    open: List(ct.Potatocodeableconcept),
  )
}

pub fn potatocondition_stage_decoder() -> Decoder(PotatoconditionStage) {
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
  let placeholder = PotatoconditionStage(type_:, summary:, id:, assessment:)
  decode.success(placeholder)
}

pub fn potatocondition_evidence_decoder() -> Decoder(PotatoconditionEvidence) {
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
  let placeholder = PotatoconditionEvidence(id:, detail:, code:)
  decode.success(placeholder)
}

pub fn potatocondition_onset_decoder() -> Decoder(PotatoconditionOnset) {
  decode.one_of(
    {
      use value <- decode.field("onsetDateTime", pt.datetime_decoder())
      decode.success(PotatoconditionOnsetDatetime(value))
    },
    [
      {
        use value <- decode.field("onsetAge", ct.potatoage_decoder())
        decode.success(PotatoconditionOnsetAge(value))
      },
      {
        use value <- decode.field("onsetPeriod", ct.potatoperiod_decoder())
        decode.success(PotatoconditionOnsetPeriod(value))
      },
      {
        use value <- decode.field("onsetRange", ct.potatorange_decoder())
        decode.success(PotatoconditionOnsetRange(value))
      },
      {
        use value <- decode.field("onsetString", decode.string)
        decode.success(PotatoconditionOnsetString(value))
      },
    ],
  )
}

pub fn potatocondition_extension_slice_decoder() -> Decoder(
  Result(PotatoconditionParsedExtensionSlice, String),
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
            PotatoconditionParsedExtensionSliceAsserteddate(value)
          })
        })
      _ -> decode.success(Ok(PotatoconditionParsedExtensionSliceIgnored))
    },
    decode.success,
  )
}

pub fn potatocondition_abatement_decoder() -> Decoder(PotatoconditionAbatement) {
  decode.one_of(
    {
      use value <- decode.field("abatementDateTime", pt.datetime_decoder())
      decode.success(PotatoconditionAbatementDatetime(value))
    },
    [
      {
        use value <- decode.field("abatementAge", ct.potatoage_decoder())
        decode.success(PotatoconditionAbatementAge(value))
      },
      {
        use value <- decode.field("abatementPeriod", ct.potatoperiod_decoder())
        decode.success(PotatoconditionAbatementPeriod(value))
      },
      {
        use value <- decode.field("abatementRange", ct.potatorange_decoder())
        decode.success(PotatoconditionAbatementRange(value))
      },
      {
        use value <- decode.field("abatementString", decode.string)
        decode.success(PotatoconditionAbatementString(value))
      },
    ],
  )
}

pub fn potatocondition_decoder() -> Decoder(Potatocondition) {
  use <- decode.recursive
  use verification_status <- decode.optional_field(
    "verificationStatus",
    None,
    decode.optional(
      ct.codeableconcept_potatocondition_verificationstatus_decoder(),
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
    decode.list(potatocondition_stage_decoder()),
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
  use onset <- decode.then(none_if_omitted(potatocondition_onset_decoder()))
  use note <- decode.optional_field(
    "note",
    [],
    decode.list(ct.potatoannotation_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_potatocondition_meta_decoder()),
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
    decode.list(potatocondition_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(PotatoconditionExtensionSliceAccumulator(None)),
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
                  PotatoconditionParsedExtensionSliceAsserteddate(value) ->
                    Ok(
                      PotatoconditionExtensionSliceAccumulator(
                        asserted_date: Some(value),
                      ),
                    )
                  PotatoconditionParsedExtensionSliceIgnored -> Ok(accumulator)
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(PotatoconditionExtensionSlices(
        asserted_date: accumulator.asserted_date,
      ))
    Error(errors) -> Error(errors)
  }
  use evidence <- decode.optional_field(
    "evidence",
    [],
    decode.list(potatocondition_evidence_decoder()),
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
    decode.optional(ct.codeableconcept_potatocondition_clinicalstatus_decoder()),
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
                      ct.codeableconcept_potatocondition_category_us_core_decoder(),
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
          ct.codeableconcept_potatocondition_category_us_core_decoder()
          |> decode.map(PotatoconditionParsedCategorySliceUsCore)
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
                          ct.codeableconcept_potatocondition_category_screening_assessment_decoder(),
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
              ct.codeableconcept_potatocondition_category_screening_assessment_decoder()
              |> decode.map(
                PotatoconditionParsedCategorySliceScreeningAssessment,
              )
            ct.DiscriminatorDifferent ->
              ct.potatocodeableconcept_decoder()
              |> decode.map(PotatoconditionParsedCategorySliceOpen)
          }
      }
    }),
  )
  let category_accumulator =
    list.index_fold(
      category_base_values,
      PotatoconditionCategorySliceAccumulator([], [], []),
      fn(accumulator, parsed, _index) {
        case parsed {
          PotatoconditionParsedCategorySliceUsCore(value) ->
            PotatoconditionCategorySliceAccumulator(..accumulator, us_core: [
              value,
              ..accumulator.us_core
            ])
          PotatoconditionParsedCategorySliceScreeningAssessment(value) ->
            PotatoconditionCategorySliceAccumulator(
              ..accumulator,
              screening_assessment: [value, ..accumulator.screening_assessment],
            )
          PotatoconditionParsedCategorySliceOpen(value) ->
            PotatoconditionCategorySliceAccumulator(..accumulator, open: [
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
        Ok(PotatoconditionCategorySlices(us_core:, screening_assessment:, open:))
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
    none_if_omitted(potatocondition_abatement_decoder()),
  )
  let category_slices_decoder = case category_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatoconditionCategorySlices(
          us_core: ct.List1(
            first: ct.codeableconcept_potatocondition_category_us_core_new(
              required: ct.List1(
                first: ct.codeableconcept_potatocondition_category_us_core_coding_required_new(),
                rest: [],
              ),
            ),
            rest: [],
          ),
          screening_assessment: [],
          open: [],
        ),
        "Potatocondition slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
  let extension_slices_decoder = case extension_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatoconditionExtensionSlices(None),
        "Potatocondition slices",
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
  decode.success(Potatocondition(
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

type PotatodocumentreferenceCategorySliceAccumulator {
  PotatodocumentreferenceCategorySliceAccumulator(
    values: List(PotatodocumentreferenceCategory),
  )
}

pub fn potatodocumentreference_relatesto_decoder() -> Decoder(
  PotatodocumentreferenceRelatesto,
) {
  use <- decode.recursive
  use target <- decode.field("target", ct.potatoreference_decoder())
  use id <- decode_optional_string("id")
  use code <- decode.field("code", valuesets.documentrelationshiptype_decoder())
  let placeholder = PotatodocumentreferenceRelatesto(target:, id:, code:)
  decode.success(placeholder)
}

pub fn potatodocumentreference_context_decoder() -> Decoder(
  PotatodocumentreferenceContext,
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
    PotatodocumentreferenceContext(
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

pub fn potatodocumentreference_content_decoder() -> Decoder(
  PotatodocumentreferenceContent,
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
  let placeholder = PotatodocumentreferenceContent(id:, format:, attachment:)
  decode.success(placeholder)
}

pub fn potatodocumentreference_decoder() -> Decoder(Potatodocumentreference) {
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
    valuesets.documentreferencestatus_decoder(),
  )
  use security_label <- decode.optional_field(
    "securityLabel",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use relates_to <- decode.optional_field(
    "relatesTo",
    [],
    decode.list(potatodocumentreference_relatesto_decoder()),
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
    decode.optional(valuesets.compositionstatus_decoder()),
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
    decode.optional(potatodocumentreference_context_decoder()),
  )
  use content <- list1_decoder(
    "content",
    potatodocumentreference_content_decoder(),
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
                      ct.codeableconcept_potatodocumentreference_category_uscore_decoder(),
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
          ct.codeableconcept_potatodocumentreference_category_uscore_decoder()
          |> decode.map(PotatodocumentreferenceCategoryUscore)
        ct.DiscriminatorDifferent ->
          ct.potatocodeableconcept_decoder()
          |> decode.map(PotatodocumentreferenceCategoryOpen)
      }
    }),
  )
  let category_accumulator =
    list.index_fold(
      category_base_values,
      PotatodocumentreferenceCategorySliceAccumulator([]),
      fn(accumulator, parsed, _index) {
        case parsed {
          value ->
            PotatodocumentreferenceCategorySliceAccumulator([
              value,
              ..accumulator.values
            ])
        }
      },
    )
  let category_slices = case category_accumulator {
    PotatodocumentreferenceCategorySliceAccumulator(values:) ->
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
          first: PotatodocumentreferenceCategoryOpen(
            ct.potatocodeableconcept_new(),
          ),
          rest: [],
        ),
        "Potatodocumentreference slices",
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
  decode.success(Potatodocumentreference(
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

pub fn potatoencounter_statushistory_decoder() -> Decoder(
  PotatoencounterStatushistory,
) {
  use <- decode.recursive
  use status <- decode.field("status", valuesets.encounterstatus_decoder())
  use period <- decode.field("period", ct.potatoperiod_decoder())
  use id <- decode_optional_string("id")
  let placeholder = PotatoencounterStatushistory(status:, period:, id:)
  decode.success(placeholder)
}

pub fn potatoencounter_participant_decoder() -> Decoder(
  PotatoencounterParticipant,
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
    PotatoencounterParticipant(type_:, period:, individual:, id:)
  decode.success(placeholder)
}

pub fn potatoencounter_location_decoder() -> Decoder(PotatoencounterLocation) {
  use <- decode.recursive
  use status <- decode.optional_field(
    "status",
    None,
    decode.optional(valuesets.encounterlocationstatus_decoder()),
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
    PotatoencounterLocation(status:, physical_type:, period:, location:, id:)
  decode.success(placeholder)
}

pub fn potatoencounter_hospitalization_decoder() -> Decoder(
  PotatoencounterHospitalization,
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
    PotatoencounterHospitalization(
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

pub fn potatoencounter_diagnosis_decoder() -> Decoder(PotatoencounterDiagnosis) {
  use <- decode.recursive
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use rank <- decode.optional_field("rank", None, decode.optional(decode.int))
  use id <- decode_optional_string("id")
  use condition <- decode.field("condition", ct.potatoreference_decoder())
  let placeholder = PotatoencounterDiagnosis(use_:, rank:, id:, condition:)
  decode.success(placeholder)
}

pub fn potatoencounter_classhistory_decoder() -> Decoder(
  PotatoencounterClasshistory,
) {
  use <- decode.recursive
  use period <- decode.field("period", ct.potatoperiod_decoder())
  use id <- decode_optional_string("id")
  use class <- decode.field("class", ct.potatocoding_decoder())
  let placeholder = PotatoencounterClasshistory(period:, id:, class:)
  decode.success(placeholder)
}

pub fn potatoencounter_decoder() -> Decoder(Potatoencounter) {
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
    decode.list(potatoencounter_statushistory_decoder()),
  )
  use status <- decode.field("status", valuesets.encounterstatus_decoder())
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
    decode.list(potatoencounter_participant_decoder()),
  )
  use part_of <- decode.optional_field(
    "partOf",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_potatoencounter_meta_decoder()),
  )
  use location <- decode.optional_field(
    "location",
    [],
    decode.list(potatoencounter_location_decoder()),
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
    decode.list(ct.identifier_potatoencounter_identifier_decoder()),
  )
  use id <- decode_optional_string("id")
  use hospitalization <- decode.optional_field(
    "hospitalization",
    None,
    decode.optional(potatoencounter_hospitalization_decoder()),
  )
  use episode_of_care <- decode.optional_field(
    "episodeOfCare",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use diagnosis <- decode.optional_field(
    "diagnosis",
    [],
    decode.list(potatoencounter_diagnosis_decoder()),
  )
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use class_history <- decode.optional_field(
    "classHistory",
    [],
    decode.list(potatoencounter_classhistory_decoder()),
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
    Potatoencounter(
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

pub fn potatoimmunization_reaction_decoder() -> Decoder(
  PotatoimmunizationReaction,
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
  let placeholder = PotatoimmunizationReaction(reported:, id:, detail:, date:)
  decode.success(placeholder)
}

pub fn potatoimmunization_protocolapplied_seriesdoses_decoder() -> Decoder(
  PotatoimmunizationProtocolappliedSeriesdoses,
) {
  decode.one_of(
    {
      use value <- decode.field("seriesDosesPositiveInt", decode.int)
      decode.success(PotatoimmunizationProtocolappliedSeriesdosesPositiveint(
        value,
      ))
    },
    [
      {
        use value <- decode.field("seriesDosesString", decode.string)
        decode.success(PotatoimmunizationProtocolappliedSeriesdosesString(value))
      },
    ],
  )
}

pub fn potatoimmunization_protocolapplied_dosenumber_decoder() -> Decoder(
  PotatoimmunizationProtocolappliedDosenumber,
) {
  decode.one_of(
    {
      use value <- decode.field("doseNumberPositiveInt", decode.int)
      decode.success(PotatoimmunizationProtocolappliedDosenumberPositiveint(
        value,
      ))
    },
    [
      {
        use value <- decode.field("doseNumberString", decode.string)
        decode.success(PotatoimmunizationProtocolappliedDosenumberString(value))
      },
    ],
  )
}

pub fn potatoimmunization_protocolapplied_decoder() -> Decoder(
  PotatoimmunizationProtocolapplied,
) {
  use <- decode.recursive
  use target_disease <- decode.optional_field(
    "targetDisease",
    [],
    decode.list(ct.potatocodeableconcept_decoder()),
  )
  use series_doses <- decode.then(
    none_if_omitted(potatoimmunization_protocolapplied_seriesdoses_decoder()),
  )
  use series <- decode_optional_string("series")
  use id <- decode_optional_string("id")
  use dose_number <- decode.then(
    potatoimmunization_protocolapplied_dosenumber_decoder(),
  )
  use authority <- decode.optional_field(
    "authority",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  let placeholder =
    PotatoimmunizationProtocolapplied(
      target_disease:,
      series_doses:,
      series:,
      id:,
      dose_number:,
      authority:,
    )
  decode.success(placeholder)
}

pub fn potatoimmunization_performer_decoder() -> Decoder(
  PotatoimmunizationPerformer,
) {
  use <- decode.recursive
  use id <- decode_optional_string("id")
  use function <- decode.optional_field(
    "function",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use actor <- decode.field("actor", ct.potatoreference_decoder())
  let placeholder = PotatoimmunizationPerformer(id:, function:, actor:)
  decode.success(placeholder)
}

pub fn potatoimmunization_education_decoder() -> Decoder(
  PotatoimmunizationEducation,
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
    PotatoimmunizationEducation(
      reference:,
      publication_date:,
      presentation_date:,
      id:,
      document_type:,
    )
  decode.success(placeholder)
}

pub fn potatoimmunization_occurrence_decoder() -> Decoder(
  PotatoimmunizationOccurrence,
) {
  decode.one_of(
    {
      use value <- decode.field("occurrenceDateTime", pt.datetime_decoder())
      decode.success(PotatoimmunizationOccurrenceDatetime(value))
    },
    [
      {
        use value <- decode.field("occurrenceString", decode.string)
        decode.success(PotatoimmunizationOccurrenceString(value))
      },
    ],
  )
}

pub fn potatoimmunization_decoder() -> Decoder(Potatoimmunization) {
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
  use status <- decode.field("status", valuesets.immunizationstatus_decoder())
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
    decode.list(potatoimmunization_reaction_decoder()),
  )
  use protocol_applied <- decode.optional_field(
    "protocolApplied",
    [],
    decode.list(potatoimmunization_protocolapplied_decoder()),
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
    decode.list(potatoimmunization_performer_decoder()),
  )
  use patient <- decode.field("patient", ct.potatoreference_decoder())
  use occurrence <- decode.then(potatoimmunization_occurrence_decoder())
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
    decode.list(potatoimmunization_education_decoder()),
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
    Potatoimmunization(
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

type PotatomedicationrequestExtensionSliceAccumulator {
  PotatomedicationrequestExtensionSliceAccumulator(
    medication_adherence: List(ct.Potatomedicationadherence),
  )
}

pub type PotatomedicationrequestParsedExtensionSlice {
  PotatomedicationrequestParsedExtensionSliceMedicationadherence(
    ct.Potatomedicationadherence,
  )
  PotatomedicationrequestParsedExtensionSliceIgnored
}

type PotatomedicationrequestExtensionSlices {
  PotatomedicationrequestExtensionSlices(
    medication_adherence: List(ct.Potatomedicationadherence),
  )
}

type PotatomedicationrequestCategorySliceAccumulator {
  PotatomedicationrequestCategorySliceAccumulator(
    us_core: List(ct.CodeableconceptPotatomedicationrequestCategoryUsCore),
    open: List(ct.Potatocodeableconcept),
  )
}

type PotatomedicationrequestParsedCategorySlice {
  PotatomedicationrequestParsedCategorySliceUsCore(
    ct.CodeableconceptPotatomedicationrequestCategoryUsCore,
  )
  PotatomedicationrequestParsedCategorySliceOpen(ct.Potatocodeableconcept)
}

type PotatomedicationrequestCategorySlices {
  PotatomedicationrequestCategorySlices(
    us_core: List(ct.CodeableconceptPotatomedicationrequestCategoryUsCore),
    open: List(ct.Potatocodeableconcept),
  )
}

pub fn potatomedicationrequest_substitution_allowed_decoder() -> Decoder(
  PotatomedicationrequestSubstitutionAllowed,
) {
  decode.one_of(
    {
      use value <- decode.field("allowedBoolean", decode.bool)
      decode.success(PotatomedicationrequestSubstitutionAllowedBoolean(value))
    },
    [
      {
        use value <- decode.field(
          "allowedCodeableConcept",
          ct.potatocodeableconcept_decoder(),
        )
        decode.success(
          PotatomedicationrequestSubstitutionAllowedCodeableconcept(value),
        )
      },
    ],
  )
}

pub fn potatomedicationrequest_substitution_decoder() -> Decoder(
  PotatomedicationrequestSubstitution,
) {
  use <- decode.recursive
  use reason <- decode.optional_field(
    "reason",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use id <- decode_optional_string("id")
  use allowed <- decode.then(
    potatomedicationrequest_substitution_allowed_decoder(),
  )
  let placeholder = PotatomedicationrequestSubstitution(reason:, id:, allowed:)
  decode.success(placeholder)
}

pub fn potatomedicationrequest_dispenserequest_initialfill_decoder() -> Decoder(
  PotatomedicationrequestDispenserequestInitialfill,
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
    PotatomedicationrequestDispenserequestInitialfill(quantity:, id:, duration:)
  decode.success(placeholder)
}

pub fn potatomedicationrequest_dispenserequest_decoder() -> Decoder(
  PotatomedicationrequestDispenserequest,
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
      potatomedicationrequest_dispenserequest_initialfill_decoder(),
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
    PotatomedicationrequestDispenserequest(
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

pub fn potatomedicationrequest_reported_decoder() -> Decoder(
  PotatomedicationrequestReported,
) {
  decode.one_of(
    {
      use value <- decode.field("reportedBoolean", decode.bool)
      decode.success(PotatomedicationrequestReportedBoolean(value))
    },
    [
      {
        use value <- decode.field(
          "reportedReference",
          ct.potatoreference_decoder(),
        )
        decode.success(PotatomedicationrequestReportedReference(value))
      },
    ],
  )
}

pub fn potatomedicationrequest_medication_decoder() -> Decoder(
  PotatomedicationrequestMedication,
) {
  decode.one_of(
    {
      use value <- decode.field(
        "medicationCodeableConcept",
        ct.potatocodeableconcept_decoder(),
      )
      decode.success(PotatomedicationrequestMedicationCodeableconcept(value))
    },
    [
      {
        use value <- decode.field(
          "medicationReference",
          ct.potatoreference_decoder(),
        )
        decode.success(PotatomedicationrequestMedicationReference(value))
      },
    ],
  )
}

pub fn potatomedicationrequest_extension_slice_decoder() -> Decoder(
  Result(PotatomedicationrequestParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use _id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication-adherence" ->
        parse_potatomedicationadherence()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatomedicationrequestParsedExtensionSliceMedicationadherence(
              value,
            )
          })
        })
      _ ->
        decode.success(Ok(PotatomedicationrequestParsedExtensionSliceIgnored))
    },
    decode.success,
  )
}

pub fn potatomedicationrequest_decoder() -> Decoder(Potatomedicationrequest) {
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
    decode.optional(potatomedicationrequest_substitution_decoder()),
  )
  use subject <- decode.field("subject", ct.potatoreference_decoder())
  use status_reason <- decode.optional_field(
    "statusReason",
    None,
    decode.optional(ct.potatocodeableconcept_decoder()),
  )
  use status <- decode.field(
    "status",
    valuesets.medicationrequeststatus_decoder(),
  )
  use requester <- decode.optional_field(
    "requester",
    None,
    decode.optional(ct.potatoreference_decoder()),
  )
  use reported <- decode.then(
    none_if_omitted(potatomedicationrequest_reported_decoder()),
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
    decode.optional(valuesets.requestpriority_decoder()),
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
  use medication <- decode.then(potatomedicationrequest_medication_decoder())
  use language <- decode_optional_string("language")
  use intent <- decode.field(
    "intent",
    valuesets.medicationrequestintent_decoder(),
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
    decode.list(potatomedicationrequest_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(PotatomedicationrequestExtensionSliceAccumulator([])),
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
                  PotatomedicationrequestParsedExtensionSliceMedicationadherence(
                    value,
                  ) ->
                    Ok(
                      PotatomedicationrequestExtensionSliceAccumulator(
                        medication_adherence: [
                          value,
                          ..accumulator.medication_adherence
                        ],
                      ),
                    )
                  PotatomedicationrequestParsedExtensionSliceIgnored ->
                    Ok(accumulator)
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(
        PotatomedicationrequestExtensionSlices(
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
    decode.list(ct.dosage_potatomedicationrequest_dosageinstruction_decoder()),
  )
  use do_not_perform <- decode_optional_bool("doNotPerform")
  use dispense_request <- decode.optional_field(
    "dispenseRequest",
    None,
    decode.optional(potatomedicationrequest_dispenserequest_decoder()),
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
                      ct.codeableconcept_potatomedicationrequest_category_us_core_decoder(),
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
          ct.codeableconcept_potatomedicationrequest_category_us_core_decoder()
          |> decode.map(PotatomedicationrequestParsedCategorySliceUsCore)
        ct.DiscriminatorDifferent ->
          ct.potatocodeableconcept_decoder()
          |> decode.map(PotatomedicationrequestParsedCategorySliceOpen)
      }
    }),
  )
  let category_accumulator =
    list.index_fold(
      category_base_values,
      PotatomedicationrequestCategorySliceAccumulator([], []),
      fn(accumulator, parsed, _index) {
        case parsed {
          PotatomedicationrequestParsedCategorySliceUsCore(value) ->
            PotatomedicationrequestCategorySliceAccumulator(
              ..accumulator,
              us_core: [value, ..accumulator.us_core],
            )
          PotatomedicationrequestParsedCategorySliceOpen(value) ->
            PotatomedicationrequestCategorySliceAccumulator(
              ..accumulator,
              open: [value, ..accumulator.open],
            )
        }
      },
    )
  let category_slices =
    PotatomedicationrequestCategorySlices(
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
        PotatomedicationrequestExtensionSlices([]),
        "Potatomedicationrequest slices",
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
  decode.success(Potatomedicationrequest(
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

pub fn potatomedicationstatement_medication_decoder() -> Decoder(
  PotatomedicationstatementMedication,
) {
  decode.one_of(
    {
      use value <- decode.field(
        "medicationCodeableConcept",
        ct.potatocodeableconcept_decoder(),
      )
      decode.success(PotatomedicationstatementMedicationCodeableconcept(value))
    },
    [
      {
        use value <- decode.field(
          "medicationReference",
          ct.potatoreference_decoder(),
        )
        decode.success(PotatomedicationstatementMedicationReference(value))
      },
    ],
  )
}

pub fn potatomedicationstatement_effective_decoder() -> Decoder(
  PotatomedicationstatementEffective,
) {
  decode.one_of(
    {
      use value <- decode.field("effectiveDateTime", pt.datetime_decoder())
      decode.success(PotatomedicationstatementEffectiveDatetime(value))
    },
    [
      {
        use value <- decode.field("effectivePeriod", ct.potatoperiod_decoder())
        decode.success(PotatomedicationstatementEffectivePeriod(value))
      },
    ],
  )
}

pub fn potatomedicationstatement_decoder() -> Decoder(Potatomedicationstatement) {
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
    valuesets.medicationstatementstatus_decoder(),
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
  use medication <- decode.then(potatomedicationstatement_medication_decoder())
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
    none_if_omitted(potatomedicationstatement_effective_decoder()),
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
    Potatomedicationstatement(
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

type PotatopatientExtensionSliceAccumulator {
  PotatopatientExtensionSliceAccumulator(
    tribal_affiliation: List(ct.Potatotribalaffiliation),
    sex: Option(String),
    race: Option(ct.Potatorace),
    gender_identity: List(ct.Potatocodeableconcept),
    ethnicity: Option(ct.Potatoethnicity),
    birthsex: Option(valuesets.Two16840111376214102124),
  )
}

pub type PotatopatientParsedExtensionSlice {
  PotatopatientParsedExtensionSliceTribalaffiliation(ct.Potatotribalaffiliation)
  PotatopatientParsedExtensionSliceSex(String)
  PotatopatientParsedExtensionSliceRace(ct.Potatorace)
  PotatopatientParsedExtensionSliceGenderidentity(ct.Potatocodeableconcept)
  PotatopatientParsedExtensionSliceEthnicity(ct.Potatoethnicity)
  PotatopatientParsedExtensionSliceBirthsex(valuesets.Two16840111376214102124)
  PotatopatientParsedExtensionSliceIgnored
}

type PotatopatientExtensionSlices {
  PotatopatientExtensionSlices(
    tribal_affiliation: List(ct.Potatotribalaffiliation),
    sex: Option(String),
    race: Option(ct.Potatorace),
    gender_identity: List(ct.Potatocodeableconcept),
    ethnicity: Option(ct.Potatoethnicity),
    birthsex: Option(valuesets.Two16840111376214102124),
  )
}

pub fn potatopatient_link_decoder() -> Decoder(PotatopatientLink) {
  use <- decode.recursive
  use type_ <- decode.field("type", valuesets.linktype_decoder())
  use other <- decode.field("other", ct.potatoreference_decoder())
  use id <- decode_optional_string("id")
  let placeholder = PotatopatientLink(type_:, other:, id:)
  decode.success(placeholder)
}

pub fn potatopatient_contact_decoder() -> Decoder(PotatopatientContact) {
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
    decode.optional(valuesets.administrativegender_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    None,
    decode.optional(ct.potatoaddress_decoder()),
  )
  let placeholder =
    PotatopatientContact(
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

pub fn potatopatient_communication_decoder() -> Decoder(
  PotatopatientCommunication,
) {
  use <- decode.recursive
  use preferred <- decode_optional_bool("preferred")
  use language <- decode.field("language", ct.potatocodeableconcept_decoder())
  use id <- decode_optional_string("id")
  let placeholder = PotatopatientCommunication(preferred:, language:, id:)
  decode.success(placeholder)
}

pub fn potatopatient_multiplebirth_decoder() -> Decoder(
  PotatopatientMultiplebirth,
) {
  decode.one_of(
    {
      use value <- decode.field("multipleBirthBoolean", decode.bool)
      decode.success(PotatopatientMultiplebirthBoolean(value))
    },
    [
      {
        use value <- decode.field("multipleBirthInteger", decode.int)
        decode.success(PotatopatientMultiplebirthInteger(value))
      },
    ],
  )
}

pub fn potatopatient_extension_slice_decoder() -> Decoder(
  Result(PotatopatientParsedExtensionSlice, String),
) {
  use url <- decode.field("url", decode.string)
  use _id <- decode.optional_field("id", None, decode.optional(decode.string))
  decode.then(
    case url {
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation" ->
        parse_potatotribalaffiliation()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatopatientParsedExtensionSliceTribalaffiliation(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-sex" ->
        decode.field("valueCode", decode.string, decode.success)
        |> decode.map(Ok)
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatopatientParsedExtensionSliceSex(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race" ->
        parse_potatorace()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatopatientParsedExtensionSliceRace(value)
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
            PotatopatientParsedExtensionSliceGenderidentity(value)
          })
        })
      "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity" ->
        parse_potatoethnicity()
        |> decode.map(fn(parsed) {
          result.map(parsed, fn(value) {
            PotatopatientParsedExtensionSliceEthnicity(value)
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
            PotatopatientParsedExtensionSliceBirthsex(value)
          })
        })
      _ -> decode.success(Ok(PotatopatientParsedExtensionSliceIgnored))
    },
    decode.success,
  )
}

pub fn potatopatient_deceased_decoder() -> Decoder(PotatopatientDeceased) {
  decode.one_of(
    {
      use value <- decode.field("deceasedBoolean", decode.bool)
      decode.success(PotatopatientDeceasedBoolean(value))
    },
    [
      {
        use value <- decode.field("deceasedDateTime", pt.datetime_decoder())
        decode.success(PotatopatientDeceasedDatetime(value))
      },
    ],
  )
}

pub fn potatopatient_decoder() -> Decoder(Potatopatient) {
  use <- decode.recursive
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(ct.potatonarrative_decoder()),
  )
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.contactpoint_potatopatient_telecom_decoder()),
  )
  use photo <- decode.optional_field(
    "photo",
    [],
    decode.list(ct.potatoattachment_decoder()),
  )
  use name <- list1_decoder("name", ct.humanname_potatopatient_name_decoder())
  use multiple_birth <- decode.then(
    none_if_omitted(potatopatient_multiplebirth_decoder()),
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
    decode.list(potatopatient_link_decoder()),
  )
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use identifier <- list1_decoder(
    "identifier",
    ct.identifier_potatopatient_identifier_decoder(),
  )
  use id <- decode_optional_string("id")
  use general_practitioner <- decode.optional_field(
    "generalPractitioner",
    [],
    decode.list(ct.potatoreference_decoder()),
  )
  use gender <- decode.field("gender", valuesets.administrativegender_decoder())
  use extension_base_values <- decode.optional_field(
    "extension",
    [],
    decode.list(potatopatient_extension_slice_decoder()),
  )
  let extension_accumulator =
    list.index_fold(
      extension_base_values,
      Ok(PotatopatientExtensionSliceAccumulator([], None, None, [], None, None)),
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
                  PotatopatientParsedExtensionSliceTribalaffiliation(value) ->
                    Ok(
                      PotatopatientExtensionSliceAccumulator(
                        ..accumulator,
                        tribal_affiliation: [
                          value,
                          ..accumulator.tribal_affiliation
                        ],
                      ),
                    )
                  PotatopatientParsedExtensionSliceSex(value) ->
                    Ok(
                      PotatopatientExtensionSliceAccumulator(
                        ..accumulator,
                        sex: Some(value),
                      ),
                    )
                  PotatopatientParsedExtensionSliceRace(value) ->
                    Ok(
                      PotatopatientExtensionSliceAccumulator(
                        ..accumulator,
                        race: Some(value),
                      ),
                    )
                  PotatopatientParsedExtensionSliceGenderidentity(value) ->
                    Ok(
                      PotatopatientExtensionSliceAccumulator(
                        ..accumulator,
                        gender_identity: [value, ..accumulator.gender_identity],
                      ),
                    )
                  PotatopatientParsedExtensionSliceEthnicity(value) ->
                    Ok(
                      PotatopatientExtensionSliceAccumulator(
                        ..accumulator,
                        ethnicity: Some(value),
                      ),
                    )
                  PotatopatientParsedExtensionSliceBirthsex(value) ->
                    Ok(
                      PotatopatientExtensionSliceAccumulator(
                        ..accumulator,
                        birthsex: Some(value),
                      ),
                    )
                  PotatopatientParsedExtensionSliceIgnored -> Ok(accumulator)
                }
            }
        }
      },
    )
  let extension_slices = case extension_accumulator {
    Ok(accumulator) ->
      Ok(PotatopatientExtensionSlices(
        tribal_affiliation: list.reverse(accumulator.tribal_affiliation),
        sex: accumulator.sex,
        race: accumulator.race,
        gender_identity: list.reverse(accumulator.gender_identity),
        ethnicity: accumulator.ethnicity,
        birthsex: accumulator.birthsex,
      ))
    Error(errors) -> Error(errors)
  }
  use deceased <- decode.then(none_if_omitted(potatopatient_deceased_decoder()))
  use contained <- decode.optional_field(
    "contained",
    [],
    decode.list(resource_decoder()),
  )
  use contact <- decode.optional_field(
    "contact",
    [],
    decode.list(potatopatient_contact_decoder()),
  )
  use communication <- decode.optional_field(
    "communication",
    [],
    decode.list(potatopatient_communication_decoder()),
  )
  use birth_date <- decode.optional_field(
    "birthDate",
    None,
    decode.optional(pt.date_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    [],
    decode.list(ct.address_potatopatient_address_decoder()),
  )
  use active <- decode_optional_bool("active")
  let extension_slices_decoder = case extension_slices {
    Ok(value) -> decode.success(value)
    Error(errors) ->
      decode.failure(
        PotatopatientExtensionSlices([], None, None, [], None, None),
        "Potatopatient slices",
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
  decode.success(Potatopatient(
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
  RtBundle
  RtOperationoutcome
  RtParameters
  RtAllergyintolerance
  RtAppointment
  RtCondition
  RtDocumentreference
  RtEncounter
  RtImmunization
  RtMedicationrequest
  RtMedicationstatement
  RtPatient
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    RtBundle -> "Bundle"
    RtOperationoutcome -> "OperationOutcome"
    RtParameters -> "Parameters"
    RtAllergyintolerance -> "AllergyIntolerance"
    RtAppointment -> "Appointment"
    RtCondition -> "Condition"
    RtDocumentreference -> "DocumentReference"
    RtEncounter -> "Encounter"
    RtImmunization -> "Immunization"
    RtMedicationrequest -> "MedicationRequest"
    RtMedicationstatement -> "MedicationStatement"
    RtPatient -> "Patient"
  }
}

pub type Resource {
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourcePotatoallergyintolerance(Potatoallergyintolerance)
  ResourcePotatoappointment(Potatoappointment)
  ResourcePotatocondition(Potatocondition)
  ResourcePotatodocumentreference(Potatodocumentreference)
  ResourcePotatoencounter(Potatoencounter)
  ResourcePotatoimmunization(Potatoimmunization)
  ResourcePotatomedicationrequest(Potatomedicationrequest)
  ResourcePotatomedicationstatement(Potatomedicationstatement)
  ResourcePotatopatient(Potatopatient)
}

pub fn resource_to_json(resource: Resource) {
  case resource {
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourcePotatoallergyintolerance(resource) ->
      potatoallergyintolerance_to_json(resource)
    ResourcePotatoappointment(resource) -> potatoappointment_to_json(resource)
    ResourcePotatocondition(resource) -> potatocondition_to_json(resource)
    ResourcePotatodocumentreference(resource) ->
      potatodocumentreference_to_json(resource)
    ResourcePotatoencounter(resource) -> potatoencounter_to_json(resource)
    ResourcePotatoimmunization(resource) -> potatoimmunization_to_json(resource)
    ResourcePotatomedicationrequest(resource) ->
      potatomedicationrequest_to_json(resource)
    ResourcePotatomedicationstatement(resource) ->
      potatomedicationstatement_to_json(resource)
    ResourcePotatopatient(resource) -> potatopatient_to_json(resource)
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
      potatoallergyintolerance_decoder()
      |> decode.map(ResourcePotatoallergyintolerance)
    "Appointment" ->
      potatoappointment_decoder() |> decode.map(ResourcePotatoappointment)
    "Condition" ->
      potatocondition_decoder() |> decode.map(ResourcePotatocondition)
    "DocumentReference" ->
      potatodocumentreference_decoder()
      |> decode.map(ResourcePotatodocumentreference)
    "Encounter" ->
      potatoencounter_decoder() |> decode.map(ResourcePotatoencounter)
    "Immunization" ->
      potatoimmunization_decoder() |> decode.map(ResourcePotatoimmunization)
    "MedicationRequest" ->
      potatomedicationrequest_decoder()
      |> decode.map(ResourcePotatomedicationrequest)
    "MedicationStatement" ->
      potatomedicationstatement_decoder()
      |> decode.map(ResourcePotatomedicationstatement)
    "Patient" -> potatopatient_decoder() |> decode.map(ResourcePotatopatient)
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
