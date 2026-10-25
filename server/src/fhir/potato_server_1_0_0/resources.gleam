////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) resources

import fhir/potato_server_1_0_0/complex_types.{
  type List1, decode_optional_string, list1_decoder, list1_to_json,
} as ct
import fhir/potato_server_1_0_0/valuesets
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

pub type Potatoserverpractitioner {
  Potatoserverpractitioner(
    id: Option(String),
    identifier: List1(
      ct.IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner,
    ),
    name: List1(ct.HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod),
  )
}

pub fn potatoserverpractitioner_new(
  identifier identifier: List1(
    ct.IdentifierRequiredSystemValueOmitIdExtensionUseTypePeriodAssigner,
  ),
  name name: List1(
    ct.HumannameRequiredFamilyOmitIdExtensionUsePrefixSuffixPeriod,
  ),
) -> Potatoserverpractitioner {
  Potatoserverpractitioner(id: None, identifier:, name:)
}

pub fn potatoserverpractitioner_to_json(
  potatoserverpractitioner: Potatoserverpractitioner,
) -> Json {
  let fields = [
    #(
      "name",
      list1_to_json(potatoserverpractitioner.name, fn(value) {
        ct.humanname_required_family_omit_id_extension_use_prefix_suffix_period_to_json(
          value,
        )
      }),
    ),
    #(
      "identifier",
      list1_to_json(potatoserverpractitioner.identifier, fn(value) {
        ct.identifier_required_system_value_omit_id_extension_use_type_period_assigner_to_json(
          value,
        )
      }),
    ),
  ]
  let fields = case potatoserverpractitioner.id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Practitioner")), ..fields]
  json.object(fields)
}

pub fn potatoserverpractitioner_decoder() -> Decoder(Potatoserverpractitioner) {
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
  let placeholder = Potatoserverpractitioner(name:, identifier:, id:)
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
  RtBundle
  RtOperationoutcome
  RtParameters
  RtPractitioner
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    RtBundle -> "Bundle"
    RtOperationoutcome -> "OperationOutcome"
    RtParameters -> "Parameters"
    RtPractitioner -> "Practitioner"
  }
}

pub type Resource {
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourcePotatoserverpractitioner(Potatoserverpractitioner)
}

pub fn resource_to_json(resource: Resource) {
  case resource {
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourcePotatoserverpractitioner(resource) ->
      potatoserverpractitioner_to_json(resource)
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
      potatoserverpractitioner_decoder()
      |> decode.map(ResourcePotatoserverpractitioner)
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
