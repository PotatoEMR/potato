////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) resources

import fhir/r4/complex_type.{
  type List1, decode_optional_bool, decode_optional_string, list1_decoder,
  list1_to_json, none_if_omitted,
} as ct
import fhir/r4/primitive_type.{type Date, type DateTime} as pt
import fhir/r4/valueset
import gleam/bool
import gleam/dynamic/decode.{type Decoder}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}

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

///[http://hl7.org/fhir/r4/StructureDefinition/Patient#resource](http://hl7.org/fhir/r4/StructureDefinition/Patient#resource)
pub type PatientLink {
  PatientLink(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    other: ct.Reference,
    type_: valueset.LinkType,
  )
}

pub fn patient_link_new(
  type_ type_: valueset.LinkType,
  other other: ct.Reference,
) -> PatientLink {
  PatientLink(type_:, other:, modifier_extension: [], extension: [], id: None)
}

///[http://hl7.org/fhir/r4/StructureDefinition/Patient#resource](http://hl7.org/fhir/r4/StructureDefinition/Patient#resource)
pub type PatientContact {
  PatientContact(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    relationship: List(ct.Codeableconcept),
    name: Option(ct.Humanname),
    telecom: List(ct.Contactpoint),
    address: Option(ct.Address),
    gender: Option(valueset.AdministrativeGender),
    organization: Option(ct.Reference),
    period: Option(ct.Period),
  )
}

pub fn patient_contact_new() -> PatientContact {
  PatientContact(
    period: None,
    organization: None,
    gender: None,
    address: None,
    telecom: [],
    name: None,
    relationship: [],
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

///[http://hl7.org/fhir/r4/StructureDefinition/Patient#resource](http://hl7.org/fhir/r4/StructureDefinition/Patient#resource)
pub type PatientCommunication {
  PatientCommunication(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    language: ct.Codeableconcept,
    preferred: Option(Bool),
  )
}

pub fn patient_communication_new(
  language language: ct.Codeableconcept,
) -> PatientCommunication {
  PatientCommunication(
    preferred: None,
    language:,
    modifier_extension: [],
    extension: [],
    id: None,
  )
}

///[http://hl7.org/fhir/r4/StructureDefinition/Patient#resource](http://hl7.org/fhir/r4/StructureDefinition/Patient#resource)
pub type Patient {
  Patient(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    text: Option(ct.Narrative),
    contained: List(Resource),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    identifier: List(ct.Identifier),
    active: Option(Bool),
    name: List(ct.Humanname),
    telecom: List(ct.Contactpoint),
    gender: Option(valueset.AdministrativeGender),
    birth_date: Option(Date),
    deceased: Option(PatientDeceased),
    address: List(ct.Address),
    marital_status: Option(ct.Codeableconcept),
    multiple_birth: Option(PatientMultiplebirth),
    photo: List(ct.Attachment),
    contact: List(PatientContact),
    communication: List(PatientCommunication),
    general_practitioner: List(ct.Reference),
    managing_organization: Option(ct.Reference),
    link: List(PatientLink),
  )
}

///[http://hl7.org/fhir/r4/StructureDefinition/Patient#resource](http://hl7.org/fhir/r4/StructureDefinition/Patient#resource)
pub type PatientDeceased {
  PatientDeceasedBoolean(deceased: Bool)
  PatientDeceasedDatetime(deceased: DateTime)
}

pub fn patient_deceased_to_json_field(
  element: PatientDeceased,
) -> #(String, Json) {
  case element {
    PatientDeceasedBoolean(v) -> #("deceasedBoolean", json.bool(v))
    PatientDeceasedDatetime(v) -> #("deceasedDateTime", pt.datetime_to_json(v))
  }
}

pub fn patient_deceased_decoder() -> Decoder(PatientDeceased) {
  decode.one_of(
    decode.field("deceasedBoolean", decode.bool, decode.success)
      |> decode.map(PatientDeceasedBoolean),
    [
      decode.field("deceasedDateTime", pt.datetime_decoder(), decode.success)
      |> decode.map(PatientDeceasedDatetime),
    ],
  )
}

///[http://hl7.org/fhir/r4/StructureDefinition/Patient#resource](http://hl7.org/fhir/r4/StructureDefinition/Patient#resource)
pub type PatientMultiplebirth {
  PatientMultiplebirthBoolean(multiple_birth: Bool)
  PatientMultiplebirthInteger(multiple_birth: Int)
}

pub fn patient_multiplebirth_to_json_field(
  element: PatientMultiplebirth,
) -> #(String, Json) {
  case element {
    PatientMultiplebirthBoolean(v) -> #("multipleBirthBoolean", json.bool(v))
    PatientMultiplebirthInteger(v) -> #("multipleBirthInteger", json.int(v))
  }
}

