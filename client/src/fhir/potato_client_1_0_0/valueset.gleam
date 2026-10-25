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

pub type AddressType {
  AddressTypePostal
  AddressTypePhysical
  AddressTypeBoth
}

pub const address_type: List(AddressType) = [
  AddressTypePostal,
  AddressTypePhysical,
  AddressTypeBoth,
]

pub fn address_type_to_json(address_type: AddressType) -> Json {
  json.string(address_type_to_code(address_type))
}

pub fn address_type_to_code(address_type: AddressType) -> String {
  case address_type {
    AddressTypePostal -> "postal"
    AddressTypePhysical -> "physical"
    AddressTypeBoth -> "both"
  }
}

pub fn address_type_parse_code(code: String) -> Result(AddressType, Nil) {
  case code {
    "postal" -> Ok(AddressTypePostal)
    "physical" -> Ok(AddressTypePhysical)
    "both" -> Ok(AddressTypeBoth)
    _ -> Error(Nil)
  }
}

pub fn address_type_decoder() -> Decoder(AddressType) {
  use variant <- decode.then(decode.string)
  case address_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AddressTypePostal,
        "AddressType",
        address_type,
        address_type_to_code,
      )
  }
}

pub type AddressUse {
  AddressUseHome
  AddressUseWork
  AddressUseTemp
  AddressUseOld
  AddressUseBilling
}

pub const address_use: List(AddressUse) = [
  AddressUseHome,
  AddressUseWork,
  AddressUseTemp,
  AddressUseOld,
  AddressUseBilling,
]

pub fn address_use_to_json(address_use: AddressUse) -> Json {
  json.string(address_use_to_code(address_use))
}

pub fn address_use_to_code(address_use: AddressUse) -> String {
  case address_use {
    AddressUseHome -> "home"
    AddressUseWork -> "work"
    AddressUseTemp -> "temp"
    AddressUseOld -> "old"
    AddressUseBilling -> "billing"
  }
}

pub fn address_use_parse_code(code: String) -> Result(AddressUse, Nil) {
  case code {
    "home" -> Ok(AddressUseHome)
    "work" -> Ok(AddressUseWork)
    "temp" -> Ok(AddressUseTemp)
    "old" -> Ok(AddressUseOld)
    "billing" -> Ok(AddressUseBilling)
    _ -> Error(Nil)
  }
}

pub fn address_use_decoder() -> Decoder(AddressUse) {
  use variant <- decode.then(decode.string)
  case address_use_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AddressUseHome,
        "AddressUse",
        address_use,
        address_use_to_code,
      )
  }
}

pub type AdministrativeGender {
  AdministrativeGenderMale
  AdministrativeGenderFemale
  AdministrativeGenderOther
  AdministrativeGenderUnknown
}

pub const administrative_gender: List(AdministrativeGender) = [
  AdministrativeGenderMale,
  AdministrativeGenderFemale,
  AdministrativeGenderOther,
  AdministrativeGenderUnknown,
]

pub fn administrative_gender_to_json(
  administrative_gender: AdministrativeGender,
) -> Json {
  json.string(administrative_gender_to_code(administrative_gender))
}

pub fn administrative_gender_to_code(
  administrative_gender: AdministrativeGender,
) -> String {
  case administrative_gender {
    AdministrativeGenderMale -> "male"
    AdministrativeGenderFemale -> "female"
    AdministrativeGenderOther -> "other"
    AdministrativeGenderUnknown -> "unknown"
  }
}

pub fn administrative_gender_parse_code(
  code: String,
) -> Result(AdministrativeGender, Nil) {
  case code {
    "male" -> Ok(AdministrativeGenderMale)
    "female" -> Ok(AdministrativeGenderFemale)
    "other" -> Ok(AdministrativeGenderOther)
    "unknown" -> Ok(AdministrativeGenderUnknown)
    _ -> Error(Nil)
  }
}

pub fn administrative_gender_decoder() -> Decoder(AdministrativeGender) {
  use variant <- decode.then(decode.string)
  case administrative_gender_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AdministrativeGenderMale,
        "AdministrativeGender",
        administrative_gender,
        administrative_gender_to_code,
      )
  }
}

pub type AllergyintoleranceCategory {
  AllergyintoleranceCategoryFood
  AllergyintoleranceCategoryMedication
  AllergyintoleranceCategoryEnvironment
  AllergyintoleranceCategoryBiologic
}

pub const allergyintolerance_category: List(AllergyintoleranceCategory) = [
  AllergyintoleranceCategoryFood,
  AllergyintoleranceCategoryMedication,
  AllergyintoleranceCategoryEnvironment,
  AllergyintoleranceCategoryBiologic,
]

pub fn allergyintolerance_category_to_json(
  allergyintolerance_category: AllergyintoleranceCategory,
) -> Json {
  json.string(allergyintolerance_category_to_code(allergyintolerance_category))
}

pub fn allergyintolerance_category_to_code(
  allergyintolerance_category: AllergyintoleranceCategory,
) -> String {
  case allergyintolerance_category {
    AllergyintoleranceCategoryFood -> "food"
    AllergyintoleranceCategoryMedication -> "medication"
    AllergyintoleranceCategoryEnvironment -> "environment"
    AllergyintoleranceCategoryBiologic -> "biologic"
  }
}

pub fn allergyintolerance_category_parse_code(
  code: String,
) -> Result(AllergyintoleranceCategory, Nil) {
  case code {
    "food" -> Ok(AllergyintoleranceCategoryFood)
    "medication" -> Ok(AllergyintoleranceCategoryMedication)
    "environment" -> Ok(AllergyintoleranceCategoryEnvironment)
    "biologic" -> Ok(AllergyintoleranceCategoryBiologic)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerance_category_decoder() -> Decoder(
  AllergyintoleranceCategory,
) {
  use variant <- decode.then(decode.string)
  case allergyintolerance_category_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceCategoryFood,
        "AllergyintoleranceCategory",
        allergyintolerance_category,
        allergyintolerance_category_to_code,
      )
  }
}

pub type AllergyintoleranceClinical {
  AllergyintoleranceClinicalActive
  AllergyintoleranceClinicalInactive
  AllergyintoleranceClinicalResolved
}

pub const allergyintolerance_clinical: List(AllergyintoleranceClinical) = [
  AllergyintoleranceClinicalActive,
  AllergyintoleranceClinicalInactive,
  AllergyintoleranceClinicalResolved,
]

pub fn allergyintolerance_clinical_to_json(
  allergyintolerance_clinical: AllergyintoleranceClinical,
) -> Json {
  json.string(allergyintolerance_clinical_to_code(allergyintolerance_clinical))
}

pub fn allergyintolerance_clinical_to_code(
  allergyintolerance_clinical: AllergyintoleranceClinical,
) -> String {
  case allergyintolerance_clinical {
    AllergyintoleranceClinicalActive -> "active"
    AllergyintoleranceClinicalInactive -> "inactive"
    AllergyintoleranceClinicalResolved -> "resolved"
  }
}

pub fn allergyintolerance_clinical_parse_code(
  code: String,
) -> Result(AllergyintoleranceClinical, Nil) {
  case code {
    "active" -> Ok(AllergyintoleranceClinicalActive)
    "inactive" -> Ok(AllergyintoleranceClinicalInactive)
    "resolved" -> Ok(AllergyintoleranceClinicalResolved)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerance_clinical_decoder() -> Decoder(
  AllergyintoleranceClinical,
) {
  use variant <- decode.then(decode.string)
  case allergyintolerance_clinical_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceClinicalActive,
        "AllergyintoleranceClinical",
        allergyintolerance_clinical,
        allergyintolerance_clinical_to_code,
      )
  }
}

pub fn allergyintolerance_clinical_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "active",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
    -> Ok(Nil)
    "inactive",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
    -> Ok(Nil)
    "resolved",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
    -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type AllergyintoleranceCriticality {
  AllergyintoleranceCriticalityLow
  AllergyintoleranceCriticalityHigh
  AllergyintoleranceCriticalityUnabletoassess
}

pub const allergyintolerance_criticality: List(AllergyintoleranceCriticality) = [
  AllergyintoleranceCriticalityLow,
  AllergyintoleranceCriticalityHigh,
  AllergyintoleranceCriticalityUnabletoassess,
]

pub fn allergyintolerance_criticality_to_json(
  allergyintolerance_criticality: AllergyintoleranceCriticality,
) -> Json {
  json.string(allergyintolerance_criticality_to_code(
    allergyintolerance_criticality,
  ))
}

pub fn allergyintolerance_criticality_to_code(
  allergyintolerance_criticality: AllergyintoleranceCriticality,
) -> String {
  case allergyintolerance_criticality {
    AllergyintoleranceCriticalityLow -> "low"
    AllergyintoleranceCriticalityHigh -> "high"
    AllergyintoleranceCriticalityUnabletoassess -> "unable-to-assess"
  }
}

pub fn allergyintolerance_criticality_parse_code(
  code: String,
) -> Result(AllergyintoleranceCriticality, Nil) {
  case code {
    "low" -> Ok(AllergyintoleranceCriticalityLow)
    "high" -> Ok(AllergyintoleranceCriticalityHigh)
    "unable-to-assess" -> Ok(AllergyintoleranceCriticalityUnabletoassess)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerance_criticality_decoder() -> Decoder(
  AllergyintoleranceCriticality,
) {
  use variant <- decode.then(decode.string)
  case allergyintolerance_criticality_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceCriticalityLow,
        "AllergyintoleranceCriticality",
        allergyintolerance_criticality,
        allergyintolerance_criticality_to_code,
      )
  }
}

pub type AllergyintoleranceType {
  AllergyintoleranceTypeAllergy
  AllergyintoleranceTypeIntolerance
}

pub const allergyintolerance_type: List(AllergyintoleranceType) = [
  AllergyintoleranceTypeAllergy,
  AllergyintoleranceTypeIntolerance,
]

pub fn allergyintolerance_type_to_json(
  allergyintolerance_type: AllergyintoleranceType,
) -> Json {
  json.string(allergyintolerance_type_to_code(allergyintolerance_type))
}

pub fn allergyintolerance_type_to_code(
  allergyintolerance_type: AllergyintoleranceType,
) -> String {
  case allergyintolerance_type {
    AllergyintoleranceTypeAllergy -> "allergy"
    AllergyintoleranceTypeIntolerance -> "intolerance"
  }
}

pub fn allergyintolerance_type_parse_code(
  code: String,
) -> Result(AllergyintoleranceType, Nil) {
  case code {
    "allergy" -> Ok(AllergyintoleranceTypeAllergy)
    "intolerance" -> Ok(AllergyintoleranceTypeIntolerance)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerance_type_decoder() -> Decoder(AllergyintoleranceType) {
  use variant <- decode.then(decode.string)
  case allergyintolerance_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceTypeAllergy,
        "AllergyintoleranceType",
        allergyintolerance_type,
        allergyintolerance_type_to_code,
      )
  }
}

pub type AllergyintoleranceVerification {
  AllergyintoleranceVerificationUnconfirmed
  AllergyintoleranceVerificationPresumed
  AllergyintoleranceVerificationConfirmed
  AllergyintoleranceVerificationRefuted
  AllergyintoleranceVerificationEnteredinerror
}

pub const allergyintolerance_verification: List(AllergyintoleranceVerification) = [
  AllergyintoleranceVerificationUnconfirmed,
  AllergyintoleranceVerificationPresumed,
  AllergyintoleranceVerificationConfirmed,
  AllergyintoleranceVerificationRefuted,
  AllergyintoleranceVerificationEnteredinerror,
]

pub fn allergyintolerance_verification_to_json(
  allergyintolerance_verification: AllergyintoleranceVerification,
) -> Json {
  json.string(allergyintolerance_verification_to_code(
    allergyintolerance_verification,
  ))
}

pub fn allergyintolerance_verification_to_code(
  allergyintolerance_verification: AllergyintoleranceVerification,
) -> String {
  case allergyintolerance_verification {
    AllergyintoleranceVerificationUnconfirmed -> "unconfirmed"
    AllergyintoleranceVerificationPresumed -> "presumed"
    AllergyintoleranceVerificationConfirmed -> "confirmed"
    AllergyintoleranceVerificationRefuted -> "refuted"
    AllergyintoleranceVerificationEnteredinerror -> "entered-in-error"
  }
}

pub fn allergyintolerance_verification_parse_code(
  code: String,
) -> Result(AllergyintoleranceVerification, Nil) {
  case code {
    "unconfirmed" -> Ok(AllergyintoleranceVerificationUnconfirmed)
    "presumed" -> Ok(AllergyintoleranceVerificationPresumed)
    "confirmed" -> Ok(AllergyintoleranceVerificationConfirmed)
    "refuted" -> Ok(AllergyintoleranceVerificationRefuted)
    "entered-in-error" -> Ok(AllergyintoleranceVerificationEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerance_verification_decoder() -> Decoder(
  AllergyintoleranceVerification,
) {
  use variant <- decode.then(decode.string)
  case allergyintolerance_verification_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceVerificationUnconfirmed,
        "AllergyintoleranceVerification",
        allergyintolerance_verification,
        allergyintolerance_verification_to_code,
      )
  }
}

pub fn allergyintolerance_verification_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "unconfirmed",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(Nil)
    "presumed",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(Nil)
    "confirmed",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(Nil)
    "refuted",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(Nil)
    "entered-in-error",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type Appointmentstatus {
  AppointmentstatusProposed
  AppointmentstatusPending
  AppointmentstatusBooked
  AppointmentstatusArrived
  AppointmentstatusFulfilled
  AppointmentstatusCancelled
  AppointmentstatusNoshow
  AppointmentstatusEnteredinerror
  AppointmentstatusCheckedin
  AppointmentstatusWaitlist
}

pub const appointmentstatus: List(Appointmentstatus) = [
  AppointmentstatusProposed,
  AppointmentstatusPending,
  AppointmentstatusBooked,
  AppointmentstatusArrived,
  AppointmentstatusFulfilled,
  AppointmentstatusCancelled,
  AppointmentstatusNoshow,
  AppointmentstatusEnteredinerror,
  AppointmentstatusCheckedin,
  AppointmentstatusWaitlist,
]

pub fn appointmentstatus_to_json(appointmentstatus: Appointmentstatus) -> Json {
  json.string(appointmentstatus_to_code(appointmentstatus))
}

pub fn appointmentstatus_to_code(
  appointmentstatus: Appointmentstatus,
) -> String {
  case appointmentstatus {
    AppointmentstatusProposed -> "proposed"
    AppointmentstatusPending -> "pending"
    AppointmentstatusBooked -> "booked"
    AppointmentstatusArrived -> "arrived"
    AppointmentstatusFulfilled -> "fulfilled"
    AppointmentstatusCancelled -> "cancelled"
    AppointmentstatusNoshow -> "noshow"
    AppointmentstatusEnteredinerror -> "entered-in-error"
    AppointmentstatusCheckedin -> "checked-in"
    AppointmentstatusWaitlist -> "waitlist"
  }
}

pub fn appointmentstatus_parse_code(
  code: String,
) -> Result(Appointmentstatus, Nil) {
  case code {
    "proposed" -> Ok(AppointmentstatusProposed)
    "pending" -> Ok(AppointmentstatusPending)
    "booked" -> Ok(AppointmentstatusBooked)
    "arrived" -> Ok(AppointmentstatusArrived)
    "fulfilled" -> Ok(AppointmentstatusFulfilled)
    "cancelled" -> Ok(AppointmentstatusCancelled)
    "noshow" -> Ok(AppointmentstatusNoshow)
    "entered-in-error" -> Ok(AppointmentstatusEnteredinerror)
    "checked-in" -> Ok(AppointmentstatusCheckedin)
    "waitlist" -> Ok(AppointmentstatusWaitlist)
    _ -> Error(Nil)
  }
}

pub fn appointmentstatus_decoder() -> Decoder(Appointmentstatus) {
  use variant <- decode.then(decode.string)
  case appointmentstatus_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AppointmentstatusProposed,
        "Appointmentstatus",
        appointmentstatus,
        appointmentstatus_to_code,
      )
  }
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

pub type CompositionStatus {
  CompositionStatusPreliminary
  CompositionStatusFinal
  CompositionStatusAmended
  CompositionStatusEnteredinerror
}

pub const composition_status: List(CompositionStatus) = [
  CompositionStatusPreliminary,
  CompositionStatusFinal,
  CompositionStatusAmended,
  CompositionStatusEnteredinerror,
]

pub fn composition_status_to_json(
  composition_status: CompositionStatus,
) -> Json {
  json.string(composition_status_to_code(composition_status))
}

pub fn composition_status_to_code(
  composition_status: CompositionStatus,
) -> String {
  case composition_status {
    CompositionStatusPreliminary -> "preliminary"
    CompositionStatusFinal -> "final"
    CompositionStatusAmended -> "amended"
    CompositionStatusEnteredinerror -> "entered-in-error"
  }
}

pub fn composition_status_parse_code(
  code: String,
) -> Result(CompositionStatus, Nil) {
  case code {
    "preliminary" -> Ok(CompositionStatusPreliminary)
    "final" -> Ok(CompositionStatusFinal)
    "amended" -> Ok(CompositionStatusAmended)
    "entered-in-error" -> Ok(CompositionStatusEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn composition_status_decoder() -> Decoder(CompositionStatus) {
  use variant <- decode.then(decode.string)
  case composition_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        CompositionStatusPreliminary,
        "CompositionStatus",
        composition_status,
        composition_status_to_code,
      )
  }
}

pub type ConditionClinical {
  ConditionClinicalActive
  ConditionClinicalRecurrence
  ConditionClinicalRelapse
  ConditionClinicalInactive
  ConditionClinicalRemission
  ConditionClinicalResolved
  ConditionClinicalUnknown
}

pub const condition_clinical: List(ConditionClinical) = [
  ConditionClinicalActive,
  ConditionClinicalRecurrence,
  ConditionClinicalRelapse,
  ConditionClinicalInactive,
  ConditionClinicalRemission,
  ConditionClinicalResolved,
  ConditionClinicalUnknown,
]

pub fn condition_clinical_to_json(
  condition_clinical: ConditionClinical,
) -> Json {
  json.string(condition_clinical_to_code(condition_clinical))
}

pub fn condition_clinical_to_code(
  condition_clinical: ConditionClinical,
) -> String {
  case condition_clinical {
    ConditionClinicalActive -> "active"
    ConditionClinicalRecurrence -> "recurrence"
    ConditionClinicalRelapse -> "relapse"
    ConditionClinicalInactive -> "inactive"
    ConditionClinicalRemission -> "remission"
    ConditionClinicalResolved -> "resolved"
    ConditionClinicalUnknown -> "unknown"
  }
}

pub fn condition_clinical_parse_code(
  code: String,
) -> Result(ConditionClinical, Nil) {
  case code {
    "active" -> Ok(ConditionClinicalActive)
    "recurrence" -> Ok(ConditionClinicalRecurrence)
    "relapse" -> Ok(ConditionClinicalRelapse)
    "inactive" -> Ok(ConditionClinicalInactive)
    "remission" -> Ok(ConditionClinicalRemission)
    "resolved" -> Ok(ConditionClinicalResolved)
    "unknown" -> Ok(ConditionClinicalUnknown)
    _ -> Error(Nil)
  }
}

pub fn condition_clinical_decoder() -> Decoder(ConditionClinical) {
  use variant <- decode.then(decode.string)
  case condition_clinical_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ConditionClinicalActive,
        "ConditionClinical",
        condition_clinical,
        condition_clinical_to_code,
      )
  }
}

pub fn condition_clinical_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "active", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    "recurrence", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    "relapse", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    "inactive", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    "remission", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    "resolved", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    "unknown", "http://terminology.hl7.org/CodeSystem/condition-clinical" ->
      Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type ConditionVerStatus {
  ConditionVerStatusUnconfirmed
  ConditionVerStatusProvisional
  ConditionVerStatusDifferential
  ConditionVerStatusConfirmed
  ConditionVerStatusRefuted
  ConditionVerStatusEnteredinerror
}

pub const condition_ver_status: List(ConditionVerStatus) = [
  ConditionVerStatusUnconfirmed,
  ConditionVerStatusProvisional,
  ConditionVerStatusDifferential,
  ConditionVerStatusConfirmed,
  ConditionVerStatusRefuted,
  ConditionVerStatusEnteredinerror,
]

pub fn condition_ver_status_to_json(
  condition_ver_status: ConditionVerStatus,
) -> Json {
  json.string(condition_ver_status_to_code(condition_ver_status))
}

pub fn condition_ver_status_to_code(
  condition_ver_status: ConditionVerStatus,
) -> String {
  case condition_ver_status {
    ConditionVerStatusUnconfirmed -> "unconfirmed"
    ConditionVerStatusProvisional -> "provisional"
    ConditionVerStatusDifferential -> "differential"
    ConditionVerStatusConfirmed -> "confirmed"
    ConditionVerStatusRefuted -> "refuted"
    ConditionVerStatusEnteredinerror -> "entered-in-error"
  }
}

pub fn condition_ver_status_parse_code(
  code: String,
) -> Result(ConditionVerStatus, Nil) {
  case code {
    "unconfirmed" -> Ok(ConditionVerStatusUnconfirmed)
    "provisional" -> Ok(ConditionVerStatusProvisional)
    "differential" -> Ok(ConditionVerStatusDifferential)
    "confirmed" -> Ok(ConditionVerStatusConfirmed)
    "refuted" -> Ok(ConditionVerStatusRefuted)
    "entered-in-error" -> Ok(ConditionVerStatusEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn condition_ver_status_decoder() -> Decoder(ConditionVerStatus) {
  use variant <- decode.then(decode.string)
  case condition_ver_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ConditionVerStatusUnconfirmed,
        "ConditionVerStatus",
        condition_ver_status,
        condition_ver_status_to_code,
      )
  }
}

pub fn condition_ver_status_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "unconfirmed", "http://terminology.hl7.org/CodeSystem/condition-ver-status"
    -> Ok(Nil)
    "provisional", "http://terminology.hl7.org/CodeSystem/condition-ver-status"
    -> Ok(Nil)
    "differential", "http://terminology.hl7.org/CodeSystem/condition-ver-status"
    -> Ok(Nil)
    "confirmed", "http://terminology.hl7.org/CodeSystem/condition-ver-status" ->
      Ok(Nil)
    "refuted", "http://terminology.hl7.org/CodeSystem/condition-ver-status" ->
      Ok(Nil)
    "entered-in-error",
      "http://terminology.hl7.org/CodeSystem/condition-ver-status"
    -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type ContactpointSystem {
  ContactpointSystemPhone
  ContactpointSystemFax
  ContactpointSystemEmail
  ContactpointSystemPager
  ContactpointSystemUrl
  ContactpointSystemSms
  ContactpointSystemOther
}

pub const contactpoint_system: List(ContactpointSystem) = [
  ContactpointSystemPhone,
  ContactpointSystemFax,
  ContactpointSystemEmail,
  ContactpointSystemPager,
  ContactpointSystemUrl,
  ContactpointSystemSms,
  ContactpointSystemOther,
]

pub fn contactpoint_system_to_json(
  contactpoint_system: ContactpointSystem,
) -> Json {
  json.string(contactpoint_system_to_code(contactpoint_system))
}

pub fn contactpoint_system_to_code(
  contactpoint_system: ContactpointSystem,
) -> String {
  case contactpoint_system {
    ContactpointSystemPhone -> "phone"
    ContactpointSystemFax -> "fax"
    ContactpointSystemEmail -> "email"
    ContactpointSystemPager -> "pager"
    ContactpointSystemUrl -> "url"
    ContactpointSystemSms -> "sms"
    ContactpointSystemOther -> "other"
  }
}

pub fn contactpoint_system_parse_code(
  code: String,
) -> Result(ContactpointSystem, Nil) {
  case code {
    "phone" -> Ok(ContactpointSystemPhone)
    "fax" -> Ok(ContactpointSystemFax)
    "email" -> Ok(ContactpointSystemEmail)
    "pager" -> Ok(ContactpointSystemPager)
    "url" -> Ok(ContactpointSystemUrl)
    "sms" -> Ok(ContactpointSystemSms)
    "other" -> Ok(ContactpointSystemOther)
    _ -> Error(Nil)
  }
}

pub fn contactpoint_system_decoder() -> Decoder(ContactpointSystem) {
  use variant <- decode.then(decode.string)
  case contactpoint_system_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ContactpointSystemPhone,
        "ContactpointSystem",
        contactpoint_system,
        contactpoint_system_to_code,
      )
  }
}

pub type ContactpointUse {
  ContactpointUseHome
  ContactpointUseWork
  ContactpointUseTemp
  ContactpointUseOld
  ContactpointUseMobile
}

pub const contactpoint_use: List(ContactpointUse) = [
  ContactpointUseHome,
  ContactpointUseWork,
  ContactpointUseTemp,
  ContactpointUseOld,
  ContactpointUseMobile,
]

pub fn contactpoint_use_to_json(contactpoint_use: ContactpointUse) -> Json {
  json.string(contactpoint_use_to_code(contactpoint_use))
}

pub fn contactpoint_use_to_code(contactpoint_use: ContactpointUse) -> String {
  case contactpoint_use {
    ContactpointUseHome -> "home"
    ContactpointUseWork -> "work"
    ContactpointUseTemp -> "temp"
    ContactpointUseOld -> "old"
    ContactpointUseMobile -> "mobile"
  }
}

pub fn contactpoint_use_parse_code(
  code: String,
) -> Result(ContactpointUse, Nil) {
  case code {
    "home" -> Ok(ContactpointUseHome)
    "work" -> Ok(ContactpointUseWork)
    "temp" -> Ok(ContactpointUseTemp)
    "old" -> Ok(ContactpointUseOld)
    "mobile" -> Ok(ContactpointUseMobile)
    _ -> Error(Nil)
  }
}

pub fn contactpoint_use_decoder() -> Decoder(ContactpointUse) {
  use variant <- decode.then(decode.string)
  case contactpoint_use_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ContactpointUseHome,
        "ContactpointUse",
        contactpoint_use,
        contactpoint_use_to_code,
      )
  }
}

pub type DaysOfWeek {
  DaysOfWeekMon
  DaysOfWeekTue
  DaysOfWeekWed
  DaysOfWeekThu
  DaysOfWeekFri
  DaysOfWeekSat
  DaysOfWeekSun
}

pub const days_of_week: List(DaysOfWeek) = [
  DaysOfWeekMon,
  DaysOfWeekTue,
  DaysOfWeekWed,
  DaysOfWeekThu,
  DaysOfWeekFri,
  DaysOfWeekSat,
  DaysOfWeekSun,
]

pub fn days_of_week_to_json(days_of_week: DaysOfWeek) -> Json {
  json.string(days_of_week_to_code(days_of_week))
}

pub fn days_of_week_to_code(days_of_week: DaysOfWeek) -> String {
  case days_of_week {
    DaysOfWeekMon -> "mon"
    DaysOfWeekTue -> "tue"
    DaysOfWeekWed -> "wed"
    DaysOfWeekThu -> "thu"
    DaysOfWeekFri -> "fri"
    DaysOfWeekSat -> "sat"
    DaysOfWeekSun -> "sun"
  }
}

pub fn days_of_week_parse_code(code: String) -> Result(DaysOfWeek, Nil) {
  case code {
    "mon" -> Ok(DaysOfWeekMon)
    "tue" -> Ok(DaysOfWeekTue)
    "wed" -> Ok(DaysOfWeekWed)
    "thu" -> Ok(DaysOfWeekThu)
    "fri" -> Ok(DaysOfWeekFri)
    "sat" -> Ok(DaysOfWeekSat)
    "sun" -> Ok(DaysOfWeekSun)
    _ -> Error(Nil)
  }
}

pub fn days_of_week_decoder() -> Decoder(DaysOfWeek) {
  use variant <- decode.then(decode.string)
  case days_of_week_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DaysOfWeekMon,
        "DaysOfWeek",
        days_of_week,
        days_of_week_to_code,
      )
  }
}

pub type DetailedEthnicity {
  DetailedEthnicity21352
  DetailedEthnicity21378
  DetailedEthnicity21386
  DetailedEthnicity21394
  DetailedEthnicity21402
  DetailedEthnicity21410
  DetailedEthnicity21428
  DetailedEthnicity21436
  DetailedEthnicity21444
  DetailedEthnicity21451
  DetailedEthnicity21469
  DetailedEthnicity21485
  DetailedEthnicity21493
  DetailedEthnicity21501
  DetailedEthnicity21519
  DetailedEthnicity21527
  DetailedEthnicity21535
  DetailedEthnicity21550
  DetailedEthnicity21568
  DetailedEthnicity21576
  DetailedEthnicity21584
  DetailedEthnicity21592
  DetailedEthnicity21600
  DetailedEthnicity21618
  DetailedEthnicity21626
  DetailedEthnicity21634
  DetailedEthnicity21659
  DetailedEthnicity21667
  DetailedEthnicity21675
  DetailedEthnicity21683
  DetailedEthnicity21691
  DetailedEthnicity21709
  DetailedEthnicity21717
  DetailedEthnicity21725
  DetailedEthnicity21733
  DetailedEthnicity21741
  DetailedEthnicity21758
  DetailedEthnicity21766
  DetailedEthnicity21782
  DetailedEthnicity21808
  DetailedEthnicity21824
  DetailedEthnicity21840
  DetailedEthnicity21865
  DetailedEthnicityAsku
  DetailedEthnicityOth
  DetailedEthnicityUnk
}

pub const detailed_ethnicity: List(DetailedEthnicity) = [
  DetailedEthnicity21352,
  DetailedEthnicity21378,
  DetailedEthnicity21386,
  DetailedEthnicity21394,
  DetailedEthnicity21402,
  DetailedEthnicity21410,
  DetailedEthnicity21428,
  DetailedEthnicity21436,
  DetailedEthnicity21444,
  DetailedEthnicity21451,
  DetailedEthnicity21469,
  DetailedEthnicity21485,
  DetailedEthnicity21493,
  DetailedEthnicity21501,
  DetailedEthnicity21519,
  DetailedEthnicity21527,
  DetailedEthnicity21535,
  DetailedEthnicity21550,
  DetailedEthnicity21568,
  DetailedEthnicity21576,
  DetailedEthnicity21584,
  DetailedEthnicity21592,
  DetailedEthnicity21600,
  DetailedEthnicity21618,
  DetailedEthnicity21626,
  DetailedEthnicity21634,
  DetailedEthnicity21659,
  DetailedEthnicity21667,
  DetailedEthnicity21675,
  DetailedEthnicity21683,
  DetailedEthnicity21691,
  DetailedEthnicity21709,
  DetailedEthnicity21717,
  DetailedEthnicity21725,
  DetailedEthnicity21733,
  DetailedEthnicity21741,
  DetailedEthnicity21758,
  DetailedEthnicity21766,
  DetailedEthnicity21782,
  DetailedEthnicity21808,
  DetailedEthnicity21824,
  DetailedEthnicity21840,
  DetailedEthnicity21865,
  DetailedEthnicityAsku,
  DetailedEthnicityOth,
  DetailedEthnicityUnk,
]

pub fn detailed_ethnicity_to_json(
  detailed_ethnicity: DetailedEthnicity,
) -> Json {
  json.string(detailed_ethnicity_to_code(detailed_ethnicity))
}

pub fn detailed_ethnicity_to_code(
  detailed_ethnicity: DetailedEthnicity,
) -> String {
  case detailed_ethnicity {
    DetailedEthnicity21352 -> "2135-2"
    DetailedEthnicity21378 -> "2137-8"
    DetailedEthnicity21386 -> "2138-6"
    DetailedEthnicity21394 -> "2139-4"
    DetailedEthnicity21402 -> "2140-2"
    DetailedEthnicity21410 -> "2141-0"
    DetailedEthnicity21428 -> "2142-8"
    DetailedEthnicity21436 -> "2143-6"
    DetailedEthnicity21444 -> "2144-4"
    DetailedEthnicity21451 -> "2145-1"
    DetailedEthnicity21469 -> "2146-9"
    DetailedEthnicity21485 -> "2148-5"
    DetailedEthnicity21493 -> "2149-3"
    DetailedEthnicity21501 -> "2150-1"
    DetailedEthnicity21519 -> "2151-9"
    DetailedEthnicity21527 -> "2152-7"
    DetailedEthnicity21535 -> "2153-5"
    DetailedEthnicity21550 -> "2155-0"
    DetailedEthnicity21568 -> "2156-8"
    DetailedEthnicity21576 -> "2157-6"
    DetailedEthnicity21584 -> "2158-4"
    DetailedEthnicity21592 -> "2159-2"
    DetailedEthnicity21600 -> "2160-0"
    DetailedEthnicity21618 -> "2161-8"
    DetailedEthnicity21626 -> "2162-6"
    DetailedEthnicity21634 -> "2163-4"
    DetailedEthnicity21659 -> "2165-9"
    DetailedEthnicity21667 -> "2166-7"
    DetailedEthnicity21675 -> "2167-5"
    DetailedEthnicity21683 -> "2168-3"
    DetailedEthnicity21691 -> "2169-1"
    DetailedEthnicity21709 -> "2170-9"
    DetailedEthnicity21717 -> "2171-7"
    DetailedEthnicity21725 -> "2172-5"
    DetailedEthnicity21733 -> "2173-3"
    DetailedEthnicity21741 -> "2174-1"
    DetailedEthnicity21758 -> "2175-8"
    DetailedEthnicity21766 -> "2176-6"
    DetailedEthnicity21782 -> "2178-2"
    DetailedEthnicity21808 -> "2180-8"
    DetailedEthnicity21824 -> "2182-4"
    DetailedEthnicity21840 -> "2184-0"
    DetailedEthnicity21865 -> "2186-5"
    DetailedEthnicityAsku -> "ASKU"
    DetailedEthnicityOth -> "OTH"
    DetailedEthnicityUnk -> "UNK"
  }
}

pub fn detailed_ethnicity_parse_code(
  code: String,
) -> Result(DetailedEthnicity, Nil) {
  case code {
    "2135-2" -> Ok(DetailedEthnicity21352)
    "2137-8" -> Ok(DetailedEthnicity21378)
    "2138-6" -> Ok(DetailedEthnicity21386)
    "2139-4" -> Ok(DetailedEthnicity21394)
    "2140-2" -> Ok(DetailedEthnicity21402)
    "2141-0" -> Ok(DetailedEthnicity21410)
    "2142-8" -> Ok(DetailedEthnicity21428)
    "2143-6" -> Ok(DetailedEthnicity21436)
    "2144-4" -> Ok(DetailedEthnicity21444)
    "2145-1" -> Ok(DetailedEthnicity21451)
    "2146-9" -> Ok(DetailedEthnicity21469)
    "2148-5" -> Ok(DetailedEthnicity21485)
    "2149-3" -> Ok(DetailedEthnicity21493)
    "2150-1" -> Ok(DetailedEthnicity21501)
    "2151-9" -> Ok(DetailedEthnicity21519)
    "2152-7" -> Ok(DetailedEthnicity21527)
    "2153-5" -> Ok(DetailedEthnicity21535)
    "2155-0" -> Ok(DetailedEthnicity21550)
    "2156-8" -> Ok(DetailedEthnicity21568)
    "2157-6" -> Ok(DetailedEthnicity21576)
    "2158-4" -> Ok(DetailedEthnicity21584)
    "2159-2" -> Ok(DetailedEthnicity21592)
    "2160-0" -> Ok(DetailedEthnicity21600)
    "2161-8" -> Ok(DetailedEthnicity21618)
    "2162-6" -> Ok(DetailedEthnicity21626)
    "2163-4" -> Ok(DetailedEthnicity21634)
    "2165-9" -> Ok(DetailedEthnicity21659)
    "2166-7" -> Ok(DetailedEthnicity21667)
    "2167-5" -> Ok(DetailedEthnicity21675)
    "2168-3" -> Ok(DetailedEthnicity21683)
    "2169-1" -> Ok(DetailedEthnicity21691)
    "2170-9" -> Ok(DetailedEthnicity21709)
    "2171-7" -> Ok(DetailedEthnicity21717)
    "2172-5" -> Ok(DetailedEthnicity21725)
    "2173-3" -> Ok(DetailedEthnicity21733)
    "2174-1" -> Ok(DetailedEthnicity21741)
    "2175-8" -> Ok(DetailedEthnicity21758)
    "2176-6" -> Ok(DetailedEthnicity21766)
    "2178-2" -> Ok(DetailedEthnicity21782)
    "2180-8" -> Ok(DetailedEthnicity21808)
    "2182-4" -> Ok(DetailedEthnicity21824)
    "2184-0" -> Ok(DetailedEthnicity21840)
    "2186-5" -> Ok(DetailedEthnicity21865)
    "ASKU" -> Ok(DetailedEthnicityAsku)
    "OTH" -> Ok(DetailedEthnicityOth)
    "UNK" -> Ok(DetailedEthnicityUnk)
    _ -> Error(Nil)
  }
}

pub fn detailed_ethnicity_decoder() -> Decoder(DetailedEthnicity) {
  use variant <- decode.then(decode.string)
  case detailed_ethnicity_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DetailedEthnicity21352,
        "DetailedEthnicity",
        detailed_ethnicity,
        detailed_ethnicity_to_code,
      )
  }
}

