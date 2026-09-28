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
  let BundleEntryResponse(
    outcome:,
    last_modified:,
    etag:,
    location:,
    status:,
    modifier_extension:,
    extension:,
    id:,
  ) = bundle_entry_response
  let fields = [
    #("status", json.string(status)),
  ]
  let fields = case outcome {
    Some(v) -> [#("outcome", resource_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case last_modified {
    Some(v) -> [#("lastModified", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case etag {
    Some(v) -> [#("etag", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case location {
    Some(v) -> [#("location", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let BundleEntryRequest(
    if_none_exist:,
    if_match:,
    if_modified_since:,
    if_none_match:,
    url:,
    method:,
    modifier_extension:,
    extension:,
    id:,
  ) = bundle_entry_request
  let fields = [
    #("url", json.string(url)),
    #("method", valuesets.httpverb_to_json(method)),
  ]
  let fields = case if_none_exist {
    Some(v) -> [#("ifNoneExist", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case if_match {
    Some(v) -> [#("ifMatch", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case if_modified_since {
    Some(v) -> [#("ifModifiedSince", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case if_none_match {
    Some(v) -> [#("ifNoneMatch", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let BundleEntrySearch(score:, mode:, modifier_extension:, extension:, id:) =
    bundle_entry_search
  let fields = []
  let fields = case score {
    Some(v) -> [#("score", json.float(v)), ..fields]
    None -> fields
  }
  let fields = case mode {
    Some(v) -> [#("mode", valuesets.searchentrymode_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let BundleEntry(
    response:,
    request:,
    search:,
    resource:,
    full_url:,
    link:,
    modifier_extension:,
    extension:,
    id:,
  ) = bundle_entry
  let fields = []
  let fields = case response {
    Some(v) -> [#("response", bundle_entry_response_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case request {
    Some(v) -> [#("request", bundle_entry_request_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case search {
    Some(v) -> [#("search", bundle_entry_search_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case resource {
    Some(v) -> [#("resource", resource_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case full_url {
    Some(v) -> [#("fullUrl", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case link {
    [] -> fields
    _ -> [#("link", json.array(link, bundle_link_to_json)), ..fields]
  }
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let BundleLink(url:, relation:, modifier_extension:, extension:, id:) =
    bundle_link
  let fields = [
    #("url", json.string(url)),
    #("relation", json.string(relation)),
  ]
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let Bundle(
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
  ) = bundle
  let fields = [
    #("type", valuesets.bundletype_to_json(type_)),
  ]
  let fields = case signature {
    Some(v) -> [#("signature", ct.signature_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case entry {
    [] -> fields
    _ -> [#("entry", json.array(entry, bundle_entry_to_json)), ..fields]
  }
  let fields = case link {
    [] -> fields
    _ -> [#("link", json.array(link, bundle_link_to_json)), ..fields]
  }
  let fields = case total {
    Some(v) -> [#("total", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case timestamp {
    Some(v) -> [#("timestamp", pt.instant_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier {
    Some(v) -> [#("identifier", ct.identifier_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case id {
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
  let OperationoutcomeIssue(
    expression:,
    location:,
    diagnostics:,
    details:,
    code:,
    severity:,
    modifier_extension:,
    extension:,
    id:,
  ) = operationoutcome_issue
  let fields = [
    #("code", valuesets.issuetype_to_json(code)),
    #("severity", valuesets.issueseverity_to_json(severity)),
  ]
  let fields = case expression {
    [] -> fields
    _ -> [#("expression", json.array(expression, json.string)), ..fields]
  }
  let fields = case location {
    [] -> fields
    _ -> [#("location", json.array(location, json.string)), ..fields]
  }
  let fields = case diagnostics {
    Some(v) -> [#("diagnostics", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case details {
    Some(v) -> [#("details", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let Operationoutcome(
    issue:,
    modifier_extension:,
    extension:,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ) = operationoutcome
  let fields = [
    #("issue", list1_to_json(issue, operationoutcome_issue_to_json)),
  ]
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case contained {
    [] -> fields
    _ -> [#("contained", json.array(contained, resource_to_json)), ..fields]
  }
  let fields = case text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case id {
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
  let ParametersParameter(
    part:,
    resource:,
    value:,
    name:,
    modifier_extension:,
    extension:,
    id:,
  ) = parameters_parameter
  let fields = [
    #("name", json.string(name)),
  ]
  let fields = case part {
    [] -> fields
    _ -> [#("part", json.array(part, parameters_parameter_to_json)), ..fields]
  }
  let fields = case resource {
    Some(v) -> [#("resource", resource_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case value {
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
  let fields = case modifier_extension {
    [] -> fields
    _ -> [
      #(
        "modifierExtension",
        json.array(modifier_extension, ct.extension_to_json),
      ),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    _ -> [#("extension", json.array(extension, ct.extension_to_json)), ..fields]
  }
  let fields = case id {
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
  let Parameters(parameter:, language:, implicit_rules:, meta:, id:) =
    parameters
  let fields = []
  let fields = case parameter {
    [] -> fields
    _ -> [
      #("parameter", json.array(parameter, parameters_parameter_to_json)),
      ..fields
    ]
  }
  let fields = case language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case id {
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
    identifier: List1(UsCorePatientIdentifier),
    active: Option(Bool),
    name: List1(ct.Humanname),
    telecom: List(UsCorePatientTelecom),
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
  identifier identifier: List1(UsCorePatientIdentifier),
  name name: List1(ct.Humanname),
  gender gender: valuesets.Administrativegender,
) -> UsCorePatient {
  UsCorePatient(
    id: None,
    meta: Some(
      ct.Meta(
        id: None,
        extension: [],
        version_id: None,
        last_updated: None,
        source: None,
        profile: [
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient",
        ],
        security: [],
        tag: [],
      ),
    ),
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

pub type UsCorePatientIdentifier {
  UsCorePatientIdentifier(
    id: Option(String),
    extension: List(ct.Extension),
    use_: Option(valuesets.Identifieruse),
    type_: Option(ct.Codeableconcept),
    system: String,
    value: String,
    period: Option(ct.Period),
    assigner: Option(ct.Reference),
  )
}

pub fn us_core_patient_identifier_new(
  system system: String,
  value value: String,
) -> UsCorePatientIdentifier {
  UsCorePatientIdentifier(
    id: None,
    extension: [],
    use_: None,
    type_: None,
    system:,
    value:,
    period: None,
    assigner: None,
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

pub type UsCorePatientTelecom {
  UsCorePatientTelecom(
    id: Option(String),
    extension: List(ct.Extension),
    system: valuesets.Contactpointsystem,
    value: String,
    use_: Option(valuesets.Contactpointuse),
    rank: Option(Int),
    period: Option(ct.Period),
  )
}

pub fn us_core_patient_telecom_new(
  system system: valuesets.Contactpointsystem,
  value value: String,
) -> UsCorePatientTelecom {
  UsCorePatientTelecom(
    id: None,
    extension: [],
    system:,
    value:,
    use_: None,
    rank: None,
    period: None,
  )
}

pub fn us_core_patient_to_json(us_core_patient: UsCorePatient) -> Json {
  let UsCorePatient(
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
    gender_identity:,
    sex:,
    birthsex:,
    tribal_affiliation:,
    ethnicity:,
    race:,
    extension:,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ) = us_core_patient
  let fields = [
    #("gender", valuesets.administrativegender_to_json(gender)),
    #("name", list1_to_json(name, ct.humanname_to_json)),
    #(
      "identifier",
      list1_to_json(identifier, us_core_patient_identifier_to_json),
    ),
  ]
  let fields = case link {
    [] -> fields
    values -> [
      #("link", json.array(values, us_core_patient_link_to_json)),
      ..fields
    ]
  }
  let fields = case managing_organization {
    Some(v) -> [#("managingOrganization", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case general_practitioner {
    [] -> fields
    values -> [
      #("generalPractitioner", json.array(values, ct.reference_to_json)),
      ..fields
    ]
  }
  let fields = case communication {
    [] -> fields
    values -> [
      #(
        "communication",
        json.array(values, us_core_patient_communication_to_json),
      ),
      ..fields
    ]
  }
  let fields = case contact {
    [] -> fields
    values -> [
      #("contact", json.array(values, us_core_patient_contact_to_json)),
      ..fields
    ]
  }
  let fields = case photo {
    [] -> fields
    values -> [#("photo", json.array(values, ct.attachment_to_json)), ..fields]
  }
  let fields = case multiple_birth {
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
  let fields = case marital_status {
    Some(v) -> [#("maritalStatus", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case address {
    [] -> fields
    values -> [#("address", json.array(values, ct.address_to_json)), ..fields]
  }
  let fields = case deceased {
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
  let fields = case birth_date {
    Some(v) -> [#("birthDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case telecom {
    [] -> fields
    values -> [
      #("telecom", json.array(values, us_core_patient_telecom_to_json)),
      ..fields
    ]
  }
  let fields = case active {
    Some(v) -> [#("active", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let slice_values =
    list.flatten([
      list.map(gender_identity, fn(value) {
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
      case sex {
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
      case birthsex {
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
      list.map(tribal_affiliation, fn(value) {
        ct.us_core_tribal_affiliation_to_json(
          value,
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation",
        )
      }),
      case ethnicity {
        Some(value) -> [
          ct.us_core_ethnicity_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity",
          ),
        ]
        None -> []
      },
      case race {
        Some(value) -> [
          ct.us_core_race_to_json(
            value,
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race",
          ),
        ]
        None -> []
      },
      list.map(extension, fn(value) { ct.extension_to_json(value) }),
    ])
  let fields = case slice_values {
    [] -> fields
    values -> [#("extension", json.preprocessed_array(values)), ..fields]
  }
  let fields = case contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case id {
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
  let UsCorePatientCommunication(
    preferred:,
    language:,
    modifier_extension:,
    extension:,
    id:,
  ) = us_core_patient_communication
  let fields = [
    #("language", ct.codeableconcept_to_json(language)),
  ]
  let fields = case preferred {
    Some(v) -> [#("preferred", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_patient_contact_to_json(
  us_core_patient_contact: UsCorePatientContact,
) -> Json {
  let UsCorePatientContact(
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
  ) = us_core_patient_contact
  let fields = []
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case organization {
    Some(v) -> [#("organization", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case gender {
    Some(v) -> [
      #("gender", valuesets.administrativegender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case address {
    Some(v) -> [#("address", ct.address_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case telecom {
    [] -> fields
    values -> [
      #("telecom", json.array(values, ct.contactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case name {
    Some(v) -> [#("name", ct.humanname_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case relationship {
    [] -> fields
    values -> [
      #("relationship", json.array(values, ct.codeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_patient_identifier_to_json(
  us_core_patient_identifier: UsCorePatientIdentifier,
) -> Json {
  let UsCorePatientIdentifier(
    assigner:,
    period:,
    value:,
    system:,
    type_:,
    use_:,
    extension:,
    id:,
  ) = us_core_patient_identifier
  let fields = [
    #("value", json.string(value)),
    #("system", json.string(system)),
  ]
  let fields = case assigner {
    Some(v) -> [#("assigner", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case type_ {
    Some(v) -> [#("type", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case use_ {
    Some(v) -> [#("use", valuesets.identifieruse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_patient_link_to_json(
  us_core_patient_link: UsCorePatientLink,
) -> Json {
  let UsCorePatientLink(type_:, other:, modifier_extension:, extension:, id:) =
    us_core_patient_link
  let fields = [
    #("type", valuesets.linktype_to_json(type_)),
    #("other", ct.reference_to_json(other)),
  ]
  let fields = case modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_patient_telecom_to_json(
  us_core_patient_telecom: UsCorePatientTelecom,
) -> Json {
  let UsCorePatientTelecom(
    period:,
    rank:,
    use_:,
    value:,
    system:,
    extension:,
    id:,
  ) = us_core_patient_telecom
  let fields = [
    #("value", json.string(value)),
    #("system", valuesets.contactpointsystem_to_json(system)),
  ]
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case rank {
    Some(v) -> [#("rank", json.int(v)), ..fields]
    None -> fields
  }
  let fields = case use_ {
    Some(v) -> [#("use", valuesets.contactpointuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

type UsCoreEthnicityExtensionAccumulator {
  UsCoreEthnicityExtensionAccumulator(
    text: Option(String),
    detailed: List(ct.BoundCoding(valuesets.Detailedethnicity)),
    omb_category: Option(ct.BoundCoding(valuesets.Ombethnicitycategory)),
    open: List(ct.Extension),
  )
}

fn parse_us_core_ethnicity(
  extension: ct.Extension,
) -> Result(ct.UsCoreEthnicity, String) {
  case extension.ext {
    ct.ExtComplex(children) -> {
      let accumulator: Result(UsCoreEthnicityExtensionAccumulator, String) =
        list.fold(
          children,
          Ok(UsCoreEthnicityExtensionAccumulator(None, [], None, [])),
          fn(accumulator_result, child) {
            case accumulator_result {
              Error(reason) -> Error(reason)
              Ok(accumulator) ->
                case child.url {
                  "text" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueString(value)) ->
                        Ok(
                          UsCoreEthnicityExtensionAccumulator(
                            ..accumulator,
                            text: Some(value),
                          ),
                        )
                      _ -> Error("extension text has invalid value")
                    }
                  "detailed" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueCoding(value)) ->
                        case
                          ct.bound_coding_from_coding(
                            value,
                            valuesets.detailedethnicity_from_code_and_system,
                          )
                        {
                          Ok(value) ->
                            Ok(
                              UsCoreEthnicityExtensionAccumulator(
                                ..accumulator,
                                detailed: [value, ..accumulator.detailed],
                              ),
                            )
                          Error(_) -> Error("invalid extension value")
                        }
                      _ -> Error("extension detailed has invalid value")
                    }
                  "ombCategory" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueCoding(value)) ->
                        case
                          ct.bound_coding_from_coding(
                            value,
                            valuesets.ombethnicitycategory_from_code_and_system,
                          )
                        {
                          Ok(value) ->
                            Ok(
                              UsCoreEthnicityExtensionAccumulator(
                                ..accumulator,
                                omb_category: Some(value),
                              ),
                            )
                          Error(_) -> Error("invalid extension value")
                        }
                      _ -> Error("extension ombCategory has invalid value")
                    }
                  _ ->
                    Ok(
                      UsCoreEthnicityExtensionAccumulator(..accumulator, open: [
                        child,
                        ..accumulator.open
                      ]),
                    )
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
    }
    _ -> Error("extension should contain child extensions")
  }
}

type UsCoreRaceExtensionAccumulator {
  UsCoreRaceExtensionAccumulator(
    text: Option(String),
    detailed: List(ct.BoundCoding(valuesets.Detailedrace)),
    omb_category: List(ct.BoundCoding(valuesets.Ombracecategory)),
    open: List(ct.Extension),
  )
}

fn parse_us_core_race(
  extension: ct.Extension,
) -> Result(ct.UsCoreRace, String) {
  case extension.ext {
    ct.ExtComplex(children) -> {
      let accumulator: Result(UsCoreRaceExtensionAccumulator, String) =
        list.fold(
          children,
          Ok(UsCoreRaceExtensionAccumulator(None, [], [], [])),
          fn(accumulator_result, child) {
            case accumulator_result {
              Error(reason) -> Error(reason)
              Ok(accumulator) ->
                case child.url {
                  "text" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueString(value)) ->
                        Ok(
                          UsCoreRaceExtensionAccumulator(
                            ..accumulator,
                            text: Some(value),
                          ),
                        )
                      _ -> Error("extension text has invalid value")
                    }
                  "detailed" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueCoding(value)) ->
                        case
                          ct.bound_coding_from_coding(
                            value,
                            valuesets.detailedrace_from_code_and_system,
                          )
                        {
                          Ok(value) ->
                            Ok(
                              UsCoreRaceExtensionAccumulator(
                                ..accumulator,
                                detailed: [value, ..accumulator.detailed],
                              ),
                            )
                          Error(_) -> Error("invalid extension value")
                        }
                      _ -> Error("extension detailed has invalid value")
                    }
                  "ombCategory" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueCoding(value)) ->
                        case
                          ct.bound_coding_from_coding(
                            value,
                            valuesets.ombracecategory_from_code_and_system,
                          )
                        {
                          Ok(value) ->
                            Ok(
                              UsCoreRaceExtensionAccumulator(
                                ..accumulator,
                                omb_category: [
                                  value,
                                  ..accumulator.omb_category
                                ],
                              ),
                            )
                          Error(_) -> Error("invalid extension value")
                        }
                      _ -> Error("extension ombCategory has invalid value")
                    }
                  _ ->
                    Ok(
                      UsCoreRaceExtensionAccumulator(..accumulator, open: [
                        child,
                        ..accumulator.open
                      ]),
                    )
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
    }
    _ -> Error("extension should contain child extensions")
  }
}

type UsCoreTribalAffiliationExtensionAccumulator {
  UsCoreTribalAffiliationExtensionAccumulator(
    is_enrolled: Option(Bool),
    tribal_affiliation: Option(ct.Codeableconcept),
    open: List(ct.Extension),
  )
}

fn parse_us_core_tribal_affiliation(
  extension: ct.Extension,
) -> Result(ct.UsCoreTribalAffiliation, String) {
  case extension.ext {
    ct.ExtComplex(children) -> {
      let accumulator: Result(
        UsCoreTribalAffiliationExtensionAccumulator,
        String,
      ) =
        list.fold(
          children,
          Ok(UsCoreTribalAffiliationExtensionAccumulator(None, None, [])),
          fn(accumulator_result, child) {
            case accumulator_result {
              Error(reason) -> Error(reason)
              Ok(accumulator) ->
                case child.url {
                  "isEnrolled" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueBoolean(value)) ->
                        Ok(
                          UsCoreTribalAffiliationExtensionAccumulator(
                            ..accumulator,
                            is_enrolled: Some(value),
                          ),
                        )
                      _ -> Error("extension isEnrolled has invalid value")
                    }
                  "tribalAffiliation" ->
                    case child.ext {
                      ct.ExtSimple(ct.ExtensionValueCodeableconcept(value)) ->
                        Ok(
                          UsCoreTribalAffiliationExtensionAccumulator(
                            ..accumulator,
                            tribal_affiliation: Some(value),
                          ),
                        )
                      _ ->
                        Error("extension tribalAffiliation has invalid value")
                    }
                  _ ->
                    Ok(
                      UsCoreTribalAffiliationExtensionAccumulator(
                        ..accumulator,
                        open: [child, ..accumulator.open],
                      ),
                    )
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
    }
    _ -> Error("extension should contain child extensions")
  }
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

pub fn us_core_patient_telecom_decoder() -> Decoder(UsCorePatientTelecom) {
  use <- decode.recursive
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use rank <- decode.optional_field("rank", None, decode.optional(decode.int))
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.contactpointuse_decoder()),
  )
  use value <- decode.field("value", decode.string)
  use system <- decode.field("system", valuesets.contactpointsystem_decoder())
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePatientTelecom(
      period:,
      rank:,
      use_:,
      value:,
      system:,
      extension:,
      id:,
    )
  decode.success(placeholder)
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

pub fn us_core_patient_identifier_decoder() -> Decoder(UsCorePatientIdentifier) {
  use <- decode.recursive
  use assigner <- decode.optional_field(
    "assigner",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use value <- decode.field("value", decode.string)
  use system <- decode.field("system", decode.string)
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.identifieruse_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePatientIdentifier(
      assigner:,
      period:,
      value:,
      system:,
      type_:,
      use_:,
      extension:,
      id:,
    )
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
    decode.list(us_core_patient_telecom_decoder()),
  )
  use name <- list1_decoder("name", ct.humanname_decoder())
  use active <- decode.optional_field(
    "active",
    None,
    decode.optional(decode.bool),
  )
  use identifier <- list1_decoder(
    "identifier",
    us_core_patient_identifier_decoder(),
  )
  use modifier_extension <- decode.optional_field(
    "modifierExtension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use extension_base_values <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
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
      fn(accumulator_result, extension, index) {
        case accumulator_result {
          Error(errors) -> Error(errors)
          Ok(accumulator) ->
            case extension.url {
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-genderIdentity" ->
                case extension.ext {
                  ct.ExtSimple(ct.ExtensionValueCodeableconcept(value)) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        gender_identity: [value, ..accumulator.gender_identity],
                      ),
                    )
                  _ ->
                    Error([
                      decode.DecodeError(
                        expected: "ct.Codeableconcept",
                        found: "invalid extension value",
                        path: ["extension", int.to_string(index)],
                      ),
                    ])
                }
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-sex" ->
                case extension.ext {
                  ct.ExtSimple(ct.ExtensionValueCode(value)) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        sex: Some(value),
                      ),
                    )
                  _ ->
                    Error([
                      decode.DecodeError(
                        expected: "String",
                        found: "invalid extension value",
                        path: ["extension", int.to_string(index)],
                      ),
                    ])
                }
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex" ->
                case extension.ext {
                  ct.ExtSimple(ct.ExtensionValueCode(value)) ->
                    case valuesets.two16840111376214102124_from_code(value) {
                      Ok(value) ->
                        Ok(
                          UsCorePatientExtensionSliceAccumulator(
                            ..accumulator,
                            birthsex: Some(value),
                          ),
                        )
                      Error(_) ->
                        Error([
                          decode.DecodeError(
                            expected: "valuesets.Two16840111376214102124",
                            found: "invalid extension value",
                            path: ["extension", int.to_string(index)],
                          ),
                        ])
                    }
                  _ ->
                    Error([
                      decode.DecodeError(
                        expected: "valuesets.Two16840111376214102124",
                        found: "invalid extension value",
                        path: ["extension", int.to_string(index)],
                      ),
                    ])
                }
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation" ->
                case parse_us_core_tribal_affiliation(extension) {
                  Ok(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        tribal_affiliation: [
                          value,
                          ..accumulator.tribal_affiliation
                        ],
                      ),
                    )
                  Error(reason) ->
                    Error([
                      decode.DecodeError(
                        expected: "ct.UsCoreTribalAffiliation",
                        found: reason,
                        path: ["extension", int.to_string(index)],
                      ),
                    ])
                }
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity" ->
                case parse_us_core_ethnicity(extension) {
                  Ok(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        ethnicity: Some(value),
                      ),
                    )
                  Error(reason) ->
                    Error([
                      decode.DecodeError(
                        expected: "ct.UsCoreEthnicity",
                        found: reason,
                        path: ["extension", int.to_string(index)],
                      ),
                    ])
                }
              "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race" ->
                case parse_us_core_race(extension) {
                  Ok(value) ->
                    Ok(
                      UsCorePatientExtensionSliceAccumulator(
                        ..accumulator,
                        race: Some(value),
                      ),
                    )
                  Error(reason) ->
                    Error([
                      decode.DecodeError(
                        expected: "ct.UsCoreRace",
                        found: reason,
                        path: ["extension", int.to_string(index)],
                      ),
                    ])
                }
              _ ->
                Ok(
                  UsCorePatientExtensionSliceAccumulator(..accumulator, open: [
                    extension,
                    ..accumulator.open
                  ]),
                )
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
  let extension_slices_decoder = case extension_slices {
    Ok(extension_slices) -> decode.success(extension_slices)
    Error(errors) ->
      decode.failure(
        UsCorePatientExtensionSlices([], None, None, [], None, None, []),
        "UsCorePatient slices",
      )
      |> decode.map_errors(fn(_) { errors })
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
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(resource_type) {
      case resource_type {
        "Patient" -> decode.success(resource_type)
        _ -> decode.failure(resource_type, "Patient")
      }
    }),
  )
  use extension_slices <- decode.then(extension_slices_decoder)
  let UsCorePatientExtensionSlices(
    gender_identity:,
    sex:,
    birthsex:,
    tribal_affiliation:,
    ethnicity:,
    race:,
    open: extension,
  ) = extension_slices
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
    gender_identity:,
    sex:,
    birthsex:,
    tribal_affiliation:,
    ethnicity:,
    race:,
    extension:,
    contained:,
    text:,
    language:,
    implicit_rules:,
    meta:,
    id:,
  ))
}

pub type UsCorePractitioner {
  UsCorePractitioner(
    id: Option(String),
    meta: Option(ct.Meta),
    implicit_rules: Option(String),
    language: Option(String),
    text: Option(ct.Narrative),
    contained: List(Resource),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    identifier: List1(UsCorePractitionerIdentifierComponent),
    active: Option(Bool),
    name: List1(UsCorePractitionerName),
    telecom: List(ct.Contactpoint),
    address: List(UsCorePractitionerAddress),
    gender: Option(valuesets.Administrativegender),
    birth_date: Option(Date),
    photo: List(ct.Attachment),
    qualification: List(UsCorePractitionerQualification),
    communication: List(ct.Codeableconcept),
  )
}

pub fn us_core_practitioner_new(
  identifier identifier: List1(UsCorePractitionerIdentifierComponent),
  name name: List1(UsCorePractitionerName),
) -> UsCorePractitioner {
  UsCorePractitioner(
    id: None,
    meta: Some(
      ct.Meta(
        id: None,
        extension: [],
        version_id: None,
        last_updated: None,
        source: None,
        profile: [
          "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner",
        ],
        security: [],
        tag: [],
      ),
    ),
    implicit_rules: None,
    language: None,
    text: None,
    contained: [],
    extension: [],
    modifier_extension: [],
    identifier:,
    active: None,
    name:,
    telecom: [],
    address: [],
    gender: None,
    birth_date: None,
    photo: [],
    qualification: [],
    communication: [],
  )
}

pub type UsCorePractitionerIdentifierComponent {
  UsCorePractitionerIdentifierComponentNpi(
    value: UsCorePractitionerIdentifierNpi,
  )
  UsCorePractitionerIdentifierComponentOpen(value: UsCorePractitionerIdentifier)
}

pub type UsCorePractitionerAddress {
  UsCorePractitionerAddress(
    id: Option(String),
    extension: List(ct.Extension),
    use_: Option(valuesets.Addressuse),
    type_: Option(valuesets.Addresstype),
    text: Option(String),
    line: List(String),
    city: Option(String),
    district: Option(String),
    state: Option(String),
    postal_code: Option(String),
    country: Option(String),
    period: Option(ct.Period),
  )
}

pub fn us_core_practitioner_address_new() -> UsCorePractitionerAddress {
  UsCorePractitionerAddress(
    id: None,
    extension: [],
    use_: None,
    type_: None,
    text: None,
    line: [],
    city: None,
    district: None,
    state: None,
    postal_code: None,
    country: None,
    period: None,
  )
}

pub type UsCorePractitionerIdentifier {
  UsCorePractitionerIdentifier(
    id: Option(String),
    extension: List(ct.Extension),
    use_: Option(valuesets.Identifieruse),
    type_: Option(ct.Codeableconcept),
    system: String,
    value: String,
    period: Option(ct.Period),
    assigner: Option(ct.Reference),
  )
}

pub fn us_core_practitioner_identifier_new(
  system system: String,
  value value: String,
) -> UsCorePractitionerIdentifier {
  UsCorePractitionerIdentifier(
    id: None,
    extension: [],
    use_: None,
    type_: None,
    system:,
    value:,
    period: None,
    assigner: None,
  )
}

pub type UsCorePractitionerIdentifierNpi {
  UsCorePractitionerIdentifierNpi(
    id: Option(String),
    extension: List(ct.Extension),
    use_: Option(valuesets.Identifieruse),
    type_: Option(ct.Codeableconcept),
    value: String,
    period: Option(ct.Period),
    assigner: Option(ct.Reference),
  )
}

pub fn us_core_practitioner_identifier_npi_new(
  value value: String,
) -> UsCorePractitionerIdentifierNpi {
  UsCorePractitionerIdentifierNpi(
    id: None,
    extension: [],
    use_: None,
    type_: None,
    value:,
    period: None,
    assigner: None,
  )
}

pub type UsCorePractitionerName {
  UsCorePractitionerName(
    id: Option(String),
    extension: List(ct.Extension),
    use_: Option(valuesets.Nameuse),
    text: Option(String),
    family: String,
    given: List(String),
    prefix: List(String),
    suffix: List(String),
    period: Option(ct.Period),
  )
}

pub fn us_core_practitioner_name_new(
  family family: String,
) -> UsCorePractitionerName {
  UsCorePractitionerName(
    id: None,
    extension: [],
    use_: None,
    text: None,
    family:,
    given: [],
    prefix: [],
    suffix: [],
    period: None,
  )
}

pub type UsCorePractitionerQualification {
  UsCorePractitionerQualification(
    id: Option(String),
    extension: List(ct.Extension),
    modifier_extension: List(ct.Extension),
    identifier: List(ct.Identifier),
    code: ct.Codeableconcept,
    period: Option(ct.Period),
    issuer: Option(ct.Reference),
  )
}

pub fn us_core_practitioner_qualification_new(
  code code: ct.Codeableconcept,
) -> UsCorePractitionerQualification {
  UsCorePractitionerQualification(
    id: None,
    extension: [],
    modifier_extension: [],
    identifier: [],
    code:,
    period: None,
    issuer: None,
  )
}

pub fn us_core_practitioner_to_json(
  us_core_practitioner: UsCorePractitioner,
) -> Json {
  let UsCorePractitioner(
    communication:,
    qualification:,
    photo:,
    birth_date:,
    gender:,
    address:,
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
  ) = us_core_practitioner
  let fields = [
    #("name", list1_to_json(name, us_core_practitioner_name_to_json)),
    #(
      "identifier",
      list1_to_json(
        identifier,
        us_core_practitioner_identifier_component_to_json,
      ),
    ),
  ]
  let fields = case communication {
    [] -> fields
    values -> [
      #("communication", json.array(values, ct.codeableconcept_to_json)),
      ..fields
    ]
  }
  let fields = case qualification {
    [] -> fields
    values -> [
      #(
        "qualification",
        json.array(values, us_core_practitioner_qualification_to_json),
      ),
      ..fields
    ]
  }
  let fields = case photo {
    [] -> fields
    values -> [#("photo", json.array(values, ct.attachment_to_json)), ..fields]
  }
  let fields = case birth_date {
    Some(v) -> [#("birthDate", pt.date_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case gender {
    Some(v) -> [
      #("gender", valuesets.administrativegender_to_json(v)),
      ..fields
    ]
    None -> fields
  }
  let fields = case address {
    [] -> fields
    values -> [
      #("address", json.array(values, us_core_practitioner_address_to_json)),
      ..fields
    ]
  }
  let fields = case telecom {
    [] -> fields
    values -> [
      #("telecom", json.array(values, ct.contactpoint_to_json)),
      ..fields
    ]
  }
  let fields = case active {
    Some(v) -> [#("active", json.bool(v)), ..fields]
    None -> fields
  }
  let fields = case modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case contained {
    [] -> fields
    values -> [#("contained", json.array(values, resource_to_json)), ..fields]
  }
  let fields = case text {
    Some(v) -> [#("text", ct.narrative_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case language {
    Some(v) -> [#("language", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case implicit_rules {
    Some(v) -> [#("implicitRules", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case meta {
    Some(v) -> [#("meta", ct.meta_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  let fields = [#("resourceType", json.string("Practitioner")), ..fields]
  json.object(fields)
}

pub fn us_core_practitioner_identifier_component_to_json(
  value: UsCorePractitionerIdentifierComponent,
) -> Json {
  case value {
    UsCorePractitionerIdentifierComponentNpi(value) ->
      us_core_practitioner_identifier_npi_to_json(value)
    UsCorePractitionerIdentifierComponentOpen(value) ->
      us_core_practitioner_identifier_to_json(value)
  }
}

pub fn us_core_practitioner_address_to_json(
  us_core_practitioner_address: UsCorePractitionerAddress,
) -> Json {
  let UsCorePractitionerAddress(
    period:,
    country:,
    postal_code:,
    state:,
    district:,
    city:,
    line:,
    text:,
    type_:,
    use_:,
    extension:,
    id:,
  ) = us_core_practitioner_address
  let fields = []
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case country {
    Some(v) -> [#("country", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case postal_code {
    Some(v) -> [#("postalCode", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case state {
    Some(v) -> [#("state", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case district {
    Some(v) -> [#("district", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case city {
    Some(v) -> [#("city", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case line {
    [] -> fields
    values -> [#("line", json.array(values, json.string)), ..fields]
  }
  let fields = case text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case type_ {
    Some(v) -> [#("type", valuesets.addresstype_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case use_ {
    Some(v) -> [#("use", valuesets.addressuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_practitioner_identifier_to_json(
  us_core_practitioner_identifier: UsCorePractitionerIdentifier,
) -> Json {
  let UsCorePractitionerIdentifier(
    assigner:,
    period:,
    value:,
    system:,
    type_:,
    use_:,
    extension:,
    id:,
  ) = us_core_practitioner_identifier
  let fields = [
    #("value", json.string(value)),
    #("system", json.string(system)),
  ]
  let fields = case assigner {
    Some(v) -> [#("assigner", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case type_ {
    Some(v) -> [#("type", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case use_ {
    Some(v) -> [#("use", valuesets.identifieruse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_practitioner_identifier_npi_to_json(
  us_core_practitioner_identifier_npi: UsCorePractitionerIdentifierNpi,
) -> Json {
  let UsCorePractitionerIdentifierNpi(
    assigner:,
    period:,
    value:,
    type_:,
    use_:,
    extension:,
    id:,
  ) = us_core_practitioner_identifier_npi
  let fields = [
    #("system", json.string("http://hl7.org/fhir/sid/us-npi")),
    #("value", json.string(value)),
  ]
  let fields = case assigner {
    Some(v) -> [#("assigner", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case type_ {
    Some(v) -> [#("type", ct.codeableconcept_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case use_ {
    Some(v) -> [#("use", valuesets.identifieruse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_practitioner_name_to_json(
  us_core_practitioner_name: UsCorePractitionerName,
) -> Json {
  let UsCorePractitionerName(
    period:,
    suffix:,
    prefix:,
    given:,
    family:,
    text:,
    use_:,
    extension:,
    id:,
  ) = us_core_practitioner_name
  let fields = [
    #("family", json.string(family)),
  ]
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case suffix {
    [] -> fields
    values -> [#("suffix", json.array(values, json.string)), ..fields]
  }
  let fields = case prefix {
    [] -> fields
    values -> [#("prefix", json.array(values, json.string)), ..fields]
  }
  let fields = case given {
    [] -> fields
    values -> [#("given", json.array(values, json.string)), ..fields]
  }
  let fields = case text {
    Some(v) -> [#("text", json.string(v)), ..fields]
    None -> fields
  }
  let fields = case use_ {
    Some(v) -> [#("use", valuesets.nameuse_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

pub fn us_core_practitioner_qualification_to_json(
  us_core_practitioner_qualification: UsCorePractitionerQualification,
) -> Json {
  let UsCorePractitionerQualification(
    issuer:,
    period:,
    code:,
    identifier:,
    modifier_extension:,
    extension:,
    id:,
  ) = us_core_practitioner_qualification
  let fields = [
    #("code", ct.codeableconcept_to_json(code)),
  ]
  let fields = case issuer {
    Some(v) -> [#("issuer", ct.reference_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case period {
    Some(v) -> [#("period", ct.period_to_json(v)), ..fields]
    None -> fields
  }
  let fields = case identifier {
    [] -> fields
    values -> [
      #("identifier", json.array(values, ct.identifier_to_json)),
      ..fields
    ]
  }
  let fields = case modifier_extension {
    [] -> fields
    values -> [
      #("modifierExtension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case extension {
    [] -> fields
    values -> [
      #("extension", json.array(values, ct.extension_to_json)),
      ..fields
    ]
  }
  let fields = case id {
    Some(v) -> [#("id", json.string(v)), ..fields]
    None -> fields
  }
  json.object(fields)
}

type UsCorePractitionerIdentifierComponentSliceAccumulator {
  UsCorePractitionerIdentifierComponentSliceAccumulator(
    values: List(UsCorePractitionerIdentifierComponent),
  )
}

pub fn us_core_practitioner_qualification_decoder() -> Decoder(
  UsCorePractitionerQualification,
) {
  use <- decode.recursive
  use issuer <- decode.optional_field(
    "issuer",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use code <- decode.field("code", ct.codeableconcept_decoder())
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
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePractitionerQualification(
      issuer:,
      period:,
      code:,
      identifier:,
      modifier_extension:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_practitioner_name_decoder() -> Decoder(UsCorePractitionerName) {
  use <- decode.recursive
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use suffix <- decode.optional_field("suffix", [], decode.list(decode.string))
  use prefix <- decode.optional_field("prefix", [], decode.list(decode.string))
  use given <- decode.optional_field("given", [], decode.list(decode.string))
  use family <- decode.field("family", decode.string)
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(decode.string),
  )
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.nameuse_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePractitionerName(
      period:,
      suffix:,
      prefix:,
      given:,
      family:,
      text:,
      use_:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_practitioner_identifier_npi_decoder() -> Decoder(
  UsCorePractitionerIdentifierNpi,
) {
  use <- decode.recursive
  use assigner <- decode.optional_field(
    "assigner",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use value <- decode.field("value", decode.string)
  use system_fixed <- decode.field("system", decode.string)
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.identifieruse_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePractitionerIdentifierNpi(
      assigner:,
      period:,
      value:,
      type_:,
      use_:,
      extension:,
      id:,
    )
  use <- bool.guard(
    system_fixed != "http://hl7.org/fhir/sid/us-npi",
    decode.failure(placeholder, "fixed system"),
  )
  decode.success(placeholder)
}

pub fn us_core_practitioner_identifier_decoder() -> Decoder(
  UsCorePractitionerIdentifier,
) {
  use <- decode.recursive
  use assigner <- decode.optional_field(
    "assigner",
    None,
    decode.optional(ct.reference_decoder()),
  )
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use value <- decode.field("value", decode.string)
  use system <- decode.field("system", decode.string)
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(ct.codeableconcept_decoder()),
  )
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.identifieruse_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePractitionerIdentifier(
      assigner:,
      period:,
      value:,
      system:,
      type_:,
      use_:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_practitioner_address_decoder() -> Decoder(
  UsCorePractitionerAddress,
) {
  use <- decode.recursive
  use period <- decode.optional_field(
    "period",
    None,
    decode.optional(ct.period_decoder()),
  )
  use country <- decode.optional_field(
    "country",
    None,
    decode.optional(decode.string),
  )
  use postal_code <- decode.optional_field(
    "postalCode",
    None,
    decode.optional(decode.string),
  )
  use state <- decode.optional_field(
    "state",
    None,
    decode.optional(decode.string),
  )
  use district <- decode.optional_field(
    "district",
    None,
    decode.optional(decode.string),
  )
  use city <- decode.optional_field(
    "city",
    None,
    decode.optional(decode.string),
  )
  use line <- decode.optional_field("line", [], decode.list(decode.string))
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(decode.string),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(valuesets.addresstype_decoder()),
  )
  use use_ <- decode.optional_field(
    "use",
    None,
    decode.optional(valuesets.addressuse_decoder()),
  )
  use extension <- decode.optional_field(
    "extension",
    [],
    decode.list(ct.extension_decoder()),
  )
  use id <- decode.optional_field("id", None, decode.optional(decode.string))
  let placeholder =
    UsCorePractitionerAddress(
      period:,
      country:,
      postal_code:,
      state:,
      district:,
      city:,
      line:,
      text:,
      type_:,
      use_:,
      extension:,
      id:,
    )
  decode.success(placeholder)
}

pub fn us_core_practitioner_decoder() -> Decoder(UsCorePractitioner) {
  use <- decode.recursive
  use communication <- decode.optional_field(
    "communication",
    [],
    decode.list(ct.codeableconcept_decoder()),
  )
  use qualification <- decode.optional_field(
    "qualification",
    [],
    decode.list(us_core_practitioner_qualification_decoder()),
  )
  use photo <- decode.optional_field(
    "photo",
    [],
    decode.list(ct.attachment_decoder()),
  )
  use birth_date <- decode.optional_field(
    "birthDate",
    None,
    decode.optional(pt.date_decoder()),
  )
  use gender <- decode.optional_field(
    "gender",
    None,
    decode.optional(valuesets.administrativegender_decoder()),
  )
  use address <- decode.optional_field(
    "address",
    [],
    decode.list(us_core_practitioner_address_decoder()),
  )
  use telecom <- decode.optional_field(
    "telecom",
    [],
    decode.list(ct.contactpoint_decoder()),
  )
  use name <- list1_decoder("name", us_core_practitioner_name_decoder())
  use active <- decode.optional_field(
    "active",
    None,
    decode.optional(decode.bool),
  )
  use identifier_base_values <- decode.optional_field(
    "identifier",
    [],
    decode.list(us_core_practitioner_identifier_decoder()),
  )
  let identifier_accumulator =
    list.fold(
      identifier_base_values,
      Ok(UsCorePractitionerIdentifierComponentSliceAccumulator([])),
      fn(accumulator_result, identifier) {
        let parsed: Result(
          UsCorePractitionerIdentifierComponent,
          List(decode.DecodeError),
        ) = case
          case identifier.system == "http://hl7.org/fhir/sid/us-npi" {
            True -> Ok(identifier.system)
            False -> Error(Nil)
          }
        {
          Ok(_) ->
            Ok(
              UsCorePractitionerIdentifierComponentNpi(
                UsCorePractitionerIdentifierNpi(
                  assigner: identifier.assigner,
                  period: identifier.period,
                  value: identifier.value,
                  type_: identifier.type_,
                  use_: identifier.use_,
                  extension: identifier.extension,
                  id: identifier.id,
                ),
              ),
            )
          Error(_) -> Ok(UsCorePractitionerIdentifierComponentOpen(identifier))
        }
        case accumulator_result, parsed {
          Ok(accumulator), Ok(value) ->
            Ok(
              UsCorePractitionerIdentifierComponentSliceAccumulator([
                value,
                ..accumulator.values
              ]),
            )
          Ok(_), Error(errors) -> Error(errors)
          Error(errors), Ok(_) -> Error(errors)
          Error(errors), Error(new_errors) ->
            Error(list.append(new_errors, errors))
        }
      },
    )
  let identifier_slices = case identifier_accumulator {
    Ok(UsCorePractitionerIdentifierComponentSliceAccumulator(values:)) ->
      case list.reverse(values) {
        [first, ..rest] -> Ok(ct.List1(first:, rest:))
        [] ->
          Error([
            decode.DecodeError(
              expected: "at least 1 identifier",
              found: int.to_string(list.length(list.reverse(values)))
                <> " identifiers",
              path: ["identifier"],
            ),
          ])
      }
    Error(errors) -> Error(errors)
  }
  let identifier_slices_decoder = case identifier_slices {
    Ok(identifier_slices) -> decode.success(identifier_slices)
    Error(errors) ->
      decode.failure(
        ct.List1(
          first: UsCorePractitionerIdentifierComponentOpen(
            us_core_practitioner_identifier_new(value: "", system: ""),
          ),
          rest: [],
        ),
        "UsCorePractitioner slices",
      )
      |> decode.map_errors(fn(_) { errors })
  }
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
  use _ <- decode.field(
    "resourceType",
    decode.then(decode.string, fn(resource_type) {
      case resource_type {
        "Practitioner" -> decode.success(resource_type)
        _ -> decode.failure(resource_type, "Practitioner")
      }
    }),
  )
  use identifier_slices <- decode.then(identifier_slices_decoder)
  let identifier = identifier_slices
  decode.success(UsCorePractitioner(
    communication:,
    qualification:,
    photo:,
    birth_date:,
    gender:,
    address:,
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

pub type ResourceType {
  RtBundle
  RtOperationoutcome
  RtParameters
  RtPatient
  RtPractitioner
}

pub fn resource_type_to_string(resource_type: ResourceType) -> String {
  case resource_type {
    RtBundle -> "Bundle"
    RtOperationoutcome -> "OperationOutcome"
    RtParameters -> "Parameters"
    RtPatient -> "Patient"
    RtPractitioner -> "Practitioner"
  }
}

pub type Resource {
  ResourceBundle(Bundle)
  ResourceOperationoutcome(Operationoutcome)
  ResourceParameters(Parameters)
  ResourceUsCorePatient(UsCorePatient)
  ResourceUsCorePractitioner(UsCorePractitioner)
}

pub fn resource_to_json(resource: Resource) {
  case resource {
    ResourceBundle(resource) -> bundle_to_json(resource)
    ResourceOperationoutcome(resource) -> operationoutcome_to_json(resource)
    ResourceParameters(resource) -> parameters_to_json(resource)
    ResourceUsCorePatient(resource) -> us_core_patient_to_json(resource)
    ResourceUsCorePractitioner(resource) ->
      us_core_practitioner_to_json(resource)
  }
}

pub fn resource_decoder() -> Decoder(Resource) {
  use tag <- decode.field("resourceType", decode.string)
  case tag {
    "Bundle" -> bundle_decoder() |> decode.map(ResourceBundle)
    "OperationOutcome" ->
      operationoutcome_decoder() |> decode.map(ResourceOperationoutcome)
    "Parameters" -> parameters_decoder() |> decode.map(ResourceParameters)
    "Patient" -> us_core_patient_decoder() |> decode.map(ResourceUsCorePatient)
    "Practitioner" ->
      us_core_practitioner_decoder() |> decode.map(ResourceUsCorePractitioner)
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
