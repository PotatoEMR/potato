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

pub type Addresstype {
  AddresstypePostal
  AddresstypePhysical
  AddresstypeBoth
}

pub const addresstype: List(Addresstype) = [
  AddresstypePostal,
  AddresstypePhysical,
  AddresstypeBoth,
]

pub fn addresstype_to_json(addresstype: Addresstype) -> Json {
  json.string(addresstype_to_code(addresstype))
}

pub fn addresstype_to_code(addresstype: Addresstype) -> String {
  case addresstype {
    AddresstypePostal -> "postal"
    AddresstypePhysical -> "physical"
    AddresstypeBoth -> "both"
  }
}

pub fn addresstype_from_code(code: String) -> Result(Addresstype, Nil) {
  case code {
    "postal" -> Ok(AddresstypePostal)
    "physical" -> Ok(AddresstypePhysical)
    "both" -> Ok(AddresstypeBoth)
    _ -> Error(Nil)
  }
}

pub fn addresstype_decoder() -> Decoder(Addresstype) {
  use variant <- decode.then(decode.string)
  case addresstype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AddresstypePostal,
        "Addresstype",
        addresstype,
        addresstype_to_code,
      )
  }
}

pub type Addressuse {
  AddressuseHome
  AddressuseWork
  AddressuseTemp
  AddressuseOld
  AddressuseBilling
}

pub const addressuse: List(Addressuse) = [
  AddressuseHome,
  AddressuseWork,
  AddressuseTemp,
  AddressuseOld,
  AddressuseBilling,
]

pub fn addressuse_to_json(addressuse: Addressuse) -> Json {
  json.string(addressuse_to_code(addressuse))
}

pub fn addressuse_to_code(addressuse: Addressuse) -> String {
  case addressuse {
    AddressuseHome -> "home"
    AddressuseWork -> "work"
    AddressuseTemp -> "temp"
    AddressuseOld -> "old"
    AddressuseBilling -> "billing"
  }
}

pub fn addressuse_from_code(code: String) -> Result(Addressuse, Nil) {
  case code {
    "home" -> Ok(AddressuseHome)
    "work" -> Ok(AddressuseWork)
    "temp" -> Ok(AddressuseTemp)
    "old" -> Ok(AddressuseOld)
    "billing" -> Ok(AddressuseBilling)
    _ -> Error(Nil)
  }
}

pub fn addressuse_decoder() -> Decoder(Addressuse) {
  use variant <- decode.then(decode.string)
  case addressuse_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AddressuseHome,
        "Addressuse",
        addressuse,
        addressuse_to_code,
      )
  }
}

pub type Administrativegender {
  AdministrativegenderMale
  AdministrativegenderFemale
  AdministrativegenderOther
  AdministrativegenderUnknown
}

pub const administrativegender: List(Administrativegender) = [
  AdministrativegenderMale,
  AdministrativegenderFemale,
  AdministrativegenderOther,
  AdministrativegenderUnknown,
]

pub fn administrativegender_to_json(
  administrativegender: Administrativegender,
) -> Json {
  json.string(administrativegender_to_code(administrativegender))
}

pub fn administrativegender_to_code(
  administrativegender: Administrativegender,
) -> String {
  case administrativegender {
    AdministrativegenderMale -> "male"
    AdministrativegenderFemale -> "female"
    AdministrativegenderOther -> "other"
    AdministrativegenderUnknown -> "unknown"
  }
}

pub fn administrativegender_from_code(
  code: String,
) -> Result(Administrativegender, Nil) {
  case code {
    "male" -> Ok(AdministrativegenderMale)
    "female" -> Ok(AdministrativegenderFemale)
    "other" -> Ok(AdministrativegenderOther)
    "unknown" -> Ok(AdministrativegenderUnknown)
    _ -> Error(Nil)
  }
}

pub fn administrativegender_decoder() -> Decoder(Administrativegender) {
  use variant <- decode.then(decode.string)
  case administrativegender_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AdministrativegenderMale,
        "Administrativegender",
        administrativegender,
        administrativegender_to_code,
      )
  }
}

pub type Allergyintolerancecategory {
  AllergyintolerancecategoryFood
  AllergyintolerancecategoryMedication
  AllergyintolerancecategoryEnvironment
  AllergyintolerancecategoryBiologic
}

pub const allergyintolerancecategory: List(Allergyintolerancecategory) = [
  AllergyintolerancecategoryFood,
  AllergyintolerancecategoryMedication,
  AllergyintolerancecategoryEnvironment,
  AllergyintolerancecategoryBiologic,
]

pub fn allergyintolerancecategory_to_json(
  allergyintolerancecategory: Allergyintolerancecategory,
) -> Json {
  json.string(allergyintolerancecategory_to_code(allergyintolerancecategory))
}

pub fn allergyintolerancecategory_to_code(
  allergyintolerancecategory: Allergyintolerancecategory,
) -> String {
  case allergyintolerancecategory {
    AllergyintolerancecategoryFood -> "food"
    AllergyintolerancecategoryMedication -> "medication"
    AllergyintolerancecategoryEnvironment -> "environment"
    AllergyintolerancecategoryBiologic -> "biologic"
  }
}

pub fn allergyintolerancecategory_from_code(
  code: String,
) -> Result(Allergyintolerancecategory, Nil) {
  case code {
    "food" -> Ok(AllergyintolerancecategoryFood)
    "medication" -> Ok(AllergyintolerancecategoryMedication)
    "environment" -> Ok(AllergyintolerancecategoryEnvironment)
    "biologic" -> Ok(AllergyintolerancecategoryBiologic)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerancecategory_decoder() -> Decoder(
  Allergyintolerancecategory,
) {
  use variant <- decode.then(decode.string)
  case allergyintolerancecategory_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintolerancecategoryFood,
        "Allergyintolerancecategory",
        allergyintolerancecategory,
        allergyintolerancecategory_to_code,
      )
  }
}

pub type Allergyintoleranceclinical {
  AllergyintoleranceclinicalActive
  AllergyintoleranceclinicalInactive
  AllergyintoleranceclinicalResolved
}

pub const allergyintoleranceclinical: List(Allergyintoleranceclinical) = [
  AllergyintoleranceclinicalActive,
  AllergyintoleranceclinicalInactive,
  AllergyintoleranceclinicalResolved,
]

pub fn allergyintoleranceclinical_to_json(
  allergyintoleranceclinical: Allergyintoleranceclinical,
) -> Json {
  json.string(allergyintoleranceclinical_to_code(allergyintoleranceclinical))
}

pub fn allergyintoleranceclinical_to_code(
  allergyintoleranceclinical: Allergyintoleranceclinical,
) -> String {
  case allergyintoleranceclinical {
    AllergyintoleranceclinicalActive -> "active"
    AllergyintoleranceclinicalInactive -> "inactive"
    AllergyintoleranceclinicalResolved -> "resolved"
  }
}

pub fn allergyintoleranceclinical_from_code(
  code: String,
) -> Result(Allergyintoleranceclinical, Nil) {
  case code {
    "active" -> Ok(AllergyintoleranceclinicalActive)
    "inactive" -> Ok(AllergyintoleranceclinicalInactive)
    "resolved" -> Ok(AllergyintoleranceclinicalResolved)
    _ -> Error(Nil)
  }
}

pub fn allergyintoleranceclinical_decoder() -> Decoder(
  Allergyintoleranceclinical,
) {
  use variant <- decode.then(decode.string)
  case allergyintoleranceclinical_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceclinicalActive,
        "Allergyintoleranceclinical",
        allergyintoleranceclinical,
        allergyintoleranceclinical_to_code,
      )
  }
}

pub fn allergyintoleranceclinical_from_code_and_system(
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

pub type Allergyintolerancecriticality {
  AllergyintolerancecriticalityLow
  AllergyintolerancecriticalityHigh
  AllergyintolerancecriticalityUnabletoassess
}

pub const allergyintolerancecriticality: List(Allergyintolerancecriticality) = [
  AllergyintolerancecriticalityLow,
  AllergyintolerancecriticalityHigh,
  AllergyintolerancecriticalityUnabletoassess,
]

pub fn allergyintolerancecriticality_to_json(
  allergyintolerancecriticality: Allergyintolerancecriticality,
) -> Json {
  json.string(allergyintolerancecriticality_to_code(
    allergyintolerancecriticality,
  ))
}

pub fn allergyintolerancecriticality_to_code(
  allergyintolerancecriticality: Allergyintolerancecriticality,
) -> String {
  case allergyintolerancecriticality {
    AllergyintolerancecriticalityLow -> "low"
    AllergyintolerancecriticalityHigh -> "high"
    AllergyintolerancecriticalityUnabletoassess -> "unable-to-assess"
  }
}

pub fn allergyintolerancecriticality_from_code(
  code: String,
) -> Result(Allergyintolerancecriticality, Nil) {
  case code {
    "low" -> Ok(AllergyintolerancecriticalityLow)
    "high" -> Ok(AllergyintolerancecriticalityHigh)
    "unable-to-assess" -> Ok(AllergyintolerancecriticalityUnabletoassess)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerancecriticality_decoder() -> Decoder(
  Allergyintolerancecriticality,
) {
  use variant <- decode.then(decode.string)
  case allergyintolerancecriticality_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintolerancecriticalityLow,
        "Allergyintolerancecriticality",
        allergyintolerancecriticality,
        allergyintolerancecriticality_to_code,
      )
  }
}

pub type Allergyintolerancetype {
  AllergyintolerancetypeAllergy
  AllergyintolerancetypeIntolerance
}

pub const allergyintolerancetype: List(Allergyintolerancetype) = [
  AllergyintolerancetypeAllergy,
  AllergyintolerancetypeIntolerance,
]

pub fn allergyintolerancetype_to_json(
  allergyintolerancetype: Allergyintolerancetype,
) -> Json {
  json.string(allergyintolerancetype_to_code(allergyintolerancetype))
}

pub fn allergyintolerancetype_to_code(
  allergyintolerancetype: Allergyintolerancetype,
) -> String {
  case allergyintolerancetype {
    AllergyintolerancetypeAllergy -> "allergy"
    AllergyintolerancetypeIntolerance -> "intolerance"
  }
}

pub fn allergyintolerancetype_from_code(
  code: String,
) -> Result(Allergyintolerancetype, Nil) {
  case code {
    "allergy" -> Ok(AllergyintolerancetypeAllergy)
    "intolerance" -> Ok(AllergyintolerancetypeIntolerance)
    _ -> Error(Nil)
  }
}

pub fn allergyintolerancetype_decoder() -> Decoder(Allergyintolerancetype) {
  use variant <- decode.then(decode.string)
  case allergyintolerancetype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintolerancetypeAllergy,
        "Allergyintolerancetype",
        allergyintolerancetype,
        allergyintolerancetype_to_code,
      )
  }
}

pub type Allergyintoleranceverification {
  AllergyintoleranceverificationUnconfirmed
  AllergyintoleranceverificationPresumed
  AllergyintoleranceverificationConfirmed
  AllergyintoleranceverificationRefuted
  AllergyintoleranceverificationEnteredinerror
}

pub const allergyintoleranceverification: List(Allergyintoleranceverification) = [
  AllergyintoleranceverificationUnconfirmed,
  AllergyintoleranceverificationPresumed,
  AllergyintoleranceverificationConfirmed,
  AllergyintoleranceverificationRefuted,
  AllergyintoleranceverificationEnteredinerror,
]

pub fn allergyintoleranceverification_to_json(
  allergyintoleranceverification: Allergyintoleranceverification,
) -> Json {
  json.string(allergyintoleranceverification_to_code(
    allergyintoleranceverification,
  ))
}

pub fn allergyintoleranceverification_to_code(
  allergyintoleranceverification: Allergyintoleranceverification,
) -> String {
  case allergyintoleranceverification {
    AllergyintoleranceverificationUnconfirmed -> "unconfirmed"
    AllergyintoleranceverificationPresumed -> "presumed"
    AllergyintoleranceverificationConfirmed -> "confirmed"
    AllergyintoleranceverificationRefuted -> "refuted"
    AllergyintoleranceverificationEnteredinerror -> "entered-in-error"
  }
}

pub fn allergyintoleranceverification_from_code(
  code: String,
) -> Result(Allergyintoleranceverification, Nil) {
  case code {
    "unconfirmed" -> Ok(AllergyintoleranceverificationUnconfirmed)
    "presumed" -> Ok(AllergyintoleranceverificationPresumed)
    "confirmed" -> Ok(AllergyintoleranceverificationConfirmed)
    "refuted" -> Ok(AllergyintoleranceverificationRefuted)
    "entered-in-error" -> Ok(AllergyintoleranceverificationEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn allergyintoleranceverification_decoder() -> Decoder(
  Allergyintoleranceverification,
) {
  use variant <- decode.then(decode.string)
  case allergyintoleranceverification_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllergyintoleranceverificationUnconfirmed,
        "Allergyintoleranceverification",
        allergyintoleranceverification,
        allergyintoleranceverification_to_code,
      )
  }
}

pub fn allergyintoleranceverification_from_code_and_system(
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

pub fn appointmentstatus_from_code(
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
  case appointmentstatus_from_code(variant) {
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

pub type Compositionstatus {
  CompositionstatusPreliminary
  CompositionstatusFinal
  CompositionstatusAmended
  CompositionstatusEnteredinerror
}

pub const compositionstatus: List(Compositionstatus) = [
  CompositionstatusPreliminary,
  CompositionstatusFinal,
  CompositionstatusAmended,
  CompositionstatusEnteredinerror,
]

pub fn compositionstatus_to_json(compositionstatus: Compositionstatus) -> Json {
  json.string(compositionstatus_to_code(compositionstatus))
}

pub fn compositionstatus_to_code(
  compositionstatus: Compositionstatus,
) -> String {
  case compositionstatus {
    CompositionstatusPreliminary -> "preliminary"
    CompositionstatusFinal -> "final"
    CompositionstatusAmended -> "amended"
    CompositionstatusEnteredinerror -> "entered-in-error"
  }
}

pub fn compositionstatus_from_code(
  code: String,
) -> Result(Compositionstatus, Nil) {
  case code {
    "preliminary" -> Ok(CompositionstatusPreliminary)
    "final" -> Ok(CompositionstatusFinal)
    "amended" -> Ok(CompositionstatusAmended)
    "entered-in-error" -> Ok(CompositionstatusEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn compositionstatus_decoder() -> Decoder(Compositionstatus) {
  use variant <- decode.then(decode.string)
  case compositionstatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        CompositionstatusPreliminary,
        "Compositionstatus",
        compositionstatus,
        compositionstatus_to_code,
      )
  }
}

pub type Conditionclinical {
  ConditionclinicalActive
  ConditionclinicalRecurrence
  ConditionclinicalRelapse
  ConditionclinicalInactive
  ConditionclinicalRemission
  ConditionclinicalResolved
  ConditionclinicalUnknown
}

pub const conditionclinical: List(Conditionclinical) = [
  ConditionclinicalActive,
  ConditionclinicalRecurrence,
  ConditionclinicalRelapse,
  ConditionclinicalInactive,
  ConditionclinicalRemission,
  ConditionclinicalResolved,
  ConditionclinicalUnknown,
]

pub fn conditionclinical_to_json(conditionclinical: Conditionclinical) -> Json {
  json.string(conditionclinical_to_code(conditionclinical))
}

pub fn conditionclinical_to_code(
  conditionclinical: Conditionclinical,
) -> String {
  case conditionclinical {
    ConditionclinicalActive -> "active"
    ConditionclinicalRecurrence -> "recurrence"
    ConditionclinicalRelapse -> "relapse"
    ConditionclinicalInactive -> "inactive"
    ConditionclinicalRemission -> "remission"
    ConditionclinicalResolved -> "resolved"
    ConditionclinicalUnknown -> "unknown"
  }
}

pub fn conditionclinical_from_code(
  code: String,
) -> Result(Conditionclinical, Nil) {
  case code {
    "active" -> Ok(ConditionclinicalActive)
    "recurrence" -> Ok(ConditionclinicalRecurrence)
    "relapse" -> Ok(ConditionclinicalRelapse)
    "inactive" -> Ok(ConditionclinicalInactive)
    "remission" -> Ok(ConditionclinicalRemission)
    "resolved" -> Ok(ConditionclinicalResolved)
    "unknown" -> Ok(ConditionclinicalUnknown)
    _ -> Error(Nil)
  }
}

pub fn conditionclinical_decoder() -> Decoder(Conditionclinical) {
  use variant <- decode.then(decode.string)
  case conditionclinical_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ConditionclinicalActive,
        "Conditionclinical",
        conditionclinical,
        conditionclinical_to_code,
      )
  }
}

pub fn conditionclinical_from_code_and_system(
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

pub type Conditionverstatus {
  ConditionverstatusUnconfirmed
  ConditionverstatusProvisional
  ConditionverstatusDifferential
  ConditionverstatusConfirmed
  ConditionverstatusRefuted
  ConditionverstatusEnteredinerror
}

pub const conditionverstatus: List(Conditionverstatus) = [
  ConditionverstatusUnconfirmed,
  ConditionverstatusProvisional,
  ConditionverstatusDifferential,
  ConditionverstatusConfirmed,
  ConditionverstatusRefuted,
  ConditionverstatusEnteredinerror,
]

pub fn conditionverstatus_to_json(
  conditionverstatus: Conditionverstatus,
) -> Json {
  json.string(conditionverstatus_to_code(conditionverstatus))
}

pub fn conditionverstatus_to_code(
  conditionverstatus: Conditionverstatus,
) -> String {
  case conditionverstatus {
    ConditionverstatusUnconfirmed -> "unconfirmed"
    ConditionverstatusProvisional -> "provisional"
    ConditionverstatusDifferential -> "differential"
    ConditionverstatusConfirmed -> "confirmed"
    ConditionverstatusRefuted -> "refuted"
    ConditionverstatusEnteredinerror -> "entered-in-error"
  }
}

pub fn conditionverstatus_from_code(
  code: String,
) -> Result(Conditionverstatus, Nil) {
  case code {
    "unconfirmed" -> Ok(ConditionverstatusUnconfirmed)
    "provisional" -> Ok(ConditionverstatusProvisional)
    "differential" -> Ok(ConditionverstatusDifferential)
    "confirmed" -> Ok(ConditionverstatusConfirmed)
    "refuted" -> Ok(ConditionverstatusRefuted)
    "entered-in-error" -> Ok(ConditionverstatusEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn conditionverstatus_decoder() -> Decoder(Conditionverstatus) {
  use variant <- decode.then(decode.string)
  case conditionverstatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ConditionverstatusUnconfirmed,
        "Conditionverstatus",
        conditionverstatus,
        conditionverstatus_to_code,
      )
  }
}

pub fn conditionverstatus_from_code_and_system(
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

pub type Contactpointsystem {
  ContactpointsystemPhone
  ContactpointsystemFax
  ContactpointsystemEmail
  ContactpointsystemPager
  ContactpointsystemUrl
  ContactpointsystemSms
  ContactpointsystemOther
}

pub const contactpointsystem: List(Contactpointsystem) = [
  ContactpointsystemPhone,
  ContactpointsystemFax,
  ContactpointsystemEmail,
  ContactpointsystemPager,
  ContactpointsystemUrl,
  ContactpointsystemSms,
  ContactpointsystemOther,
]

pub fn contactpointsystem_to_json(
  contactpointsystem: Contactpointsystem,
) -> Json {
  json.string(contactpointsystem_to_code(contactpointsystem))
}

pub fn contactpointsystem_to_code(
  contactpointsystem: Contactpointsystem,
) -> String {
  case contactpointsystem {
    ContactpointsystemPhone -> "phone"
    ContactpointsystemFax -> "fax"
    ContactpointsystemEmail -> "email"
    ContactpointsystemPager -> "pager"
    ContactpointsystemUrl -> "url"
    ContactpointsystemSms -> "sms"
    ContactpointsystemOther -> "other"
  }
}

pub fn contactpointsystem_from_code(
  code: String,
) -> Result(Contactpointsystem, Nil) {
  case code {
    "phone" -> Ok(ContactpointsystemPhone)
    "fax" -> Ok(ContactpointsystemFax)
    "email" -> Ok(ContactpointsystemEmail)
    "pager" -> Ok(ContactpointsystemPager)
    "url" -> Ok(ContactpointsystemUrl)
    "sms" -> Ok(ContactpointsystemSms)
    "other" -> Ok(ContactpointsystemOther)
    _ -> Error(Nil)
  }
}

pub fn contactpointsystem_decoder() -> Decoder(Contactpointsystem) {
  use variant <- decode.then(decode.string)
  case contactpointsystem_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ContactpointsystemPhone,
        "Contactpointsystem",
        contactpointsystem,
        contactpointsystem_to_code,
      )
  }
}

pub type Contactpointuse {
  ContactpointuseHome
  ContactpointuseWork
  ContactpointuseTemp
  ContactpointuseOld
  ContactpointuseMobile
}

pub const contactpointuse: List(Contactpointuse) = [
  ContactpointuseHome,
  ContactpointuseWork,
  ContactpointuseTemp,
  ContactpointuseOld,
  ContactpointuseMobile,
]

pub fn contactpointuse_to_json(contactpointuse: Contactpointuse) -> Json {
  json.string(contactpointuse_to_code(contactpointuse))
}

pub fn contactpointuse_to_code(contactpointuse: Contactpointuse) -> String {
  case contactpointuse {
    ContactpointuseHome -> "home"
    ContactpointuseWork -> "work"
    ContactpointuseTemp -> "temp"
    ContactpointuseOld -> "old"
    ContactpointuseMobile -> "mobile"
  }
}

pub fn contactpointuse_from_code(code: String) -> Result(Contactpointuse, Nil) {
  case code {
    "home" -> Ok(ContactpointuseHome)
    "work" -> Ok(ContactpointuseWork)
    "temp" -> Ok(ContactpointuseTemp)
    "old" -> Ok(ContactpointuseOld)
    "mobile" -> Ok(ContactpointuseMobile)
    _ -> Error(Nil)
  }
}

pub fn contactpointuse_decoder() -> Decoder(Contactpointuse) {
  use variant <- decode.then(decode.string)
  case contactpointuse_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ContactpointuseHome,
        "Contactpointuse",
        contactpointuse,
        contactpointuse_to_code,
      )
  }
}

pub type Daysofweek {
  DaysofweekMon
  DaysofweekTue
  DaysofweekWed
  DaysofweekThu
  DaysofweekFri
  DaysofweekSat
  DaysofweekSun
}

pub const daysofweek: List(Daysofweek) = [
  DaysofweekMon,
  DaysofweekTue,
  DaysofweekWed,
  DaysofweekThu,
  DaysofweekFri,
  DaysofweekSat,
  DaysofweekSun,
]

pub fn daysofweek_to_json(daysofweek: Daysofweek) -> Json {
  json.string(daysofweek_to_code(daysofweek))
}

pub fn daysofweek_to_code(daysofweek: Daysofweek) -> String {
  case daysofweek {
    DaysofweekMon -> "mon"
    DaysofweekTue -> "tue"
    DaysofweekWed -> "wed"
    DaysofweekThu -> "thu"
    DaysofweekFri -> "fri"
    DaysofweekSat -> "sat"
    DaysofweekSun -> "sun"
  }
}

pub fn daysofweek_from_code(code: String) -> Result(Daysofweek, Nil) {
  case code {
    "mon" -> Ok(DaysofweekMon)
    "tue" -> Ok(DaysofweekTue)
    "wed" -> Ok(DaysofweekWed)
    "thu" -> Ok(DaysofweekThu)
    "fri" -> Ok(DaysofweekFri)
    "sat" -> Ok(DaysofweekSat)
    "sun" -> Ok(DaysofweekSun)
    _ -> Error(Nil)
  }
}

pub fn daysofweek_decoder() -> Decoder(Daysofweek) {
  use variant <- decode.then(decode.string)
  case daysofweek_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DaysofweekMon,
        "Daysofweek",
        daysofweek,
        daysofweek_to_code,
      )
  }
}

pub type Detailedethnicity {
  Detailedethnicity21352
  Detailedethnicity21378
  Detailedethnicity21386
  Detailedethnicity21394
  Detailedethnicity21402
  Detailedethnicity21410
  Detailedethnicity21428
  Detailedethnicity21436
  Detailedethnicity21444
  Detailedethnicity21451
  Detailedethnicity21469
  Detailedethnicity21485
  Detailedethnicity21493
  Detailedethnicity21501
  Detailedethnicity21519
  Detailedethnicity21527
  Detailedethnicity21535
  Detailedethnicity21550
  Detailedethnicity21568
  Detailedethnicity21576
  Detailedethnicity21584
  Detailedethnicity21592
  Detailedethnicity21600
  Detailedethnicity21618
  Detailedethnicity21626
  Detailedethnicity21634
  Detailedethnicity21659
  Detailedethnicity21667
  Detailedethnicity21675
  Detailedethnicity21683
  Detailedethnicity21691
  Detailedethnicity21709
  Detailedethnicity21717
  Detailedethnicity21725
  Detailedethnicity21733
  Detailedethnicity21741
  Detailedethnicity21758
  Detailedethnicity21766
  Detailedethnicity21782
  Detailedethnicity21808
  Detailedethnicity21824
  Detailedethnicity21840
  Detailedethnicity21865
  DetailedethnicityAsku
  DetailedethnicityOth
  DetailedethnicityUnk
}

pub const detailedethnicity: List(Detailedethnicity) = [
  Detailedethnicity21352,
  Detailedethnicity21378,
  Detailedethnicity21386,
  Detailedethnicity21394,
  Detailedethnicity21402,
  Detailedethnicity21410,
  Detailedethnicity21428,
  Detailedethnicity21436,
  Detailedethnicity21444,
  Detailedethnicity21451,
  Detailedethnicity21469,
  Detailedethnicity21485,
  Detailedethnicity21493,
  Detailedethnicity21501,
  Detailedethnicity21519,
  Detailedethnicity21527,
  Detailedethnicity21535,
  Detailedethnicity21550,
  Detailedethnicity21568,
  Detailedethnicity21576,
  Detailedethnicity21584,
  Detailedethnicity21592,
  Detailedethnicity21600,
  Detailedethnicity21618,
  Detailedethnicity21626,
  Detailedethnicity21634,
  Detailedethnicity21659,
  Detailedethnicity21667,
  Detailedethnicity21675,
  Detailedethnicity21683,
  Detailedethnicity21691,
  Detailedethnicity21709,
  Detailedethnicity21717,
  Detailedethnicity21725,
  Detailedethnicity21733,
  Detailedethnicity21741,
  Detailedethnicity21758,
  Detailedethnicity21766,
  Detailedethnicity21782,
  Detailedethnicity21808,
  Detailedethnicity21824,
  Detailedethnicity21840,
  Detailedethnicity21865,
  DetailedethnicityAsku,
  DetailedethnicityOth,
  DetailedethnicityUnk,
]

pub fn detailedethnicity_to_json(detailedethnicity: Detailedethnicity) -> Json {
  json.string(detailedethnicity_to_code(detailedethnicity))
}

pub fn detailedethnicity_to_code(
  detailedethnicity: Detailedethnicity,
) -> String {
  case detailedethnicity {
    Detailedethnicity21352 -> "2135-2"
    Detailedethnicity21378 -> "2137-8"
    Detailedethnicity21386 -> "2138-6"
    Detailedethnicity21394 -> "2139-4"
    Detailedethnicity21402 -> "2140-2"
    Detailedethnicity21410 -> "2141-0"
    Detailedethnicity21428 -> "2142-8"
    Detailedethnicity21436 -> "2143-6"
    Detailedethnicity21444 -> "2144-4"
    Detailedethnicity21451 -> "2145-1"
    Detailedethnicity21469 -> "2146-9"
    Detailedethnicity21485 -> "2148-5"
    Detailedethnicity21493 -> "2149-3"
    Detailedethnicity21501 -> "2150-1"
    Detailedethnicity21519 -> "2151-9"
    Detailedethnicity21527 -> "2152-7"
    Detailedethnicity21535 -> "2153-5"
    Detailedethnicity21550 -> "2155-0"
    Detailedethnicity21568 -> "2156-8"
    Detailedethnicity21576 -> "2157-6"
    Detailedethnicity21584 -> "2158-4"
    Detailedethnicity21592 -> "2159-2"
    Detailedethnicity21600 -> "2160-0"
    Detailedethnicity21618 -> "2161-8"
    Detailedethnicity21626 -> "2162-6"
    Detailedethnicity21634 -> "2163-4"
    Detailedethnicity21659 -> "2165-9"
    Detailedethnicity21667 -> "2166-7"
    Detailedethnicity21675 -> "2167-5"
    Detailedethnicity21683 -> "2168-3"
    Detailedethnicity21691 -> "2169-1"
    Detailedethnicity21709 -> "2170-9"
    Detailedethnicity21717 -> "2171-7"
    Detailedethnicity21725 -> "2172-5"
    Detailedethnicity21733 -> "2173-3"
    Detailedethnicity21741 -> "2174-1"
    Detailedethnicity21758 -> "2175-8"
    Detailedethnicity21766 -> "2176-6"
    Detailedethnicity21782 -> "2178-2"
    Detailedethnicity21808 -> "2180-8"
    Detailedethnicity21824 -> "2182-4"
    Detailedethnicity21840 -> "2184-0"
    Detailedethnicity21865 -> "2186-5"
    DetailedethnicityAsku -> "ASKU"
    DetailedethnicityOth -> "OTH"
    DetailedethnicityUnk -> "UNK"
  }
}

pub fn detailedethnicity_from_code(
  code: String,
) -> Result(Detailedethnicity, Nil) {
  case code {
    "2135-2" -> Ok(Detailedethnicity21352)
    "2137-8" -> Ok(Detailedethnicity21378)
    "2138-6" -> Ok(Detailedethnicity21386)
    "2139-4" -> Ok(Detailedethnicity21394)
    "2140-2" -> Ok(Detailedethnicity21402)
    "2141-0" -> Ok(Detailedethnicity21410)
    "2142-8" -> Ok(Detailedethnicity21428)
    "2143-6" -> Ok(Detailedethnicity21436)
    "2144-4" -> Ok(Detailedethnicity21444)
    "2145-1" -> Ok(Detailedethnicity21451)
    "2146-9" -> Ok(Detailedethnicity21469)
    "2148-5" -> Ok(Detailedethnicity21485)
    "2149-3" -> Ok(Detailedethnicity21493)
    "2150-1" -> Ok(Detailedethnicity21501)
    "2151-9" -> Ok(Detailedethnicity21519)
    "2152-7" -> Ok(Detailedethnicity21527)
    "2153-5" -> Ok(Detailedethnicity21535)
    "2155-0" -> Ok(Detailedethnicity21550)
    "2156-8" -> Ok(Detailedethnicity21568)
    "2157-6" -> Ok(Detailedethnicity21576)
    "2158-4" -> Ok(Detailedethnicity21584)
    "2159-2" -> Ok(Detailedethnicity21592)
    "2160-0" -> Ok(Detailedethnicity21600)
    "2161-8" -> Ok(Detailedethnicity21618)
    "2162-6" -> Ok(Detailedethnicity21626)
    "2163-4" -> Ok(Detailedethnicity21634)
    "2165-9" -> Ok(Detailedethnicity21659)
    "2166-7" -> Ok(Detailedethnicity21667)
    "2167-5" -> Ok(Detailedethnicity21675)
    "2168-3" -> Ok(Detailedethnicity21683)
    "2169-1" -> Ok(Detailedethnicity21691)
    "2170-9" -> Ok(Detailedethnicity21709)
    "2171-7" -> Ok(Detailedethnicity21717)
    "2172-5" -> Ok(Detailedethnicity21725)
    "2173-3" -> Ok(Detailedethnicity21733)
    "2174-1" -> Ok(Detailedethnicity21741)
    "2175-8" -> Ok(Detailedethnicity21758)
    "2176-6" -> Ok(Detailedethnicity21766)
    "2178-2" -> Ok(Detailedethnicity21782)
    "2180-8" -> Ok(Detailedethnicity21808)
    "2182-4" -> Ok(Detailedethnicity21824)
    "2184-0" -> Ok(Detailedethnicity21840)
    "2186-5" -> Ok(Detailedethnicity21865)
    "ASKU" -> Ok(DetailedethnicityAsku)
    "OTH" -> Ok(DetailedethnicityOth)
    "UNK" -> Ok(DetailedethnicityUnk)
    _ -> Error(Nil)
  }
}

pub fn detailedethnicity_decoder() -> Decoder(Detailedethnicity) {
  use variant <- decode.then(decode.string)
  case detailedethnicity_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        Detailedethnicity21352,
        "Detailedethnicity",
        detailedethnicity,
        detailedethnicity_to_code,
      )
  }
}