pub fn detailed_ethnicity_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "2135-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2137-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2138-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2139-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2140-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2141-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2142-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2143-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2144-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2145-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2146-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2148-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2149-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2150-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2151-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2152-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2153-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2155-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2156-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2157-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2158-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2159-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2160-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2161-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2162-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2163-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2165-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2166-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2167-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2168-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2169-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2170-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2171-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2172-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2173-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2174-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2175-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2176-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2178-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2180-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2182-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2184-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2186-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    "OTH", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type DetailedRace {
  DetailedRace10041
  DetailedRace10066
  DetailedRace15792
  DetailedRace12120
  DetailedRace10454
  DetailedRace16543
  DetailedRace11940
  DetailedRace11957
  DetailedRace11874
  DetailedRace10082
  DetailedRace30122
  DetailedRace16881
  DetailedRace13920
  DetailedRace30155
  DetailedRace30163
  DetailedRace10108
  DetailedRace10165
  DetailedRace10215
  DetailedRace10249
  DetailedRace10264
  DetailedRace13664
  DetailedRace10280
  DetailedRace30247
  DetailedRace30254
  DetailedRace12344
  DetailedRace12658
  DetailedRace10462
  DetailedRace11247
  DetailedRace10330
  DetailedRace30312
  DetailedRace11254
  DetailedRace10603
  DetailedRace30346
  DetailedRace30353
  DetailedRace30361
  DetailedRace14308
  DetailedRace30387
  DetailedRace30395
  DetailedRace12351
  DetailedRace30411
  DetailedRace14175
  DetailedRace10355
  DetailedRace30445
  DetailedRace11262
  DetailedRace14183
  DetailedRace10371
  DetailedRace16113
  DetailedRace30494
  DetailedRace14191
  DetailedRace30510
  DetailedRace10470
  DetailedRace30536
  DetailedRace10413
  DetailedRace30551
  DetailedRace10421
  DetailedRace10546
  DetailedRace10447
  DetailedRace30593
  DetailedRace30601
  DetailedRace12237
  DetailedRace12245
  DetailedRace10769
  DetailedRace12864
  DetailedRace10785
  DetailedRace14209
  DetailedRace13938
  DetailedRace14654
  DetailedRace30692
  DetailedRace30700
  DetailedRace30718
  DetailedRace10827
  DetailedRace10868
  DetailedRace30742
  DetailedRace30759
  DetailedRace30767
  DetailedRace10884
  DetailedRace10892
  DetailedRace30791
  DetailedRace30809
  DetailedRace30817
  DetailedRace10900
  DetailedRace11023
  DetailedRace11064
  DetailedRace30858
  DetailedRace30866
  DetailedRace11098
  DetailedRace30882
  DetailedRace10553
  DetailedRace11148
  DetailedRace11239
  DetailedRace30924
  DetailedRace11536
  DetailedRace11551
  DetailedRace30957
  DetailedRace11627
  DetailedRace14795
  DetailedRace11155
  DetailedRace11650
  DetailedRace11569
  DetailedRace31013
  DetailedRace17251
  DetailedRace11676
  DetailedRace11692
  DetailedRace31054
  DetailedRace11718
  DetailedRace13946
  DetailedRace11163
  DetailedRace31096
  DetailedRace15602
  DetailedRace17079
  DetailedRace16071
  DetailedRace10801
  DetailedRace11734
  DetailedRace11783
  DetailedRace15917
  DetailedRace12625
  DetailedRace16659
  DetailedRace16832
  DetailedRace11809
  DetailedRace11825
  DetailedRace11841
  DetailedRace11866
  DetailedRace31245
  DetailedRace16683
  DetailedRace11890
  DetailedRace31278
  DetailedRace11916
  DetailedRace12070
  DetailedRace16139
  DetailedRace12096
  DetailedRace31328
  DetailedRace12112
  DetailedRace31344
  DetailedRace31351
  DetailedRace31369
  DetailedRace10579
  DetailedRace14662
  DetailedRace15883
  DetailedRace15198
  DetailedRace31419
  DetailedRace10926
  DetailedRace11965
  DetailedRace11973
  DetailedRace31450
  DetailedRace14670
  DetailedRace15800
  DetailedRace15990
  DetailedRace10934
  DetailedRace12393
  DetailedRace14720
  DetailedRace31526
  DetailedRace31534
  DetailedRace15909
  DetailedRace31559
  DetailedRace12500
  DetailedRace12252
  DetailedRace10561
  DetailedRace31591
  DetailedRace16154
  DetailedRace11288
  DetailedRace31625
  DetailedRace12526
  DetailedRace14217
  DetailedRace14225
  DetailedRace16055
  DetailedRace12567
  DetailedRace17293
  DetailedRace31690
  DetailedRace31708
  DetailedRace12609
  DetailedRace12369
  DetailedRace31732
  DetailedRace31740
  DetailedRace12427
  DetailedRace11296
  DetailedRace31773
  DetailedRace11304
  DetailedRace31799
  DetailedRace31807
  DetailedRace12641
  DetailedRace31823
  DetailedRace31831
  DetailedRace31849
  DetailedRace12674
  DetailedRace14811
  DetailedRace31872
  DetailedRace17269
  DetailedRace31898
  DetailedRace12690
  DetailedRace16972
  DetailedRace10835
  DetailedRace12757
  DetailedRace12716
  DetailedRace31955
  DetailedRace31963
  DetailedRace31971
  DetailedRace17277
  DetailedRace12302
  DetailedRace13599
  DetailedRace12799
  DetailedRace14423
  DetailedRace13607
  DetailedRace32045
  DetailedRace12815
  DetailedRace12823
  DetailedRace12831
  DetailedRace12856
  DetailedRace32094
  DetailedRace13136
  DetailedRace32110
  DetailedRace11577
  DetailedRace10132
  DetailedRace12971
  DetailedRace14233
  DetailedRace13953
  DetailedRace12997
  DetailedRace13011
  DetailedRace14688
  DetailedRace11171
  DetailedRace13037
  DetailedRace32227
  DetailedRace15107
  DetailedRace32243
  DetailedRace11981
  DetailedRace13052
  DetailedRace13078
  DetailedRace32284
  DetailedRace13060
  DetailedRace15206
  DetailedRace13094
  DetailedRace13102
  DetailedRace13128
  DetailedRace32342
  DetailedRace32359
  DetailedRace32367
  DetailedRace32375
  DetailedRace13193
  DetailedRace13219
  DetailedRace12229
  DetailedRace13326
  DetailedRace12260
  DetailedRace11320
  DetailedRace11338
  DetailedRace11346
  DetailedRace11353
  DetailedRace14241
  DetailedRace13235
  DetailedRace11361
  DetailedRace32508
  DetailedRace10140
  DetailedRace32524
  DetailedRace11379
  DetailedRace32540
  DetailedRace14258
  DetailedRace10488
  DetailedRace32573
  DetailedRace14266
  DetailedRace16188
  DetailedRace13144
  DetailedRace11999
  DetailedRace16196
  DetailedRace15214
  DetailedRace13318
  DetailedRace13409
  DetailedRace13425
  DetailedRace32672
  DetailedRace12005
  DetailedRace13441
  DetailedRace13482
  DetailedRace14274
  DetailedRace13508
  DetailedRace32730
  DetailedRace13524
  DetailedRace12278
  DetailedRace17285
  DetailedRace32771
  DetailedRace14548
  DetailedRace16816
  DetailedRace32805
  DetailedRace13268
  DetailedRace13540
  DetailedRace16204
  DetailedRace32847
  DetailedRace32854
  DetailedRace13565
  DetailedRace12286
  DetailedRace10157
  DetailedRace32896
  DetailedRace13581
  DetailedRace13615
  DetailedRace13631
  DetailedRace13656
  DetailedRace32946
  DetailedRace11387
  DetailedRace11395
  DetailedRace13680
  DetailedRace11585
  DetailedRace13706
  DetailedRace14282
  DetailedRace13722
  DetailedRace12872
  DetailedRace13748
  DetailedRace13961
  DetailedRace33050
  DetailedRace13763
  DetailedRace13276
  DetailedRace12377
  DetailedRace33092
  DetailedRace10496
  DetailedRace13458
  DetailedRace11593
  DetailedRace15222
  DetailedRace12179
  DetailedRace12385
  DetailedRace13789
  DetailedRace33175
  DetailedRace13805
  DetailedRace33191
  DetailedRace12401
  DetailedRace33217
  DetailedRace12203
  DetailedRace13870
  DetailedRace12419
  DetailedRace13466
  DetailedRace15230
  DetailedRace13896
  DetailedRace15248
  DetailedRace33290
  DetailedRace10223
  DetailedRace10959
  DetailedRace11031
  DetailedRace14290
  DetailedRace14696
  DetailedRace15982
  DetailedRace14829
  DetailedRace33373
  DetailedRace33381
  DetailedRace33399
  DetailedRace33407
  DetailedRace33415
  DetailedRace14035
  DetailedRace12880
  DetailedRace33449
  DetailedRace33456
  DetailedRace12898
  DetailedRace14050
  DetailedRace14092
  DetailedRace14118
  DetailedRace14142
  DetailedRace14167
  DetailedRace14332
  DetailedRace16048
  DetailedRace13334
  DetailedRace14399
  DetailedRace33563
  DetailedRace33571
  DetailedRace14415
  DetailedRace33597
  DetailedRace33605
  DetailedRace13342
  DetailedRace14456
  DetailedRace14464
  DetailedRace13359
  DetailedRace33654
  DetailedRace33662
  DetailedRace14480
  DetailedRace33688
  DetailedRace14530
  DetailedRace17186
  DetailedRace33712
  DetailedRace14563
  DetailedRace33738
  DetailedRace16246
  DetailedRace33753
  DetailedRace15008
  DetailedRace14605
  DetailedRace33787
  DetailedRace33795
  DetailedRace14621
  DetailedRace14431
  DetailedRace12013
  DetailedRace33837
  DetailedRace12435
  DetailedRace33852
  DetailedRace14837
  DetailedRace33878
  DetailedRace14647
  DetailedRace14746
  DetailedRace14761
  DetailedRace14753
  DetailedRace33928
  DetailedRace13284
  DetailedRace13151
  DetailedRace14787
  DetailedRace33969
  DetailedRace14878
  DetailedRace14845
  DetailedRace16253
  DetailedRace12021
  DetailedRace14894
  DetailedRace14902
  DetailedRace14928
  DetailedRace14944
  DetailedRace14951
  DetailedRace14977
  DetailedRace14985
  DetailedRace14993
  DetailedRace15016
  DetailedRace15024
  DetailedRace15032
  DetailedRace15073
  DetailedRace15081
  DetailedRace15099
  DetailedRace15115
  DetailedRace15123
  DetailedRace15156
  DetailedRace15180
  DetailedRace15263
  DetailedRace14316
  DetailedRace15412
  DetailedRace34223
  DetailedRace34231
  DetailedRace10843
  DetailedRace15438
  DetailedRace12195
  DetailedRace34272
  DetailedRace15453
  DetailedRace11411
  DetailedRace11429
  DetailedRace10611
  DetailedRace34322
  DetailedRace34330
  DetailedRace15479
  DetailedRace17335
  DetailedRace34363
  DetailedRace34371
  DetailedRace16279
  DetailedRace15495
  DetailedRace15511
  DetailedRace15537
  DetailedRace15545
  DetailedRace15529
  DetailedRace34447
  DetailedRace11437
  DetailedRace34462
  DetailedRace15560
  DetailedRace15586
  DetailedRace14589
  DetailedRace15271
  DetailedRace10181
  DetailedRace15065
  DetailedRace14324
  DetailedRace34546
  DetailedRace15743
  DetailedRace12294
  DetailedRace10504
  DetailedRace10629
  DetailedRace11635
  DetailedRace34603
  DetailedRace34611
  DetailedRace16295
  DetailedRace34637
  DetailedRace34645
  DetailedRace15289
  DetailedRace11452
  DetailedRace15628
  DetailedRace14704
  DetailedRace34694
  DetailedRace15669
  DetailedRace34710
  DetailedRace34728
  DetailedRace12922
  DetailedRace15735
  DetailedRace13292
  DetailedRace16261
  DetailedRace15768
  DetailedRace15784
  DetailedRace34793
  DetailedRace11007
  DetailedRace34819
  DetailedRace34827
  DetailedRace15826
  DetailedRace15842
  DetailedRace15867
  DetailedRace16022
  DetailedRace12583
  DetailedRace16030
  DetailedRace16097
  DetailedRace34900
  DetailedRace16436
  DetailedRace15297
  DetailedRace15941
  DetailedRace15305
  DetailedRace15313
  DetailedRace15321
  DetailedRace13367
  DetailedRace11460
  DetailedRace34991
  DetailedRace12443
  DetailedRace10231
  DetailedRace11049
  DetailedRace35030
  DetailedRace16329
  DetailedRace16451
  DetailedRace15339
  DetailedRace11445
  DetailedRace16337
  DetailedRace15347
  DetailedRace15354
  DetailedRace16493
  DetailedRace14712
  DetailedRace14340
  DetailedRace16519
  DetailedRace12450
  DetailedRace35162
  DetailedRace15370
  DetailedRace12310
  DetailedRace35196
  DetailedRace17194
  DetailedRace10637
  DetailedRace13979
  DetailedRace35238
  DetailedRace13383
  DetailedRace35253
  DetailedRace13987
  DetailedRace16345
  DetailedRace11122
  DetailedRace11601
  DetailedRace35303
  DetailedRace11932
  DetailedRace14076
  DetailedRace15719
  DetailedRace12039
  DetailedRace35352
  DetailedRace35360
  DetailedRace12047
  DetailedRace12542
  DetailedRace13995
  DetailedRace35402
  DetailedRace35410
  DetailedRace16592
  DetailedRace35436
  DetailedRace12930
  DetailedRace16618
  DetailedRace10173
  DetailedRace10512
  DetailedRace12724
  DetailedRace12054
  DetailedRace15388
  DetailedRace17202
  DetailedRace12468
  DetailedRace35535
  DetailedRace11478
  DetailedRace12948
  DetailedRace10967
  DetailedRace13375
  DetailedRace16634
  DetailedRace16675
  DetailedRace35600
  DetailedRace35618
  DetailedRace12773
  DetailedRace10975
  DetailedRace11189
  DetailedRace35659
  DetailedRace16360
  DetailedRace15396
  DetailedRace16709
  DetailedRace16725
  DetailedRace35709
  DetailedRace14357
  DetailedRace35725
  DetailedRace12476
  DetailedRace16378
  DetailedRace16758
  DetailedRace11197
  DetailedRace14365
  DetailedRace16774
  DetailedRace16790
  DetailedRace16808
  DetailedRace10645
  DetailedRace16857
  DetailedRace35832
  DetailedRace35840
  DetailedRace16394
  DetailedRace14001
  DetailedRace12732
  DetailedRace11486
  DetailedRace10199
  DetailedRace35907
  DetailedRace16923
  DetailedRace12484
  DetailedRace11205
  DetailedRace35949
  DetailedRace16949
  DetailedRace16964
  DetailedRace16980
  DetailedRace17004
  DetailedRace17020
  DetailedRace11213
  DetailedRace36012
  DetailedRace12955
  DetailedRace17095
  DetailedRace10652
  DetailedRace16402
  DetailedRace16410
  DetailedRace17111
  DetailedRace17152
  DetailedRace17319
  DetailedRace14373
  DetailedRace36111
  DetailedRace17178
  DetailedRace16006
  DetailedRace15149
  DetailedRace17228
  DetailedRace10660
  DetailedRace17327
  DetailedRace15164
  DetailedRace17350
  DetailedRace17376
  DetailedRace17392
  DetailedRace17400
  DetailedRace17442
  DetailedRace17418
  DetailedRace17426
  DetailedRace17434
  DetailedRace17459
  DetailedRace36285
  DetailedRace17475
  DetailedRace17483
  DetailedRace17509
  DetailedRace17525
  DetailedRace17517
  DetailedRace17541
  DetailedRace17558
  DetailedRace17574
  DetailedRace17590
  DetailedRace17616
  DetailedRace17624
  DetailedRace17657
  DetailedRace17673
  DetailedRace17681
  DetailedRace17699
  DetailedRace17707
  DetailedRace17715
  DetailedRace17756
  DetailedRace17764
  DetailedRace17772
  DetailedRace17780
  DetailedRace17806
  DetailedRace17798
  DetailedRace17814
  DetailedRace17491
  DetailedRace17533
  DetailedRace17608
  DetailedRace17632
  DetailedRace17640
  DetailedRace17749
  DetailedRace17822
  DetailedRace17913
  DetailedRace17962
  DetailedRace17996
  DetailedRace18010
  DetailedRace18036
  DetailedRace18051
  DetailedRace18077
  DetailedRace17830
  DetailedRace17848
  DetailedRace17855
  DetailedRace17863
  DetailedRace17871
  DetailedRace17889
  DetailedRace17665
  DetailedRace17897
  DetailedRace17905
  DetailedRace17939
  DetailedRace17954
  DetailedRace17947
  DetailedRace17988
  DetailedRace18028
  DetailedRace18044
  DetailedRace18069
  DetailedRace17582
  DetailedRace17723
  DetailedRace17731
  DetailedRace17921
  DetailedRace17970
  DetailedRace18085
  DetailedRace18093
  DetailedRace18259
  DetailedRace19661
  DetailedRace19943
  DetailedRace20081
  DetailedRace41871
  DetailedRace19729
  DetailedRace19737
  DetailedRace19745
  DetailedRace19844
  DetailedRace19869
  DetailedRace19752
  DetailedRace18408
  DetailedRace19760
  DetailedRace19778
  DetailedRace37044
  DetailedRace20149
  DetailedRace19786
  DetailedRace19968
  DetailedRace19794
  DetailedRace19927
  DetailedRace37101
  DetailedRace37119
  DetailedRace19935
  DetailedRace20073
  DetailedRace20115
  DetailedRace20123
  DetailedRace19851
  DetailedRace20131
  DetailedRace19901
  DetailedRace20156
  DetailedRace37200
  DetailedRace19950
  DetailedRace19976
  DetailedRace19877
  DetailedRace20164
  DetailedRace20172
  DetailedRace19992
  DetailedRace19802
  DetailedRace19810
  DetailedRace19885
  DetailedRace19828
  DetailedRace20008
  DetailedRace19695
  DetailedRace20263
  DetailedRace20180
  DetailedRace37358
  DetailedRace20206
  DetailedRace20214
  DetailedRace20222
  DetailedRace20248
  DetailedRace20024
  DetailedRace37416
  DetailedRace19703
  DetailedRace37432
  DetailedRace19984
  DetailedRace37457
  DetailedRace37465
  DetailedRace18499
  DetailedRace18507
  DetailedRace18523
  DetailedRace19091
  DetailedRace37515
  DetailedRace18424
  DetailedRace37531
  DetailedRace18481
  DetailedRace18622
  DetailedRace18630
  DetailedRace37572
  DetailedRace18713
  DetailedRace18457
  DetailedRace18515
  DetailedRace18531
  DetailedRace18549
  DetailedRace18564
  DetailedRace18572
  DetailedRace18606
  DetailedRace18580
  DetailedRace18648
  DetailedRace18655
  DetailedRace18663
  DetailedRace18671
  DetailedRace18689
  DetailedRace18895
  DetailedRace19331
  DetailedRace18721
  DetailedRace18754
  DetailedRace18762
  DetailedRace18770
  DetailedRace18788
  DetailedRace18796
  DetailedRace18804
  DetailedRace18812
  DetailedRace18838
  DetailedRace18846
  DetailedRace18861
  DetailedRace37853
  DetailedRace18739
  DetailedRace18747
  DetailedRace37887
  DetailedRace18820
  DetailedRace18853
  DetailedRace18333
  DetailedRace38612
  DetailedRace18168
  DetailedRace18176
  DetailedRace18184
  DetailedRace18192
  DetailedRace18200
  DetailedRace18218
  DetailedRace18226
  DetailedRace18267
  DetailedRace18275
  DetailedRace18234
  DetailedRace18242
  DetailedRace18309
  DetailedRace18283
  DetailedRace18291
  DetailedRace18119
  DetailedRace18317
  DetailedRace38091
  DetailedRace18325
  DetailedRace18143
  DetailedRace18341
  DetailedRace18358
  DetailedRace18374
  DetailedRace18382
  DetailedRace18960
  DetailedRace18978
  DetailedRace18986
  DetailedRace19638
  DetailedRace19349
  DetailedRace19067
  DetailedRace19075
  DetailedRace38232
  DetailedRace19133
  DetailedRace19166
  DetailedRace38265
  DetailedRace19208
  DetailedRace19299
  DetailedRace19315
  DetailedRace19356
  DetailedRace19000
  DetailedRace19109
  DetailedRace19141
  DetailedRace19158
  DetailedRace18929
  DetailedRace19620
  DetailedRace19182
  DetailedRace38380
  DetailedRace19190
  DetailedRace19224
  DetailedRace19232
  DetailedRace19257
  DetailedRace19281
  DetailedRace19497
  DetailedRace19323
  DetailedRace19364
  DetailedRace19372
  DetailedRace19380
  DetailedRace19422
  DetailedRace19539
  DetailedRace19430
  DetailedRace19463
  DetailedRace19513
  DetailedRace18937
  DetailedRace19521
  DetailedRace19596
  DetailedRace19604
  DetailedRace19240
  DetailedRace19406
  DetailedRace19398
  DetailedRace19414
  DetailedRace19570
  DetailedRace19273
  DetailedRace19042
  DetailedRace19448
  DetailedRace19455
  DetailedRace19471
  DetailedRace19489
  DetailedRace18945
  DetailedRace19554
  DetailedRace19562
  DetailedRace19588
  DetailedRace19612
  DetailedRace19646
  DetailedRace18994
  DetailedRace19026
  DetailedRace19034
  DetailedRace19059
  DetailedRace19083
  DetailedRace19117
  DetailedRace19125
  DetailedRace19216
  DetailedRace19265
  DetailedRace19307
  DetailedRace38851
  DetailedRace19505
  DetailedRace19547
  DetailedRace19018
  DetailedRace38893
  DetailedRace10694
  DetailedRace38919
  DetailedRace38927
  DetailedRace38935
  DetailedRace38943
  DetailedRace38950
  DetailedRace38968
  DetailedRace38976
  DetailedRace38984
  DetailedRace38992
  DetailedRace39008
  DetailedRace39016
  DetailedRace39024
  DetailedRace39032
  DetailedRace39040
  DetailedRace39057
  DetailedRace39065
  DetailedRace39073
  DetailedRace39081
  DetailedRace39099
  DetailedRace39107
  DetailedRace39115
  DetailedRace39123
  DetailedRace39131
  DetailedRace39149
  DetailedRace39156
  DetailedRace39164
  DetailedRace39172
  DetailedRace39180
  DetailedRace39198
  DetailedRace39206
  DetailedRace39214
  DetailedRace39222
  DetailedRace39230
  DetailedRace39248
  DetailedRace39255
  DetailedRace39263
  DetailedRace39271
  DetailedRace39289
  DetailedRace39297
  DetailedRace39305
  DetailedRace39313
  DetailedRace39321
  DetailedRace39339
  DetailedRace39347
  DetailedRace39354
  DetailedRace39362
  DetailedRace39370
  DetailedRace39388
  DetailedRace39396
  DetailedRace39404
  DetailedRace39412
  DetailedRace39420
  DetailedRace39438
  DetailedRace39446
  DetailedRace39453
  DetailedRace39461
  DetailedRace39479
  DetailedRace39487
  DetailedRace39495
  DetailedRace10710
  DetailedRace39511
  DetailedRace39529
  DetailedRace39537
  DetailedRace39545
  DetailedRace39552
  DetailedRace39560
  DetailedRace39578
  DetailedRace39586
  DetailedRace39594
  DetailedRace39602
  DetailedRace39610
  DetailedRace39628
  DetailedRace39636
  DetailedRace39644
  DetailedRace39651
  DetailedRace39669
  DetailedRace39677
  DetailedRace39685
  DetailedRace39693
  DetailedRace39701
  DetailedRace39719
  DetailedRace39727
  DetailedRace39735
  DetailedRace39743
  DetailedRace39750
  DetailedRace39768
  DetailedRace39776
  DetailedRace39784
  DetailedRace39792
  DetailedRace39800
  DetailedRace39818
  DetailedRace39826
  DetailedRace39834
  DetailedRace39842
  DetailedRace39859
  DetailedRace39867
  DetailedRace39875
  DetailedRace39883
  DetailedRace39891
  DetailedRace39909
  DetailedRace39917
  DetailedRace39925
  DetailedRace39933
  DetailedRace39941
  DetailedRace39958
  DetailedRace39966
  DetailedRace39974
  DetailedRace39982
  DetailedRace39990
  DetailedRace40006
  DetailedRace40014
  DetailedRace40022
  DetailedRace40030
  DetailedRace40048
  DetailedRace40055
  DetailedRace40063
  DetailedRace40071
  DetailedRace40089
  DetailedRace40097
  DetailedRace40105
  DetailedRace40113
  DetailedRace40121
  DetailedRace40139
  DetailedRace40147
  DetailedRace40154
  DetailedRace40162
  DetailedRace40170
  DetailedRace40188
  DetailedRace40196
  DetailedRace40204
  DetailedRace40212
  DetailedRace40220
  DetailedRace40238
  DetailedRace40246
  DetailedRace40253
  DetailedRace40261
  DetailedRace40279
  DetailedRace40287
  DetailedRace40295
  DetailedRace40303
  DetailedRace40311
  DetailedRace40329
  DetailedRace40337
  DetailedRace40345
  DetailedRace40352
  DetailedRace40360
  DetailedRace40378
  DetailedRace40386
  DetailedRace40394
  DetailedRace40402
  DetailedRace40410
  DetailedRace40428
  DetailedRace40436
  DetailedRace40444
  DetailedRace40451
  DetailedRace40469
  DetailedRace40477
  DetailedRace40485
  DetailedRace40493
  DetailedRace40501
  DetailedRace40519
  DetailedRace40527
  DetailedRace40535
  DetailedRace40543
  DetailedRace40550
  DetailedRace40568
  DetailedRace40576
  DetailedRace40584
  DetailedRace40592
  DetailedRace40600
  DetailedRace40618
  DetailedRace40626
  DetailedRace40634
  DetailedRace40642
  DetailedRace40659
  DetailedRace40667
  DetailedRace40675
  DetailedRace40683
  DetailedRace40691
  DetailedRace40709
  DetailedRace40717
  DetailedRace40725
  DetailedRace40733
  DetailedRace40741
  DetailedRace40758
  DetailedRace40766
  DetailedRace40774
  DetailedRace40782
  DetailedRace40790
  DetailedRace40808
  DetailedRace40816
  DetailedRace40824
  DetailedRace40832
  DetailedRace40840
  DetailedRace40857
  DetailedRace10702
  DetailedRace40873
  DetailedRace40881
  DetailedRace40899
  DetailedRace40907
  DetailedRace40915
  DetailedRace40923
  DetailedRace40931
  DetailedRace40949
  DetailedRace40956
  DetailedRace40964
  DetailedRace40972
  DetailedRace40980
  DetailedRace40998
  DetailedRace41004
  DetailedRace41012
  DetailedRace41020
  DetailedRace41038
  DetailedRace41046
  DetailedRace41053
  DetailedRace41061
  DetailedRace41079
  DetailedRace41087
  DetailedRace41095
  DetailedRace41103
  DetailedRace41111
  DetailedRace41129
  DetailedRace41137
  DetailedRace41145
  DetailedRace41152
  DetailedRace41160
  DetailedRace41178
  DetailedRace41186
  DetailedRace41194
  DetailedRace41202
  DetailedRace41210
  DetailedRace41228
  DetailedRace41236
  DetailedRace41244
  DetailedRace41251
  DetailedRace41269
  DetailedRace41277
  DetailedRace41285
  DetailedRace41293
  DetailedRace41301
  DetailedRace41319
  DetailedRace41327
  DetailedRace41335
  DetailedRace41343
  DetailedRace41350
  DetailedRace41368
  DetailedRace41376
  DetailedRace41384
  DetailedRace41392
  DetailedRace41400
  DetailedRace41418
  DetailedRace41426
  DetailedRace41434
  DetailedRace41442
  DetailedRace41459
  DetailedRace41467
  DetailedRace10728
  DetailedRace41483
  DetailedRace10736
  DetailedRace41509
  DetailedRace41517
  DetailedRace41525
  DetailedRace41533
  DetailedRace41541
  DetailedRace41558
  DetailedRace41566
  DetailedRace41574
  DetailedRace41582
  DetailedRace41590
  DetailedRace41608
  DetailedRace41616
  DetailedRace41624
  DetailedRace41632
  DetailedRace41640
  DetailedRace41657
  DetailedRace41665
  DetailedRace41673
  DetailedRace41681
  DetailedRace41699
  DetailedRace41707
  DetailedRace41715
  DetailedRace41723
  DetailedRace41731
  DetailedRace41749
  DetailedRace41756
  DetailedRace41764
  DetailedRace41772
  DetailedRace41780
  DetailedRace41798
  DetailedRace41806
  DetailedRace41814
  DetailedRace10744
  DetailedRace41830
  DetailedRace41848
  DetailedRace41855
  DetailedRace20297
  DetailedRace20305
  DetailedRace20313
  DetailedRace20321
  DetailedRace20339
  DetailedRace20347
  DetailedRace20354
  DetailedRace20362
  DetailedRace20370
  DetailedRace20388
  DetailedRace20396
  DetailedRace20404
  DetailedRace20412
  DetailedRace20420
  DetailedRace20438
  DetailedRace20446
  DetailedRace20453
  DetailedRace20461
  DetailedRace20479
  DetailedRace20487
  DetailedRace20495
  DetailedRace20503
  DetailedRace20511
  DetailedRace20529
  DetailedRace20560
  DetailedRace20586
  DetailedRace20602
  DetailedRace20610
  DetailedRace20628
  DetailedRace20636
  DetailedRace20644
  DetailedRace20651
  DetailedRace20669
  DetailedRace41863
  DetailedRace20677
  DetailedRace20685
  DetailedRace20693
  DetailedRace20701
  DetailedRace20719
  DetailedRace20727
  DetailedRace20735
  DetailedRace20743
  DetailedRace20750
  DetailedRace20784
  DetailedRace20792
  DetailedRace20800
  DetailedRace20818
  DetailedRace20826
  DetailedRace20834
  DetailedRace20859
  DetailedRace20867
  DetailedRace20875
  DetailedRace20883
  DetailedRace20891
  DetailedRace20909
  DetailedRace20917
  DetailedRace20925
  DetailedRace20933
  DetailedRace20941
  DetailedRace20958
  DetailedRace20966
  DetailedRace20974
  DetailedRace20982
  DetailedRace21006
  DetailedRace21014
  DetailedRace21022
  DetailedRace21030
  DetailedRace21048
  DetailedRace25007
  DetailedRace21089
  DetailedRace21097
  DetailedRace21105
  DetailedRace21113
  DetailedRace21121
  DetailedRace21139
  DetailedRace21147
  DetailedRace21154
  DetailedRace21162
  DetailedRace21188
  DetailedRace21196
  DetailedRace21204
  DetailedRace21212
  DetailedRace21220
  DetailedRace21238
  DetailedRace21246
  DetailedRace21253
  DetailedRace21261
  DetailedRace21279
  DetailedRace21295
  DetailedRace21311
  DetailedRaceAsku
  DetailedRaceOth
  DetailedRaceUnk
}

