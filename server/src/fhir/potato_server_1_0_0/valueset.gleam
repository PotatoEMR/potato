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

pub type BundleType {
  BundleTypeDocument
  BundleTypeMessage
  BundleTypeTransaction
  BundleTypeTransactionresponse
  BundleTypeBatch
  BundleTypeBatchresponse
  BundleTypeHistory
  BundleTypeSearchset
  BundleTypeCollection
}

pub const bundle_type: List(BundleType) = [
  BundleTypeDocument,
  BundleTypeMessage,
  BundleTypeTransaction,
  BundleTypeTransactionresponse,
  BundleTypeBatch,
  BundleTypeBatchresponse,
  BundleTypeHistory,
  BundleTypeSearchset,
  BundleTypeCollection,
]

pub fn bundle_type_to_json(bundle_type: BundleType) -> Json {
  json.string(bundle_type_to_code(bundle_type))
}

pub fn bundle_type_to_code(bundle_type: BundleType) -> String {
  case bundle_type {
    BundleTypeDocument -> "document"
    BundleTypeMessage -> "message"
    BundleTypeTransaction -> "transaction"
    BundleTypeTransactionresponse -> "transaction-response"
    BundleTypeBatch -> "batch"
    BundleTypeBatchresponse -> "batch-response"
    BundleTypeHistory -> "history"
    BundleTypeSearchset -> "searchset"
    BundleTypeCollection -> "collection"
  }
}

pub fn bundle_type_parse_code(code: String) -> Result(BundleType, Nil) {
  case code {
    "document" -> Ok(BundleTypeDocument)
    "message" -> Ok(BundleTypeMessage)
    "transaction" -> Ok(BundleTypeTransaction)
    "transaction-response" -> Ok(BundleTypeTransactionresponse)
    "batch" -> Ok(BundleTypeBatch)
    "batch-response" -> Ok(BundleTypeBatchresponse)
    "history" -> Ok(BundleTypeHistory)
    "searchset" -> Ok(BundleTypeSearchset)
    "collection" -> Ok(BundleTypeCollection)
    _ -> Error(Nil)
  }
}

pub fn bundle_type_decoder() -> Decoder(BundleType) {
  use variant <- decode.then(decode.string)
  case bundle_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        BundleTypeDocument,
        "BundleType",
        bundle_type,
        bundle_type_to_code,
      )
  }
}

pub type IssueSeverity {
  IssueSeverityFatal
  IssueSeverityError
  IssueSeverityWarning
  IssueSeverityInformation
}

pub const issue_severity: List(IssueSeverity) = [
  IssueSeverityFatal,
  IssueSeverityError,
  IssueSeverityWarning,
  IssueSeverityInformation,
]

pub fn issue_severity_to_json(issue_severity: IssueSeverity) -> Json {
  json.string(issue_severity_to_code(issue_severity))
}

pub fn issue_severity_to_code(issue_severity: IssueSeverity) -> String {
  case issue_severity {
    IssueSeverityFatal -> "fatal"
    IssueSeverityError -> "error"
    IssueSeverityWarning -> "warning"
    IssueSeverityInformation -> "information"
  }
}

pub fn issue_severity_parse_code(code: String) -> Result(IssueSeverity, Nil) {
  case code {
    "fatal" -> Ok(IssueSeverityFatal)
    "error" -> Ok(IssueSeverityError)
    "warning" -> Ok(IssueSeverityWarning)
    "information" -> Ok(IssueSeverityInformation)
    _ -> Error(Nil)
  }
}

pub fn issue_severity_decoder() -> Decoder(IssueSeverity) {
  use variant <- decode.then(decode.string)
  case issue_severity_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        IssueSeverityFatal,
        "IssueSeverity",
        issue_severity,
        issue_severity_to_code,
      )
  }
}

pub type IssueType {
  IssueTypeInvalid
  IssueTypeStructure
  IssueTypeRequired
  IssueTypeValue
  IssueTypeInvariant
  IssueTypeSecurity
  IssueTypeLogin
  IssueTypeUnknown
  IssueTypeExpired
  IssueTypeForbidden
  IssueTypeSuppressed
  IssueTypeProcessing
  IssueTypeNotsupported
  IssueTypeDuplicate
  IssueTypeMultiplematches
  IssueTypeNotfound
  IssueTypeDeleted
  IssueTypeToolong
  IssueTypeCodeinvalid
  IssueTypeExtension
  IssueTypeToocostly
  IssueTypeBusinessrule
  IssueTypeConflict
  IssueTypeTransient
  IssueTypeLockerror
  IssueTypeNostore
  IssueTypeException
  IssueTypeTimeout
  IssueTypeIncomplete
  IssueTypeThrottled
  IssueTypeInformational
}