pub fn detailedethnicity_from_code_and_system(
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

pub type Detailedrace {
  Detailedrace10041
  Detailedrace10066
  Detailedrace15792
  Detailedrace12120
  Detailedrace10454
  Detailedrace16543
  Detailedrace11940
  Detailedrace11957
  Detailedrace11874
  Detailedrace10082
  Detailedrace30122
  Detailedrace16881
  Detailedrace13920
  Detailedrace30155
  Detailedrace30163
  Detailedrace10108
  Detailedrace10165
  Detailedrace10215
  Detailedrace10249
  Detailedrace10264
  Detailedrace13664
  Detailedrace10280
  Detailedrace30247
  Detailedrace30254
  Detailedrace12344
  Detailedrace12658
  Detailedrace10462
  Detailedrace11247
  Detailedrace10330
  Detailedrace30312
  Detailedrace11254
  Detailedrace10603
  Detailedrace30346
  Detailedrace30353
  Detailedrace30361
  Detailedrace14308
  Detailedrace30387
  Detailedrace30395
  Detailedrace12351
  Detailedrace30411
  Detailedrace14175
  Detailedrace10355
  Detailedrace30445
  Detailedrace11262
  Detailedrace14183
  Detailedrace10371
  Detailedrace16113
  Detailedrace30494
  Detailedrace14191
  Detailedrace30510
  Detailedrace10470
  Detailedrace30536
  Detailedrace10413
  Detailedrace30551
  Detailedrace10421
  Detailedrace10546
  Detailedrace10447
  Detailedrace30593
  Detailedrace30601
  Detailedrace12237
  Detailedrace12245
  Detailedrace10769
  Detailedrace12864
  Detailedrace10785
  Detailedrace14209
  Detailedrace13938
  Detailedrace14654
  Detailedrace30692
  Detailedrace30700
  Detailedrace30718
  Detailedrace10827
  Detailedrace10868
  Detailedrace30742
  Detailedrace30759
  Detailedrace30767
  Detailedrace10884
  Detailedrace10892
  Detailedrace30791
  Detailedrace30809
  Detailedrace30817
  Detailedrace10900
  Detailedrace11023
  Detailedrace11064
  Detailedrace30858
  Detailedrace30866
  Detailedrace11098
  Detailedrace30882
  Detailedrace10553
  Detailedrace11148
  Detailedrace11239
  Detailedrace30924
  Detailedrace11536
  Detailedrace11551
  Detailedrace30957
  Detailedrace11627
  Detailedrace14795
  Detailedrace11155
  Detailedrace11650
  Detailedrace11569
  Detailedrace31013
  Detailedrace17251
  Detailedrace11676
  Detailedrace11692
  Detailedrace31054
  Detailedrace11718
  Detailedrace13946
  Detailedrace11163
  Detailedrace31096
  Detailedrace15602
  Detailedrace17079
  Detailedrace16071
  Detailedrace10801
  Detailedrace11734
  Detailedrace11783
  Detailedrace15917
  Detailedrace12625
  Detailedrace16659
  Detailedrace16832
  Detailedrace11809
  Detailedrace11825
  Detailedrace11841
  Detailedrace11866
  Detailedrace31245
  Detailedrace16683
  Detailedrace11890
  Detailedrace31278
  Detailedrace11916
  Detailedrace12070
  Detailedrace16139
  Detailedrace12096
  Detailedrace31328
  Detailedrace12112
  Detailedrace31344
  Detailedrace31351
  Detailedrace31369
  Detailedrace10579
  Detailedrace14662
  Detailedrace15883
  Detailedrace15198
  Detailedrace31419
  Detailedrace10926
  Detailedrace11965
  Detailedrace11973
  Detailedrace31450
  Detailedrace14670
  Detailedrace15800
  Detailedrace15990
  Detailedrace10934
  Detailedrace12393
  Detailedrace14720
  Detailedrace31526
  Detailedrace31534
  Detailedrace15909
  Detailedrace31559
  Detailedrace12500
  Detailedrace12252
  Detailedrace10561
  Detailedrace31591
  Detailedrace16154
  Detailedrace11288
  Detailedrace31625
  Detailedrace12526
  Detailedrace14217
  Detailedrace14225
  Detailedrace16055
  Detailedrace12567
  Detailedrace17293
  Detailedrace31690
  Detailedrace31708
  Detailedrace12609
  Detailedrace12369
  Detailedrace31732
  Detailedrace31740
  Detailedrace12427
  Detailedrace11296
  Detailedrace31773
  Detailedrace11304
  Detailedrace31799
  Detailedrace31807
  Detailedrace12641
  Detailedrace31823
  Detailedrace31831
  Detailedrace31849
  Detailedrace12674
  Detailedrace14811
  Detailedrace31872
  Detailedrace17269
  Detailedrace31898
  Detailedrace12690
  Detailedrace16972
  Detailedrace10835
  Detailedrace12757
  Detailedrace12716
  Detailedrace31955
  Detailedrace31963
  Detailedrace31971
  Detailedrace17277
  Detailedrace12302
  Detailedrace13599
  Detailedrace12799
  Detailedrace14423
  Detailedrace13607
  Detailedrace32045
  Detailedrace12815
  Detailedrace12823
  Detailedrace12831
  Detailedrace12856
  Detailedrace32094
  Detailedrace13136
  Detailedrace32110
  Detailedrace11577
  Detailedrace10132
  Detailedrace12971
  Detailedrace14233
  Detailedrace13953
  Detailedrace12997
  Detailedrace13011
  Detailedrace14688
  Detailedrace11171
  Detailedrace13037
  Detailedrace32227
  Detailedrace15107
  Detailedrace32243
  Detailedrace11981
  Detailedrace13052
  Detailedrace13078
  Detailedrace32284
  Detailedrace13060
  Detailedrace15206
  Detailedrace13094
  Detailedrace13102
  Detailedrace13128
  Detailedrace32342
  Detailedrace32359
  Detailedrace32367
  Detailedrace32375
  Detailedrace13193
  Detailedrace13219
  Detailedrace12229
  Detailedrace13326
  Detailedrace12260
  Detailedrace11320
  Detailedrace11338
  Detailedrace11346
  Detailedrace11353
  Detailedrace14241
  Detailedrace13235
  Detailedrace11361
  Detailedrace32508
  Detailedrace10140
  Detailedrace32524
  Detailedrace11379
  Detailedrace32540
  Detailedrace14258
  Detailedrace10488
  Detailedrace32573
  Detailedrace14266
  Detailedrace16188
  Detailedrace13144
  Detailedrace11999
  Detailedrace16196
  Detailedrace15214
  Detailedrace13318
  Detailedrace13409
  Detailedrace13425
  Detailedrace32672
  Detailedrace12005
  Detailedrace13441
  Detailedrace13482
  Detailedrace14274
  Detailedrace13508
  Detailedrace32730
  Detailedrace13524
  Detailedrace12278
  Detailedrace17285
  Detailedrace32771
  Detailedrace14548
  Detailedrace16816
  Detailedrace32805
  Detailedrace13268
  Detailedrace13540
  Detailedrace16204
  Detailedrace32847
  Detailedrace32854
  Detailedrace13565
  Detailedrace12286
  Detailedrace10157
  Detailedrace32896
  Detailedrace13581
  Detailedrace13615
  Detailedrace13631
  Detailedrace13656
  Detailedrace32946
  Detailedrace11387
  Detailedrace11395
  Detailedrace13680
  Detailedrace11585
  Detailedrace13706
  Detailedrace14282
  Detailedrace13722
  Detailedrace12872
  Detailedrace13748
  Detailedrace13961
  Detailedrace33050
  Detailedrace13763
  Detailedrace13276
  Detailedrace12377
  Detailedrace33092
  Detailedrace10496
  Detailedrace13458
  Detailedrace11593
  Detailedrace15222
  Detailedrace12179
  Detailedrace12385
  Detailedrace13789
  Detailedrace33175
  Detailedrace13805
  Detailedrace33191
  Detailedrace12401
  Detailedrace33217
  Detailedrace12203
  Detailedrace13870
  Detailedrace12419
  Detailedrace13466
  Detailedrace15230
  Detailedrace13896
  Detailedrace15248
  Detailedrace33290
  Detailedrace10223
  Detailedrace10959
  Detailedrace11031
  Detailedrace14290
  Detailedrace14696
  Detailedrace15982
  Detailedrace14829
  Detailedrace33373
  Detailedrace33381
  Detailedrace33399
  Detailedrace33407
  Detailedrace33415
  Detailedrace14035
  Detailedrace12880
  Detailedrace33449
  Detailedrace33456
  Detailedrace12898
  Detailedrace14050
  Detailedrace14092
  Detailedrace14118
  Detailedrace14142
  Detailedrace14167
  Detailedrace14332
  Detailedrace16048
  Detailedrace13334
  Detailedrace14399
  Detailedrace33563
  Detailedrace33571
  Detailedrace14415
  Detailedrace33597
  Detailedrace33605
  Detailedrace13342
  Detailedrace14456
  Detailedrace14464
  Detailedrace13359
  Detailedrace33654
  Detailedrace33662
  Detailedrace14480
  Detailedrace33688
  Detailedrace14530
  Detailedrace17186
  Detailedrace33712
  Detailedrace14563
  Detailedrace33738
  Detailedrace16246
  Detailedrace33753
  Detailedrace15008
  Detailedrace14605
  Detailedrace33787
  Detailedrace33795
  Detailedrace14621
  Detailedrace14431
  Detailedrace12013
  Detailedrace33837
  Detailedrace12435
  Detailedrace33852
  Detailedrace14837
  Detailedrace33878
  Detailedrace14647
  Detailedrace14746
  Detailedrace14761
  Detailedrace14753
  Detailedrace33928
  Detailedrace13284
  Detailedrace13151
  Detailedrace14787
  Detailedrace33969
  Detailedrace14878
  Detailedrace14845
  Detailedrace16253
  Detailedrace12021
  Detailedrace14894
  Detailedrace14902
  Detailedrace14928
  Detailedrace14944
  Detailedrace14951
  Detailedrace14977
  Detailedrace14985
  Detailedrace14993
  Detailedrace15016
  Detailedrace15024
  Detailedrace15032
  Detailedrace15073
  Detailedrace15081
  Detailedrace15099
  Detailedrace15115
  Detailedrace15123
  Detailedrace15156
  Detailedrace15180
  Detailedrace15263
  Detailedrace14316
  Detailedrace15412
  Detailedrace34223
  Detailedrace34231
  Detailedrace10843
  Detailedrace15438
  Detailedrace12195
  Detailedrace34272
  Detailedrace15453
  Detailedrace11411
  Detailedrace11429
  Detailedrace10611
  Detailedrace34322
  Detailedrace34330
  Detailedrace15479
  Detailedrace17335
  Detailedrace34363
  Detailedrace34371
  Detailedrace16279
  Detailedrace15495
  Detailedrace15511
  Detailedrace15537
  Detailedrace15545
  Detailedrace15529
  Detailedrace34447
  Detailedrace11437
  Detailedrace34462
  Detailedrace15560
  Detailedrace15586
  Detailedrace14589
  Detailedrace15271
  Detailedrace10181
  Detailedrace15065
  Detailedrace14324
  Detailedrace34546
  Detailedrace15743
  Detailedrace12294
  Detailedrace10504
  Detailedrace10629
  Detailedrace11635
  Detailedrace34603
  Detailedrace34611
  Detailedrace16295
  Detailedrace34637
  Detailedrace34645
  Detailedrace15289
  Detailedrace11452
  Detailedrace15628
  Detailedrace14704
  Detailedrace34694
  Detailedrace15669
  Detailedrace34710
  Detailedrace34728
  Detailedrace12922
  Detailedrace15735
  Detailedrace13292
  Detailedrace16261
  Detailedrace15768
  Detailedrace15784
  Detailedrace34793
  Detailedrace11007
  Detailedrace34819
  Detailedrace34827
  Detailedrace15826
  Detailedrace15842
  Detailedrace15867
  Detailedrace16022
  Detailedrace12583
  Detailedrace16030
  Detailedrace16097
  Detailedrace34900
  Detailedrace16436
  Detailedrace15297
  Detailedrace15941
  Detailedrace15305
  Detailedrace15313
  Detailedrace15321
  Detailedrace13367
  Detailedrace11460
  Detailedrace34991
  Detailedrace12443
  Detailedrace10231
  Detailedrace11049
  Detailedrace35030
  Detailedrace16329
  Detailedrace16451
  Detailedrace15339
  Detailedrace11445
  Detailedrace16337
  Detailedrace15347
  Detailedrace15354
  Detailedrace16493
  Detailedrace14712
  Detailedrace14340
  Detailedrace16519
  Detailedrace12450
  Detailedrace35162
  Detailedrace15370
  Detailedrace12310
  Detailedrace35196
  Detailedrace17194
  Detailedrace10637
  Detailedrace13979
  Detailedrace35238
  Detailedrace13383
  Detailedrace35253
  Detailedrace13987
  Detailedrace16345
  Detailedrace11122
  Detailedrace11601
  Detailedrace35303
  Detailedrace11932
  Detailedrace14076
  Detailedrace15719
  Detailedrace12039
  Detailedrace35352
  Detailedrace35360
  Detailedrace12047
  Detailedrace12542
  Detailedrace13995
  Detailedrace35402
  Detailedrace35410
  Detailedrace16592
  Detailedrace35436
  Detailedrace12930
  Detailedrace16618
  Detailedrace10173
  Detailedrace10512
  Detailedrace12724
  Detailedrace12054
  Detailedrace15388
  Detailedrace17202
  Detailedrace12468
  Detailedrace35535
  Detailedrace11478
  Detailedrace12948
  Detailedrace10967
  Detailedrace13375
  Detailedrace16634
  Detailedrace16675
  Detailedrace35600
  Detailedrace35618
  Detailedrace12773
  Detailedrace10975
  Detailedrace11189
  Detailedrace35659
  Detailedrace16360
  Detailedrace15396
  Detailedrace16709
  Detailedrace16725
  Detailedrace35709
  Detailedrace14357
  Detailedrace35725
  Detailedrace12476
  Detailedrace16378
  Detailedrace16758
  Detailedrace11197
  Detailedrace14365
  Detailedrace16774
  Detailedrace16790
  Detailedrace16808
  Detailedrace10645
  Detailedrace16857
  Detailedrace35832
  Detailedrace35840
  Detailedrace16394
  Detailedrace14001
  Detailedrace12732
  Detailedrace11486
  Detailedrace10199
  Detailedrace35907
  Detailedrace16923
  Detailedrace12484
  Detailedrace11205
  Detailedrace35949
  Detailedrace16949
  Detailedrace16964
  Detailedrace16980
  Detailedrace17004
  Detailedrace17020
  Detailedrace11213
  Detailedrace36012
  Detailedrace12955
  Detailedrace17095
  Detailedrace10652
  Detailedrace16402
  Detailedrace16410
  Detailedrace17111
  Detailedrace17152
  Detailedrace17319
  Detailedrace14373
  Detailedrace36111
  Detailedrace17178
  Detailedrace16006
  Detailedrace15149
  Detailedrace17228
  Detailedrace10660
  Detailedrace17327
  Detailedrace15164
  Detailedrace17350
  Detailedrace17376
  Detailedrace17392
  Detailedrace17400
  Detailedrace17442
  Detailedrace17418
  Detailedrace17426
  Detailedrace17434
  Detailedrace17459
  Detailedrace36285
  Detailedrace17475
  Detailedrace17483
  Detailedrace17509
  Detailedrace17525
  Detailedrace17517
  Detailedrace17541
  Detailedrace17558
  Detailedrace17574
  Detailedrace17590
  Detailedrace17616
  Detailedrace17624
  Detailedrace17657
  Detailedrace17673
  Detailedrace17681
  Detailedrace17699
  Detailedrace17707
  Detailedrace17715
  Detailedrace17756
  Detailedrace17764
  Detailedrace17772
  Detailedrace17780
  Detailedrace17806
  Detailedrace17798
  Detailedrace17814
  Detailedrace17491
  Detailedrace17533
  Detailedrace17608
  Detailedrace17632
  Detailedrace17640
  Detailedrace17749
  Detailedrace17822
  Detailedrace17913
  Detailedrace17962
  Detailedrace17996
  Detailedrace18010
  Detailedrace18036
  Detailedrace18051
  Detailedrace18077
  Detailedrace17830
  Detailedrace17848
  Detailedrace17855
  Detailedrace17863
  Detailedrace17871
  Detailedrace17889
  Detailedrace17665
  Detailedrace17897
  Detailedrace17905
  Detailedrace17939
  Detailedrace17954
  Detailedrace17947
  Detailedrace17988
  Detailedrace18028
  Detailedrace18044
  Detailedrace18069
  Detailedrace17582
  Detailedrace17723
  Detailedrace17731
  Detailedrace17921
  Detailedrace17970
  Detailedrace18085
  Detailedrace18093
  Detailedrace18259
  Detailedrace19661
  Detailedrace19943
  Detailedrace20081
  Detailedrace41871
  Detailedrace19729
  Detailedrace19737
  Detailedrace19745
  Detailedrace19844
  Detailedrace19869
  Detailedrace19752
  Detailedrace18408
  Detailedrace19760
  Detailedrace19778
  Detailedrace37044
  Detailedrace20149
  Detailedrace19786
  Detailedrace19968
  Detailedrace19794
  Detailedrace19927
  Detailedrace37101
  Detailedrace37119
  Detailedrace19935
  Detailedrace20073
  Detailedrace20115
  Detailedrace20123
  Detailedrace19851
  Detailedrace20131
  Detailedrace19901
  Detailedrace20156
  Detailedrace37200
  Detailedrace19950
  Detailedrace19976
  Detailedrace19877
  Detailedrace20164
  Detailedrace20172
  Detailedrace19992
  Detailedrace19802
  Detailedrace19810
  Detailedrace19885
  Detailedrace19828
  Detailedrace20008
  Detailedrace19695
  Detailedrace20263
  Detailedrace20180
  Detailedrace37358
  Detailedrace20206
  Detailedrace20214
  Detailedrace20222
  Detailedrace20248
  Detailedrace20024
  Detailedrace37416
  Detailedrace19703
  Detailedrace37432
  Detailedrace19984
  Detailedrace37457
  Detailedrace37465
  Detailedrace18499
  Detailedrace18507
  Detailedrace18523
  Detailedrace19091
  Detailedrace37515
  Detailedrace18424
  Detailedrace37531
  Detailedrace18481
  Detailedrace18622
  Detailedrace18630
  Detailedrace37572
  Detailedrace18713
  Detailedrace18457
  Detailedrace18515
  Detailedrace18531
  Detailedrace18549
  Detailedrace18564
  Detailedrace18572
  Detailedrace18606
  Detailedrace18580
  Detailedrace18648
  Detailedrace18655
  Detailedrace18663
  Detailedrace18671
  Detailedrace18689
  Detailedrace18895
  Detailedrace19331
  Detailedrace18721
  Detailedrace18754
  Detailedrace18762
  Detailedrace18770
  Detailedrace18788
  Detailedrace18796
  Detailedrace18804
  Detailedrace18812
  Detailedrace18838
  Detailedrace18846
  Detailedrace18861
  Detailedrace37853
  Detailedrace18739
  Detailedrace18747
  Detailedrace37887
  Detailedrace18820
  Detailedrace18853
  Detailedrace18333
  Detailedrace38612
  Detailedrace18168
  Detailedrace18176
  Detailedrace18184
  Detailedrace18192
  Detailedrace18200
  Detailedrace18218
  Detailedrace18226
  Detailedrace18267
  Detailedrace18275
  Detailedrace18234
  Detailedrace18242
  Detailedrace18309
  Detailedrace18283
  Detailedrace18291
  Detailedrace18119
  Detailedrace18317
  Detailedrace38091
  Detailedrace18325
  Detailedrace18143
  Detailedrace18341
  Detailedrace18358
  Detailedrace18374
  Detailedrace18382
  Detailedrace18960
  Detailedrace18978
  Detailedrace18986
  Detailedrace19638
  Detailedrace19349
  Detailedrace19067
  Detailedrace19075
  Detailedrace38232
  Detailedrace19133
  Detailedrace19166
  Detailedrace38265
  Detailedrace19208
  Detailedrace19299
  Detailedrace19315
  Detailedrace19356
  Detailedrace19000
  Detailedrace19109
  Detailedrace19141
  Detailedrace19158
  Detailedrace18929
  Detailedrace19620
  Detailedrace19182
  Detailedrace38380
  Detailedrace19190
  Detailedrace19224
  Detailedrace19232
  Detailedrace19257
  Detailedrace19281
  Detailedrace19497
  Detailedrace19323
  Detailedrace19364
  Detailedrace19372
  Detailedrace19380
  Detailedrace19422
  Detailedrace19539
  Detailedrace19430
  Detailedrace19463
  Detailedrace19513
  Detailedrace18937
  Detailedrace19521
  Detailedrace19596
  Detailedrace19604
  Detailedrace19240
  Detailedrace19406
  Detailedrace19398
  Detailedrace19414
  Detailedrace19570
  Detailedrace19273
  Detailedrace19042
  Detailedrace19448
  Detailedrace19455
  Detailedrace19471
  Detailedrace19489
  Detailedrace18945
  Detailedrace19554
  Detailedrace19562
  Detailedrace19588
  Detailedrace19612
  Detailedrace19646
  Detailedrace18994
  Detailedrace19026
  Detailedrace19034
  Detailedrace19059
  Detailedrace19083
  Detailedrace19117
  Detailedrace19125
  Detailedrace19216
  Detailedrace19265
  Detailedrace19307
  Detailedrace38851
  Detailedrace19505
  Detailedrace19547
  Detailedrace19018
  Detailedrace38893
  Detailedrace10694
  Detailedrace38919
  Detailedrace38927
  Detailedrace38935
  Detailedrace38943
  Detailedrace38950
  Detailedrace38968
  Detailedrace38976
  Detailedrace38984
  Detailedrace38992
  Detailedrace39008
  Detailedrace39016
  Detailedrace39024
  Detailedrace39032
  Detailedrace39040
  Detailedrace39057
  Detailedrace39065
  Detailedrace39073
  Detailedrace39081
  Detailedrace39099
  Detailedrace39107
  Detailedrace39115
  Detailedrace39123
  Detailedrace39131
  Detailedrace39149
  Detailedrace39156
  Detailedrace39164
  Detailedrace39172
  Detailedrace39180
  Detailedrace39198
  Detailedrace39206
  Detailedrace39214
  Detailedrace39222
  Detailedrace39230
  Detailedrace39248
  Detailedrace39255
  Detailedrace39263
  Detailedrace39271
  Detailedrace39289
  Detailedrace39297
  Detailedrace39305
  Detailedrace39313
  Detailedrace39321
  Detailedrace39339
  Detailedrace39347
  Detailedrace39354
  Detailedrace39362
  Detailedrace39370
  Detailedrace39388
  Detailedrace39396
  Detailedrace39404
  Detailedrace39412
  Detailedrace39420
  Detailedrace39438
  Detailedrace39446
  Detailedrace39453
  Detailedrace39461
  Detailedrace39479
  Detailedrace39487
  Detailedrace39495
  Detailedrace10710
  Detailedrace39511
  Detailedrace39529
  Detailedrace39537
  Detailedrace39545
  Detailedrace39552
  Detailedrace39560
  Detailedrace39578
  Detailedrace39586
  Detailedrace39594
  Detailedrace39602
  Detailedrace39610
  Detailedrace39628
  Detailedrace39636
  Detailedrace39644
  Detailedrace39651
  Detailedrace39669
  Detailedrace39677
  Detailedrace39685
  Detailedrace39693
  Detailedrace39701
  Detailedrace39719
  Detailedrace39727
  Detailedrace39735
  Detailedrace39743
  Detailedrace39750
  Detailedrace39768
  Detailedrace39776
  Detailedrace39784
  Detailedrace39792
  Detailedrace39800
  Detailedrace39818
  Detailedrace39826
  Detailedrace39834
  Detailedrace39842
  Detailedrace39859
  Detailedrace39867
  Detailedrace39875
  Detailedrace39883
  Detailedrace39891
  Detailedrace39909
  Detailedrace39917
  Detailedrace39925
  Detailedrace39933
  Detailedrace39941
  Detailedrace39958
  Detailedrace39966
  Detailedrace39974
  Detailedrace39982
  Detailedrace39990
  Detailedrace40006
  Detailedrace40014
  Detailedrace40022
  Detailedrace40030
  Detailedrace40048
  Detailedrace40055
  Detailedrace40063
  Detailedrace40071
  Detailedrace40089
  Detailedrace40097
  Detailedrace40105
  Detailedrace40113
  Detailedrace40121
  Detailedrace40139
  Detailedrace40147
  Detailedrace40154
  Detailedrace40162
  Detailedrace40170
  Detailedrace40188
  Detailedrace40196
  Detailedrace40204
  Detailedrace40212
  Detailedrace40220
  Detailedrace40238
  Detailedrace40246
  Detailedrace40253
  Detailedrace40261
  Detailedrace40279
  Detailedrace40287
  Detailedrace40295
  Detailedrace40303
  Detailedrace40311
  Detailedrace40329
  Detailedrace40337
  Detailedrace40345
  Detailedrace40352
  Detailedrace40360
  Detailedrace40378
  Detailedrace40386
  Detailedrace40394
  Detailedrace40402
  Detailedrace40410
  Detailedrace40428
  Detailedrace40436
  Detailedrace40444
  Detailedrace40451
  Detailedrace40469
  Detailedrace40477
  Detailedrace40485
  Detailedrace40493
  Detailedrace40501
  Detailedrace40519
  Detailedrace40527
  Detailedrace40535
  Detailedrace40543
  Detailedrace40550
  Detailedrace40568
  Detailedrace40576
  Detailedrace40584
  Detailedrace40592
  Detailedrace40600
  Detailedrace40618
  Detailedrace40626
  Detailedrace40634
  Detailedrace40642
  Detailedrace40659
  Detailedrace40667
  Detailedrace40675
  Detailedrace40683
  Detailedrace40691
  Detailedrace40709
  Detailedrace40717
  Detailedrace40725
  Detailedrace40733
  Detailedrace40741
  Detailedrace40758
  Detailedrace40766
  Detailedrace40774
  Detailedrace40782
  Detailedrace40790
  Detailedrace40808
  Detailedrace40816
  Detailedrace40824
  Detailedrace40832
  Detailedrace40840
  Detailedrace40857
  Detailedrace10702
  Detailedrace40873
  Detailedrace40881
  Detailedrace40899
  Detailedrace40907
  Detailedrace40915
  Detailedrace40923
  Detailedrace40931
  Detailedrace40949
  Detailedrace40956
  Detailedrace40964
  Detailedrace40972
  Detailedrace40980
  Detailedrace40998
  Detailedrace41004
  Detailedrace41012
  Detailedrace41020
  Detailedrace41038
  Detailedrace41046
  Detailedrace41053
  Detailedrace41061
  Detailedrace41079
  Detailedrace41087
  Detailedrace41095
  Detailedrace41103
  Detailedrace41111
  Detailedrace41129
  Detailedrace41137
  Detailedrace41145
  Detailedrace41152
  Detailedrace41160
  Detailedrace41178
  Detailedrace41186
  Detailedrace41194
  Detailedrace41202
  Detailedrace41210
  Detailedrace41228
  Detailedrace41236
  Detailedrace41244
  Detailedrace41251
  Detailedrace41269
  Detailedrace41277
  Detailedrace41285
  Detailedrace41293
  Detailedrace41301
  Detailedrace41319
  Detailedrace41327
  Detailedrace41335
  Detailedrace41343
  Detailedrace41350
  Detailedrace41368
  Detailedrace41376
  Detailedrace41384
  Detailedrace41392
  Detailedrace41400
  Detailedrace41418
  Detailedrace41426
  Detailedrace41434
  Detailedrace41442
  Detailedrace41459
  Detailedrace41467
  Detailedrace10728
  Detailedrace41483
  Detailedrace10736
  Detailedrace41509
  Detailedrace41517
  Detailedrace41525
  Detailedrace41533
  Detailedrace41541
  Detailedrace41558
  Detailedrace41566
  Detailedrace41574
  Detailedrace41582
  Detailedrace41590
  Detailedrace41608
  Detailedrace41616
  Detailedrace41624
  Detailedrace41632
  Detailedrace41640
  Detailedrace41657
  Detailedrace41665
  Detailedrace41673
  Detailedrace41681
  Detailedrace41699
  Detailedrace41707
  Detailedrace41715
  Detailedrace41723
  Detailedrace41731
  Detailedrace41749
  Detailedrace41756
  Detailedrace41764
  Detailedrace41772
  Detailedrace41780
  Detailedrace41798
  Detailedrace41806
  Detailedrace41814
  Detailedrace10744
  Detailedrace41830
  Detailedrace41848
  Detailedrace41855
  Detailedrace20297
  Detailedrace20305
  Detailedrace20313
  Detailedrace20321
  Detailedrace20339
  Detailedrace20347
  Detailedrace20354
  Detailedrace20362
  Detailedrace20370
  Detailedrace20388
  Detailedrace20396
  Detailedrace20404
  Detailedrace20412
  Detailedrace20420
  Detailedrace20438
  Detailedrace20446
  Detailedrace20453
  Detailedrace20461
  Detailedrace20479
  Detailedrace20487
  Detailedrace20495
  Detailedrace20503
  Detailedrace20511
  Detailedrace20529
  Detailedrace20560
  Detailedrace20586
  Detailedrace20602
  Detailedrace20610
  Detailedrace20628
  Detailedrace20636
  Detailedrace20644
  Detailedrace20651
  Detailedrace20669
  Detailedrace41863
  Detailedrace20677
  Detailedrace20685
  Detailedrace20693
  Detailedrace20701
  Detailedrace20719
  Detailedrace20727
  Detailedrace20735
  Detailedrace20743
  Detailedrace20750
  Detailedrace20784
  Detailedrace20792
  Detailedrace20800
  Detailedrace20818
  Detailedrace20826
  Detailedrace20834
  Detailedrace20859
  Detailedrace20867
  Detailedrace20875
  Detailedrace20883
  Detailedrace20891
  Detailedrace20909
  Detailedrace20917
  Detailedrace20925
  Detailedrace20933
  Detailedrace20941
  Detailedrace20958
  Detailedrace20966
  Detailedrace20974
  Detailedrace20982
  Detailedrace21006
  Detailedrace21014
  Detailedrace21022
  Detailedrace21030
  Detailedrace21048
  Detailedrace25007
  Detailedrace21089
  Detailedrace21097
  Detailedrace21105
  Detailedrace21113
  Detailedrace21121
  Detailedrace21139
  Detailedrace21147
  Detailedrace21154
  Detailedrace21162
  Detailedrace21188
  Detailedrace21196
  Detailedrace21204
  Detailedrace21212
  Detailedrace21220
  Detailedrace21238
  Detailedrace21246
  Detailedrace21253
  Detailedrace21261
  Detailedrace21279
  Detailedrace21295
  Detailedrace21311
  DetailedraceAsku
  DetailedraceOth
  DetailedraceUnk
}

pub const detailedrace: List(Detailedrace) = [
  Detailedrace10041,
  Detailedrace10066,
  Detailedrace15792,
  Detailedrace12120,
  Detailedrace10454,
  Detailedrace16543,
  Detailedrace11940,
  Detailedrace11957,
  Detailedrace11874,
  Detailedrace10082,
  Detailedrace30122,
  Detailedrace16881,
  Detailedrace13920,
  Detailedrace30155,
  Detailedrace30163,
  Detailedrace10108,
  Detailedrace10165,
  Detailedrace10215,
  Detailedrace10249,
  Detailedrace10264,
  Detailedrace13664,
  Detailedrace10280,
  Detailedrace30247,
  Detailedrace30254,
  Detailedrace12344,
  Detailedrace12658,
  Detailedrace10462,
  Detailedrace11247,
  Detailedrace10330,
  Detailedrace30312,
  Detailedrace11254,
  Detailedrace10603,
  Detailedrace30346,
  Detailedrace30353,
  Detailedrace30361,
  Detailedrace14308,
  Detailedrace30387,
  Detailedrace30395,
  Detailedrace12351,
  Detailedrace30411,
  Detailedrace14175,
  Detailedrace10355,
  Detailedrace30445,
  Detailedrace11262,
  Detailedrace14183,
  Detailedrace10371,
  Detailedrace16113,
  Detailedrace30494,
  Detailedrace14191,
  Detailedrace30510,
  Detailedrace10470,
  Detailedrace30536,
  Detailedrace10413,
  Detailedrace30551,
  Detailedrace10421,
  Detailedrace10546,
  Detailedrace10447,
  Detailedrace30593,
  Detailedrace30601,
  Detailedrace12237,
  Detailedrace12245,
  Detailedrace10769,
  Detailedrace12864,
  Detailedrace10785,
  Detailedrace14209,
  Detailedrace13938,
  Detailedrace14654,
  Detailedrace30692,
  Detailedrace30700,
  Detailedrace30718,
  Detailedrace10827,
  Detailedrace10868,
  Detailedrace30742,
  Detailedrace30759,
  Detailedrace30767,
  Detailedrace10884,
  Detailedrace10892,
  Detailedrace30791,
  Detailedrace30809,
  Detailedrace30817,
  Detailedrace10900,
  Detailedrace11023,
  Detailedrace11064,
  Detailedrace30858,
  Detailedrace30866,
  Detailedrace11098,
  Detailedrace30882,
  Detailedrace10553,
  Detailedrace11148,
  Detailedrace11239,
  Detailedrace30924,
  Detailedrace11536,
  Detailedrace11551,
  Detailedrace30957,
  Detailedrace11627,
  Detailedrace14795,
  Detailedrace11155,
  Detailedrace11650,
  Detailedrace11569,
  Detailedrace31013,
  Detailedrace17251,
  Detailedrace11676,
  Detailedrace11692,
  Detailedrace31054,
  Detailedrace11718,
  Detailedrace13946,
  Detailedrace11163,
  Detailedrace31096,
  Detailedrace15602,
  Detailedrace17079,
  Detailedrace16071,
  Detailedrace10801,
  Detailedrace11734,
  Detailedrace11783,
  Detailedrace15917,
  Detailedrace12625,
  Detailedrace16659,
  Detailedrace16832,
  Detailedrace11809,
  Detailedrace11825,
  Detailedrace11841,
  Detailedrace11866,
  Detailedrace31245,
  Detailedrace16683,
  Detailedrace11890,
  Detailedrace31278,
  Detailedrace11916,
  Detailedrace12070,
  Detailedrace16139,
  Detailedrace12096,
  Detailedrace31328,
  Detailedrace12112,
  Detailedrace31344,
  Detailedrace31351,
  Detailedrace31369,
  Detailedrace10579,
  Detailedrace14662,
  Detailedrace15883,
  Detailedrace15198,
  Detailedrace31419,
  Detailedrace10926,
  Detailedrace11965,
  Detailedrace11973,
  Detailedrace31450,
  Detailedrace14670,
  Detailedrace15800,
  Detailedrace15990,
  Detailedrace10934,
  Detailedrace12393,
  Detailedrace14720,
  Detailedrace31526,
  Detailedrace31534,
  Detailedrace15909,
  Detailedrace31559,
  Detailedrace12500,
  Detailedrace12252,
  Detailedrace10561,
  Detailedrace31591,
  Detailedrace16154,
  Detailedrace11288,
  Detailedrace31625,
  Detailedrace12526,
  Detailedrace14217,
  Detailedrace14225,
  Detailedrace16055,
  Detailedrace12567,
  Detailedrace17293,
  Detailedrace31690,
  Detailedrace31708,
  Detailedrace12609,
  Detailedrace12369,
  Detailedrace31732,
  Detailedrace31740,
  Detailedrace12427,
  Detailedrace11296,
  Detailedrace31773,
  Detailedrace11304,
  Detailedrace31799,
  Detailedrace31807,
  Detailedrace12641,
  Detailedrace31823,
  Detailedrace31831,
  Detailedrace31849,
  Detailedrace12674,
  Detailedrace14811,
  Detailedrace31872,
  Detailedrace17269,
  Detailedrace31898,
  Detailedrace12690,
  Detailedrace16972,
  Detailedrace10835,
  Detailedrace12757,
  Detailedrace12716,
  Detailedrace31955,
  Detailedrace31963,
  Detailedrace31971,
  Detailedrace17277,
  Detailedrace12302,
  Detailedrace13599,
  Detailedrace12799,
  Detailedrace14423,
  Detailedrace13607,
  Detailedrace32045,
  Detailedrace12815,
  Detailedrace12823,
  Detailedrace12831,
  Detailedrace12856,
  Detailedrace32094,
  Detailedrace13136,
  Detailedrace32110,
  Detailedrace11577,
  Detailedrace10132,
  Detailedrace12971,
  Detailedrace14233,
  Detailedrace13953,
  Detailedrace12997,
  Detailedrace13011,
  Detailedrace14688,
  Detailedrace11171,
  Detailedrace13037,
  Detailedrace32227,
  Detailedrace15107,
  Detailedrace32243,
  Detailedrace11981,
  Detailedrace13052,
  Detailedrace13078,
  Detailedrace32284,
  Detailedrace13060,
  Detailedrace15206,
  Detailedrace13094,
  Detailedrace13102,
  Detailedrace13128,
  Detailedrace32342,
  Detailedrace32359,
  Detailedrace32367,
  Detailedrace32375,
  Detailedrace13193,
  Detailedrace13219,
  Detailedrace12229,
  Detailedrace13326,
  Detailedrace12260,
  Detailedrace11320,
  Detailedrace11338,
  Detailedrace11346,
  Detailedrace11353,
  Detailedrace14241,
  Detailedrace13235,
  Detailedrace11361,
  Detailedrace32508,
  Detailedrace10140,
  Detailedrace32524,
  Detailedrace11379,
  Detailedrace32540,
  Detailedrace14258,
  Detailedrace10488,
  Detailedrace32573,
  Detailedrace14266,
  Detailedrace16188,
  Detailedrace13144,
  Detailedrace11999,
  Detailedrace16196,
  Detailedrace15214,
  Detailedrace13318,
  Detailedrace13409,
  Detailedrace13425,
  Detailedrace32672,
  Detailedrace12005,
  Detailedrace13441,
  Detailedrace13482,
  Detailedrace14274,
  Detailedrace13508,
  Detailedrace32730,
  Detailedrace13524,
  Detailedrace12278,
  Detailedrace17285,
  Detailedrace32771,
  Detailedrace14548,
  Detailedrace16816,
  Detailedrace32805,
  Detailedrace13268,
  Detailedrace13540,
  Detailedrace16204,
  Detailedrace32847,
  Detailedrace32854,
  Detailedrace13565,
  Detailedrace12286,
  Detailedrace10157,
  Detailedrace32896,
  Detailedrace13581,
  Detailedrace13615,
  Detailedrace13631,
  Detailedrace13656,
  Detailedrace32946,
  Detailedrace11387,
  Detailedrace11395,
  Detailedrace13680,
  Detailedrace11585,
  Detailedrace13706,
  Detailedrace14282,
  Detailedrace13722,
  Detailedrace12872,
  Detailedrace13748,
  Detailedrace13961,
  Detailedrace33050,
  Detailedrace13763,
  Detailedrace13276,
  Detailedrace12377,
  Detailedrace33092,
  Detailedrace10496,
  Detailedrace13458,
  Detailedrace11593,
  Detailedrace15222,
  Detailedrace12179,
  Detailedrace12385,
  Detailedrace13789,
  Detailedrace33175,
  Detailedrace13805,
  Detailedrace33191,
  Detailedrace12401,
  Detailedrace33217,
  Detailedrace12203,
  Detailedrace13870,
  Detailedrace12419,
  Detailedrace13466,
  Detailedrace15230,
  Detailedrace13896,
  Detailedrace15248,
  Detailedrace33290,
  Detailedrace10223,
  Detailedrace10959,
  Detailedrace11031,
  Detailedrace14290,
  Detailedrace14696,
  Detailedrace15982,
  Detailedrace14829,
  Detailedrace33373,
  Detailedrace33381,
  Detailedrace33399,
  Detailedrace33407,
  Detailedrace33415,
  Detailedrace14035,
  Detailedrace12880,
  Detailedrace33449,
  Detailedrace33456,
  Detailedrace12898,
  Detailedrace14050,
  Detailedrace14092,
  Detailedrace14118,
  Detailedrace14142,
  Detailedrace14167,
  Detailedrace14332,
  Detailedrace16048,
  Detailedrace13334,
  Detailedrace14399,
  Detailedrace33563,
  Detailedrace33571,
  Detailedrace14415,
  Detailedrace33597,
  Detailedrace33605,
  Detailedrace13342,
  Detailedrace14456,
  Detailedrace14464,
  Detailedrace13359,
  Detailedrace33654,
  Detailedrace33662,
  Detailedrace14480,
  Detailedrace33688,
  Detailedrace14530,
  Detailedrace17186,
  Detailedrace33712,
  Detailedrace14563,
  Detailedrace33738,
  Detailedrace16246,
  Detailedrace33753,
  Detailedrace15008,
  Detailedrace14605,
  Detailedrace33787,
  Detailedrace33795,
  Detailedrace14621,
  Detailedrace14431,
  Detailedrace12013,
  Detailedrace33837,
  Detailedrace12435,
  Detailedrace33852,
  Detailedrace14837,
  Detailedrace33878,
  Detailedrace14647,
  Detailedrace14746,
  Detailedrace14761,
  Detailedrace14753,
  Detailedrace33928,
  Detailedrace13284,
  Detailedrace13151,
  Detailedrace14787,
  Detailedrace33969,
  Detailedrace14878,
  Detailedrace14845,
  Detailedrace16253,
  Detailedrace12021,
  Detailedrace14894,
  Detailedrace14902,
  Detailedrace14928,
  Detailedrace14944,
  Detailedrace14951,
  Detailedrace14977,
  Detailedrace14985,
  Detailedrace14993,
  Detailedrace15016,
  Detailedrace15024,
  Detailedrace15032,
  Detailedrace15073,
  Detailedrace15081,
  Detailedrace15099,
  Detailedrace15115,
  Detailedrace15123,
  Detailedrace15156,
  Detailedrace15180,
  Detailedrace15263,
  Detailedrace14316,
  Detailedrace15412,
  Detailedrace34223,
  Detailedrace34231,
  Detailedrace10843,
  Detailedrace15438,
  Detailedrace12195,
  Detailedrace34272,
  Detailedrace15453,
  Detailedrace11411,
  Detailedrace11429,
  Detailedrace10611,
  Detailedrace34322,
  Detailedrace34330,
  Detailedrace15479,
  Detailedrace17335,
  Detailedrace34363,
  Detailedrace34371,
  Detailedrace16279,
  Detailedrace15495,
  Detailedrace15511,
  Detailedrace15537,
  Detailedrace15545,
  Detailedrace15529,
  Detailedrace34447,
  Detailedrace11437,
  Detailedrace34462,
  Detailedrace15560,
  Detailedrace15586,
  Detailedrace14589,
  Detailedrace15271,
  Detailedrace10181,
  Detailedrace15065,
  Detailedrace14324,
  Detailedrace34546,
  Detailedrace15743,
  Detailedrace12294,
  Detailedrace10504,
  Detailedrace10629,
  Detailedrace11635,
  Detailedrace34603,
  Detailedrace34611,
  Detailedrace16295,
  Detailedrace34637,
  Detailedrace34645,
  Detailedrace15289,
  Detailedrace11452,
  Detailedrace15628,
  Detailedrace14704,
  Detailedrace34694,
  Detailedrace15669,
  Detailedrace34710,
  Detailedrace34728,
  Detailedrace12922,
  Detailedrace15735,
  Detailedrace13292,
  Detailedrace16261,
  Detailedrace15768,
  Detailedrace15784,
  Detailedrace34793,
  Detailedrace11007,
  Detailedrace34819,
  Detailedrace34827,
  Detailedrace15826,
  Detailedrace15842,
  Detailedrace15867,
  Detailedrace16022,
  Detailedrace12583,
  Detailedrace16030,
  Detailedrace16097,
  Detailedrace34900,
  Detailedrace16436,
  Detailedrace15297,
  Detailedrace15941,
  Detailedrace15305,
  Detailedrace15313,
  Detailedrace15321,
  Detailedrace13367,
  Detailedrace11460,
  Detailedrace34991,
  Detailedrace12443,
  Detailedrace10231,
  Detailedrace11049,
  Detailedrace35030,
  Detailedrace16329,
  Detailedrace16451,
  Detailedrace15339,
  Detailedrace11445,
  Detailedrace16337,
  Detailedrace15347,
  Detailedrace15354,
  Detailedrace16493,
  Detailedrace14712,
  Detailedrace14340,
  Detailedrace16519,
  Detailedrace12450,
  Detailedrace35162,
  Detailedrace15370,
  Detailedrace12310,
  Detailedrace35196,
  Detailedrace17194,
  Detailedrace10637,
  Detailedrace13979,
  Detailedrace35238,
  Detailedrace13383,
  Detailedrace35253,
  Detailedrace13987,
  Detailedrace16345,
  Detailedrace11122,
  Detailedrace11601,
  Detailedrace35303,
  Detailedrace11932,
  Detailedrace14076,
  Detailedrace15719,
  Detailedrace12039,
  Detailedrace35352,
  Detailedrace35360,
  Detailedrace12047,
  Detailedrace12542,
  Detailedrace13995,
  Detailedrace35402,
  Detailedrace35410,
  Detailedrace16592,
  Detailedrace35436,
  Detailedrace12930,
  Detailedrace16618,
  Detailedrace10173,
  Detailedrace10512,
  Detailedrace12724,
  Detailedrace12054,
  Detailedrace15388,
  Detailedrace17202,
  Detailedrace12468,
  Detailedrace35535,
  Detailedrace11478,
  Detailedrace12948,
  Detailedrace10967,
  Detailedrace13375,
  Detailedrace16634,
  Detailedrace16675,
  Detailedrace35600,
  Detailedrace35618,
  Detailedrace12773,
  Detailedrace10975,
  Detailedrace11189,
  Detailedrace35659,
  Detailedrace16360,
  Detailedrace15396,
  Detailedrace16709,
  Detailedrace16725,
  Detailedrace35709,
  Detailedrace14357,
  Detailedrace35725,
  Detailedrace12476,
  Detailedrace16378,
  Detailedrace16758,
  Detailedrace11197,
  Detailedrace14365,
  Detailedrace16774,
  Detailedrace16790,
  Detailedrace16808,
  Detailedrace10645,
  Detailedrace16857,
  Detailedrace35832,
  Detailedrace35840,
  Detailedrace16394,
  Detailedrace14001,
  Detailedrace12732,
  Detailedrace11486,
  Detailedrace10199,
  Detailedrace35907,
  Detailedrace16923,
  Detailedrace12484,
  Detailedrace11205,
  Detailedrace35949,
  Detailedrace16949,
  Detailedrace16964,
  Detailedrace16980,
  Detailedrace17004,
  Detailedrace17020,
  Detailedrace11213,
  Detailedrace36012,
  Detailedrace12955,
  Detailedrace17095,
  Detailedrace10652,
  Detailedrace16402,
  Detailedrace16410,
  Detailedrace17111,
  Detailedrace17152,
  Detailedrace17319,
  Detailedrace14373,
  Detailedrace36111,
  Detailedrace17178,
  Detailedrace16006,
  Detailedrace15149,
  Detailedrace17228,
  Detailedrace10660,
  Detailedrace17327,
  Detailedrace15164,
  Detailedrace17350,
  Detailedrace17376,
  Detailedrace17392,
  Detailedrace17400,
  Detailedrace17442,
  Detailedrace17418,
  Detailedrace17426,
  Detailedrace17434,
  Detailedrace17459,
  Detailedrace36285,
  Detailedrace17475,
  Detailedrace17483,
  Detailedrace17509,
  Detailedrace17525,
  Detailedrace17517,
  Detailedrace17541,
  Detailedrace17558,
  Detailedrace17574,
  Detailedrace17590,
  Detailedrace17616,
  Detailedrace17624,
  Detailedrace17657,
  Detailedrace17673,
  Detailedrace17681,
  Detailedrace17699,
  Detailedrace17707,
  Detailedrace17715,
  Detailedrace17756,
  Detailedrace17764,
  Detailedrace17772,
  Detailedrace17780,
  Detailedrace17806,
  Detailedrace17798,
  Detailedrace17814,
  Detailedrace17491,
  Detailedrace17533,
  Detailedrace17608,
  Detailedrace17632,
  Detailedrace17640,
  Detailedrace17749,
  Detailedrace17822,
  Detailedrace17913,
  Detailedrace17962,
  Detailedrace17996,
  Detailedrace18010,
  Detailedrace18036,
  Detailedrace18051,
  Detailedrace18077,
  Detailedrace17830,
  Detailedrace17848,
  Detailedrace17855,
  Detailedrace17863,
  Detailedrace17871,
  Detailedrace17889,
  Detailedrace17665,
  Detailedrace17897,
  Detailedrace17905,
  Detailedrace17939,
  Detailedrace17954,
  Detailedrace17947,
  Detailedrace17988,
  Detailedrace18028,
  Detailedrace18044,
  Detailedrace18069,
  Detailedrace17582,
  Detailedrace17723,
  Detailedrace17731,
  Detailedrace17921,
  Detailedrace17970,
  Detailedrace18085,
  Detailedrace18093,
  Detailedrace18259,
  Detailedrace19661,
  Detailedrace19943,
  Detailedrace20081,
  Detailedrace41871,
  Detailedrace19729,
  Detailedrace19737,
  Detailedrace19745,
  Detailedrace19844,
  Detailedrace19869,
  Detailedrace19752,
  Detailedrace18408,
  Detailedrace19760,
  Detailedrace19778,
  Detailedrace37044,
  Detailedrace20149,
  Detailedrace19786,
  Detailedrace19968,
  Detailedrace19794,
  Detailedrace19927,
  Detailedrace37101,
  Detailedrace37119,
  Detailedrace19935,
  Detailedrace20073,
  Detailedrace20115,
  Detailedrace20123,
  Detailedrace19851,
  Detailedrace20131,
  Detailedrace19901,
  Detailedrace20156,
  Detailedrace37200,
  Detailedrace19950,
  Detailedrace19976,
  Detailedrace19877,
  Detailedrace20164,
  Detailedrace20172,
  Detailedrace19992,
  Detailedrace19802,
  Detailedrace19810,
  Detailedrace19885,
  Detailedrace19828,
  Detailedrace20008,
  Detailedrace19695,
  Detailedrace20263,
  Detailedrace20180,
  Detailedrace37358,
  Detailedrace20206,
  Detailedrace20214,
  Detailedrace20222,
  Detailedrace20248,
  Detailedrace20024,
  Detailedrace37416,
  Detailedrace19703,
  Detailedrace37432,
  Detailedrace19984,
  Detailedrace37457,
  Detailedrace37465,
  Detailedrace18499,
  Detailedrace18507,
  Detailedrace18523,
  Detailedrace19091,
  Detailedrace37515,
  Detailedrace18424,
  Detailedrace37531,
  Detailedrace18481,
  Detailedrace18622,
  Detailedrace18630,
  Detailedrace37572,
  Detailedrace18713,
  Detailedrace18457,
  Detailedrace18515,
  Detailedrace18531,
  Detailedrace18549,
  Detailedrace18564,
  Detailedrace18572,
  Detailedrace18606,
  Detailedrace18580,
  Detailedrace18648,
  Detailedrace18655,
  Detailedrace18663,
  Detailedrace18671,
  Detailedrace18689,
  Detailedrace18895,
  Detailedrace19331,
  Detailedrace18721,
  Detailedrace18754,
  Detailedrace18762,
  Detailedrace18770,
  Detailedrace18788,
  Detailedrace18796,
  Detailedrace18804,
  Detailedrace18812,
  Detailedrace18838,
  Detailedrace18846,
  Detailedrace18861,
  Detailedrace37853,
  Detailedrace18739,
  Detailedrace18747,
  Detailedrace37887,
  Detailedrace18820,
  Detailedrace18853,
  Detailedrace18333,
  Detailedrace38612,
  Detailedrace18168,
  Detailedrace18176,
  Detailedrace18184,
  Detailedrace18192,
  Detailedrace18200,
  Detailedrace18218,
  Detailedrace18226,
  Detailedrace18267,
  Detailedrace18275,
  Detailedrace18234,
  Detailedrace18242,
  Detailedrace18309,
  Detailedrace18283,
  Detailedrace18291,
  Detailedrace18119,
  Detailedrace18317,
  Detailedrace38091,
  Detailedrace18325,
  Detailedrace18143,
  Detailedrace18341,
  Detailedrace18358,
  Detailedrace18374,
  Detailedrace18382,
  Detailedrace18960,
  Detailedrace18978,
  Detailedrace18986,
  Detailedrace19638,
  Detailedrace19349,
  Detailedrace19067,
  Detailedrace19075,
  Detailedrace38232,
  Detailedrace19133,
  Detailedrace19166,
  Detailedrace38265,
  Detailedrace19208,
  Detailedrace19299,
  Detailedrace19315,
  Detailedrace19356,
  Detailedrace19000,
  Detailedrace19109,
  Detailedrace19141,
  Detailedrace19158,
  Detailedrace18929,
  Detailedrace19620,
  Detailedrace19182,
  Detailedrace38380,
  Detailedrace19190,
  Detailedrace19224,
  Detailedrace19232,
  Detailedrace19257,
  Detailedrace19281,
  Detailedrace19497,
  Detailedrace19323,
  Detailedrace19364,
  Detailedrace19372,
  Detailedrace19380,
  Detailedrace19422,
  Detailedrace19539,
  Detailedrace19430,
  Detailedrace19463,
  Detailedrace19513,
  Detailedrace18937,
  Detailedrace19521,
  Detailedrace19596,
  Detailedrace19604,
  Detailedrace19240,
  Detailedrace19406,
  Detailedrace19398,
  Detailedrace19414,
  Detailedrace19570,
  Detailedrace19273,
  Detailedrace19042,
  Detailedrace19448,
  Detailedrace19455,
  Detailedrace19471,
  Detailedrace19489,
  Detailedrace18945,
  Detailedrace19554,
  Detailedrace19562,
  Detailedrace19588,
  Detailedrace19612,
  Detailedrace19646,
  Detailedrace18994,
  Detailedrace19026,
  Detailedrace19034,
  Detailedrace19059,
  Detailedrace19083,
  Detailedrace19117,
  Detailedrace19125,
  Detailedrace19216,
  Detailedrace19265,
  Detailedrace19307,
  Detailedrace38851,
  Detailedrace19505,
  Detailedrace19547,
  Detailedrace19018,
  Detailedrace38893,
  Detailedrace10694,
  Detailedrace38919,
  Detailedrace38927,
  Detailedrace38935,
  Detailedrace38943,
  Detailedrace38950,
  Detailedrace38968,
  Detailedrace38976,
  Detailedrace38984,
  Detailedrace38992,
  Detailedrace39008,
  Detailedrace39016,
  Detailedrace39024,
  Detailedrace39032,
  Detailedrace39040,
  Detailedrace39057,
  Detailedrace39065,
  Detailedrace39073,
  Detailedrace39081,
  Detailedrace39099,
  Detailedrace39107,
  Detailedrace39115,
  Detailedrace39123,
  Detailedrace39131,
  Detailedrace39149,
  Detailedrace39156,
  Detailedrace39164,
  Detailedrace39172,
  Detailedrace39180,
  Detailedrace39198,
  Detailedrace39206,
  Detailedrace39214,
  Detailedrace39222,
  Detailedrace39230,
  Detailedrace39248,
  Detailedrace39255,
  Detailedrace39263,
  Detailedrace39271,
  Detailedrace39289,
  Detailedrace39297,
  Detailedrace39305,
  Detailedrace39313,
  Detailedrace39321,
  Detailedrace39339,
  Detailedrace39347,
  Detailedrace39354,
  Detailedrace39362,
  Detailedrace39370,
  Detailedrace39388,
  Detailedrace39396,
  Detailedrace39404,
  Detailedrace39412,
  Detailedrace39420,
  Detailedrace39438,
  Detailedrace39446,
  Detailedrace39453,
  Detailedrace39461,
  Detailedrace39479,
  Detailedrace39487,
  Detailedrace39495,
  Detailedrace10710,
  Detailedrace39511,
  Detailedrace39529,
  Detailedrace39537,
  Detailedrace39545,
  Detailedrace39552,
  Detailedrace39560,
  Detailedrace39578,
  Detailedrace39586,
  Detailedrace39594,
  Detailedrace39602,
  Detailedrace39610,
  Detailedrace39628,
  Detailedrace39636,
  Detailedrace39644,
  Detailedrace39651,
  Detailedrace39669,
  Detailedrace39677,
  Detailedrace39685,
  Detailedrace39693,
  Detailedrace39701,
  Detailedrace39719,
  Detailedrace39727,
  Detailedrace39735,
  Detailedrace39743,
  Detailedrace39750,
  Detailedrace39768,
  Detailedrace39776,
  Detailedrace39784,
  Detailedrace39792,
  Detailedrace39800,
  Detailedrace39818,
  Detailedrace39826,
  Detailedrace39834,
  Detailedrace39842,
  Detailedrace39859,
  Detailedrace39867,
  Detailedrace39875,
  Detailedrace39883,
  Detailedrace39891,
  Detailedrace39909,
  Detailedrace39917,
  Detailedrace39925,
  Detailedrace39933,
  Detailedrace39941,
  Detailedrace39958,
  Detailedrace39966,
  Detailedrace39974,
  Detailedrace39982,
  Detailedrace39990,
  Detailedrace40006,
  Detailedrace40014,
  Detailedrace40022,
  Detailedrace40030,
  Detailedrace40048,
  Detailedrace40055,
  Detailedrace40063,
  Detailedrace40071,
  Detailedrace40089,
  Detailedrace40097,
  Detailedrace40105,
  Detailedrace40113,
  Detailedrace40121,
  Detailedrace40139,
  Detailedrace40147,
  Detailedrace40154,
  Detailedrace40162,
  Detailedrace40170,
  Detailedrace40188,
  Detailedrace40196,
  Detailedrace40204,
  Detailedrace40212,
  Detailedrace40220,
  Detailedrace40238,
  Detailedrace40246,
  Detailedrace40253,
  Detailedrace40261,
  Detailedrace40279,
  Detailedrace40287,
  Detailedrace40295,
  Detailedrace40303,
  Detailedrace40311,
  Detailedrace40329,
  Detailedrace40337,
  Detailedrace40345,
  Detailedrace40352,
  Detailedrace40360,
  Detailedrace40378,
  Detailedrace40386,
  Detailedrace40394,
  Detailedrace40402,
  Detailedrace40410,
  Detailedrace40428,
  Detailedrace40436,
  Detailedrace40444,
  Detailedrace40451,
  Detailedrace40469,
  Detailedrace40477,
  Detailedrace40485,
  Detailedrace40493,
  Detailedrace40501,
  Detailedrace40519,
  Detailedrace40527,
  Detailedrace40535,
  Detailedrace40543,
  Detailedrace40550,
  Detailedrace40568,
  Detailedrace40576,
  Detailedrace40584,
  Detailedrace40592,
  Detailedrace40600,
  Detailedrace40618,
  Detailedrace40626,
  Detailedrace40634,
  Detailedrace40642,
  Detailedrace40659,
  Detailedrace40667,
  Detailedrace40675,
  Detailedrace40683,
  Detailedrace40691,
  Detailedrace40709,
  Detailedrace40717,
  Detailedrace40725,
  Detailedrace40733,
  Detailedrace40741,
  Detailedrace40758,
  Detailedrace40766,
  Detailedrace40774,
  Detailedrace40782,
  Detailedrace40790,
  Detailedrace40808,
  Detailedrace40816,
  Detailedrace40824,
  Detailedrace40832,
  Detailedrace40840,
  Detailedrace40857,
  Detailedrace10702,
  Detailedrace40873,
  Detailedrace40881,
  Detailedrace40899,
  Detailedrace40907,
  Detailedrace40915,
  Detailedrace40923,
  Detailedrace40931,
  Detailedrace40949,
  Detailedrace40956,
  Detailedrace40964,
  Detailedrace40972,
  Detailedrace40980,
  Detailedrace40998,
  Detailedrace41004,
  Detailedrace41012,
  Detailedrace41020,
  Detailedrace41038,
  Detailedrace41046,
  Detailedrace41053,
  Detailedrace41061,
  Detailedrace41079,
  Detailedrace41087,
  Detailedrace41095,
  Detailedrace41103,
  Detailedrace41111,
  Detailedrace41129,
  Detailedrace41137,
  Detailedrace41145,
  Detailedrace41152,
  Detailedrace41160,
  Detailedrace41178,
  Detailedrace41186,
  Detailedrace41194,
  Detailedrace41202,
  Detailedrace41210,
  Detailedrace41228,
  Detailedrace41236,
  Detailedrace41244,
  Detailedrace41251,
  Detailedrace41269,
  Detailedrace41277,
  Detailedrace41285,
  Detailedrace41293,
  Detailedrace41301,
  Detailedrace41319,
  Detailedrace41327,
  Detailedrace41335,
  Detailedrace41343,
  Detailedrace41350,
  Detailedrace41368,
  Detailedrace41376,
  Detailedrace41384,
  Detailedrace41392,
  Detailedrace41400,
  Detailedrace41418,
  Detailedrace41426,
  Detailedrace41434,
  Detailedrace41442,
  Detailedrace41459,
  Detailedrace41467,
  Detailedrace10728,
  Detailedrace41483,
  Detailedrace10736,
  Detailedrace41509,
  Detailedrace41517,
  Detailedrace41525,
  Detailedrace41533,
  Detailedrace41541,
  Detailedrace41558,
  Detailedrace41566,
  Detailedrace41574,
  Detailedrace41582,
  Detailedrace41590,
  Detailedrace41608,
  Detailedrace41616,
  Detailedrace41624,
  Detailedrace41632,
  Detailedrace41640,
  Detailedrace41657,
  Detailedrace41665,
  Detailedrace41673,
  Detailedrace41681,
  Detailedrace41699,
  Detailedrace41707,
  Detailedrace41715,
  Detailedrace41723,
  Detailedrace41731,
  Detailedrace41749,
  Detailedrace41756,
  Detailedrace41764,
  Detailedrace41772,
  Detailedrace41780,
  Detailedrace41798,
  Detailedrace41806,
  Detailedrace41814,
  Detailedrace10744,
  Detailedrace41830,
  Detailedrace41848,
  Detailedrace41855,
  Detailedrace20297,
  Detailedrace20305,
  Detailedrace20313,
  Detailedrace20321,
  Detailedrace20339,
  Detailedrace20347,
  Detailedrace20354,
  Detailedrace20362,
  Detailedrace20370,
  Detailedrace20388,
  Detailedrace20396,
  Detailedrace20404,
  Detailedrace20412,
  Detailedrace20420,
  Detailedrace20438,
  Detailedrace20446,
  Detailedrace20453,
  Detailedrace20461,
  Detailedrace20479,
  Detailedrace20487,
  Detailedrace20495,
  Detailedrace20503,
  Detailedrace20511,
  Detailedrace20529,
  Detailedrace20560,
  Detailedrace20586,
  Detailedrace20602,
  Detailedrace20610,
  Detailedrace20628,
  Detailedrace20636,
  Detailedrace20644,
  Detailedrace20651,
  Detailedrace20669,
  Detailedrace41863,
  Detailedrace20677,
  Detailedrace20685,
  Detailedrace20693,
  Detailedrace20701,
  Detailedrace20719,
  Detailedrace20727,
  Detailedrace20735,
  Detailedrace20743,
  Detailedrace20750,
  Detailedrace20784,
  Detailedrace20792,
  Detailedrace20800,
  Detailedrace20818,
  Detailedrace20826,
  Detailedrace20834,
  Detailedrace20859,
  Detailedrace20867,
  Detailedrace20875,
  Detailedrace20883,
  Detailedrace20891,
  Detailedrace20909,
  Detailedrace20917,
  Detailedrace20925,
  Detailedrace20933,
  Detailedrace20941,
  Detailedrace20958,
  Detailedrace20966,
  Detailedrace20974,
  Detailedrace20982,
  Detailedrace21006,
  Detailedrace21014,
  Detailedrace21022,
  Detailedrace21030,
  Detailedrace21048,
  Detailedrace25007,
  Detailedrace21089,
  Detailedrace21097,
  Detailedrace21105,
  Detailedrace21113,
  Detailedrace21121,
  Detailedrace21139,
  Detailedrace21147,
  Detailedrace21154,
  Detailedrace21162,
  Detailedrace21188,
  Detailedrace21196,
  Detailedrace21204,
  Detailedrace21212,
  Detailedrace21220,
  Detailedrace21238,
  Detailedrace21246,
  Detailedrace21253,
  Detailedrace21261,
  Detailedrace21279,
  Detailedrace21295,
  Detailedrace21311,
  DetailedraceAsku,
  DetailedraceOth,
  DetailedraceUnk,
]

pub fn detailedrace_to_json(detailedrace: Detailedrace) -> Json {
  json.string(detailedrace_to_code(detailedrace))
}

pub fn detailedrace_to_code(detailedrace: Detailedrace) -> String {
  case detailedrace {
    Detailedrace10041 -> "1004-1"
    Detailedrace10066 -> "1006-6"
    Detailedrace15792 -> "1579-2"
    Detailedrace12120 -> "1212-0"
    Detailedrace10454 -> "1045-4"
    Detailedrace16543 -> "1654-3"
    Detailedrace11940 -> "1194-0"
    Detailedrace11957 -> "1195-7"
    Detailedrace11874 -> "1187-4"
    Detailedrace10082 -> "1008-2"
    Detailedrace30122 -> "3012-2"
    Detailedrace16881 -> "1688-1"
    Detailedrace13920 -> "1392-0"
    Detailedrace30155 -> "3015-5"
    Detailedrace30163 -> "3016-3"
    Detailedrace10108 -> "1010-8"
    Detailedrace10165 -> "1016-5"
    Detailedrace10215 -> "1021-5"
    Detailedrace10249 -> "1024-9"
    Detailedrace10264 -> "1026-4"
    Detailedrace13664 -> "1366-4"
    Detailedrace10280 -> "1028-0"
    Detailedrace30247 -> "3024-7"
    Detailedrace30254 -> "3025-4"
    Detailedrace12344 -> "1234-4"
    Detailedrace12658 -> "1265-8"
    Detailedrace10462 -> "1046-2"
    Detailedrace11247 -> "1124-7"
    Detailedrace10330 -> "1033-0"
    Detailedrace30312 -> "3031-2"
    Detailedrace11254 -> "1125-4"
    Detailedrace10603 -> "1060-3"
    Detailedrace30346 -> "3034-6"
    Detailedrace30353 -> "3035-3"
    Detailedrace30361 -> "3036-1"
    Detailedrace14308 -> "1430-8"
    Detailedrace30387 -> "3038-7"
    Detailedrace30395 -> "3039-5"
    Detailedrace12351 -> "1235-1"
    Detailedrace30411 -> "3041-1"
    Detailedrace14175 -> "1417-5"
    Detailedrace10355 -> "1035-5"
    Detailedrace30445 -> "3044-5"
    Detailedrace11262 -> "1126-2"
    Detailedrace14183 -> "1418-3"
    Detailedrace10371 -> "1037-1"
    Detailedrace16113 -> "1611-3"
    Detailedrace30494 -> "3049-4"
    Detailedrace14191 -> "1419-1"
    Detailedrace30510 -> "3051-0"
    Detailedrace10470 -> "1047-0"
    Detailedrace30536 -> "3053-6"
    Detailedrace10413 -> "1041-3"
    Detailedrace30551 -> "3055-1"
    Detailedrace10421 -> "1042-1"
    Detailedrace10546 -> "1054-6"
    Detailedrace10447 -> "1044-7"
    Detailedrace30593 -> "3059-3"
    Detailedrace30601 -> "3060-1"
    Detailedrace12237 -> "1223-7"
    Detailedrace12245 -> "1224-5"
    Detailedrace10769 -> "1076-9"
    Detailedrace12864 -> "1286-4"
    Detailedrace10785 -> "1078-5"
    Detailedrace14209 -> "1420-9"
    Detailedrace13938 -> "1393-8"
    Detailedrace14654 -> "1465-4"
    Detailedrace30692 -> "3069-2"
    Detailedrace30700 -> "3070-0"
    Detailedrace30718 -> "3071-8"
    Detailedrace10827 -> "1082-7"
    Detailedrace10868 -> "1086-8"
    Detailedrace30742 -> "3074-2"
    Detailedrace30759 -> "3075-9"
    Detailedrace30767 -> "3076-7"
    Detailedrace10884 -> "1088-4"
    Detailedrace10892 -> "1089-2"
    Detailedrace30791 -> "3079-1"
    Detailedrace30809 -> "3080-9"
    Detailedrace30817 -> "3081-7"
    Detailedrace10900 -> "1090-0"
    Detailedrace11023 -> "1102-3"
    Detailedrace11064 -> "1106-4"
    Detailedrace30858 -> "3085-8"
    Detailedrace30866 -> "3086-6"
    Detailedrace11098 -> "1109-8"
    Detailedrace30882 -> "3088-2"
    Detailedrace10553 -> "1055-3"
    Detailedrace11148 -> "1114-8"
    Detailedrace11239 -> "1123-9"
    Detailedrace30924 -> "3092-4"
    Detailedrace11536 -> "1153-6"
    Detailedrace11551 -> "1155-1"
    Detailedrace30957 -> "3095-7"
    Detailedrace11627 -> "1162-7"
    Detailedrace14795 -> "1479-5"
    Detailedrace11155 -> "1115-5"
    Detailedrace11650 -> "1165-0"
    Detailedrace11569 -> "1156-9"
    Detailedrace31013 -> "3101-3"
    Detailedrace17251 -> "1725-1"
    Detailedrace11676 -> "1167-6"
    Detailedrace11692 -> "1169-2"
    Detailedrace31054 -> "3105-4"
    Detailedrace11718 -> "1171-8"
    Detailedrace13946 -> "1394-6"
    Detailedrace11163 -> "1116-3"
    Detailedrace31096 -> "3109-6"
    Detailedrace15602 -> "1560-2"
    Detailedrace17079 -> "1707-9"
    Detailedrace16071 -> "1607-1"
    Detailedrace10801 -> "1080-1"
    Detailedrace11734 -> "1173-4"
    Detailedrace11783 -> "1178-3"
    Detailedrace15917 -> "1591-7"
    Detailedrace12625 -> "1262-5"
    Detailedrace16659 -> "1665-9"
    Detailedrace16832 -> "1683-2"
    Detailedrace11809 -> "1180-9"
    Detailedrace11825 -> "1182-5"
    Detailedrace11841 -> "1184-1"
    Detailedrace11866 -> "1186-6"
    Detailedrace31245 -> "3124-5"
    Detailedrace16683 -> "1668-3"
    Detailedrace11890 -> "1189-0"
    Detailedrace31278 -> "3127-8"
    Detailedrace11916 -> "1191-6"
    Detailedrace12070 -> "1207-0"
    Detailedrace16139 -> "1613-9"
    Detailedrace12096 -> "1209-6"
    Detailedrace31328 -> "3132-8"
    Detailedrace12112 -> "1211-2"
    Detailedrace31344 -> "3134-4"
    Detailedrace31351 -> "3135-1"
    Detailedrace31369 -> "3136-9"
    Detailedrace10579 -> "1057-9"
    Detailedrace14662 -> "1466-2"
    Detailedrace15883 -> "1588-3"
    Detailedrace15198 -> "1519-8"
    Detailedrace31419 -> "3141-9"
    Detailedrace10926 -> "1092-6"
    Detailedrace11965 -> "1196-5"
    Detailedrace11973 -> "1197-3"
    Detailedrace31450 -> "3145-0"
    Detailedrace14670 -> "1467-0"
    Detailedrace15800 -> "1580-0"
    Detailedrace15990 -> "1599-0"
    Detailedrace10934 -> "1093-4"
    Detailedrace12393 -> "1239-3"
    Detailedrace14720 -> "1472-0"
    Detailedrace31526 -> "3152-6"
    Detailedrace31534 -> "3153-4"
    Detailedrace15909 -> "1590-9"
    Detailedrace31559 -> "3155-9"
    Detailedrace12500 -> "1250-0"
    Detailedrace12252 -> "1225-2"
    Detailedrace10561 -> "1056-1"
    Detailedrace31591 -> "3159-1"
    Detailedrace16154 -> "1615-4"
    Detailedrace11288 -> "1128-8"
    Detailedrace31625 -> "3162-5"
    Detailedrace12526 -> "1252-6"
    Detailedrace14217 -> "1421-7"
    Detailedrace14225 -> "1422-5"
    Detailedrace16055 -> "1605-5"
    Detailedrace12567 -> "1256-7"
    Detailedrace17293 -> "1729-3"
    Detailedrace31690 -> "3169-0"
    Detailedrace31708 -> "3170-8"
    Detailedrace12609 -> "1260-9"
    Detailedrace12369 -> "1236-9"
    Detailedrace31732 -> "3173-2"
    Detailedrace31740 -> "3174-0"
    Detailedrace12427 -> "1242-7"
    Detailedrace11296 -> "1129-6"
    Detailedrace31773 -> "3177-3"
    Detailedrace11304 -> "1130-4"
    Detailedrace31799 -> "3179-9"
    Detailedrace31807 -> "3180-7"
    Detailedrace12641 -> "1264-1"
    Detailedrace31823 -> "3182-3"
    Detailedrace31831 -> "3183-1"
    Detailedrace31849 -> "3184-9"
    Detailedrace12674 -> "1267-4"
    Detailedrace14811 -> "1481-1"
    Detailedrace31872 -> "3187-2"
    Detailedrace17269 -> "1726-9"
    Detailedrace31898 -> "3189-8"
    Detailedrace12690 -> "1269-0"
    Detailedrace16972 -> "1697-2"
    Detailedrace10835 -> "1083-5"
    Detailedrace12757 -> "1275-7"
    Detailedrace12716 -> "1271-6"
    Detailedrace31955 -> "3195-5"
    Detailedrace31963 -> "3196-3"
    Detailedrace31971 -> "3197-1"
    Detailedrace17277 -> "1727-7"
    Detailedrace12302 -> "1230-2"
    Detailedrace13599 -> "1359-9"
    Detailedrace12799 -> "1279-9"
    Detailedrace14423 -> "1442-3"
    Detailedrace13607 -> "1360-7"
    Detailedrace32045 -> "3204-5"
    Detailedrace12815 -> "1281-5"
    Detailedrace12823 -> "1282-3"
    Detailedrace12831 -> "1283-1"
    Detailedrace12856 -> "1285-6"
    Detailedrace32094 -> "3209-4"
    Detailedrace13136 -> "1313-6"
    Detailedrace32110 -> "3211-0"
    Detailedrace11577 -> "1157-7"
    Detailedrace10132 -> "1013-2"
    Detailedrace12971 -> "1297-1"
    Detailedrace14233 -> "1423-3"
    Detailedrace13953 -> "1395-3"
    Detailedrace12997 -> "1299-7"
    Detailedrace13011 -> "1301-1"
    Detailedrace14688 -> "1468-8"
    Detailedrace11171 -> "1117-1"
    Detailedrace13037 -> "1303-7"
    Detailedrace32227 -> "3222-7"
    Detailedrace15107 -> "1510-7"
    Detailedrace32243 -> "3224-3"
    Detailedrace11981 -> "1198-1"
    Detailedrace13052 -> "1305-2"
    Detailedrace13078 -> "1307-8"
    Detailedrace32284 -> "3228-4"
    Detailedrace13060 -> "1306-0"
    Detailedrace15206 -> "1520-6"
    Detailedrace13094 -> "1309-4"
    Detailedrace13102 -> "1310-2"
    Detailedrace13128 -> "1312-8"
    Detailedrace32342 -> "3234-2"
    Detailedrace32359 -> "3235-9"
    Detailedrace32367 -> "3236-7"
    Detailedrace32375 -> "3237-5"
    Detailedrace13193 -> "1319-3"
    Detailedrace13219 -> "1321-9"
    Detailedrace12229 -> "1222-9"
    Detailedrace13326 -> "1332-6"
    Detailedrace12260 -> "1226-0"
    Detailedrace11320 -> "1132-0"
    Detailedrace11338 -> "1133-8"
    Detailedrace11346 -> "1134-6"
    Detailedrace11353 -> "1135-3"
    Detailedrace14241 -> "1424-1"
    Detailedrace13235 -> "1323-5"
    Detailedrace11361 -> "1136-1"
    Detailedrace32508 -> "3250-8"
    Detailedrace10140 -> "1014-0"
    Detailedrace32524 -> "3252-4"
    Detailedrace11379 -> "1137-9"
    Detailedrace32540 -> "3254-0"
    Detailedrace14258 -> "1425-8"
    Detailedrace10488 -> "1048-8"
    Detailedrace32573 -> "3257-3"
    Detailedrace14266 -> "1426-6"
    Detailedrace16188 -> "1618-8"
    Detailedrace13144 -> "1314-4"
    Detailedrace11999 -> "1199-9"
    Detailedrace16196 -> "1619-6"
    Detailedrace15214 -> "1521-4"
    Detailedrace13318 -> "1331-8"
    Detailedrace13409 -> "1340-9"
    Detailedrace13425 -> "1342-5"
    Detailedrace32672 -> "3267-2"
    Detailedrace12005 -> "1200-5"
    Detailedrace13441 -> "1344-1"
    Detailedrace13482 -> "1348-2"
    Detailedrace14274 -> "1427-4"
    Detailedrace13508 -> "1350-8"
    Detailedrace32730 -> "3273-0"
    Detailedrace13524 -> "1352-4"
    Detailedrace12278 -> "1227-8"
    Detailedrace17285 -> "1728-5"
    Detailedrace32771 -> "3277-1"
    Detailedrace14548 -> "1454-8"
    Detailedrace16816 -> "1681-6"
    Detailedrace32805 -> "3280-5"
    Detailedrace13268 -> "1326-8"
    Detailedrace13540 -> "1354-0"
    Detailedrace16204 -> "1620-4"
    Detailedrace32847 -> "3284-7"
    Detailedrace32854 -> "3285-4"
    Detailedrace13565 -> "1356-5"
    Detailedrace12286 -> "1228-6"
    Detailedrace10157 -> "1015-7"
    Detailedrace32896 -> "3289-6"
    Detailedrace13581 -> "1358-1"
    Detailedrace13615 -> "1361-5"
    Detailedrace13631 -> "1363-1"
    Detailedrace13656 -> "1365-6"
    Detailedrace32946 -> "3294-6"
    Detailedrace11387 -> "1138-7"
    Detailedrace11395 -> "1139-5"
    Detailedrace13680 -> "1368-0"
    Detailedrace11585 -> "1158-5"
    Detailedrace13706 -> "1370-6"
    Detailedrace14282 -> "1428-2"
    Detailedrace13722 -> "1372-2"
    Detailedrace12872 -> "1287-2"
    Detailedrace13748 -> "1374-8"
    Detailedrace13961 -> "1396-1"
    Detailedrace33050 -> "3305-0"
    Detailedrace13763 -> "1376-3"
    Detailedrace13276 -> "1327-6"
    Detailedrace12377 -> "1237-7"
    Detailedrace33092 -> "3309-2"
    Detailedrace10496 -> "1049-6"
    Detailedrace13458 -> "1345-8"
    Detailedrace11593 -> "1159-3"
    Detailedrace15222 -> "1522-2"
    Detailedrace12179 -> "1217-9"
    Detailedrace12385 -> "1238-5"
    Detailedrace13789 -> "1378-9"
    Detailedrace33175 -> "3317-5"
    Detailedrace13805 -> "1380-5"
    Detailedrace33191 -> "3319-1"
    Detailedrace12401 -> "1240-1"
    Detailedrace33217 -> "3321-7"
    Detailedrace12203 -> "1220-3"
    Detailedrace13870 -> "1387-0"
    Detailedrace12419 -> "1241-9"
    Detailedrace13466 -> "1346-6"
    Detailedrace15230 -> "1523-0"
    Detailedrace13896 -> "1389-6"
    Detailedrace15248 -> "1524-8"
    Detailedrace33290 -> "3329-0"
    Detailedrace10223 -> "1022-3"
    Detailedrace10959 -> "1095-9"
    Detailedrace11031 -> "1103-1"
    Detailedrace14290 -> "1429-0"
    Detailedrace14696 -> "1469-6"
    Detailedrace15982 -> "1598-2"
    Detailedrace14829 -> "1482-9"
    Detailedrace33373 -> "3337-3"
    Detailedrace33381 -> "3338-1"
    Detailedrace33399 -> "3339-9"
    Detailedrace33407 -> "3340-7"
    Detailedrace33415 -> "3341-5"
    Detailedrace14035 -> "1403-5"
    Detailedrace12880 -> "1288-0"
    Detailedrace33449 -> "3344-9"
    Detailedrace33456 -> "3345-6"
    Detailedrace12898 -> "1289-8"
    Detailedrace14050 -> "1405-0"
    Detailedrace14092 -> "1409-2"
    Detailedrace14118 -> "1411-8"
    Detailedrace14142 -> "1414-2"
    Detailedrace14167 -> "1416-7"
    Detailedrace14332 -> "1433-2"
    Detailedrace16048 -> "1604-8"
    Detailedrace13334 -> "1333-4"
    Detailedrace14399 -> "1439-9"
    Detailedrace33563 -> "3356-3"
    Detailedrace33571 -> "3357-1"
    Detailedrace14415 -> "1441-5"
    Detailedrace33597 -> "3359-7"
    Detailedrace33605 -> "3360-5"
    Detailedrace13342 -> "1334-2"
    Detailedrace14456 -> "1445-6"
    Detailedrace14464 -> "1446-4"
    Detailedrace13359 -> "1335-9"
    Detailedrace33654 -> "3365-4"
    Detailedrace33662 -> "3366-2"
    Detailedrace14480 -> "1448-0"
    Detailedrace33688 -> "3368-8"
    Detailedrace14530 -> "1453-0"
    Detailedrace17186 -> "1718-6"
    Detailedrace33712 -> "3371-2"
    Detailedrace14563 -> "1456-3"
    Detailedrace33738 -> "3373-8"
    Detailedrace16246 -> "1624-6"
    Detailedrace33753 -> "3375-3"
    Detailedrace15008 -> "1500-8"
    Detailedrace14605 -> "1460-5"
    Detailedrace33787 -> "3378-7"
    Detailedrace33795 -> "3379-5"
    Detailedrace14621 -> "1462-1"
    Detailedrace14431 -> "1443-1"
    Detailedrace12013 -> "1201-3"
    Detailedrace33837 -> "3383-7"
    Detailedrace12435 -> "1243-5"
    Detailedrace33852 -> "3385-2"
    Detailedrace14837 -> "1483-7"
    Detailedrace33878 -> "3387-8"
    Detailedrace14647 -> "1464-7"
    Detailedrace14746 -> "1474-6"
    Detailedrace14761 -> "1476-1"
    Detailedrace14753 -> "1475-3"
    Detailedrace33928 -> "3392-8"
    Detailedrace13284 -> "1328-4"
    Detailedrace13151 -> "1315-1"
    Detailedrace14787 -> "1478-7"
    Detailedrace33969 -> "3396-9"
    Detailedrace14878 -> "1487-8"
    Detailedrace14845 -> "1484-5"
    Detailedrace16253 -> "1625-3"
    Detailedrace12021 -> "1202-1"
    Detailedrace14894 -> "1489-4"
    Detailedrace14902 -> "1490-2"
    Detailedrace14928 -> "1492-8"
    Detailedrace14944 -> "1494-4"
    Detailedrace14951 -> "1495-1"
    Detailedrace14977 -> "1497-7"
    Detailedrace14985 -> "1498-5"
    Detailedrace14993 -> "1499-3"
    Detailedrace15016 -> "1501-6"
    Detailedrace15024 -> "1502-4"
    Detailedrace15032 -> "1503-2"
    Detailedrace15073 -> "1507-3"
    Detailedrace15081 -> "1508-1"
    Detailedrace15099 -> "1509-9"
    Detailedrace15115 -> "1511-5"
    Detailedrace15123 -> "1512-3"
    Detailedrace15156 -> "1515-6"
    Detailedrace15180 -> "1518-0"
    Detailedrace15263 -> "1526-3"
    Detailedrace14316 -> "1431-6"
    Detailedrace15412 -> "1541-2"
    Detailedrace34223 -> "3422-3"
    Detailedrace34231 -> "3423-1"
    Detailedrace10843 -> "1084-3"
    Detailedrace15438 -> "1543-8"
    Detailedrace12195 -> "1219-5"
    Detailedrace34272 -> "3427-2"
    Detailedrace15453 -> "1545-3"
    Detailedrace11411 -> "1141-1"
    Detailedrace11429 -> "1142-9"
    Detailedrace10611 -> "1061-1"
    Detailedrace34322 -> "3432-2"
    Detailedrace34330 -> "3433-0"
    Detailedrace15479 -> "1547-9"
    Detailedrace17335 -> "1733-5"
    Detailedrace34363 -> "3436-3"
    Detailedrace34371 -> "3437-1"
    Detailedrace16279 -> "1627-9"
    Detailedrace15495 -> "1549-5"
    Detailedrace15511 -> "1551-1"
    Detailedrace15537 -> "1553-7"
    Detailedrace15545 -> "1554-5"
    Detailedrace15529 -> "1552-9"
    Detailedrace34447 -> "3444-7"
    Detailedrace11437 -> "1143-7"
    Detailedrace34462 -> "3446-2"
    Detailedrace15560 -> "1556-0"
    Detailedrace15586 -> "1558-6"
    Detailedrace14589 -> "1458-9"
    Detailedrace15271 -> "1527-1"
    Detailedrace10181 -> "1018-1"
    Detailedrace15065 -> "1506-5"
    Detailedrace14324 -> "1432-4"
    Detailedrace34546 -> "3454-6"
    Detailedrace15743 -> "1574-3"
    Detailedrace12294 -> "1229-4"
    Detailedrace10504 -> "1050-4"
    Detailedrace10629 -> "1062-9"
    Detailedrace11635 -> "1163-5"
    Detailedrace34603 -> "3460-3"
    Detailedrace34611 -> "3461-1"
    Detailedrace16295 -> "1629-5"
    Detailedrace34637 -> "3463-7"
    Detailedrace34645 -> "3464-5"
    Detailedrace15289 -> "1528-9"
    Detailedrace11452 -> "1145-2"
    Detailedrace15628 -> "1562-8"
    Detailedrace14704 -> "1470-4"
    Detailedrace34694 -> "3469-4"
    Detailedrace15669 -> "1566-9"
    Detailedrace34710 -> "3471-0"
    Detailedrace34728 -> "3472-8"
    Detailedrace12922 -> "1292-2"
    Detailedrace15735 -> "1573-5"
    Detailedrace13292 -> "1329-2"
    Detailedrace16261 -> "1626-1"
    Detailedrace15768 -> "1576-8"
    Detailedrace15784 -> "1578-4"
    Detailedrace34793 -> "3479-3"
    Detailedrace11007 -> "1100-7"
    Detailedrace34819 -> "3481-9"
    Detailedrace34827 -> "3482-7"
    Detailedrace15826 -> "1582-6"
    Detailedrace15842 -> "1584-2"
    Detailedrace15867 -> "1586-7"
    Detailedrace16022 -> "1602-2"
    Detailedrace12583 -> "1258-3"
    Detailedrace16030 -> "1603-0"
    Detailedrace16097 -> "1609-7"
    Detailedrace34900 -> "3490-0"
    Detailedrace16436 -> "1643-6"
    Detailedrace15297 -> "1529-7"
    Detailedrace15941 -> "1594-1"
    Detailedrace15305 -> "1530-5"
    Detailedrace15313 -> "1531-3"
    Detailedrace15321 -> "1532-1"
    Detailedrace13367 -> "1336-7"
    Detailedrace11460 -> "1146-0"
    Detailedrace34991 -> "3499-1"
    Detailedrace12443 -> "1244-3"
    Detailedrace10231 -> "1023-1"
    Detailedrace11049 -> "1104-9"
    Detailedrace35030 -> "3503-0"
    Detailedrace16329 -> "1632-9"
    Detailedrace16451 -> "1645-1"
    Detailedrace15339 -> "1533-9"
    Detailedrace11445 -> "1144-5"
    Detailedrace16337 -> "1633-7"
    Detailedrace15347 -> "1534-7"
    Detailedrace15354 -> "1535-4"
    Detailedrace16493 -> "1649-3"
    Detailedrace14712 -> "1471-2"
    Detailedrace14340 -> "1434-0"
    Detailedrace16519 -> "1651-9"
    Detailedrace12450 -> "1245-0"
    Detailedrace35162 -> "3516-2"
    Detailedrace15370 -> "1537-0"
    Detailedrace12310 -> "1231-0"
    Detailedrace35196 -> "3519-6"
    Detailedrace17194 -> "1719-4"
    Detailedrace10637 -> "1063-7"
    Detailedrace13979 -> "1397-9"
    Detailedrace35238 -> "3523-8"
    Detailedrace13383 -> "1338-3"
    Detailedrace35253 -> "3525-3"
    Detailedrace13987 -> "1398-7"
    Detailedrace16345 -> "1634-5"
    Detailedrace11122 -> "1112-2"
    Detailedrace11601 -> "1160-1"
    Detailedrace35303 -> "3530-3"
    Detailedrace11932 -> "1193-2"
    Detailedrace14076 -> "1407-6"
    Detailedrace15719 -> "1571-9"
    Detailedrace12039 -> "1203-9"
    Detailedrace35352 -> "3535-2"
    Detailedrace35360 -> "3536-0"
    Detailedrace12047 -> "1204-7"
    Detailedrace12542 -> "1254-2"
    Detailedrace13995 -> "1399-5"
    Detailedrace35402 -> "3540-2"
    Detailedrace35410 -> "3541-0"
    Detailedrace16592 -> "1659-2"
    Detailedrace35436 -> "3543-6"
    Detailedrace12930 -> "1293-0"
    Detailedrace16618 -> "1661-8"
    Detailedrace10173 -> "1017-3"
    Detailedrace10512 -> "1051-2"
    Detailedrace12724 -> "1272-4"
    Detailedrace12054 -> "1205-4"
    Detailedrace15388 -> "1538-8"
    Detailedrace17202 -> "1720-2"
    Detailedrace12468 -> "1246-8"
    Detailedrace35535 -> "3553-5"
    Detailedrace11478 -> "1147-8"
    Detailedrace12948 -> "1294-8"
    Detailedrace10967 -> "1096-7"
    Detailedrace13375 -> "1337-5"
    Detailedrace16634 -> "1663-4"
    Detailedrace16675 -> "1667-5"
    Detailedrace35600 -> "3560-0"
    Detailedrace35618 -> "3561-8"
    Detailedrace12773 -> "1277-3"
    Detailedrace10975 -> "1097-5"
    Detailedrace11189 -> "1118-9"
    Detailedrace35659 -> "3565-9"
    Detailedrace16360 -> "1636-0"
    Detailedrace15396 -> "1539-6"
    Detailedrace16709 -> "1670-9"
    Detailedrace16725 -> "1672-5"
    Detailedrace35709 -> "3570-9"
    Detailedrace14357 -> "1435-7"
    Detailedrace35725 -> "3572-5"
    Detailedrace12476 -> "1247-6"
    Detailedrace16378 -> "1637-8"
    Detailedrace16758 -> "1675-8"
    Detailedrace11197 -> "1119-7"
    Detailedrace14365 -> "1436-5"
    Detailedrace16774 -> "1677-4"
    Detailedrace16790 -> "1679-0"
    Detailedrace16808 -> "1680-8"
    Detailedrace10645 -> "1064-5"
    Detailedrace16857 -> "1685-7"
    Detailedrace35832 -> "3583-2"
    Detailedrace35840 -> "3584-0"
    Detailedrace16394 -> "1639-4"
    Detailedrace14001 -> "1400-1"
    Detailedrace12732 -> "1273-2"
    Detailedrace11486 -> "1148-6"
    Detailedrace10199 -> "1019-9"
    Detailedrace35907 -> "3590-7"
    Detailedrace16923 -> "1692-3"
    Detailedrace12484 -> "1248-4"
    Detailedrace11205 -> "1120-5"
    Detailedrace35949 -> "3594-9"
    Detailedrace16949 -> "1694-9"
    Detailedrace16964 -> "1696-4"
    Detailedrace16980 -> "1698-0"
    Detailedrace17004 -> "1700-4"
    Detailedrace17020 -> "1702-0"
    Detailedrace11213 -> "1121-3"
    Detailedrace36012 -> "3601-2"
    Detailedrace12955 -> "1295-5"
    Detailedrace17095 -> "1709-5"
    Detailedrace10652 -> "1065-2"
    Detailedrace16402 -> "1640-2"
    Detailedrace16410 -> "1641-0"
    Detailedrace17111 -> "1711-1"
    Detailedrace17152 -> "1715-2"
    Detailedrace17319 -> "1731-9"
    Detailedrace14373 -> "1437-3"
    Detailedrace36111 -> "3611-1"
    Detailedrace17178 -> "1717-8"
    Detailedrace16006 -> "1600-6"
    Detailedrace15149 -> "1514-9"
    Detailedrace17228 -> "1722-8"
    Detailedrace10660 -> "1066-0"
    Detailedrace17327 -> "1732-7"
    Detailedrace15164 -> "1516-4"
    Detailedrace17350 -> "1735-0"
    Detailedrace17376 -> "1737-6"
    Detailedrace17392 -> "1739-2"
    Detailedrace17400 -> "1740-0"
    Detailedrace17442 -> "1744-2"
    Detailedrace17418 -> "1741-8"
    Detailedrace17426 -> "1742-6"
    Detailedrace17434 -> "1743-4"
    Detailedrace17459 -> "1745-9"
    Detailedrace36285 -> "3628-5"
    Detailedrace17475 -> "1747-5"
    Detailedrace17483 -> "1748-3"
    Detailedrace17509 -> "1750-9"
    Detailedrace17525 -> "1752-5"
    Detailedrace17517 -> "1751-7"
    Detailedrace17541 -> "1754-1"
    Detailedrace17558 -> "1755-8"
    Detailedrace17574 -> "1757-4"
    Detailedrace17590 -> "1759-0"
    Detailedrace17616 -> "1761-6"
    Detailedrace17624 -> "1762-4"
    Detailedrace17657 -> "1765-7"
    Detailedrace17673 -> "1767-3"
    Detailedrace17681 -> "1768-1"
    Detailedrace17699 -> "1769-9"
    Detailedrace17707 -> "1770-7"
    Detailedrace17715 -> "1771-5"
    Detailedrace17756 -> "1775-6"
    Detailedrace17764 -> "1776-4"
    Detailedrace17772 -> "1777-2"
    Detailedrace17780 -> "1778-0"
    Detailedrace17806 -> "1780-6"
    Detailedrace17798 -> "1779-8"
    Detailedrace17814 -> "1781-4"
    Detailedrace17491 -> "1749-1"
    Detailedrace17533 -> "1753-3"
    Detailedrace17608 -> "1760-8"
    Detailedrace17632 -> "1763-2"
    Detailedrace17640 -> "1764-0"
    Detailedrace17749 -> "1774-9"
    Detailedrace17822 -> "1782-2"
    Detailedrace17913 -> "1791-3"
    Detailedrace17962 -> "1796-2"
    Detailedrace17996 -> "1799-6"
    Detailedrace18010 -> "1801-0"
    Detailedrace18036 -> "1803-6"
    Detailedrace18051 -> "1805-1"
    Detailedrace18077 -> "1807-7"
    Detailedrace17830 -> "1783-0"
    Detailedrace17848 -> "1784-8"
    Detailedrace17855 -> "1785-5"
    Detailedrace17863 -> "1786-3"
    Detailedrace17871 -> "1787-1"
    Detailedrace17889 -> "1788-9"
    Detailedrace17665 -> "1766-5"
    Detailedrace17897 -> "1789-7"
    Detailedrace17905 -> "1790-5"
    Detailedrace17939 -> "1793-9"
    Detailedrace17954 -> "1795-4"
    Detailedrace17947 -> "1794-7"
    Detailedrace17988 -> "1798-8"
    Detailedrace18028 -> "1802-8"
    Detailedrace18044 -> "1804-4"
    Detailedrace18069 -> "1806-9"
    Detailedrace17582 -> "1758-2"
    Detailedrace17723 -> "1772-3"
    Detailedrace17731 -> "1773-1"
    Detailedrace17921 -> "1792-1"
    Detailedrace17970 -> "1797-0"
    Detailedrace18085 -> "1808-5"
    Detailedrace18093 -> "1809-3"
    Detailedrace18259 -> "1825-9"
    Detailedrace19661 -> "1966-1"
    Detailedrace19943 -> "1994-3"
    Detailedrace20081 -> "2008-1"
    Detailedrace41871 -> "4187-1"
    Detailedrace19729 -> "1972-9"
    Detailedrace19737 -> "1973-7"
    Detailedrace19745 -> "1974-5"
    Detailedrace19844 -> "1984-4"
    Detailedrace19869 -> "1986-9"
    Detailedrace19752 -> "1975-2"
    Detailedrace18408 -> "1840-8"
    Detailedrace19760 -> "1976-0"
    Detailedrace19778 -> "1977-8"
    Detailedrace37044 -> "3704-4"
    Detailedrace20149 -> "2014-9"
    Detailedrace19786 -> "1978-6"
    Detailedrace19968 -> "1996-8"
    Detailedrace19794 -> "1979-4"
    Detailedrace19927 -> "1992-7"
    Detailedrace37101 -> "3710-1"
    Detailedrace37119 -> "3711-9"
    Detailedrace19935 -> "1993-5"
    Detailedrace20073 -> "2007-3"
    Detailedrace20115 -> "2011-5"
    Detailedrace20123 -> "2012-3"
    Detailedrace19851 -> "1985-1"
    Detailedrace20131 -> "2013-1"
    Detailedrace19901 -> "1990-1"
    Detailedrace20156 -> "2015-6"
    Detailedrace37200 -> "3720-0"
    Detailedrace19950 -> "1995-0"
    Detailedrace19976 -> "1997-6"
    Detailedrace19877 -> "1987-7"
    Detailedrace20164 -> "2016-4"
    Detailedrace20172 -> "2017-2"
    Detailedrace19992 -> "1999-2"
    Detailedrace19802 -> "1980-2"
    Detailedrace19810 -> "1981-0"
    Detailedrace19885 -> "1988-5"
    Detailedrace19828 -> "1982-8"
    Detailedrace20008 -> "2000-8"
    Detailedrace19695 -> "1969-5"
    Detailedrace20263 -> "2026-3"
    Detailedrace20180 -> "2018-0"
    Detailedrace37358 -> "3735-8"
    Detailedrace20206 -> "2020-6"
    Detailedrace20214 -> "2021-4"
    Detailedrace20222 -> "2022-2"
    Detailedrace20248 -> "2024-8"
    Detailedrace20024 -> "2002-4"
    Detailedrace37416 -> "3741-6"
    Detailedrace19703 -> "1970-3"
    Detailedrace37432 -> "3743-2"
    Detailedrace19984 -> "1998-4"
    Detailedrace37457 -> "3745-7"
    Detailedrace37465 -> "3746-5"
    Detailedrace18499 -> "1849-9"
    Detailedrace18507 -> "1850-7"
    Detailedrace18523 -> "1852-3"
    Detailedrace19091 -> "1909-1"
    Detailedrace37515 -> "3751-5"
    Detailedrace18424 -> "1842-4"
    Detailedrace37531 -> "3753-1"
    Detailedrace18481 -> "1848-1"
    Detailedrace18622 -> "1862-2"
    Detailedrace18630 -> "1863-0"
    Detailedrace37572 -> "3757-2"
    Detailedrace18713 -> "1871-3"
    Detailedrace18457 -> "1845-7"
    Detailedrace18515 -> "1851-5"
    Detailedrace18531 -> "1853-1"
    Detailedrace18549 -> "1854-9"
    Detailedrace18564 -> "1856-4"
    Detailedrace18572 -> "1857-2"
    Detailedrace18606 -> "1860-6"
    Detailedrace18580 -> "1858-0"
    Detailedrace18648 -> "1864-8"
    Detailedrace18655 -> "1865-5"
    Detailedrace18663 -> "1866-3"
    Detailedrace18671 -> "1867-1"
    Detailedrace18689 -> "1868-9"
    Detailedrace18895 -> "1889-5"
    Detailedrace19331 -> "1933-1"
    Detailedrace18721 -> "1872-1"
    Detailedrace18754 -> "1875-4"
    Detailedrace18762 -> "1876-2"
    Detailedrace18770 -> "1877-0"
    Detailedrace18788 -> "1878-8"
    Detailedrace18796 -> "1879-6"
    Detailedrace18804 -> "1880-4"
    Detailedrace18812 -> "1881-2"
    Detailedrace18838 -> "1883-8"
    Detailedrace18846 -> "1884-6"
    Detailedrace18861 -> "1886-1"
    Detailedrace37853 -> "3785-3"
    Detailedrace18739 -> "1873-9"
    Detailedrace18747 -> "1874-7"
    Detailedrace37887 -> "3788-7"
    Detailedrace18820 -> "1882-0"
    Detailedrace18853 -> "1885-3"
    Detailedrace18333 -> "1833-3"
    Detailedrace38612 -> "3861-2"
    Detailedrace18168 -> "1816-8"
    Detailedrace18176 -> "1817-6"
    Detailedrace18184 -> "1818-4"
    Detailedrace18192 -> "1819-2"
    Detailedrace18200 -> "1820-0"
    Detailedrace18218 -> "1821-8"
    Detailedrace18226 -> "1822-6"
    Detailedrace18267 -> "1826-7"
    Detailedrace18275 -> "1827-5"
    Detailedrace18234 -> "1823-4"
    Detailedrace18242 -> "1824-2"
    Detailedrace18309 -> "1830-9"
    Detailedrace18283 -> "1828-3"
    Detailedrace18291 -> "1829-1"
    Detailedrace18119 -> "1811-9"
    Detailedrace18317 -> "1831-7"
    Detailedrace38091 -> "3809-1"
    Detailedrace18325 -> "1832-5"
    Detailedrace18143 -> "1814-3"
    Detailedrace18341 -> "1834-1"
    Detailedrace18358 -> "1835-8"
    Detailedrace18374 -> "1837-4"
    Detailedrace18382 -> "1838-2"
    Detailedrace18960 -> "1896-0"
    Detailedrace18978 -> "1897-8"
    Detailedrace18986 -> "1898-6"
    Detailedrace19638 -> "1963-8"
    Detailedrace19349 -> "1934-9"
    Detailedrace19067 -> "1906-7"
    Detailedrace19075 -> "1907-5"
    Detailedrace38232 -> "3823-2"
    Detailedrace19133 -> "1913-3"
    Detailedrace19166 -> "1916-6"
    Detailedrace38265 -> "3826-5"
    Detailedrace19208 -> "1920-8"
    Detailedrace19299 -> "1929-9"
    Detailedrace19315 -> "1931-5"
    Detailedrace19356 -> "1935-6"
    Detailedrace19000 -> "1900-0"
    Detailedrace19109 -> "1910-9"
    Detailedrace19141 -> "1914-1"
    Detailedrace19158 -> "1915-8"
    Detailedrace18929 -> "1892-9"
    Detailedrace19620 -> "1962-0"
    Detailedrace19182 -> "1918-2"
    Detailedrace38380 -> "3838-0"
    Detailedrace19190 -> "1919-0"
    Detailedrace19224 -> "1922-4"
    Detailedrace19232 -> "1923-2"
    Detailedrace19257 -> "1925-7"
    Detailedrace19281 -> "1928-1"
    Detailedrace19497 -> "1949-7"
    Detailedrace19323 -> "1932-3"
    Detailedrace19364 -> "1936-4"
    Detailedrace19372 -> "1937-2"
    Detailedrace19380 -> "1938-0"
    Detailedrace19422 -> "1942-2"
    Detailedrace19539 -> "1953-9"
    Detailedrace19430 -> "1943-0"
    Detailedrace19463 -> "1946-3"
    Detailedrace19513 -> "1951-3"
    Detailedrace18937 -> "1893-7"
    Detailedrace19521 -> "1952-1"
    Detailedrace19596 -> "1959-6"
    Detailedrace19604 -> "1960-4"
    Detailedrace19240 -> "1924-0"
    Detailedrace19406 -> "1940-6"
    Detailedrace19398 -> "1939-8"
    Detailedrace19414 -> "1941-4"
    Detailedrace19570 -> "1957-0"
    Detailedrace19273 -> "1927-3"
    Detailedrace19042 -> "1904-2"
    Detailedrace19448 -> "1944-8"
    Detailedrace19455 -> "1945-5"
    Detailedrace19471 -> "1947-1"
    Detailedrace19489 -> "1948-9"
    Detailedrace18945 -> "1894-5"
    Detailedrace19554 -> "1955-4"
    Detailedrace19562 -> "1956-2"
    Detailedrace19588 -> "1958-8"
    Detailedrace19612 -> "1961-2"
    Detailedrace19646 -> "1964-6"
    Detailedrace18994 -> "1899-4"
    Detailedrace19026 -> "1902-6"
    Detailedrace19034 -> "1903-4"
    Detailedrace19059 -> "1905-9"
    Detailedrace19083 -> "1908-3"
    Detailedrace19117 -> "1911-7"
    Detailedrace19125 -> "1912-5"
    Detailedrace19216 -> "1921-6"
    Detailedrace19265 -> "1926-5"
    Detailedrace19307 -> "1930-7"
    Detailedrace38851 -> "3885-1"
    Detailedrace19505 -> "1950-5"
    Detailedrace19547 -> "1954-7"
    Detailedrace19018 -> "1901-8"
    Detailedrace38893 -> "3889-3"
    Detailedrace10694 -> "1069-4"
    Detailedrace38919 -> "3891-9"
    Detailedrace38927 -> "3892-7"
    Detailedrace38935 -> "3893-5"
    Detailedrace38943 -> "3894-3"
    Detailedrace38950 -> "3895-0"
    Detailedrace38968 -> "3896-8"
    Detailedrace38976 -> "3897-6"
    Detailedrace38984 -> "3898-4"
    Detailedrace38992 -> "3899-2"
    Detailedrace39008 -> "3900-8"
    Detailedrace39016 -> "3901-6"
    Detailedrace39024 -> "3902-4"
    Detailedrace39032 -> "3903-2"
    Detailedrace39040 -> "3904-0"
    Detailedrace39057 -> "3905-7"
    Detailedrace39065 -> "3906-5"
    Detailedrace39073 -> "3907-3"
    Detailedrace39081 -> "3908-1"
    Detailedrace39099 -> "3909-9"
    Detailedrace39107 -> "3910-7"
    Detailedrace39115 -> "3911-5"
    Detailedrace39123 -> "3912-3"
    Detailedrace39131 -> "3913-1"
    Detailedrace39149 -> "3914-9"
    Detailedrace39156 -> "3915-6"
    Detailedrace39164 -> "3916-4"
    Detailedrace39172 -> "3917-2"
    Detailedrace39180 -> "3918-0"
    Detailedrace39198 -> "3919-8"
    Detailedrace39206 -> "3920-6"
    Detailedrace39214 -> "3921-4"
    Detailedrace39222 -> "3922-2"
    Detailedrace39230 -> "3923-0"
    Detailedrace39248 -> "3924-8"
    Detailedrace39255 -> "3925-5"
    Detailedrace39263 -> "3926-3"
    Detailedrace39271 -> "3927-1"
    Detailedrace39289 -> "3928-9"
    Detailedrace39297 -> "3929-7"
    Detailedrace39305 -> "3930-5"
    Detailedrace39313 -> "3931-3"
    Detailedrace39321 -> "3932-1"
    Detailedrace39339 -> "3933-9"
    Detailedrace39347 -> "3934-7"
    Detailedrace39354 -> "3935-4"
    Detailedrace39362 -> "3936-2"
    Detailedrace39370 -> "3937-0"
    Detailedrace39388 -> "3938-8"
    Detailedrace39396 -> "3939-6"
    Detailedrace39404 -> "3940-4"
    Detailedrace39412 -> "3941-2"
    Detailedrace39420 -> "3942-0"
    Detailedrace39438 -> "3943-8"
    Detailedrace39446 -> "3944-6"
    Detailedrace39453 -> "3945-3"
    Detailedrace39461 -> "3946-1"
    Detailedrace39479 -> "3947-9"
    Detailedrace39487 -> "3948-7"
    Detailedrace39495 -> "3949-5"
    Detailedrace10710 -> "1071-0"
    Detailedrace39511 -> "3951-1"
    Detailedrace39529 -> "3952-9"
    Detailedrace39537 -> "3953-7"
    Detailedrace39545 -> "3954-5"
    Detailedrace39552 -> "3955-2"
    Detailedrace39560 -> "3956-0"
    Detailedrace39578 -> "3957-8"
    Detailedrace39586 -> "3958-6"
    Detailedrace39594 -> "3959-4"
    Detailedrace39602 -> "3960-2"
    Detailedrace39610 -> "3961-0"
    Detailedrace39628 -> "3962-8"
    Detailedrace39636 -> "3963-6"
    Detailedrace39644 -> "3964-4"
    Detailedrace39651 -> "3965-1"
    Detailedrace39669 -> "3966-9"
    Detailedrace39677 -> "3967-7"
    Detailedrace39685 -> "3968-5"
    Detailedrace39693 -> "3969-3"
    Detailedrace39701 -> "3970-1"
    Detailedrace39719 -> "3971-9"
    Detailedrace39727 -> "3972-7"
    Detailedrace39735 -> "3973-5"
    Detailedrace39743 -> "3974-3"
    Detailedrace39750 -> "3975-0"
    Detailedrace39768 -> "3976-8"
    Detailedrace39776 -> "3977-6"
    Detailedrace39784 -> "3978-4"
    Detailedrace39792 -> "3979-2"
    Detailedrace39800 -> "3980-0"
    Detailedrace39818 -> "3981-8"
    Detailedrace39826 -> "3982-6"
    Detailedrace39834 -> "3983-4"
    Detailedrace39842 -> "3984-2"
    Detailedrace39859 -> "3985-9"
    Detailedrace39867 -> "3986-7"
    Detailedrace39875 -> "3987-5"
    Detailedrace39883 -> "3988-3"
    Detailedrace39891 -> "3989-1"
    Detailedrace39909 -> "3990-9"
    Detailedrace39917 -> "3991-7"
    Detailedrace39925 -> "3992-5"
    Detailedrace39933 -> "3993-3"
    Detailedrace39941 -> "3994-1"
    Detailedrace39958 -> "3995-8"
    Detailedrace39966 -> "3996-6"
    Detailedrace39974 -> "3997-4"
    Detailedrace39982 -> "3998-2"
    Detailedrace39990 -> "3999-0"
    Detailedrace40006 -> "4000-6"
    Detailedrace40014 -> "4001-4"
    Detailedrace40022 -> "4002-2"
    Detailedrace40030 -> "4003-0"
    Detailedrace40048 -> "4004-8"
    Detailedrace40055 -> "4005-5"
    Detailedrace40063 -> "4006-3"
    Detailedrace40071 -> "4007-1"
    Detailedrace40089 -> "4008-9"
    Detailedrace40097 -> "4009-7"
    Detailedrace40105 -> "4010-5"
    Detailedrace40113 -> "4011-3"
    Detailedrace40121 -> "4012-1"
    Detailedrace40139 -> "4013-9"
    Detailedrace40147 -> "4014-7"
    Detailedrace40154 -> "4015-4"
    Detailedrace40162 -> "4016-2"
    Detailedrace40170 -> "4017-0"
    Detailedrace40188 -> "4018-8"
    Detailedrace40196 -> "4019-6"
    Detailedrace40204 -> "4020-4"
    Detailedrace40212 -> "4021-2"
    Detailedrace40220 -> "4022-0"
    Detailedrace40238 -> "4023-8"
    Detailedrace40246 -> "4024-6"
    Detailedrace40253 -> "4025-3"
    Detailedrace40261 -> "4026-1"
    Detailedrace40279 -> "4027-9"
    Detailedrace40287 -> "4028-7"
    Detailedrace40295 -> "4029-5"
    Detailedrace40303 -> "4030-3"
    Detailedrace40311 -> "4031-1"
    Detailedrace40329 -> "4032-9"
    Detailedrace40337 -> "4033-7"
    Detailedrace40345 -> "4034-5"
    Detailedrace40352 -> "4035-2"
    Detailedrace40360 -> "4036-0"
    Detailedrace40378 -> "4037-8"
    Detailedrace40386 -> "4038-6"
    Detailedrace40394 -> "4039-4"
    Detailedrace40402 -> "4040-2"
    Detailedrace40410 -> "4041-0"
    Detailedrace40428 -> "4042-8"
    Detailedrace40436 -> "4043-6"
    Detailedrace40444 -> "4044-4"
    Detailedrace40451 -> "4045-1"
    Detailedrace40469 -> "4046-9"
    Detailedrace40477 -> "4047-7"
    Detailedrace40485 -> "4048-5"
    Detailedrace40493 -> "4049-3"
    Detailedrace40501 -> "4050-1"
    Detailedrace40519 -> "4051-9"
    Detailedrace40527 -> "4052-7"
    Detailedrace40535 -> "4053-5"
    Detailedrace40543 -> "4054-3"
    Detailedrace40550 -> "4055-0"
    Detailedrace40568 -> "4056-8"
    Detailedrace40576 -> "4057-6"
    Detailedrace40584 -> "4058-4"
    Detailedrace40592 -> "4059-2"
    Detailedrace40600 -> "4060-0"
    Detailedrace40618 -> "4061-8"
    Detailedrace40626 -> "4062-6"
    Detailedrace40634 -> "4063-4"
    Detailedrace40642 -> "4064-2"
    Detailedrace40659 -> "4065-9"
    Detailedrace40667 -> "4066-7"
    Detailedrace40675 -> "4067-5"
    Detailedrace40683 -> "4068-3"
    Detailedrace40691 -> "4069-1"
    Detailedrace40709 -> "4070-9"
    Detailedrace40717 -> "4071-7"
    Detailedrace40725 -> "4072-5"
    Detailedrace40733 -> "4073-3"
    Detailedrace40741 -> "4074-1"
    Detailedrace40758 -> "4075-8"
    Detailedrace40766 -> "4076-6"
    Detailedrace40774 -> "4077-4"
    Detailedrace40782 -> "4078-2"
    Detailedrace40790 -> "4079-0"
    Detailedrace40808 -> "4080-8"
    Detailedrace40816 -> "4081-6"
    Detailedrace40824 -> "4082-4"
    Detailedrace40832 -> "4083-2"
    Detailedrace40840 -> "4084-0"
    Detailedrace40857 -> "4085-7"
    Detailedrace10702 -> "1070-2"
    Detailedrace40873 -> "4087-3"
    Detailedrace40881 -> "4088-1"
    Detailedrace40899 -> "4089-9"
    Detailedrace40907 -> "4090-7"
    Detailedrace40915 -> "4091-5"
    Detailedrace40923 -> "4092-3"
    Detailedrace40931 -> "4093-1"
    Detailedrace40949 -> "4094-9"
    Detailedrace40956 -> "4095-6"
    Detailedrace40964 -> "4096-4"
    Detailedrace40972 -> "4097-2"
    Detailedrace40980 -> "4098-0"
    Detailedrace40998 -> "4099-8"
    Detailedrace41004 -> "4100-4"
    Detailedrace41012 -> "4101-2"
    Detailedrace41020 -> "4102-0"
    Detailedrace41038 -> "4103-8"
    Detailedrace41046 -> "4104-6"
    Detailedrace41053 -> "4105-3"
    Detailedrace41061 -> "4106-1"
    Detailedrace41079 -> "4107-9"
    Detailedrace41087 -> "4108-7"
    Detailedrace41095 -> "4109-5"
    Detailedrace41103 -> "4110-3"
    Detailedrace41111 -> "4111-1"
    Detailedrace41129 -> "4112-9"
    Detailedrace41137 -> "4113-7"
    Detailedrace41145 -> "4114-5"
    Detailedrace41152 -> "4115-2"
    Detailedrace41160 -> "4116-0"
    Detailedrace41178 -> "4117-8"
    Detailedrace41186 -> "4118-6"
    Detailedrace41194 -> "4119-4"
    Detailedrace41202 -> "4120-2"
    Detailedrace41210 -> "4121-0"
    Detailedrace41228 -> "4122-8"
    Detailedrace41236 -> "4123-6"
    Detailedrace41244 -> "4124-4"
    Detailedrace41251 -> "4125-1"
    Detailedrace41269 -> "4126-9"
    Detailedrace41277 -> "4127-7"
    Detailedrace41285 -> "4128-5"
    Detailedrace41293 -> "4129-3"
    Detailedrace41301 -> "4130-1"
    Detailedrace41319 -> "4131-9"
    Detailedrace41327 -> "4132-7"
    Detailedrace41335 -> "4133-5"
    Detailedrace41343 -> "4134-3"
    Detailedrace41350 -> "4135-0"
    Detailedrace41368 -> "4136-8"
    Detailedrace41376 -> "4137-6"
    Detailedrace41384 -> "4138-4"
    Detailedrace41392 -> "4139-2"
    Detailedrace41400 -> "4140-0"
    Detailedrace41418 -> "4141-8"
    Detailedrace41426 -> "4142-6"
    Detailedrace41434 -> "4143-4"
    Detailedrace41442 -> "4144-2"
    Detailedrace41459 -> "4145-9"
    Detailedrace41467 -> "4146-7"
    Detailedrace10728 -> "1072-8"
    Detailedrace41483 -> "4148-3"
    Detailedrace10736 -> "1073-6"
    Detailedrace41509 -> "4150-9"
    Detailedrace41517 -> "4151-7"
    Detailedrace41525 -> "4152-5"
    Detailedrace41533 -> "4153-3"
    Detailedrace41541 -> "4154-1"
    Detailedrace41558 -> "4155-8"
    Detailedrace41566 -> "4156-6"
    Detailedrace41574 -> "4157-4"
    Detailedrace41582 -> "4158-2"
    Detailedrace41590 -> "4159-0"
    Detailedrace41608 -> "4160-8"
    Detailedrace41616 -> "4161-6"
    Detailedrace41624 -> "4162-4"
    Detailedrace41632 -> "4163-2"
    Detailedrace41640 -> "4164-0"
    Detailedrace41657 -> "4165-7"
    Detailedrace41665 -> "4166-5"
    Detailedrace41673 -> "4167-3"
    Detailedrace41681 -> "4168-1"
    Detailedrace41699 -> "4169-9"
    Detailedrace41707 -> "4170-7"
    Detailedrace41715 -> "4171-5"
    Detailedrace41723 -> "4172-3"
    Detailedrace41731 -> "4173-1"
    Detailedrace41749 -> "4174-9"
    Detailedrace41756 -> "4175-6"
    Detailedrace41764 -> "4176-4"
    Detailedrace41772 -> "4177-2"
    Detailedrace41780 -> "4178-0"
    Detailedrace41798 -> "4179-8"
    Detailedrace41806 -> "4180-6"
    Detailedrace41814 -> "4181-4"
    Detailedrace10744 -> "1074-4"
    Detailedrace41830 -> "4183-0"
    Detailedrace41848 -> "4184-8"
    Detailedrace41855 -> "4185-5"
    Detailedrace20297 -> "2029-7"
    Detailedrace20305 -> "2030-5"
    Detailedrace20313 -> "2031-3"
    Detailedrace20321 -> "2032-1"
    Detailedrace20339 -> "2033-9"
    Detailedrace20347 -> "2034-7"
    Detailedrace20354 -> "2035-4"
    Detailedrace20362 -> "2036-2"
    Detailedrace20370 -> "2037-0"
    Detailedrace20388 -> "2038-8"
    Detailedrace20396 -> "2039-6"
    Detailedrace20404 -> "2040-4"
    Detailedrace20412 -> "2041-2"
    Detailedrace20420 -> "2042-0"
    Detailedrace20438 -> "2043-8"
    Detailedrace20446 -> "2044-6"
    Detailedrace20453 -> "2045-3"
    Detailedrace20461 -> "2046-1"
    Detailedrace20479 -> "2047-9"
    Detailedrace20487 -> "2048-7"
    Detailedrace20495 -> "2049-5"
    Detailedrace20503 -> "2050-3"
    Detailedrace20511 -> "2051-1"
    Detailedrace20529 -> "2052-9"
    Detailedrace20560 -> "2056-0"
    Detailedrace20586 -> "2058-6"
    Detailedrace20602 -> "2060-2"
    Detailedrace20610 -> "2061-0"
    Detailedrace20628 -> "2062-8"
    Detailedrace20636 -> "2063-6"
    Detailedrace20644 -> "2064-4"
    Detailedrace20651 -> "2065-1"
    Detailedrace20669 -> "2066-9"
    Detailedrace41863 -> "4186-3"
    Detailedrace20677 -> "2067-7"
    Detailedrace20685 -> "2068-5"
    Detailedrace20693 -> "2069-3"
    Detailedrace20701 -> "2070-1"
    Detailedrace20719 -> "2071-9"
    Detailedrace20727 -> "2072-7"
    Detailedrace20735 -> "2073-5"
    Detailedrace20743 -> "2074-3"
    Detailedrace20750 -> "2075-0"
    Detailedrace20784 -> "2078-4"
    Detailedrace20792 -> "2079-2"
    Detailedrace20800 -> "2080-0"
    Detailedrace20818 -> "2081-8"
    Detailedrace20826 -> "2082-6"
    Detailedrace20834 -> "2083-4"
    Detailedrace20859 -> "2085-9"
    Detailedrace20867 -> "2086-7"
    Detailedrace20875 -> "2087-5"
    Detailedrace20883 -> "2088-3"
    Detailedrace20891 -> "2089-1"
    Detailedrace20909 -> "2090-9"
    Detailedrace20917 -> "2091-7"
    Detailedrace20925 -> "2092-5"
    Detailedrace20933 -> "2093-3"
    Detailedrace20941 -> "2094-1"
    Detailedrace20958 -> "2095-8"
    Detailedrace20966 -> "2096-6"
    Detailedrace20974 -> "2097-4"
    Detailedrace20982 -> "2098-2"
    Detailedrace21006 -> "2100-6"
    Detailedrace21014 -> "2101-4"
    Detailedrace21022 -> "2102-2"
    Detailedrace21030 -> "2103-0"
    Detailedrace21048 -> "2104-8"
    Detailedrace25007 -> "2500-7"
    Detailedrace21089 -> "2108-9"
    Detailedrace21097 -> "2109-7"
    Detailedrace21105 -> "2110-5"
    Detailedrace21113 -> "2111-3"
    Detailedrace21121 -> "2112-1"
    Detailedrace21139 -> "2113-9"
    Detailedrace21147 -> "2114-7"
    Detailedrace21154 -> "2115-4"
    Detailedrace21162 -> "2116-2"
    Detailedrace21188 -> "2118-8"
    Detailedrace21196 -> "2119-6"
    Detailedrace21204 -> "2120-4"
    Detailedrace21212 -> "2121-2"
    Detailedrace21220 -> "2122-0"
    Detailedrace21238 -> "2123-8"
    Detailedrace21246 -> "2124-6"
    Detailedrace21253 -> "2125-3"
    Detailedrace21261 -> "2126-1"
    Detailedrace21279 -> "2127-9"
    Detailedrace21295 -> "2129-5"
    Detailedrace21311 -> "2131-1"
    DetailedraceAsku -> "ASKU"
    DetailedraceOth -> "OTH"
    DetailedraceUnk -> "UNK"
  }
}

pub fn detailedrace_from_code(code: String) -> Result(Detailedrace, Nil) {
  case code {
    "1004-1" -> Ok(Detailedrace10041)
    "1006-6" -> Ok(Detailedrace10066)
    "1579-2" -> Ok(Detailedrace15792)
    "1212-0" -> Ok(Detailedrace12120)
    "1045-4" -> Ok(Detailedrace10454)
    "1654-3" -> Ok(Detailedrace16543)
    "1194-0" -> Ok(Detailedrace11940)
    "1195-7" -> Ok(Detailedrace11957)
    "1187-4" -> Ok(Detailedrace11874)
    "1008-2" -> Ok(Detailedrace10082)
    "3012-2" -> Ok(Detailedrace30122)
    "1688-1" -> Ok(Detailedrace16881)
    "1392-0" -> Ok(Detailedrace13920)
    "3015-5" -> Ok(Detailedrace30155)
    "3016-3" -> Ok(Detailedrace30163)
    "1010-8" -> Ok(Detailedrace10108)
    "1016-5" -> Ok(Detailedrace10165)
    "1021-5" -> Ok(Detailedrace10215)
    "1024-9" -> Ok(Detailedrace10249)
    "1026-4" -> Ok(Detailedrace10264)
    "1366-4" -> Ok(Detailedrace13664)
    "1028-0" -> Ok(Detailedrace10280)
    "3024-7" -> Ok(Detailedrace30247)
    "3025-4" -> Ok(Detailedrace30254)
    "1234-4" -> Ok(Detailedrace12344)
    "1265-8" -> Ok(Detailedrace12658)
    "1046-2" -> Ok(Detailedrace10462)
    "1124-7" -> Ok(Detailedrace11247)
    "1033-0" -> Ok(Detailedrace10330)
    "3031-2" -> Ok(Detailedrace30312)
    "1125-4" -> Ok(Detailedrace11254)
    "1060-3" -> Ok(Detailedrace10603)
    "3034-6" -> Ok(Detailedrace30346)
    "3035-3" -> Ok(Detailedrace30353)
    "3036-1" -> Ok(Detailedrace30361)
    "1430-8" -> Ok(Detailedrace14308)
    "3038-7" -> Ok(Detailedrace30387)
    "3039-5" -> Ok(Detailedrace30395)
    "1235-1" -> Ok(Detailedrace12351)
    "3041-1" -> Ok(Detailedrace30411)
    "1417-5" -> Ok(Detailedrace14175)
    "1035-5" -> Ok(Detailedrace10355)
    "3044-5" -> Ok(Detailedrace30445)
    "1126-2" -> Ok(Detailedrace11262)
    "1418-3" -> Ok(Detailedrace14183)
    "1037-1" -> Ok(Detailedrace10371)
    "1611-3" -> Ok(Detailedrace16113)
    "3049-4" -> Ok(Detailedrace30494)
    "1419-1" -> Ok(Detailedrace14191)
    "3051-0" -> Ok(Detailedrace30510)
    "1047-0" -> Ok(Detailedrace10470)
    "3053-6" -> Ok(Detailedrace30536)
    "1041-3" -> Ok(Detailedrace10413)
    "3055-1" -> Ok(Detailedrace30551)
    "1042-1" -> Ok(Detailedrace10421)
    "1054-6" -> Ok(Detailedrace10546)
    "1044-7" -> Ok(Detailedrace10447)
    "3059-3" -> Ok(Detailedrace30593)
    "3060-1" -> Ok(Detailedrace30601)
    "1223-7" -> Ok(Detailedrace12237)
    "1224-5" -> Ok(Detailedrace12245)
    "1076-9" -> Ok(Detailedrace10769)
    "1286-4" -> Ok(Detailedrace12864)
    "1078-5" -> Ok(Detailedrace10785)
    "1420-9" -> Ok(Detailedrace14209)
    "1393-8" -> Ok(Detailedrace13938)
    "1465-4" -> Ok(Detailedrace14654)
    "3069-2" -> Ok(Detailedrace30692)
    "3070-0" -> Ok(Detailedrace30700)
    "3071-8" -> Ok(Detailedrace30718)
    "1082-7" -> Ok(Detailedrace10827)
    "1086-8" -> Ok(Detailedrace10868)
    "3074-2" -> Ok(Detailedrace30742)
    "3075-9" -> Ok(Detailedrace30759)
    "3076-7" -> Ok(Detailedrace30767)
    "1088-4" -> Ok(Detailedrace10884)
    "1089-2" -> Ok(Detailedrace10892)
    "3079-1" -> Ok(Detailedrace30791)
    "3080-9" -> Ok(Detailedrace30809)
    "3081-7" -> Ok(Detailedrace30817)
    "1090-0" -> Ok(Detailedrace10900)
    "1102-3" -> Ok(Detailedrace11023)
    "1106-4" -> Ok(Detailedrace11064)
    "3085-8" -> Ok(Detailedrace30858)
    "3086-6" -> Ok(Detailedrace30866)
    "1109-8" -> Ok(Detailedrace11098)
    "3088-2" -> Ok(Detailedrace30882)
    "1055-3" -> Ok(Detailedrace10553)
    "1114-8" -> Ok(Detailedrace11148)
    "1123-9" -> Ok(Detailedrace11239)
    "3092-4" -> Ok(Detailedrace30924)
    "1153-6" -> Ok(Detailedrace11536)
    "1155-1" -> Ok(Detailedrace11551)
    "3095-7" -> Ok(Detailedrace30957)
    "1162-7" -> Ok(Detailedrace11627)
    "1479-5" -> Ok(Detailedrace14795)
    "1115-5" -> Ok(Detailedrace11155)
    "1165-0" -> Ok(Detailedrace11650)
    "1156-9" -> Ok(Detailedrace11569)
    "3101-3" -> Ok(Detailedrace31013)
    "1725-1" -> Ok(Detailedrace17251)
    "1167-6" -> Ok(Detailedrace11676)
    "1169-2" -> Ok(Detailedrace11692)
    "3105-4" -> Ok(Detailedrace31054)
    "1171-8" -> Ok(Detailedrace11718)
    "1394-6" -> Ok(Detailedrace13946)
    "1116-3" -> Ok(Detailedrace11163)
    "3109-6" -> Ok(Detailedrace31096)
    "1560-2" -> Ok(Detailedrace15602)
    "1707-9" -> Ok(Detailedrace17079)
    "1607-1" -> Ok(Detailedrace16071)
    "1080-1" -> Ok(Detailedrace10801)
    "1173-4" -> Ok(Detailedrace11734)
    "1178-3" -> Ok(Detailedrace11783)
    "1591-7" -> Ok(Detailedrace15917)
    "1262-5" -> Ok(Detailedrace12625)
    "1665-9" -> Ok(Detailedrace16659)
    "1683-2" -> Ok(Detailedrace16832)
    "1180-9" -> Ok(Detailedrace11809)
    "1182-5" -> Ok(Detailedrace11825)
    "1184-1" -> Ok(Detailedrace11841)
    "1186-6" -> Ok(Detailedrace11866)
    "3124-5" -> Ok(Detailedrace31245)
    "1668-3" -> Ok(Detailedrace16683)
    "1189-0" -> Ok(Detailedrace11890)
    "3127-8" -> Ok(Detailedrace31278)
    "1191-6" -> Ok(Detailedrace11916)
    "1207-0" -> Ok(Detailedrace12070)
    "1613-9" -> Ok(Detailedrace16139)
    "1209-6" -> Ok(Detailedrace12096)
    "3132-8" -> Ok(Detailedrace31328)
    "1211-2" -> Ok(Detailedrace12112)
    "3134-4" -> Ok(Detailedrace31344)
    "3135-1" -> Ok(Detailedrace31351)
    "3136-9" -> Ok(Detailedrace31369)
    "1057-9" -> Ok(Detailedrace10579)
    "1466-2" -> Ok(Detailedrace14662)
    "1588-3" -> Ok(Detailedrace15883)
    "1519-8" -> Ok(Detailedrace15198)
    "3141-9" -> Ok(Detailedrace31419)
    "1092-6" -> Ok(Detailedrace10926)
    "1196-5" -> Ok(Detailedrace11965)
    "1197-3" -> Ok(Detailedrace11973)
    "3145-0" -> Ok(Detailedrace31450)
    "1467-0" -> Ok(Detailedrace14670)
    "1580-0" -> Ok(Detailedrace15800)
    "1599-0" -> Ok(Detailedrace15990)
    "1093-4" -> Ok(Detailedrace10934)
    "1239-3" -> Ok(Detailedrace12393)
    "1472-0" -> Ok(Detailedrace14720)
    "3152-6" -> Ok(Detailedrace31526)
    "3153-4" -> Ok(Detailedrace31534)
    "1590-9" -> Ok(Detailedrace15909)
    "3155-9" -> Ok(Detailedrace31559)
    "1250-0" -> Ok(Detailedrace12500)
    "1225-2" -> Ok(Detailedrace12252)
    "1056-1" -> Ok(Detailedrace10561)
    "3159-1" -> Ok(Detailedrace31591)
    "1615-4" -> Ok(Detailedrace16154)
    "1128-8" -> Ok(Detailedrace11288)
    "3162-5" -> Ok(Detailedrace31625)
    "1252-6" -> Ok(Detailedrace12526)
    "1421-7" -> Ok(Detailedrace14217)
    "1422-5" -> Ok(Detailedrace14225)
    "1605-5" -> Ok(Detailedrace16055)
    "1256-7" -> Ok(Detailedrace12567)
    "1729-3" -> Ok(Detailedrace17293)
    "3169-0" -> Ok(Detailedrace31690)
    "3170-8" -> Ok(Detailedrace31708)
    "1260-9" -> Ok(Detailedrace12609)
    "1236-9" -> Ok(Detailedrace12369)
    "3173-2" -> Ok(Detailedrace31732)
    "3174-0" -> Ok(Detailedrace31740)
    "1242-7" -> Ok(Detailedrace12427)
    "1129-6" -> Ok(Detailedrace11296)
    "3177-3" -> Ok(Detailedrace31773)
    "1130-4" -> Ok(Detailedrace11304)
    "3179-9" -> Ok(Detailedrace31799)
    "3180-7" -> Ok(Detailedrace31807)
    "1264-1" -> Ok(Detailedrace12641)
    "3182-3" -> Ok(Detailedrace31823)
    "3183-1" -> Ok(Detailedrace31831)
    "3184-9" -> Ok(Detailedrace31849)
    "1267-4" -> Ok(Detailedrace12674)
    "1481-1" -> Ok(Detailedrace14811)
    "3187-2" -> Ok(Detailedrace31872)
    "1726-9" -> Ok(Detailedrace17269)
    "3189-8" -> Ok(Detailedrace31898)
    "1269-0" -> Ok(Detailedrace12690)
    "1697-2" -> Ok(Detailedrace16972)
    "1083-5" -> Ok(Detailedrace10835)
    "1275-7" -> Ok(Detailedrace12757)
    "1271-6" -> Ok(Detailedrace12716)
    "3195-5" -> Ok(Detailedrace31955)
    "3196-3" -> Ok(Detailedrace31963)
    "3197-1" -> Ok(Detailedrace31971)
    "1727-7" -> Ok(Detailedrace17277)
    "1230-2" -> Ok(Detailedrace12302)
    "1359-9" -> Ok(Detailedrace13599)
    "1279-9" -> Ok(Detailedrace12799)
    "1442-3" -> Ok(Detailedrace14423)
    "1360-7" -> Ok(Detailedrace13607)
    "3204-5" -> Ok(Detailedrace32045)
    "1281-5" -> Ok(Detailedrace12815)
    "1282-3" -> Ok(Detailedrace12823)
    "1283-1" -> Ok(Detailedrace12831)
    "1285-6" -> Ok(Detailedrace12856)
    "3209-4" -> Ok(Detailedrace32094)
    "1313-6" -> Ok(Detailedrace13136)
    "3211-0" -> Ok(Detailedrace32110)
    "1157-7" -> Ok(Detailedrace11577)
    "1013-2" -> Ok(Detailedrace10132)
    "1297-1" -> Ok(Detailedrace12971)
    "1423-3" -> Ok(Detailedrace14233)
    "1395-3" -> Ok(Detailedrace13953)
    "1299-7" -> Ok(Detailedrace12997)
    "1301-1" -> Ok(Detailedrace13011)
    "1468-8" -> Ok(Detailedrace14688)
    "1117-1" -> Ok(Detailedrace11171)
    "1303-7" -> Ok(Detailedrace13037)
    "3222-7" -> Ok(Detailedrace32227)
    "1510-7" -> Ok(Detailedrace15107)
    "3224-3" -> Ok(Detailedrace32243)
    "1198-1" -> Ok(Detailedrace11981)
    "1305-2" -> Ok(Detailedrace13052)
    "1307-8" -> Ok(Detailedrace13078)
    "3228-4" -> Ok(Detailedrace32284)
    "1306-0" -> Ok(Detailedrace13060)
    "1520-6" -> Ok(Detailedrace15206)
    "1309-4" -> Ok(Detailedrace13094)
    "1310-2" -> Ok(Detailedrace13102)
    "1312-8" -> Ok(Detailedrace13128)
    "3234-2" -> Ok(Detailedrace32342)
    "3235-9" -> Ok(Detailedrace32359)
    "3236-7" -> Ok(Detailedrace32367)
    "3237-5" -> Ok(Detailedrace32375)
    "1319-3" -> Ok(Detailedrace13193)
    "1321-9" -> Ok(Detailedrace13219)
    "1222-9" -> Ok(Detailedrace12229)
    "1332-6" -> Ok(Detailedrace13326)
    "1226-0" -> Ok(Detailedrace12260)
    "1132-0" -> Ok(Detailedrace11320)
    "1133-8" -> Ok(Detailedrace11338)
    "1134-6" -> Ok(Detailedrace11346)
    "1135-3" -> Ok(Detailedrace11353)
    "1424-1" -> Ok(Detailedrace14241)
    "1323-5" -> Ok(Detailedrace13235)
    "1136-1" -> Ok(Detailedrace11361)
    "3250-8" -> Ok(Detailedrace32508)
    "1014-0" -> Ok(Detailedrace10140)
    "3252-4" -> Ok(Detailedrace32524)
    "1137-9" -> Ok(Detailedrace11379)
    "3254-0" -> Ok(Detailedrace32540)
    "1425-8" -> Ok(Detailedrace14258)
    "1048-8" -> Ok(Detailedrace10488)
    "3257-3" -> Ok(Detailedrace32573)
    "1426-6" -> Ok(Detailedrace14266)
    "1618-8" -> Ok(Detailedrace16188)
    "1314-4" -> Ok(Detailedrace13144)
    "1199-9" -> Ok(Detailedrace11999)
    "1619-6" -> Ok(Detailedrace16196)
    "1521-4" -> Ok(Detailedrace15214)
    "1331-8" -> Ok(Detailedrace13318)
    "1340-9" -> Ok(Detailedrace13409)
    "1342-5" -> Ok(Detailedrace13425)
    "3267-2" -> Ok(Detailedrace32672)
    "1200-5" -> Ok(Detailedrace12005)
    "1344-1" -> Ok(Detailedrace13441)
    "1348-2" -> Ok(Detailedrace13482)
    "1427-4" -> Ok(Detailedrace14274)
    "1350-8" -> Ok(Detailedrace13508)
    "3273-0" -> Ok(Detailedrace32730)
    "1352-4" -> Ok(Detailedrace13524)
    "1227-8" -> Ok(Detailedrace12278)
    "1728-5" -> Ok(Detailedrace17285)
    "3277-1" -> Ok(Detailedrace32771)
    "1454-8" -> Ok(Detailedrace14548)
    "1681-6" -> Ok(Detailedrace16816)
    "3280-5" -> Ok(Detailedrace32805)
    "1326-8" -> Ok(Detailedrace13268)
    "1354-0" -> Ok(Detailedrace13540)
    "1620-4" -> Ok(Detailedrace16204)
    "3284-7" -> Ok(Detailedrace32847)
    "3285-4" -> Ok(Detailedrace32854)
    "1356-5" -> Ok(Detailedrace13565)
    "1228-6" -> Ok(Detailedrace12286)
    "1015-7" -> Ok(Detailedrace10157)
    "3289-6" -> Ok(Detailedrace32896)
    "1358-1" -> Ok(Detailedrace13581)
    "1361-5" -> Ok(Detailedrace13615)
    "1363-1" -> Ok(Detailedrace13631)
    "1365-6" -> Ok(Detailedrace13656)
    "3294-6" -> Ok(Detailedrace32946)
    "1138-7" -> Ok(Detailedrace11387)
    "1139-5" -> Ok(Detailedrace11395)
    "1368-0" -> Ok(Detailedrace13680)
    "1158-5" -> Ok(Detailedrace11585)
    "1370-6" -> Ok(Detailedrace13706)
    "1428-2" -> Ok(Detailedrace14282)
    "1372-2" -> Ok(Detailedrace13722)
    "1287-2" -> Ok(Detailedrace12872)
    "1374-8" -> Ok(Detailedrace13748)
    "1396-1" -> Ok(Detailedrace13961)
    "3305-0" -> Ok(Detailedrace33050)
    "1376-3" -> Ok(Detailedrace13763)
    "1327-6" -> Ok(Detailedrace13276)
    "1237-7" -> Ok(Detailedrace12377)
    "3309-2" -> Ok(Detailedrace33092)
    "1049-6" -> Ok(Detailedrace10496)
    "1345-8" -> Ok(Detailedrace13458)
    "1159-3" -> Ok(Detailedrace11593)
    "1522-2" -> Ok(Detailedrace15222)
    "1217-9" -> Ok(Detailedrace12179)
    "1238-5" -> Ok(Detailedrace12385)
    "1378-9" -> Ok(Detailedrace13789)
    "3317-5" -> Ok(Detailedrace33175)
    "1380-5" -> Ok(Detailedrace13805)
    "3319-1" -> Ok(Detailedrace33191)
    "1240-1" -> Ok(Detailedrace12401)
    "3321-7" -> Ok(Detailedrace33217)
    "1220-3" -> Ok(Detailedrace12203)
    "1387-0" -> Ok(Detailedrace13870)
    "1241-9" -> Ok(Detailedrace12419)
    "1346-6" -> Ok(Detailedrace13466)
    "1523-0" -> Ok(Detailedrace15230)
    "1389-6" -> Ok(Detailedrace13896)
    "1524-8" -> Ok(Detailedrace15248)
    "3329-0" -> Ok(Detailedrace33290)
    "1022-3" -> Ok(Detailedrace10223)
    "1095-9" -> Ok(Detailedrace10959)
    "1103-1" -> Ok(Detailedrace11031)
    "1429-0" -> Ok(Detailedrace14290)
    "1469-6" -> Ok(Detailedrace14696)
    "1598-2" -> Ok(Detailedrace15982)
    "1482-9" -> Ok(Detailedrace14829)
    "3337-3" -> Ok(Detailedrace33373)
    "3338-1" -> Ok(Detailedrace33381)
    "3339-9" -> Ok(Detailedrace33399)
    "3340-7" -> Ok(Detailedrace33407)
    "3341-5" -> Ok(Detailedrace33415)
    "1403-5" -> Ok(Detailedrace14035)
    "1288-0" -> Ok(Detailedrace12880)
    "3344-9" -> Ok(Detailedrace33449)
    "3345-6" -> Ok(Detailedrace33456)
    "1289-8" -> Ok(Detailedrace12898)
    "1405-0" -> Ok(Detailedrace14050)
    "1409-2" -> Ok(Detailedrace14092)
    "1411-8" -> Ok(Detailedrace14118)
    "1414-2" -> Ok(Detailedrace14142)
    "1416-7" -> Ok(Detailedrace14167)
    "1433-2" -> Ok(Detailedrace14332)
    "1604-8" -> Ok(Detailedrace16048)
    "1333-4" -> Ok(Detailedrace13334)
    "1439-9" -> Ok(Detailedrace14399)
    "3356-3" -> Ok(Detailedrace33563)
    "3357-1" -> Ok(Detailedrace33571)
    "1441-5" -> Ok(Detailedrace14415)
    "3359-7" -> Ok(Detailedrace33597)
    "3360-5" -> Ok(Detailedrace33605)
    "1334-2" -> Ok(Detailedrace13342)
    "1445-6" -> Ok(Detailedrace14456)
    "1446-4" -> Ok(Detailedrace14464)
    "1335-9" -> Ok(Detailedrace13359)
    "3365-4" -> Ok(Detailedrace33654)
    "3366-2" -> Ok(Detailedrace33662)
    "1448-0" -> Ok(Detailedrace14480)
    "3368-8" -> Ok(Detailedrace33688)
    "1453-0" -> Ok(Detailedrace14530)
    "1718-6" -> Ok(Detailedrace17186)
    "3371-2" -> Ok(Detailedrace33712)
    "1456-3" -> Ok(Detailedrace14563)
    "3373-8" -> Ok(Detailedrace33738)
    "1624-6" -> Ok(Detailedrace16246)
    "3375-3" -> Ok(Detailedrace33753)
    "1500-8" -> Ok(Detailedrace15008)
    "1460-5" -> Ok(Detailedrace14605)
    "3378-7" -> Ok(Detailedrace33787)
    "3379-5" -> Ok(Detailedrace33795)
    "1462-1" -> Ok(Detailedrace14621)
    "1443-1" -> Ok(Detailedrace14431)
    "1201-3" -> Ok(Detailedrace12013)
    "3383-7" -> Ok(Detailedrace33837)
    "1243-5" -> Ok(Detailedrace12435)
    "3385-2" -> Ok(Detailedrace33852)
    "1483-7" -> Ok(Detailedrace14837)
    "3387-8" -> Ok(Detailedrace33878)
    "1464-7" -> Ok(Detailedrace14647)
    "1474-6" -> Ok(Detailedrace14746)
    "1476-1" -> Ok(Detailedrace14761)
    "1475-3" -> Ok(Detailedrace14753)
    "3392-8" -> Ok(Detailedrace33928)
    "1328-4" -> Ok(Detailedrace13284)
    "1315-1" -> Ok(Detailedrace13151)
    "1478-7" -> Ok(Detailedrace14787)
    "3396-9" -> Ok(Detailedrace33969)
    "1487-8" -> Ok(Detailedrace14878)
    "1484-5" -> Ok(Detailedrace14845)
    "1625-3" -> Ok(Detailedrace16253)
    "1202-1" -> Ok(Detailedrace12021)
    "1489-4" -> Ok(Detailedrace14894)
    "1490-2" -> Ok(Detailedrace14902)
    "1492-8" -> Ok(Detailedrace14928)
    "1494-4" -> Ok(Detailedrace14944)
    "1495-1" -> Ok(Detailedrace14951)
    "1497-7" -> Ok(Detailedrace14977)
    "1498-5" -> Ok(Detailedrace14985)
    "1499-3" -> Ok(Detailedrace14993)
    "1501-6" -> Ok(Detailedrace15016)
    "1502-4" -> Ok(Detailedrace15024)
    "1503-2" -> Ok(Detailedrace15032)
    "1507-3" -> Ok(Detailedrace15073)
    "1508-1" -> Ok(Detailedrace15081)
    "1509-9" -> Ok(Detailedrace15099)
    "1511-5" -> Ok(Detailedrace15115)
    "1512-3" -> Ok(Detailedrace15123)
    "1515-6" -> Ok(Detailedrace15156)
    "1518-0" -> Ok(Detailedrace15180)
    "1526-3" -> Ok(Detailedrace15263)
    "1431-6" -> Ok(Detailedrace14316)
    "1541-2" -> Ok(Detailedrace15412)
    "3422-3" -> Ok(Detailedrace34223)
    "3423-1" -> Ok(Detailedrace34231)
    "1084-3" -> Ok(Detailedrace10843)
    "1543-8" -> Ok(Detailedrace15438)
    "1219-5" -> Ok(Detailedrace12195)
    "3427-2" -> Ok(Detailedrace34272)
    "1545-3" -> Ok(Detailedrace15453)
    "1141-1" -> Ok(Detailedrace11411)
    "1142-9" -> Ok(Detailedrace11429)
    "1061-1" -> Ok(Detailedrace10611)
    "3432-2" -> Ok(Detailedrace34322)
    "3433-0" -> Ok(Detailedrace34330)
    "1547-9" -> Ok(Detailedrace15479)
    "1733-5" -> Ok(Detailedrace17335)
    "3436-3" -> Ok(Detailedrace34363)
    "3437-1" -> Ok(Detailedrace34371)
    "1627-9" -> Ok(Detailedrace16279)
    "1549-5" -> Ok(Detailedrace15495)
    "1551-1" -> Ok(Detailedrace15511)
    "1553-7" -> Ok(Detailedrace15537)
    "1554-5" -> Ok(Detailedrace15545)
    "1552-9" -> Ok(Detailedrace15529)
    "3444-7" -> Ok(Detailedrace34447)
    "1143-7" -> Ok(Detailedrace11437)
    "3446-2" -> Ok(Detailedrace34462)
    "1556-0" -> Ok(Detailedrace15560)
    "1558-6" -> Ok(Detailedrace15586)
    "1458-9" -> Ok(Detailedrace14589)
    "1527-1" -> Ok(Detailedrace15271)
    "1018-1" -> Ok(Detailedrace10181)
    "1506-5" -> Ok(Detailedrace15065)
    "1432-4" -> Ok(Detailedrace14324)
    "3454-6" -> Ok(Detailedrace34546)
    "1574-3" -> Ok(Detailedrace15743)
    "1229-4" -> Ok(Detailedrace12294)
    "1050-4" -> Ok(Detailedrace10504)
    "1062-9" -> Ok(Detailedrace10629)
    "1163-5" -> Ok(Detailedrace11635)
    "3460-3" -> Ok(Detailedrace34603)
    "3461-1" -> Ok(Detailedrace34611)
    "1629-5" -> Ok(Detailedrace16295)
    "3463-7" -> Ok(Detailedrace34637)
    "3464-5" -> Ok(Detailedrace34645)
    "1528-9" -> Ok(Detailedrace15289)
    "1145-2" -> Ok(Detailedrace11452)
    "1562-8" -> Ok(Detailedrace15628)
    "1470-4" -> Ok(Detailedrace14704)
    "3469-4" -> Ok(Detailedrace34694)
    "1566-9" -> Ok(Detailedrace15669)
    "3471-0" -> Ok(Detailedrace34710)
    "3472-8" -> Ok(Detailedrace34728)
    "1292-2" -> Ok(Detailedrace12922)
    "1573-5" -> Ok(Detailedrace15735)
    "1329-2" -> Ok(Detailedrace13292)
    "1626-1" -> Ok(Detailedrace16261)
    "1576-8" -> Ok(Detailedrace15768)
    "1578-4" -> Ok(Detailedrace15784)
    "3479-3" -> Ok(Detailedrace34793)
    "1100-7" -> Ok(Detailedrace11007)
    "3481-9" -> Ok(Detailedrace34819)
    "3482-7" -> Ok(Detailedrace34827)
    "1582-6" -> Ok(Detailedrace15826)
    "1584-2" -> Ok(Detailedrace15842)
    "1586-7" -> Ok(Detailedrace15867)
    "1602-2" -> Ok(Detailedrace16022)
    "1258-3" -> Ok(Detailedrace12583)
    "1603-0" -> Ok(Detailedrace16030)
    "1609-7" -> Ok(Detailedrace16097)
    "3490-0" -> Ok(Detailedrace34900)
    "1643-6" -> Ok(Detailedrace16436)
    "1529-7" -> Ok(Detailedrace15297)
    "1594-1" -> Ok(Detailedrace15941)
    "1530-5" -> Ok(Detailedrace15305)
    "1531-3" -> Ok(Detailedrace15313)
    "1532-1" -> Ok(Detailedrace15321)
    "1336-7" -> Ok(Detailedrace13367)
    "1146-0" -> Ok(Detailedrace11460)
    "3499-1" -> Ok(Detailedrace34991)
    "1244-3" -> Ok(Detailedrace12443)
    "1023-1" -> Ok(Detailedrace10231)
    "1104-9" -> Ok(Detailedrace11049)
    "3503-0" -> Ok(Detailedrace35030)
    "1632-9" -> Ok(Detailedrace16329)
    "1645-1" -> Ok(Detailedrace16451)
    "1533-9" -> Ok(Detailedrace15339)
    "1144-5" -> Ok(Detailedrace11445)
    "1633-7" -> Ok(Detailedrace16337)
    "1534-7" -> Ok(Detailedrace15347)
    "1535-4" -> Ok(Detailedrace15354)
    "1649-3" -> Ok(Detailedrace16493)
    "1471-2" -> Ok(Detailedrace14712)
    "1434-0" -> Ok(Detailedrace14340)
    "1651-9" -> Ok(Detailedrace16519)
    "1245-0" -> Ok(Detailedrace12450)
    "3516-2" -> Ok(Detailedrace35162)
    "1537-0" -> Ok(Detailedrace15370)
    "1231-0" -> Ok(Detailedrace12310)
    "3519-6" -> Ok(Detailedrace35196)
    "1719-4" -> Ok(Detailedrace17194)
    "1063-7" -> Ok(Detailedrace10637)
    "1397-9" -> Ok(Detailedrace13979)
    "3523-8" -> Ok(Detailedrace35238)
    "1338-3" -> Ok(Detailedrace13383)
    "3525-3" -> Ok(Detailedrace35253)
    "1398-7" -> Ok(Detailedrace13987)
    "1634-5" -> Ok(Detailedrace16345)
    "1112-2" -> Ok(Detailedrace11122)
    "1160-1" -> Ok(Detailedrace11601)
    "3530-3" -> Ok(Detailedrace35303)
    "1193-2" -> Ok(Detailedrace11932)
    "1407-6" -> Ok(Detailedrace14076)
    "1571-9" -> Ok(Detailedrace15719)
    "1203-9" -> Ok(Detailedrace12039)
    "3535-2" -> Ok(Detailedrace35352)
    "3536-0" -> Ok(Detailedrace35360)
    "1204-7" -> Ok(Detailedrace12047)
    "1254-2" -> Ok(Detailedrace12542)
    "1399-5" -> Ok(Detailedrace13995)
    "3540-2" -> Ok(Detailedrace35402)
    "3541-0" -> Ok(Detailedrace35410)
    "1659-2" -> Ok(Detailedrace16592)
    "3543-6" -> Ok(Detailedrace35436)
    "1293-0" -> Ok(Detailedrace12930)
    "1661-8" -> Ok(Detailedrace16618)
    "1017-3" -> Ok(Detailedrace10173)
    "1051-2" -> Ok(Detailedrace10512)
    "1272-4" -> Ok(Detailedrace12724)
    "1205-4" -> Ok(Detailedrace12054)
    "1538-8" -> Ok(Detailedrace15388)
    "1720-2" -> Ok(Detailedrace17202)
    "1246-8" -> Ok(Detailedrace12468)
    "3553-5" -> Ok(Detailedrace35535)
    "1147-8" -> Ok(Detailedrace11478)
    "1294-8" -> Ok(Detailedrace12948)
    "1096-7" -> Ok(Detailedrace10967)
    "1337-5" -> Ok(Detailedrace13375)
    "1663-4" -> Ok(Detailedrace16634)
    "1667-5" -> Ok(Detailedrace16675)
    "3560-0" -> Ok(Detailedrace35600)
    "3561-8" -> Ok(Detailedrace35618)
    "1277-3" -> Ok(Detailedrace12773)
    "1097-5" -> Ok(Detailedrace10975)
    "1118-9" -> Ok(Detailedrace11189)
    "3565-9" -> Ok(Detailedrace35659)
    "1636-0" -> Ok(Detailedrace16360)
    "1539-6" -> Ok(Detailedrace15396)
    "1670-9" -> Ok(Detailedrace16709)
    "1672-5" -> Ok(Detailedrace16725)
    "3570-9" -> Ok(Detailedrace35709)
    "1435-7" -> Ok(Detailedrace14357)
    "3572-5" -> Ok(Detailedrace35725)
    "1247-6" -> Ok(Detailedrace12476)
    "1637-8" -> Ok(Detailedrace16378)
    "1675-8" -> Ok(Detailedrace16758)
    "1119-7" -> Ok(Detailedrace11197)
    "1436-5" -> Ok(Detailedrace14365)
    "1677-4" -> Ok(Detailedrace16774)
    "1679-0" -> Ok(Detailedrace16790)
    "1680-8" -> Ok(Detailedrace16808)
    "1064-5" -> Ok(Detailedrace10645)
    "1685-7" -> Ok(Detailedrace16857)
    "3583-2" -> Ok(Detailedrace35832)
    "3584-0" -> Ok(Detailedrace35840)
    "1639-4" -> Ok(Detailedrace16394)
    "1400-1" -> Ok(Detailedrace14001)
    "1273-2" -> Ok(Detailedrace12732)
    "1148-6" -> Ok(Detailedrace11486)
    "1019-9" -> Ok(Detailedrace10199)
    "3590-7" -> Ok(Detailedrace35907)
    "1692-3" -> Ok(Detailedrace16923)
    "1248-4" -> Ok(Detailedrace12484)
    "1120-5" -> Ok(Detailedrace11205)
    "3594-9" -> Ok(Detailedrace35949)
    "1694-9" -> Ok(Detailedrace16949)
    "1696-4" -> Ok(Detailedrace16964)
    "1698-0" -> Ok(Detailedrace16980)
    "1700-4" -> Ok(Detailedrace17004)
    "1702-0" -> Ok(Detailedrace17020)
    "1121-3" -> Ok(Detailedrace11213)
    "3601-2" -> Ok(Detailedrace36012)
    "1295-5" -> Ok(Detailedrace12955)
    "1709-5" -> Ok(Detailedrace17095)
    "1065-2" -> Ok(Detailedrace10652)
    "1640-2" -> Ok(Detailedrace16402)
    "1641-0" -> Ok(Detailedrace16410)
    "1711-1" -> Ok(Detailedrace17111)
    "1715-2" -> Ok(Detailedrace17152)
    "1731-9" -> Ok(Detailedrace17319)
    "1437-3" -> Ok(Detailedrace14373)
    "3611-1" -> Ok(Detailedrace36111)
    "1717-8" -> Ok(Detailedrace17178)
    "1600-6" -> Ok(Detailedrace16006)
    "1514-9" -> Ok(Detailedrace15149)
    "1722-8" -> Ok(Detailedrace17228)
    "1066-0" -> Ok(Detailedrace10660)
    "1732-7" -> Ok(Detailedrace17327)
    "1516-4" -> Ok(Detailedrace15164)
    "1735-0" -> Ok(Detailedrace17350)
    "1737-6" -> Ok(Detailedrace17376)
    "1739-2" -> Ok(Detailedrace17392)
    "1740-0" -> Ok(Detailedrace17400)
    "1744-2" -> Ok(Detailedrace17442)
    "1741-8" -> Ok(Detailedrace17418)
    "1742-6" -> Ok(Detailedrace17426)
    "1743-4" -> Ok(Detailedrace17434)
    "1745-9" -> Ok(Detailedrace17459)
    "3628-5" -> Ok(Detailedrace36285)
    "1747-5" -> Ok(Detailedrace17475)
    "1748-3" -> Ok(Detailedrace17483)
    "1750-9" -> Ok(Detailedrace17509)
    "1752-5" -> Ok(Detailedrace17525)
    "1751-7" -> Ok(Detailedrace17517)
    "1754-1" -> Ok(Detailedrace17541)
    "1755-8" -> Ok(Detailedrace17558)
    "1757-4" -> Ok(Detailedrace17574)
    "1759-0" -> Ok(Detailedrace17590)
    "1761-6" -> Ok(Detailedrace17616)
    "1762-4" -> Ok(Detailedrace17624)
    "1765-7" -> Ok(Detailedrace17657)
    "1767-3" -> Ok(Detailedrace17673)
    "1768-1" -> Ok(Detailedrace17681)
    "1769-9" -> Ok(Detailedrace17699)
    "1770-7" -> Ok(Detailedrace17707)
    "1771-5" -> Ok(Detailedrace17715)
    "1775-6" -> Ok(Detailedrace17756)
    "1776-4" -> Ok(Detailedrace17764)
    "1777-2" -> Ok(Detailedrace17772)
    "1778-0" -> Ok(Detailedrace17780)
    "1780-6" -> Ok(Detailedrace17806)
    "1779-8" -> Ok(Detailedrace17798)
    "1781-4" -> Ok(Detailedrace17814)
    "1749-1" -> Ok(Detailedrace17491)
    "1753-3" -> Ok(Detailedrace17533)
    "1760-8" -> Ok(Detailedrace17608)
    "1763-2" -> Ok(Detailedrace17632)
    "1764-0" -> Ok(Detailedrace17640)
    "1774-9" -> Ok(Detailedrace17749)
    "1782-2" -> Ok(Detailedrace17822)
    "1791-3" -> Ok(Detailedrace17913)
    "1796-2" -> Ok(Detailedrace17962)
    "1799-6" -> Ok(Detailedrace17996)
    "1801-0" -> Ok(Detailedrace18010)
    "1803-6" -> Ok(Detailedrace18036)
    "1805-1" -> Ok(Detailedrace18051)
    "1807-7" -> Ok(Detailedrace18077)
    "1783-0" -> Ok(Detailedrace17830)
    "1784-8" -> Ok(Detailedrace17848)
    "1785-5" -> Ok(Detailedrace17855)
    "1786-3" -> Ok(Detailedrace17863)
    "1787-1" -> Ok(Detailedrace17871)
    "1788-9" -> Ok(Detailedrace17889)
    "1766-5" -> Ok(Detailedrace17665)
    "1789-7" -> Ok(Detailedrace17897)
    "1790-5" -> Ok(Detailedrace17905)
    "1793-9" -> Ok(Detailedrace17939)
    "1795-4" -> Ok(Detailedrace17954)
    "1794-7" -> Ok(Detailedrace17947)
    "1798-8" -> Ok(Detailedrace17988)
    "1802-8" -> Ok(Detailedrace18028)
    "1804-4" -> Ok(Detailedrace18044)
    "1806-9" -> Ok(Detailedrace18069)
    "1758-2" -> Ok(Detailedrace17582)
    "1772-3" -> Ok(Detailedrace17723)
    "1773-1" -> Ok(Detailedrace17731)
    "1792-1" -> Ok(Detailedrace17921)
    "1797-0" -> Ok(Detailedrace17970)
    "1808-5" -> Ok(Detailedrace18085)
    "1809-3" -> Ok(Detailedrace18093)
    "1825-9" -> Ok(Detailedrace18259)
    "1966-1" -> Ok(Detailedrace19661)
    "1994-3" -> Ok(Detailedrace19943)
    "2008-1" -> Ok(Detailedrace20081)
    "4187-1" -> Ok(Detailedrace41871)
    "1972-9" -> Ok(Detailedrace19729)
    "1973-7" -> Ok(Detailedrace19737)
    "1974-5" -> Ok(Detailedrace19745)
    "1984-4" -> Ok(Detailedrace19844)
    "1986-9" -> Ok(Detailedrace19869)
    "1975-2" -> Ok(Detailedrace19752)
    "1840-8" -> Ok(Detailedrace18408)
    "1976-0" -> Ok(Detailedrace19760)
    "1977-8" -> Ok(Detailedrace19778)
    "3704-4" -> Ok(Detailedrace37044)
    "2014-9" -> Ok(Detailedrace20149)
    "1978-6" -> Ok(Detailedrace19786)
    "1996-8" -> Ok(Detailedrace19968)
    "1979-4" -> Ok(Detailedrace19794)
    "1992-7" -> Ok(Detailedrace19927)
    "3710-1" -> Ok(Detailedrace37101)
    "3711-9" -> Ok(Detailedrace37119)
    "1993-5" -> Ok(Detailedrace19935)
    "2007-3" -> Ok(Detailedrace20073)
    "2011-5" -> Ok(Detailedrace20115)
    "2012-3" -> Ok(Detailedrace20123)
    "1985-1" -> Ok(Detailedrace19851)
    "2013-1" -> Ok(Detailedrace20131)
    "1990-1" -> Ok(Detailedrace19901)
    "2015-6" -> Ok(Detailedrace20156)
    "3720-0" -> Ok(Detailedrace37200)
    "1995-0" -> Ok(Detailedrace19950)
    "1997-6" -> Ok(Detailedrace19976)
    "1987-7" -> Ok(Detailedrace19877)
    "2016-4" -> Ok(Detailedrace20164)
    "2017-2" -> Ok(Detailedrace20172)
    "1999-2" -> Ok(Detailedrace19992)
    "1980-2" -> Ok(Detailedrace19802)
    "1981-0" -> Ok(Detailedrace19810)
    "1988-5" -> Ok(Detailedrace19885)
    "1982-8" -> Ok(Detailedrace19828)
    "2000-8" -> Ok(Detailedrace20008)
    "1969-5" -> Ok(Detailedrace19695)
    "2026-3" -> Ok(Detailedrace20263)
    "2018-0" -> Ok(Detailedrace20180)
    "3735-8" -> Ok(Detailedrace37358)
    "2020-6" -> Ok(Detailedrace20206)
    "2021-4" -> Ok(Detailedrace20214)
    "2022-2" -> Ok(Detailedrace20222)
    "2024-8" -> Ok(Detailedrace20248)
    "2002-4" -> Ok(Detailedrace20024)
    "3741-6" -> Ok(Detailedrace37416)
    "1970-3" -> Ok(Detailedrace19703)
    "3743-2" -> Ok(Detailedrace37432)
    "1998-4" -> Ok(Detailedrace19984)
    "3745-7" -> Ok(Detailedrace37457)
    "3746-5" -> Ok(Detailedrace37465)
    "1849-9" -> Ok(Detailedrace18499)
    "1850-7" -> Ok(Detailedrace18507)
    "1852-3" -> Ok(Detailedrace18523)
    "1909-1" -> Ok(Detailedrace19091)
    "3751-5" -> Ok(Detailedrace37515)
    "1842-4" -> Ok(Detailedrace18424)
    "3753-1" -> Ok(Detailedrace37531)
    "1848-1" -> Ok(Detailedrace18481)
    "1862-2" -> Ok(Detailedrace18622)
    "1863-0" -> Ok(Detailedrace18630)
    "3757-2" -> Ok(Detailedrace37572)
    "1871-3" -> Ok(Detailedrace18713)
    "1845-7" -> Ok(Detailedrace18457)
    "1851-5" -> Ok(Detailedrace18515)
    "1853-1" -> Ok(Detailedrace18531)
    "1854-9" -> Ok(Detailedrace18549)
    "1856-4" -> Ok(Detailedrace18564)
    "1857-2" -> Ok(Detailedrace18572)
    "1860-6" -> Ok(Detailedrace18606)
    "1858-0" -> Ok(Detailedrace18580)
    "1864-8" -> Ok(Detailedrace18648)
    "1865-5" -> Ok(Detailedrace18655)
    "1866-3" -> Ok(Detailedrace18663)
    "1867-1" -> Ok(Detailedrace18671)
    "1868-9" -> Ok(Detailedrace18689)
    "1889-5" -> Ok(Detailedrace18895)
    "1933-1" -> Ok(Detailedrace19331)
    "1872-1" -> Ok(Detailedrace18721)
    "1875-4" -> Ok(Detailedrace18754)
    "1876-2" -> Ok(Detailedrace18762)
    "1877-0" -> Ok(Detailedrace18770)
    "1878-8" -> Ok(Detailedrace18788)
    "1879-6" -> Ok(Detailedrace18796)
    "1880-4" -> Ok(Detailedrace18804)
    "1881-2" -> Ok(Detailedrace18812)
    "1883-8" -> Ok(Detailedrace18838)
    "1884-6" -> Ok(Detailedrace18846)
    "1886-1" -> Ok(Detailedrace18861)
    "3785-3" -> Ok(Detailedrace37853)
    "1873-9" -> Ok(Detailedrace18739)
    "1874-7" -> Ok(Detailedrace18747)
    "3788-7" -> Ok(Detailedrace37887)
    "1882-0" -> Ok(Detailedrace18820)
    "1885-3" -> Ok(Detailedrace18853)
    "1833-3" -> Ok(Detailedrace18333)
    "3861-2" -> Ok(Detailedrace38612)
    "1816-8" -> Ok(Detailedrace18168)
    "1817-6" -> Ok(Detailedrace18176)
    "1818-4" -> Ok(Detailedrace18184)
    "1819-2" -> Ok(Detailedrace18192)
    "1820-0" -> Ok(Detailedrace18200)
    "1821-8" -> Ok(Detailedrace18218)
    "1822-6" -> Ok(Detailedrace18226)
    "1826-7" -> Ok(Detailedrace18267)
    "1827-5" -> Ok(Detailedrace18275)
    "1823-4" -> Ok(Detailedrace18234)
    "1824-2" -> Ok(Detailedrace18242)
    "1830-9" -> Ok(Detailedrace18309)
    "1828-3" -> Ok(Detailedrace18283)
    "1829-1" -> Ok(Detailedrace18291)
    "1811-9" -> Ok(Detailedrace18119)
    "1831-7" -> Ok(Detailedrace18317)
    "3809-1" -> Ok(Detailedrace38091)
    "1832-5" -> Ok(Detailedrace18325)
    "1814-3" -> Ok(Detailedrace18143)
    "1834-1" -> Ok(Detailedrace18341)
    "1835-8" -> Ok(Detailedrace18358)
    "1837-4" -> Ok(Detailedrace18374)
    "1838-2" -> Ok(Detailedrace18382)
    "1896-0" -> Ok(Detailedrace18960)
    "1897-8" -> Ok(Detailedrace18978)
    "1898-6" -> Ok(Detailedrace18986)
    "1963-8" -> Ok(Detailedrace19638)
    "1934-9" -> Ok(Detailedrace19349)
    "1906-7" -> Ok(Detailedrace19067)
    "1907-5" -> Ok(Detailedrace19075)
    "3823-2" -> Ok(Detailedrace38232)
    "1913-3" -> Ok(Detailedrace19133)
    "1916-6" -> Ok(Detailedrace19166)
    "3826-5" -> Ok(Detailedrace38265)
    "1920-8" -> Ok(Detailedrace19208)
    "1929-9" -> Ok(Detailedrace19299)
    "1931-5" -> Ok(Detailedrace19315)
    "1935-6" -> Ok(Detailedrace19356)
    "1900-0" -> Ok(Detailedrace19000)
    "1910-9" -> Ok(Detailedrace19109)
    "1914-1" -> Ok(Detailedrace19141)
    "1915-8" -> Ok(Detailedrace19158)
    "1892-9" -> Ok(Detailedrace18929)
    "1962-0" -> Ok(Detailedrace19620)
    "1918-2" -> Ok(Detailedrace19182)
    "3838-0" -> Ok(Detailedrace38380)
    "1919-0" -> Ok(Detailedrace19190)
    "1922-4" -> Ok(Detailedrace19224)
    "1923-2" -> Ok(Detailedrace19232)
    "1925-7" -> Ok(Detailedrace19257)
    "1928-1" -> Ok(Detailedrace19281)
    "1949-7" -> Ok(Detailedrace19497)
    "1932-3" -> Ok(Detailedrace19323)
    "1936-4" -> Ok(Detailedrace19364)
    "1937-2" -> Ok(Detailedrace19372)
    "1938-0" -> Ok(Detailedrace19380)
    "1942-2" -> Ok(Detailedrace19422)
    "1953-9" -> Ok(Detailedrace19539)
    "1943-0" -> Ok(Detailedrace19430)
    "1946-3" -> Ok(Detailedrace19463)
    "1951-3" -> Ok(Detailedrace19513)
    "1893-7" -> Ok(Detailedrace18937)
    "1952-1" -> Ok(Detailedrace19521)
    "1959-6" -> Ok(Detailedrace19596)
    "1960-4" -> Ok(Detailedrace19604)
    "1924-0" -> Ok(Detailedrace19240)
    "1940-6" -> Ok(Detailedrace19406)
    "1939-8" -> Ok(Detailedrace19398)
    "1941-4" -> Ok(Detailedrace19414)
    "1957-0" -> Ok(Detailedrace19570)
    "1927-3" -> Ok(Detailedrace19273)
    "1904-2" -> Ok(Detailedrace19042)
    "1944-8" -> Ok(Detailedrace19448)
    "1945-5" -> Ok(Detailedrace19455)
    "1947-1" -> Ok(Detailedrace19471)
    "1948-9" -> Ok(Detailedrace19489)
    "1894-5" -> Ok(Detailedrace18945)
    "1955-4" -> Ok(Detailedrace19554)
    "1956-2" -> Ok(Detailedrace19562)
    "1958-8" -> Ok(Detailedrace19588)
    "1961-2" -> Ok(Detailedrace19612)
    "1964-6" -> Ok(Detailedrace19646)
    "1899-4" -> Ok(Detailedrace18994)
    "1902-6" -> Ok(Detailedrace19026)
    "1903-4" -> Ok(Detailedrace19034)
    "1905-9" -> Ok(Detailedrace19059)
    "1908-3" -> Ok(Detailedrace19083)
    "1911-7" -> Ok(Detailedrace19117)
    "1912-5" -> Ok(Detailedrace19125)
    "1921-6" -> Ok(Detailedrace19216)
    "1926-5" -> Ok(Detailedrace19265)
    "1930-7" -> Ok(Detailedrace19307)
    "3885-1" -> Ok(Detailedrace38851)
    "1950-5" -> Ok(Detailedrace19505)
    "1954-7" -> Ok(Detailedrace19547)
    "1901-8" -> Ok(Detailedrace19018)
    "3889-3" -> Ok(Detailedrace38893)
    "1069-4" -> Ok(Detailedrace10694)
    "3891-9" -> Ok(Detailedrace38919)
    "3892-7" -> Ok(Detailedrace38927)
    "3893-5" -> Ok(Detailedrace38935)
    "3894-3" -> Ok(Detailedrace38943)
    "3895-0" -> Ok(Detailedrace38950)
    "3896-8" -> Ok(Detailedrace38968)
    "3897-6" -> Ok(Detailedrace38976)
    "3898-4" -> Ok(Detailedrace38984)
    "3899-2" -> Ok(Detailedrace38992)
    "3900-8" -> Ok(Detailedrace39008)
    "3901-6" -> Ok(Detailedrace39016)
    "3902-4" -> Ok(Detailedrace39024)
    "3903-2" -> Ok(Detailedrace39032)
    "3904-0" -> Ok(Detailedrace39040)
    "3905-7" -> Ok(Detailedrace39057)
    "3906-5" -> Ok(Detailedrace39065)
    "3907-3" -> Ok(Detailedrace39073)
    "3908-1" -> Ok(Detailedrace39081)
    "3909-9" -> Ok(Detailedrace39099)
    "3910-7" -> Ok(Detailedrace39107)
    "3911-5" -> Ok(Detailedrace39115)
    "3912-3" -> Ok(Detailedrace39123)
    "3913-1" -> Ok(Detailedrace39131)
    "3914-9" -> Ok(Detailedrace39149)
    "3915-6" -> Ok(Detailedrace39156)
    "3916-4" -> Ok(Detailedrace39164)
    "3917-2" -> Ok(Detailedrace39172)
    "3918-0" -> Ok(Detailedrace39180)
    "3919-8" -> Ok(Detailedrace39198)
    "3920-6" -> Ok(Detailedrace39206)
    "3921-4" -> Ok(Detailedrace39214)
    "3922-2" -> Ok(Detailedrace39222)
    "3923-0" -> Ok(Detailedrace39230)
    "3924-8" -> Ok(Detailedrace39248)
    "3925-5" -> Ok(Detailedrace39255)
    "3926-3" -> Ok(Detailedrace39263)
    "3927-1" -> Ok(Detailedrace39271)
    "3928-9" -> Ok(Detailedrace39289)
    "3929-7" -> Ok(Detailedrace39297)
    "3930-5" -> Ok(Detailedrace39305)
    "3931-3" -> Ok(Detailedrace39313)
    "3932-1" -> Ok(Detailedrace39321)
    "3933-9" -> Ok(Detailedrace39339)
    "3934-7" -> Ok(Detailedrace39347)
    "3935-4" -> Ok(Detailedrace39354)
    "3936-2" -> Ok(Detailedrace39362)
    "3937-0" -> Ok(Detailedrace39370)
    "3938-8" -> Ok(Detailedrace39388)
    "3939-6" -> Ok(Detailedrace39396)
    "3940-4" -> Ok(Detailedrace39404)
    "3941-2" -> Ok(Detailedrace39412)
    "3942-0" -> Ok(Detailedrace39420)
    "3943-8" -> Ok(Detailedrace39438)
    "3944-6" -> Ok(Detailedrace39446)
    "3945-3" -> Ok(Detailedrace39453)
    "3946-1" -> Ok(Detailedrace39461)
    "3947-9" -> Ok(Detailedrace39479)
    "3948-7" -> Ok(Detailedrace39487)
    "3949-5" -> Ok(Detailedrace39495)
    "1071-0" -> Ok(Detailedrace10710)
    "3951-1" -> Ok(Detailedrace39511)
    "3952-9" -> Ok(Detailedrace39529)
    "3953-7" -> Ok(Detailedrace39537)
    "3954-5" -> Ok(Detailedrace39545)
    "3955-2" -> Ok(Detailedrace39552)
    "3956-0" -> Ok(Detailedrace39560)
    "3957-8" -> Ok(Detailedrace39578)
    "3958-6" -> Ok(Detailedrace39586)
    "3959-4" -> Ok(Detailedrace39594)
    "3960-2" -> Ok(Detailedrace39602)
    "3961-0" -> Ok(Detailedrace39610)
    "3962-8" -> Ok(Detailedrace39628)
    "3963-6" -> Ok(Detailedrace39636)
    "3964-4" -> Ok(Detailedrace39644)
    "3965-1" -> Ok(Detailedrace39651)
    "3966-9" -> Ok(Detailedrace39669)
    "3967-7" -> Ok(Detailedrace39677)
    "3968-5" -> Ok(Detailedrace39685)
    "3969-3" -> Ok(Detailedrace39693)
    "3970-1" -> Ok(Detailedrace39701)
    "3971-9" -> Ok(Detailedrace39719)
    "3972-7" -> Ok(Detailedrace39727)
    "3973-5" -> Ok(Detailedrace39735)
    "3974-3" -> Ok(Detailedrace39743)
    "3975-0" -> Ok(Detailedrace39750)
    "3976-8" -> Ok(Detailedrace39768)
    "3977-6" -> Ok(Detailedrace39776)
    "3978-4" -> Ok(Detailedrace39784)
    "3979-2" -> Ok(Detailedrace39792)
    "3980-0" -> Ok(Detailedrace39800)
    "3981-8" -> Ok(Detailedrace39818)
    "3982-6" -> Ok(Detailedrace39826)
    "3983-4" -> Ok(Detailedrace39834)
    "3984-2" -> Ok(Detailedrace39842)
    "3985-9" -> Ok(Detailedrace39859)
    "3986-7" -> Ok(Detailedrace39867)
    "3987-5" -> Ok(Detailedrace39875)
    "3988-3" -> Ok(Detailedrace39883)
    "3989-1" -> Ok(Detailedrace39891)
    "3990-9" -> Ok(Detailedrace39909)
    "3991-7" -> Ok(Detailedrace39917)
    "3992-5" -> Ok(Detailedrace39925)
    "3993-3" -> Ok(Detailedrace39933)
    "3994-1" -> Ok(Detailedrace39941)
    "3995-8" -> Ok(Detailedrace39958)
    "3996-6" -> Ok(Detailedrace39966)
    "3997-4" -> Ok(Detailedrace39974)
    "3998-2" -> Ok(Detailedrace39982)
    "3999-0" -> Ok(Detailedrace39990)
    "4000-6" -> Ok(Detailedrace40006)
    "4001-4" -> Ok(Detailedrace40014)
    "4002-2" -> Ok(Detailedrace40022)
    "4003-0" -> Ok(Detailedrace40030)
    "4004-8" -> Ok(Detailedrace40048)
    "4005-5" -> Ok(Detailedrace40055)
    "4006-3" -> Ok(Detailedrace40063)
    "4007-1" -> Ok(Detailedrace40071)
    "4008-9" -> Ok(Detailedrace40089)
    "4009-7" -> Ok(Detailedrace40097)
    "4010-5" -> Ok(Detailedrace40105)
    "4011-3" -> Ok(Detailedrace40113)
    "4012-1" -> Ok(Detailedrace40121)
    "4013-9" -> Ok(Detailedrace40139)
    "4014-7" -> Ok(Detailedrace40147)
    "4015-4" -> Ok(Detailedrace40154)
    "4016-2" -> Ok(Detailedrace40162)
    "4017-0" -> Ok(Detailedrace40170)
    "4018-8" -> Ok(Detailedrace40188)
    "4019-6" -> Ok(Detailedrace40196)
    "4020-4" -> Ok(Detailedrace40204)
    "4021-2" -> Ok(Detailedrace40212)
    "4022-0" -> Ok(Detailedrace40220)
    "4023-8" -> Ok(Detailedrace40238)
    "4024-6" -> Ok(Detailedrace40246)
    "4025-3" -> Ok(Detailedrace40253)
    "4026-1" -> Ok(Detailedrace40261)
    "4027-9" -> Ok(Detailedrace40279)
    "4028-7" -> Ok(Detailedrace40287)
    "4029-5" -> Ok(Detailedrace40295)
    "4030-3" -> Ok(Detailedrace40303)
    "4031-1" -> Ok(Detailedrace40311)
    "4032-9" -> Ok(Detailedrace40329)
    "4033-7" -> Ok(Detailedrace40337)
    "4034-5" -> Ok(Detailedrace40345)
    "4035-2" -> Ok(Detailedrace40352)
    "4036-0" -> Ok(Detailedrace40360)
    "4037-8" -> Ok(Detailedrace40378)
    "4038-6" -> Ok(Detailedrace40386)
    "4039-4" -> Ok(Detailedrace40394)
    "4040-2" -> Ok(Detailedrace40402)
    "4041-0" -> Ok(Detailedrace40410)
    "4042-8" -> Ok(Detailedrace40428)
    "4043-6" -> Ok(Detailedrace40436)
    "4044-4" -> Ok(Detailedrace40444)
    "4045-1" -> Ok(Detailedrace40451)
    "4046-9" -> Ok(Detailedrace40469)
    "4047-7" -> Ok(Detailedrace40477)
    "4048-5" -> Ok(Detailedrace40485)
    "4049-3" -> Ok(Detailedrace40493)
    "4050-1" -> Ok(Detailedrace40501)
    "4051-9" -> Ok(Detailedrace40519)
    "4052-7" -> Ok(Detailedrace40527)
    "4053-5" -> Ok(Detailedrace40535)
    "4054-3" -> Ok(Detailedrace40543)
    "4055-0" -> Ok(Detailedrace40550)
    "4056-8" -> Ok(Detailedrace40568)
    "4057-6" -> Ok(Detailedrace40576)
    "4058-4" -> Ok(Detailedrace40584)
    "4059-2" -> Ok(Detailedrace40592)
    "4060-0" -> Ok(Detailedrace40600)
    "4061-8" -> Ok(Detailedrace40618)
    "4062-6" -> Ok(Detailedrace40626)
    "4063-4" -> Ok(Detailedrace40634)
    "4064-2" -> Ok(Detailedrace40642)
    "4065-9" -> Ok(Detailedrace40659)
    "4066-7" -> Ok(Detailedrace40667)
    "4067-5" -> Ok(Detailedrace40675)
    "4068-3" -> Ok(Detailedrace40683)
    "4069-1" -> Ok(Detailedrace40691)
    "4070-9" -> Ok(Detailedrace40709)
    "4071-7" -> Ok(Detailedrace40717)
    "4072-5" -> Ok(Detailedrace40725)
    "4073-3" -> Ok(Detailedrace40733)
    "4074-1" -> Ok(Detailedrace40741)
    "4075-8" -> Ok(Detailedrace40758)
    "4076-6" -> Ok(Detailedrace40766)
    "4077-4" -> Ok(Detailedrace40774)
    "4078-2" -> Ok(Detailedrace40782)
    "4079-0" -> Ok(Detailedrace40790)
    "4080-8" -> Ok(Detailedrace40808)
    "4081-6" -> Ok(Detailedrace40816)
    "4082-4" -> Ok(Detailedrace40824)
    "4083-2" -> Ok(Detailedrace40832)
    "4084-0" -> Ok(Detailedrace40840)
    "4085-7" -> Ok(Detailedrace40857)
    "1070-2" -> Ok(Detailedrace10702)
    "4087-3" -> Ok(Detailedrace40873)
    "4088-1" -> Ok(Detailedrace40881)
    "4089-9" -> Ok(Detailedrace40899)
    "4090-7" -> Ok(Detailedrace40907)
    "4091-5" -> Ok(Detailedrace40915)
    "4092-3" -> Ok(Detailedrace40923)
    "4093-1" -> Ok(Detailedrace40931)
    "4094-9" -> Ok(Detailedrace40949)
    "4095-6" -> Ok(Detailedrace40956)
    "4096-4" -> Ok(Detailedrace40964)
    "4097-2" -> Ok(Detailedrace40972)
    "4098-0" -> Ok(Detailedrace40980)
    "4099-8" -> Ok(Detailedrace40998)
    "4100-4" -> Ok(Detailedrace41004)
    "4101-2" -> Ok(Detailedrace41012)
    "4102-0" -> Ok(Detailedrace41020)
    "4103-8" -> Ok(Detailedrace41038)
    "4104-6" -> Ok(Detailedrace41046)
    "4105-3" -> Ok(Detailedrace41053)
    "4106-1" -> Ok(Detailedrace41061)
    "4107-9" -> Ok(Detailedrace41079)
    "4108-7" -> Ok(Detailedrace41087)
    "4109-5" -> Ok(Detailedrace41095)
    "4110-3" -> Ok(Detailedrace41103)
    "4111-1" -> Ok(Detailedrace41111)
    "4112-9" -> Ok(Detailedrace41129)
    "4113-7" -> Ok(Detailedrace41137)
    "4114-5" -> Ok(Detailedrace41145)
    "4115-2" -> Ok(Detailedrace41152)
    "4116-0" -> Ok(Detailedrace41160)
    "4117-8" -> Ok(Detailedrace41178)
    "4118-6" -> Ok(Detailedrace41186)
    "4119-4" -> Ok(Detailedrace41194)
    "4120-2" -> Ok(Detailedrace41202)
    "4121-0" -> Ok(Detailedrace41210)
    "4122-8" -> Ok(Detailedrace41228)
    "4123-6" -> Ok(Detailedrace41236)
    "4124-4" -> Ok(Detailedrace41244)
    "4125-1" -> Ok(Detailedrace41251)
    "4126-9" -> Ok(Detailedrace41269)
    "4127-7" -> Ok(Detailedrace41277)
    "4128-5" -> Ok(Detailedrace41285)
    "4129-3" -> Ok(Detailedrace41293)
    "4130-1" -> Ok(Detailedrace41301)
    "4131-9" -> Ok(Detailedrace41319)
    "4132-7" -> Ok(Detailedrace41327)
    "4133-5" -> Ok(Detailedrace41335)
    "4134-3" -> Ok(Detailedrace41343)
    "4135-0" -> Ok(Detailedrace41350)
    "4136-8" -> Ok(Detailedrace41368)
    "4137-6" -> Ok(Detailedrace41376)
    "4138-4" -> Ok(Detailedrace41384)
    "4139-2" -> Ok(Detailedrace41392)
    "4140-0" -> Ok(Detailedrace41400)
    "4141-8" -> Ok(Detailedrace41418)
    "4142-6" -> Ok(Detailedrace41426)
    "4143-4" -> Ok(Detailedrace41434)
    "4144-2" -> Ok(Detailedrace41442)
    "4145-9" -> Ok(Detailedrace41459)
    "4146-7" -> Ok(Detailedrace41467)
    "1072-8" -> Ok(Detailedrace10728)
    "4148-3" -> Ok(Detailedrace41483)
    "1073-6" -> Ok(Detailedrace10736)
    "4150-9" -> Ok(Detailedrace41509)
    "4151-7" -> Ok(Detailedrace41517)
    "4152-5" -> Ok(Detailedrace41525)
    "4153-3" -> Ok(Detailedrace41533)
    "4154-1" -> Ok(Detailedrace41541)
    "4155-8" -> Ok(Detailedrace41558)
    "4156-6" -> Ok(Detailedrace41566)
    "4157-4" -> Ok(Detailedrace41574)
    "4158-2" -> Ok(Detailedrace41582)
    "4159-0" -> Ok(Detailedrace41590)
    "4160-8" -> Ok(Detailedrace41608)
    "4161-6" -> Ok(Detailedrace41616)
    "4162-4" -> Ok(Detailedrace41624)
    "4163-2" -> Ok(Detailedrace41632)
    "4164-0" -> Ok(Detailedrace41640)
    "4165-7" -> Ok(Detailedrace41657)
    "4166-5" -> Ok(Detailedrace41665)
    "4167-3" -> Ok(Detailedrace41673)
    "4168-1" -> Ok(Detailedrace41681)
    "4169-9" -> Ok(Detailedrace41699)
    "4170-7" -> Ok(Detailedrace41707)
    "4171-5" -> Ok(Detailedrace41715)
    "4172-3" -> Ok(Detailedrace41723)
    "4173-1" -> Ok(Detailedrace41731)
    "4174-9" -> Ok(Detailedrace41749)
    "4175-6" -> Ok(Detailedrace41756)
    "4176-4" -> Ok(Detailedrace41764)
    "4177-2" -> Ok(Detailedrace41772)
    "4178-0" -> Ok(Detailedrace41780)
    "4179-8" -> Ok(Detailedrace41798)
    "4180-6" -> Ok(Detailedrace41806)
    "4181-4" -> Ok(Detailedrace41814)
    "1074-4" -> Ok(Detailedrace10744)
    "4183-0" -> Ok(Detailedrace41830)
    "4184-8" -> Ok(Detailedrace41848)
    "4185-5" -> Ok(Detailedrace41855)
    "2029-7" -> Ok(Detailedrace20297)
    "2030-5" -> Ok(Detailedrace20305)
    "2031-3" -> Ok(Detailedrace20313)
    "2032-1" -> Ok(Detailedrace20321)
    "2033-9" -> Ok(Detailedrace20339)
    "2034-7" -> Ok(Detailedrace20347)
    "2035-4" -> Ok(Detailedrace20354)
    "2036-2" -> Ok(Detailedrace20362)
    "2037-0" -> Ok(Detailedrace20370)
    "2038-8" -> Ok(Detailedrace20388)
    "2039-6" -> Ok(Detailedrace20396)
    "2040-4" -> Ok(Detailedrace20404)
    "2041-2" -> Ok(Detailedrace20412)
    "2042-0" -> Ok(Detailedrace20420)
    "2043-8" -> Ok(Detailedrace20438)
    "2044-6" -> Ok(Detailedrace20446)
    "2045-3" -> Ok(Detailedrace20453)
    "2046-1" -> Ok(Detailedrace20461)
    "2047-9" -> Ok(Detailedrace20479)
    "2048-7" -> Ok(Detailedrace20487)
    "2049-5" -> Ok(Detailedrace20495)
    "2050-3" -> Ok(Detailedrace20503)
    "2051-1" -> Ok(Detailedrace20511)
    "2052-9" -> Ok(Detailedrace20529)
    "2056-0" -> Ok(Detailedrace20560)
    "2058-6" -> Ok(Detailedrace20586)
    "2060-2" -> Ok(Detailedrace20602)
    "2061-0" -> Ok(Detailedrace20610)
    "2062-8" -> Ok(Detailedrace20628)
    "2063-6" -> Ok(Detailedrace20636)
    "2064-4" -> Ok(Detailedrace20644)
    "2065-1" -> Ok(Detailedrace20651)
    "2066-9" -> Ok(Detailedrace20669)
    "4186-3" -> Ok(Detailedrace41863)
    "2067-7" -> Ok(Detailedrace20677)
    "2068-5" -> Ok(Detailedrace20685)
    "2069-3" -> Ok(Detailedrace20693)
    "2070-1" -> Ok(Detailedrace20701)
    "2071-9" -> Ok(Detailedrace20719)
    "2072-7" -> Ok(Detailedrace20727)
    "2073-5" -> Ok(Detailedrace20735)
    "2074-3" -> Ok(Detailedrace20743)
    "2075-0" -> Ok(Detailedrace20750)
    "2078-4" -> Ok(Detailedrace20784)
    "2079-2" -> Ok(Detailedrace20792)
    "2080-0" -> Ok(Detailedrace20800)
    "2081-8" -> Ok(Detailedrace20818)
    "2082-6" -> Ok(Detailedrace20826)
    "2083-4" -> Ok(Detailedrace20834)
    "2085-9" -> Ok(Detailedrace20859)
    "2086-7" -> Ok(Detailedrace20867)
    "2087-5" -> Ok(Detailedrace20875)
    "2088-3" -> Ok(Detailedrace20883)
    "2089-1" -> Ok(Detailedrace20891)
    "2090-9" -> Ok(Detailedrace20909)
    "2091-7" -> Ok(Detailedrace20917)
    "2092-5" -> Ok(Detailedrace20925)
    "2093-3" -> Ok(Detailedrace20933)
    "2094-1" -> Ok(Detailedrace20941)
    "2095-8" -> Ok(Detailedrace20958)
    "2096-6" -> Ok(Detailedrace20966)
    "2097-4" -> Ok(Detailedrace20974)
    "2098-2" -> Ok(Detailedrace20982)
    "2100-6" -> Ok(Detailedrace21006)
    "2101-4" -> Ok(Detailedrace21014)
    "2102-2" -> Ok(Detailedrace21022)
    "2103-0" -> Ok(Detailedrace21030)
    "2104-8" -> Ok(Detailedrace21048)
    "2500-7" -> Ok(Detailedrace25007)
    "2108-9" -> Ok(Detailedrace21089)
    "2109-7" -> Ok(Detailedrace21097)
    "2110-5" -> Ok(Detailedrace21105)
    "2111-3" -> Ok(Detailedrace21113)
    "2112-1" -> Ok(Detailedrace21121)
    "2113-9" -> Ok(Detailedrace21139)
    "2114-7" -> Ok(Detailedrace21147)
    "2115-4" -> Ok(Detailedrace21154)
    "2116-2" -> Ok(Detailedrace21162)
    "2118-8" -> Ok(Detailedrace21188)
    "2119-6" -> Ok(Detailedrace21196)
    "2120-4" -> Ok(Detailedrace21204)
    "2121-2" -> Ok(Detailedrace21212)
    "2122-0" -> Ok(Detailedrace21220)
    "2123-8" -> Ok(Detailedrace21238)
    "2124-6" -> Ok(Detailedrace21246)
    "2125-3" -> Ok(Detailedrace21253)
    "2126-1" -> Ok(Detailedrace21261)
    "2127-9" -> Ok(Detailedrace21279)
    "2129-5" -> Ok(Detailedrace21295)
    "2131-1" -> Ok(Detailedrace21311)
    "ASKU" -> Ok(DetailedraceAsku)
    "OTH" -> Ok(DetailedraceOth)
    "UNK" -> Ok(DetailedraceUnk)
    _ -> Error(Nil)
  }
}

pub fn detailedrace_decoder() -> Decoder(Detailedrace) {
  use variant <- decode.then(decode.string)
  case detailedrace_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        Detailedrace10041,
        "Detailedrace",
        detailedrace,
        detailedrace_to_code,
      )
  }
}