pub const detailed_race: List(DetailedRace) = [
  DetailedRace10041,
  DetailedRace10066,
  DetailedRace15792,
  DetailedRace12120,
  DetailedRace10454,
  DetailedRace16543,
  DetailedRace11940,
  DetailedRace11957,
  DetailedRace11874,
  DetailedRace10082,
  DetailedRace30122,
  DetailedRace16881,
  DetailedRace13920,
  DetailedRace30155,
  DetailedRace30163,
  DetailedRace10108,
  DetailedRace10165,
  DetailedRace10215,
  DetailedRace10249,
  DetailedRace10264,
  DetailedRace13664,
  DetailedRace10280,
  DetailedRace30247,
  DetailedRace30254,
  DetailedRace12344,
  DetailedRace12658,
  DetailedRace10462,
  DetailedRace11247,
  DetailedRace10330,
  DetailedRace30312,
  DetailedRace11254,
  DetailedRace10603,
  DetailedRace30346,
  DetailedRace30353,
  DetailedRace30361,
  DetailedRace14308,
  DetailedRace30387,
  DetailedRace30395,
  DetailedRace12351,
  DetailedRace30411,
  DetailedRace14175,
  DetailedRace10355,
  DetailedRace30445,
  DetailedRace11262,
  DetailedRace14183,
  DetailedRace10371,
  DetailedRace16113,
  DetailedRace30494,
  DetailedRace14191,
  DetailedRace30510,
  DetailedRace10470,
  DetailedRace30536,
  DetailedRace10413,
  DetailedRace30551,
  DetailedRace10421,
  DetailedRace10546,
  DetailedRace10447,
  DetailedRace30593,
  DetailedRace30601,
  DetailedRace12237,
  DetailedRace12245,
  DetailedRace10769,
  DetailedRace12864,
  DetailedRace10785,
  DetailedRace14209,
  DetailedRace13938,
  DetailedRace14654,
  DetailedRace30692,
  DetailedRace30700,
  DetailedRace30718,
  DetailedRace10827,
  DetailedRace10868,
  DetailedRace30742,
  DetailedRace30759,
  DetailedRace30767,
  DetailedRace10884,
  DetailedRace10892,
  DetailedRace30791,
  DetailedRace30809,
  DetailedRace30817,
  DetailedRace10900,
  DetailedRace11023,
  DetailedRace11064,
  DetailedRace30858,
  DetailedRace30866,
  DetailedRace11098,
  DetailedRace30882,
  DetailedRace10553,
  DetailedRace11148,
  DetailedRace11239,
  DetailedRace30924,
  DetailedRace11536,
  DetailedRace11551,
  DetailedRace30957,
  DetailedRace11627,
  DetailedRace14795,
  DetailedRace11155,
  DetailedRace11650,
  DetailedRace11569,
  DetailedRace31013,
  DetailedRace17251,
  DetailedRace11676,
  DetailedRace11692,
  DetailedRace31054,
  DetailedRace11718,
  DetailedRace13946,
  DetailedRace11163,
  DetailedRace31096,
  DetailedRace15602,
  DetailedRace17079,
  DetailedRace16071,
  DetailedRace10801,
  DetailedRace11734,
  DetailedRace11783,
  DetailedRace15917,
  DetailedRace12625,
  DetailedRace16659,
  DetailedRace16832,
  DetailedRace11809,
  DetailedRace11825,
  DetailedRace11841,
  DetailedRace11866,
  DetailedRace31245,
  DetailedRace16683,
  DetailedRace11890,
  DetailedRace31278,
  DetailedRace11916,
  DetailedRace12070,
  DetailedRace16139,
  DetailedRace12096,
  DetailedRace31328,
  DetailedRace12112,
  DetailedRace31344,
  DetailedRace31351,
  DetailedRace31369,
  DetailedRace10579,
  DetailedRace14662,
  DetailedRace15883,
  DetailedRace15198,
  DetailedRace31419,
  DetailedRace10926,
  DetailedRace11965,
  DetailedRace11973,
  DetailedRace31450,
  DetailedRace14670,
  DetailedRace15800,
  DetailedRace15990,
  DetailedRace10934,
  DetailedRace12393,
  DetailedRace14720,
  DetailedRace31526,
  DetailedRace31534,
  DetailedRace15909,
  DetailedRace31559,
  DetailedRace12500,
  DetailedRace12252,
  DetailedRace10561,
  DetailedRace31591,
  DetailedRace16154,
  DetailedRace11288,
  DetailedRace31625,
  DetailedRace12526,
  DetailedRace14217,
  DetailedRace14225,
  DetailedRace16055,
  DetailedRace12567,
  DetailedRace17293,
  DetailedRace31690,
  DetailedRace31708,
  DetailedRace12609,
  DetailedRace12369,
  DetailedRace31732,
  DetailedRace31740,
  DetailedRace12427,
  DetailedRace11296,
  DetailedRace31773,
  DetailedRace11304,
  DetailedRace31799,
  DetailedRace31807,
  DetailedRace12641,
  DetailedRace31823,
  DetailedRace31831,
  DetailedRace31849,
  DetailedRace12674,
  DetailedRace14811,
  DetailedRace31872,
  DetailedRace17269,
  DetailedRace31898,
  DetailedRace12690,
  DetailedRace16972,
  DetailedRace10835,
  DetailedRace12757,
  DetailedRace12716,
  DetailedRace31955,
  DetailedRace31963,
  DetailedRace31971,
  DetailedRace17277,
  DetailedRace12302,
  DetailedRace13599,
  DetailedRace12799,
  DetailedRace14423,
  DetailedRace13607,
  DetailedRace32045,
  DetailedRace12815,
  DetailedRace12823,
  DetailedRace12831,
  DetailedRace12856,
  DetailedRace32094,
  DetailedRace13136,
  DetailedRace32110,
  DetailedRace11577,
  DetailedRace10132,
  DetailedRace12971,
  DetailedRace14233,
  DetailedRace13953,
  DetailedRace12997,
  DetailedRace13011,
  DetailedRace14688,
  DetailedRace11171,
  DetailedRace13037,
  DetailedRace32227,
  DetailedRace15107,
  DetailedRace32243,
  DetailedRace11981,
  DetailedRace13052,
  DetailedRace13078,
  DetailedRace32284,
  DetailedRace13060,
  DetailedRace15206,
  DetailedRace13094,
  DetailedRace13102,
  DetailedRace13128,
  DetailedRace32342,
  DetailedRace32359,
  DetailedRace32367,
  DetailedRace32375,
  DetailedRace13193,
  DetailedRace13219,
  DetailedRace12229,
  DetailedRace13326,
  DetailedRace12260,
  DetailedRace11320,
  DetailedRace11338,
  DetailedRace11346,
  DetailedRace11353,
  DetailedRace14241,
  DetailedRace13235,
  DetailedRace11361,
  DetailedRace32508,
  DetailedRace10140,
  DetailedRace32524,
  DetailedRace11379,
  DetailedRace32540,
  DetailedRace14258,
  DetailedRace10488,
  DetailedRace32573,
  DetailedRace14266,
  DetailedRace16188,
  DetailedRace13144,
  DetailedRace11999,
  DetailedRace16196,
  DetailedRace15214,
  DetailedRace13318,
  DetailedRace13409,
  DetailedRace13425,
  DetailedRace32672,
  DetailedRace12005,
  DetailedRace13441,
  DetailedRace13482,
  DetailedRace14274,
  DetailedRace13508,
  DetailedRace32730,
  DetailedRace13524,
  DetailedRace12278,
  DetailedRace17285,
  DetailedRace32771,
  DetailedRace14548,
  DetailedRace16816,
  DetailedRace32805,
  DetailedRace13268,
  DetailedRace13540,
  DetailedRace16204,
  DetailedRace32847,
  DetailedRace32854,
  DetailedRace13565,
  DetailedRace12286,
  DetailedRace10157,
  DetailedRace32896,
  DetailedRace13581,
  DetailedRace13615,
  DetailedRace13631,
  DetailedRace13656,
  DetailedRace32946,
  DetailedRace11387,
  DetailedRace11395,
  DetailedRace13680,
  DetailedRace11585,
  DetailedRace13706,
  DetailedRace14282,
  DetailedRace13722,
  DetailedRace12872,
  DetailedRace13748,
  DetailedRace13961,
  DetailedRace33050,
  DetailedRace13763,
  DetailedRace13276,
  DetailedRace12377,
  DetailedRace33092,
  DetailedRace10496,
  DetailedRace13458,
  DetailedRace11593,
  DetailedRace15222,
  DetailedRace12179,
  DetailedRace12385,
  DetailedRace13789,
  DetailedRace33175,
  DetailedRace13805,
  DetailedRace33191,
  DetailedRace12401,
  DetailedRace33217,
  DetailedRace12203,
  DetailedRace13870,
  DetailedRace12419,
  DetailedRace13466,
  DetailedRace15230,
  DetailedRace13896,
  DetailedRace15248,
  DetailedRace33290,
  DetailedRace10223,
  DetailedRace10959,
  DetailedRace11031,
  DetailedRace14290,
  DetailedRace14696,
  DetailedRace15982,
  DetailedRace14829,
  DetailedRace33373,
  DetailedRace33381,
  DetailedRace33399,
  DetailedRace33407,
  DetailedRace33415,
  DetailedRace14035,
  DetailedRace12880,
  DetailedRace33449,
  DetailedRace33456,
  DetailedRace12898,
  DetailedRace14050,
  DetailedRace14092,
  DetailedRace14118,
  DetailedRace14142,
  DetailedRace14167,
  DetailedRace14332,
  DetailedRace16048,
  DetailedRace13334,
  DetailedRace14399,
  DetailedRace33563,
  DetailedRace33571,
  DetailedRace14415,
  DetailedRace33597,
  DetailedRace33605,
  DetailedRace13342,
  DetailedRace14456,
  DetailedRace14464,
  DetailedRace13359,
  DetailedRace33654,
  DetailedRace33662,
  DetailedRace14480,
  DetailedRace33688,
  DetailedRace14530,
  DetailedRace17186,
  DetailedRace33712,
  DetailedRace14563,
  DetailedRace33738,
  DetailedRace16246,
  DetailedRace33753,
  DetailedRace15008,
  DetailedRace14605,
  DetailedRace33787,
  DetailedRace33795,
  DetailedRace14621,
  DetailedRace14431,
  DetailedRace12013,
  DetailedRace33837,
  DetailedRace12435,
  DetailedRace33852,
  DetailedRace14837,
  DetailedRace33878,
  DetailedRace14647,
  DetailedRace14746,
  DetailedRace14761,
  DetailedRace14753,
  DetailedRace33928,
  DetailedRace13284,
  DetailedRace13151,
  DetailedRace14787,
  DetailedRace33969,
  DetailedRace14878,
  DetailedRace14845,
  DetailedRace16253,
  DetailedRace12021,
  DetailedRace14894,
  DetailedRace14902,
  DetailedRace14928,
  DetailedRace14944,
  DetailedRace14951,
  DetailedRace14977,
  DetailedRace14985,
  DetailedRace14993,
  DetailedRace15016,
  DetailedRace15024,
  DetailedRace15032,
  DetailedRace15073,
  DetailedRace15081,
  DetailedRace15099,
  DetailedRace15115,
  DetailedRace15123,
  DetailedRace15156,
  DetailedRace15180,
  DetailedRace15263,
  DetailedRace14316,
  DetailedRace15412,
  DetailedRace34223,
  DetailedRace34231,
  DetailedRace10843,
  DetailedRace15438,
  DetailedRace12195,
  DetailedRace34272,
  DetailedRace15453,
  DetailedRace11411,
  DetailedRace11429,
  DetailedRace10611,
  DetailedRace34322,
  DetailedRace34330,
  DetailedRace15479,
  DetailedRace17335,
  DetailedRace34363,
  DetailedRace34371,
  DetailedRace16279,
  DetailedRace15495,
  DetailedRace15511,
  DetailedRace15537,
  DetailedRace15545,
  DetailedRace15529,
  DetailedRace34447,
  DetailedRace11437,
  DetailedRace34462,
  DetailedRace15560,
  DetailedRace15586,
  DetailedRace14589,
  DetailedRace15271,
  DetailedRace10181,
  DetailedRace15065,
  DetailedRace14324,
  DetailedRace34546,
  DetailedRace15743,
  DetailedRace12294,
  DetailedRace10504,
  DetailedRace10629,
  DetailedRace11635,
  DetailedRace34603,
  DetailedRace34611,
  DetailedRace16295,
  DetailedRace34637,
  DetailedRace34645,
  DetailedRace15289,
  DetailedRace11452,
  DetailedRace15628,
  DetailedRace14704,
  DetailedRace34694,
  DetailedRace15669,
  DetailedRace34710,
  DetailedRace34728,
  DetailedRace12922,
  DetailedRace15735,
  DetailedRace13292,
  DetailedRace16261,
  DetailedRace15768,
  DetailedRace15784,
  DetailedRace34793,
  DetailedRace11007,
  DetailedRace34819,
  DetailedRace34827,
  DetailedRace15826,
  DetailedRace15842,
  DetailedRace15867,
  DetailedRace16022,
  DetailedRace12583,
  DetailedRace16030,
  DetailedRace16097,
  DetailedRace34900,
  DetailedRace16436,
  DetailedRace15297,
  DetailedRace15941,
  DetailedRace15305,
  DetailedRace15313,
  DetailedRace15321,
  DetailedRace13367,
  DetailedRace11460,
  DetailedRace34991,
  DetailedRace12443,
  DetailedRace10231,
  DetailedRace11049,
  DetailedRace35030,
  DetailedRace16329,
  DetailedRace16451,
  DetailedRace15339,
  DetailedRace11445,
  DetailedRace16337,
  DetailedRace15347,
  DetailedRace15354,
  DetailedRace16493,
  DetailedRace14712,
  DetailedRace14340,
  DetailedRace16519,
  DetailedRace12450,
  DetailedRace35162,
  DetailedRace15370,
  DetailedRace12310,
  DetailedRace35196,
  DetailedRace17194,
  DetailedRace10637,
  DetailedRace13979,
  DetailedRace35238,
  DetailedRace13383,
  DetailedRace35253,
  DetailedRace13987,
  DetailedRace16345,
  DetailedRace11122,
  DetailedRace11601,
  DetailedRace35303,
  DetailedRace11932,
  DetailedRace14076,
  DetailedRace15719,
  DetailedRace12039,
  DetailedRace35352,
  DetailedRace35360,
  DetailedRace12047,
  DetailedRace12542,
  DetailedRace13995,
  DetailedRace35402,
  DetailedRace35410,
  DetailedRace16592,
  DetailedRace35436,
  DetailedRace12930,
  DetailedRace16618,
  DetailedRace10173,
  DetailedRace10512,
  DetailedRace12724,
  DetailedRace12054,
  DetailedRace15388,
  DetailedRace17202,
  DetailedRace12468,
  DetailedRace35535,
  DetailedRace11478,
  DetailedRace12948,
  DetailedRace10967,
  DetailedRace13375,
  DetailedRace16634,
  DetailedRace16675,
  DetailedRace35600,
  DetailedRace35618,
  DetailedRace12773,
  DetailedRace10975,
  DetailedRace11189,
  DetailedRace35659,
  DetailedRace16360,
  DetailedRace15396,
  DetailedRace16709,
  DetailedRace16725,
  DetailedRace35709,
  DetailedRace14357,
  DetailedRace35725,
  DetailedRace12476,
  DetailedRace16378,
  DetailedRace16758,
  DetailedRace11197,
  DetailedRace14365,
  DetailedRace16774,
  DetailedRace16790,
  DetailedRace16808,
  DetailedRace10645,
  DetailedRace16857,
  DetailedRace35832,
  DetailedRace35840,
  DetailedRace16394,
  DetailedRace14001,
  DetailedRace12732,
  DetailedRace11486,
  DetailedRace10199,
  DetailedRace35907,
  DetailedRace16923,
  DetailedRace12484,
  DetailedRace11205,
  DetailedRace35949,
  DetailedRace16949,
  DetailedRace16964,
  DetailedRace16980,
  DetailedRace17004,
  DetailedRace17020,
  DetailedRace11213,
  DetailedRace36012,
  DetailedRace12955,
  DetailedRace17095,
  DetailedRace10652,
  DetailedRace16402,
  DetailedRace16410,
  DetailedRace17111,
  DetailedRace17152,
  DetailedRace17319,
  DetailedRace14373,
  DetailedRace36111,
  DetailedRace17178,
  DetailedRace16006,
  DetailedRace15149,
  DetailedRace17228,
  DetailedRace10660,
  DetailedRace17327,
  DetailedRace15164,
  DetailedRace17350,
  DetailedRace17376,
  DetailedRace17392,
  DetailedRace17400,
  DetailedRace17442,
  DetailedRace17418,
  DetailedRace17426,
  DetailedRace17434,
  DetailedRace17459,
  DetailedRace36285,
  DetailedRace17475,
  DetailedRace17483,
  DetailedRace17509,
  DetailedRace17525,
  DetailedRace17517,
  DetailedRace17541,
  DetailedRace17558,
  DetailedRace17574,
  DetailedRace17590,
  DetailedRace17616,
  DetailedRace17624,
  DetailedRace17657,
  DetailedRace17673,
  DetailedRace17681,
  DetailedRace17699,
  DetailedRace17707,
  DetailedRace17715,
  DetailedRace17756,
  DetailedRace17764,
  DetailedRace17772,
  DetailedRace17780,
  DetailedRace17806,
  DetailedRace17798,
  DetailedRace17814,
  DetailedRace17491,
  DetailedRace17533,
  DetailedRace17608,
  DetailedRace17632,
  DetailedRace17640,
  DetailedRace17749,
  DetailedRace17822,
  DetailedRace17913,
  DetailedRace17962,
  DetailedRace17996,
  DetailedRace18010,
  DetailedRace18036,
  DetailedRace18051,
  DetailedRace18077,
  DetailedRace17830,
  DetailedRace17848,
  DetailedRace17855,
  DetailedRace17863,
  DetailedRace17871,
  DetailedRace17889,
  DetailedRace17665,
  DetailedRace17897,
  DetailedRace17905,
  DetailedRace17939,
  DetailedRace17954,
  DetailedRace17947,
  DetailedRace17988,
  DetailedRace18028,
  DetailedRace18044,
  DetailedRace18069,
  DetailedRace17582,
  DetailedRace17723,
  DetailedRace17731,
  DetailedRace17921,
  DetailedRace17970,
  DetailedRace18085,
  DetailedRace18093,
  DetailedRace18259,
  DetailedRace19661,
  DetailedRace19943,
  DetailedRace20081,
  DetailedRace41871,
  DetailedRace19729,
  DetailedRace19737,
  DetailedRace19745,
  DetailedRace19844,
  DetailedRace19869,
  DetailedRace19752,
  DetailedRace18408,
  DetailedRace19760,
  DetailedRace19778,
  DetailedRace37044,
  DetailedRace20149,
  DetailedRace19786,
  DetailedRace19968,
  DetailedRace19794,
  DetailedRace19927,
  DetailedRace37101,
  DetailedRace37119,
  DetailedRace19935,
  DetailedRace20073,
  DetailedRace20115,
  DetailedRace20123,
  DetailedRace19851,
  DetailedRace20131,
  DetailedRace19901,
  DetailedRace20156,
  DetailedRace37200,
  DetailedRace19950,
  DetailedRace19976,
  DetailedRace19877,
  DetailedRace20164,
  DetailedRace20172,
  DetailedRace19992,
  DetailedRace19802,
  DetailedRace19810,
  DetailedRace19885,
  DetailedRace19828,
  DetailedRace20008,
  DetailedRace19695,
  DetailedRace20263,
  DetailedRace20180,
  DetailedRace37358,
  DetailedRace20206,
  DetailedRace20214,
  DetailedRace20222,
  DetailedRace20248,
  DetailedRace20024,
  DetailedRace37416,
  DetailedRace19703,
  DetailedRace37432,
  DetailedRace19984,
  DetailedRace37457,
  DetailedRace37465,
  DetailedRace18499,
  DetailedRace18507,
  DetailedRace18523,
  DetailedRace19091,
  DetailedRace37515,
  DetailedRace18424,
  DetailedRace37531,
  DetailedRace18481,
  DetailedRace18622,
  DetailedRace18630,
  DetailedRace37572,
  DetailedRace18713,
  DetailedRace18457,
  DetailedRace18515,
  DetailedRace18531,
  DetailedRace18549,
  DetailedRace18564,
  DetailedRace18572,
  DetailedRace18606,
  DetailedRace18580,
  DetailedRace18648,
  DetailedRace18655,
  DetailedRace18663,
  DetailedRace18671,
  DetailedRace18689,
  DetailedRace18895,
  DetailedRace19331,
  DetailedRace18721,
  DetailedRace18754,
  DetailedRace18762,
  DetailedRace18770,
  DetailedRace18788,
  DetailedRace18796,
  DetailedRace18804,
  DetailedRace18812,
  DetailedRace18838,
  DetailedRace18846,
  DetailedRace18861,
  DetailedRace37853,
  DetailedRace18739,
  DetailedRace18747,
  DetailedRace37887,
  DetailedRace18820,
  DetailedRace18853,
  DetailedRace18333,
  DetailedRace38612,
  DetailedRace18168,
  DetailedRace18176,
  DetailedRace18184,
  DetailedRace18192,
  DetailedRace18200,
  DetailedRace18218,
  DetailedRace18226,
  DetailedRace18267,
  DetailedRace18275,
  DetailedRace18234,
  DetailedRace18242,
  DetailedRace18309,
  DetailedRace18283,
  DetailedRace18291,
  DetailedRace18119,
  DetailedRace18317,
  DetailedRace38091,
  DetailedRace18325,
  DetailedRace18143,
  DetailedRace18341,
  DetailedRace18358,
  DetailedRace18374,
  DetailedRace18382,
  DetailedRace18960,
  DetailedRace18978,
  DetailedRace18986,
  DetailedRace19638,
  DetailedRace19349,
  DetailedRace19067,
  DetailedRace19075,
  DetailedRace38232,
  DetailedRace19133,
  DetailedRace19166,
  DetailedRace38265,
  DetailedRace19208,
  DetailedRace19299,
  DetailedRace19315,
  DetailedRace19356,
  DetailedRace19000,
  DetailedRace19109,
  DetailedRace19141,
  DetailedRace19158,
  DetailedRace18929,
  DetailedRace19620,
  DetailedRace19182,
  DetailedRace38380,
  DetailedRace19190,
  DetailedRace19224,
  DetailedRace19232,
  DetailedRace19257,
  DetailedRace19281,
  DetailedRace19497,
  DetailedRace19323,
  DetailedRace19364,
  DetailedRace19372,
  DetailedRace19380,
  DetailedRace19422,
  DetailedRace19539,
  DetailedRace19430,
  DetailedRace19463,
  DetailedRace19513,
  DetailedRace18937,
  DetailedRace19521,
  DetailedRace19596,
  DetailedRace19604,
  DetailedRace19240,
  DetailedRace19406,
  DetailedRace19398,
  DetailedRace19414,
  DetailedRace19570,
  DetailedRace19273,
  DetailedRace19042,
  DetailedRace19448,
  DetailedRace19455,
  DetailedRace19471,
  DetailedRace19489,
  DetailedRace18945,
  DetailedRace19554,
  DetailedRace19562,
  DetailedRace19588,
  DetailedRace19612,
  DetailedRace19646,
  DetailedRace18994,
  DetailedRace19026,
  DetailedRace19034,
  DetailedRace19059,
  DetailedRace19083,
  DetailedRace19117,
  DetailedRace19125,
  DetailedRace19216,
  DetailedRace19265,
  DetailedRace19307,
  DetailedRace38851,
  DetailedRace19505,
  DetailedRace19547,
  DetailedRace19018,
  DetailedRace38893,
  DetailedRace10694,
  DetailedRace38919,
  DetailedRace38927,
  DetailedRace38935,
  DetailedRace38943,
  DetailedRace38950,
  DetailedRace38968,
  DetailedRace38976,
  DetailedRace38984,
  DetailedRace38992,
  DetailedRace39008,
  DetailedRace39016,
  DetailedRace39024,
  DetailedRace39032,
  DetailedRace39040,
  DetailedRace39057,
  DetailedRace39065,
  DetailedRace39073,
  DetailedRace39081,
  DetailedRace39099,
  DetailedRace39107,
  DetailedRace39115,
  DetailedRace39123,
  DetailedRace39131,
  DetailedRace39149,
  DetailedRace39156,
  DetailedRace39164,
  DetailedRace39172,
  DetailedRace39180,
  DetailedRace39198,
  DetailedRace39206,
  DetailedRace39214,
  DetailedRace39222,
  DetailedRace39230,
  DetailedRace39248,
  DetailedRace39255,
  DetailedRace39263,
  DetailedRace39271,
  DetailedRace39289,
  DetailedRace39297,
  DetailedRace39305,
  DetailedRace39313,
  DetailedRace39321,
  DetailedRace39339,
  DetailedRace39347,
  DetailedRace39354,
  DetailedRace39362,
  DetailedRace39370,
  DetailedRace39388,
  DetailedRace39396,
  DetailedRace39404,
  DetailedRace39412,
  DetailedRace39420,
  DetailedRace39438,
  DetailedRace39446,
  DetailedRace39453,
  DetailedRace39461,
  DetailedRace39479,
  DetailedRace39487,
  DetailedRace39495,
  DetailedRace10710,
  DetailedRace39511,
  DetailedRace39529,
  DetailedRace39537,
  DetailedRace39545,
  DetailedRace39552,
  DetailedRace39560,
  DetailedRace39578,
  DetailedRace39586,
  DetailedRace39594,
  DetailedRace39602,
  DetailedRace39610,
  DetailedRace39628,
  DetailedRace39636,
  DetailedRace39644,
  DetailedRace39651,
  DetailedRace39669,
  DetailedRace39677,
  DetailedRace39685,
  DetailedRace39693,
  DetailedRace39701,
  DetailedRace39719,
  DetailedRace39727,
  DetailedRace39735,
  DetailedRace39743,
  DetailedRace39750,
  DetailedRace39768,
  DetailedRace39776,
  DetailedRace39784,
  DetailedRace39792,
  DetailedRace39800,
  DetailedRace39818,
  DetailedRace39826,
  DetailedRace39834,
  DetailedRace39842,
  DetailedRace39859,
  DetailedRace39867,
  DetailedRace39875,
  DetailedRace39883,
  DetailedRace39891,
  DetailedRace39909,
  DetailedRace39917,
  DetailedRace39925,
  DetailedRace39933,
  DetailedRace39941,
  DetailedRace39958,
  DetailedRace39966,
  DetailedRace39974,
  DetailedRace39982,
  DetailedRace39990,
  DetailedRace40006,
  DetailedRace40014,
  DetailedRace40022,
  DetailedRace40030,
  DetailedRace40048,
  DetailedRace40055,
  DetailedRace40063,
  DetailedRace40071,
  DetailedRace40089,
  DetailedRace40097,
  DetailedRace40105,
  DetailedRace40113,
  DetailedRace40121,
  DetailedRace40139,
  DetailedRace40147,
  DetailedRace40154,
  DetailedRace40162,
  DetailedRace40170,
  DetailedRace40188,
  DetailedRace40196,
  DetailedRace40204,
  DetailedRace40212,
  DetailedRace40220,
  DetailedRace40238,
  DetailedRace40246,
  DetailedRace40253,
  DetailedRace40261,
  DetailedRace40279,
  DetailedRace40287,
  DetailedRace40295,
  DetailedRace40303,
  DetailedRace40311,
  DetailedRace40329,
  DetailedRace40337,
  DetailedRace40345,
  DetailedRace40352,
  DetailedRace40360,
  DetailedRace40378,
  DetailedRace40386,
  DetailedRace40394,
  DetailedRace40402,
  DetailedRace40410,
  DetailedRace40428,
  DetailedRace40436,
  DetailedRace40444,
  DetailedRace40451,
  DetailedRace40469,
  DetailedRace40477,
  DetailedRace40485,
  DetailedRace40493,
  DetailedRace40501,
  DetailedRace40519,
  DetailedRace40527,
  DetailedRace40535,
  DetailedRace40543,
  DetailedRace40550,
  DetailedRace40568,
  DetailedRace40576,
  DetailedRace40584,
  DetailedRace40592,
  DetailedRace40600,
  DetailedRace40618,
  DetailedRace40626,
  DetailedRace40634,
  DetailedRace40642,
  DetailedRace40659,
  DetailedRace40667,
  DetailedRace40675,
  DetailedRace40683,
  DetailedRace40691,
  DetailedRace40709,
  DetailedRace40717,
  DetailedRace40725,
  DetailedRace40733,
  DetailedRace40741,
  DetailedRace40758,
  DetailedRace40766,
  DetailedRace40774,
  DetailedRace40782,
  DetailedRace40790,
  DetailedRace40808,
  DetailedRace40816,
  DetailedRace40824,
  DetailedRace40832,
  DetailedRace40840,
  DetailedRace40857,
  DetailedRace10702,
  DetailedRace40873,
  DetailedRace40881,
  DetailedRace40899,
  DetailedRace40907,
  DetailedRace40915,
  DetailedRace40923,
  DetailedRace40931,
  DetailedRace40949,
  DetailedRace40956,
  DetailedRace40964,
  DetailedRace40972,
  DetailedRace40980,
  DetailedRace40998,
  DetailedRace41004,
  DetailedRace41012,
  DetailedRace41020,
  DetailedRace41038,
  DetailedRace41046,
  DetailedRace41053,
  DetailedRace41061,
  DetailedRace41079,
  DetailedRace41087,
  DetailedRace41095,
  DetailedRace41103,
  DetailedRace41111,
  DetailedRace41129,
  DetailedRace41137,
  DetailedRace41145,
  DetailedRace41152,
  DetailedRace41160,
  DetailedRace41178,
  DetailedRace41186,
  DetailedRace41194,
  DetailedRace41202,
  DetailedRace41210,
  DetailedRace41228,
  DetailedRace41236,
  DetailedRace41244,
  DetailedRace41251,
  DetailedRace41269,
  DetailedRace41277,
  DetailedRace41285,
  DetailedRace41293,
  DetailedRace41301,
  DetailedRace41319,
  DetailedRace41327,
  DetailedRace41335,
  DetailedRace41343,
  DetailedRace41350,
  DetailedRace41368,
  DetailedRace41376,
  DetailedRace41384,
  DetailedRace41392,
  DetailedRace41400,
  DetailedRace41418,
  DetailedRace41426,
  DetailedRace41434,
  DetailedRace41442,
  DetailedRace41459,
  DetailedRace41467,
  DetailedRace10728,
  DetailedRace41483,
  DetailedRace10736,
  DetailedRace41509,
  DetailedRace41517,
  DetailedRace41525,
  DetailedRace41533,
  DetailedRace41541,
  DetailedRace41558,
  DetailedRace41566,
  DetailedRace41574,
  DetailedRace41582,
  DetailedRace41590,
  DetailedRace41608,
  DetailedRace41616,
  DetailedRace41624,
  DetailedRace41632,
  DetailedRace41640,
  DetailedRace41657,
  DetailedRace41665,
  DetailedRace41673,
  DetailedRace41681,
  DetailedRace41699,
  DetailedRace41707,
  DetailedRace41715,
  DetailedRace41723,
  DetailedRace41731,
  DetailedRace41749,
  DetailedRace41756,
  DetailedRace41764,
  DetailedRace41772,
  DetailedRace41780,
  DetailedRace41798,
  DetailedRace41806,
  DetailedRace41814,
  DetailedRace10744,
  DetailedRace41830,
  DetailedRace41848,
  DetailedRace41855,
  DetailedRace20297,
  DetailedRace20305,
  DetailedRace20313,
  DetailedRace20321,
  DetailedRace20339,
  DetailedRace20347,
  DetailedRace20354,
  DetailedRace20362,
  DetailedRace20370,
  DetailedRace20388,
  DetailedRace20396,
  DetailedRace20404,
  DetailedRace20412,
  DetailedRace20420,
  DetailedRace20438,
  DetailedRace20446,
  DetailedRace20453,
  DetailedRace20461,
  DetailedRace20479,
  DetailedRace20487,
  DetailedRace20495,
  DetailedRace20503,
  DetailedRace20511,
  DetailedRace20529,
  DetailedRace20560,
  DetailedRace20586,
  DetailedRace20602,
  DetailedRace20610,
  DetailedRace20628,
  DetailedRace20636,
  DetailedRace20644,
  DetailedRace20651,
  DetailedRace20669,
  DetailedRace41863,
  DetailedRace20677,
  DetailedRace20685,
  DetailedRace20693,
  DetailedRace20701,
  DetailedRace20719,
  DetailedRace20727,
  DetailedRace20735,
  DetailedRace20743,
  DetailedRace20750,
  DetailedRace20784,
  DetailedRace20792,
  DetailedRace20800,
  DetailedRace20818,
  DetailedRace20826,
  DetailedRace20834,
  DetailedRace20859,
  DetailedRace20867,
  DetailedRace20875,
  DetailedRace20883,
  DetailedRace20891,
  DetailedRace20909,
  DetailedRace20917,
  DetailedRace20925,
  DetailedRace20933,
  DetailedRace20941,
  DetailedRace20958,
  DetailedRace20966,
  DetailedRace20974,
  DetailedRace20982,
  DetailedRace21006,
  DetailedRace21014,
  DetailedRace21022,
  DetailedRace21030,
  DetailedRace21048,
  DetailedRace25007,
  DetailedRace21089,
  DetailedRace21097,
  DetailedRace21105,
  DetailedRace21113,
  DetailedRace21121,
  DetailedRace21139,
  DetailedRace21147,
  DetailedRace21154,
  DetailedRace21162,
  DetailedRace21188,
  DetailedRace21196,
  DetailedRace21204,
  DetailedRace21212,
  DetailedRace21220,
  DetailedRace21238,
  DetailedRace21246,
  DetailedRace21253,
  DetailedRace21261,
  DetailedRace21279,
  DetailedRace21295,
  DetailedRace21311,
  DetailedRaceAsku,
  DetailedRaceOth,
  DetailedRaceUnk,
]

pub fn detailed_race_to_json(detailed_race: DetailedRace) -> Json {
  json.string(detailed_race_to_code(detailed_race))
}