pub fn patient_multiplebirth_decoder() -> Decoder(PatientMultiplebirth) {
  decode.one_of(
    decode.field("multipleBirthBoolean", decode.bool, decode.success)
      |> decode.map(PatientMultiplebirthBoolean),
    [
      decode.field("multipleBirthInteger", decode.int, decode.success)
      |> decode.map(PatientMultiplebirthInteger),
    ],
  )
}

pub fn patient_new() -> Patient {
  Patient(
    link: [],
    managing_organization: None,
    general_practitioner: [],
    communication: [],
    contact: [],
    photo: [],
    multiple_birth: None,
    marital_status: None,
    address: [],
    deceased: None,
    birth_date: None,
    gender: None,
    telecom: [],
    name: [],
    active: None,
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

pub fn patient_to_json(patient: Patient) -> Json {
  let fields = []
  let fields = case patient.link {
    [] -> fields
    _ -> [#("link", json.array(patient.link, patient_link_to_json)), ..fields]
  }
  let fields = case patient.managing_organization {
    Some(v) -> [#("managingOrganization", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient.general_practitioner {
    [] -> fields
    _ -> [
      #(
        "generalPractitioner",
        json.array(patient.general_practitioner, ct.reference_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient.communication {
    [] -> fields
    _ -> [
      #(
        "communication",
        json.array(patient.communication, patient_communication_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient.contact {
    [] -> fields
    _ -> [
      #("contact", json.array(patient.contact, patient_contact_to_json)),
      ..fields
    ]
  }
  let fields = case patient.photo {
    [] -> fields
    _ -> [
      #("photo", json.array(patient.photo, ct.attachment_to_json)),
      ..fields
    ]
  }
  let fields = case patient.multiple_birth {
    Some(v) -> [patient_multiplebirth_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case patient.marital_status {
    Some(v) -> [#("maritalStatus", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient.address {
    [] -> fields
    _ -> [
      #("address", json.array(patient.address, ct.address_to_json)),
      ..fields
    ]
  }
  let fields = case patient.deceased {
    Some(v) -> [patient_deceased_to_json_field(v), ..fields]
    None -> fields
  }
  let fields = case patient.birth_date {
    Some(v) -> [#("birthDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient.gender {
    Some(v) -> [
      #("gender", valueset.administrative_gender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case patient.telecom {
    [] -> fields
    _ -> [
      #("telecom", json.array(patient.telecom, ct.contactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case patient.name {
    [] -> fields
    _ -> [#("name", json.array(patient.name, ct.humanname_to_json)), ..fields]
  }
  let fields = case patient.active {
    Some(v) -> [#("active", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case patient.identifier {
    [] -> fields
    _ -> [
      #("identifier", json.array(patient.identifier, ct.identifier_to_json)),
      ..fields
    ]
  }
  let fields = case patient.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(patient.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient.extension {
    [] -> fields
    _ -> [
      #("extension", json.array(patient.extension, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case patient.contained {
    [] -> fields
    _ -> [#("contained", json.array(patient.contained, to_json)), ..fields]
  }
  let fields = case patient.text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient.language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case patient.implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case patient.meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Patient")), ..fields]
  json.object(fields)
}

pub fn patient_decoder() -> Decoder(Patient) {
  use <- decode.recursive
  use link <- decode.optional_field(
    "link",
    [],
    decode.list(patient_link_decoder()),
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
    decode.list(patient_communication_decoder()),
  )
  use contact <- decode.optional_field(
    "contact",
    [],
    decode.list(patient_contact_decoder()),
  )
  use photo <- decode.optional_field(
    "photo",
    [],
    decode.list(ct.attachment_decoder()),
  )
  use multiple_birth <- decode.then(
    none_if_omitted(patient_multiplebirth_decoder()),
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
  use deceased <- decode.then(none_if_omitted(patient_deceased_decoder()))
  use birth_date <- decode.optional_field(
    "birthDate",
    None,
    decode.optional(pt.date_decoder()),
  )
  use gender <- decode.optional_field(
    "gender",
    None,
    decode.optional(valueset.administrative_gender_decoder()),
  )
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.contactpoint_decoder()),
  )
  use name <- decode.optional_field(
    "name",
    [],
    decode.list(ct.humanname_decoder()),
  )
  use active <- decode_optional_bool("active")
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
  use language <- decode_optional_string("language")
  use implicit_rules <- decode_optional_string("implicitRules")
  use meta <- decode.optional_field(
    "meta",
    None,
    decode.optional(ct.meta_decoder()),
  )
  use id <- decode_optional_string("id")

  use resource_type <- decode.field("resourceType", decode.string)
  use <- bool.guard(
    resource_type != "Patient",
    decode.failure(patient_new(), "resourceType"),
  )
  decode.success(Patient(
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
    extension:,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

pub fn patient_communication_to_json(
  patient_communication: PatientCommunication,
) -> Json {
  let fields = [
    #("language", ct.codeableconcept_to_json(patient_communication.language)),
  ]
  let fields = case patient_communication.preferred {
    Some(v) -> [#("preferred", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case patient_communication.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(
          patient_communication.modifier_extension,
          ct.extension_to_json,
        ),
      ),
      ..fields
    ]
  }
  let fields = case patient_communication.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(patient_communication.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient_communication.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn patient_communication_decoder() -> Decoder(PatientCommunication) {
  use <- decode.recursive
  use preferred <- decode_optional_bool("preferred")
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
  use id <- decode_optional_string("id")
  decode.success(PatientCommunication(
    preferred:,
    language:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub fn patient_contact_to_json(patient_contact: PatientContact) -> Json {
  let fields = []
  let fields = case patient_contact.period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient_contact.organization {
    Some(v) -> [#("organization", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient_contact.gender {
    Some(v) -> [
      #("gender", valueset.administrative_gender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case patient_contact.address {
    Some(v) -> [#("address", ct.address_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient_contact.telecom {
    [] -> fields
    _ -> [
      #("telecom", json.array(patient_contact.telecom, ct.contactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case patient_contact.name {
    Some(v) -> [#("name", ct.humanname_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case patient_contact.relationship {
    [] -> fields
    _ -> [
      #(
        "relationship",
        json.array(patient_contact.relationship, ct.codeableconcept_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient_contact.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(patient_contact.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient_contact.extension {
    [] -> fields
    _ -> [
      #(
        "extension",
        json.array(patient_contact.extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient_contact.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn patient_contact_decoder() -> Decoder(PatientContact) {
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
    decode.optional(valueset.administrative_gender_decoder()),
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
  use id <- decode_optional_string("id")
  decode.success(PatientContact(
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
  ))
}

pub fn patient_link_to_json(patient_link: PatientLink) -> Json {
  let fields = [
    #("type", valueset.link_type_to_json(patient_link.type_)),
    #("other", ct.reference_to_json(patient_link.other)),
  ]
  let fields = case patient_link.modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(patient_link.modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case patient_link.extension {
    [] -> fields
    _ -> [
      #("extension", json.array(patient_link.extension, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case patient_link.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn patient_link_decoder() -> Decoder(PatientLink) {
  use <- decode.recursive
  use type_ <- decode.field("type", valueset.link_type_decoder())
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
  use id <- decode_optional_string("id")
  decode.success(PatientLink(
    type_:,
    other:,
    modifier_extension:,
    extension:,
    id:,
  ))
}

pub type ResourceType {
  ResourceTypeBundle
  ResourceTypeOperationoutcome
  ResourceTypeParameters
  ResourceTypePatient
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    ResourceTypeBundle -> "Bundle"
    ResourceTypeOperationoutcome -> "OperationOutcome"
    ResourceTypeParameters -> "Parameters"
    ResourceTypePatient -> "Patient"
  }
}

pub type Resource {
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourcePatient(Patient)
}

pub fn to_json(resource: Resource) -> Json {
  case resource {
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourcePatient(resource) -> patient_to_json(resource)
  }
}

pub fn resource_decoder() -> Decoder(Resource) {
  use tag <- decode.field("resourceType", decode.string)
  case tag {
    "Bundle" -> bundle_decoder() |> decode.map(ResourceBundle)
    "OperationOutcome" ->
      operationoutcome_decoder() |> decode.map(ResourceOperationoutcome)
    "Parameters" -> parameters_decoder() |> decode.map(ResourceParameters)
    "Patient" -> patient_decoder() |> decode.map(ResourcePatient)
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