pub fn detailedrace_from_code_and_system(
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

pub type Documentreferencestatus {
  DocumentreferencestatusCurrent
  DocumentreferencestatusSuperseded
  DocumentreferencestatusEnteredinerror
}

pub const documentreferencestatus: List(Documentreferencestatus) = [
  DocumentreferencestatusCurrent,
  DocumentreferencestatusSuperseded,
  DocumentreferencestatusEnteredinerror,
]

pub fn documentreferencestatus_to_json(
  documentreferencestatus: Documentreferencestatus,
) -> Json {
  json.string(documentreferencestatus_to_code(documentreferencestatus))
}

pub fn documentreferencestatus_to_code(
  documentreferencestatus: Documentreferencestatus,
) -> String {
  case documentreferencestatus {
    DocumentreferencestatusCurrent -> "current"
    DocumentreferencestatusSuperseded -> "superseded"
    DocumentreferencestatusEnteredinerror -> "entered-in-error"
  }
}

pub fn documentreferencestatus_from_code(
  code: String,
) -> Result(Documentreferencestatus, Nil) {
  case code {
    "current" -> Ok(DocumentreferencestatusCurrent)
    "superseded" -> Ok(DocumentreferencestatusSuperseded)
    "entered-in-error" -> Ok(DocumentreferencestatusEnteredinerror)
    _ -> Error(Nil)
  }
}

pub fn documentreferencestatus_decoder() -> Decoder(Documentreferencestatus) {
  use variant <- decode.then(decode.string)
  case documentreferencestatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DocumentreferencestatusCurrent,
        "Documentreferencestatus",
        documentreferencestatus,
        documentreferencestatus_to_code,
      )
  }
}