pub fn detailed_race_to_code(detailed_race: DetailedRace) -> String {
  case detailed_race {
    DetailedRace10041 -> "1004-1"
    DetailedRace10066 -> "1006-6"
    DetailedRace15792 -> "1579-2"
    DetailedRace12120 -> "1212-0"
    DetailedRace10454 -> "1045-4"
    DetailedRace16543 -> "1654-3"
    DetailedRace11940 -> "1194-0"
    DetailedRace11957 -> "1195-7"
    DetailedRace11874 -> "1187-4"
    DetailedRace10082 -> "1008-2"
    DetailedRace30122 -> "3012-2"
    DetailedRace16881 -> "1688-1"
    DetailedRace13920 -> "1392-0"
    DetailedRace30155 -> "3015-5"
    DetailedRace30163 -> "3016-3"
    DetailedRace10108 -> "1010-8"
    DetailedRace10165 -> "1016-5"
    DetailedRace10215 -> "1021-5"
    DetailedRace10249 -> "1024-9"
    DetailedRace10264 -> "1026-4"
    DetailedRace13664 -> "1366-4"
    DetailedRace10280 -> "1028-0"
    DetailedRace30247 -> "3024-7"
    DetailedRace30254 -> "3025-4"
    DetailedRace12344 -> "1234-4"
    DetailedRace12658 -> "1265-8"
    DetailedRace10462 -> "1046-2"
    DetailedRace11247 -> "1124-7"
    DetailedRace10330 -> "1033-0"
    DetailedRace30312 -> "3031-2"
    DetailedRace11254 -> "1125-4"
    DetailedRace10603 -> "1060-3"
    DetailedRace30346 -> "3034-6"
    DetailedRace30353 -> "3035-3"
    DetailedRace30361 -> "3036-1"
    DetailedRace14308 -> "1430-8"
    DetailedRace30387 -> "3038-7"
    DetailedRace30395 -> "3039-5"
    DetailedRace12351 -> "1235-1"
    DetailedRace30411 -> "3041-1"
    DetailedRace14175 -> "1417-5"
    DetailedRace10355 -> "1035-5"
    DetailedRace30445 -> "3044-5"
    DetailedRace11262 -> "1126-2"
    DetailedRace14183 -> "1418-3"
    DetailedRace10371 -> "1037-1"
    DetailedRace16113 -> "1611-3"
    DetailedRace30494 -> "3049-4"
    DetailedRace14191 -> "1419-1"
    DetailedRace30510 -> "3051-0"
    DetailedRace10470 -> "1047-0"
    DetailedRace30536 -> "3053-6"
    DetailedRace10413 -> "1041-3"
    DetailedRace30551 -> "3055-1"
    DetailedRace10421 -> "1042-1"
    DetailedRace10546 -> "1054-6"
    DetailedRace10447 -> "1044-7"
    DetailedRace30593 -> "3059-3"
    DetailedRace30601 -> "3060-1"
    DetailedRace12237 -> "1223-7"
    DetailedRace12245 -> "1224-5"
    DetailedRace10769 -> "1076-9"
    DetailedRace12864 -> "1286-4"
    DetailedRace10785 -> "1078-5"
    DetailedRace14209 -> "1420-9"
    DetailedRace13938 -> "1393-8"
    DetailedRace14654 -> "1465-4"
    DetailedRace30692 -> "3069-2"
    DetailedRace30700 -> "3070-0"
    DetailedRace30718 -> "3071-8"
    DetailedRace10827 -> "1082-7"
    DetailedRace10868 -> "1086-8"
    DetailedRace30742 -> "3074-2"
    DetailedRace30759 -> "3075-9"
    DetailedRace30767 -> "3076-7"
    DetailedRace10884 -> "1088-4"
    DetailedRace10892 -> "1089-2"
    DetailedRace30791 -> "3079-1"
    DetailedRace30809 -> "3080-9"
    DetailedRace30817 -> "3081-7"
    DetailedRace10900 -> "1090-0"
    DetailedRace11023 -> "1102-3"
    DetailedRace11064 -> "1106-4"
    DetailedRace30858 -> "3085-8"
    DetailedRace30866 -> "3086-6"
    DetailedRace11098 -> "1109-8"
    DetailedRace30882 -> "3088-2"
    DetailedRace10553 -> "1055-3"
    DetailedRace11148 -> "1114-8"
    DetailedRace11239 -> "1123-9"
    DetailedRace30924 -> "3092-4"
    DetailedRace11536 -> "1153-6"
    DetailedRace11551 -> "1155-1"
    DetailedRace30957 -> "3095-7"
    DetailedRace11627 -> "1162-7"
    DetailedRace14795 -> "1479-5"
    DetailedRace11155 -> "1115-5"
    DetailedRace11650 -> "1165-0"
    DetailedRace11569 -> "1156-9"
    DetailedRace31013 -> "3101-3"
    DetailedRace17251 -> "1725-1"
    DetailedRace11676 -> "1167-6"
    DetailedRace11692 -> "1169-2"
    DetailedRace31054 -> "3105-4"
    DetailedRace11718 -> "1171-8"
    DetailedRace13946 -> "1394-6"
    DetailedRace11163 -> "1116-3"
    DetailedRace31096 -> "3109-6"
    DetailedRace15602 -> "1560-2"
    DetailedRace17079 -> "1707-9"
    DetailedRace16071 -> "1607-1"
    DetailedRace10801 -> "1080-1"
    DetailedRace11734 -> "1173-4"
    DetailedRace11783 -> "1178-3"
    DetailedRace15917 -> "1591-7"
    DetailedRace12625 -> "1262-5"
    DetailedRace16659 -> "1665-9"
    DetailedRace16832 -> "1683-2"
    DetailedRace11809 -> "1180-9"
    DetailedRace11825 -> "1182-5"
    DetailedRace11841 -> "1184-1"
    DetailedRace11866 -> "1186-6"
    DetailedRace31245 -> "3124-5"
    DetailedRace16683 -> "1668-3"
    DetailedRace11890 -> "1189-0"
    DetailedRace31278 -> "3127-8"
    DetailedRace11916 -> "1191-6"
    DetailedRace12070 -> "1207-0"
    DetailedRace16139 -> "1613-9"
    DetailedRace12096 -> "1209-6"
    DetailedRace31328 -> "3132-8"
    DetailedRace12112 -> "1211-2"
    DetailedRace31344 -> "3134-4"
    DetailedRace31351 -> "3135-1"
    DetailedRace31369 -> "3136-9"
    DetailedRace10579 -> "1057-9"
    DetailedRace14662 -> "1466-2"
    DetailedRace15883 -> "1588-3"
    DetailedRace15198 -> "1519-8"
    DetailedRace31419 -> "3141-9"
    DetailedRace10926 -> "1092-6"
    DetailedRace11965 -> "1196-5"
    DetailedRace11973 -> "1197-3"
    DetailedRace31450 -> "3145-0"
    DetailedRace14670 -> "1467-0"
    DetailedRace15800 -> "1580-0"
    DetailedRace15990 -> "1599-0"
    DetailedRace10934 -> "1093-4"
    DetailedRace12393 -> "1239-3"
    DetailedRace14720 -> "1472-0"
    DetailedRace31526 -> "3152-6"
    DetailedRace31534 -> "3153-4"
    DetailedRace15909 -> "1590-9"
    DetailedRace31559 -> "3155-9"
    DetailedRace12500 -> "1250-0"
    DetailedRace12252 -> "1225-2"
    DetailedRace10561 -> "1056-1"
    DetailedRace31591 -> "3159-1"
    DetailedRace16154 -> "1615-4"
    DetailedRace11288 -> "1128-8"
    DetailedRace31625 -> "3162-5"
    DetailedRace12526 -> "1252-6"
    DetailedRace14217 -> "1421-7"
    DetailedRace14225 -> "1422-5"
    DetailedRace16055 -> "1605-5"
    DetailedRace12567 -> "1256-7"
    DetailedRace17293 -> "1729-3"
    DetailedRace31690 -> "3169-0"
    DetailedRace31708 -> "3170-8"
    DetailedRace12609 -> "1260-9"
    DetailedRace12369 -> "1236-9"
    DetailedRace31732 -> "3173-2"
    DetailedRace31740 -> "3174-0"
    DetailedRace12427 -> "1242-7"
    DetailedRace11296 -> "1129-6"
    DetailedRace31773 -> "3177-3"
    DetailedRace11304 -> "1130-4"
    DetailedRace31799 -> "3179-9"
    DetailedRace31807 -> "3180-7"
    DetailedRace12641 -> "1264-1"
    DetailedRace31823 -> "3182-3"
    DetailedRace31831 -> "3183-1"
    DetailedRace31849 -> "3184-9"
    DetailedRace12674 -> "1267-4"
    DetailedRace14811 -> "1481-1"
    DetailedRace31872 -> "3187-2"
    DetailedRace17269 -> "1726-9"
    DetailedRace31898 -> "3189-8"
    DetailedRace12690 -> "1269-0"
    DetailedRace16972 -> "1697-2"
    DetailedRace10835 -> "1083-5"
    DetailedRace12757 -> "1275-7"
    DetailedRace12716 -> "1271-6"
    DetailedRace31955 -> "3195-5"
    DetailedRace31963 -> "3196-3"
    DetailedRace31971 -> "3197-1"
    DetailedRace17277 -> "1727-7"
    DetailedRace12302 -> "1230-2"
    DetailedRace13599 -> "1359-9"
    DetailedRace12799 -> "1279-9"
    DetailedRace14423 -> "1442-3"
    DetailedRace13607 -> "1360-7"
    DetailedRace32045 -> "3204-5"
    DetailedRace12815 -> "1281-5"
    DetailedRace12823 -> "1282-3"
    DetailedRace12831 -> "1283-1"
    DetailedRace12856 -> "1285-6"
    DetailedRace32094 -> "3209-4"
    DetailedRace13136 -> "1313-6"
    DetailedRace32110 -> "3211-0"
    DetailedRace11577 -> "1157-7"
    DetailedRace10132 -> "1013-2"
    DetailedRace12971 -> "1297-1"
    DetailedRace14233 -> "1423-3"
    DetailedRace13953 -> "1395-3"
    DetailedRace12997 -> "1299-7"
    DetailedRace13011 -> "1301-1"
    DetailedRace14688 -> "1468-8"
    DetailedRace11171 -> "1117-1"
    DetailedRace13037 -> "1303-7"
    DetailedRace32227 -> "3222-7"
    DetailedRace15107 -> "1510-7"
    DetailedRace32243 -> "3224-3"
    DetailedRace11981 -> "1198-1"
    DetailedRace13052 -> "1305-2"
    DetailedRace13078 -> "1307-8"
    DetailedRace32284 -> "3228-4"
    DetailedRace13060 -> "1306-0"
    DetailedRace15206 -> "1520-6"
    DetailedRace13094 -> "1309-4"
    DetailedRace13102 -> "1310-2"
    DetailedRace13128 -> "1312-8"
    DetailedRace32342 -> "3234-2"
    DetailedRace32359 -> "3235-9"
    DetailedRace32367 -> "3236-7"
    DetailedRace32375 -> "3237-5"
    DetailedRace13193 -> "1319-3"
    DetailedRace13219 -> "1321-9"
    DetailedRace12229 -> "1222-9"
    DetailedRace13326 -> "1332-6"
    DetailedRace12260 -> "1226-0"
    DetailedRace11320 -> "1132-0"
    DetailedRace11338 -> "1133-8"
    DetailedRace11346 -> "1134-6"
    DetailedRace11353 -> "1135-3"
    DetailedRace14241 -> "1424-1"
    DetailedRace13235 -> "1323-5"
    DetailedRace11361 -> "1136-1"
    DetailedRace32508 -> "3250-8"
    DetailedRace10140 -> "1014-0"
    DetailedRace32524 -> "3252-4"
    DetailedRace11379 -> "1137-9"
    DetailedRace32540 -> "3254-0"
    DetailedRace14258 -> "1425-8"
    DetailedRace10488 -> "1048-8"
    DetailedRace32573 -> "3257-3"
    DetailedRace14266 -> "1426-6"
    DetailedRace16188 -> "1618-8"
    DetailedRace13144 -> "1314-4"
    DetailedRace11999 -> "1199-9"
    DetailedRace16196 -> "1619-6"
    DetailedRace15214 -> "1521-4"
    DetailedRace13318 -> "1331-8"
    DetailedRace13409 -> "1340-9"
    DetailedRace13425 -> "1342-5"
    DetailedRace32672 -> "3267-2"
    DetailedRace12005 -> "1200-5"
    DetailedRace13441 -> "1344-1"
    DetailedRace13482 -> "1348-2"
    DetailedRace14274 -> "1427-4"
    DetailedRace13508 -> "1350-8"
    DetailedRace32730 -> "3273-0"
    DetailedRace13524 -> "1352-4"
    DetailedRace12278 -> "1227-8"
    DetailedRace17285 -> "1728-5"
    DetailedRace32771 -> "3277-1"
    DetailedRace14548 -> "1454-8"
    DetailedRace16816 -> "1681-6"
    DetailedRace32805 -> "3280-5"
    DetailedRace13268 -> "1326-8"
    DetailedRace13540 -> "1354-0"
    DetailedRace16204 -> "1620-4"
    DetailedRace32847 -> "3284-7"
    DetailedRace32854 -> "3285-4"
    DetailedRace13565 -> "1356-5"
    DetailedRace12286 -> "1228-6"
    DetailedRace10157 -> "1015-7"
    DetailedRace32896 -> "3289-6"
    DetailedRace13581 -> "1358-1"
    DetailedRace13615 -> "1361-5"
    DetailedRace13631 -> "1363-1"
    DetailedRace13656 -> "1365-6"
    DetailedRace32946 -> "3294-6"
    DetailedRace11387 -> "1138-7"
    DetailedRace11395 -> "1139-5"
    DetailedRace13680 -> "1368-0"
    DetailedRace11585 -> "1158-5"
    DetailedRace13706 -> "1370-6"
    DetailedRace14282 -> "1428-2"
    DetailedRace13722 -> "1372-2"
    DetailedRace12872 -> "1287-2"
    DetailedRace13748 -> "1374-8"
    DetailedRace13961 -> "1396-1"
    DetailedRace33050 -> "3305-0"
    DetailedRace13763 -> "1376-3"
    DetailedRace13276 -> "1327-6"
    DetailedRace12377 -> "1237-7"
    DetailedRace33092 -> "3309-2"
    DetailedRace10496 -> "1049-6"
    DetailedRace13458 -> "1345-8"
    DetailedRace11593 -> "1159-3"
    DetailedRace15222 -> "1522-2"
    DetailedRace12179 -> "1217-9"
    DetailedRace12385 -> "1238-5"
    DetailedRace13789 -> "1378-9"
    DetailedRace33175 -> "3317-5"
    DetailedRace13805 -> "1380-5"
    DetailedRace33191 -> "3319-1"
    DetailedRace12401 -> "1240-1"
    DetailedRace33217 -> "3321-7"
    DetailedRace12203 -> "1220-3"
    DetailedRace13870 -> "1387-0"
    DetailedRace12419 -> "1241-9"
    DetailedRace13466 -> "1346-6"
    DetailedRace15230 -> "1523-0"
    DetailedRace13896 -> "1389-6"
    DetailedRace15248 -> "1524-8"
    DetailedRace33290 -> "3329-0"
    DetailedRace10223 -> "1022-3"
    DetailedRace10959 -> "1095-9"
    DetailedRace11031 -> "1103-1"
    DetailedRace14290 -> "1429-0"
    DetailedRace14696 -> "1469-6"
    DetailedRace15982 -> "1598-2"
    DetailedRace14829 -> "1482-9"
    DetailedRace33373 -> "3337-3"
    DetailedRace33381 -> "3338-1"
    DetailedRace33399 -> "3339-9"
    DetailedRace33407 -> "3340-7"
    DetailedRace33415 -> "3341-5"
    DetailedRace14035 -> "1403-5"
    DetailedRace12880 -> "1288-0"
    DetailedRace33449 -> "3344-9"
    DetailedRace33456 -> "3345-6"
    DetailedRace12898 -> "1289-8"
    DetailedRace14050 -> "1405-0"
    DetailedRace14092 -> "1409-2"
    DetailedRace14118 -> "1411-8"
    DetailedRace14142 -> "1414-2"
    DetailedRace14167 -> "1416-7"
    DetailedRace14332 -> "1433-2"
    DetailedRace16048 -> "1604-8"
    DetailedRace13334 -> "1333-4"
    DetailedRace14399 -> "1439-9"
    DetailedRace33563 -> "3356-3"
    DetailedRace33571 -> "3357-1"
    DetailedRace14415 -> "1441-5"
    DetailedRace33597 -> "3359-7"
    DetailedRace33605 -> "3360-5"
    DetailedRace13342 -> "1334-2"
    DetailedRace14456 -> "1445-6"
    DetailedRace14464 -> "1446-4"
    DetailedRace13359 -> "1335-9"
    DetailedRace33654 -> "3365-4"
    DetailedRace33662 -> "3366-2"
    DetailedRace14480 -> "1448-0"
    DetailedRace33688 -> "3368-8"
    DetailedRace14530 -> "1453-0"
    DetailedRace17186 -> "1718-6"
    DetailedRace33712 -> "3371-2"
    DetailedRace14563 -> "1456-3"
    DetailedRace33738 -> "3373-8"
    DetailedRace16246 -> "1624-6"
    DetailedRace33753 -> "3375-3"
    DetailedRace15008 -> "1500-8"
    DetailedRace14605 -> "1460-5"
    DetailedRace33787 -> "3378-7"
    DetailedRace33795 -> "3379-5"
    DetailedRace14621 -> "1462-1"
    DetailedRace14431 -> "1443-1"
    DetailedRace12013 -> "1201-3"
    DetailedRace33837 -> "3383-7"
    DetailedRace12435 -> "1243-5"
    DetailedRace33852 -> "3385-2"
    DetailedRace14837 -> "1483-7"
    DetailedRace33878 -> "3387-8"
    DetailedRace14647 -> "1464-7"
    DetailedRace14746 -> "1474-6"
    DetailedRace14761 -> "1476-1"
    DetailedRace14753 -> "1475-3"
    DetailedRace33928 -> "3392-8"
    DetailedRace13284 -> "1328-4"
    DetailedRace13151 -> "1315-1"
    DetailedRace14787 -> "1478-7"
    DetailedRace33969 -> "3396-9"
    DetailedRace14878 -> "1487-8"
    DetailedRace14845 -> "1484-5"
    DetailedRace16253 -> "1625-3"
    DetailedRace12021 -> "1202-1"
    DetailedRace14894 -> "1489-4"
    DetailedRace14902 -> "1490-2"
    DetailedRace14928 -> "1492-8"
    DetailedRace14944 -> "1494-4"
    DetailedRace14951 -> "1495-1"
    DetailedRace14977 -> "1497-7"
    DetailedRace14985 -> "1498-5"
    DetailedRace14993 -> "1499-3"
    DetailedRace15016 -> "1501-6"
    DetailedRace15024 -> "1502-4"
    DetailedRace15032 -> "1503-2"
    DetailedRace15073 -> "1507-3"
    DetailedRace15081 -> "1508-1"
    DetailedRace15099 -> "1509-9"
    DetailedRace15115 -> "1511-5"
    DetailedRace15123 -> "1512-3"
    DetailedRace15156 -> "1515-6"
    DetailedRace15180 -> "1518-0"
    DetailedRace15263 -> "1526-3"
    DetailedRace14316 -> "1431-6"
    DetailedRace15412 -> "1541-2"
    DetailedRace34223 -> "3422-3"
    DetailedRace34231 -> "3423-1"
    DetailedRace10843 -> "1084-3"
    DetailedRace15438 -> "1543-8"
    DetailedRace12195 -> "1219-5"
    DetailedRace34272 -> "3427-2"
    DetailedRace15453 -> "1545-3"
    DetailedRace11411 -> "1141-1"
    DetailedRace11429 -> "1142-9"
    DetailedRace10611 -> "1061-1"
    DetailedRace34322 -> "3432-2"
    DetailedRace34330 -> "3433-0"
    DetailedRace15479 -> "1547-9"
    DetailedRace17335 -> "1733-5"
    DetailedRace34363 -> "3436-3"
    DetailedRace34371 -> "3437-1"
    DetailedRace16279 -> "1627-9"
    DetailedRace15495 -> "1549-5"
    DetailedRace15511 -> "1551-1"
    DetailedRace15537 -> "1553-7"
    DetailedRace15545 -> "1554-5"
    DetailedRace15529 -> "1552-9"
    DetailedRace34447 -> "3444-7"
    DetailedRace11437 -> "1143-7"
    DetailedRace34462 -> "3446-2"
    DetailedRace15560 -> "1556-0"
    DetailedRace15586 -> "1558-6"
    DetailedRace14589 -> "1458-9"
    DetailedRace15271 -> "1527-1"
    DetailedRace10181 -> "1018-1"
    DetailedRace15065 -> "1506-5"
    DetailedRace14324 -> "1432-4"
    DetailedRace34546 -> "3454-6"
    DetailedRace15743 -> "1574-3"
    DetailedRace12294 -> "1229-4"
    DetailedRace10504 -> "1050-4"
    DetailedRace10629 -> "1062-9"
    DetailedRace11635 -> "1163-5"
    DetailedRace34603 -> "3460-3"
    DetailedRace34611 -> "3461-1"
    DetailedRace16295 -> "1629-5"
    DetailedRace34637 -> "3463-7"
    DetailedRace34645 -> "3464-5"
    DetailedRace15289 -> "1528-9"
    DetailedRace11452 -> "1145-2"
    DetailedRace15628 -> "1562-8"
    DetailedRace14704 -> "1470-4"
    DetailedRace34694 -> "3469-4"
    DetailedRace15669 -> "1566-9"
    DetailedRace34710 -> "3471-0"
    DetailedRace34728 -> "3472-8"
    DetailedRace12922 -> "1292-2"
    DetailedRace15735 -> "1573-5"
    DetailedRace13292 -> "1329-2"
    DetailedRace16261 -> "1626-1"
    DetailedRace15768 -> "1576-8"
    DetailedRace15784 -> "1578-4"
    DetailedRace34793 -> "3479-3"
    DetailedRace11007 -> "1100-7"
    DetailedRace34819 -> "3481-9"
    DetailedRace34827 -> "3482-7"
    DetailedRace15826 -> "1582-6"
    DetailedRace15842 -> "1584-2"
    DetailedRace15867 -> "1586-7"
    DetailedRace16022 -> "1602-2"
    DetailedRace12583 -> "1258-3"
    DetailedRace16030 -> "1603-0"
    DetailedRace16097 -> "1609-7"
    DetailedRace34900 -> "3490-0"
    DetailedRace16436 -> "1643-6"
    DetailedRace15297 -> "1529-7"
    DetailedRace15941 -> "1594-1"
    DetailedRace15305 -> "1530-5"
    DetailedRace15313 -> "1531-3"
    DetailedRace15321 -> "1532-1"
    DetailedRace13367 -> "1336-7"
    DetailedRace11460 -> "1146-0"
    DetailedRace34991 -> "3499-1"
    DetailedRace12443 -> "1244-3"
    DetailedRace10231 -> "1023-1"
    DetailedRace11049 -> "1104-9"
    DetailedRace35030 -> "3503-0"
    DetailedRace16329 -> "1632-9"
    DetailedRace16451 -> "1645-1"
    DetailedRace15339 -> "1533-9"
    DetailedRace11445 -> "1144-5"
    DetailedRace16337 -> "1633-7"
    DetailedRace15347 -> "1534-7"
    DetailedRace15354 -> "1535-4"
    DetailedRace16493 -> "1649-3"
    DetailedRace14712 -> "1471-2"
    DetailedRace14340 -> "1434-0"
    DetailedRace16519 -> "1651-9"
    DetailedRace12450 -> "1245-0"
    DetailedRace35162 -> "3516-2"
    DetailedRace15370 -> "1537-0"
    DetailedRace12310 -> "1231-0"
    DetailedRace35196 -> "3519-6"
    DetailedRace17194 -> "1719-4"
    DetailedRace10637 -> "1063-7"
    DetailedRace13979 -> "1397-9"
    DetailedRace35238 -> "3523-8"
    DetailedRace13383 -> "1338-3"
    DetailedRace35253 -> "3525-3"
    DetailedRace13987 -> "1398-7"
    DetailedRace16345 -> "1634-5"
    DetailedRace11122 -> "1112-2"
    DetailedRace11601 -> "1160-1"
    DetailedRace35303 -> "3530-3"
    DetailedRace11932 -> "1193-2"
    DetailedRace14076 -> "1407-6"
    DetailedRace15719 -> "1571-9"
    DetailedRace12039 -> "1203-9"
    DetailedRace35352 -> "3535-2"
    DetailedRace35360 -> "3536-0"
    DetailedRace12047 -> "1204-7"
    DetailedRace12542 -> "1254-2"
    DetailedRace13995 -> "1399-5"
    DetailedRace35402 -> "3540-2"
    DetailedRace35410 -> "3541-0"
    DetailedRace16592 -> "1659-2"
    DetailedRace35436 -> "3543-6"
    DetailedRace12930 -> "1293-0"
    DetailedRace16618 -> "1661-8"
    DetailedRace10173 -> "1017-3"
    DetailedRace10512 -> "1051-2"
    DetailedRace12724 -> "1272-4"
    DetailedRace12054 -> "1205-4"
    DetailedRace15388 -> "1538-8"
    DetailedRace17202 -> "1720-2"
    DetailedRace12468 -> "1246-8"
    DetailedRace35535 -> "3553-5"
    DetailedRace11478 -> "1147-8"
    DetailedRace12948 -> "1294-8"
    DetailedRace10967 -> "1096-7"
    DetailedRace13375 -> "1337-5"
    DetailedRace16634 -> "1663-4"
    DetailedRace16675 -> "1667-5"
    DetailedRace35600 -> "3560-0"
    DetailedRace35618 -> "3561-8"
    DetailedRace12773 -> "1277-3"
    DetailedRace10975 -> "1097-5"
    DetailedRace11189 -> "1118-9"
    DetailedRace35659 -> "3565-9"
    DetailedRace16360 -> "1636-0"
    DetailedRace15396 -> "1539-6"
    DetailedRace16709 -> "1670-9"
    DetailedRace16725 -> "1672-5"
    DetailedRace35709 -> "3570-9"
    DetailedRace14357 -> "1435-7"
    DetailedRace35725 -> "3572-5"
    DetailedRace12476 -> "1247-6"
    DetailedRace16378 -> "1637-8"
    DetailedRace16758 -> "1675-8"
    DetailedRace11197 -> "1119-7"
    DetailedRace14365 -> "1436-5"
    DetailedRace16774 -> "1677-4"
    DetailedRace16790 -> "1679-0"
    DetailedRace16808 -> "1680-8"
    DetailedRace10645 -> "1064-5"
    DetailedRace16857 -> "1685-7"
    DetailedRace35832 -> "3583-2"
    DetailedRace35840 -> "3584-0"
    DetailedRace16394 -> "1639-4"
    DetailedRace14001 -> "1400-1"
    DetailedRace12732 -> "1273-2"
    DetailedRace11486 -> "1148-6"
    DetailedRace10199 -> "1019-9"
    DetailedRace35907 -> "3590-7"
    DetailedRace16923 -> "1692-3"
    DetailedRace12484 -> "1248-4"
    DetailedRace11205 -> "1120-5"
    DetailedRace35949 -> "3594-9"
    DetailedRace16949 -> "1694-9"
    DetailedRace16964 -> "1696-4"
    DetailedRace16980 -> "1698-0"
    DetailedRace17004 -> "1700-4"
    DetailedRace17020 -> "1702-0"
    DetailedRace11213 -> "1121-3"
    DetailedRace36012 -> "3601-2"
    DetailedRace12955 -> "1295-5"
    DetailedRace17095 -> "1709-5"
    DetailedRace10652 -> "1065-2"
    DetailedRace16402 -> "1640-2"
    DetailedRace16410 -> "1641-0"
    DetailedRace17111 -> "1711-1"
    DetailedRace17152 -> "1715-2"
    DetailedRace17319 -> "1731-9"
    DetailedRace14373 -> "1437-3"
    DetailedRace36111 -> "3611-1"
    DetailedRace17178 -> "1717-8"
    DetailedRace16006 -> "1600-6"
    DetailedRace15149 -> "1514-9"
    DetailedRace17228 -> "1722-8"
    DetailedRace10660 -> "1066-0"
    DetailedRace17327 -> "1732-7"
    DetailedRace15164 -> "1516-4"
    DetailedRace17350 -> "1735-0"
    DetailedRace17376 -> "1737-6"
    DetailedRace17392 -> "1739-2"
    DetailedRace17400 -> "1740-0"
    DetailedRace17442 -> "1744-2"
    DetailedRace17418 -> "1741-8"
    DetailedRace17426 -> "1742-6"
    DetailedRace17434 -> "1743-4"
    DetailedRace17459 -> "1745-9"
    DetailedRace36285 -> "3628-5"
    DetailedRace17475 -> "1747-5"
    DetailedRace17483 -> "1748-3"
    DetailedRace17509 -> "1750-9"
    DetailedRace17525 -> "1752-5"
    DetailedRace17517 -> "1751-7"
    DetailedRace17541 -> "1754-1"
    DetailedRace17558 -> "1755-8"
    DetailedRace17574 -> "1757-4"
    DetailedRace17590 -> "1759-0"
    DetailedRace17616 -> "1761-6"
    DetailedRace17624 -> "1762-4"
    DetailedRace17657 -> "1765-7"
    DetailedRace17673 -> "1767-3"
    DetailedRace17681 -> "1768-1"
    DetailedRace17699 -> "1769-9"
    DetailedRace17707 -> "1770-7"
    DetailedRace17715 -> "1771-5"
    DetailedRace17756 -> "1775-6"
    DetailedRace17764 -> "1776-4"
    DetailedRace17772 -> "1777-2"
    DetailedRace17780 -> "1778-0"
    DetailedRace17806 -> "1780-6"
    DetailedRace17798 -> "1779-8"
    DetailedRace17814 -> "1781-4"
    DetailedRace17491 -> "1749-1"
    DetailedRace17533 -> "1753-3"
    DetailedRace17608 -> "1760-8"
    DetailedRace17632 -> "1763-2"
    DetailedRace17640 -> "1764-0"
    DetailedRace17749 -> "1774-9"
    DetailedRace17822 -> "1782-2"
    DetailedRace17913 -> "1791-3"
    DetailedRace17962 -> "1796-2"
    DetailedRace17996 -> "1799-6"
    DetailedRace18010 -> "1801-0"
    DetailedRace18036 -> "1803-6"
    DetailedRace18051 -> "1805-1"
    DetailedRace18077 -> "1807-7"
    DetailedRace17830 -> "1783-0"
    DetailedRace17848 -> "1784-8"
    DetailedRace17855 -> "1785-5"
    DetailedRace17863 -> "1786-3"
    DetailedRace17871 -> "1787-1"
    DetailedRace17889 -> "1788-9"
    DetailedRace17665 -> "1766-5"
    DetailedRace17897 -> "1789-7"
    DetailedRace17905 -> "1790-5"
    DetailedRace17939 -> "1793-9"
    DetailedRace17954 -> "1795-4"
    DetailedRace17947 -> "1794-7"
    DetailedRace17988 -> "1798-8"
    DetailedRace18028 -> "1802-8"
    DetailedRace18044 -> "1804-4"
    DetailedRace18069 -> "1806-9"
    DetailedRace17582 -> "1758-2"
    DetailedRace17723 -> "1772-3"
    DetailedRace17731 -> "1773-1"
    DetailedRace17921 -> "1792-1"
    DetailedRace17970 -> "1797-0"
    DetailedRace18085 -> "1808-5"
    DetailedRace18093 -> "1809-3"
    DetailedRace18259 -> "1825-9"
    DetailedRace19661 -> "1966-1"
    DetailedRace19943 -> "1994-3"
    DetailedRace20081 -> "2008-1"
    DetailedRace41871 -> "4187-1"
    DetailedRace19729 -> "1972-9"
    DetailedRace19737 -> "1973-7"
    DetailedRace19745 -> "1974-5"
    DetailedRace19844 -> "1984-4"
    DetailedRace19869 -> "1986-9"
    DetailedRace19752 -> "1975-2"
    DetailedRace18408 -> "1840-8"
    DetailedRace19760 -> "1976-0"
    DetailedRace19778 -> "1977-8"
    DetailedRace37044 -> "3704-4"
    DetailedRace20149 -> "2014-9"
    DetailedRace19786 -> "1978-6"
    DetailedRace19968 -> "1996-8"
    DetailedRace19794 -> "1979-4"
    DetailedRace19927 -> "1992-7"
    DetailedRace37101 -> "3710-1"
    DetailedRace37119 -> "3711-9"
    DetailedRace19935 -> "1993-5"
    DetailedRace20073 -> "2007-3"
    DetailedRace20115 -> "2011-5"
    DetailedRace20123 -> "2012-3"
    DetailedRace19851 -> "1985-1"
    DetailedRace20131 -> "2013-1"
    DetailedRace19901 -> "1990-1"
    DetailedRace20156 -> "2015-6"
    DetailedRace37200 -> "3720-0"
    DetailedRace19950 -> "1995-0"
    DetailedRace19976 -> "1997-6"
    DetailedRace19877 -> "1987-7"
    DetailedRace20164 -> "2016-4"
    DetailedRace20172 -> "2017-2"
    DetailedRace19992 -> "1999-2"
    DetailedRace19802 -> "1980-2"
    DetailedRace19810 -> "1981-0"
    DetailedRace19885 -> "1988-5"
    DetailedRace19828 -> "1982-8"
    DetailedRace20008 -> "2000-8"
    DetailedRace19695 -> "1969-5"
    DetailedRace20263 -> "2026-3"
    DetailedRace20180 -> "2018-0"
    DetailedRace37358 -> "3735-8"
    DetailedRace20206 -> "2020-6"
    DetailedRace20214 -> "2021-4"
    DetailedRace20222 -> "2022-2"
    DetailedRace20248 -> "2024-8"
    DetailedRace20024 -> "2002-4"
    DetailedRace37416 -> "3741-6"
    DetailedRace19703 -> "1970-3"
    DetailedRace37432 -> "3743-2"
    DetailedRace19984 -> "1998-4"
    DetailedRace37457 -> "3745-7"
    DetailedRace37465 -> "3746-5"
    DetailedRace18499 -> "1849-9"
    DetailedRace18507 -> "1850-7"
    DetailedRace18523 -> "1852-3"
    DetailedRace19091 -> "1909-1"
    DetailedRace37515 -> "3751-5"
    DetailedRace18424 -> "1842-4"
    DetailedRace37531 -> "3753-1"
    DetailedRace18481 -> "1848-1"
    DetailedRace18622 -> "1862-2"
    DetailedRace18630 -> "1863-0"
    DetailedRace37572 -> "3757-2"
    DetailedRace18713 -> "1871-3"
    DetailedRace18457 -> "1845-7"
    DetailedRace18515 -> "1851-5"
    DetailedRace18531 -> "1853-1"
    DetailedRace18549 -> "1854-9"
    DetailedRace18564 -> "1856-4"
    DetailedRace18572 -> "1857-2"
    DetailedRace18606 -> "1860-6"
    DetailedRace18580 -> "1858-0"
    DetailedRace18648 -> "1864-8"
    DetailedRace18655 -> "1865-5"
    DetailedRace18663 -> "1866-3"
    DetailedRace18671 -> "1867-1"
    DetailedRace18689 -> "1868-9"
    DetailedRace18895 -> "1889-5"
    DetailedRace19331 -> "1933-1"
    DetailedRace18721 -> "1872-1"
    DetailedRace18754 -> "1875-4"
    DetailedRace18762 -> "1876-2"
    DetailedRace18770 -> "1877-0"
    DetailedRace18788 -> "1878-8"
    DetailedRace18796 -> "1879-6"
    DetailedRace18804 -> "1880-4"
    DetailedRace18812 -> "1881-2"
    DetailedRace18838 -> "1883-8"
    DetailedRace18846 -> "1884-6"
    DetailedRace18861 -> "1886-1"
    DetailedRace37853 -> "3785-3"
    DetailedRace18739 -> "1873-9"
    DetailedRace18747 -> "1874-7"
    DetailedRace37887 -> "3788-7"
    DetailedRace18820 -> "1882-0"
    DetailedRace18853 -> "1885-3"
    DetailedRace18333 -> "1833-3"
    DetailedRace38612 -> "3861-2"
    DetailedRace18168 -> "1816-8"
    DetailedRace18176 -> "1817-6"
    DetailedRace18184 -> "1818-4"
    DetailedRace18192 -> "1819-2"
    DetailedRace18200 -> "1820-0"
    DetailedRace18218 -> "1821-8"
    DetailedRace18226 -> "1822-6"
    DetailedRace18267 -> "1826-7"
    DetailedRace18275 -> "1827-5"
    DetailedRace18234 -> "1823-4"
    DetailedRace18242 -> "1824-2"
    DetailedRace18309 -> "1830-9"
    DetailedRace18283 -> "1828-3"
    DetailedRace18291 -> "1829-1"
    DetailedRace18119 -> "1811-9"
    DetailedRace18317 -> "1831-7"
    DetailedRace38091 -> "3809-1"
    DetailedRace18325 -> "1832-5"
    DetailedRace18143 -> "1814-3"
    DetailedRace18341 -> "1834-1"
    DetailedRace18358 -> "1835-8"
    DetailedRace18374 -> "1837-4"
    DetailedRace18382 -> "1838-2"
    DetailedRace18960 -> "1896-0"
    DetailedRace18978 -> "1897-8"
    DetailedRace18986 -> "1898-6"
    DetailedRace19638 -> "1963-8"
    DetailedRace19349 -> "1934-9"
    DetailedRace19067 -> "1906-7"
    DetailedRace19075 -> "1907-5"
    DetailedRace38232 -> "3823-2"
    DetailedRace19133 -> "1913-3"
    DetailedRace19166 -> "1916-6"
    DetailedRace38265 -> "3826-5"
    DetailedRace19208 -> "1920-8"
    DetailedRace19299 -> "1929-9"
    DetailedRace19315 -> "1931-5"
    DetailedRace19356 -> "1935-6"
    DetailedRace19000 -> "1900-0"
    DetailedRace19109 -> "1910-9"
    DetailedRace19141 -> "1914-1"
    DetailedRace19158 -> "1915-8"
    DetailedRace18929 -> "1892-9"
    DetailedRace19620 -> "1962-0"
    DetailedRace19182 -> "1918-2"
    DetailedRace38380 -> "3838-0"
    DetailedRace19190 -> "1919-0"
    DetailedRace19224 -> "1922-4"
    DetailedRace19232 -> "1923-2"
    DetailedRace19257 -> "1925-7"
    DetailedRace19281 -> "1928-1"
    DetailedRace19497 -> "1949-7"
    DetailedRace19323 -> "1932-3"
    DetailedRace19364 -> "1936-4"
    DetailedRace19372 -> "1937-2"
    DetailedRace19380 -> "1938-0"
    DetailedRace19422 -> "1942-2"
    DetailedRace19539 -> "1953-9"
    DetailedRace19430 -> "1943-0"
    DetailedRace19463 -> "1946-3"
    DetailedRace19513 -> "1951-3"
    DetailedRace18937 -> "1893-7"
    DetailedRace19521 -> "1952-1"
    DetailedRace19596 -> "1959-6"
    DetailedRace19604 -> "1960-4"
    DetailedRace19240 -> "1924-0"
    DetailedRace19406 -> "1940-6"
    DetailedRace19398 -> "1939-8"
    DetailedRace19414 -> "1941-4"
    DetailedRace19570 -> "1957-0"
    DetailedRace19273 -> "1927-3"
    DetailedRace19042 -> "1904-2"
    DetailedRace19448 -> "1944-8"
    DetailedRace19455 -> "1945-5"
    DetailedRace19471 -> "1947-1"
    DetailedRace19489 -> "1948-9"
    DetailedRace18945 -> "1894-5"
    DetailedRace19554 -> "1955-4"
    DetailedRace19562 -> "1956-2"
    DetailedRace19588 -> "1958-8"
    DetailedRace19612 -> "1961-2"
    DetailedRace19646 -> "1964-6"
    DetailedRace18994 -> "1899-4"
    DetailedRace19026 -> "1902-6"
    DetailedRace19034 -> "1903-4"
    DetailedRace19059 -> "1905-9"
    DetailedRace19083 -> "1908-3"
    DetailedRace19117 -> "1911-7"
    DetailedRace19125 -> "1912-5"
    DetailedRace19216 -> "1921-6"
    DetailedRace19265 -> "1926-5"
    DetailedRace19307 -> "1930-7"
    DetailedRace38851 -> "3885-1"
    DetailedRace19505 -> "1950-5"
    DetailedRace19547 -> "1954-7"
    DetailedRace19018 -> "1901-8"
    DetailedRace38893 -> "3889-3"
    DetailedRace10694 -> "1069-4"
    DetailedRace38919 -> "3891-9"
    DetailedRace38927 -> "3892-7"
    DetailedRace38935 -> "3893-5"
    DetailedRace38943 -> "3894-3"
    DetailedRace38950 -> "3895-0"
    DetailedRace38968 -> "3896-8"
    DetailedRace38976 -> "3897-6"
    DetailedRace38984 -> "3898-4"
    DetailedRace38992 -> "3899-2"
    DetailedRace39008 -> "3900-8"
    DetailedRace39016 -> "3901-6"
    DetailedRace39024 -> "3902-4"
    DetailedRace39032 -> "3903-2"
    DetailedRace39040 -> "3904-0"
    DetailedRace39057 -> "3905-7"
    DetailedRace39065 -> "3906-5"
    DetailedRace39073 -> "3907-3"
    DetailedRace39081 -> "3908-1"
    DetailedRace39099 -> "3909-9"
    DetailedRace39107 -> "3910-7"
    DetailedRace39115 -> "3911-5"
    DetailedRace39123 -> "3912-3"
    DetailedRace39131 -> "3913-1"
    DetailedRace39149 -> "3914-9"
    DetailedRace39156 -> "3915-6"
    DetailedRace39164 -> "3916-4"
    DetailedRace39172 -> "3917-2"
    DetailedRace39180 -> "3918-0"
    DetailedRace39198 -> "3919-8"
    DetailedRace39206 -> "3920-6"
    DetailedRace39214 -> "3921-4"
    DetailedRace39222 -> "3922-2"
    DetailedRace39230 -> "3923-0"
    DetailedRace39248 -> "3924-8"
    DetailedRace39255 -> "3925-5"
    DetailedRace39263 -> "3926-3"
    DetailedRace39271 -> "3927-1"
    DetailedRace39289 -> "3928-9"
    DetailedRace39297 -> "3929-7"
    DetailedRace39305 -> "3930-5"
    DetailedRace39313 -> "3931-3"
    DetailedRace39321 -> "3932-1"
    DetailedRace39339 -> "3933-9"
    DetailedRace39347 -> "3934-7"
    DetailedRace39354 -> "3935-4"
    DetailedRace39362 -> "3936-2"
    DetailedRace39370 -> "3937-0"
    DetailedRace39388 -> "3938-8"
    DetailedRace39396 -> "3939-6"
    DetailedRace39404 -> "3940-4"
    DetailedRace39412 -> "3941-2"
    DetailedRace39420 -> "3942-0"
    DetailedRace39438 -> "3943-8"
    DetailedRace39446 -> "3944-6"
    DetailedRace39453 -> "3945-3"
    DetailedRace39461 -> "3946-1"
    DetailedRace39479 -> "3947-9"
    DetailedRace39487 -> "3948-7"
    DetailedRace39495 -> "3949-5"
    DetailedRace10710 -> "1071-0"
    DetailedRace39511 -> "3951-1"
    DetailedRace39529 -> "3952-9"
    DetailedRace39537 -> "3953-7"
    DetailedRace39545 -> "3954-5"
    DetailedRace39552 -> "3955-2"
    DetailedRace39560 -> "3956-0"
    DetailedRace39578 -> "3957-8"
    DetailedRace39586 -> "3958-6"
    DetailedRace39594 -> "3959-4"
    DetailedRace39602 -> "3960-2"
    DetailedRace39610 -> "3961-0"
    DetailedRace39628 -> "3962-8"
    DetailedRace39636 -> "3963-6"
    DetailedRace39644 -> "3964-4"
    DetailedRace39651 -> "3965-1"
    DetailedRace39669 -> "3966-9"
    DetailedRace39677 -> "3967-7"
    DetailedRace39685 -> "3968-5"
    DetailedRace39693 -> "3969-3"
    DetailedRace39701 -> "3970-1"
    DetailedRace39719 -> "3971-9"
    DetailedRace39727 -> "3972-7"
    DetailedRace39735 -> "3973-5"
    DetailedRace39743 -> "3974-3"
    DetailedRace39750 -> "3975-0"
    DetailedRace39768 -> "3976-8"
    DetailedRace39776 -> "3977-6"
    DetailedRace39784 -> "3978-4"
    DetailedRace39792 -> "3979-2"
    DetailedRace39800 -> "3980-0"
    DetailedRace39818 -> "3981-8"
    DetailedRace39826 -> "3982-6"
    DetailedRace39834 -> "3983-4"
    DetailedRace39842 -> "3984-2"
    DetailedRace39859 -> "3985-9"
    DetailedRace39867 -> "3986-7"
    DetailedRace39875 -> "3987-5"
    DetailedRace39883 -> "3988-3"
    DetailedRace39891 -> "3989-1"
    DetailedRace39909 -> "3990-9"
    DetailedRace39917 -> "3991-7"
    DetailedRace39925 -> "3992-5"
    DetailedRace39933 -> "3993-3"
    DetailedRace39941 -> "3994-1"
    DetailedRace39958 -> "3995-8"
    DetailedRace39966 -> "3996-6"
    DetailedRace39974 -> "3997-4"
    DetailedRace39982 -> "3998-2"
    DetailedRace39990 -> "3999-0"
    DetailedRace40006 -> "4000-6"
    DetailedRace40014 -> "4001-4"
    DetailedRace40022 -> "4002-2"
    DetailedRace40030 -> "4003-0"
    DetailedRace40048 -> "4004-8"
    DetailedRace40055 -> "4005-5"
    DetailedRace40063 -> "4006-3"
    DetailedRace40071 -> "4007-1"
    DetailedRace40089 -> "4008-9"
    DetailedRace40097 -> "4009-7"
    DetailedRace40105 -> "4010-5"
    DetailedRace40113 -> "4011-3"
    DetailedRace40121 -> "4012-1"
    DetailedRace40139 -> "4013-9"
    DetailedRace40147 -> "4014-7"
    DetailedRace40154 -> "4015-4"
    DetailedRace40162 -> "4016-2"
    DetailedRace40170 -> "4017-0"
    DetailedRace40188 -> "4018-8"
    DetailedRace40196 -> "4019-6"
    DetailedRace40204 -> "4020-4"
    DetailedRace40212 -> "4021-2"
    DetailedRace40220 -> "4022-0"
    DetailedRace40238 -> "4023-8"
    DetailedRace40246 -> "4024-6"
    DetailedRace40253 -> "4025-3"
    DetailedRace40261 -> "4026-1"
    DetailedRace40279 -> "4027-9"
    DetailedRace40287 -> "4028-7"
    DetailedRace40295 -> "4029-5"
    DetailedRace40303 -> "4030-3"
    DetailedRace40311 -> "4031-1"
    DetailedRace40329 -> "4032-9"
    DetailedRace40337 -> "4033-7"
    DetailedRace40345 -> "4034-5"
    DetailedRace40352 -> "4035-2"
    DetailedRace40360 -> "4036-0"
    DetailedRace40378 -> "4037-8"
    DetailedRace40386 -> "4038-6"
    DetailedRace40394 -> "4039-4"
    DetailedRace40402 -> "4040-2"
    DetailedRace40410 -> "4041-0"
    DetailedRace40428 -> "4042-8"
    DetailedRace40436 -> "4043-6"
    DetailedRace40444 -> "4044-4"
    DetailedRace40451 -> "4045-1"
    DetailedRace40469 -> "4046-9"
    DetailedRace40477 -> "4047-7"
    DetailedRace40485 -> "4048-5"
    DetailedRace40493 -> "4049-3"
    DetailedRace40501 -> "4050-1"
    DetailedRace40519 -> "4051-9"
    DetailedRace40527 -> "4052-7"
    DetailedRace40535 -> "4053-5"
    DetailedRace40543 -> "4054-3"
    DetailedRace40550 -> "4055-0"
    DetailedRace40568 -> "4056-8"
    DetailedRace40576 -> "4057-6"
    DetailedRace40584 -> "4058-4"
    DetailedRace40592 -> "4059-2"
    DetailedRace40600 -> "4060-0"
    DetailedRace40618 -> "4061-8"
    DetailedRace40626 -> "4062-6"
    DetailedRace40634 -> "4063-4"
    DetailedRace40642 -> "4064-2"
    DetailedRace40659 -> "4065-9"
    DetailedRace40667 -> "4066-7"
    DetailedRace40675 -> "4067-5"
    DetailedRace40683 -> "4068-3"
    DetailedRace40691 -> "4069-1"
    DetailedRace40709 -> "4070-9"
    DetailedRace40717 -> "4071-7"
    DetailedRace40725 -> "4072-5"
    DetailedRace40733 -> "4073-3"
    DetailedRace40741 -> "4074-1"
    DetailedRace40758 -> "4075-8"
    DetailedRace40766 -> "4076-6"
    DetailedRace40774 -> "4077-4"
    DetailedRace40782 -> "4078-2"
    DetailedRace40790 -> "4079-0"
    DetailedRace40808 -> "4080-8"
    DetailedRace40816 -> "4081-6"
    DetailedRace40824 -> "4082-4"
    DetailedRace40832 -> "4083-2"
    DetailedRace40840 -> "4084-0"
    DetailedRace40857 -> "4085-7"
    DetailedRace10702 -> "1070-2"
    DetailedRace40873 -> "4087-3"
    DetailedRace40881 -> "4088-1"
    DetailedRace40899 -> "4089-9"
    DetailedRace40907 -> "4090-7"
    DetailedRace40915 -> "4091-5"
    DetailedRace40923 -> "4092-3"
    DetailedRace40931 -> "4093-1"
    DetailedRace40949 -> "4094-9"
    DetailedRace40956 -> "4095-6"
    DetailedRace40964 -> "4096-4"
    DetailedRace40972 -> "4097-2"
    DetailedRace40980 -> "4098-0"
    DetailedRace40998 -> "4099-8"
    DetailedRace41004 -> "4100-4"
    DetailedRace41012 -> "4101-2"
    DetailedRace41020 -> "4102-0"
    DetailedRace41038 -> "4103-8"
    DetailedRace41046 -> "4104-6"
    DetailedRace41053 -> "4105-3"
    DetailedRace41061 -> "4106-1"
    DetailedRace41079 -> "4107-9"
    DetailedRace41087 -> "4108-7"
    DetailedRace41095 -> "4109-5"
    DetailedRace41103 -> "4110-3"
    DetailedRace41111 -> "4111-1"
    DetailedRace41129 -> "4112-9"
    DetailedRace41137 -> "4113-7"
    DetailedRace41145 -> "4114-5"
    DetailedRace41152 -> "4115-2"
    DetailedRace41160 -> "4116-0"
    DetailedRace41178 -> "4117-8"
    DetailedRace41186 -> "4118-6"
    DetailedRace41194 -> "4119-4"
    DetailedRace41202 -> "4120-2"
    DetailedRace41210 -> "4121-0"
    DetailedRace41228 -> "4122-8"
    DetailedRace41236 -> "4123-6"
    DetailedRace41244 -> "4124-4"
    DetailedRace41251 -> "4125-1"
    DetailedRace41269 -> "4126-9"
    DetailedRace41277 -> "4127-7"
    DetailedRace41285 -> "4128-5"
    DetailedRace41293 -> "4129-3"
    DetailedRace41301 -> "4130-1"
    DetailedRace41319 -> "4131-9"
    DetailedRace41327 -> "4132-7"
    DetailedRace41335 -> "4133-5"
    DetailedRace41343 -> "4134-3"
    DetailedRace41350 -> "4135-0"
    DetailedRace41368 -> "4136-8"
    DetailedRace41376 -> "4137-6"
    DetailedRace41384 -> "4138-4"
    DetailedRace41392 -> "4139-2"
    DetailedRace41400 -> "4140-0"
    DetailedRace41418 -> "4141-8"
    DetailedRace41426 -> "4142-6"
    DetailedRace41434 -> "4143-4"
    DetailedRace41442 -> "4144-2"
    DetailedRace41459 -> "4145-9"
    DetailedRace41467 -> "4146-7"
    DetailedRace10728 -> "1072-8"
    DetailedRace41483 -> "4148-3"
    DetailedRace10736 -> "1073-6"
    DetailedRace41509 -> "4150-9"
    DetailedRace41517 -> "4151-7"
    DetailedRace41525 -> "4152-5"
    DetailedRace41533 -> "4153-3"
    DetailedRace41541 -> "4154-1"
    DetailedRace41558 -> "4155-8"
    DetailedRace41566 -> "4156-6"
    DetailedRace41574 -> "4157-4"
    DetailedRace41582 -> "4158-2"
    DetailedRace41590 -> "4159-0"
    DetailedRace41608 -> "4160-8"
    DetailedRace41616 -> "4161-6"
    DetailedRace41624 -> "4162-4"
    DetailedRace41632 -> "4163-2"
    DetailedRace41640 -> "4164-0"
    DetailedRace41657 -> "4165-7"
    DetailedRace41665 -> "4166-5"
    DetailedRace41673 -> "4167-3"
    DetailedRace41681 -> "4168-1"
    DetailedRace41699 -> "4169-9"
    DetailedRace41707 -> "4170-7"
    DetailedRace41715 -> "4171-5"
    DetailedRace41723 -> "4172-3"
    DetailedRace41731 -> "4173-1"
    DetailedRace41749 -> "4174-9"
    DetailedRace41756 -> "4175-6"
    DetailedRace41764 -> "4176-4"
    DetailedRace41772 -> "4177-2"
    DetailedRace41780 -> "4178-0"
    DetailedRace41798 -> "4179-8"
    DetailedRace41806 -> "4180-6"
    DetailedRace41814 -> "4181-4"
    DetailedRace10744 -> "1074-4"
    DetailedRace41830 -> "4183-0"
    DetailedRace41848 -> "4184-8"
    DetailedRace41855 -> "4185-5"
    DetailedRace20297 -> "2029-7"
    DetailedRace20305 -> "2030-5"
    DetailedRace20313 -> "2031-3"
    DetailedRace20321 -> "2032-1"
    DetailedRace20339 -> "2033-9"
    DetailedRace20347 -> "2034-7"
    DetailedRace20354 -> "2035-4"
    DetailedRace20362 -> "2036-2"
    DetailedRace20370 -> "2037-0"
    DetailedRace20388 -> "2038-8"
    DetailedRace20396 -> "2039-6"
    DetailedRace20404 -> "2040-4"
    DetailedRace20412 -> "2041-2"
    DetailedRace20420 -> "2042-0"
    DetailedRace20438 -> "2043-8"
    DetailedRace20446 -> "2044-6"
    DetailedRace20453 -> "2045-3"
    DetailedRace20461 -> "2046-1"
    DetailedRace20479 -> "2047-9"
    DetailedRace20487 -> "2048-7"
    DetailedRace20495 -> "2049-5"
    DetailedRace20503 -> "2050-3"
    DetailedRace20511 -> "2051-1"
    DetailedRace20529 -> "2052-9"
    DetailedRace20560 -> "2056-0"
    DetailedRace20586 -> "2058-6"
    DetailedRace20602 -> "2060-2"
    DetailedRace20610 -> "2061-0"
    DetailedRace20628 -> "2062-8"
    DetailedRace20636 -> "2063-6"
    DetailedRace20644 -> "2064-4"
    DetailedRace20651 -> "2065-1"
    DetailedRace20669 -> "2066-9"
    DetailedRace41863 -> "4186-3"
    DetailedRace20677 -> "2067-7"
    DetailedRace20685 -> "2068-5"
    DetailedRace20693 -> "2069-3"
    DetailedRace20701 -> "2070-1"
    DetailedRace20719 -> "2071-9"
    DetailedRace20727 -> "2072-7"
    DetailedRace20735 -> "2073-5"
    DetailedRace20743 -> "2074-3"
    DetailedRace20750 -> "2075-0"
    DetailedRace20784 -> "2078-4"
    DetailedRace20792 -> "2079-2"
    DetailedRace20800 -> "2080-0"
    DetailedRace20818 -> "2081-8"
    DetailedRace20826 -> "2082-6"
    DetailedRace20834 -> "2083-4"
    DetailedRace20859 -> "2085-9"
    DetailedRace20867 -> "2086-7"
    DetailedRace20875 -> "2087-5"
    DetailedRace20883 -> "2088-3"
    DetailedRace20891 -> "2089-1"
    DetailedRace20909 -> "2090-9"
    DetailedRace20917 -> "2091-7"
    DetailedRace20925 -> "2092-5"
    DetailedRace20933 -> "2093-3"
    DetailedRace20941 -> "2094-1"
    DetailedRace20958 -> "2095-8"
    DetailedRace20966 -> "2096-6"
    DetailedRace20974 -> "2097-4"
    DetailedRace20982 -> "2098-2"
    DetailedRace21006 -> "2100-6"
    DetailedRace21014 -> "2101-4"
    DetailedRace21022 -> "2102-2"
    DetailedRace21030 -> "2103-0"
    DetailedRace21048 -> "2104-8"
    DetailedRace25007 -> "2500-7"
    DetailedRace21089 -> "2108-9"
    DetailedRace21097 -> "2109-7"
    DetailedRace21105 -> "2110-5"
    DetailedRace21113 -> "2111-3"
    DetailedRace21121 -> "2112-1"
    DetailedRace21139 -> "2113-9"
    DetailedRace21147 -> "2114-7"
    DetailedRace21154 -> "2115-4"
    DetailedRace21162 -> "2116-2"
    DetailedRace21188 -> "2118-8"
    DetailedRace21196 -> "2119-6"
    DetailedRace21204 -> "2120-4"
    DetailedRace21212 -> "2121-2"
    DetailedRace21220 -> "2122-0"
    DetailedRace21238 -> "2123-8"
    DetailedRace21246 -> "2124-6"
    DetailedRace21253 -> "2125-3"
    DetailedRace21261 -> "2126-1"
    DetailedRace21279 -> "2127-9"
    DetailedRace21295 -> "2129-5"
    DetailedRace21311 -> "2131-1"
    DetailedRaceAsku -> "ASKU"
    DetailedRaceOth -> "OTH"
    DetailedRaceUnk -> "UNK"
  }
}

