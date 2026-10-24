////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) valuesets

import gleam/dynamic/decode.{type Decoder}
import gleam/json.{type Json}
import gleam/list
import gleam/string

fn not_included_failure(
  variant: String,
  placeholder: a,
  name: String,
  values: List(a),
  to_code: fn(a) -> String,
) -> Decoder(a) {
  let expected =
    "code from valueset "
    <> name
    <> " ["
    <> { values |> list.map(to_code) |> string.join(", ") }
    <> "]"

  decode.failure(placeholder, expected)
  |> decode.map_errors(fn(_) {
    [decode.DecodeError(expected:, found: variant, path: [])]
  })
}

pub type Bundletype {
  BundletypeDocument
  BundletypeMessage
  BundletypeTransaction
  BundletypeTransactionresponse
  BundletypeBatch
  BundletypeBatchresponse
  BundletypeHistory
  BundletypeSearchset
  BundletypeCollection
}

pub const bundletype: List(Bundletype) = [
  BundletypeDocument,
  BundletypeMessage,
  BundletypeTransaction,
  BundletypeTransactionresponse,
  BundletypeBatch,
  BundletypeBatchresponse,
  BundletypeHistory,
  BundletypeSearchset,
  BundletypeCollection,
]

pub fn bundletype_to_json(bundletype: Bundletype) -> Json {
  json.string(bundletype_to_code(bundletype))
}

pub fn bundletype_to_code(bundletype: Bundletype) -> String {
  case bundletype {
    BundletypeDocument -> "document"
    BundletypeMessage -> "message"
    BundletypeTransaction -> "transaction"
    BundletypeTransactionresponse -> "transaction-response"
    BundletypeBatch -> "batch"
    BundletypeBatchresponse -> "batch-response"
    BundletypeHistory -> "history"
    BundletypeSearchset -> "searchset"
    BundletypeCollection -> "collection"
  }
}

pub fn bundletype_from_code(code: String) -> Result(Bundletype, Nil) {
  case code {
    "document" -> Ok(BundletypeDocument)
    "message" -> Ok(BundletypeMessage)
    "transaction" -> Ok(BundletypeTransaction)
    "transaction-response" -> Ok(BundletypeTransactionresponse)
    "batch" -> Ok(BundletypeBatch)
    "batch-response" -> Ok(BundletypeBatchresponse)
    "history" -> Ok(BundletypeHistory)
    "searchset" -> Ok(BundletypeSearchset)
    "collection" -> Ok(BundletypeCollection)
    _ -> Error(Nil)
  }
}

pub fn bundletype_decoder() -> Decoder(Bundletype) {
  use variant <- decode.then(decode.string)
  case bundletype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        BundletypeDocument,
        "Bundletype",
        bundletype,
        bundletype_to_code,
      )
  }
}

pub type Issueseverity {
  IssueseverityFatal
  IssueseverityError
  IssueseverityWarning
  IssueseverityInformation
}

pub const issueseverity: List(Issueseverity) = [
  IssueseverityFatal,
  IssueseverityError,
  IssueseverityWarning,
  IssueseverityInformation,
]

pub fn issueseverity_to_json(issueseverity: Issueseverity) -> Json {
  json.string(issueseverity_to_code(issueseverity))
}

pub fn issueseverity_to_code(issueseverity: Issueseverity) -> String {
  case issueseverity {
    IssueseverityFatal -> "fatal"
    IssueseverityError -> "error"
    IssueseverityWarning -> "warning"
    IssueseverityInformation -> "information"
  }
}

pub fn issueseverity_from_code(code: String) -> Result(Issueseverity, Nil) {
  case code {
    "fatal" -> Ok(IssueseverityFatal)
    "error" -> Ok(IssueseverityError)
    "warning" -> Ok(IssueseverityWarning)
    "information" -> Ok(IssueseverityInformation)
    _ -> Error(Nil)
  }
}

pub fn issueseverity_decoder() -> Decoder(Issueseverity) {
  use variant <- decode.then(decode.string)
  case issueseverity_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        IssueseverityFatal,
        "Issueseverity",
        issueseverity,
        issueseverity_to_code,
      )
  }
}

pub type Issuetype {
  IssuetypeInvalid
  IssuetypeStructure
  IssuetypeRequired
  IssuetypeValue
  IssuetypeInvariant
  IssuetypeSecurity
  IssuetypeLogin
  IssuetypeUnknown
  IssuetypeExpired
  IssuetypeForbidden
  IssuetypeSuppressed
  IssuetypeProcessing
  IssuetypeNotsupported
  IssuetypeDuplicate
  IssuetypeMultiplematches
  IssuetypeNotfound
  IssuetypeDeleted
  IssuetypeToolong
  IssuetypeCodeinvalid
  IssuetypeExtension
  IssuetypeToocostly
  IssuetypeBusinessrule
  IssuetypeConflict
  IssuetypeTransient
  IssuetypeLockerror
  IssuetypeNostore
  IssuetypeException
  IssuetypeTimeout
  IssuetypeIncomplete
  IssuetypeThrottled
  IssuetypeInformational
}