pub type Documentrelationshiptype {
  DocumentrelationshiptypeReplaces
  DocumentrelationshiptypeTransforms
  DocumentrelationshiptypeSigns
  DocumentrelationshiptypeAppends
}

pub const documentrelationshiptype: List(Documentrelationshiptype) = [
  DocumentrelationshiptypeReplaces,
  DocumentrelationshiptypeTransforms,
  DocumentrelationshiptypeSigns,
  DocumentrelationshiptypeAppends,
]

pub fn documentrelationshiptype_to_json(
  documentrelationshiptype: Documentrelationshiptype,
) -> Json {
  json.string(documentrelationshiptype_to_code(documentrelationshiptype))
}

pub fn documentrelationshiptype_to_code(
  documentrelationshiptype: Documentrelationshiptype,
) -> String {
  case documentrelationshiptype {
    DocumentrelationshiptypeReplaces -> "replaces"
    DocumentrelationshiptypeTransforms -> "transforms"
    DocumentrelationshiptypeSigns -> "signs"
    DocumentrelationshiptypeAppends -> "appends"
  }
}

pub fn documentrelationshiptype_from_code(
  code: String,
) -> Result(Documentrelationshiptype, Nil) {
  case code {
    "replaces" -> Ok(DocumentrelationshiptypeReplaces)
    "transforms" -> Ok(DocumentrelationshiptypeTransforms)
    "signs" -> Ok(DocumentrelationshiptypeSigns)
    "appends" -> Ok(DocumentrelationshiptypeAppends)
    _ -> Error(Nil)
  }
}