pub fn detailed_race_parse_code(code: String) -> Result(DetailedRace, Nil) {
  case code {
    "1004-1" -> Ok(DetailedRace10041)
    "1006-6" -> Ok(DetailedRace10066)
    "1579-2" -> Ok(DetailedRace15792)
    "1212-0" -> Ok(DetailedRace12120)
    "1045-4" -> Ok(DetailedRace10454)
    "1654-3" -> Ok(DetailedRace16543)
    "1194-0" -> Ok(DetailedRace11940)
    "1195-7" -> Ok(DetailedRace11957)
    "1187-4" -> Ok(DetailedRace11874)
    "1008-2" -> Ok(DetailedRace10082)
    "3012-2" -> Ok(DetailedRace30122)
    "1688-1" -> Ok(DetailedRace16881)
    "1392-0" -> Ok(DetailedRace13920)
    "3015-5" -> Ok(DetailedRace30155)
    "3016-3" -> Ok(DetailedRace30163)
    "1010-8" -> Ok(DetailedRace10108)
    "1016-5" -> Ok(DetailedRace10165)
    "1021-5" -> Ok(DetailedRace10215)
    "1024-9" -> Ok(DetailedRace10249)
    "1026-4" -> Ok(DetailedRace10264)
    "1366-4" -> Ok(DetailedRace13664)
    "1028-0" -> Ok(DetailedRace10280)
    "3024-7" -> Ok(DetailedRace30247)
    "3025-4" -> Ok(DetailedRace30254)
    "1234-4" -> Ok(DetailedRace12344)
    "1265-8" -> Ok(DetailedRace12658)
    "1046-2" -> Ok(DetailedRace10462)
    "1124-7" -> Ok(DetailedRace11247)
    "1033-0" -> Ok(DetailedRace10330)
    "3031-2" -> Ok(DetailedRace30312)
    "1125-4" -> Ok(DetailedRace11254)
    "1060-3" -> Ok(DetailedRace10603)
    "3034-6" -> Ok(DetailedRace30346)
    "3035-3" -> Ok(DetailedRace30353)
    "3036-1" -> Ok(DetailedRace30361)
    "1430-8" -> Ok(DetailedRace14308)
    "3038-7" -> Ok(DetailedRace30387)
    "3039-5" -> Ok(DetailedRace30395)
    "1235-1" -> Ok(DetailedRace12351)
    "3041-1" -> Ok(DetailedRace30411)
    "1417-5" -> Ok(DetailedRace14175)
    "1035-5" -> Ok(DetailedRace10355)
    "3044-5" -> Ok(DetailedRace30445)
    "1126-2" -> Ok(DetailedRace11262)
    "1418-3" -> Ok(DetailedRace14183)
    "1037-1" -> Ok(DetailedRace10371)
    "1611-3" -> Ok(DetailedRace16113)
    "3049-4" -> Ok(DetailedRace30494)
    "1419-1" -> Ok(DetailedRace14191)
    "3051-0" -> Ok(DetailedRace30510)
    "1047-0" -> Ok(DetailedRace10470)
    "3053-6" -> Ok(DetailedRace30536)
    "1041-3" -> Ok(DetailedRace10413)
    "3055-1" -> Ok(DetailedRace30551)
    "1042-1" -> Ok(DetailedRace10421)
    "1054-6" -> Ok(DetailedRace10546)
    "1044-7" -> Ok(DetailedRace10447)
    "3059-3" -> Ok(DetailedRace30593)
    "3060-1" -> Ok(DetailedRace30601)
    "1223-7" -> Ok(DetailedRace12237)
    "1224-5" -> Ok(DetailedRace12245)
    "1076-9" -> Ok(DetailedRace10769)
    "1286-4" -> Ok(DetailedRace12864)
    "1078-5" -> Ok(DetailedRace10785)
    "1420-9" -> Ok(DetailedRace14209)
    "1393-8" -> Ok(DetailedRace13938)
    "1465-4" -> Ok(DetailedRace14654)
    "3069-2" -> Ok(DetailedRace30692)
    "3070-0" -> Ok(DetailedRace30700)
    "3071-8" -> Ok(DetailedRace30718)
    "1082-7" -> Ok(DetailedRace10827)
    "1086-8" -> Ok(DetailedRace10868)
    "3074-2" -> Ok(DetailedRace30742)
    "3075-9" -> Ok(DetailedRace30759)
    "3076-7" -> Ok(DetailedRace30767)
    "1088-4" -> Ok(DetailedRace10884)
    "1089-2" -> Ok(DetailedRace10892)
    "3079-1" -> Ok(DetailedRace30791)
    "3080-9" -> Ok(DetailedRace30809)
    "3081-7" -> Ok(DetailedRace30817)
    "1090-0" -> Ok(DetailedRace10900)
    "1102-3" -> Ok(DetailedRace11023)
    "1106-4" -> Ok(DetailedRace11064)
    "3085-8" -> Ok(DetailedRace30858)
    "3086-6" -> Ok(DetailedRace30866)
    "1109-8" -> Ok(DetailedRace11098)
    "3088-2" -> Ok(DetailedRace30882)
    "1055-3" -> Ok(DetailedRace10553)
    "1114-8" -> Ok(DetailedRace11148)
    "1123-9" -> Ok(DetailedRace11239)
    "3092-4" -> Ok(DetailedRace30924)
    "1153-6" -> Ok(DetailedRace11536)
    "1155-1" -> Ok(DetailedRace11551)
    "3095-7" -> Ok(DetailedRace30957)
    "1162-7" -> Ok(DetailedRace11627)
    "1479-5" -> Ok(DetailedRace14795)
    "1115-5" -> Ok(DetailedRace11155)
    "1165-0" -> Ok(DetailedRace11650)
    "1156-9" -> Ok(DetailedRace11569)
    "3101-3" -> Ok(DetailedRace31013)
    "1725-1" -> Ok(DetailedRace17251)
    "1167-6" -> Ok(DetailedRace11676)
    "1169-2" -> Ok(DetailedRace11692)
    "3105-4" -> Ok(DetailedRace31054)
    "1171-8" -> Ok(DetailedRace11718)
    "1394-6" -> Ok(DetailedRace13946)
    "1116-3" -> Ok(DetailedRace11163)
    "3109-6" -> Ok(DetailedRace31096)
    "1560-2" -> Ok(DetailedRace15602)
    "1707-9" -> Ok(DetailedRace17079)
    "1607-1" -> Ok(DetailedRace16071)
    "1080-1" -> Ok(DetailedRace10801)
    "1173-4" -> Ok(DetailedRace11734)
    "1178-3" -> Ok(DetailedRace11783)
    "1591-7" -> Ok(DetailedRace15917)
    "1262-5" -> Ok(DetailedRace12625)
    "1665-9" -> Ok(DetailedRace16659)
    "1683-2" -> Ok(DetailedRace16832)
    "1180-9" -> Ok(DetailedRace11809)
    "1182-5" -> Ok(DetailedRace11825)
    "1184-1" -> Ok(DetailedRace11841)
    "1186-6" -> Ok(DetailedRace11866)
    "3124-5" -> Ok(DetailedRace31245)
    "1668-3" -> Ok(DetailedRace16683)
    "1189-0" -> Ok(DetailedRace11890)
    "3127-8" -> Ok(DetailedRace31278)
    "1191-6" -> Ok(DetailedRace11916)
    "1207-0" -> Ok(DetailedRace12070)
    "1613-9" -> Ok(DetailedRace16139)
    "1209-6" -> Ok(DetailedRace12096)
    "3132-8" -> Ok(DetailedRace31328)
    "1211-2" -> Ok(DetailedRace12112)
    "3134-4" -> Ok(DetailedRace31344)
    "3135-1" -> Ok(DetailedRace31351)
    "3136-9" -> Ok(DetailedRace31369)
    "1057-9" -> Ok(DetailedRace10579)
    "1466-2" -> Ok(DetailedRace14662)
    "1588-3" -> Ok(DetailedRace15883)
    "1519-8" -> Ok(DetailedRace15198)
    "3141-9" -> Ok(DetailedRace31419)
    "1092-6" -> Ok(DetailedRace10926)
    "1196-5" -> Ok(DetailedRace11965)
    "1197-3" -> Ok(DetailedRace11973)
    "3145-0" -> Ok(DetailedRace31450)
    "1467-0" -> Ok(DetailedRace14670)
    "1580-0" -> Ok(DetailedRace15800)
    "1599-0" -> Ok(DetailedRace15990)
    "1093-4" -> Ok(DetailedRace10934)
    "1239-3" -> Ok(DetailedRace12393)
    "1472-0" -> Ok(DetailedRace14720)
    "3152-6" -> Ok(DetailedRace31526)
    "3153-4" -> Ok(DetailedRace31534)
    "1590-9" -> Ok(DetailedRace15909)
    "3155-9" -> Ok(DetailedRace31559)
    "1250-0" -> Ok(DetailedRace12500)
    "1225-2" -> Ok(DetailedRace12252)
    "1056-1" -> Ok(DetailedRace10561)
    "3159-1" -> Ok(DetailedRace31591)
    "1615-4" -> Ok(DetailedRace16154)
    "1128-8" -> Ok(DetailedRace11288)
    "3162-5" -> Ok(DetailedRace31625)
    "1252-6" -> Ok(DetailedRace12526)
    "1421-7" -> Ok(DetailedRace14217)
    "1422-5" -> Ok(DetailedRace14225)
    "1605-5" -> Ok(DetailedRace16055)
    "1256-7" -> Ok(DetailedRace12567)
    "1729-3" -> Ok(DetailedRace17293)
    "3169-0" -> Ok(DetailedRace31690)
    "3170-8" -> Ok(DetailedRace31708)
    "1260-9" -> Ok(DetailedRace12609)
    "1236-9" -> Ok(DetailedRace12369)
    "3173-2" -> Ok(DetailedRace31732)
    "3174-0" -> Ok(DetailedRace31740)
    "1242-7" -> Ok(DetailedRace12427)
    "1129-6" -> Ok(DetailedRace11296)
    "3177-3" -> Ok(DetailedRace31773)
    "1130-4" -> Ok(DetailedRace11304)
    "3179-9" -> Ok(DetailedRace31799)
    "3180-7" -> Ok(DetailedRace31807)
    "1264-1" -> Ok(DetailedRace12641)
    "3182-3" -> Ok(DetailedRace31823)
    "3183-1" -> Ok(DetailedRace31831)
    "3184-9" -> Ok(DetailedRace31849)
    "1267-4" -> Ok(DetailedRace12674)
    "1481-1" -> Ok(DetailedRace14811)
    "3187-2" -> Ok(DetailedRace31872)
    "1726-9" -> Ok(DetailedRace17269)
    "3189-8" -> Ok(DetailedRace31898)
    "1269-0" -> Ok(DetailedRace12690)
    "1697-2" -> Ok(DetailedRace16972)
    "1083-5" -> Ok(DetailedRace10835)
    "1275-7" -> Ok(DetailedRace12757)
    "1271-6" -> Ok(DetailedRace12716)
    "3195-5" -> Ok(DetailedRace31955)
    "3196-3" -> Ok(DetailedRace31963)
    "3197-1" -> Ok(DetailedRace31971)
    "1727-7" -> Ok(DetailedRace17277)
    "1230-2" -> Ok(DetailedRace12302)
    "1359-9" -> Ok(DetailedRace13599)
    "1279-9" -> Ok(DetailedRace12799)
    "1442-3" -> Ok(DetailedRace14423)
    "1360-7" -> Ok(DetailedRace13607)
    "3204-5" -> Ok(DetailedRace32045)
    "1281-5" -> Ok(DetailedRace12815)
    "1282-3" -> Ok(DetailedRace12823)
    "1283-1" -> Ok(DetailedRace12831)
    "1285-6" -> Ok(DetailedRace12856)
    "3209-4" -> Ok(DetailedRace32094)
    "1313-6" -> Ok(DetailedRace13136)
    "3211-0" -> Ok(DetailedRace32110)
    "1157-7" -> Ok(DetailedRace11577)
    "1013-2" -> Ok(DetailedRace10132)
    "1297-1" -> Ok(DetailedRace12971)
    "1423-3" -> Ok(DetailedRace14233)
    "1395-3" -> Ok(DetailedRace13953)
    "1299-7" -> Ok(DetailedRace12997)
    "1301-1" -> Ok(DetailedRace13011)
    "1468-8" -> Ok(DetailedRace14688)
    "1117-1" -> Ok(DetailedRace11171)
    "1303-7" -> Ok(DetailedRace13037)
    "3222-7" -> Ok(DetailedRace32227)
    "1510-7" -> Ok(DetailedRace15107)
    "3224-3" -> Ok(DetailedRace32243)
    "1198-1" -> Ok(DetailedRace11981)
    "1305-2" -> Ok(DetailedRace13052)
    "1307-8" -> Ok(DetailedRace13078)
    "3228-4" -> Ok(DetailedRace32284)
    "1306-0" -> Ok(DetailedRace13060)
    "1520-6" -> Ok(DetailedRace15206)
    "1309-4" -> Ok(DetailedRace13094)
    "1310-2" -> Ok(DetailedRace13102)
    "1312-8" -> Ok(DetailedRace13128)
    "3234-2" -> Ok(DetailedRace32342)
    "3235-9" -> Ok(DetailedRace32359)
    "3236-7" -> Ok(DetailedRace32367)
    "3237-5" -> Ok(DetailedRace32375)
    "1319-3" -> Ok(DetailedRace13193)
    "1321-9" -> Ok(DetailedRace13219)
    "1222-9" -> Ok(DetailedRace12229)
    "1332-6" -> Ok(DetailedRace13326)
    "1226-0" -> Ok(DetailedRace12260)
    "1132-0" -> Ok(DetailedRace11320)
    "1133-8" -> Ok(DetailedRace11338)
    "1134-6" -> Ok(DetailedRace11346)
    "1135-3" -> Ok(DetailedRace11353)
    "1424-1" -> Ok(DetailedRace14241)
    "1323-5" -> Ok(DetailedRace13235)
    "1136-1" -> Ok(DetailedRace11361)
    "3250-8" -> Ok(DetailedRace32508)
    "1014-0" -> Ok(DetailedRace10140)
    "3252-4" -> Ok(DetailedRace32524)
    "1137-9" -> Ok(DetailedRace11379)
    "3254-0" -> Ok(DetailedRace32540)
    "1425-8" -> Ok(DetailedRace14258)
    "1048-8" -> Ok(DetailedRace10488)
    "3257-3" -> Ok(DetailedRace32573)
    "1426-6" -> Ok(DetailedRace14266)
    "1618-8" -> Ok(DetailedRace16188)
    "1314-4" -> Ok(DetailedRace13144)
    "1199-9" -> Ok(DetailedRace11999)
    "1619-6" -> Ok(DetailedRace16196)
    "1521-4" -> Ok(DetailedRace15214)
    "1331-8" -> Ok(DetailedRace13318)
    "1340-9" -> Ok(DetailedRace13409)
    "1342-5" -> Ok(DetailedRace13425)
    "3267-2" -> Ok(DetailedRace32672)
    "1200-5" -> Ok(DetailedRace12005)
    "1344-1" -> Ok(DetailedRace13441)
    "1348-2" -> Ok(DetailedRace13482)
    "1427-4" -> Ok(DetailedRace14274)
    "1350-8" -> Ok(DetailedRace13508)
    "3273-0" -> Ok(DetailedRace32730)
    "1352-4" -> Ok(DetailedRace13524)
    "1227-8" -> Ok(DetailedRace12278)
    "1728-5" -> Ok(DetailedRace17285)
    "3277-1" -> Ok(DetailedRace32771)
    "1454-8" -> Ok(DetailedRace14548)
    "1681-6" -> Ok(DetailedRace16816)
    "3280-5" -> Ok(DetailedRace32805)
    "1326-8" -> Ok(DetailedRace13268)
    "1354-0" -> Ok(DetailedRace13540)
    "1620-4" -> Ok(DetailedRace16204)
    "3284-7" -> Ok(DetailedRace32847)
    "3285-4" -> Ok(DetailedRace32854)
    "1356-5" -> Ok(DetailedRace13565)
    "1228-6" -> Ok(DetailedRace12286)
    "1015-7" -> Ok(DetailedRace10157)
    "3289-6" -> Ok(DetailedRace32896)
    "1358-1" -> Ok(DetailedRace13581)
    "1361-5" -> Ok(DetailedRace13615)
    "1363-1" -> Ok(DetailedRace13631)
    "1365-6" -> Ok(DetailedRace13656)
    "3294-6" -> Ok(DetailedRace32946)
    "1138-7" -> Ok(DetailedRace11387)
    "1139-5" -> Ok(DetailedRace11395)
    "1368-0" -> Ok(DetailedRace13680)
    "1158-5" -> Ok(DetailedRace11585)
    "1370-6" -> Ok(DetailedRace13706)
    "1428-2" -> Ok(DetailedRace14282)
    "1372-2" -> Ok(DetailedRace13722)
    "1287-2" -> Ok(DetailedRace12872)
    "1374-8" -> Ok(DetailedRace13748)
    "1396-1" -> Ok(DetailedRace13961)
    "3305-0" -> Ok(DetailedRace33050)
    "1376-3" -> Ok(DetailedRace13763)
    "1327-6" -> Ok(DetailedRace13276)
    "1237-7" -> Ok(DetailedRace12377)
    "3309-2" -> Ok(DetailedRace33092)
    "1049-6" -> Ok(DetailedRace10496)
    "1345-8" -> Ok(DetailedRace13458)
    "1159-3" -> Ok(DetailedRace11593)
    "1522-2" -> Ok(DetailedRace15222)
    "1217-9" -> Ok(DetailedRace12179)
    "1238-5" -> Ok(DetailedRace12385)
    "1378-9" -> Ok(DetailedRace13789)
    "3317-5" -> Ok(DetailedRace33175)
    "1380-5" -> Ok(DetailedRace13805)
    "3319-1" -> Ok(DetailedRace33191)
    "1240-1" -> Ok(DetailedRace12401)
    "3321-7" -> Ok(DetailedRace33217)
    "1220-3" -> Ok(DetailedRace12203)
    "1387-0" -> Ok(DetailedRace13870)
    "1241-9" -> Ok(DetailedRace12419)
    "1346-6" -> Ok(DetailedRace13466)
    "1523-0" -> Ok(DetailedRace15230)
    "1389-6" -> Ok(DetailedRace13896)
    "1524-8" -> Ok(DetailedRace15248)
    "3329-0" -> Ok(DetailedRace33290)
    "1022-3" -> Ok(DetailedRace10223)
    "1095-9" -> Ok(DetailedRace10959)
    "1103-1" -> Ok(DetailedRace11031)
    "1429-0" -> Ok(DetailedRace14290)
    "1469-6" -> Ok(DetailedRace14696)
    "1598-2" -> Ok(DetailedRace15982)
    "1482-9" -> Ok(DetailedRace14829)
    "3337-3" -> Ok(DetailedRace33373)
    "3338-1" -> Ok(DetailedRace33381)
    "3339-9" -> Ok(DetailedRace33399)
    "3340-7" -> Ok(DetailedRace33407)
    "3341-5" -> Ok(DetailedRace33415)
    "1403-5" -> Ok(DetailedRace14035)
    "1288-0" -> Ok(DetailedRace12880)
    "3344-9" -> Ok(DetailedRace33449)
    "3345-6" -> Ok(DetailedRace33456)
    "1289-8" -> Ok(DetailedRace12898)
    "1405-0" -> Ok(DetailedRace14050)
    "1409-2" -> Ok(DetailedRace14092)
    "1411-8" -> Ok(DetailedRace14118)
    "1414-2" -> Ok(DetailedRace14142)
    "1416-7" -> Ok(DetailedRace14167)
    "1433-2" -> Ok(DetailedRace14332)
    "1604-8" -> Ok(DetailedRace16048)
    "1333-4" -> Ok(DetailedRace13334)
    "1439-9" -> Ok(DetailedRace14399)
    "3356-3" -> Ok(DetailedRace33563)
    "3357-1" -> Ok(DetailedRace33571)
    "1441-5" -> Ok(DetailedRace14415)
    "3359-7" -> Ok(DetailedRace33597)
    "3360-5" -> Ok(DetailedRace33605)
    "1334-2" -> Ok(DetailedRace13342)
    "1445-6" -> Ok(DetailedRace14456)
    "1446-4" -> Ok(DetailedRace14464)
    "1335-9" -> Ok(DetailedRace13359)
    "3365-4" -> Ok(DetailedRace33654)
    "3366-2" -> Ok(DetailedRace33662)
    "1448-0" -> Ok(DetailedRace14480)
    "3368-8" -> Ok(DetailedRace33688)
    "1453-0" -> Ok(DetailedRace14530)
    "1718-6" -> Ok(DetailedRace17186)
    "3371-2" -> Ok(DetailedRace33712)
    "1456-3" -> Ok(DetailedRace14563)
    "3373-8" -> Ok(DetailedRace33738)
    "1624-6" -> Ok(DetailedRace16246)
    "3375-3" -> Ok(DetailedRace33753)
    "1500-8" -> Ok(DetailedRace15008)
    "1460-5" -> Ok(DetailedRace14605)
    "3378-7" -> Ok(DetailedRace33787)
    "3379-5" -> Ok(DetailedRace33795)
    "1462-1" -> Ok(DetailedRace14621)
    "1443-1" -> Ok(DetailedRace14431)
    "1201-3" -> Ok(DetailedRace12013)
    "3383-7" -> Ok(DetailedRace33837)
    "1243-5" -> Ok(DetailedRace12435)
    "3385-2" -> Ok(DetailedRace33852)
    "1483-7" -> Ok(DetailedRace14837)
    "3387-8" -> Ok(DetailedRace33878)
    "1464-7" -> Ok(DetailedRace14647)
    "1474-6" -> Ok(DetailedRace14746)
    "1476-1" -> Ok(DetailedRace14761)
    "1475-3" -> Ok(DetailedRace14753)
    "3392-8" -> Ok(DetailedRace33928)
    "1328-4" -> Ok(DetailedRace13284)
    "1315-1" -> Ok(DetailedRace13151)
    "1478-7" -> Ok(DetailedRace14787)
    "3396-9" -> Ok(DetailedRace33969)
    "1487-8" -> Ok(DetailedRace14878)
    "1484-5" -> Ok(DetailedRace14845)
    "1625-3" -> Ok(DetailedRace16253)
    "1202-1" -> Ok(DetailedRace12021)
    "1489-4" -> Ok(DetailedRace14894)
    "1490-2" -> Ok(DetailedRace14902)
    "1492-8" -> Ok(DetailedRace14928)
    "1494-4" -> Ok(DetailedRace14944)
    "1495-1" -> Ok(DetailedRace14951)
    "1497-7" -> Ok(DetailedRace14977)
    "1498-5" -> Ok(DetailedRace14985)
    "1499-3" -> Ok(DetailedRace14993)
    "1501-6" -> Ok(DetailedRace15016)
    "1502-4" -> Ok(DetailedRace15024)
    "1503-2" -> Ok(DetailedRace15032)
    "1507-3" -> Ok(DetailedRace15073)
    "1508-1" -> Ok(DetailedRace15081)
    "1509-9" -> Ok(DetailedRace15099)
    "1511-5" -> Ok(DetailedRace15115)
    "1512-3" -> Ok(DetailedRace15123)
    "1515-6" -> Ok(DetailedRace15156)
    "1518-0" -> Ok(DetailedRace15180)
    "1526-3" -> Ok(DetailedRace15263)
    "1431-6" -> Ok(DetailedRace14316)
    "1541-2" -> Ok(DetailedRace15412)
    "3422-3" -> Ok(DetailedRace34223)
    "3423-1" -> Ok(DetailedRace34231)
    "1084-3" -> Ok(DetailedRace10843)
    "1543-8" -> Ok(DetailedRace15438)
    "1219-5" -> Ok(DetailedRace12195)
    "3427-2" -> Ok(DetailedRace34272)
    "1545-3" -> Ok(DetailedRace15453)
    "1141-1" -> Ok(DetailedRace11411)
    "1142-9" -> Ok(DetailedRace11429)
    "1061-1" -> Ok(DetailedRace10611)
    "3432-2" -> Ok(DetailedRace34322)
    "3433-0" -> Ok(DetailedRace34330)
    "1547-9" -> Ok(DetailedRace15479)
    "1733-5" -> Ok(DetailedRace17335)
    "3436-3" -> Ok(DetailedRace34363)
    "3437-1" -> Ok(DetailedRace34371)
    "1627-9" -> Ok(DetailedRace16279)
    "1549-5" -> Ok(DetailedRace15495)
    "1551-1" -> Ok(DetailedRace15511)
    "1553-7" -> Ok(DetailedRace15537)
    "1554-5" -> Ok(DetailedRace15545)
    "1552-9" -> Ok(DetailedRace15529)
    "3444-7" -> Ok(DetailedRace34447)
    "1143-7" -> Ok(DetailedRace11437)
    "3446-2" -> Ok(DetailedRace34462)
    "1556-0" -> Ok(DetailedRace15560)
    "1558-6" -> Ok(DetailedRace15586)
    "1458-9" -> Ok(DetailedRace14589)
    "1527-1" -> Ok(DetailedRace15271)
    "1018-1" -> Ok(DetailedRace10181)
    "1506-5" -> Ok(DetailedRace15065)
    "1432-4" -> Ok(DetailedRace14324)
    "3454-6" -> Ok(DetailedRace34546)
    "1574-3" -> Ok(DetailedRace15743)
    "1229-4" -> Ok(DetailedRace12294)
    "1050-4" -> Ok(DetailedRace10504)
    "1062-9" -> Ok(DetailedRace10629)
    "1163-5" -> Ok(DetailedRace11635)
    "3460-3" -> Ok(DetailedRace34603)
    "3461-1" -> Ok(DetailedRace34611)
    "1629-5" -> Ok(DetailedRace16295)
    "3463-7" -> Ok(DetailedRace34637)
    "3464-5" -> Ok(DetailedRace34645)
    "1528-9" -> Ok(DetailedRace15289)
    "1145-2" -> Ok(DetailedRace11452)
    "1562-8" -> Ok(DetailedRace15628)
    "1470-4" -> Ok(DetailedRace14704)
    "3469-4" -> Ok(DetailedRace34694)
    "1566-9" -> Ok(DetailedRace15669)
    "3471-0" -> Ok(DetailedRace34710)
    "3472-8" -> Ok(DetailedRace34728)
    "1292-2" -> Ok(DetailedRace12922)
    "1573-5" -> Ok(DetailedRace15735)
    "1329-2" -> Ok(DetailedRace13292)
    "1626-1" -> Ok(DetailedRace16261)
    "1576-8" -> Ok(DetailedRace15768)
    "1578-4" -> Ok(DetailedRace15784)
    "3479-3" -> Ok(DetailedRace34793)
    "1100-7" -> Ok(DetailedRace11007)
    "3481-9" -> Ok(DetailedRace34819)
    "3482-7" -> Ok(DetailedRace34827)
    "1582-6" -> Ok(DetailedRace15826)
    "1584-2" -> Ok(DetailedRace15842)
    "1586-7" -> Ok(DetailedRace15867)
    "1602-2" -> Ok(DetailedRace16022)
    "1258-3" -> Ok(DetailedRace12583)
    "1603-0" -> Ok(DetailedRace16030)
    "1609-7" -> Ok(DetailedRace16097)
    "3490-0" -> Ok(DetailedRace34900)
    "1643-6" -> Ok(DetailedRace16436)
    "1529-7" -> Ok(DetailedRace15297)
    "1594-1" -> Ok(DetailedRace15941)
    "1530-5" -> Ok(DetailedRace15305)
    "1531-3" -> Ok(DetailedRace15313)
    "1532-1" -> Ok(DetailedRace15321)
    "1336-7" -> Ok(DetailedRace13367)
    "1146-0" -> Ok(DetailedRace11460)
    "3499-1" -> Ok(DetailedRace34991)
    "1244-3" -> Ok(DetailedRace12443)
    "1023-1" -> Ok(DetailedRace10231)
    "1104-9" -> Ok(DetailedRace11049)
    "3503-0" -> Ok(DetailedRace35030)
    "1632-9" -> Ok(DetailedRace16329)
    "1645-1" -> Ok(DetailedRace16451)
    "1533-9" -> Ok(DetailedRace15339)
    "1144-5" -> Ok(DetailedRace11445)
    "1633-7" -> Ok(DetailedRace16337)
    "1534-7" -> Ok(DetailedRace15347)
    "1535-4" -> Ok(DetailedRace15354)
    "1649-3" -> Ok(DetailedRace16493)
    "1471-2" -> Ok(DetailedRace14712)
    "1434-0" -> Ok(DetailedRace14340)
    "1651-9" -> Ok(DetailedRace16519)
    "1245-0" -> Ok(DetailedRace12450)
    "3516-2" -> Ok(DetailedRace35162)
    "1537-0" -> Ok(DetailedRace15370)
    "1231-0" -> Ok(DetailedRace12310)
    "3519-6" -> Ok(DetailedRace35196)
    "1719-4" -> Ok(DetailedRace17194)
    "1063-7" -> Ok(DetailedRace10637)
    "1397-9" -> Ok(DetailedRace13979)
    "3523-8" -> Ok(DetailedRace35238)
    "1338-3" -> Ok(DetailedRace13383)
    "3525-3" -> Ok(DetailedRace35253)
    "1398-7" -> Ok(DetailedRace13987)
    "1634-5" -> Ok(DetailedRace16345)
    "1112-2" -> Ok(DetailedRace11122)
    "1160-1" -> Ok(DetailedRace11601)
    "3530-3" -> Ok(DetailedRace35303)
    "1193-2" -> Ok(DetailedRace11932)
    "1407-6" -> Ok(DetailedRace14076)
    "1571-9" -> Ok(DetailedRace15719)
    "1203-9" -> Ok(DetailedRace12039)
    "3535-2" -> Ok(DetailedRace35352)
    "3536-0" -> Ok(DetailedRace35360)
    "1204-7" -> Ok(DetailedRace12047)
    "1254-2" -> Ok(DetailedRace12542)
    "1399-5" -> Ok(DetailedRace13995)
    "3540-2" -> Ok(DetailedRace35402)
    "3541-0" -> Ok(DetailedRace35410)
    "1659-2" -> Ok(DetailedRace16592)
    "3543-6" -> Ok(DetailedRace35436)
    "1293-0" -> Ok(DetailedRace12930)
    "1661-8" -> Ok(DetailedRace16618)
    "1017-3" -> Ok(DetailedRace10173)
    "1051-2" -> Ok(DetailedRace10512)
    "1272-4" -> Ok(DetailedRace12724)
    "1205-4" -> Ok(DetailedRace12054)
    "1538-8" -> Ok(DetailedRace15388)
    "1720-2" -> Ok(DetailedRace17202)
    "1246-8" -> Ok(DetailedRace12468)
    "3553-5" -> Ok(DetailedRace35535)
    "1147-8" -> Ok(DetailedRace11478)
    "1294-8" -> Ok(DetailedRace12948)
    "1096-7" -> Ok(DetailedRace10967)
    "1337-5" -> Ok(DetailedRace13375)
    "1663-4" -> Ok(DetailedRace16634)
    "1667-5" -> Ok(DetailedRace16675)
    "3560-0" -> Ok(DetailedRace35600)
    "3561-8" -> Ok(DetailedRace35618)
    "1277-3" -> Ok(DetailedRace12773)
    "1097-5" -> Ok(DetailedRace10975)
    "1118-9" -> Ok(DetailedRace11189)
    "3565-9" -> Ok(DetailedRace35659)
    "1636-0" -> Ok(DetailedRace16360)
    "1539-6" -> Ok(DetailedRace15396)
    "1670-9" -> Ok(DetailedRace16709)
    "1672-5" -> Ok(DetailedRace16725)
    "3570-9" -> Ok(DetailedRace35709)
    "1435-7" -> Ok(DetailedRace14357)
    "3572-5" -> Ok(DetailedRace35725)
    "1247-6" -> Ok(DetailedRace12476)
    "1637-8" -> Ok(DetailedRace16378)
    "1675-8" -> Ok(DetailedRace16758)
    "1119-7" -> Ok(DetailedRace11197)
    "1436-5" -> Ok(DetailedRace14365)
    "1677-4" -> Ok(DetailedRace16774)
    "1679-0" -> Ok(DetailedRace16790)
    "1680-8" -> Ok(DetailedRace16808)
    "1064-5" -> Ok(DetailedRace10645)
    "1685-7" -> Ok(DetailedRace16857)
    "3583-2" -> Ok(DetailedRace35832)
    "3584-0" -> Ok(DetailedRace35840)
    "1639-4" -> Ok(DetailedRace16394)
    "1400-1" -> Ok(DetailedRace14001)
    "1273-2" -> Ok(DetailedRace12732)
    "1148-6" -> Ok(DetailedRace11486)
    "1019-9" -> Ok(DetailedRace10199)
    "3590-7" -> Ok(DetailedRace35907)
    "1692-3" -> Ok(DetailedRace16923)
    "1248-4" -> Ok(DetailedRace12484)
    "1120-5" -> Ok(DetailedRace11205)
    "3594-9" -> Ok(DetailedRace35949)
    "1694-9" -> Ok(DetailedRace16949)
    "1696-4" -> Ok(DetailedRace16964)
    "1698-0" -> Ok(DetailedRace16980)
    "1700-4" -> Ok(DetailedRace17004)
    "1702-0" -> Ok(DetailedRace17020)
    "1121-3" -> Ok(DetailedRace11213)
    "3601-2" -> Ok(DetailedRace36012)
    "1295-5" -> Ok(DetailedRace12955)
    "1709-5" -> Ok(DetailedRace17095)
    "1065-2" -> Ok(DetailedRace10652)
    "1640-2" -> Ok(DetailedRace16402)
    "1641-0" -> Ok(DetailedRace16410)
    "1711-1" -> Ok(DetailedRace17111)
    "1715-2" -> Ok(DetailedRace17152)
    "1731-9" -> Ok(DetailedRace17319)
    "1437-3" -> Ok(DetailedRace14373)
    "3611-1" -> Ok(DetailedRace36111)
    "1717-8" -> Ok(DetailedRace17178)
    "1600-6" -> Ok(DetailedRace16006)
    "1514-9" -> Ok(DetailedRace15149)
    "1722-8" -> Ok(DetailedRace17228)
    "1066-0" -> Ok(DetailedRace10660)
    "1732-7" -> Ok(DetailedRace17327)
    "1516-4" -> Ok(DetailedRace15164)
    "1735-0" -> Ok(DetailedRace17350)
    "1737-6" -> Ok(DetailedRace17376)
    "1739-2" -> Ok(DetailedRace17392)
    "1740-0" -> Ok(DetailedRace17400)
    "1744-2" -> Ok(DetailedRace17442)
    "1741-8" -> Ok(DetailedRace17418)
    "1742-6" -> Ok(DetailedRace17426)
    "1743-4" -> Ok(DetailedRace17434)
    "1745-9" -> Ok(DetailedRace17459)
    "3628-5" -> Ok(DetailedRace36285)
    "1747-5" -> Ok(DetailedRace17475)
    "1748-3" -> Ok(DetailedRace17483)
    "1750-9" -> Ok(DetailedRace17509)
    "1752-5" -> Ok(DetailedRace17525)
    "1751-7" -> Ok(DetailedRace17517)
    "1754-1" -> Ok(DetailedRace17541)
    "1755-8" -> Ok(DetailedRace17558)
    "1757-4" -> Ok(DetailedRace17574)
    "1759-0" -> Ok(DetailedRace17590)
    "1761-6" -> Ok(DetailedRace17616)
    "1762-4" -> Ok(DetailedRace17624)
    "1765-7" -> Ok(DetailedRace17657)
    "1767-3" -> Ok(DetailedRace17673)
    "1768-1" -> Ok(DetailedRace17681)
    "1769-9" -> Ok(DetailedRace17699)
    "1770-7" -> Ok(DetailedRace17707)
    "1771-5" -> Ok(DetailedRace17715)
    "1775-6" -> Ok(DetailedRace17756)
    "1776-4" -> Ok(DetailedRace17764)
    "1777-2" -> Ok(DetailedRace17772)
    "1778-0" -> Ok(DetailedRace17780)
    "1780-6" -> Ok(DetailedRace17806)
    "1779-8" -> Ok(DetailedRace17798)
    "1781-4" -> Ok(DetailedRace17814)
    "1749-1" -> Ok(DetailedRace17491)
    "1753-3" -> Ok(DetailedRace17533)
    "1760-8" -> Ok(DetailedRace17608)
    "1763-2" -> Ok(DetailedRace17632)
    "1764-0" -> Ok(DetailedRace17640)
    "1774-9" -> Ok(DetailedRace17749)
    "1782-2" -> Ok(DetailedRace17822)
    "1791-3" -> Ok(DetailedRace17913)
    "1796-2" -> Ok(DetailedRace17962)
    "1799-6" -> Ok(DetailedRace17996)
    "1801-0" -> Ok(DetailedRace18010)
    "1803-6" -> Ok(DetailedRace18036)
    "1805-1" -> Ok(DetailedRace18051)
    "1807-7" -> Ok(DetailedRace18077)
    "1783-0" -> Ok(DetailedRace17830)
    "1784-8" -> Ok(DetailedRace17848)
    "1785-5" -> Ok(DetailedRace17855)
    "1786-3" -> Ok(DetailedRace17863)
    "1787-1" -> Ok(DetailedRace17871)
    "1788-9" -> Ok(DetailedRace17889)
    "1766-5" -> Ok(DetailedRace17665)
    "1789-7" -> Ok(DetailedRace17897)
    "1790-5" -> Ok(DetailedRace17905)
    "1793-9" -> Ok(DetailedRace17939)
    "1795-4" -> Ok(DetailedRace17954)
    "1794-7" -> Ok(DetailedRace17947)
    "1798-8" -> Ok(DetailedRace17988)
    "1802-8" -> Ok(DetailedRace18028)
    "1804-4" -> Ok(DetailedRace18044)
    "1806-9" -> Ok(DetailedRace18069)
    "1758-2" -> Ok(DetailedRace17582)
    "1772-3" -> Ok(DetailedRace17723)
    "1773-1" -> Ok(DetailedRace17731)
    "1792-1" -> Ok(DetailedRace17921)
    "1797-0" -> Ok(DetailedRace17970)
    "1808-5" -> Ok(DetailedRace18085)
    "1809-3" -> Ok(DetailedRace18093)
    "1825-9" -> Ok(DetailedRace18259)
    "1966-1" -> Ok(DetailedRace19661)
    "1994-3" -> Ok(DetailedRace19943)
    "2008-1" -> Ok(DetailedRace20081)
    "4187-1" -> Ok(DetailedRace41871)
    "1972-9" -> Ok(DetailedRace19729)
    "1973-7" -> Ok(DetailedRace19737)
    "1974-5" -> Ok(DetailedRace19745)
    "1984-4" -> Ok(DetailedRace19844)
    "1986-9" -> Ok(DetailedRace19869)
    "1975-2" -> Ok(DetailedRace19752)
    "1840-8" -> Ok(DetailedRace18408)
    "1976-0" -> Ok(DetailedRace19760)
    "1977-8" -> Ok(DetailedRace19778)
    "3704-4" -> Ok(DetailedRace37044)
    "2014-9" -> Ok(DetailedRace20149)
    "1978-6" -> Ok(DetailedRace19786)
    "1996-8" -> Ok(DetailedRace19968)
    "1979-4" -> Ok(DetailedRace19794)
    "1992-7" -> Ok(DetailedRace19927)
    "3710-1" -> Ok(DetailedRace37101)
    "3711-9" -> Ok(DetailedRace37119)
    "1993-5" -> Ok(DetailedRace19935)
    "2007-3" -> Ok(DetailedRace20073)
    "2011-5" -> Ok(DetailedRace20115)
    "2012-3" -> Ok(DetailedRace20123)
    "1985-1" -> Ok(DetailedRace19851)
    "2013-1" -> Ok(DetailedRace20131)
    "1990-1" -> Ok(DetailedRace19901)
    "2015-6" -> Ok(DetailedRace20156)
    "3720-0" -> Ok(DetailedRace37200)
    "1995-0" -> Ok(DetailedRace19950)
    "1997-6" -> Ok(DetailedRace19976)
    "1987-7" -> Ok(DetailedRace19877)
    "2016-4" -> Ok(DetailedRace20164)
    "2017-2" -> Ok(DetailedRace20172)
    "1999-2" -> Ok(DetailedRace19992)
    "1980-2" -> Ok(DetailedRace19802)
    "1981-0" -> Ok(DetailedRace19810)
    "1988-5" -> Ok(DetailedRace19885)
    "1982-8" -> Ok(DetailedRace19828)
    "2000-8" -> Ok(DetailedRace20008)
    "1969-5" -> Ok(DetailedRace19695)
    "2026-3" -> Ok(DetailedRace20263)
    "2018-0" -> Ok(DetailedRace20180)
    "3735-8" -> Ok(DetailedRace37358)
    "2020-6" -> Ok(DetailedRace20206)
    "2021-4" -> Ok(DetailedRace20214)
    "2022-2" -> Ok(DetailedRace20222)
    "2024-8" -> Ok(DetailedRace20248)
    "2002-4" -> Ok(DetailedRace20024)
    "3741-6" -> Ok(DetailedRace37416)
    "1970-3" -> Ok(DetailedRace19703)
    "3743-2" -> Ok(DetailedRace37432)
    "1998-4" -> Ok(DetailedRace19984)
    "3745-7" -> Ok(DetailedRace37457)
    "3746-5" -> Ok(DetailedRace37465)
    "1849-9" -> Ok(DetailedRace18499)
    "1850-7" -> Ok(DetailedRace18507)
    "1852-3" -> Ok(DetailedRace18523)
    "1909-1" -> Ok(DetailedRace19091)
    "3751-5" -> Ok(DetailedRace37515)
    "1842-4" -> Ok(DetailedRace18424)
    "3753-1" -> Ok(DetailedRace37531)
    "1848-1" -> Ok(DetailedRace18481)
    "1862-2" -> Ok(DetailedRace18622)
    "1863-0" -> Ok(DetailedRace18630)
    "3757-2" -> Ok(DetailedRace37572)
    "1871-3" -> Ok(DetailedRace18713)
    "1845-7" -> Ok(DetailedRace18457)
    "1851-5" -> Ok(DetailedRace18515)
    "1853-1" -> Ok(DetailedRace18531)
    "1854-9" -> Ok(DetailedRace18549)
    "1856-4" -> Ok(DetailedRace18564)
    "1857-2" -> Ok(DetailedRace18572)
    "1860-6" -> Ok(DetailedRace18606)
    "1858-0" -> Ok(DetailedRace18580)
    "1864-8" -> Ok(DetailedRace18648)
    "1865-5" -> Ok(DetailedRace18655)
    "1866-3" -> Ok(DetailedRace18663)
    "1867-1" -> Ok(DetailedRace18671)
    "1868-9" -> Ok(DetailedRace18689)
    "1889-5" -> Ok(DetailedRace18895)
    "1933-1" -> Ok(DetailedRace19331)
    "1872-1" -> Ok(DetailedRace18721)
    "1875-4" -> Ok(DetailedRace18754)
    "1876-2" -> Ok(DetailedRace18762)
    "1877-0" -> Ok(DetailedRace18770)
    "1878-8" -> Ok(DetailedRace18788)
    "1879-6" -> Ok(DetailedRace18796)
    "1880-4" -> Ok(DetailedRace18804)
    "1881-2" -> Ok(DetailedRace18812)
    "1883-8" -> Ok(DetailedRace18838)
    "1884-6" -> Ok(DetailedRace18846)
    "1886-1" -> Ok(DetailedRace18861)
    "3785-3" -> Ok(DetailedRace37853)
    "1873-9" -> Ok(DetailedRace18739)
    "1874-7" -> Ok(DetailedRace18747)
    "3788-7" -> Ok(DetailedRace37887)
    "1882-0" -> Ok(DetailedRace18820)
    "1885-3" -> Ok(DetailedRace18853)
    "1833-3" -> Ok(DetailedRace18333)
    "3861-2" -> Ok(DetailedRace38612)
    "1816-8" -> Ok(DetailedRace18168)
    "1817-6" -> Ok(DetailedRace18176)
    "1818-4" -> Ok(DetailedRace18184)
    "1819-2" -> Ok(DetailedRace18192)
    "1820-0" -> Ok(DetailedRace18200)
    "1821-8" -> Ok(DetailedRace18218)
    "1822-6" -> Ok(DetailedRace18226)
    "1826-7" -> Ok(DetailedRace18267)
    "1827-5" -> Ok(DetailedRace18275)
    "1823-4" -> Ok(DetailedRace18234)
    "1824-2" -> Ok(DetailedRace18242)
    "1830-9" -> Ok(DetailedRace18309)
    "1828-3" -> Ok(DetailedRace18283)
    "1829-1" -> Ok(DetailedRace18291)
    "1811-9" -> Ok(DetailedRace18119)
    "1831-7" -> Ok(DetailedRace18317)
    "3809-1" -> Ok(DetailedRace38091)
    "1832-5" -> Ok(DetailedRace18325)
    "1814-3" -> Ok(DetailedRace18143)
    "1834-1" -> Ok(DetailedRace18341)
    "1835-8" -> Ok(DetailedRace18358)
    "1837-4" -> Ok(DetailedRace18374)
    "1838-2" -> Ok(DetailedRace18382)
    "1896-0" -> Ok(DetailedRace18960)
    "1897-8" -> Ok(DetailedRace18978)
    "1898-6" -> Ok(DetailedRace18986)
    "1963-8" -> Ok(DetailedRace19638)
    "1934-9" -> Ok(DetailedRace19349)
    "1906-7" -> Ok(DetailedRace19067)
    "1907-5" -> Ok(DetailedRace19075)
    "3823-2" -> Ok(DetailedRace38232)
    "1913-3" -> Ok(DetailedRace19133)
    "1916-6" -> Ok(DetailedRace19166)
    "3826-5" -> Ok(DetailedRace38265)
    "1920-8" -> Ok(DetailedRace19208)
    "1929-9" -> Ok(DetailedRace19299)
    "1931-5" -> Ok(DetailedRace19315)
    "1935-6" -> Ok(DetailedRace19356)
    "1900-0" -> Ok(DetailedRace19000)
    "1910-9" -> Ok(DetailedRace19109)
    "1914-1" -> Ok(DetailedRace19141)
    "1915-8" -> Ok(DetailedRace19158)
    "1892-9" -> Ok(DetailedRace18929)
    "1962-0" -> Ok(DetailedRace19620)
    "1918-2" -> Ok(DetailedRace19182)
    "3838-0" -> Ok(DetailedRace38380)
    "1919-0" -> Ok(DetailedRace19190)
    "1922-4" -> Ok(DetailedRace19224)
    "1923-2" -> Ok(DetailedRace19232)
    "1925-7" -> Ok(DetailedRace19257)
    "1928-1" -> Ok(DetailedRace19281)
    "1949-7" -> Ok(DetailedRace19497)
    "1932-3" -> Ok(DetailedRace19323)
    "1936-4" -> Ok(DetailedRace19364)
    "1937-2" -> Ok(DetailedRace19372)
    "1938-0" -> Ok(DetailedRace19380)
    "1942-2" -> Ok(DetailedRace19422)
    "1953-9" -> Ok(DetailedRace19539)
    "1943-0" -> Ok(DetailedRace19430)
    "1946-3" -> Ok(DetailedRace19463)
    "1951-3" -> Ok(DetailedRace19513)
    "1893-7" -> Ok(DetailedRace18937)
    "1952-1" -> Ok(DetailedRace19521)
    "1959-6" -> Ok(DetailedRace19596)
    "1960-4" -> Ok(DetailedRace19604)
    "1924-0" -> Ok(DetailedRace19240)
    "1940-6" -> Ok(DetailedRace19406)
    "1939-8" -> Ok(DetailedRace19398)
    "1941-4" -> Ok(DetailedRace19414)
    "1957-0" -> Ok(DetailedRace19570)
    "1927-3" -> Ok(DetailedRace19273)
    "1904-2" -> Ok(DetailedRace19042)
    "1944-8" -> Ok(DetailedRace19448)
    "1945-5" -> Ok(DetailedRace19455)
    "1947-1" -> Ok(DetailedRace19471)
    "1948-9" -> Ok(DetailedRace19489)
    "1894-5" -> Ok(DetailedRace18945)
    "1955-4" -> Ok(DetailedRace19554)
    "1956-2" -> Ok(DetailedRace19562)
    "1958-8" -> Ok(DetailedRace19588)
    "1961-2" -> Ok(DetailedRace19612)
    "1964-6" -> Ok(DetailedRace19646)
    "1899-4" -> Ok(DetailedRace18994)
    "1902-6" -> Ok(DetailedRace19026)
    "1903-4" -> Ok(DetailedRace19034)
    "1905-9" -> Ok(DetailedRace19059)
    "1908-3" -> Ok(DetailedRace19083)
    "1911-7" -> Ok(DetailedRace19117)
    "1912-5" -> Ok(DetailedRace19125)
    "1921-6" -> Ok(DetailedRace19216)
    "1926-5" -> Ok(DetailedRace19265)
    "1930-7" -> Ok(DetailedRace19307)
    "3885-1" -> Ok(DetailedRace38851)
    "1950-5" -> Ok(DetailedRace19505)
    "1954-7" -> Ok(DetailedRace19547)
    "1901-8" -> Ok(DetailedRace19018)
    "3889-3" -> Ok(DetailedRace38893)
    "1069-4" -> Ok(DetailedRace10694)
    "3891-9" -> Ok(DetailedRace38919)
    "3892-7" -> Ok(DetailedRace38927)
    "3893-5" -> Ok(DetailedRace38935)
    "3894-3" -> Ok(DetailedRace38943)
    "3895-0" -> Ok(DetailedRace38950)
    "3896-8" -> Ok(DetailedRace38968)
    "3897-6" -> Ok(DetailedRace38976)
    "3898-4" -> Ok(DetailedRace38984)
    "3899-2" -> Ok(DetailedRace38992)
    "3900-8" -> Ok(DetailedRace39008)
    "3901-6" -> Ok(DetailedRace39016)
    "3902-4" -> Ok(DetailedRace39024)
    "3903-2" -> Ok(DetailedRace39032)
    "3904-0" -> Ok(DetailedRace39040)
    "3905-7" -> Ok(DetailedRace39057)
    "3906-5" -> Ok(DetailedRace39065)
    "3907-3" -> Ok(DetailedRace39073)
    "3908-1" -> Ok(DetailedRace39081)
    "3909-9" -> Ok(DetailedRace39099)
    "3910-7" -> Ok(DetailedRace39107)
    "3911-5" -> Ok(DetailedRace39115)
    "3912-3" -> Ok(DetailedRace39123)
    "3913-1" -> Ok(DetailedRace39131)
    "3914-9" -> Ok(DetailedRace39149)
    "3915-6" -> Ok(DetailedRace39156)
    "3916-4" -> Ok(DetailedRace39164)
    "3917-2" -> Ok(DetailedRace39172)
    "3918-0" -> Ok(DetailedRace39180)
    "3919-8" -> Ok(DetailedRace39198)
    "3920-6" -> Ok(DetailedRace39206)
    "3921-4" -> Ok(DetailedRace39214)
    "3922-2" -> Ok(DetailedRace39222)
    "3923-0" -> Ok(DetailedRace39230)
    "3924-8" -> Ok(DetailedRace39248)
    "3925-5" -> Ok(DetailedRace39255)
    "3926-3" -> Ok(DetailedRace39263)
    "3927-1" -> Ok(DetailedRace39271)
    "3928-9" -> Ok(DetailedRace39289)
    "3929-7" -> Ok(DetailedRace39297)
    "3930-5" -> Ok(DetailedRace39305)
    "3931-3" -> Ok(DetailedRace39313)
    "3932-1" -> Ok(DetailedRace39321)
    "3933-9" -> Ok(DetailedRace39339)
    "3934-7" -> Ok(DetailedRace39347)
    "3935-4" -> Ok(DetailedRace39354)
    "3936-2" -> Ok(DetailedRace39362)
    "3937-0" -> Ok(DetailedRace39370)
    "3938-8" -> Ok(DetailedRace39388)
    "3939-6" -> Ok(DetailedRace39396)
    "3940-4" -> Ok(DetailedRace39404)
    "3941-2" -> Ok(DetailedRace39412)
    "3942-0" -> Ok(DetailedRace39420)
    "3943-8" -> Ok(DetailedRace39438)
    "3944-6" -> Ok(DetailedRace39446)
    "3945-3" -> Ok(DetailedRace39453)
    "3946-1" -> Ok(DetailedRace39461)
    "3947-9" -> Ok(DetailedRace39479)
    "3948-7" -> Ok(DetailedRace39487)
    "3949-5" -> Ok(DetailedRace39495)
    "1071-0" -> Ok(DetailedRace10710)
    "3951-1" -> Ok(DetailedRace39511)
    "3952-9" -> Ok(DetailedRace39529)
    "3953-7" -> Ok(DetailedRace39537)
    "3954-5" -> Ok(DetailedRace39545)
    "3955-2" -> Ok(DetailedRace39552)
    "3956-0" -> Ok(DetailedRace39560)
    "3957-8" -> Ok(DetailedRace39578)
    "3958-6" -> Ok(DetailedRace39586)
    "3959-4" -> Ok(DetailedRace39594)
    "3960-2" -> Ok(DetailedRace39602)
    "3961-0" -> Ok(DetailedRace39610)
    "3962-8" -> Ok(DetailedRace39628)
    "3963-6" -> Ok(DetailedRace39636)
    "3964-4" -> Ok(DetailedRace39644)
    "3965-1" -> Ok(DetailedRace39651)
    "3966-9" -> Ok(DetailedRace39669)
    "3967-7" -> Ok(DetailedRace39677)
    "3968-5" -> Ok(DetailedRace39685)
    "3969-3" -> Ok(DetailedRace39693)
    "3970-1" -> Ok(DetailedRace39701)
    "3971-9" -> Ok(DetailedRace39719)
    "3972-7" -> Ok(DetailedRace39727)
    "3973-5" -> Ok(DetailedRace39735)
    "3974-3" -> Ok(DetailedRace39743)
    "3975-0" -> Ok(DetailedRace39750)
    "3976-8" -> Ok(DetailedRace39768)
    "3977-6" -> Ok(DetailedRace39776)
    "3978-4" -> Ok(DetailedRace39784)
    "3979-2" -> Ok(DetailedRace39792)
    "3980-0" -> Ok(DetailedRace39800)
    "3981-8" -> Ok(DetailedRace39818)
    "3982-6" -> Ok(DetailedRace39826)
    "3983-4" -> Ok(DetailedRace39834)
    "3984-2" -> Ok(DetailedRace39842)
    "3985-9" -> Ok(DetailedRace39859)
    "3986-7" -> Ok(DetailedRace39867)
    "3987-5" -> Ok(DetailedRace39875)
    "3988-3" -> Ok(DetailedRace39883)
    "3989-1" -> Ok(DetailedRace39891)
    "3990-9" -> Ok(DetailedRace39909)
    "3991-7" -> Ok(DetailedRace39917)
    "3992-5" -> Ok(DetailedRace39925)
    "3993-3" -> Ok(DetailedRace39933)
    "3994-1" -> Ok(DetailedRace39941)
    "3995-8" -> Ok(DetailedRace39958)
    "3996-6" -> Ok(DetailedRace39966)
    "3997-4" -> Ok(DetailedRace39974)
    "3998-2" -> Ok(DetailedRace39982)
    "3999-0" -> Ok(DetailedRace39990)
    "4000-6" -> Ok(DetailedRace40006)
    "4001-4" -> Ok(DetailedRace40014)
    "4002-2" -> Ok(DetailedRace40022)
    "4003-0" -> Ok(DetailedRace40030)
    "4004-8" -> Ok(DetailedRace40048)
    "4005-5" -> Ok(DetailedRace40055)
    "4006-3" -> Ok(DetailedRace40063)
    "4007-1" -> Ok(DetailedRace40071)
    "4008-9" -> Ok(DetailedRace40089)
    "4009-7" -> Ok(DetailedRace40097)
    "4010-5" -> Ok(DetailedRace40105)
    "4011-3" -> Ok(DetailedRace40113)
    "4012-1" -> Ok(DetailedRace40121)
    "4013-9" -> Ok(DetailedRace40139)
    "4014-7" -> Ok(DetailedRace40147)
    "4015-4" -> Ok(DetailedRace40154)
    "4016-2" -> Ok(DetailedRace40162)
    "4017-0" -> Ok(DetailedRace40170)
    "4018-8" -> Ok(DetailedRace40188)
    "4019-6" -> Ok(DetailedRace40196)
    "4020-4" -> Ok(DetailedRace40204)
    "4021-2" -> Ok(DetailedRace40212)
    "4022-0" -> Ok(DetailedRace40220)
    "4023-8" -> Ok(DetailedRace40238)
    "4024-6" -> Ok(DetailedRace40246)
    "4025-3" -> Ok(DetailedRace40253)
    "4026-1" -> Ok(DetailedRace40261)
    "4027-9" -> Ok(DetailedRace40279)
    "4028-7" -> Ok(DetailedRace40287)
    "4029-5" -> Ok(DetailedRace40295)
    "4030-3" -> Ok(DetailedRace40303)
    "4031-1" -> Ok(DetailedRace40311)
    "4032-9" -> Ok(DetailedRace40329)
    "4033-7" -> Ok(DetailedRace40337)
    "4034-5" -> Ok(DetailedRace40345)
    "4035-2" -> Ok(DetailedRace40352)
    "4036-0" -> Ok(DetailedRace40360)
    "4037-8" -> Ok(DetailedRace40378)
    "4038-6" -> Ok(DetailedRace40386)
    "4039-4" -> Ok(DetailedRace40394)
    "4040-2" -> Ok(DetailedRace40402)
    "4041-0" -> Ok(DetailedRace40410)
    "4042-8" -> Ok(DetailedRace40428)
    "4043-6" -> Ok(DetailedRace40436)
    "4044-4" -> Ok(DetailedRace40444)
    "4045-1" -> Ok(DetailedRace40451)
    "4046-9" -> Ok(DetailedRace40469)
    "4047-7" -> Ok(DetailedRace40477)
    "4048-5" -> Ok(DetailedRace40485)
    "4049-3" -> Ok(DetailedRace40493)
    "4050-1" -> Ok(DetailedRace40501)
    "4051-9" -> Ok(DetailedRace40519)
    "4052-7" -> Ok(DetailedRace40527)
    "4053-5" -> Ok(DetailedRace40535)
    "4054-3" -> Ok(DetailedRace40543)
    "4055-0" -> Ok(DetailedRace40550)
    "4056-8" -> Ok(DetailedRace40568)
    "4057-6" -> Ok(DetailedRace40576)
    "4058-4" -> Ok(DetailedRace40584)
    "4059-2" -> Ok(DetailedRace40592)
    "4060-0" -> Ok(DetailedRace40600)
    "4061-8" -> Ok(DetailedRace40618)
    "4062-6" -> Ok(DetailedRace40626)
    "4063-4" -> Ok(DetailedRace40634)
    "4064-2" -> Ok(DetailedRace40642)
    "4065-9" -> Ok(DetailedRace40659)
    "4066-7" -> Ok(DetailedRace40667)
    "4067-5" -> Ok(DetailedRace40675)
    "4068-3" -> Ok(DetailedRace40683)
    "4069-1" -> Ok(DetailedRace40691)
    "4070-9" -> Ok(DetailedRace40709)
    "4071-7" -> Ok(DetailedRace40717)
    "4072-5" -> Ok(DetailedRace40725)
    "4073-3" -> Ok(DetailedRace40733)
    "4074-1" -> Ok(DetailedRace40741)
    "4075-8" -> Ok(DetailedRace40758)
    "4076-6" -> Ok(DetailedRace40766)
    "4077-4" -> Ok(DetailedRace40774)
    "4078-2" -> Ok(DetailedRace40782)
    "4079-0" -> Ok(DetailedRace40790)
    "4080-8" -> Ok(DetailedRace40808)
    "4081-6" -> Ok(DetailedRace40816)
    "4082-4" -> Ok(DetailedRace40824)
    "4083-2" -> Ok(DetailedRace40832)
    "4084-0" -> Ok(DetailedRace40840)
    "4085-7" -> Ok(DetailedRace40857)
    "1070-2" -> Ok(DetailedRace10702)
    "4087-3" -> Ok(DetailedRace40873)
    "4088-1" -> Ok(DetailedRace40881)
    "4089-9" -> Ok(DetailedRace40899)
    "4090-7" -> Ok(DetailedRace40907)
    "4091-5" -> Ok(DetailedRace40915)
    "4092-3" -> Ok(DetailedRace40923)
    "4093-1" -> Ok(DetailedRace40931)
    "4094-9" -> Ok(DetailedRace40949)
    "4095-6" -> Ok(DetailedRace40956)
    "4096-4" -> Ok(DetailedRace40964)
    "4097-2" -> Ok(DetailedRace40972)
    "4098-0" -> Ok(DetailedRace40980)
    "4099-8" -> Ok(DetailedRace40998)
    "4100-4" -> Ok(DetailedRace41004)
    "4101-2" -> Ok(DetailedRace41012)
    "4102-0" -> Ok(DetailedRace41020)
    "4103-8" -> Ok(DetailedRace41038)
    "4104-6" -> Ok(DetailedRace41046)
    "4105-3" -> Ok(DetailedRace41053)
    "4106-1" -> Ok(DetailedRace41061)
    "4107-9" -> Ok(DetailedRace41079)
    "4108-7" -> Ok(DetailedRace41087)
    "4109-5" -> Ok(DetailedRace41095)
    "4110-3" -> Ok(DetailedRace41103)
    "4111-1" -> Ok(DetailedRace41111)
    "4112-9" -> Ok(DetailedRace41129)
    "4113-7" -> Ok(DetailedRace41137)
    "4114-5" -> Ok(DetailedRace41145)
    "4115-2" -> Ok(DetailedRace41152)
    "4116-0" -> Ok(DetailedRace41160)
    "4117-8" -> Ok(DetailedRace41178)
    "4118-6" -> Ok(DetailedRace41186)
    "4119-4" -> Ok(DetailedRace41194)
    "4120-2" -> Ok(DetailedRace41202)
    "4121-0" -> Ok(DetailedRace41210)
    "4122-8" -> Ok(DetailedRace41228)
    "4123-6" -> Ok(DetailedRace41236)
    "4124-4" -> Ok(DetailedRace41244)
    "4125-1" -> Ok(DetailedRace41251)
    "4126-9" -> Ok(DetailedRace41269)
    "4127-7" -> Ok(DetailedRace41277)
    "4128-5" -> Ok(DetailedRace41285)
    "4129-3" -> Ok(DetailedRace41293)
    "4130-1" -> Ok(DetailedRace41301)
    "4131-9" -> Ok(DetailedRace41319)
    "4132-7" -> Ok(DetailedRace41327)
    "4133-5" -> Ok(DetailedRace41335)
    "4134-3" -> Ok(DetailedRace41343)
    "4135-0" -> Ok(DetailedRace41350)
    "4136-8" -> Ok(DetailedRace41368)
    "4137-6" -> Ok(DetailedRace41376)
    "4138-4" -> Ok(DetailedRace41384)
    "4139-2" -> Ok(DetailedRace41392)
    "4140-0" -> Ok(DetailedRace41400)
    "4141-8" -> Ok(DetailedRace41418)
    "4142-6" -> Ok(DetailedRace41426)
    "4143-4" -> Ok(DetailedRace41434)
    "4144-2" -> Ok(DetailedRace41442)
    "4145-9" -> Ok(DetailedRace41459)
    "4146-7" -> Ok(DetailedRace41467)
    "1072-8" -> Ok(DetailedRace10728)
    "4148-3" -> Ok(DetailedRace41483)
    "1073-6" -> Ok(DetailedRace10736)
    "4150-9" -> Ok(DetailedRace41509)
    "4151-7" -> Ok(DetailedRace41517)
    "4152-5" -> Ok(DetailedRace41525)
    "4153-3" -> Ok(DetailedRace41533)
    "4154-1" -> Ok(DetailedRace41541)
    "4155-8" -> Ok(DetailedRace41558)
    "4156-6" -> Ok(DetailedRace41566)
    "4157-4" -> Ok(DetailedRace41574)
    "4158-2" -> Ok(DetailedRace41582)
    "4159-0" -> Ok(DetailedRace41590)
    "4160-8" -> Ok(DetailedRace41608)
    "4161-6" -> Ok(DetailedRace41616)
    "4162-4" -> Ok(DetailedRace41624)
    "4163-2" -> Ok(DetailedRace41632)
    "4164-0" -> Ok(DetailedRace41640)
    "4165-7" -> Ok(DetailedRace41657)
    "4166-5" -> Ok(DetailedRace41665)
    "4167-3" -> Ok(DetailedRace41673)
    "4168-1" -> Ok(DetailedRace41681)
    "4169-9" -> Ok(DetailedRace41699)
    "4170-7" -> Ok(DetailedRace41707)
    "4171-5" -> Ok(DetailedRace41715)
    "4172-3" -> Ok(DetailedRace41723)
    "4173-1" -> Ok(DetailedRace41731)
    "4174-9" -> Ok(DetailedRace41749)
    "4175-6" -> Ok(DetailedRace41756)
    "4176-4" -> Ok(DetailedRace41764)
    "4177-2" -> Ok(DetailedRace41772)
    "4178-0" -> Ok(DetailedRace41780)
    "4179-8" -> Ok(DetailedRace41798)
    "4180-6" -> Ok(DetailedRace41806)
    "4181-4" -> Ok(DetailedRace41814)
    "1074-4" -> Ok(DetailedRace10744)
    "4183-0" -> Ok(DetailedRace41830)
    "4184-8" -> Ok(DetailedRace41848)
    "4185-5" -> Ok(DetailedRace41855)
    "2029-7" -> Ok(DetailedRace20297)
    "2030-5" -> Ok(DetailedRace20305)
    "2031-3" -> Ok(DetailedRace20313)
    "2032-1" -> Ok(DetailedRace20321)
    "2033-9" -> Ok(DetailedRace20339)
    "2034-7" -> Ok(DetailedRace20347)
    "2035-4" -> Ok(DetailedRace20354)
    "2036-2" -> Ok(DetailedRace20362)
    "2037-0" -> Ok(DetailedRace20370)
    "2038-8" -> Ok(DetailedRace20388)
    "2039-6" -> Ok(DetailedRace20396)
    "2040-4" -> Ok(DetailedRace20404)
    "2041-2" -> Ok(DetailedRace20412)
    "2042-0" -> Ok(DetailedRace20420)
    "2043-8" -> Ok(DetailedRace20438)
    "2044-6" -> Ok(DetailedRace20446)
    "2045-3" -> Ok(DetailedRace20453)
    "2046-1" -> Ok(DetailedRace20461)
    "2047-9" -> Ok(DetailedRace20479)
    "2048-7" -> Ok(DetailedRace20487)
    "2049-5" -> Ok(DetailedRace20495)
    "2050-3" -> Ok(DetailedRace20503)
    "2051-1" -> Ok(DetailedRace20511)
    "2052-9" -> Ok(DetailedRace20529)
    "2056-0" -> Ok(DetailedRace20560)
    "2058-6" -> Ok(DetailedRace20586)
    "2060-2" -> Ok(DetailedRace20602)
    "2061-0" -> Ok(DetailedRace20610)
    "2062-8" -> Ok(DetailedRace20628)
    "2063-6" -> Ok(DetailedRace20636)
    "2064-4" -> Ok(DetailedRace20644)
    "2065-1" -> Ok(DetailedRace20651)
    "2066-9" -> Ok(DetailedRace20669)
    "4186-3" -> Ok(DetailedRace41863)
    "2067-7" -> Ok(DetailedRace20677)
    "2068-5" -> Ok(DetailedRace20685)
    "2069-3" -> Ok(DetailedRace20693)
    "2070-1" -> Ok(DetailedRace20701)
    "2071-9" -> Ok(DetailedRace20719)
    "2072-7" -> Ok(DetailedRace20727)
    "2073-5" -> Ok(DetailedRace20735)
    "2074-3" -> Ok(DetailedRace20743)
    "2075-0" -> Ok(DetailedRace20750)
    "2078-4" -> Ok(DetailedRace20784)
    "2079-2" -> Ok(DetailedRace20792)
    "2080-0" -> Ok(DetailedRace20800)
    "2081-8" -> Ok(DetailedRace20818)
    "2082-6" -> Ok(DetailedRace20826)
    "2083-4" -> Ok(DetailedRace20834)
    "2085-9" -> Ok(DetailedRace20859)
    "2086-7" -> Ok(DetailedRace20867)
    "2087-5" -> Ok(DetailedRace20875)
    "2088-3" -> Ok(DetailedRace20883)
    "2089-1" -> Ok(DetailedRace20891)
    "2090-9" -> Ok(DetailedRace20909)
    "2091-7" -> Ok(DetailedRace20917)
    "2092-5" -> Ok(DetailedRace20925)
    "2093-3" -> Ok(DetailedRace20933)
    "2094-1" -> Ok(DetailedRace20941)
    "2095-8" -> Ok(DetailedRace20958)
    "2096-6" -> Ok(DetailedRace20966)
    "2097-4" -> Ok(DetailedRace20974)
    "2098-2" -> Ok(DetailedRace20982)
    "2100-6" -> Ok(DetailedRace21006)
    "2101-4" -> Ok(DetailedRace21014)
    "2102-2" -> Ok(DetailedRace21022)
    "2103-0" -> Ok(DetailedRace21030)
    "2104-8" -> Ok(DetailedRace21048)
    "2500-7" -> Ok(DetailedRace25007)
    "2108-9" -> Ok(DetailedRace21089)
    "2109-7" -> Ok(DetailedRace21097)
    "2110-5" -> Ok(DetailedRace21105)
    "2111-3" -> Ok(DetailedRace21113)
    "2112-1" -> Ok(DetailedRace21121)
    "2113-9" -> Ok(DetailedRace21139)
    "2114-7" -> Ok(DetailedRace21147)
    "2115-4" -> Ok(DetailedRace21154)
    "2116-2" -> Ok(DetailedRace21162)
    "2118-8" -> Ok(DetailedRace21188)
    "2119-6" -> Ok(DetailedRace21196)
    "2120-4" -> Ok(DetailedRace21204)
    "2121-2" -> Ok(DetailedRace21212)
    "2122-0" -> Ok(DetailedRace21220)
    "2123-8" -> Ok(DetailedRace21238)
    "2124-6" -> Ok(DetailedRace21246)
    "2125-3" -> Ok(DetailedRace21253)
    "2126-1" -> Ok(DetailedRace21261)
    "2127-9" -> Ok(DetailedRace21279)
    "2129-5" -> Ok(DetailedRace21295)
    "2131-1" -> Ok(DetailedRace21311)
    "ASKU" -> Ok(DetailedRaceAsku)
    "OTH" -> Ok(DetailedRaceOth)
    "UNK" -> Ok(DetailedRaceUnk)
    _ -> Error(Nil)
  }
}