pub const issuetype: List(Issuetype) = [
  IssuetypeInvalid,
  IssuetypeStructure,
  IssuetypeRequired,
  IssuetypeValue,
  IssuetypeInvariant,
  IssuetypeSecurity,
  IssuetypeLogin,
  IssuetypeUnknown,
  IssuetypeExpired,
  IssuetypeForbidden,
  IssuetypeSuppressed,
  IssuetypeProcessing,
  IssuetypeNotsupported,
  IssuetypeDuplicate,
  IssuetypeMultiplematches,
  IssuetypeNotfound,
  IssuetypeDeleted,
  IssuetypeToolong,
  IssuetypeCodeinvalid,
  IssuetypeExtension,
  IssuetypeToocostly,
  IssuetypeBusinessrule,
  IssuetypeConflict,
  IssuetypeTransient,
  IssuetypeLockerror,
  IssuetypeNostore,
  IssuetypeException,
  IssuetypeTimeout,
  IssuetypeIncomplete,
  IssuetypeThrottled,
  IssuetypeInformational,
]

pub fn issuetype_to_json(issuetype: Issuetype) -> Json {
  json.string(issuetype_to_code(issuetype))
}

pub fn issuetype_to_code(issuetype: Issuetype) -> String {
  case issuetype {
    IssuetypeInvalid -> "invalid"
    IssuetypeStructure -> "structure"
    IssuetypeRequired -> "required"
    IssuetypeValue -> "value"
    IssuetypeInvariant -> "invariant"
    IssuetypeSecurity -> "security"
    IssuetypeLogin -> "login"
    IssuetypeUnknown -> "unknown"
    IssuetypeExpired -> "expired"
    IssuetypeForbidden -> "forbidden"
    IssuetypeSuppressed -> "suppressed"
    IssuetypeProcessing -> "processing"
    IssuetypeNotsupported -> "not-supported"
    IssuetypeDuplicate -> "duplicate"
    IssuetypeMultiplematches -> "multiple-matches"
    IssuetypeNotfound -> "not-found"
    IssuetypeDeleted -> "deleted"
    IssuetypeToolong -> "too-long"
    IssuetypeCodeinvalid -> "code-invalid"
    IssuetypeExtension -> "extension"
    IssuetypeToocostly -> "too-costly"
    IssuetypeBusinessrule -> "business-rule"
    IssuetypeConflict -> "conflict"
    IssuetypeTransient -> "transient"
    IssuetypeLockerror -> "lock-error"
    IssuetypeNostore -> "no-store"
    IssuetypeException -> "exception"
    IssuetypeTimeout -> "timeout"
    IssuetypeIncomplete -> "incomplete"
    IssuetypeThrottled -> "throttled"
    IssuetypeInformational -> "informational"
  }
}

pub fn issuetype_from_code(code: String) -> Result(Issuetype, Nil) {
  case code {
    "invalid" -> Ok(IssuetypeInvalid)
    "structure" -> Ok(IssuetypeStructure)
    "required" -> Ok(IssuetypeRequired)
    "value" -> Ok(IssuetypeValue)
    "invariant" -> Ok(IssuetypeInvariant)
    "security" -> Ok(IssuetypeSecurity)
    "login" -> Ok(IssuetypeLogin)
    "unknown" -> Ok(IssuetypeUnknown)
    "expired" -> Ok(IssuetypeExpired)
    "forbidden" -> Ok(IssuetypeForbidden)
    "suppressed" -> Ok(IssuetypeSuppressed)
    "processing" -> Ok(IssuetypeProcessing)
    "not-supported" -> Ok(IssuetypeNotsupported)
    "duplicate" -> Ok(IssuetypeDuplicate)
    "multiple-matches" -> Ok(IssuetypeMultiplematches)
    "not-found" -> Ok(IssuetypeNotfound)
    "deleted" -> Ok(IssuetypeDeleted)
    "too-long" -> Ok(IssuetypeToolong)
    "code-invalid" -> Ok(IssuetypeCodeinvalid)
    "extension" -> Ok(IssuetypeExtension)
    "too-costly" -> Ok(IssuetypeToocostly)
    "business-rule" -> Ok(IssuetypeBusinessrule)
    "conflict" -> Ok(IssuetypeConflict)
    "transient" -> Ok(IssuetypeTransient)
    "lock-error" -> Ok(IssuetypeLockerror)
    "no-store" -> Ok(IssuetypeNostore)
    "exception" -> Ok(IssuetypeException)
    "timeout" -> Ok(IssuetypeTimeout)
    "incomplete" -> Ok(IssuetypeIncomplete)
    "throttled" -> Ok(IssuetypeThrottled)
    "informational" -> Ok(IssuetypeInformational)
    _ -> Error(Nil)
  }
}

pub fn issuetype_decoder() -> Decoder(Issuetype) {
  use variant <- decode.then(decode.string)
  case issuetype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        IssuetypeInvalid,
        "Issuetype",
        issuetype,
        issuetype_to_code,
      )
  }
}