pub fn documentrelationshiptype_decoder() -> Decoder(Documentrelationshiptype) {
  use variant <- decode.then(decode.string)
  case documentrelationshiptype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        DocumentrelationshiptypeReplaces,
        "Documentrelationshiptype",
        documentrelationshiptype,
        documentrelationshiptype_to_code,
      )
  }
}

pub type Encounterlocationstatus {
  EncounterlocationstatusPlanned
  EncounterlocationstatusActive
  EncounterlocationstatusReserved
  EncounterlocationstatusCompleted
}

pub const encounterlocationstatus: List(Encounterlocationstatus) = [
  EncounterlocationstatusPlanned,
  EncounterlocationstatusActive,
  EncounterlocationstatusReserved,
  EncounterlocationstatusCompleted,
]

pub fn encounterlocationstatus_to_json(
  encounterlocationstatus: Encounterlocationstatus,
) -> Json {
  json.string(encounterlocationstatus_to_code(encounterlocationstatus))
}

pub fn encounterlocationstatus_to_code(
  encounterlocationstatus: Encounterlocationstatus,
) -> String {
  case encounterlocationstatus {
    EncounterlocationstatusPlanned -> "planned"
    EncounterlocationstatusActive -> "active"
    EncounterlocationstatusReserved -> "reserved"
    EncounterlocationstatusCompleted -> "completed"
  }
}

