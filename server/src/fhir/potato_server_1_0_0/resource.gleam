////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) resources

import fhir/potato_server_1_0_0/complex_type.{
  type List1, decode_optional_string, list1_decoder, list1_to_json,
} as ct
import fhir/potato_server_1_0_0/valueset
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

pub type PotatoserverPractitioner {
  PotatoserverPractitioner(
    id: Option(String),
    identifier: List1(
      ct.IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner,
    ),
    name: List1(ct.HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod),
  )
}

pub fn potatoserver_practitioner_new(
  identifier identifier: List1(
    ct.IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner,
  ),
  name name: List1(
    ct.HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod,
  ),
) -> PotatoserverPractitioner {
  PotatoserverPractitioner(id: None, identifier:, name:)
}

pub fn potatoserver_practitioner_to_json(
  potatoserver_practitioner: PotatoserverPractitioner,
) -> Json {
  let fields = [
    #(
      "name",
      list1_to_json(potatoserver_practitioner.name, fn(value) {
        ct.humanname_required_family_omit_id_extension_use_prefix_suffix_period_to_json(
          value,
        )
      }),
    ),
    #(
      "identifier",
      list1_to_json(potatoserver_practitioner.identifier, fn(value) {
        ct.identifier_required_system_value_omit_id_extension_use_type_period_assigner_to_json(
          value,
        )
      }),
    ),
  ]
  let fields = case potatoserver_practitioner.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Practitioner")), ..fields]
  json.object(fields)
}

pub fn potatoserver_practitioner_decoder() -> Decoder(PotatoserverPractitioner) {
  use <- decode.recursive
  use name <- list1_decoder(
    "name",
    ct.humanname_required_family_omit_id_extension_use_prefix_suffix_period_decoder(),
  )
  use identifier <- list1_decoder(
    "identifier",
    ct.identifier_required_system_value_omit_id_extension_use_type_period_assigner_decoder(),
  )
  use id <- decode_optional_string("id")
  let placeholder = PotatoserverPractitioner(name:, identifier:, id:)
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(value) {
      case value == "Practitioner" {
        True -> decode.success(Nil)
        False ->
          decode.failure(Nil, "Practitioner")
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

pub type ResourceType {
  ResourceTypeBundle
  ResourceTypeOperationoutcome
  ResourceTypeParameters
  ResourceTypePractitioner
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    ResourceTypeBundle -> "Bundle"
    ResourceTypeOperationoutcome -> "OperationOutcome"
    ResourceTypeParameters -> "Parameters"
    ResourceTypePractitioner -> "Practitioner"
  }
}

pub type Resource {
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourcePotatoserverPractitioner(PotatoserverPractitioner)
}

pub fn to_json(resource: Resource) -> Json {
  case resource {
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourcePotatoserverPractitioner(resource) ->
      potatoserver_practitioner_to_json(resource)
  }
}

pub fn resource_decoder() -> Decoder(Resource) {
  use tag <- decode.field("resourceType", decode.string)
  case tag {
    "Bundle" -> bundle_decoder() |> decode.map(ResourceBundle)
    "OperationOutcome" ->
      operationoutcome_decoder() |> decode.map(ResourceOperationoutcome)
    "Parameters" -> parameters_decoder() |> decode.map(ResourceParameters)
    "Practitioner" ->
      potatoserver_practitioner_decoder()
      |> decode.map(ResourcePotatoserverPractitioner)
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