pub const issue_type: List(IssueType) = [
  IssueTypeInvalid,
  IssueTypeStructure,
  IssueTypeRequired,
  IssueTypeValue,
  IssueTypeInvariant,
  IssueTypeSecurity,
  IssueTypeLogin,
  IssueTypeUnknown,
  IssueTypeExpired,
  IssueTypeForbidden,
  IssueTypeSuppressed,
  IssueTypeProcessing,
  IssueTypeNotsupported,
  IssueTypeDuplicate,
  IssueTypeMultiplematches,
  IssueTypeNotfound,
  IssueTypeDeleted,
  IssueTypeToolong,
  IssueTypeCodeinvalid,
  IssueTypeExtension,
  IssueTypeToocostly,
  IssueTypeBusinessrule,
  IssueTypeConflict,
  IssueTypeTransient,
  IssueTypeLockerror,
  IssueTypeNostore,
  IssueTypeException,
  IssueTypeTimeout,
  IssueTypeIncomplete,
  IssueTypeThrottled,
  IssueTypeInformational,
]

pub fn issue_type_to_json(issue_type: IssueType) -> Json {
  json.string(issue_type_to_code(issue_type))
}

pub fn issue_type_to_code(issue_type: IssueType) -> String {
  case issue_type {
    IssueTypeInvalid -> "invalid"
    IssueTypeStructure -> "structure"
    IssueTypeRequired -> "required"
    IssueTypeValue -> "value"
    IssueTypeInvariant -> "invariant"
    IssueTypeSecurity -> "security"
    IssueTypeLogin -> "login"
    IssueTypeUnknown -> "unknown"
    IssueTypeExpired -> "expired"
    IssueTypeForbidden -> "forbidden"
    IssueTypeSuppressed -> "suppressed"
    IssueTypeProcessing -> "processing"
    IssueTypeNotsupported -> "not-supported"
    IssueTypeDuplicate -> "duplicate"
    IssueTypeMultiplematches -> "multiple-matches"
    IssueTypeNotfound -> "not-found"
    IssueTypeDeleted -> "deleted"
    IssueTypeToolong -> "too-long"
    IssueTypeCodeinvalid -> "code-invalid"
    IssueTypeExtension -> "extension"
    IssueTypeToocostly -> "too-costly"
    IssueTypeBusinessrule -> "business-rule"
    IssueTypeConflict -> "conflict"
    IssueTypeTransient -> "transient"
    IssueTypeLockerror -> "lock-error"
    IssueTypeNostore -> "no-store"
    IssueTypeException -> "exception"
    IssueTypeTimeout -> "timeout"
    IssueTypeIncomplete -> "incomplete"
    IssueTypeThrottled -> "throttled"
    IssueTypeInformational -> "informational"
  }
}

pub fn issue_type_parse_code(code: String) -> Result(IssueType, Nil) {
  case code {
    "invalid" -> Ok(IssueTypeInvalid)
    "structure" -> Ok(IssueTypeStructure)
    "required" -> Ok(IssueTypeRequired)
    "value" -> Ok(IssueTypeValue)
    "invariant" -> Ok(IssueTypeInvariant)
    "security" -> Ok(IssueTypeSecurity)
    "login" -> Ok(IssueTypeLogin)
    "unknown" -> Ok(IssueTypeUnknown)
    "expired" -> Ok(IssueTypeExpired)
    "forbidden" -> Ok(IssueTypeForbidden)
    "suppressed" -> Ok(IssueTypeSuppressed)
    "processing" -> Ok(IssueTypeProcessing)
    "not-supported" -> Ok(IssueTypeNotsupported)
    "duplicate" -> Ok(IssueTypeDuplicate)
    "multiple-matches" -> Ok(IssueTypeMultiplematches)
    "not-found" -> Ok(IssueTypeNotfound)
    "deleted" -> Ok(IssueTypeDeleted)
    "too-long" -> Ok(IssueTypeToolong)
    "code-invalid" -> Ok(IssueTypeCodeinvalid)
    "extension" -> Ok(IssueTypeExtension)
    "too-costly" -> Ok(IssueTypeToocostly)
    "business-rule" -> Ok(IssueTypeBusinessrule)
    "conflict" -> Ok(IssueTypeConflict)
    "transient" -> Ok(IssueTypeTransient)
    "lock-error" -> Ok(IssueTypeLockerror)
    "no-store" -> Ok(IssueTypeNostore)
    "exception" -> Ok(IssueTypeException)
    "timeout" -> Ok(IssueTypeTimeout)
    "incomplete" -> Ok(IssueTypeIncomplete)
    "throttled" -> Ok(IssueTypeThrottled)
    "informational" -> Ok(IssueTypeInformational)
    _ -> Error(Nil)
  }
}

pub fn issue_type_decoder() -> Decoder(IssueType) {
  use variant <- decode.then(decode.string)
  case issue_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        IssueTypeInvalid,
        "IssueType",
        issue_type,
        issue_type_to_code,
      )
  }
}