pub fn encounterlocationstatus_from_code(
  code: String,
) -> Result(Encounterlocationstatus, Nil) {
  case code {
    "planned" -> Ok(EncounterlocationstatusPlanned)
    "active" -> Ok(EncounterlocationstatusActive)
    "reserved" -> Ok(EncounterlocationstatusReserved)
    "completed" -> Ok(EncounterlocationstatusCompleted)
    _ -> Error(Nil)
  }
}

pub fn encounterlocationstatus_decoder() -> Decoder(Encounterlocationstatus) {
  use variant <- decode.then(decode.string)
  case encounterlocationstatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        EncounterlocationstatusPlanned,
        "Encounterlocationstatus",
        encounterlocationstatus,
        encounterlocationstatus_to_code,
      )
  }
}

pub type Encounterstatus {
  EncounterstatusPlanned
  EncounterstatusArrived
  EncounterstatusTriaged
  EncounterstatusInprogress
  EncounterstatusOnleave
  EncounterstatusFinished
  EncounterstatusCancelled
  EncounterstatusEnteredinerror
  EncounterstatusUnknown
}

pub const encounterstatus: List(Encounterstatus) = [
  EncounterstatusPlanned,
  EncounterstatusArrived,
  EncounterstatusTriaged,
  EncounterstatusInprogress,
  EncounterstatusOnleave,
  EncounterstatusFinished,
  EncounterstatusCancelled,
  EncounterstatusEnteredinerror,
  EncounterstatusUnknown,
]