pub fn detailed_race_decoder() -> Decoder(DetailedRace) {
  use variant <- decode.then(decode.string)
  case detailed_race_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DetailedRace10041,
        "DetailedRace",
        detailed_race,
        detailed_race_to_code,
      )
  }
}

pub fn detailed_race_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "1004-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1006-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1579-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1212-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1045-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1654-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1194-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1195-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1187-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1008-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3012-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1688-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1392-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3015-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3016-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1010-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1016-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1021-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1024-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1026-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1366-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1028-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3024-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3025-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1234-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1265-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1046-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1124-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1033-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3031-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1125-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1060-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3034-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3035-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3036-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1430-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3038-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3039-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1235-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3041-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1417-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1035-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3044-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1126-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1418-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1037-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1611-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3049-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1419-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3051-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1047-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3053-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1041-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3055-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1042-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1054-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1044-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3059-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3060-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1223-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1224-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1076-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1286-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1078-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1420-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1393-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1465-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3069-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3070-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3071-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1082-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1086-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3074-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3075-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3076-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1088-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1089-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3079-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3080-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3081-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1090-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1102-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1106-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3085-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3086-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1109-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3088-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1055-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1114-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1123-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3092-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1153-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1155-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3095-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1162-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1479-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1115-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1165-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1156-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3101-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1725-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1167-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1169-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3105-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1171-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1394-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1116-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3109-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1560-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1707-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1607-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1080-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1173-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1178-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1591-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1262-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1665-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1683-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1180-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1182-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1184-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1186-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3124-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1668-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1189-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3127-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1191-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1207-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1613-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1209-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3132-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1211-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3134-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3135-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3136-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1057-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1466-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1588-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1519-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3141-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1092-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1196-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1197-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3145-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1467-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1580-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1599-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1093-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1239-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1472-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3152-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3153-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1590-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3155-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1250-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1225-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1056-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3159-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1615-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1128-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3162-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1252-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1421-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1422-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1605-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1256-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1729-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3169-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3170-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1260-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1236-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3173-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3174-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1242-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1129-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3177-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1130-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3179-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3180-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1264-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3182-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3183-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3184-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1267-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1481-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3187-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1726-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3189-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1269-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1697-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1083-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1275-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1271-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3195-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3196-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3197-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1727-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1230-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1359-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1279-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1442-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1360-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3204-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1281-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1282-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1283-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1285-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3209-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1313-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3211-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1157-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1013-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1297-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1423-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1395-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1299-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1301-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1468-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1117-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1303-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3222-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1510-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3224-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1198-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1305-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1307-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3228-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1306-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1520-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1309-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1310-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1312-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3234-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3235-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3236-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3237-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1319-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1321-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1222-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1332-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1226-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1132-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1133-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1134-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1135-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1424-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1323-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1136-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3250-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1014-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3252-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1137-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3254-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1425-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1048-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3257-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1426-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1618-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1314-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1199-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1619-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1521-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1331-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1340-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1342-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3267-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1200-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1344-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1348-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1427-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1350-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3273-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1352-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1227-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1728-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3277-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1454-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1681-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3280-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1326-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1354-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1620-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3284-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3285-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1356-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1228-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1015-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3289-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1358-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1361-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1363-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1365-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3294-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1138-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1139-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1368-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1158-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1370-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1428-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1372-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1287-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1374-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1396-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3305-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1376-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1327-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1237-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3309-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1049-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1345-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1159-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1522-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1217-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1238-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1378-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3317-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1380-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3319-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1240-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3321-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1220-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1387-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1241-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1346-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1523-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1389-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1524-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3329-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1022-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1095-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1103-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1429-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1469-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1598-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1482-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3337-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3338-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3339-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3340-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3341-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1403-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1288-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3344-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3345-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1289-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1405-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1409-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1411-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1414-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1416-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1433-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1604-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1333-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1439-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3356-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3357-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1441-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3359-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3360-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1334-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1445-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1446-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1335-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3365-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3366-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1448-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3368-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1453-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1718-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3371-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1456-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3373-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1624-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3375-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1500-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1460-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3378-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3379-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1462-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1443-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1201-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3383-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1243-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3385-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1483-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3387-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1464-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1474-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1476-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1475-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3392-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1328-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1315-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1478-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3396-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1487-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1484-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1625-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1202-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1489-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1490-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1492-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1494-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1495-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1497-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1498-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1499-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1501-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1502-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1503-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1507-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1508-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1509-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1511-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1512-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1515-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1518-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1526-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1431-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1541-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3422-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3423-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1084-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1543-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1219-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3427-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1545-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1141-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1142-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1061-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3432-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3433-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1547-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1733-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3436-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3437-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1627-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1549-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1551-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1553-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1554-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1552-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3444-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1143-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3446-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1556-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1558-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1458-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1527-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1018-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1506-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1432-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3454-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1574-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1229-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1050-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1062-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1163-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3460-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3461-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1629-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3463-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3464-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1528-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1145-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1562-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1470-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3469-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1566-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3471-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3472-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1292-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1573-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1329-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1626-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1576-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1578-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3479-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1100-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3481-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3482-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1582-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1584-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1586-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1602-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1258-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1603-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1609-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3490-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1643-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1529-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1594-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1530-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1531-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1532-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1336-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1146-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3499-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1244-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1023-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1104-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3503-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1632-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1645-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1533-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1144-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1633-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1534-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1535-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1649-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1471-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1434-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1651-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1245-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3516-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1537-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1231-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3519-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1719-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1063-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1397-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3523-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1338-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3525-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1398-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1634-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1112-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1160-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3530-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1193-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1407-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1571-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1203-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3535-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3536-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1204-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1254-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1399-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3540-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3541-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1659-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3543-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1293-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1661-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1017-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1051-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1272-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1205-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1538-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1720-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1246-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3553-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1147-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1294-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1096-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1337-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1663-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1667-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3560-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3561-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1277-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1097-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1118-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3565-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1636-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1539-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1670-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1672-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3570-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1435-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3572-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1247-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1637-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1675-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1119-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1436-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1677-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1679-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1680-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1064-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1685-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3583-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3584-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1639-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1400-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1273-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1148-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1019-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3590-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1692-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1248-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1120-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3594-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1694-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1696-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1698-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1700-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1702-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1121-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3601-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1295-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1709-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1065-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1640-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1641-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1711-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1715-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1731-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1437-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3611-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1717-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1600-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1514-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1722-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1066-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1732-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1516-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1735-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1737-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1739-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1740-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1744-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1741-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1742-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1743-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1745-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3628-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1747-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1748-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1750-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1752-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1751-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1754-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1755-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1757-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1759-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1761-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1762-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1765-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1767-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1768-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1769-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1770-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1771-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1775-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1776-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1777-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1778-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1780-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1779-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1781-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1749-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1753-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1760-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1763-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1764-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1774-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1782-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1791-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1796-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1799-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1801-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1803-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1805-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1807-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1783-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1784-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1785-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1786-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1787-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1788-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1766-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1789-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1790-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1793-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1795-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1794-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1798-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1802-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1804-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1806-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1758-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1772-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1773-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1792-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1797-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1808-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1809-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1825-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1966-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1994-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2008-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4187-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1972-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1973-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1974-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1984-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1986-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1975-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1840-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1976-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1977-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3704-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2014-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1978-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1996-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1979-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1992-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3710-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3711-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1993-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2007-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2011-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2012-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1985-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2013-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1990-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2015-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3720-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1995-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1997-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1987-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2016-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2017-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1999-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1980-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1981-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1988-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1982-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2000-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1969-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2026-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2018-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3735-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2020-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2021-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2022-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2024-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2002-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3741-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1970-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3743-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1998-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3745-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3746-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1849-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1850-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1852-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1909-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3751-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1842-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3753-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1848-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1862-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1863-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3757-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1871-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1845-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1851-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1853-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1854-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1856-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1857-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1860-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1858-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1864-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1865-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1866-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1867-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1868-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1889-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1933-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1872-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1875-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1876-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1877-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1878-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1879-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1880-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1881-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1883-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1884-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1886-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3785-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1873-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1874-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3788-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1882-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1885-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1833-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3861-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1816-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1817-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1818-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1819-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1820-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1821-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1822-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1826-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1827-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1823-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1824-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1830-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1828-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1829-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1811-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1831-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3809-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1832-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1814-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1834-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1835-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1837-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1838-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1896-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1897-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1898-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1963-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1934-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1906-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1907-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3823-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1913-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1916-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3826-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1920-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1929-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1931-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1935-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1900-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1910-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1914-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1915-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1892-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1962-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1918-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3838-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1919-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1922-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1923-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1925-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1928-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1949-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1932-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1936-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1937-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1938-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1942-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1953-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1943-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1946-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1951-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1893-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1952-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1959-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1960-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1924-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1940-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1939-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1941-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1957-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1927-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1904-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1944-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1945-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1947-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1948-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1894-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1955-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1956-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1958-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1961-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1964-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1899-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1902-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1903-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1905-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1908-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1911-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1912-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1921-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1926-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1930-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3885-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1950-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1954-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1901-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3889-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1069-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3891-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3892-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3893-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3894-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3895-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3896-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3897-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3898-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3899-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3900-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3901-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3902-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3903-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3904-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3905-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3906-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3907-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3908-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3909-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3910-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3911-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3912-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3913-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3914-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3915-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3916-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3917-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3918-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3919-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3920-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3921-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3922-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3923-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3924-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3925-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3926-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3927-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3928-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3929-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3930-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3931-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3932-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3933-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3934-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3935-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3936-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3937-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3938-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3939-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3940-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3941-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3942-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3943-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3944-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3945-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3946-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3947-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3948-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3949-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1071-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3951-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3952-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3953-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3954-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3955-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3956-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3957-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3958-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3959-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3960-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3961-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3962-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3963-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3964-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3965-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3966-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3967-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3968-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3969-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3970-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3971-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3972-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3973-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3974-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3975-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3976-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3977-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3978-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3979-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3980-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3981-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3982-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3983-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3984-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3985-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3986-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3987-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3988-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3989-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3990-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3991-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3992-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3993-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3994-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3995-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3996-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3997-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3998-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "3999-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4000-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4001-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4002-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4003-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4004-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4005-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4006-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4007-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4008-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4009-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4010-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4011-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4012-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4013-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4014-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4015-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4016-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4017-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4018-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4019-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4020-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4021-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4022-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4023-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4024-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4025-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4026-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4027-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4028-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4029-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4030-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4031-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4032-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4033-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4034-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4035-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4036-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4037-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4038-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4039-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4040-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4041-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4042-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4043-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4044-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4045-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4046-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4047-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4048-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4049-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4050-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4051-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4052-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4053-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4054-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4055-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4056-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4057-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4058-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4059-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4060-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4061-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4062-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4063-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4064-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4065-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4066-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4067-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4068-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4069-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4070-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4071-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4072-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4073-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4074-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4075-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4076-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4077-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4078-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4079-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4080-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4081-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4082-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4083-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4084-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4085-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1070-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4087-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4088-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4089-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4090-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4091-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4092-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4093-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4094-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4095-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4096-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4097-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4098-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4099-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4100-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4101-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4102-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4103-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4104-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4105-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4106-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4107-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4108-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4109-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4110-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4111-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4112-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4113-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4114-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4115-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4116-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4117-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4118-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4119-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4120-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4121-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4122-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4123-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4124-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4125-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4126-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4127-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4128-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4129-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4130-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4131-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4132-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4133-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4134-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4135-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4136-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4137-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4138-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4139-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4140-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4141-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4142-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4143-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4144-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4145-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4146-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1072-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4148-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1073-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4150-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4151-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4152-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4153-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4154-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4155-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4156-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4157-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4158-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4159-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4160-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4161-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4162-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4163-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4164-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4165-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4166-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4167-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4168-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4169-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4170-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4171-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4172-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4173-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4174-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4175-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4176-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4177-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4178-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4179-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4180-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4181-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "1074-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4183-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4184-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4185-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2029-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2030-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2031-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2032-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2033-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2034-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2035-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2036-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2037-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2038-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2039-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2040-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2041-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2042-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2043-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2044-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2045-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2046-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2047-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2048-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2049-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2050-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2051-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2052-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2056-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2058-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2060-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2061-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2062-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2063-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2064-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2065-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2066-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "4186-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2067-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2068-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2069-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2070-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2071-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2072-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2073-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2074-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2075-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2078-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2079-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2080-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2081-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2082-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2083-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2085-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2086-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2087-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2088-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2089-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2090-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2091-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2092-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2093-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2094-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2095-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2096-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2097-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2098-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2100-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2101-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2102-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2103-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2104-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2500-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2108-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2109-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2110-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2111-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2112-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2113-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2114-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2115-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2116-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2118-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2119-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2120-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2121-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2122-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2123-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2124-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2125-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2126-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2127-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2129-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2131-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    "OTH", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type DocumentreferenceStatus {
  DocumentreferenceStatusCurrent
  DocumentreferenceStatusSuperseded
  DocumentreferenceStatusEnteredinerror
}