pub fn encounterstatus_to_json(encounterstatus: Encounterstatus) -> Json {
  json.string(encounterstatus_to_code(encounterstatus))
}

pub fn encounterstatus_to_code(encounterstatus: Encounterstatus) -> String {
  case encounterstatus {
    EncounterstatusPlanned -> "planned"
    EncounterstatusArrived -> "arrived"
    EncounterstatusTriaged -> "triaged"
    EncounterstatusInprogress -> "in-progress"
    EncounterstatusOnleave -> "onleave"
    EncounterstatusFinished -> "finished"
    EncounterstatusCancelled -> "cancelled"
    EncounterstatusEnteredinerror -> "entered-in-error"
    EncounterstatusUnknown -> "unknown"
  }
}

pub fn encounterstatus_from_code(code: String) -> Result(Encounterstatus, Nil) {
  case code {
    "planned" -> Ok(EncounterstatusPlanned)
    "arrived" -> Ok(EncounterstatusArrived)
    "triaged" -> Ok(EncounterstatusTriaged)
    "in-progress" -> Ok(EncounterstatusInprogress)
    "onleave" -> Ok(EncounterstatusOnleave)
    "finished" -> Ok(EncounterstatusFinished)
    "cancelled" -> Ok(EncounterstatusCancelled)
    "entered-in-error" -> Ok(EncounterstatusEnteredinerror)
    "unknown" -> Ok(EncounterstatusUnknown)
    _ -> Error(Nil)
  }
}

pub fn encounterstatus_decoder() -> Decoder(Encounterstatus) {
  use variant <- decode.then(decode.string)
  case encounterstatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        EncounterstatusPlanned,
        "Encounterstatus",
        encounterstatus,
        encounterstatus_to_code,
      )
  }
}

pub type Eventtiming {
  EventtimingMorn
  EventtimingMornearly
  EventtimingMornlate
  EventtimingNoon
  EventtimingAft
  EventtimingAftearly
  EventtimingAftlate
  EventtimingEve
  EventtimingEveearly
  EventtimingEvelate
  EventtimingNight
  EventtimingPhs
  EventtimingHs
  EventtimingWake
  EventtimingC
  EventtimingCm
  EventtimingCd
  EventtimingCv
  EventtimingAc
  EventtimingAcm
  EventtimingAcd
  EventtimingAcv
  EventtimingPc
  EventtimingPcm
  EventtimingPcd
  EventtimingPcv
}

pub const eventtiming: List(Eventtiming) = [
  EventtimingMorn,
  EventtimingMornearly,
  EventtimingMornlate,
  EventtimingNoon,
  EventtimingAft,
  EventtimingAftearly,
  EventtimingAftlate,
  EventtimingEve,
  EventtimingEveearly,
  EventtimingEvelate,
  EventtimingNight,
  EventtimingPhs,
  EventtimingHs,
  EventtimingWake,
  EventtimingC,
  EventtimingCm,
  EventtimingCd,
  EventtimingCv,
  EventtimingAc,
  EventtimingAcm,
  EventtimingAcd,
  EventtimingAcv,
  EventtimingPc,
  EventtimingPcm,
  EventtimingPcd,
  EventtimingPcv,
]

pub fn eventtiming_to_json(eventtiming: Eventtiming) -> Json {
  json.string(eventtiming_to_code(eventtiming))
}

pub fn eventtiming_to_code(eventtiming: Eventtiming) -> String {
  case eventtiming {
    EventtimingMorn -> "MORN"
    EventtimingMornearly -> "MORN.early"
    EventtimingMornlate -> "MORN.late"
    EventtimingNoon -> "NOON"
    EventtimingAft -> "AFT"
    EventtimingAftearly -> "AFT.early"
    EventtimingAftlate -> "AFT.late"
    EventtimingEve -> "EVE"
    EventtimingEveearly -> "EVE.early"
    EventtimingEvelate -> "EVE.late"
    EventtimingNight -> "NIGHT"
    EventtimingPhs -> "PHS"
    EventtimingHs -> "HS"
    EventtimingWake -> "WAKE"
    EventtimingC -> "C"
    EventtimingCm -> "CM"
    EventtimingCd -> "CD"
    EventtimingCv -> "CV"
    EventtimingAc -> "AC"
    EventtimingAcm -> "ACM"
    EventtimingAcd -> "ACD"
    EventtimingAcv -> "ACV"
    EventtimingPc -> "PC"
    EventtimingPcm -> "PCM"
    EventtimingPcd -> "PCD"
    EventtimingPcv -> "PCV"
  }
}

pub fn eventtiming_from_code(code: String) -> Result(Eventtiming, Nil) {
  case code {
    "MORN" -> Ok(EventtimingMorn)
    "MORN.early" -> Ok(EventtimingMornearly)
    "MORN.late" -> Ok(EventtimingMornlate)
    "NOON" -> Ok(EventtimingNoon)
    "AFT" -> Ok(EventtimingAft)
    "AFT.early" -> Ok(EventtimingAftearly)
    "AFT.late" -> Ok(EventtimingAftlate)
    "EVE" -> Ok(EventtimingEve)
    "EVE.early" -> Ok(EventtimingEveearly)
    "EVE.late" -> Ok(EventtimingEvelate)
    "NIGHT" -> Ok(EventtimingNight)
    "PHS" -> Ok(EventtimingPhs)
    "HS" -> Ok(EventtimingHs)
    "WAKE" -> Ok(EventtimingWake)
    "C" -> Ok(EventtimingC)
    "CM" -> Ok(EventtimingCm)
    "CD" -> Ok(EventtimingCd)
    "CV" -> Ok(EventtimingCv)
    "AC" -> Ok(EventtimingAc)
    "ACM" -> Ok(EventtimingAcm)
    "ACD" -> Ok(EventtimingAcd)
    "ACV" -> Ok(EventtimingAcv)
    "PC" -> Ok(EventtimingPc)
    "PCM" -> Ok(EventtimingPcm)
    "PCD" -> Ok(EventtimingPcd)
    "PCV" -> Ok(EventtimingPcv)
    _ -> Error(Nil)
  }
}

pub fn eventtiming_decoder() -> Decoder(Eventtiming) {
  use variant <- decode.then(decode.string)
  case eventtiming_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        EventtimingMorn,
        "Eventtiming",
        eventtiming,
        eventtiming_to_code,
      )
  }
}

pub type Identifieruse {
  IdentifieruseUsual
  IdentifieruseOfficial
  IdentifieruseTemp
  IdentifieruseSecondary
  IdentifieruseOld
}

pub const identifieruse: List(Identifieruse) = [
  IdentifieruseUsual,
  IdentifieruseOfficial,
  IdentifieruseTemp,
  IdentifieruseSecondary,
  IdentifieruseOld,
]

pub fn identifieruse_to_json(identifieruse: Identifieruse) -> Json {
  json.string(identifieruse_to_code(identifieruse))
}