pub const documentreference_status: List(DocumentreferenceStatus) = [
  DocumentreferenceStatusCurrent,
  DocumentreferenceStatusSuperseded,
  DocumentreferenceStatusEnteredinerror,
]

pub fn documentreference_status_to_json(
  documentreference_status: DocumentreferenceStatus,
) -> Json {
  json.string(documentreference_status_to_code(documentreference_status))
}

pub fn documentreference_status_to_code(
  documentreference_status: DocumentreferenceStatus,
) -> String {
  case documentreference_status {
    DocumentreferenceStatusCurrent -> "current"
    DocumentreferenceStatusSuperseded -> "superseded"
    DocumentreferenceStatusEnteredinerror -> "entered-in-error"
  }
}

pub fn documentreference_status_parse_code(
  code: String,
) -> Result(DocumentreferenceStatus, Nil) {
  case code {
    "current" -> Ok(DocumentreferenceStatusCurrent)
    "superseded" -> Ok(DocumentreferenceStatusSuperseded)
    "entered-in-error" -> Ok(DocumentreferenceStatusEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn documentreference_status_decoder() -> Decoder(DocumentreferenceStatus) {
  use variant <- decode.then(decode.string)
  case documentreference_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DocumentreferenceStatusCurrent,
        "DocumentreferenceStatus",
        documentreference_status,
        documentreference_status_to_code,
      )
  }
}

pub type DocumentRelationshipType {
  DocumentRelationshipTypeReplaces
  DocumentRelationshipTypeTransforms
  DocumentRelationshipTypeSigns
  DocumentRelationshipTypeAppends
}

pub const document_relationship_type: List(DocumentRelationshipType) = [
  DocumentRelationshipTypeReplaces,
  DocumentRelationshipTypeTransforms,
  DocumentRelationshipTypeSigns,
  DocumentRelationshipTypeAppends,
]

pub fn document_relationship_type_to_json(
  document_relationship_type: DocumentRelationshipType,
) -> Json {
  json.string(document_relationship_type_to_code(document_relationship_type))
}

pub fn document_relationship_type_to_code(
  document_relationship_type: DocumentRelationshipType,
) -> String {
  case document_relationship_type {
    DocumentRelationshipTypeReplaces -> "replaces"
    DocumentRelationshipTypeTransforms -> "transforms"
    DocumentRelationshipTypeSigns -> "signs"
    DocumentRelationshipTypeAppends -> "appends"
  }
}

pub fn document_relationship_type_parse_code(
  code: String,
) -> Result(DocumentRelationshipType, Nil) {
  case code {
    "replaces" -> Ok(DocumentRelationshipTypeReplaces)
    "transforms" -> Ok(DocumentRelationshipTypeTransforms)
    "signs" -> Ok(DocumentRelationshipTypeSigns)
    "appends" -> Ok(DocumentRelationshipTypeAppends)
    _ -> Error(Nil)
  }
}

pub fn document_relationship_type_decoder() -> Decoder(DocumentRelationshipType) {
  use variant <- decode.then(decode.string)
  case document_relationship_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DocumentRelationshipTypeReplaces,
        "DocumentRelationshipType",
        document_relationship_type,
        document_relationship_type_to_code,
      )
  }
}

pub type EncounterLocationStatus {
  EncounterLocationStatusPlanned
  EncounterLocationStatusActive
  EncounterLocationStatusReserved
  EncounterLocationStatusCompleted
}

pub const encounter_location_status: List(EncounterLocationStatus) = [
  EncounterLocationStatusPlanned,
  EncounterLocationStatusActive,
  EncounterLocationStatusReserved,
  EncounterLocationStatusCompleted,
]

pub fn encounter_location_status_to_json(
  encounter_location_status: EncounterLocationStatus,
) -> Json {
  json.string(encounter_location_status_to_code(encounter_location_status))
}

pub fn encounter_location_status_to_code(
  encounter_location_status: EncounterLocationStatus,
) -> String {
  case encounter_location_status {
    EncounterLocationStatusPlanned -> "planned"
    EncounterLocationStatusActive -> "active"
    EncounterLocationStatusReserved -> "reserved"
    EncounterLocationStatusCompleted -> "completed"
  }
}

pub fn encounter_location_status_parse_code(
  code: String,
) -> Result(EncounterLocationStatus, Nil) {
  case code {
    "planned" -> Ok(EncounterLocationStatusPlanned)
    "active" -> Ok(EncounterLocationStatusActive)
    "reserved" -> Ok(EncounterLocationStatusReserved)
    "completed" -> Ok(EncounterLocationStatusCompleted)
    _ -> Error(Nil)
  }
}

pub fn encounter_location_status_decoder() -> Decoder(EncounterLocationStatus) {
  use variant <- decode.then(decode.string)
  case encounter_location_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        EncounterLocationStatusPlanned,
        "EncounterLocationStatus",
        encounter_location_status,
        encounter_location_status_to_code,
      )
  }
}

pub type EncounterStatus {
  EncounterStatusPlanned
  EncounterStatusArrived
  EncounterStatusTriaged
  EncounterStatusInprogress
  EncounterStatusOnleave
  EncounterStatusFinished
  EncounterStatusCancelled
  EncounterStatusEnteredinerror
  EncounterStatusUnknown
}

pub const encounter_status: List(EncounterStatus) = [
  EncounterStatusPlanned,
  EncounterStatusArrived,
  EncounterStatusTriaged,
  EncounterStatusInprogress,
  EncounterStatusOnleave,
  EncounterStatusFinished,
  EncounterStatusCancelled,
  EncounterStatusEnteredinerror,
  EncounterStatusUnknown,
]

pub fn encounter_status_to_json(encounter_status: EncounterStatus) -> Json {
  json.string(encounter_status_to_code(encounter_status))
}

pub fn encounter_status_to_code(encounter_status: EncounterStatus) -> String {
  case encounter_status {
    EncounterStatusPlanned -> "planned"
    EncounterStatusArrived -> "arrived"
    EncounterStatusTriaged -> "triaged"
    EncounterStatusInprogress -> "in-progress"
    EncounterStatusOnleave -> "onleave"
    EncounterStatusFinished -> "finished"
    EncounterStatusCancelled -> "cancelled"
    EncounterStatusEnteredinerror -> "entered-in-error"
    EncounterStatusUnknown -> "unknown"
  }
}

pub fn encounter_status_parse_code(
  code: String,
) -> Result(EncounterStatus, Nil) {
  case code {
    "planned" -> Ok(EncounterStatusPlanned)
    "arrived" -> Ok(EncounterStatusArrived)
    "triaged" -> Ok(EncounterStatusTriaged)
    "in-progress" -> Ok(EncounterStatusInprogress)
    "onleave" -> Ok(EncounterStatusOnleave)
    "finished" -> Ok(EncounterStatusFinished)
    "cancelled" -> Ok(EncounterStatusCancelled)
    "entered-in-error" -> Ok(EncounterStatusEnteredinerror)
    "unknown" -> Ok(EncounterStatusUnknown)
    _ -> Error(Nil)
  }
}

pub fn encounter_status_decoder() -> Decoder(EncounterStatus) {
  use variant <- decode.then(decode.string)
  case encounter_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        EncounterStatusPlanned,
        "EncounterStatus",
        encounter_status,
        encounter_status_to_code,
      )
  }
}

pub type EventTiming {
  EventTimingMorn
  EventTimingMornearly
  EventTimingMornlate
  EventTimingNoon
  EventTimingAft
  EventTimingAftearly
  EventTimingAftlate
  EventTimingEve
  EventTimingEveearly
  EventTimingEvelate
  EventTimingNight
  EventTimingPhs
  EventTimingHs
  EventTimingWake
  EventTimingC
  EventTimingCm
  EventTimingCd
  EventTimingCv
  EventTimingAc
  EventTimingAcm
  EventTimingAcd
  EventTimingAcv
  EventTimingPc
  EventTimingPcm
  EventTimingPcd
  EventTimingPcv
}

pub const event_timing: List(EventTiming) = [
  EventTimingMorn,
  EventTimingMornearly,
  EventTimingMornlate,
  EventTimingNoon,
  EventTimingAft,
  EventTimingAftearly,
  EventTimingAftlate,
  EventTimingEve,
  EventTimingEveearly,
  EventTimingEvelate,
  EventTimingNight,
  EventTimingPhs,
  EventTimingHs,
  EventTimingWake,
  EventTimingC,
  EventTimingCm,
  EventTimingCd,
  EventTimingCv,
  EventTimingAc,
  EventTimingAcm,
  EventTimingAcd,
  EventTimingAcv,
  EventTimingPc,
  EventTimingPcm,
  EventTimingPcd,
  EventTimingPcv,
]

pub fn event_timing_to_json(event_timing: EventTiming) -> Json {
  json.string(event_timing_to_code(event_timing))
}

pub fn event_timing_to_code(event_timing: EventTiming) -> String {
  case event_timing {
    EventTimingMorn -> "MORN"
    EventTimingMornearly -> "MORN.early"
    EventTimingMornlate -> "MORN.late"
    EventTimingNoon -> "NOON"
    EventTimingAft -> "AFT"
    EventTimingAftearly -> "AFT.early"
    EventTimingAftlate -> "AFT.late"
    EventTimingEve -> "EVE"
    EventTimingEveearly -> "EVE.early"
    EventTimingEvelate -> "EVE.late"
    EventTimingNight -> "NIGHT"
    EventTimingPhs -> "PHS"
    EventTimingHs -> "HS"
    EventTimingWake -> "WAKE"
    EventTimingC -> "C"
    EventTimingCm -> "CM"
    EventTimingCd -> "CD"
    EventTimingCv -> "CV"
    EventTimingAc -> "AC"
    EventTimingAcm -> "ACM"
    EventTimingAcd -> "ACD"
    EventTimingAcv -> "ACV"
    EventTimingPc -> "PC"
    EventTimingPcm -> "PCM"
    EventTimingPcd -> "PCD"
    EventTimingPcv -> "PCV"
  }
}

pub fn event_timing_parse_code(code: String) -> Result(EventTiming, Nil) {
  case code {
    "MORN" -> Ok(EventTimingMorn)
    "MORN.early" -> Ok(EventTimingMornearly)
    "MORN.late" -> Ok(EventTimingMornlate)
    "NOON" -> Ok(EventTimingNoon)
    "AFT" -> Ok(EventTimingAft)
    "AFT.early" -> Ok(EventTimingAftearly)
    "AFT.late" -> Ok(EventTimingAftlate)
    "EVE" -> Ok(EventTimingEve)
    "EVE.early" -> Ok(EventTimingEveearly)
    "EVE.late" -> Ok(EventTimingEvelate)
    "NIGHT" -> Ok(EventTimingNight)
    "PHS" -> Ok(EventTimingPhs)
    "HS" -> Ok(EventTimingHs)
    "WAKE" -> Ok(EventTimingWake)
    "C" -> Ok(EventTimingC)
    "CM" -> Ok(EventTimingCm)
    "CD" -> Ok(EventTimingCd)
    "CV" -> Ok(EventTimingCv)
    "AC" -> Ok(EventTimingAc)
    "ACM" -> Ok(EventTimingAcm)
    "ACD" -> Ok(EventTimingAcd)
    "ACV" -> Ok(EventTimingAcv)
    "PC" -> Ok(EventTimingPc)
    "PCM" -> Ok(EventTimingPcm)
    "PCD" -> Ok(EventTimingPcd)
    "PCV" -> Ok(EventTimingPcv)
    _ -> Error(Nil)
  }
}

pub fn event_timing_decoder() -> Decoder(EventTiming) {
  use variant <- decode.then(decode.string)
  case event_timing_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        EventTimingMorn,
        "EventTiming",
        event_timing,
        event_timing_to_code,
      )
  }
}

pub type IdentifierUse {
  IdentifierUseUsual
  IdentifierUseOfficial
  IdentifierUseTemp
  IdentifierUseSecondary
  IdentifierUseOld
}

pub const identifier_use: List(IdentifierUse) = [
  IdentifierUseUsual,
  IdentifierUseOfficial,
  IdentifierUseTemp,
  IdentifierUseSecondary,
  IdentifierUseOld,
]

pub fn identifier_use_to_json(identifier_use: IdentifierUse) -> Json {
  json.string(identifier_use_to_code(identifier_use))
}

pub fn identifier_use_to_code(identifier_use: IdentifierUse) -> String {
  case identifier_use {
    IdentifierUseUsual -> "usual"
    IdentifierUseOfficial -> "official"
    IdentifierUseTemp -> "temp"
    IdentifierUseSecondary -> "secondary"
    IdentifierUseOld -> "old"
  }
}

pub fn identifier_use_parse_code(code: String) -> Result(IdentifierUse, Nil) {
  case code {
    "usual" -> Ok(IdentifierUseUsual)
    "official" -> Ok(IdentifierUseOfficial)
    "temp" -> Ok(IdentifierUseTemp)
    "secondary" -> Ok(IdentifierUseSecondary)
    "old" -> Ok(IdentifierUseOld)
    _ -> Error(Nil)
  }
}

pub fn identifier_use_decoder() -> Decoder(IdentifierUse) {
  use variant <- decode.then(decode.string)
  case identifier_use_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        IdentifierUseUsual,
        "IdentifierUse",
        identifier_use,
        identifier_use_to_code,
      )
  }
}

pub type ImmunizationStatus {
  ImmunizationStatusCompleted
  ImmunizationStatusEnteredinerror
  ImmunizationStatusNotdone
}

pub const immunization_status: List(ImmunizationStatus) = [
  ImmunizationStatusCompleted,
  ImmunizationStatusEnteredinerror,
  ImmunizationStatusNotdone,
]

pub fn immunization_status_to_json(
  immunization_status: ImmunizationStatus,
) -> Json {
  json.string(immunization_status_to_code(immunization_status))
}

pub fn immunization_status_to_code(
  immunization_status: ImmunizationStatus,
) -> String {
  case immunization_status {
    ImmunizationStatusCompleted -> "completed"
    ImmunizationStatusEnteredinerror -> "entered-in-error"
    ImmunizationStatusNotdone -> "not-done"
  }
}

pub fn immunization_status_parse_code(
  code: String,
) -> Result(ImmunizationStatus, Nil) {
  case code {
    "completed" -> Ok(ImmunizationStatusCompleted)
    "entered-in-error" -> Ok(ImmunizationStatusEnteredinerror)
    "not-done" -> Ok(ImmunizationStatusNotdone)
    _ -> Error(Nil)
  }
}

pub fn immunization_status_decoder() -> Decoder(ImmunizationStatus) {
  use variant <- decode.then(decode.string)
  case immunization_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ImmunizationStatusCompleted,
        "ImmunizationStatus",
        immunization_status,
        immunization_status_to_code,
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

pub type LinkType {
  LinkTypeReplacedby
  LinkTypeReplaces
  LinkTypeRefer
  LinkTypeSeealso
}

pub const link_type: List(LinkType) = [
  LinkTypeReplacedby,
  LinkTypeReplaces,
  LinkTypeRefer,
  LinkTypeSeealso,
]

pub fn link_type_to_json(link_type: LinkType) -> Json {
  json.string(link_type_to_code(link_type))
}

pub fn link_type_to_code(link_type: LinkType) -> String {
  case link_type {
    LinkTypeReplacedby -> "replaced-by"
    LinkTypeReplaces -> "replaces"
    LinkTypeRefer -> "refer"
    LinkTypeSeealso -> "seealso"
  }
}

pub fn link_type_parse_code(code: String) -> Result(LinkType, Nil) {
  case code {
    "replaced-by" -> Ok(LinkTypeReplacedby)
    "replaces" -> Ok(LinkTypeReplaces)
    "refer" -> Ok(LinkTypeRefer)
    "seealso" -> Ok(LinkTypeSeealso)
    _ -> Error(Nil)
  }
}

pub fn link_type_decoder() -> Decoder(LinkType) {
  use variant <- decode.then(decode.string)
  case link_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        LinkTypeReplacedby,
        "LinkType",
        link_type,
        link_type_to_code,
      )
  }
}