pub fn identifieruse_to_code(identifieruse: Identifieruse) -> String {
  case identifieruse {
    IdentifieruseUsual -> "usual"
    IdentifieruseOfficial -> "official"
    IdentifieruseTemp -> "temp"
    IdentifieruseSecondary -> "secondary"
    IdentifieruseOld -> "old"
  }
}

pub fn identifieruse_from_code(code: String) -> Result(Identifieruse, Nil) {
  case code {
    "usual" -> Ok(IdentifieruseUsual)
    "official" -> Ok(IdentifieruseOfficial)
    "temp" -> Ok(IdentifieruseTemp)
    "secondary" -> Ok(IdentifieruseSecondary)
    "old" -> Ok(IdentifieruseOld)
    _ -> Error(Nil)
  }
}

pub fn identifieruse_decoder() -> Decoder(Identifieruse) {
  use variant <- decode.then(decode.string)
  case identifieruse_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        IdentifieruseUsual,
        "Identifieruse",
        identifieruse,
        identifieruse_to_code,
      )
  }
}

pub type Immunizationstatus {
  ImmunizationstatusCompleted
  ImmunizationstatusEnteredinerror
  ImmunizationstatusNotdone
}

pub const immunizationstatus: List(Immunizationstatus) = [
  ImmunizationstatusCompleted,
  ImmunizationstatusEnteredinerror,
  ImmunizationstatusNotdone,
]

pub fn immunizationstatus_to_json(
  immunizationstatus: Immunizationstatus,
) -> Json {
  json.string(immunizationstatus_to_code(immunizationstatus))
}

pub fn immunizationstatus_to_code(
  immunizationstatus: Immunizationstatus,
) -> String {
  case immunizationstatus {
    ImmunizationstatusCompleted -> "completed"
    ImmunizationstatusEnteredinerror -> "entered-in-error"
    ImmunizationstatusNotdone -> "not-done"
  }
}

pub fn immunizationstatus_from_code(
  code: String,
) -> Result(Immunizationstatus, Nil) {
  case code {
    "completed" -> Ok(ImmunizationstatusCompleted)
    "entered-in-error" -> Ok(ImmunizationstatusEnteredinerror)
    "not-done" -> Ok(ImmunizationstatusNotdone)
    _ -> Error(Nil)
  }
}

pub fn immunizationstatus_decoder() -> Decoder(Immunizationstatus) {
  use variant <- decode.then(decode.string)
  case immunizationstatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ImmunizationstatusCompleted,
        "Immunizationstatus",
        immunizationstatus,
        immunizationstatus_to_code,
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

pub type Linktype {
  LinktypeReplacedby
  LinktypeReplaces
  LinktypeRefer
  LinktypeSeealso
}

pub const linktype: List(Linktype) = [
  LinktypeReplacedby,
  LinktypeReplaces,
  LinktypeRefer,
  LinktypeSeealso,
]

pub fn linktype_to_json(linktype: Linktype) -> Json {
  json.string(linktype_to_code(linktype))
}

pub fn linktype_to_code(linktype: Linktype) -> String {
  case linktype {
    LinktypeReplacedby -> "replaced-by"
    LinktypeReplaces -> "replaces"
    LinktypeRefer -> "refer"
    LinktypeSeealso -> "seealso"
  }
}

pub fn linktype_from_code(code: String) -> Result(Linktype, Nil) {
  case code {
    "replaced-by" -> Ok(LinktypeReplacedby)
    "replaces" -> Ok(LinktypeReplaces)
    "refer" -> Ok(LinktypeRefer)
    "seealso" -> Ok(LinktypeSeealso)
    _ -> Error(Nil)
  }
}

pub fn linktype_decoder() -> Decoder(Linktype) {
  use variant <- decode.then(decode.string)
  case linktype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        LinktypeReplacedby,
        "Linktype",
        linktype,
        linktype_to_code,
      )
  }
}

pub type Medicationrequestcategory {
  MedicationrequestcategoryInpatient
  MedicationrequestcategoryOutpatient
  MedicationrequestcategoryCommunity
  MedicationrequestcategoryDischarge
}

pub const medicationrequestcategory: List(Medicationrequestcategory) = [
  MedicationrequestcategoryInpatient,
  MedicationrequestcategoryOutpatient,
  MedicationrequestcategoryCommunity,
  MedicationrequestcategoryDischarge,
]

pub fn medicationrequestcategory_to_json(
  medicationrequestcategory: Medicationrequestcategory,
) -> Json {
  json.string(medicationrequestcategory_to_code(medicationrequestcategory))
}

pub fn medicationrequestcategory_to_code(
  medicationrequestcategory: Medicationrequestcategory,
) -> String {
  case medicationrequestcategory {
    MedicationrequestcategoryInpatient -> "inpatient"
    MedicationrequestcategoryOutpatient -> "outpatient"
    MedicationrequestcategoryCommunity -> "community"
    MedicationrequestcategoryDischarge -> "discharge"
  }
}

pub fn medicationrequestcategory_from_code(
  code: String,
) -> Result(Medicationrequestcategory, Nil) {
  case code {
    "inpatient" -> Ok(MedicationrequestcategoryInpatient)
    "outpatient" -> Ok(MedicationrequestcategoryOutpatient)
    "community" -> Ok(MedicationrequestcategoryCommunity)
    "discharge" -> Ok(MedicationrequestcategoryDischarge)
    _ -> Error(Nil)
  }
}

pub fn medicationrequestcategory_decoder() -> Decoder(Medicationrequestcategory) {
  use variant <- decode.then(decode.string)
  case medicationrequestcategory_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationrequestcategoryInpatient,
        "Medicationrequestcategory",
        medicationrequestcategory,
        medicationrequestcategory_to_code,
      )
  }
}

pub fn medicationrequestcategory_from_code_and_system(
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

pub type Medicationrequestintent {
  MedicationrequestintentProposal
  MedicationrequestintentPlan
  MedicationrequestintentOrder
  MedicationrequestintentOriginalorder
  MedicationrequestintentReflexorder
  MedicationrequestintentFillerorder
  MedicationrequestintentInstanceorder
  MedicationrequestintentOption
}

pub const medicationrequestintent: List(Medicationrequestintent) = [
  MedicationrequestintentProposal,
  MedicationrequestintentPlan,
  MedicationrequestintentOrder,
  MedicationrequestintentOriginalorder,
  MedicationrequestintentReflexorder,
  MedicationrequestintentFillerorder,
  MedicationrequestintentInstanceorder,
  MedicationrequestintentOption,
]

pub fn medicationrequestintent_to_json(
  medicationrequestintent: Medicationrequestintent,
) -> Json {
  json.string(medicationrequestintent_to_code(medicationrequestintent))
}

pub fn medicationrequestintent_to_code(
  medicationrequestintent: Medicationrequestintent,
) -> String {
  case medicationrequestintent {
    MedicationrequestintentProposal -> "proposal"
    MedicationrequestintentPlan -> "plan"
    MedicationrequestintentOrder -> "order"
    MedicationrequestintentOriginalorder -> "original-order"
    MedicationrequestintentReflexorder -> "reflex-order"
    MedicationrequestintentFillerorder -> "filler-order"
    MedicationrequestintentInstanceorder -> "instance-order"
    MedicationrequestintentOption -> "option"
  }
}

pub fn medicationrequestintent_from_code(
  code: String,
) -> Result(Medicationrequestintent, Nil) {
  case code {
    "proposal" -> Ok(MedicationrequestintentProposal)
    "plan" -> Ok(MedicationrequestintentPlan)
    "order" -> Ok(MedicationrequestintentOrder)
    "original-order" -> Ok(MedicationrequestintentOriginalorder)
    "reflex-order" -> Ok(MedicationrequestintentReflexorder)
    "filler-order" -> Ok(MedicationrequestintentFillerorder)
    "instance-order" -> Ok(MedicationrequestintentInstanceorder)
    "option" -> Ok(MedicationrequestintentOption)
    _ -> Error(Nil)
  }
}

pub fn medicationrequestintent_decoder() -> Decoder(Medicationrequestintent) {
  use variant <- decode.then(decode.string)
  case medicationrequestintent_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationrequestintentProposal,
        "Medicationrequestintent",
        medicationrequestintent,
        medicationrequestintent_to_code,
      )
  }
}

pub type Medicationrequeststatus {
  MedicationrequeststatusActive
  MedicationrequeststatusOnhold
  MedicationrequeststatusCancelled
  MedicationrequeststatusCompleted
  MedicationrequeststatusEnteredinerror
  MedicationrequeststatusStopped
  MedicationrequeststatusDraft
  MedicationrequeststatusUnknown
}

pub const medicationrequeststatus: List(Medicationrequeststatus) = [
  MedicationrequeststatusActive,
  MedicationrequeststatusOnhold,
  MedicationrequeststatusCancelled,
  MedicationrequeststatusCompleted,
  MedicationrequeststatusEnteredinerror,
  MedicationrequeststatusStopped,
  MedicationrequeststatusDraft,
  MedicationrequeststatusUnknown,
]

pub fn medicationrequeststatus_to_json(
  medicationrequeststatus: Medicationrequeststatus,
) -> Json {
  json.string(medicationrequeststatus_to_code(medicationrequeststatus))
}

pub fn medicationrequeststatus_to_code(
  medicationrequeststatus: Medicationrequeststatus,
) -> String {
  case medicationrequeststatus {
    MedicationrequeststatusActive -> "active"
    MedicationrequeststatusOnhold -> "on-hold"
    MedicationrequeststatusCancelled -> "cancelled"
    MedicationrequeststatusCompleted -> "completed"
    MedicationrequeststatusEnteredinerror -> "entered-in-error"
    MedicationrequeststatusStopped -> "stopped"
    MedicationrequeststatusDraft -> "draft"
    MedicationrequeststatusUnknown -> "unknown"
  }
}

pub fn medicationrequeststatus_from_code(
  code: String,
) -> Result(Medicationrequeststatus, Nil) {
  case code {
    "active" -> Ok(MedicationrequeststatusActive)
    "on-hold" -> Ok(MedicationrequeststatusOnhold)
    "cancelled" -> Ok(MedicationrequeststatusCancelled)
    "completed" -> Ok(MedicationrequeststatusCompleted)
    "entered-in-error" -> Ok(MedicationrequeststatusEnteredinerror)
    "stopped" -> Ok(MedicationrequeststatusStopped)
    "draft" -> Ok(MedicationrequeststatusDraft)
    "unknown" -> Ok(MedicationrequeststatusUnknown)
    _ -> Error(Nil)
  }
}

pub fn medicationrequeststatus_decoder() -> Decoder(Medicationrequeststatus) {
  use variant <- decode.then(decode.string)
  case medicationrequeststatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationrequeststatusActive,
        "Medicationrequeststatus",
        medicationrequeststatus,
        medicationrequeststatus_to_code,
      )
  }
}

pub type Medicationstatementstatus {
  MedicationstatementstatusActive
  MedicationstatementstatusCompleted
  MedicationstatementstatusEnteredinerror
  MedicationstatementstatusIntended
  MedicationstatementstatusStopped
  MedicationstatementstatusOnhold
  MedicationstatementstatusUnknown
  MedicationstatementstatusNottaken
}

pub const medicationstatementstatus: List(Medicationstatementstatus) = [
  MedicationstatementstatusActive,
  MedicationstatementstatusCompleted,
  MedicationstatementstatusEnteredinerror,
  MedicationstatementstatusIntended,
  MedicationstatementstatusStopped,
  MedicationstatementstatusOnhold,
  MedicationstatementstatusUnknown,
  MedicationstatementstatusNottaken,
]

pub fn medicationstatementstatus_to_json(
  medicationstatementstatus: Medicationstatementstatus,
) -> Json {
  json.string(medicationstatementstatus_to_code(medicationstatementstatus))
}

pub fn medicationstatementstatus_to_code(
  medicationstatementstatus: Medicationstatementstatus,
) -> String {
  case medicationstatementstatus {
    MedicationstatementstatusActive -> "active"
    MedicationstatementstatusCompleted -> "completed"
    MedicationstatementstatusEnteredinerror -> "entered-in-error"
    MedicationstatementstatusIntended -> "intended"
    MedicationstatementstatusStopped -> "stopped"
    MedicationstatementstatusOnhold -> "on-hold"
    MedicationstatementstatusUnknown -> "unknown"
    MedicationstatementstatusNottaken -> "not-taken"
  }
}

pub fn medicationstatementstatus_from_code(
  code: String,
) -> Result(Medicationstatementstatus, Nil) {
  case code {
    "active" -> Ok(MedicationstatementstatusActive)
    "completed" -> Ok(MedicationstatementstatusCompleted)
    "entered-in-error" -> Ok(MedicationstatementstatusEnteredinerror)
    "intended" -> Ok(MedicationstatementstatusIntended)
    "stopped" -> Ok(MedicationstatementstatusStopped)
    "on-hold" -> Ok(MedicationstatementstatusOnhold)
    "unknown" -> Ok(MedicationstatementstatusUnknown)
    "not-taken" -> Ok(MedicationstatementstatusNottaken)
    _ -> Error(Nil)
  }
}

pub fn medicationstatementstatus_decoder() -> Decoder(Medicationstatementstatus) {
  use variant <- decode.then(decode.string)
  case medicationstatementstatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        MedicationstatementstatusActive,
        "Medicationstatementstatus",
        medicationstatementstatus,
        medicationstatementstatus_to_code,
      )
  }
}

pub type Nameuse {
  NameuseUsual
  NameuseOfficial
  NameuseTemp
  NameuseNickname
  NameuseAnonymous
  NameuseOld
  NameuseMaiden
}

pub const nameuse: List(Nameuse) = [
  NameuseUsual,
  NameuseOfficial,
  NameuseTemp,
  NameuseNickname,
  NameuseAnonymous,
  NameuseOld,
  NameuseMaiden,
]

pub fn nameuse_to_json(nameuse: Nameuse) -> Json {
  json.string(nameuse_to_code(nameuse))
}

pub fn nameuse_to_code(nameuse: Nameuse) -> String {
  case nameuse {
    NameuseUsual -> "usual"
    NameuseOfficial -> "official"
    NameuseTemp -> "temp"
    NameuseNickname -> "nickname"
    NameuseAnonymous -> "anonymous"
    NameuseOld -> "old"
    NameuseMaiden -> "maiden"
  }
}

pub fn nameuse_from_code(code: String) -> Result(Nameuse, Nil) {
  case code {
    "usual" -> Ok(NameuseUsual)
    "official" -> Ok(NameuseOfficial)
    "temp" -> Ok(NameuseTemp)
    "nickname" -> Ok(NameuseNickname)
    "anonymous" -> Ok(NameuseAnonymous)
    "old" -> Ok(NameuseOld)
    "maiden" -> Ok(NameuseMaiden)
    _ -> Error(Nil)
  }
}

pub fn nameuse_decoder() -> Decoder(Nameuse) {
  use variant <- decode.then(decode.string)
  case nameuse_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        NameuseUsual,
        "Nameuse",
        nameuse,
        nameuse_to_code,
      )
  }
}

pub type Narrativestatus {
  NarrativestatusGenerated
  NarrativestatusExtensions
  NarrativestatusAdditional
  NarrativestatusEmpty
}

pub const narrativestatus: List(Narrativestatus) = [
  NarrativestatusGenerated,
  NarrativestatusExtensions,
  NarrativestatusAdditional,
  NarrativestatusEmpty,
]

pub fn narrativestatus_to_json(narrativestatus: Narrativestatus) -> Json {
  json.string(narrativestatus_to_code(narrativestatus))
}

pub fn narrativestatus_to_code(narrativestatus: Narrativestatus) -> String {
  case narrativestatus {
    NarrativestatusGenerated -> "generated"
    NarrativestatusExtensions -> "extensions"
    NarrativestatusAdditional -> "additional"
    NarrativestatusEmpty -> "empty"
  }
}

pub fn narrativestatus_from_code(code: String) -> Result(Narrativestatus, Nil) {
  case code {
    "generated" -> Ok(NarrativestatusGenerated)
    "extensions" -> Ok(NarrativestatusExtensions)
    "additional" -> Ok(NarrativestatusAdditional)
    "empty" -> Ok(NarrativestatusEmpty)
    _ -> Error(Nil)
  }
}

pub fn narrativestatus_decoder() -> Decoder(Narrativestatus) {
  use variant <- decode.then(decode.string)
  case narrativestatus_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        NarrativestatusGenerated,
        "Narrativestatus",
        narrativestatus,
        narrativestatus_to_code,
      )
  }
}

pub type Ombethnicitycategory {
  Ombethnicitycategory21352
  Ombethnicitycategory21865
  OmbethnicitycategoryAsku
  OmbethnicitycategoryUnk
}

pub const ombethnicitycategory: List(Ombethnicitycategory) = [
  Ombethnicitycategory21352,
  Ombethnicitycategory21865,
  OmbethnicitycategoryAsku,
  OmbethnicitycategoryUnk,
]

pub fn ombethnicitycategory_to_json(
  ombethnicitycategory: Ombethnicitycategory,
) -> Json {
  json.string(ombethnicitycategory_to_code(ombethnicitycategory))
}

pub fn ombethnicitycategory_to_code(
  ombethnicitycategory: Ombethnicitycategory,
) -> String {
  case ombethnicitycategory {
    Ombethnicitycategory21352 -> "2135-2"
    Ombethnicitycategory21865 -> "2186-5"
    OmbethnicitycategoryAsku -> "ASKU"
    OmbethnicitycategoryUnk -> "UNK"
  }
}

pub fn ombethnicitycategory_from_code(
  code: String,
) -> Result(Ombethnicitycategory, Nil) {
  case code {
    "2135-2" -> Ok(Ombethnicitycategory21352)
    "2186-5" -> Ok(Ombethnicitycategory21865)
    "ASKU" -> Ok(OmbethnicitycategoryAsku)
    "UNK" -> Ok(OmbethnicitycategoryUnk)
    _ -> Error(Nil)
  }
}

pub fn ombethnicitycategory_decoder() -> Decoder(Ombethnicitycategory) {
  use variant <- decode.then(decode.string)
  case ombethnicitycategory_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        Ombethnicitycategory21352,
        "Ombethnicitycategory",
        ombethnicitycategory,
        ombethnicitycategory_to_code,
      )
  }
}

pub fn ombethnicitycategory_from_code_and_system(
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

pub type Ombracecategory {
  Ombracecategory10025
  Ombracecategory20289
  Ombracecategory20545
  Ombracecategory20768
  Ombracecategory21063
  Ombracecategory21311
  OmbracecategoryAsku
  OmbracecategoryUnk
}

pub const ombracecategory: List(Ombracecategory) = [
  Ombracecategory10025,
  Ombracecategory20289,
  Ombracecategory20545,
  Ombracecategory20768,
  Ombracecategory21063,
  Ombracecategory21311,
  OmbracecategoryAsku,
  OmbracecategoryUnk,
]

pub fn ombracecategory_to_json(ombracecategory: Ombracecategory) -> Json {
  json.string(ombracecategory_to_code(ombracecategory))
}

pub fn ombracecategory_to_code(ombracecategory: Ombracecategory) -> String {
  case ombracecategory {
    Ombracecategory10025 -> "1002-5"
    Ombracecategory20289 -> "2028-9"
    Ombracecategory20545 -> "2054-5"
    Ombracecategory20768 -> "2076-8"
    Ombracecategory21063 -> "2106-3"
    Ombracecategory21311 -> "2131-1"
    OmbracecategoryAsku -> "ASKU"
    OmbracecategoryUnk -> "UNK"
  }
}

pub fn ombracecategory_from_code(code: String) -> Result(Ombracecategory, Nil) {
  case code {
    "1002-5" -> Ok(Ombracecategory10025)
    "2028-9" -> Ok(Ombracecategory20289)
    "2054-5" -> Ok(Ombracecategory20545)
    "2076-8" -> Ok(Ombracecategory20768)
    "2106-3" -> Ok(Ombracecategory21063)
    "2131-1" -> Ok(Ombracecategory21311)
    "ASKU" -> Ok(OmbracecategoryAsku)
    "UNK" -> Ok(OmbracecategoryUnk)
    _ -> Error(Nil)
  }
}

pub fn ombracecategory_decoder() -> Decoder(Ombracecategory) {
  use variant <- decode.then(decode.string)
  case ombracecategory_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        Ombracecategory10025,
        "Ombracecategory",
        ombracecategory,
        ombracecategory_to_code,
      )
  }
}

pub fn ombracecategory_from_code_and_system(
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

pub fn participantrequired_from_code(
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
  case participantrequired_from_code(variant) {
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

pub fn participationstatus_from_code(
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
  case participationstatus_from_code(variant) {
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

pub type Quantitycomparator {
  QuantitycomparatorLessthan
  QuantitycomparatorLessthanequal
  QuantitycomparatorGreaterthanequal
  QuantitycomparatorGreaterthan
}

pub const quantitycomparator: List(Quantitycomparator) = [
  QuantitycomparatorLessthan,
  QuantitycomparatorLessthanequal,
  QuantitycomparatorGreaterthanequal,
  QuantitycomparatorGreaterthan,
]

pub fn quantitycomparator_to_json(
  quantitycomparator: Quantitycomparator,
) -> Json {
  json.string(quantitycomparator_to_code(quantitycomparator))
}

pub fn quantitycomparator_to_code(
  quantitycomparator: Quantitycomparator,
) -> String {
  case quantitycomparator {
    QuantitycomparatorLessthan -> "<"
    QuantitycomparatorLessthanequal -> "<="
    QuantitycomparatorGreaterthanequal -> ">="
    QuantitycomparatorGreaterthan -> ">"
  }
}

pub fn quantitycomparator_from_code(
  code: String,
) -> Result(Quantitycomparator, Nil) {
  case code {
    "<" -> Ok(QuantitycomparatorLessthan)
    "<=" -> Ok(QuantitycomparatorLessthanequal)
    ">=" -> Ok(QuantitycomparatorGreaterthanequal)
    ">" -> Ok(QuantitycomparatorGreaterthan)
    _ -> Error(Nil)
  }
}

pub fn quantitycomparator_decoder() -> Decoder(Quantitycomparator) {
  use variant <- decode.then(decode.string)
  case quantitycomparator_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        QuantitycomparatorLessthan,
        "Quantitycomparator",
        quantitycomparator,
        quantitycomparator_to_code,
      )
  }
}

pub type Reactioneventseverity {
  ReactioneventseverityMild
  ReactioneventseverityModerate
  ReactioneventseveritySevere
}

pub const reactioneventseverity: List(Reactioneventseverity) = [
  ReactioneventseverityMild,
  ReactioneventseverityModerate,
  ReactioneventseveritySevere,
]

pub fn reactioneventseverity_to_json(
  reactioneventseverity: Reactioneventseverity,
) -> Json {
  json.string(reactioneventseverity_to_code(reactioneventseverity))
}

pub fn reactioneventseverity_to_code(
  reactioneventseverity: Reactioneventseverity,
) -> String {
  case reactioneventseverity {
    ReactioneventseverityMild -> "mild"
    ReactioneventseverityModerate -> "moderate"
    ReactioneventseveritySevere -> "severe"
  }
}

pub fn reactioneventseverity_from_code(
  code: String,
) -> Result(Reactioneventseverity, Nil) {
  case code {
    "mild" -> Ok(ReactioneventseverityMild)
    "moderate" -> Ok(ReactioneventseverityModerate)
    "severe" -> Ok(ReactioneventseveritySevere)
    _ -> Error(Nil)
  }
}

pub fn reactioneventseverity_decoder() -> Decoder(Reactioneventseverity) {
  use variant <- decode.then(decode.string)
  case reactioneventseverity_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ReactioneventseverityMild,
        "Reactioneventseverity",
        reactioneventseverity,
        reactioneventseverity_to_code,
      )
  }
}

pub type Requestpriority {
  RequestpriorityRoutine
  RequestpriorityUrgent
  RequestpriorityAsap
  RequestpriorityStat
}

pub const requestpriority: List(Requestpriority) = [
  RequestpriorityRoutine,
  RequestpriorityUrgent,
  RequestpriorityAsap,
  RequestpriorityStat,
]

pub fn requestpriority_to_json(requestpriority: Requestpriority) -> Json {
  json.string(requestpriority_to_code(requestpriority))
}

pub fn requestpriority_to_code(requestpriority: Requestpriority) -> String {
  case requestpriority {
    RequestpriorityRoutine -> "routine"
    RequestpriorityUrgent -> "urgent"
    RequestpriorityAsap -> "asap"
    RequestpriorityStat -> "stat"
  }
}

pub fn requestpriority_from_code(code: String) -> Result(Requestpriority, Nil) {
  case code {
    "routine" -> Ok(RequestpriorityRoutine)
    "urgent" -> Ok(RequestpriorityUrgent)
    "asap" -> Ok(RequestpriorityAsap)
    "stat" -> Ok(RequestpriorityStat)
    _ -> Error(Nil)
  }
}

pub fn requestpriority_decoder() -> Decoder(Requestpriority) {
  use variant <- decode.then(decode.string)
  case requestpriority_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        RequestpriorityRoutine,
        "Requestpriority",
        requestpriority,
        requestpriority_to_code,
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

pub fn two16840111376214102124_from_code(
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
  case two16840111376214102124_from_code(variant) {
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

pub type Unitsoftime {
  UnitsoftimeS
  UnitsoftimeMin
  UnitsoftimeH
  UnitsoftimeD
  UnitsoftimeWk
  UnitsoftimeMo
  UnitsoftimeA
}

pub const unitsoftime: List(Unitsoftime) = [
  UnitsoftimeS,
  UnitsoftimeMin,
  UnitsoftimeH,
  UnitsoftimeD,
  UnitsoftimeWk,
  UnitsoftimeMo,
  UnitsoftimeA,
]

pub fn unitsoftime_to_json(unitsoftime: Unitsoftime) -> Json {
  json.string(unitsoftime_to_code(unitsoftime))
}

pub fn unitsoftime_to_code(unitsoftime: Unitsoftime) -> String {
  case unitsoftime {
    UnitsoftimeS -> "s"
    UnitsoftimeMin -> "min"
    UnitsoftimeH -> "h"
    UnitsoftimeD -> "d"
    UnitsoftimeWk -> "wk"
    UnitsoftimeMo -> "mo"
    UnitsoftimeA -> "a"
  }
}

pub fn unitsoftime_from_code(code: String) -> Result(Unitsoftime, Nil) {
  case code {
    "s" -> Ok(UnitsoftimeS)
    "min" -> Ok(UnitsoftimeMin)
    "h" -> Ok(UnitsoftimeH)
    "d" -> Ok(UnitsoftimeD)
    "wk" -> Ok(UnitsoftimeWk)
    "mo" -> Ok(UnitsoftimeMo)
    "a" -> Ok(UnitsoftimeA)
    _ -> Error(Nil)
  }
}

pub fn unitsoftime_decoder() -> Decoder(Unitsoftime) {
  use variant <- decode.then(decode.string)
  case unitsoftime_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UnitsoftimeS,
        "Unitsoftime",
        unitsoftime,
        unitsoftime_to_code,
      )
  }
}

pub type Uscoredocumentreferencecategory {
  UscoredocumentreferencecategoryClinicalnote
}

pub const uscoredocumentreferencecategory: List(Uscoredocumentreferencecategory) = [
  UscoredocumentreferencecategoryClinicalnote,
]

pub fn uscoredocumentreferencecategory_to_json(
  uscoredocumentreferencecategory: Uscoredocumentreferencecategory,
) -> Json {
  json.string(uscoredocumentreferencecategory_to_code(
    uscoredocumentreferencecategory,
  ))
}

pub fn uscoredocumentreferencecategory_to_code(
  uscoredocumentreferencecategory: Uscoredocumentreferencecategory,
) -> String {
  case uscoredocumentreferencecategory {
    UscoredocumentreferencecategoryClinicalnote -> "clinical-note"
  }
}

pub fn uscoredocumentreferencecategory_from_code(
  code: String,
) -> Result(Uscoredocumentreferencecategory, Nil) {
  case code {
    "clinical-note" -> Ok(UscoredocumentreferencecategoryClinicalnote)
    _ -> Error(Nil)
  }
}

pub fn uscoredocumentreferencecategory_decoder() -> Decoder(
  Uscoredocumentreferencecategory,
) {
  use variant <- decode.then(decode.string)
  case uscoredocumentreferencecategory_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UscoredocumentreferencecategoryClinicalnote,
        "Uscoredocumentreferencecategory",
        uscoredocumentreferencecategory,
        uscoredocumentreferencecategory_to_code,
      )
  }
}

pub fn uscoredocumentreferencecategory_from_code_and_system(
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

pub type Uscoreproblemorhealthconcern {
  UscoreproblemorhealthconcernProblemlistitem
  UscoreproblemorhealthconcernHealthconcern
}

pub const uscoreproblemorhealthconcern: List(Uscoreproblemorhealthconcern) = [
  UscoreproblemorhealthconcernProblemlistitem,
  UscoreproblemorhealthconcernHealthconcern,
]

pub fn uscoreproblemorhealthconcern_to_json(
  uscoreproblemorhealthconcern: Uscoreproblemorhealthconcern,
) -> Json {
  json.string(uscoreproblemorhealthconcern_to_code(uscoreproblemorhealthconcern))
}

pub fn uscoreproblemorhealthconcern_to_code(
  uscoreproblemorhealthconcern: Uscoreproblemorhealthconcern,
) -> String {
  case uscoreproblemorhealthconcern {
    UscoreproblemorhealthconcernProblemlistitem -> "problem-list-item"
    UscoreproblemorhealthconcernHealthconcern -> "health-concern"
  }
}

pub fn uscoreproblemorhealthconcern_from_code(
  code: String,
) -> Result(Uscoreproblemorhealthconcern, Nil) {
  case code {
    "problem-list-item" -> Ok(UscoreproblemorhealthconcernProblemlistitem)
    "health-concern" -> Ok(UscoreproblemorhealthconcernHealthconcern)
    _ -> Error(Nil)
  }
}

pub fn uscoreproblemorhealthconcern_decoder() -> Decoder(
  Uscoreproblemorhealthconcern,
) {
  use variant <- decode.then(decode.string)
  case uscoreproblemorhealthconcern_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UscoreproblemorhealthconcernProblemlistitem,
        "Uscoreproblemorhealthconcern",
        uscoreproblemorhealthconcern,
        uscoreproblemorhealthconcern_to_code,
      )
  }
}

pub fn uscoreproblemorhealthconcern_from_code_and_system(
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

pub type Uscorescreeningassessmentconditioncategory {
  UscorescreeningassessmentconditioncategorySdoh
  UscorescreeningassessmentconditioncategoryFunctionalstatus
  UscorescreeningassessmentconditioncategoryDisabilitystatus
  UscorescreeningassessmentconditioncategoryCognitivestatus
  UscorescreeningassessmentconditioncategoryTreatmentinterventionpreference
  UscorescreeningassessmentconditioncategoryCareexperiencepreference
  UscorescreeningassessmentconditioncategoryObservationadidocumentation
  UscorescreeningassessmentconditioncategoryPmo
}

pub const uscorescreeningassessmentconditioncategory: List(
  Uscorescreeningassessmentconditioncategory,
) = [
  UscorescreeningassessmentconditioncategorySdoh,
  UscorescreeningassessmentconditioncategoryFunctionalstatus,
  UscorescreeningassessmentconditioncategoryDisabilitystatus,
  UscorescreeningassessmentconditioncategoryCognitivestatus,
  UscorescreeningassessmentconditioncategoryTreatmentinterventionpreference,
  UscorescreeningassessmentconditioncategoryCareexperiencepreference,
  UscorescreeningassessmentconditioncategoryObservationadidocumentation,
  UscorescreeningassessmentconditioncategoryPmo,
]

pub fn uscorescreeningassessmentconditioncategory_to_json(
  uscorescreeningassessmentconditioncategory: Uscorescreeningassessmentconditioncategory,
) -> Json {
  json.string(uscorescreeningassessmentconditioncategory_to_code(
    uscorescreeningassessmentconditioncategory,
  ))
}

pub fn uscorescreeningassessmentconditioncategory_to_code(
  uscorescreeningassessmentconditioncategory: Uscorescreeningassessmentconditioncategory,
) -> String {
  case uscorescreeningassessmentconditioncategory {
    UscorescreeningassessmentconditioncategorySdoh -> "sdoh"
    UscorescreeningassessmentconditioncategoryFunctionalstatus ->
      "functional-status"
    UscorescreeningassessmentconditioncategoryDisabilitystatus ->
      "disability-status"
    UscorescreeningassessmentconditioncategoryCognitivestatus ->
      "cognitive-status"
    UscorescreeningassessmentconditioncategoryTreatmentinterventionpreference ->
      "treatment-intervention-preference"
    UscorescreeningassessmentconditioncategoryCareexperiencepreference ->
      "care-experience-preference"
    UscorescreeningassessmentconditioncategoryObservationadidocumentation ->
      "observation-adi-documentation"
    UscorescreeningassessmentconditioncategoryPmo -> "PMO"
  }
}

pub fn uscorescreeningassessmentconditioncategory_from_code(
  code: String,
) -> Result(Uscorescreeningassessmentconditioncategory, Nil) {
  case code {
    "sdoh" -> Ok(UscorescreeningassessmentconditioncategorySdoh)
    "functional-status" ->
      Ok(UscorescreeningassessmentconditioncategoryFunctionalstatus)
    "disability-status" ->
      Ok(UscorescreeningassessmentconditioncategoryDisabilitystatus)
    "cognitive-status" ->
      Ok(UscorescreeningassessmentconditioncategoryCognitivestatus)
    "treatment-intervention-preference" ->
      Ok(
        UscorescreeningassessmentconditioncategoryTreatmentinterventionpreference,
      )
    "care-experience-preference" ->
      Ok(UscorescreeningassessmentconditioncategoryCareexperiencepreference)
    "observation-adi-documentation" ->
      Ok(UscorescreeningassessmentconditioncategoryObservationadidocumentation)
    "PMO" -> Ok(UscorescreeningassessmentconditioncategoryPmo)
    _ -> Error(Nil)
  }
}

pub fn uscorescreeningassessmentconditioncategory_decoder() -> Decoder(
  Uscorescreeningassessmentconditioncategory,
) {
  use variant <- decode.then(decode.string)
  case uscorescreeningassessmentconditioncategory_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        UscorescreeningassessmentconditioncategorySdoh,
        "Uscorescreeningassessmentconditioncategory",
        uscorescreeningassessmentconditioncategory,
        uscorescreeningassessmentconditioncategory_to_code,
      )
  }
}

pub fn uscorescreeningassessmentconditioncategory_from_code_and_system(
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