pub type MedicationrequestCategory {
  MedicationrequestCategoryInpatient
  MedicationrequestCategoryOutpatient
  MedicationrequestCategoryCommunity
  MedicationrequestCategoryDischarge
}

pub const medicationrequest_category: List(MedicationrequestCategory) = [
  MedicationrequestCategoryInpatient,
  MedicationrequestCategoryOutpatient,
  MedicationrequestCategoryCommunity,
  MedicationrequestCategoryDischarge,
]

pub fn medicationrequest_category_to_json(
  medicationrequest_category: MedicationrequestCategory,
) -> Json {
  json.string(medicationrequest_category_to_code(medicationrequest_category))
}

pub fn medicationrequest_category_to_code(
  medicationrequest_category: MedicationrequestCategory,
) -> String {
  case medicationrequest_category {
    MedicationrequestCategoryInpatient -> "inpatient"
    MedicationrequestCategoryOutpatient -> "outpatient"
    MedicationrequestCategoryCommunity -> "community"
    MedicationrequestCategoryDischarge -> "discharge"
  }
}

pub fn medicationrequest_category_parse_code(
  code: String,
) -> Result(MedicationrequestCategory, Nil) {
  case code {
    "inpatient" -> Ok(MedicationrequestCategoryInpatient)
    "outpatient" -> Ok(MedicationrequestCategoryOutpatient)
    "community" -> Ok(MedicationrequestCategoryCommunity)
    "discharge" -> Ok(MedicationrequestCategoryDischarge)
    _ -> Error(Nil)
  }
}

pub fn medicationrequest_category_decoder() -> Decoder(
  MedicationrequestCategory,
) {
  use variant <- decode.then(decode.string)
  case medicationrequest_category_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationrequestCategoryInpatient,
        "MedicationrequestCategory",
        medicationrequest_category,
        medicationrequest_category_to_code,
      )
  }
}

pub fn medicationrequest_category_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "inpatient",
      "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
    -> Ok(Nil)
    "outpatient",
      "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
    -> Ok(Nil)
    "community",
      "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
    -> Ok(Nil)
    "discharge",
      "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
    -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type MedicationrequestIntent {
  MedicationrequestIntentProposal
  MedicationrequestIntentPlan
  MedicationrequestIntentOrder
  MedicationrequestIntentOriginalorder
  MedicationrequestIntentReflexorder
  MedicationrequestIntentFillerorder
  MedicationrequestIntentInstanceorder
  MedicationrequestIntentOption
}

pub const medicationrequest_intent: List(MedicationrequestIntent) = [
  MedicationrequestIntentProposal,
  MedicationrequestIntentPlan,
  MedicationrequestIntentOrder,
  MedicationrequestIntentOriginalorder,
  MedicationrequestIntentReflexorder,
  MedicationrequestIntentFillerorder,
  MedicationrequestIntentInstanceorder,
  MedicationrequestIntentOption,
]

pub fn medicationrequest_intent_to_json(
  medicationrequest_intent: MedicationrequestIntent,
) -> Json {
  json.string(medicationrequest_intent_to_code(medicationrequest_intent))
}

pub fn medicationrequest_intent_to_code(
  medicationrequest_intent: MedicationrequestIntent,
) -> String {
  case medicationrequest_intent {
    MedicationrequestIntentProposal -> "proposal"
    MedicationrequestIntentPlan -> "plan"
    MedicationrequestIntentOrder -> "order"
    MedicationrequestIntentOriginalorder -> "original-order"
    MedicationrequestIntentReflexorder -> "reflex-order"
    MedicationrequestIntentFillerorder -> "filler-order"
    MedicationrequestIntentInstanceorder -> "instance-order"
    MedicationrequestIntentOption -> "option"
  }
}

pub fn medicationrequest_intent_parse_code(
  code: String,
) -> Result(MedicationrequestIntent, Nil) {
  case code {
    "proposal" -> Ok(MedicationrequestIntentProposal)
    "plan" -> Ok(MedicationrequestIntentPlan)
    "order" -> Ok(MedicationrequestIntentOrder)
    "original-order" -> Ok(MedicationrequestIntentOriginalorder)
    "reflex-order" -> Ok(MedicationrequestIntentReflexorder)
    "filler-order" -> Ok(MedicationrequestIntentFillerorder)
    "instance-order" -> Ok(MedicationrequestIntentInstanceorder)
    "option" -> Ok(MedicationrequestIntentOption)
    _ -> Error(Nil)
  }
}

pub fn medicationrequest_intent_decoder() -> Decoder(MedicationrequestIntent) {
  use variant <- decode.then(decode.string)
  case medicationrequest_intent_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationrequestIntentProposal,
        "MedicationrequestIntent",
        medicationrequest_intent,
        medicationrequest_intent_to_code,
      )
  }
}

pub type MedicationrequestStatus {
  MedicationrequestStatusActive
  MedicationrequestStatusOnhold
  MedicationrequestStatusCancelled
  MedicationrequestStatusCompleted
  MedicationrequestStatusEnteredinerror
  MedicationrequestStatusStopped
  MedicationrequestStatusDraft
  MedicationrequestStatusUnknown
}

pub const medicationrequest_status: List(MedicationrequestStatus) = [
  MedicationrequestStatusActive,
  MedicationrequestStatusOnhold,
  MedicationrequestStatusCancelled,
  MedicationrequestStatusCompleted,
  MedicationrequestStatusEnteredinerror,
  MedicationrequestStatusStopped,
  MedicationrequestStatusDraft,
  MedicationrequestStatusUnknown,
]

pub fn medicationrequest_status_to_json(
  medicationrequest_status: MedicationrequestStatus,
) -> Json {
  json.string(medicationrequest_status_to_code(medicationrequest_status))
}

pub fn medicationrequest_status_to_code(
  medicationrequest_status: MedicationrequestStatus,
) -> String {
  case medicationrequest_status {
    MedicationrequestStatusActive -> "active"
    MedicationrequestStatusOnhold -> "on-hold"
    MedicationrequestStatusCancelled -> "cancelled"
    MedicationrequestStatusCompleted -> "completed"
    MedicationrequestStatusEnteredinerror -> "entered-in-error"
    MedicationrequestStatusStopped -> "stopped"
    MedicationrequestStatusDraft -> "draft"
    MedicationrequestStatusUnknown -> "unknown"
  }
}

pub fn medicationrequest_status_parse_code(
  code: String,
) -> Result(MedicationrequestStatus, Nil) {
  case code {
    "active" -> Ok(MedicationrequestStatusActive)
    "on-hold" -> Ok(MedicationrequestStatusOnhold)
    "cancelled" -> Ok(MedicationrequestStatusCancelled)
    "completed" -> Ok(MedicationrequestStatusCompleted)
    "entered-in-error" -> Ok(MedicationrequestStatusEnteredinerror)
    "stopped" -> Ok(MedicationrequestStatusStopped)
    "draft" -> Ok(MedicationrequestStatusDraft)
    "unknown" -> Ok(MedicationrequestStatusUnknown)
    _ -> Error(Nil)
  }
}

pub fn medicationrequest_status_decoder() -> Decoder(MedicationrequestStatus) {
  use variant <- decode.then(decode.string)
  case medicationrequest_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationrequestStatusActive,
        "MedicationrequestStatus",
        medicationrequest_status,
        medicationrequest_status_to_code,
      )
  }
}

pub type MedicationstatementStatus {
  MedicationstatementStatusActive
  MedicationstatementStatusCompleted
  MedicationstatementStatusEnteredinerror
  MedicationstatementStatusIntended
  MedicationstatementStatusStopped
  MedicationstatementStatusOnhold
  MedicationstatementStatusUnknown
  MedicationstatementStatusNottaken
}

pub const medicationstatement_status: List(MedicationstatementStatus) = [
  MedicationstatementStatusActive,
  MedicationstatementStatusCompleted,
  MedicationstatementStatusEnteredinerror,
  MedicationstatementStatusIntended,
  MedicationstatementStatusStopped,
  MedicationstatementStatusOnhold,
  MedicationstatementStatusUnknown,
  MedicationstatementStatusNottaken,
]

pub fn medicationstatement_status_to_json(
  medicationstatement_status: MedicationstatementStatus,
) -> Json {
  json.string(medicationstatement_status_to_code(medicationstatement_status))
}

pub fn medicationstatement_status_to_code(
  medicationstatement_status: MedicationstatementStatus,
) -> String {
  case medicationstatement_status {
    MedicationstatementStatusActive -> "active"
    MedicationstatementStatusCompleted -> "completed"
    MedicationstatementStatusEnteredinerror -> "entered-in-error"
    MedicationstatementStatusIntended -> "intended"
    MedicationstatementStatusStopped -> "stopped"
    MedicationstatementStatusOnhold -> "on-hold"
    MedicationstatementStatusUnknown -> "unknown"
    MedicationstatementStatusNottaken -> "not-taken"
  }
}

pub fn medicationstatement_status_parse_code(
  code: String,
) -> Result(MedicationstatementStatus, Nil) {
  case code {
    "active" -> Ok(MedicationstatementStatusActive)
    "completed" -> Ok(MedicationstatementStatusCompleted)
    "entered-in-error" -> Ok(MedicationstatementStatusEnteredinerror)
    "intended" -> Ok(MedicationstatementStatusIntended)
    "stopped" -> Ok(MedicationstatementStatusStopped)
    "on-hold" -> Ok(MedicationstatementStatusOnhold)
    "unknown" -> Ok(MedicationstatementStatusUnknown)
    "not-taken" -> Ok(MedicationstatementStatusNottaken)
    _ -> Error(Nil)
  }
}

pub fn medicationstatement_status_decoder() -> Decoder(
  MedicationstatementStatus,
) {
  use variant <- decode.then(decode.string)
  case medicationstatement_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationstatementStatusActive,
        "MedicationstatementStatus",
        medicationstatement_status,
        medicationstatement_status_to_code,
      )
  }
}

pub type NameUse {
  NameUseUsual
  NameUseOfficial
  NameUseTemp
  NameUseNickname
  NameUseAnonymous
  NameUseOld
  NameUseMaiden
}

pub const name_use: List(NameUse) = [
  NameUseUsual,
  NameUseOfficial,
  NameUseTemp,
  NameUseNickname,
  NameUseAnonymous,
  NameUseOld,
  NameUseMaiden,
]

pub fn name_use_to_json(name_use: NameUse) -> Json {
  json.string(name_use_to_code(name_use))
}

pub fn name_use_to_code(name_use: NameUse) -> String {
  case name_use {
    NameUseUsual -> "usual"
    NameUseOfficial -> "official"
    NameUseTemp -> "temp"
    NameUseNickname -> "nickname"
    NameUseAnonymous -> "anonymous"
    NameUseOld -> "old"
    NameUseMaiden -> "maiden"
  }
}

pub fn name_use_parse_code(code: String) -> Result(NameUse, Nil) {
  case code {
    "usual" -> Ok(NameUseUsual)
    "official" -> Ok(NameUseOfficial)
    "temp" -> Ok(NameUseTemp)
    "nickname" -> Ok(NameUseNickname)
    "anonymous" -> Ok(NameUseAnonymous)
    "old" -> Ok(NameUseOld)
    "maiden" -> Ok(NameUseMaiden)
    _ -> Error(Nil)
  }
}

pub fn name_use_decoder() -> Decoder(NameUse) {
  use variant <- decode.then(decode.string)
  case name_use_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        NameUseUsual,
        "NameUse",
        name_use,
        name_use_to_code,
      )
  }
}

pub type NarrativeStatus {
  NarrativeStatusGenerated
  NarrativeStatusExtensions
  NarrativeStatusAdditional
  NarrativeStatusEmpty
}

pub const narrative_status: List(NarrativeStatus) = [
  NarrativeStatusGenerated,
  NarrativeStatusExtensions,
  NarrativeStatusAdditional,
  NarrativeStatusEmpty,
]

pub fn narrative_status_to_json(narrative_status: NarrativeStatus) -> Json {
  json.string(narrative_status_to_code(narrative_status))
}

pub fn narrative_status_to_code(narrative_status: NarrativeStatus) -> String {
  case narrative_status {
    NarrativeStatusGenerated -> "generated"
    NarrativeStatusExtensions -> "extensions"
    NarrativeStatusAdditional -> "additional"
    NarrativeStatusEmpty -> "empty"
  }
}

pub fn narrative_status_parse_code(
  code: String,
) -> Result(NarrativeStatus, Nil) {
  case code {
    "generated" -> Ok(NarrativeStatusGenerated)
    "extensions" -> Ok(NarrativeStatusExtensions)
    "additional" -> Ok(NarrativeStatusAdditional)
    "empty" -> Ok(NarrativeStatusEmpty)
    _ -> Error(Nil)
  }
}

pub fn narrative_status_decoder() -> Decoder(NarrativeStatus) {
  use variant <- decode.then(decode.string)
  case narrative_status_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        NarrativeStatusGenerated,
        "NarrativeStatus",
        narrative_status,
        narrative_status_to_code,
      )
  }
}

pub type OmbEthnicityCategory {
  OmbEthnicityCategory21352
  OmbEthnicityCategory21865
  OmbEthnicityCategoryAsku
  OmbEthnicityCategoryUnk
}

pub const omb_ethnicity_category: List(OmbEthnicityCategory) = [
  OmbEthnicityCategory21352,
  OmbEthnicityCategory21865,
  OmbEthnicityCategoryAsku,
  OmbEthnicityCategoryUnk,
]

pub fn omb_ethnicity_category_to_json(
  omb_ethnicity_category: OmbEthnicityCategory,
) -> Json {
  json.string(omb_ethnicity_category_to_code(omb_ethnicity_category))
}

pub fn omb_ethnicity_category_to_code(
  omb_ethnicity_category: OmbEthnicityCategory,
) -> String {
  case omb_ethnicity_category {
    OmbEthnicityCategory21352 -> "2135-2"
    OmbEthnicityCategory21865 -> "2186-5"
    OmbEthnicityCategoryAsku -> "ASKU"
    OmbEthnicityCategoryUnk -> "UNK"
  }
}

pub fn omb_ethnicity_category_parse_code(
  code: String,
) -> Result(OmbEthnicityCategory, Nil) {
  case code {
    "2135-2" -> Ok(OmbEthnicityCategory21352)
    "2186-5" -> Ok(OmbEthnicityCategory21865)
    "ASKU" -> Ok(OmbEthnicityCategoryAsku)
    "UNK" -> Ok(OmbEthnicityCategoryUnk)
    _ -> Error(Nil)
  }
}

pub fn omb_ethnicity_category_decoder() -> Decoder(OmbEthnicityCategory) {
  use variant <- decode.then(decode.string)
  case omb_ethnicity_category_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        OmbEthnicityCategory21352,
        "OmbEthnicityCategory",
        omb_ethnicity_category,
        omb_ethnicity_category_to_code,
      )
  }
}

pub fn omb_ethnicity_category_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "2135-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2186-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type OmbRaceCategory {
  OmbRaceCategory10025
  OmbRaceCategory20289
  OmbRaceCategory20545
  OmbRaceCategory20768
  OmbRaceCategory21063
  OmbRaceCategory21311
  OmbRaceCategoryAsku
  OmbRaceCategoryUnk
}

pub const omb_race_category: List(OmbRaceCategory) = [
  OmbRaceCategory10025,
  OmbRaceCategory20289,
  OmbRaceCategory20545,
  OmbRaceCategory20768,
  OmbRaceCategory21063,
  OmbRaceCategory21311,
  OmbRaceCategoryAsku,
  OmbRaceCategoryUnk,
]

pub fn omb_race_category_to_json(omb_race_category: OmbRaceCategory) -> Json {
  json.string(omb_race_category_to_code(omb_race_category))
}

pub fn omb_race_category_to_code(omb_race_category: OmbRaceCategory) -> String {
  case omb_race_category {
    OmbRaceCategory10025 -> "1002-5"
    OmbRaceCategory20289 -> "2028-9"
    OmbRaceCategory20545 -> "2054-5"
    OmbRaceCategory20768 -> "2076-8"
    OmbRaceCategory21063 -> "2106-3"
    OmbRaceCategory21311 -> "2131-1"
    OmbRaceCategoryAsku -> "ASKU"
    OmbRaceCategoryUnk -> "UNK"
  }
}

pub fn omb_race_category_parse_code(
  code: String,
) -> Result(OmbRaceCategory, Nil) {
  case code {
    "1002-5" -> Ok(OmbRaceCategory10025)
    "2028-9" -> Ok(OmbRaceCategory20289)
    "2054-5" -> Ok(OmbRaceCategory20545)
    "2076-8" -> Ok(OmbRaceCategory20768)
    "2106-3" -> Ok(OmbRaceCategory21063)
    "2131-1" -> Ok(OmbRaceCategory21311)
    "ASKU" -> Ok(OmbRaceCategoryAsku)
    "UNK" -> Ok(OmbRaceCategoryUnk)
    _ -> Error(Nil)
  }
}

pub fn omb_race_category_decoder() -> Decoder(OmbRaceCategory) {
  use variant <- decode.then(decode.string)
  case omb_race_category_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        OmbRaceCategory10025,
        "OmbRaceCategory",
        omb_race_category,
        omb_race_category_to_code,
      )
  }
}

pub fn omb_race_category_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "1002-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2028-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2054-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2076-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2106-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "2131-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Nil)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type Participantrequired {
  ParticipantrequiredRequired
  ParticipantrequiredOptional
  ParticipantrequiredInformationonly
}

pub const participantrequired: List(Participantrequired) = [
  ParticipantrequiredRequired,
  ParticipantrequiredOptional,
  ParticipantrequiredInformationonly,
]

pub fn participantrequired_to_json(
  participantrequired: Participantrequired,
) -> Json {
  json.string(participantrequired_to_code(participantrequired))
}

pub fn participantrequired_to_code(
  participantrequired: Participantrequired,
) -> String {
  case participantrequired {
    ParticipantrequiredRequired -> "required"
    ParticipantrequiredOptional -> "optional"
    ParticipantrequiredInformationonly -> "information-only"
  }
}

pub fn participantrequired_parse_code(
  code: String,
) -> Result(Participantrequired, Nil) {
  case code {
    "required" -> Ok(ParticipantrequiredRequired)
    "optional" -> Ok(ParticipantrequiredOptional)
    "information-only" -> Ok(ParticipantrequiredInformationonly)
    _ -> Error(Nil)
  }
}

pub fn participantrequired_decoder() -> Decoder(Participantrequired) {
  use variant <- decode.then(decode.string)
  case participantrequired_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ParticipantrequiredRequired,
        "Participantrequired",
        participantrequired,
        participantrequired_to_code,
      )
  }
}

pub type Participationstatus {
  ParticipationstatusAccepted
  ParticipationstatusDeclined
  ParticipationstatusTentative
  ParticipationstatusNeedsaction
}

pub const participationstatus: List(Participationstatus) = [
  ParticipationstatusAccepted,
  ParticipationstatusDeclined,
  ParticipationstatusTentative,
  ParticipationstatusNeedsaction,
]

pub fn participationstatus_to_json(
  participationstatus: Participationstatus,
) -> Json {
  json.string(participationstatus_to_code(participationstatus))
}

pub fn participationstatus_to_code(
  participationstatus: Participationstatus,
) -> String {
  case participationstatus {
    ParticipationstatusAccepted -> "accepted"
    ParticipationstatusDeclined -> "declined"
    ParticipationstatusTentative -> "tentative"
    ParticipationstatusNeedsaction -> "needs-action"
  }
}

pub fn participationstatus_parse_code(
  code: String,
) -> Result(Participationstatus, Nil) {
  case code {
    "accepted" -> Ok(ParticipationstatusAccepted)
    "declined" -> Ok(ParticipationstatusDeclined)
    "tentative" -> Ok(ParticipationstatusTentative)
    "needs-action" -> Ok(ParticipationstatusNeedsaction)
    _ -> Error(Nil)
  }
}

pub fn participationstatus_decoder() -> Decoder(Participationstatus) {
  use variant <- decode.then(decode.string)
  case participationstatus_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ParticipationstatusAccepted,
        "Participationstatus",
        participationstatus,
        participationstatus_to_code,
      )
  }
}

pub type QuantityComparator {
  QuantityComparatorLessthan
  QuantityComparatorLessthanequal
  QuantityComparatorGreaterthanequal
  QuantityComparatorGreaterthan
}

pub const quantity_comparator: List(QuantityComparator) = [
  QuantityComparatorLessthan,
  QuantityComparatorLessthanequal,
  QuantityComparatorGreaterthanequal,
  QuantityComparatorGreaterthan,
]

pub fn quantity_comparator_to_json(
  quantity_comparator: QuantityComparator,
) -> Json {
  json.string(quantity_comparator_to_code(quantity_comparator))
}

pub fn quantity_comparator_to_code(
  quantity_comparator: QuantityComparator,
) -> String {
  case quantity_comparator {
    QuantityComparatorLessthan -> "<"
    QuantityComparatorLessthanequal -> "<="
    QuantityComparatorGreaterthanequal -> ">="
    QuantityComparatorGreaterthan -> ">"
  }
}

pub fn quantity_comparator_parse_code(
  code: String,
) -> Result(QuantityComparator, Nil) {
  case code {
    "<" -> Ok(QuantityComparatorLessthan)
    "<=" -> Ok(QuantityComparatorLessthanequal)
    ">=" -> Ok(QuantityComparatorGreaterthanequal)
    ">" -> Ok(QuantityComparatorGreaterthan)
    _ -> Error(Nil)
  }
}

pub fn quantity_comparator_decoder() -> Decoder(QuantityComparator) {
  use variant <- decode.then(decode.string)
  case quantity_comparator_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        QuantityComparatorLessthan,
        "QuantityComparator",
        quantity_comparator,
        quantity_comparator_to_code,
      )
  }
}

pub type ReactionEventSeverity {
  ReactionEventSeverityMild
  ReactionEventSeverityModerate
  ReactionEventSeveritySevere
}

pub const reaction_event_severity: List(ReactionEventSeverity) = [
  ReactionEventSeverityMild,
  ReactionEventSeverityModerate,
  ReactionEventSeveritySevere,
]

pub fn reaction_event_severity_to_json(
  reaction_event_severity: ReactionEventSeverity,
) -> Json {
  json.string(reaction_event_severity_to_code(reaction_event_severity))
}

pub fn reaction_event_severity_to_code(
  reaction_event_severity: ReactionEventSeverity,
) -> String {
  case reaction_event_severity {
    ReactionEventSeverityMild -> "mild"
    ReactionEventSeverityModerate -> "moderate"
    ReactionEventSeveritySevere -> "severe"
  }
}

pub fn reaction_event_severity_parse_code(
  code: String,
) -> Result(ReactionEventSeverity, Nil) {
  case code {
    "mild" -> Ok(ReactionEventSeverityMild)
    "moderate" -> Ok(ReactionEventSeverityModerate)
    "severe" -> Ok(ReactionEventSeveritySevere)
    _ -> Error(Nil)
  }
}

pub fn reaction_event_severity_decoder() -> Decoder(ReactionEventSeverity) {
  use variant <- decode.then(decode.string)
  case reaction_event_severity_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ReactionEventSeverityMild,
        "ReactionEventSeverity",
        reaction_event_severity,
        reaction_event_severity_to_code,
      )
  }
}

pub type RequestPriority {
  RequestPriorityRoutine
  RequestPriorityUrgent
  RequestPriorityAsap
  RequestPriorityStat
}

pub const request_priority: List(RequestPriority) = [
  RequestPriorityRoutine,
  RequestPriorityUrgent,
  RequestPriorityAsap,
  RequestPriorityStat,
]

pub fn request_priority_to_json(request_priority: RequestPriority) -> Json {
  json.string(request_priority_to_code(request_priority))
}

pub fn request_priority_to_code(request_priority: RequestPriority) -> String {
  case request_priority {
    RequestPriorityRoutine -> "routine"
    RequestPriorityUrgent -> "urgent"
    RequestPriorityAsap -> "asap"
    RequestPriorityStat -> "stat"
  }
}

pub fn request_priority_parse_code(
  code: String,
) -> Result(RequestPriority, Nil) {
  case code {
    "routine" -> Ok(RequestPriorityRoutine)
    "urgent" -> Ok(RequestPriorityUrgent)
    "asap" -> Ok(RequestPriorityAsap)
    "stat" -> Ok(RequestPriorityStat)
    _ -> Error(Nil)
  }
}

pub fn request_priority_decoder() -> Decoder(RequestPriority) {
  use variant <- decode.then(decode.string)
  case request_priority_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        RequestPriorityRoutine,
        "RequestPriority",
        request_priority,
        request_priority_to_code,
      )
  }
}

pub type Two16840111376214102124 {
  Two16840111376214102124Asku
  Two16840111376214102124F
  Two16840111376214102124M
  Two16840111376214102124Oth
  Two16840111376214102124Unk
  Two16840111376214102124Askeddeclined
}

pub const two16840111376214102124: List(Two16840111376214102124) = [
  Two16840111376214102124Asku,
  Two16840111376214102124F,
  Two16840111376214102124M,
  Two16840111376214102124Oth,
  Two16840111376214102124Unk,
  Two16840111376214102124Askeddeclined,
]

pub fn two16840111376214102124_to_json(
  two16840111376214102124: Two16840111376214102124,
) -> Json {
  json.string(two16840111376214102124_to_code(two16840111376214102124))
}

pub fn two16840111376214102124_to_code(
  two16840111376214102124: Two16840111376214102124,
) -> String {
  case two16840111376214102124 {
    Two16840111376214102124Asku -> "ASKU"
    Two16840111376214102124F -> "F"
    Two16840111376214102124M -> "M"
    Two16840111376214102124Oth -> "OTH"
    Two16840111376214102124Unk -> "UNK"
    Two16840111376214102124Askeddeclined -> "asked-declined"
  }
}

pub fn two16840111376214102124_parse_code(
  code: String,
) -> Result(Two16840111376214102124, Nil) {
  case code {
    "ASKU" -> Ok(Two16840111376214102124Asku)
    "F" -> Ok(Two16840111376214102124F)
    "M" -> Ok(Two16840111376214102124M)
    "OTH" -> Ok(Two16840111376214102124Oth)
    "UNK" -> Ok(Two16840111376214102124Unk)
    "asked-declined" -> Ok(Two16840111376214102124Askeddeclined)
    _ -> Error(Nil)
  }
}

pub fn two16840111376214102124_decoder() -> Decoder(Two16840111376214102124) {
  use variant <- decode.then(decode.string)
  case two16840111376214102124_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        Two16840111376214102124Asku,
        "Two16840111376214102124",
        two16840111376214102124,
        two16840111376214102124_to_code,
      )
  }
}

pub type UnitsOfTime {
  UnitsOfTimeS
  UnitsOfTimeMin
  UnitsOfTimeH
  UnitsOfTimeD
  UnitsOfTimeWk
  UnitsOfTimeMo
  UnitsOfTimeA
}

pub const units_of_time: List(UnitsOfTime) = [
  UnitsOfTimeS,
  UnitsOfTimeMin,
  UnitsOfTimeH,
  UnitsOfTimeD,
  UnitsOfTimeWk,
  UnitsOfTimeMo,
  UnitsOfTimeA,
]

pub fn units_of_time_to_json(units_of_time: UnitsOfTime) -> Json {
  json.string(units_of_time_to_code(units_of_time))
}

pub fn units_of_time_to_code(units_of_time: UnitsOfTime) -> String {
  case units_of_time {
    UnitsOfTimeS -> "s"
    UnitsOfTimeMin -> "min"
    UnitsOfTimeH -> "h"
    UnitsOfTimeD -> "d"
    UnitsOfTimeWk -> "wk"
    UnitsOfTimeMo -> "mo"
    UnitsOfTimeA -> "a"
  }
}

pub fn units_of_time_parse_code(code: String) -> Result(UnitsOfTime, Nil) {
  case code {
    "s" -> Ok(UnitsOfTimeS)
    "min" -> Ok(UnitsOfTimeMin)
    "h" -> Ok(UnitsOfTimeH)
    "d" -> Ok(UnitsOfTimeD)
    "wk" -> Ok(UnitsOfTimeWk)
    "mo" -> Ok(UnitsOfTimeMo)
    "a" -> Ok(UnitsOfTimeA)
    _ -> Error(Nil)
  }
}

pub fn units_of_time_decoder() -> Decoder(UnitsOfTime) {
  use variant <- decode.then(decode.string)
  case units_of_time_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UnitsOfTimeS,
        "UnitsOfTime",
        units_of_time,
        units_of_time_to_code,
      )
  }
}

pub type UsCoreDocumentreferenceCategory {
  UsCoreDocumentreferenceCategoryClinicalnote
}

pub const us_core_documentreference_category: List(
  UsCoreDocumentreferenceCategory,
) = [UsCoreDocumentreferenceCategoryClinicalnote]

pub fn us_core_documentreference_category_to_json(
  us_core_documentreference_category: UsCoreDocumentreferenceCategory,
) -> Json {
  json.string(us_core_documentreference_category_to_code(
    us_core_documentreference_category,
  ))
}

pub fn us_core_documentreference_category_to_code(
  us_core_documentreference_category: UsCoreDocumentreferenceCategory,
) -> String {
  case us_core_documentreference_category {
    UsCoreDocumentreferenceCategoryClinicalnote -> "clinical-note"
  }
}

pub fn us_core_documentreference_category_parse_code(
  code: String,
) -> Result(UsCoreDocumentreferenceCategory, Nil) {
  case code {
    "clinical-note" -> Ok(UsCoreDocumentreferenceCategoryClinicalnote)
    _ -> Error(Nil)
  }
}

pub fn us_core_documentreference_category_decoder() -> Decoder(
  UsCoreDocumentreferenceCategory,
) {
  use variant <- decode.then(decode.string)
  case us_core_documentreference_category_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UsCoreDocumentreferenceCategoryClinicalnote,
        "UsCoreDocumentreferenceCategory",
        us_core_documentreference_category,
        us_core_documentreference_category_to_code,
      )
  }
}

pub fn us_core_documentreference_category_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "clinical-note",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-documentreference-category"
    -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type UsCoreProblemOrHealthConcern {
  UsCoreProblemOrHealthConcernProblemlistitem
  UsCoreProblemOrHealthConcernHealthconcern
}

pub const us_core_problem_or_health_concern: List(UsCoreProblemOrHealthConcern) = [
  UsCoreProblemOrHealthConcernProblemlistitem,
  UsCoreProblemOrHealthConcernHealthconcern,
]

pub fn us_core_problem_or_health_concern_to_json(
  us_core_problem_or_health_concern: UsCoreProblemOrHealthConcern,
) -> Json {
  json.string(us_core_problem_or_health_concern_to_code(
    us_core_problem_or_health_concern,
  ))
}

pub fn us_core_problem_or_health_concern_to_code(
  us_core_problem_or_health_concern: UsCoreProblemOrHealthConcern,
) -> String {
  case us_core_problem_or_health_concern {
    UsCoreProblemOrHealthConcernProblemlistitem -> "problem-list-item"
    UsCoreProblemOrHealthConcernHealthconcern -> "health-concern"
  }
}

pub fn us_core_problem_or_health_concern_parse_code(
  code: String,
) -> Result(UsCoreProblemOrHealthConcern, Nil) {
  case code {
    "problem-list-item" -> Ok(UsCoreProblemOrHealthConcernProblemlistitem)
    "health-concern" -> Ok(UsCoreProblemOrHealthConcernHealthconcern)
    _ -> Error(Nil)
  }
}

pub fn us_core_problem_or_health_concern_decoder() -> Decoder(
  UsCoreProblemOrHealthConcern,
) {
  use variant <- decode.then(decode.string)
  case us_core_problem_or_health_concern_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UsCoreProblemOrHealthConcernProblemlistitem,
        "UsCoreProblemOrHealthConcern",
        us_core_problem_or_health_concern,
        us_core_problem_or_health_concern_to_code,
      )
  }
}

pub fn us_core_problem_or_health_concern_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "problem-list-item",
      "http://terminology.hl7.org/CodeSystem/condition-category"
    -> Ok(Nil)
    "health-concern",
      "http://hl7.org/fhir/us/core/CodeSystem/condition-category"
    -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}

pub type UsCoreScreeningAssessmentConditionCategory {
  UsCoreScreeningAssessmentConditionCategorySdoh
  UsCoreScreeningAssessmentConditionCategoryFunctionalstatus
  UsCoreScreeningAssessmentConditionCategoryDisabilitystatus
  UsCoreScreeningAssessmentConditionCategoryCognitivestatus
  UsCoreScreeningAssessmentConditionCategoryTreatmentinterventionpreference
  UsCoreScreeningAssessmentConditionCategoryCareexperiencepreference
  UsCoreScreeningAssessmentConditionCategoryObservationadidocumentation
  UsCoreScreeningAssessmentConditionCategoryPmo
}

pub const us_core_screening_assessment_condition_category: List(
  UsCoreScreeningAssessmentConditionCategory,
) = [
  UsCoreScreeningAssessmentConditionCategorySdoh,
  UsCoreScreeningAssessmentConditionCategoryFunctionalstatus,
  UsCoreScreeningAssessmentConditionCategoryDisabilitystatus,
  UsCoreScreeningAssessmentConditionCategoryCognitivestatus,
  UsCoreScreeningAssessmentConditionCategoryTreatmentinterventionpreference,
  UsCoreScreeningAssessmentConditionCategoryCareexperiencepreference,
  UsCoreScreeningAssessmentConditionCategoryObservationadidocumentation,
  UsCoreScreeningAssessmentConditionCategoryPmo,
]

pub fn us_core_screening_assessment_condition_category_to_json(
  us_core_screening_assessment_condition_category: UsCoreScreeningAssessmentConditionCategory,
) -> Json {
  json.string(us_core_screening_assessment_condition_category_to_code(
    us_core_screening_assessment_condition_category,
  ))
}

pub fn us_core_screening_assessment_condition_category_to_code(
  us_core_screening_assessment_condition_category: UsCoreScreeningAssessmentConditionCategory,
) -> String {
  case us_core_screening_assessment_condition_category {
    UsCoreScreeningAssessmentConditionCategorySdoh -> "sdoh"
    UsCoreScreeningAssessmentConditionCategoryFunctionalstatus ->
      "functional-status"
    UsCoreScreeningAssessmentConditionCategoryDisabilitystatus ->
      "disability-status"
    UsCoreScreeningAssessmentConditionCategoryCognitivestatus ->
      "cognitive-status"
    UsCoreScreeningAssessmentConditionCategoryTreatmentinterventionpreference ->
      "treatment-intervention-preference"
    UsCoreScreeningAssessmentConditionCategoryCareexperiencepreference ->
      "care-experience-preference"
    UsCoreScreeningAssessmentConditionCategoryObservationadidocumentation ->
      "observation-adi-documentation"
    UsCoreScreeningAssessmentConditionCategoryPmo -> "PMO"
  }
}

pub fn us_core_screening_assessment_condition_category_parse_code(
  code: String,
) -> Result(UsCoreScreeningAssessmentConditionCategory, Nil) {
  case code {
    "sdoh" -> Ok(UsCoreScreeningAssessmentConditionCategorySdoh)
    "functional-status" ->
      Ok(UsCoreScreeningAssessmentConditionCategoryFunctionalstatus)
    "disability-status" ->
      Ok(UsCoreScreeningAssessmentConditionCategoryDisabilitystatus)
    "cognitive-status" ->
      Ok(UsCoreScreeningAssessmentConditionCategoryCognitivestatus)
    "treatment-intervention-preference" ->
      Ok(
        UsCoreScreeningAssessmentConditionCategoryTreatmentinterventionpreference,
      )
    "care-experience-preference" ->
      Ok(UsCoreScreeningAssessmentConditionCategoryCareexperiencepreference)
    "observation-adi-documentation" ->
      Ok(UsCoreScreeningAssessmentConditionCategoryObservationadidocumentation)
    "PMO" -> Ok(UsCoreScreeningAssessmentConditionCategoryPmo)
    _ -> Error(Nil)
  }
}

pub fn us_core_screening_assessment_condition_category_decoder() -> Decoder(
  UsCoreScreeningAssessmentConditionCategory,
) {
  use variant <- decode.then(decode.string)
  case us_core_screening_assessment_condition_category_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UsCoreScreeningAssessmentConditionCategorySdoh,
        "UsCoreScreeningAssessmentConditionCategory",
        us_core_screening_assessment_condition_category,
        us_core_screening_assessment_condition_category_to_code,
      )
  }
}

pub fn us_core_screening_assessment_condition_category_parse_code_and_system(
  code code: String,
  system system: String,
) -> Result(Nil, Nil) {
  case code, system {
    "sdoh", "http://hl7.org/fhir/us/core/CodeSystem/us-core-category" -> Ok(Nil)
    "functional-status",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-category"
    -> Ok(Nil)
    "disability-status",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-category"
    -> Ok(Nil)
    "cognitive-status",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-category"
    -> Ok(Nil)
    "treatment-intervention-preference",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-category"
    -> Ok(Nil)
    "care-experience-preference",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-category"
    -> Ok(Nil)
    "observation-adi-documentation",
      "http://hl7.org/fhir/us/core/CodeSystem/us-core-category"
    -> Ok(Nil)
    "PMO", "http://hl7.org/fhir/us/core/CodeSystem/us-core-category" -> Ok(Nil)
    _, _ -> Error(Nil)
  }
}
