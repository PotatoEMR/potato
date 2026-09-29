////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) valuesets

import gleam/dynamic/decode.{type Decoder}
import gleam/json.{type Json}

pub type Addresstype {
  AddresstypePostal
  AddresstypePhysical
  AddresstypeBoth
}

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
  case variant {
    "postal" -> decode.success(AddresstypePostal)
    "physical" -> decode.success(AddresstypePhysical)
    "both" -> decode.success(AddresstypeBoth)
    _ -> decode.failure(AddresstypePostal, "Addresstype")
  }
}

pub type Addressuse {
  AddressuseHome
  AddressuseWork
  AddressuseTemp
  AddressuseOld
  AddressuseBilling
}

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
  case variant {
    "home" -> decode.success(AddressuseHome)
    "work" -> decode.success(AddressuseWork)
    "temp" -> decode.success(AddressuseTemp)
    "old" -> decode.success(AddressuseOld)
    "billing" -> decode.success(AddressuseBilling)
    _ -> decode.failure(AddressuseHome, "Addressuse")
  }
}

pub type Administrativegender {
  AdministrativegenderMale
  AdministrativegenderFemale
  AdministrativegenderOther
  AdministrativegenderUnknown
}

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
  case variant {
    "male" -> decode.success(AdministrativegenderMale)
    "female" -> decode.success(AdministrativegenderFemale)
    "other" -> decode.success(AdministrativegenderOther)
    "unknown" -> decode.success(AdministrativegenderUnknown)
    _ -> decode.failure(AdministrativegenderMale, "Administrativegender")
  }
}

pub type Allergyintolerancecategory {
  AllergyintolerancecategoryFood
  AllergyintolerancecategoryMedication
  AllergyintolerancecategoryEnvironment
  AllergyintolerancecategoryBiologic
}

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
  case variant {
    "food" -> decode.success(AllergyintolerancecategoryFood)
    "medication" -> decode.success(AllergyintolerancecategoryMedication)
    "environment" -> decode.success(AllergyintolerancecategoryEnvironment)
    "biologic" -> decode.success(AllergyintolerancecategoryBiologic)
    _ ->
      decode.failure(
        AllergyintolerancecategoryFood,
        "Allergyintolerancecategory",
      )
  }
}

pub type Allergyintoleranceclinical {
  AllergyintoleranceclinicalActive
  AllergyintoleranceclinicalInactive
  AllergyintoleranceclinicalResolved
}

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

pub fn allergyintoleranceclinical_from_code_and_system(
  code code: String,
  system system: String,
) -> Result(Allergyintoleranceclinical, Nil) {
  case code, system {
    "active",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
    -> Ok(AllergyintoleranceclinicalActive)
    "inactive",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
    -> Ok(AllergyintoleranceclinicalInactive)
    "resolved",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
    -> Ok(AllergyintoleranceclinicalResolved)
    _, _ -> Error(Nil)
  }
}

pub fn allergyintoleranceclinical_decoder() -> Decoder(
  Allergyintoleranceclinical,
) {
  use variant <- decode.then(decode.string)
  case variant {
    "active" -> decode.success(AllergyintoleranceclinicalActive)
    "inactive" -> decode.success(AllergyintoleranceclinicalInactive)
    "resolved" -> decode.success(AllergyintoleranceclinicalResolved)
    _ ->
      decode.failure(
        AllergyintoleranceclinicalActive,
        "Allergyintoleranceclinical",
      )
  }
}

pub fn allergyintoleranceclinical_system(
  _allergyintoleranceclinical: Allergyintoleranceclinical,
) -> String {
  "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"
}

pub type Allergyintolerancecriticality {
  AllergyintolerancecriticalityLow
  AllergyintolerancecriticalityHigh
  AllergyintolerancecriticalityUnabletoassess
}

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
  case variant {
    "low" -> decode.success(AllergyintolerancecriticalityLow)
    "high" -> decode.success(AllergyintolerancecriticalityHigh)
    "unable-to-assess" ->
      decode.success(AllergyintolerancecriticalityUnabletoassess)
    _ ->
      decode.failure(
        AllergyintolerancecriticalityLow,
        "Allergyintolerancecriticality",
      )
  }
}

pub type Allergyintolerancetype {
  AllergyintolerancetypeAllergy
  AllergyintolerancetypeIntolerance
}

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
  case variant {
    "allergy" -> decode.success(AllergyintolerancetypeAllergy)
    "intolerance" -> decode.success(AllergyintolerancetypeIntolerance)
    _ -> decode.failure(AllergyintolerancetypeAllergy, "Allergyintolerancetype")
  }
}

pub type Allergyintoleranceverification {
  AllergyintoleranceverificationUnconfirmed
  AllergyintoleranceverificationPresumed
  AllergyintoleranceverificationConfirmed
  AllergyintoleranceverificationRefuted
  AllergyintoleranceverificationEnteredinerror
}

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

pub fn allergyintoleranceverification_from_code_and_system(
  code code: String,
  system system: String,
) -> Result(Allergyintoleranceverification, Nil) {
  case code, system {
    "unconfirmed",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(AllergyintoleranceverificationUnconfirmed)
    "presumed",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(AllergyintoleranceverificationPresumed)
    "confirmed",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(AllergyintoleranceverificationConfirmed)
    "refuted",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(AllergyintoleranceverificationRefuted)
    "entered-in-error",
      "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
    -> Ok(AllergyintoleranceverificationEnteredinerror)
    _, _ -> Error(Nil)
  }
}

pub fn allergyintoleranceverification_decoder() -> Decoder(
  Allergyintoleranceverification,
) {
  use variant <- decode.then(decode.string)
  case variant {
    "unconfirmed" -> decode.success(AllergyintoleranceverificationUnconfirmed)
    "presumed" -> decode.success(AllergyintoleranceverificationPresumed)
    "confirmed" -> decode.success(AllergyintoleranceverificationConfirmed)
    "refuted" -> decode.success(AllergyintoleranceverificationRefuted)
    "entered-in-error" ->
      decode.success(AllergyintoleranceverificationEnteredinerror)
    _ ->
      decode.failure(
        AllergyintoleranceverificationUnconfirmed,
        "Allergyintoleranceverification",
      )
  }
}

pub fn allergyintoleranceverification_system(
  _allergyintoleranceverification: Allergyintoleranceverification,
) -> String {
  "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"
}

pub type Alltypes {
  AlltypesAddress
  AlltypesAge
  AlltypesAnnotation
  AlltypesAttachment
  AlltypesBackboneelement
  AlltypesCodeableconcept
  AlltypesCoding
  AlltypesContactdetail
  AlltypesContactpoint
  AlltypesContributor
  AlltypesCount
  AlltypesDatarequirement
  AlltypesDistance
  AlltypesDosage
  AlltypesDuration
  AlltypesElement
  AlltypesElementdefinition
  AlltypesExpression
  AlltypesExtension
  AlltypesHumanname
  AlltypesIdentifier
  AlltypesMarketingstatus
  AlltypesMeta
  AlltypesMoney
  AlltypesMoneyquantity
  AlltypesNarrative
  AlltypesParameterdefinition
  AlltypesPeriod
  AlltypesPopulation
  AlltypesProdcharacteristic
  AlltypesProductshelflife
  AlltypesQuantity
  AlltypesRange
  AlltypesRatio
  AlltypesReference
  AlltypesRelatedartifact
  AlltypesSampleddata
  AlltypesSignature
  AlltypesSimplequantity
  AlltypesSubstanceamount
  AlltypesTiming
  AlltypesTriggerdefinition
  AlltypesUsagecontext
  AlltypesBase64binary
  AlltypesBoolean
  AlltypesCanonical
  AlltypesCode
  AlltypesDate
  AlltypesDatetime
  AlltypesDecimal
  AlltypesId
  AlltypesInstant
  AlltypesInteger
  AlltypesMarkdown
  AlltypesOid
  AlltypesPositiveint
  AlltypesString
  AlltypesTime
  AlltypesUnsignedint
  AlltypesUri
  AlltypesUrl
  AlltypesUuid
  AlltypesXhtml
  AlltypesAccount
  AlltypesActivitydefinition
  AlltypesAdverseevent
  AlltypesAllergyintolerance
  AlltypesAppointment
  AlltypesAppointmentresponse
  AlltypesAuditevent
  AlltypesBasic
  AlltypesBinary
  AlltypesBiologicallyderivedproduct
  AlltypesBodystructure
  AlltypesBundle
  AlltypesCapabilitystatement
  AlltypesCareplan
  AlltypesCareteam
  AlltypesCatalogentry
  AlltypesChargeitem
  AlltypesChargeitemdefinition
  AlltypesClaim
  AlltypesClaimresponse
  AlltypesClinicalimpression
  AlltypesCodesystem
  AlltypesCommunication
  AlltypesCommunicationrequest
  AlltypesCompartmentdefinition
  AlltypesComposition
  AlltypesConceptmap
  AlltypesCondition
  AlltypesConsent
  AlltypesContract
  AlltypesCoverage
  AlltypesCoverageeligibilityrequest
  AlltypesCoverageeligibilityresponse
  AlltypesDetectedissue
  AlltypesDevice
  AlltypesDevicedefinition
  AlltypesDevicemetric
  AlltypesDevicerequest
  AlltypesDeviceusestatement
  AlltypesDiagnosticreport
  AlltypesDocumentmanifest
  AlltypesDocumentreference
  AlltypesDomainresource
  AlltypesEffectevidencesynthesis
  AlltypesEncounter
  AlltypesEndpoint
  AlltypesEnrollmentrequest
  AlltypesEnrollmentresponse
  AlltypesEpisodeofcare
  AlltypesEventdefinition
  AlltypesEvidence
  AlltypesEvidencevariable
  AlltypesExamplescenario
  AlltypesExplanationofbenefit
  AlltypesFamilymemberhistory
  AlltypesFlag
  AlltypesGoal
  AlltypesGraphdefinition
  AlltypesGroup
  AlltypesGuidanceresponse
  AlltypesHealthcareservice
  AlltypesImagingstudy
  AlltypesImmunization
  AlltypesImmunizationevaluation
  AlltypesImmunizationrecommendation
  AlltypesImplementationguide
  AlltypesInsuranceplan
  AlltypesInvoice
  AlltypesLibrary
  AlltypesLinkage
  AlltypesList
  AlltypesLocation
  AlltypesMeasure
  AlltypesMeasurereport
  AlltypesMedia
  AlltypesMedication
  AlltypesMedicationadministration
  AlltypesMedicationdispense
  AlltypesMedicationknowledge
  AlltypesMedicationrequest
  AlltypesMedicationstatement
  AlltypesMedicinalproduct
  AlltypesMedicinalproductauthorization
  AlltypesMedicinalproductcontraindication
  AlltypesMedicinalproductindication
  AlltypesMedicinalproductingredient
  AlltypesMedicinalproductinteraction
  AlltypesMedicinalproductmanufactured
  AlltypesMedicinalproductpackaged
  AlltypesMedicinalproductpharmaceutical
  AlltypesMedicinalproductundesirableeffect
  AlltypesMessagedefinition
  AlltypesMessageheader
  AlltypesMolecularsequence
  AlltypesNamingsystem
  AlltypesNutritionorder
  AlltypesObservation
  AlltypesObservationdefinition
  AlltypesOperationdefinition
  AlltypesOperationoutcome
  AlltypesOrganization
  AlltypesOrganizationaffiliation
  AlltypesParameters
  AlltypesPatient
  AlltypesPaymentnotice
  AlltypesPaymentreconciliation
  AlltypesPerson
  AlltypesPlandefinition
  AlltypesPractitioner
  AlltypesPractitionerrole
  AlltypesProcedure
  AlltypesProvenance
  AlltypesQuestionnaire
  AlltypesQuestionnaireresponse
  AlltypesRelatedperson
  AlltypesRequestgroup
  AlltypesResearchdefinition
  AlltypesResearchelementdefinition
  AlltypesResearchstudy
  AlltypesResearchsubject
  AlltypesResource
  AlltypesRiskassessment
  AlltypesRiskevidencesynthesis
  AlltypesSchedule
  AlltypesSearchparameter
  AlltypesServicerequest
  AlltypesSlot
  AlltypesSpecimen
  AlltypesSpecimendefinition
  AlltypesStructuredefinition
  AlltypesStructuremap
  AlltypesSubscription
  AlltypesSubstance
  AlltypesSubstancenucleicacid
  AlltypesSubstancepolymer
  AlltypesSubstanceprotein
  AlltypesSubstancereferenceinformation
  AlltypesSubstancesourcematerial
  AlltypesSubstancespecification
  AlltypesSupplydelivery
  AlltypesSupplyrequest
  AlltypesTask
  AlltypesTerminologycapabilities
  AlltypesTestreport
  AlltypesTestscript
  AlltypesValueset
  AlltypesVerificationresult
  AlltypesVisionprescription
  AlltypesType
  AlltypesAny
}

pub fn alltypes_to_json(alltypes: Alltypes) -> Json {
  json.string(alltypes_to_code(alltypes))
}

pub fn alltypes_to_code(alltypes: Alltypes) -> String {
  case alltypes {
    AlltypesAddress -> "Address"
    AlltypesAge -> "Age"
    AlltypesAnnotation -> "Annotation"
    AlltypesAttachment -> "Attachment"
    AlltypesBackboneelement -> "BackboneElement"
    AlltypesCodeableconcept -> "CodeableConcept"
    AlltypesCoding -> "Coding"
    AlltypesContactdetail -> "ContactDetail"
    AlltypesContactpoint -> "ContactPoint"
    AlltypesContributor -> "Contributor"
    AlltypesCount -> "Count"
    AlltypesDatarequirement -> "DataRequirement"
    AlltypesDistance -> "Distance"
    AlltypesDosage -> "Dosage"
    AlltypesDuration -> "Duration"
    AlltypesElement -> "Element"
    AlltypesElementdefinition -> "ElementDefinition"
    AlltypesExpression -> "Expression"
    AlltypesExtension -> "Extension"
    AlltypesHumanname -> "HumanName"
    AlltypesIdentifier -> "Identifier"
    AlltypesMarketingstatus -> "MarketingStatus"
    AlltypesMeta -> "Meta"
    AlltypesMoney -> "Money"
    AlltypesMoneyquantity -> "MoneyQuantity"
    AlltypesNarrative -> "Narrative"
    AlltypesParameterdefinition -> "ParameterDefinition"
    AlltypesPeriod -> "Period"
    AlltypesPopulation -> "Population"
    AlltypesProdcharacteristic -> "ProdCharacteristic"
    AlltypesProductshelflife -> "ProductShelfLife"
    AlltypesQuantity -> "Quantity"
    AlltypesRange -> "Range"
    AlltypesRatio -> "Ratio"
    AlltypesReference -> "Reference"
    AlltypesRelatedartifact -> "RelatedArtifact"
    AlltypesSampleddata -> "SampledData"
    AlltypesSignature -> "Signature"
    AlltypesSimplequantity -> "SimpleQuantity"
    AlltypesSubstanceamount -> "SubstanceAmount"
    AlltypesTiming -> "Timing"
    AlltypesTriggerdefinition -> "TriggerDefinition"
    AlltypesUsagecontext -> "UsageContext"
    AlltypesBase64binary -> "base64Binary"
    AlltypesBoolean -> "boolean"
    AlltypesCanonical -> "canonical"
    AlltypesCode -> "code"
    AlltypesDate -> "date"
    AlltypesDatetime -> "dateTime"
    AlltypesDecimal -> "decimal"
    AlltypesId -> "id"
    AlltypesInstant -> "instant"
    AlltypesInteger -> "integer"
    AlltypesMarkdown -> "markdown"
    AlltypesOid -> "oid"
    AlltypesPositiveint -> "positiveInt"
    AlltypesString -> "string"
    AlltypesTime -> "time"
    AlltypesUnsignedint -> "unsignedInt"
    AlltypesUri -> "uri"
    AlltypesUrl -> "url"
    AlltypesUuid -> "uuid"
    AlltypesXhtml -> "xhtml"
    AlltypesAccount -> "Account"
    AlltypesActivitydefinition -> "ActivityDefinition"
    AlltypesAdverseevent -> "AdverseEvent"
    AlltypesAllergyintolerance -> "AllergyIntolerance"
    AlltypesAppointment -> "Appointment"
    AlltypesAppointmentresponse -> "AppointmentResponse"
    AlltypesAuditevent -> "AuditEvent"
    AlltypesBasic -> "Basic"
    AlltypesBinary -> "Binary"
    AlltypesBiologicallyderivedproduct -> "BiologicallyDerivedProduct"
    AlltypesBodystructure -> "BodyStructure"
    AlltypesBundle -> "Bundle"
    AlltypesCapabilitystatement -> "CapabilityStatement"
    AlltypesCareplan -> "CarePlan"
    AlltypesCareteam -> "CareTeam"
    AlltypesCatalogentry -> "CatalogEntry"
    AlltypesChargeitem -> "ChargeItem"
    AlltypesChargeitemdefinition -> "ChargeItemDefinition"
    AlltypesClaim -> "Claim"
    AlltypesClaimresponse -> "ClaimResponse"
    AlltypesClinicalimpression -> "ClinicalImpression"
    AlltypesCodesystem -> "CodeSystem"
    AlltypesCommunication -> "Communication"
    AlltypesCommunicationrequest -> "CommunicationRequest"
    AlltypesCompartmentdefinition -> "CompartmentDefinition"
    AlltypesComposition -> "Composition"
    AlltypesConceptmap -> "ConceptMap"
    AlltypesCondition -> "Condition"
    AlltypesConsent -> "Consent"
    AlltypesContract -> "Contract"
    AlltypesCoverage -> "Coverage"
    AlltypesCoverageeligibilityrequest -> "CoverageEligibilityRequest"
    AlltypesCoverageeligibilityresponse -> "CoverageEligibilityResponse"
    AlltypesDetectedissue -> "DetectedIssue"
    AlltypesDevice -> "Device"
    AlltypesDevicedefinition -> "DeviceDefinition"
    AlltypesDevicemetric -> "DeviceMetric"
    AlltypesDevicerequest -> "DeviceRequest"
    AlltypesDeviceusestatement -> "DeviceUseStatement"
    AlltypesDiagnosticreport -> "DiagnosticReport"
    AlltypesDocumentmanifest -> "DocumentManifest"
    AlltypesDocumentreference -> "DocumentReference"
    AlltypesDomainresource -> "DomainResource"
    AlltypesEffectevidencesynthesis -> "EffectEvidenceSynthesis"
    AlltypesEncounter -> "Encounter"
    AlltypesEndpoint -> "Endpoint"
    AlltypesEnrollmentrequest -> "EnrollmentRequest"
    AlltypesEnrollmentresponse -> "EnrollmentResponse"
    AlltypesEpisodeofcare -> "EpisodeOfCare"
    AlltypesEventdefinition -> "EventDefinition"
    AlltypesEvidence -> "Evidence"
    AlltypesEvidencevariable -> "EvidenceVariable"
    AlltypesExamplescenario -> "ExampleScenario"
    AlltypesExplanationofbenefit -> "ExplanationOfBenefit"
    AlltypesFamilymemberhistory -> "FamilyMemberHistory"
    AlltypesFlag -> "Flag"
    AlltypesGoal -> "Goal"
    AlltypesGraphdefinition -> "GraphDefinition"
    AlltypesGroup -> "Group"
    AlltypesGuidanceresponse -> "GuidanceResponse"
    AlltypesHealthcareservice -> "HealthcareService"
    AlltypesImagingstudy -> "ImagingStudy"
    AlltypesImmunization -> "Immunization"
    AlltypesImmunizationevaluation -> "ImmunizationEvaluation"
    AlltypesImmunizationrecommendation -> "ImmunizationRecommendation"
    AlltypesImplementationguide -> "ImplementationGuide"
    AlltypesInsuranceplan -> "InsurancePlan"
    AlltypesInvoice -> "Invoice"
    AlltypesLibrary -> "Library"
    AlltypesLinkage -> "Linkage"
    AlltypesList -> "List"
    AlltypesLocation -> "Location"
    AlltypesMeasure -> "Measure"
    AlltypesMeasurereport -> "MeasureReport"
    AlltypesMedia -> "Media"
    AlltypesMedication -> "Medication"
    AlltypesMedicationadministration -> "MedicationAdministration"
    AlltypesMedicationdispense -> "MedicationDispense"
    AlltypesMedicationknowledge -> "MedicationKnowledge"
    AlltypesMedicationrequest -> "MedicationRequest"
    AlltypesMedicationstatement -> "MedicationStatement"
    AlltypesMedicinalproduct -> "MedicinalProduct"
    AlltypesMedicinalproductauthorization -> "MedicinalProductAuthorization"
    AlltypesMedicinalproductcontraindication ->
      "MedicinalProductContraindication"
    AlltypesMedicinalproductindication -> "MedicinalProductIndication"
    AlltypesMedicinalproductingredient -> "MedicinalProductIngredient"
    AlltypesMedicinalproductinteraction -> "MedicinalProductInteraction"
    AlltypesMedicinalproductmanufactured -> "MedicinalProductManufactured"
    AlltypesMedicinalproductpackaged -> "MedicinalProductPackaged"
    AlltypesMedicinalproductpharmaceutical -> "MedicinalProductPharmaceutical"
    AlltypesMedicinalproductundesirableeffect ->
      "MedicinalProductUndesirableEffect"
    AlltypesMessagedefinition -> "MessageDefinition"
    AlltypesMessageheader -> "MessageHeader"
    AlltypesMolecularsequence -> "MolecularSequence"
    AlltypesNamingsystem -> "NamingSystem"
    AlltypesNutritionorder -> "NutritionOrder"
    AlltypesObservation -> "Observation"
    AlltypesObservationdefinition -> "ObservationDefinition"
    AlltypesOperationdefinition -> "OperationDefinition"
    AlltypesOperationoutcome -> "OperationOutcome"
    AlltypesOrganization -> "Organization"
    AlltypesOrganizationaffiliation -> "OrganizationAffiliation"
    AlltypesParameters -> "Parameters"
    AlltypesPatient -> "Patient"
    AlltypesPaymentnotice -> "PaymentNotice"
    AlltypesPaymentreconciliation -> "PaymentReconciliation"
    AlltypesPerson -> "Person"
    AlltypesPlandefinition -> "PlanDefinition"
    AlltypesPractitioner -> "Practitioner"
    AlltypesPractitionerrole -> "PractitionerRole"
    AlltypesProcedure -> "Procedure"
    AlltypesProvenance -> "Provenance"
    AlltypesQuestionnaire -> "Questionnaire"
    AlltypesQuestionnaireresponse -> "QuestionnaireResponse"
    AlltypesRelatedperson -> "RelatedPerson"
    AlltypesRequestgroup -> "RequestGroup"
    AlltypesResearchdefinition -> "ResearchDefinition"
    AlltypesResearchelementdefinition -> "ResearchElementDefinition"
    AlltypesResearchstudy -> "ResearchStudy"
    AlltypesResearchsubject -> "ResearchSubject"
    AlltypesResource -> "Resource"
    AlltypesRiskassessment -> "RiskAssessment"
    AlltypesRiskevidencesynthesis -> "RiskEvidenceSynthesis"
    AlltypesSchedule -> "Schedule"
    AlltypesSearchparameter -> "SearchParameter"
    AlltypesServicerequest -> "ServiceRequest"
    AlltypesSlot -> "Slot"
    AlltypesSpecimen -> "Specimen"
    AlltypesSpecimendefinition -> "SpecimenDefinition"
    AlltypesStructuredefinition -> "StructureDefinition"
    AlltypesStructuremap -> "StructureMap"
    AlltypesSubscription -> "Subscription"
    AlltypesSubstance -> "Substance"
    AlltypesSubstancenucleicacid -> "SubstanceNucleicAcid"
    AlltypesSubstancepolymer -> "SubstancePolymer"
    AlltypesSubstanceprotein -> "SubstanceProtein"
    AlltypesSubstancereferenceinformation -> "SubstanceReferenceInformation"
    AlltypesSubstancesourcematerial -> "SubstanceSourceMaterial"
    AlltypesSubstancespecification -> "SubstanceSpecification"
    AlltypesSupplydelivery -> "SupplyDelivery"
    AlltypesSupplyrequest -> "SupplyRequest"
    AlltypesTask -> "Task"
    AlltypesTerminologycapabilities -> "TerminologyCapabilities"
    AlltypesTestreport -> "TestReport"
    AlltypesTestscript -> "TestScript"
    AlltypesValueset -> "ValueSet"
    AlltypesVerificationresult -> "VerificationResult"
    AlltypesVisionprescription -> "VisionPrescription"
    AlltypesType -> "Type"
    AlltypesAny -> "Any"
  }
}

pub fn alltypes_from_code(code: String) -> Result(Alltypes, Nil) {
  case code {
    "Address" -> Ok(AlltypesAddress)
    "Age" -> Ok(AlltypesAge)
    "Annotation" -> Ok(AlltypesAnnotation)
    "Attachment" -> Ok(AlltypesAttachment)
    "BackboneElement" -> Ok(AlltypesBackboneelement)
    "CodeableConcept" -> Ok(AlltypesCodeableconcept)
    "Coding" -> Ok(AlltypesCoding)
    "ContactDetail" -> Ok(AlltypesContactdetail)
    "ContactPoint" -> Ok(AlltypesContactpoint)
    "Contributor" -> Ok(AlltypesContributor)
    "Count" -> Ok(AlltypesCount)
    "DataRequirement" -> Ok(AlltypesDatarequirement)
    "Distance" -> Ok(AlltypesDistance)
    "Dosage" -> Ok(AlltypesDosage)
    "Duration" -> Ok(AlltypesDuration)
    "Element" -> Ok(AlltypesElement)
    "ElementDefinition" -> Ok(AlltypesElementdefinition)
    "Expression" -> Ok(AlltypesExpression)
    "Extension" -> Ok(AlltypesExtension)
    "HumanName" -> Ok(AlltypesHumanname)
    "Identifier" -> Ok(AlltypesIdentifier)
    "MarketingStatus" -> Ok(AlltypesMarketingstatus)
    "Meta" -> Ok(AlltypesMeta)
    "Money" -> Ok(AlltypesMoney)
    "MoneyQuantity" -> Ok(AlltypesMoneyquantity)
    "Narrative" -> Ok(AlltypesNarrative)
    "ParameterDefinition" -> Ok(AlltypesParameterdefinition)
    "Period" -> Ok(AlltypesPeriod)
    "Population" -> Ok(AlltypesPopulation)
    "ProdCharacteristic" -> Ok(AlltypesProdcharacteristic)
    "ProductShelfLife" -> Ok(AlltypesProductshelflife)
    "Quantity" -> Ok(AlltypesQuantity)
    "Range" -> Ok(AlltypesRange)
    "Ratio" -> Ok(AlltypesRatio)
    "Reference" -> Ok(AlltypesReference)
    "RelatedArtifact" -> Ok(AlltypesRelatedartifact)
    "SampledData" -> Ok(AlltypesSampleddata)
    "Signature" -> Ok(AlltypesSignature)
    "SimpleQuantity" -> Ok(AlltypesSimplequantity)
    "SubstanceAmount" -> Ok(AlltypesSubstanceamount)
    "Timing" -> Ok(AlltypesTiming)
    "TriggerDefinition" -> Ok(AlltypesTriggerdefinition)
    "UsageContext" -> Ok(AlltypesUsagecontext)
    "base64Binary" -> Ok(AlltypesBase64binary)
    "boolean" -> Ok(AlltypesBoolean)
    "canonical" -> Ok(AlltypesCanonical)
    "code" -> Ok(AlltypesCode)
    "date" -> Ok(AlltypesDate)
    "dateTime" -> Ok(AlltypesDatetime)
    "decimal" -> Ok(AlltypesDecimal)
    "id" -> Ok(AlltypesId)
    "instant" -> Ok(AlltypesInstant)
    "integer" -> Ok(AlltypesInteger)
    "markdown" -> Ok(AlltypesMarkdown)
    "oid" -> Ok(AlltypesOid)
    "positiveInt" -> Ok(AlltypesPositiveint)
    "string" -> Ok(AlltypesString)
    "time" -> Ok(AlltypesTime)
    "unsignedInt" -> Ok(AlltypesUnsignedint)
    "uri" -> Ok(AlltypesUri)
    "url" -> Ok(AlltypesUrl)
    "uuid" -> Ok(AlltypesUuid)
    "xhtml" -> Ok(AlltypesXhtml)
    "Account" -> Ok(AlltypesAccount)
    "ActivityDefinition" -> Ok(AlltypesActivitydefinition)
    "AdverseEvent" -> Ok(AlltypesAdverseevent)
    "AllergyIntolerance" -> Ok(AlltypesAllergyintolerance)
    "Appointment" -> Ok(AlltypesAppointment)
    "AppointmentResponse" -> Ok(AlltypesAppointmentresponse)
    "AuditEvent" -> Ok(AlltypesAuditevent)
    "Basic" -> Ok(AlltypesBasic)
    "Binary" -> Ok(AlltypesBinary)
    "BiologicallyDerivedProduct" -> Ok(AlltypesBiologicallyderivedproduct)
    "BodyStructure" -> Ok(AlltypesBodystructure)
    "Bundle" -> Ok(AlltypesBundle)
    "CapabilityStatement" -> Ok(AlltypesCapabilitystatement)
    "CarePlan" -> Ok(AlltypesCareplan)
    "CareTeam" -> Ok(AlltypesCareteam)
    "CatalogEntry" -> Ok(AlltypesCatalogentry)
    "ChargeItem" -> Ok(AlltypesChargeitem)
    "ChargeItemDefinition" -> Ok(AlltypesChargeitemdefinition)
    "Claim" -> Ok(AlltypesClaim)
    "ClaimResponse" -> Ok(AlltypesClaimresponse)
    "ClinicalImpression" -> Ok(AlltypesClinicalimpression)
    "CodeSystem" -> Ok(AlltypesCodesystem)
    "Communication" -> Ok(AlltypesCommunication)
    "CommunicationRequest" -> Ok(AlltypesCommunicationrequest)
    "CompartmentDefinition" -> Ok(AlltypesCompartmentdefinition)
    "Composition" -> Ok(AlltypesComposition)
    "ConceptMap" -> Ok(AlltypesConceptmap)
    "Condition" -> Ok(AlltypesCondition)
    "Consent" -> Ok(AlltypesConsent)
    "Contract" -> Ok(AlltypesContract)
    "Coverage" -> Ok(AlltypesCoverage)
    "CoverageEligibilityRequest" -> Ok(AlltypesCoverageeligibilityrequest)
    "CoverageEligibilityResponse" -> Ok(AlltypesCoverageeligibilityresponse)
    "DetectedIssue" -> Ok(AlltypesDetectedissue)
    "Device" -> Ok(AlltypesDevice)
    "DeviceDefinition" -> Ok(AlltypesDevicedefinition)
    "DeviceMetric" -> Ok(AlltypesDevicemetric)
    "DeviceRequest" -> Ok(AlltypesDevicerequest)
    "DeviceUseStatement" -> Ok(AlltypesDeviceusestatement)
    "DiagnosticReport" -> Ok(AlltypesDiagnosticreport)
    "DocumentManifest" -> Ok(AlltypesDocumentmanifest)
    "DocumentReference" -> Ok(AlltypesDocumentreference)
    "DomainResource" -> Ok(AlltypesDomainresource)
    "EffectEvidenceSynthesis" -> Ok(AlltypesEffectevidencesynthesis)
    "Encounter" -> Ok(AlltypesEncounter)
    "Endpoint" -> Ok(AlltypesEndpoint)
    "EnrollmentRequest" -> Ok(AlltypesEnrollmentrequest)
    "EnrollmentResponse" -> Ok(AlltypesEnrollmentresponse)
    "EpisodeOfCare" -> Ok(AlltypesEpisodeofcare)
    "EventDefinition" -> Ok(AlltypesEventdefinition)
    "Evidence" -> Ok(AlltypesEvidence)
    "EvidenceVariable" -> Ok(AlltypesEvidencevariable)
    "ExampleScenario" -> Ok(AlltypesExamplescenario)
    "ExplanationOfBenefit" -> Ok(AlltypesExplanationofbenefit)
    "FamilyMemberHistory" -> Ok(AlltypesFamilymemberhistory)
    "Flag" -> Ok(AlltypesFlag)
    "Goal" -> Ok(AlltypesGoal)
    "GraphDefinition" -> Ok(AlltypesGraphdefinition)
    "Group" -> Ok(AlltypesGroup)
    "GuidanceResponse" -> Ok(AlltypesGuidanceresponse)
    "HealthcareService" -> Ok(AlltypesHealthcareservice)
    "ImagingStudy" -> Ok(AlltypesImagingstudy)
    "Immunization" -> Ok(AlltypesImmunization)
    "ImmunizationEvaluation" -> Ok(AlltypesImmunizationevaluation)
    "ImmunizationRecommendation" -> Ok(AlltypesImmunizationrecommendation)
    "ImplementationGuide" -> Ok(AlltypesImplementationguide)
    "InsurancePlan" -> Ok(AlltypesInsuranceplan)
    "Invoice" -> Ok(AlltypesInvoice)
    "Library" -> Ok(AlltypesLibrary)
    "Linkage" -> Ok(AlltypesLinkage)
    "List" -> Ok(AlltypesList)
    "Location" -> Ok(AlltypesLocation)
    "Measure" -> Ok(AlltypesMeasure)
    "MeasureReport" -> Ok(AlltypesMeasurereport)
    "Media" -> Ok(AlltypesMedia)
    "Medication" -> Ok(AlltypesMedication)
    "MedicationAdministration" -> Ok(AlltypesMedicationadministration)
    "MedicationDispense" -> Ok(AlltypesMedicationdispense)
    "MedicationKnowledge" -> Ok(AlltypesMedicationknowledge)
    "MedicationRequest" -> Ok(AlltypesMedicationrequest)
    "MedicationStatement" -> Ok(AlltypesMedicationstatement)
    "MedicinalProduct" -> Ok(AlltypesMedicinalproduct)
    "MedicinalProductAuthorization" -> Ok(AlltypesMedicinalproductauthorization)
    "MedicinalProductContraindication" ->
      Ok(AlltypesMedicinalproductcontraindication)
    "MedicinalProductIndication" -> Ok(AlltypesMedicinalproductindication)
    "MedicinalProductIngredient" -> Ok(AlltypesMedicinalproductingredient)
    "MedicinalProductInteraction" -> Ok(AlltypesMedicinalproductinteraction)
    "MedicinalProductManufactured" -> Ok(AlltypesMedicinalproductmanufactured)
    "MedicinalProductPackaged" -> Ok(AlltypesMedicinalproductpackaged)
    "MedicinalProductPharmaceutical" ->
      Ok(AlltypesMedicinalproductpharmaceutical)
    "MedicinalProductUndesirableEffect" ->
      Ok(AlltypesMedicinalproductundesirableeffect)
    "MessageDefinition" -> Ok(AlltypesMessagedefinition)
    "MessageHeader" -> Ok(AlltypesMessageheader)
    "MolecularSequence" -> Ok(AlltypesMolecularsequence)
    "NamingSystem" -> Ok(AlltypesNamingsystem)
    "NutritionOrder" -> Ok(AlltypesNutritionorder)
    "Observation" -> Ok(AlltypesObservation)
    "ObservationDefinition" -> Ok(AlltypesObservationdefinition)
    "OperationDefinition" -> Ok(AlltypesOperationdefinition)
    "OperationOutcome" -> Ok(AlltypesOperationoutcome)
    "Organization" -> Ok(AlltypesOrganization)
    "OrganizationAffiliation" -> Ok(AlltypesOrganizationaffiliation)
    "Parameters" -> Ok(AlltypesParameters)
    "Patient" -> Ok(AlltypesPatient)
    "PaymentNotice" -> Ok(AlltypesPaymentnotice)
    "PaymentReconciliation" -> Ok(AlltypesPaymentreconciliation)
    "Person" -> Ok(AlltypesPerson)
    "PlanDefinition" -> Ok(AlltypesPlandefinition)
    "Practitioner" -> Ok(AlltypesPractitioner)
    "PractitionerRole" -> Ok(AlltypesPractitionerrole)
    "Procedure" -> Ok(AlltypesProcedure)
    "Provenance" -> Ok(AlltypesProvenance)
    "Questionnaire" -> Ok(AlltypesQuestionnaire)
    "QuestionnaireResponse" -> Ok(AlltypesQuestionnaireresponse)
    "RelatedPerson" -> Ok(AlltypesRelatedperson)
    "RequestGroup" -> Ok(AlltypesRequestgroup)
    "ResearchDefinition" -> Ok(AlltypesResearchdefinition)
    "ResearchElementDefinition" -> Ok(AlltypesResearchelementdefinition)
    "ResearchStudy" -> Ok(AlltypesResearchstudy)
    "ResearchSubject" -> Ok(AlltypesResearchsubject)
    "Resource" -> Ok(AlltypesResource)
    "RiskAssessment" -> Ok(AlltypesRiskassessment)
    "RiskEvidenceSynthesis" -> Ok(AlltypesRiskevidencesynthesis)
    "Schedule" -> Ok(AlltypesSchedule)
    "SearchParameter" -> Ok(AlltypesSearchparameter)
    "ServiceRequest" -> Ok(AlltypesServicerequest)
    "Slot" -> Ok(AlltypesSlot)
    "Specimen" -> Ok(AlltypesSpecimen)
    "SpecimenDefinition" -> Ok(AlltypesSpecimendefinition)
    "StructureDefinition" -> Ok(AlltypesStructuredefinition)
    "StructureMap" -> Ok(AlltypesStructuremap)
    "Subscription" -> Ok(AlltypesSubscription)
    "Substance" -> Ok(AlltypesSubstance)
    "SubstanceNucleicAcid" -> Ok(AlltypesSubstancenucleicacid)
    "SubstancePolymer" -> Ok(AlltypesSubstancepolymer)
    "SubstanceProtein" -> Ok(AlltypesSubstanceprotein)
    "SubstanceReferenceInformation" -> Ok(AlltypesSubstancereferenceinformation)
    "SubstanceSourceMaterial" -> Ok(AlltypesSubstancesourcematerial)
    "SubstanceSpecification" -> Ok(AlltypesSubstancespecification)
    "SupplyDelivery" -> Ok(AlltypesSupplydelivery)
    "SupplyRequest" -> Ok(AlltypesSupplyrequest)
    "Task" -> Ok(AlltypesTask)
    "TerminologyCapabilities" -> Ok(AlltypesTerminologycapabilities)
    "TestReport" -> Ok(AlltypesTestreport)
    "TestScript" -> Ok(AlltypesTestscript)
    "ValueSet" -> Ok(AlltypesValueset)
    "VerificationResult" -> Ok(AlltypesVerificationresult)
    "VisionPrescription" -> Ok(AlltypesVisionprescription)
    "Type" -> Ok(AlltypesType)
    "Any" -> Ok(AlltypesAny)
    _ -> Error(Nil)
  }
}

pub fn alltypes_decoder() -> Decoder(Alltypes) {
  use variant <- decode.then(decode.string)
  case variant {
    "Address" -> decode.success(AlltypesAddress)
    "Age" -> decode.success(AlltypesAge)
    "Annotation" -> decode.success(AlltypesAnnotation)
    "Attachment" -> decode.success(AlltypesAttachment)
    "BackboneElement" -> decode.success(AlltypesBackboneelement)
    "CodeableConcept" -> decode.success(AlltypesCodeableconcept)
    "Coding" -> decode.success(AlltypesCoding)
    "ContactDetail" -> decode.success(AlltypesContactdetail)
    "ContactPoint" -> decode.success(AlltypesContactpoint)
    "Contributor" -> decode.success(AlltypesContributor)
    "Count" -> decode.success(AlltypesCount)
    "DataRequirement" -> decode.success(AlltypesDatarequirement)
    "Distance" -> decode.success(AlltypesDistance)
    "Dosage" -> decode.success(AlltypesDosage)
    "Duration" -> decode.success(AlltypesDuration)
    "Element" -> decode.success(AlltypesElement)
    "ElementDefinition" -> decode.success(AlltypesElementdefinition)
    "Expression" -> decode.success(AlltypesExpression)
    "Extension" -> decode.success(AlltypesExtension)
    "HumanName" -> decode.success(AlltypesHumanname)
    "Identifier" -> decode.success(AlltypesIdentifier)
    "MarketingStatus" -> decode.success(AlltypesMarketingstatus)
    "Meta" -> decode.success(AlltypesMeta)
    "Money" -> decode.success(AlltypesMoney)
    "MoneyQuantity" -> decode.success(AlltypesMoneyquantity)
    "Narrative" -> decode.success(AlltypesNarrative)
    "ParameterDefinition" -> decode.success(AlltypesParameterdefinition)
    "Period" -> decode.success(AlltypesPeriod)
    "Population" -> decode.success(AlltypesPopulation)
    "ProdCharacteristic" -> decode.success(AlltypesProdcharacteristic)
    "ProductShelfLife" -> decode.success(AlltypesProductshelflife)
    "Quantity" -> decode.success(AlltypesQuantity)
    "Range" -> decode.success(AlltypesRange)
    "Ratio" -> decode.success(AlltypesRatio)
    "Reference" -> decode.success(AlltypesReference)
    "RelatedArtifact" -> decode.success(AlltypesRelatedartifact)
    "SampledData" -> decode.success(AlltypesSampleddata)
    "Signature" -> decode.success(AlltypesSignature)
    "SimpleQuantity" -> decode.success(AlltypesSimplequantity)
    "SubstanceAmount" -> decode.success(AlltypesSubstanceamount)
    "Timing" -> decode.success(AlltypesTiming)
    "TriggerDefinition" -> decode.success(AlltypesTriggerdefinition)
    "UsageContext" -> decode.success(AlltypesUsagecontext)
    "base64Binary" -> decode.success(AlltypesBase64binary)
    "boolean" -> decode.success(AlltypesBoolean)
    "canonical" -> decode.success(AlltypesCanonical)
    "code" -> decode.success(AlltypesCode)
    "date" -> decode.success(AlltypesDate)
    "dateTime" -> decode.success(AlltypesDatetime)
    "decimal" -> decode.success(AlltypesDecimal)
    "id" -> decode.success(AlltypesId)
    "instant" -> decode.success(AlltypesInstant)
    "integer" -> decode.success(AlltypesInteger)
    "markdown" -> decode.success(AlltypesMarkdown)
    "oid" -> decode.success(AlltypesOid)
    "positiveInt" -> decode.success(AlltypesPositiveint)
    "string" -> decode.success(AlltypesString)
    "time" -> decode.success(AlltypesTime)
    "unsignedInt" -> decode.success(AlltypesUnsignedint)
    "uri" -> decode.success(AlltypesUri)
    "url" -> decode.success(AlltypesUrl)
    "uuid" -> decode.success(AlltypesUuid)
    "xhtml" -> decode.success(AlltypesXhtml)
    "Account" -> decode.success(AlltypesAccount)
    "ActivityDefinition" -> decode.success(AlltypesActivitydefinition)
    "AdverseEvent" -> decode.success(AlltypesAdverseevent)
    "AllergyIntolerance" -> decode.success(AlltypesAllergyintolerance)
    "Appointment" -> decode.success(AlltypesAppointment)
    "AppointmentResponse" -> decode.success(AlltypesAppointmentresponse)
    "AuditEvent" -> decode.success(AlltypesAuditevent)
    "Basic" -> decode.success(AlltypesBasic)
    "Binary" -> decode.success(AlltypesBinary)
    "BiologicallyDerivedProduct" ->
      decode.success(AlltypesBiologicallyderivedproduct)
    "BodyStructure" -> decode.success(AlltypesBodystructure)
    "Bundle" -> decode.success(AlltypesBundle)
    "CapabilityStatement" -> decode.success(AlltypesCapabilitystatement)
    "CarePlan" -> decode.success(AlltypesCareplan)
    "CareTeam" -> decode.success(AlltypesCareteam)
    "CatalogEntry" -> decode.success(AlltypesCatalogentry)
    "ChargeItem" -> decode.success(AlltypesChargeitem)
    "ChargeItemDefinition" -> decode.success(AlltypesChargeitemdefinition)
    "Claim" -> decode.success(AlltypesClaim)
    "ClaimResponse" -> decode.success(AlltypesClaimresponse)
    "ClinicalImpression" -> decode.success(AlltypesClinicalimpression)
    "CodeSystem" -> decode.success(AlltypesCodesystem)
    "Communication" -> decode.success(AlltypesCommunication)
    "CommunicationRequest" -> decode.success(AlltypesCommunicationrequest)
    "CompartmentDefinition" -> decode.success(AlltypesCompartmentdefinition)
    "Composition" -> decode.success(AlltypesComposition)
    "ConceptMap" -> decode.success(AlltypesConceptmap)
    "Condition" -> decode.success(AlltypesCondition)
    "Consent" -> decode.success(AlltypesConsent)
    "Contract" -> decode.success(AlltypesContract)
    "Coverage" -> decode.success(AlltypesCoverage)
    "CoverageEligibilityRequest" ->
      decode.success(AlltypesCoverageeligibilityrequest)
    "CoverageEligibilityResponse" ->
      decode.success(AlltypesCoverageeligibilityresponse)
    "DetectedIssue" -> decode.success(AlltypesDetectedissue)
    "Device" -> decode.success(AlltypesDevice)
    "DeviceDefinition" -> decode.success(AlltypesDevicedefinition)
    "DeviceMetric" -> decode.success(AlltypesDevicemetric)
    "DeviceRequest" -> decode.success(AlltypesDevicerequest)
    "DeviceUseStatement" -> decode.success(AlltypesDeviceusestatement)
    "DiagnosticReport" -> decode.success(AlltypesDiagnosticreport)
    "DocumentManifest" -> decode.success(AlltypesDocumentmanifest)
    "DocumentReference" -> decode.success(AlltypesDocumentreference)
    "DomainResource" -> decode.success(AlltypesDomainresource)
    "EffectEvidenceSynthesis" -> decode.success(AlltypesEffectevidencesynthesis)
    "Encounter" -> decode.success(AlltypesEncounter)
    "Endpoint" -> decode.success(AlltypesEndpoint)
    "EnrollmentRequest" -> decode.success(AlltypesEnrollmentrequest)
    "EnrollmentResponse" -> decode.success(AlltypesEnrollmentresponse)
    "EpisodeOfCare" -> decode.success(AlltypesEpisodeofcare)
    "EventDefinition" -> decode.success(AlltypesEventdefinition)
    "Evidence" -> decode.success(AlltypesEvidence)
    "EvidenceVariable" -> decode.success(AlltypesEvidencevariable)
    "ExampleScenario" -> decode.success(AlltypesExamplescenario)
    "ExplanationOfBenefit" -> decode.success(AlltypesExplanationofbenefit)
    "FamilyMemberHistory" -> decode.success(AlltypesFamilymemberhistory)
    "Flag" -> decode.success(AlltypesFlag)
    "Goal" -> decode.success(AlltypesGoal)
    "GraphDefinition" -> decode.success(AlltypesGraphdefinition)
    "Group" -> decode.success(AlltypesGroup)
    "GuidanceResponse" -> decode.success(AlltypesGuidanceresponse)
    "HealthcareService" -> decode.success(AlltypesHealthcareservice)
    "ImagingStudy" -> decode.success(AlltypesImagingstudy)
    "Immunization" -> decode.success(AlltypesImmunization)
    "ImmunizationEvaluation" -> decode.success(AlltypesImmunizationevaluation)
    "ImmunizationRecommendation" ->
      decode.success(AlltypesImmunizationrecommendation)
    "ImplementationGuide" -> decode.success(AlltypesImplementationguide)
    "InsurancePlan" -> decode.success(AlltypesInsuranceplan)
    "Invoice" -> decode.success(AlltypesInvoice)
    "Library" -> decode.success(AlltypesLibrary)
    "Linkage" -> decode.success(AlltypesLinkage)
    "List" -> decode.success(AlltypesList)
    "Location" -> decode.success(AlltypesLocation)
    "Measure" -> decode.success(AlltypesMeasure)
    "MeasureReport" -> decode.success(AlltypesMeasurereport)
    "Media" -> decode.success(AlltypesMedia)
    "Medication" -> decode.success(AlltypesMedication)
    "MedicationAdministration" ->
      decode.success(AlltypesMedicationadministration)
    "MedicationDispense" -> decode.success(AlltypesMedicationdispense)
    "MedicationKnowledge" -> decode.success(AlltypesMedicationknowledge)
    "MedicationRequest" -> decode.success(AlltypesMedicationrequest)
    "MedicationStatement" -> decode.success(AlltypesMedicationstatement)
    "MedicinalProduct" -> decode.success(AlltypesMedicinalproduct)
    "MedicinalProductAuthorization" ->
      decode.success(AlltypesMedicinalproductauthorization)
    "MedicinalProductContraindication" ->
      decode.success(AlltypesMedicinalproductcontraindication)
    "MedicinalProductIndication" ->
      decode.success(AlltypesMedicinalproductindication)
    "MedicinalProductIngredient" ->
      decode.success(AlltypesMedicinalproductingredient)
    "MedicinalProductInteraction" ->
      decode.success(AlltypesMedicinalproductinteraction)
    "MedicinalProductManufactured" ->
      decode.success(AlltypesMedicinalproductmanufactured)
    "MedicinalProductPackaged" ->
      decode.success(AlltypesMedicinalproductpackaged)
    "MedicinalProductPharmaceutical" ->
      decode.success(AlltypesMedicinalproductpharmaceutical)
    "MedicinalProductUndesirableEffect" ->
      decode.success(AlltypesMedicinalproductundesirableeffect)
    "MessageDefinition" -> decode.success(AlltypesMessagedefinition)
    "MessageHeader" -> decode.success(AlltypesMessageheader)
    "MolecularSequence" -> decode.success(AlltypesMolecularsequence)
    "NamingSystem" -> decode.success(AlltypesNamingsystem)
    "NutritionOrder" -> decode.success(AlltypesNutritionorder)
    "Observation" -> decode.success(AlltypesObservation)
    "ObservationDefinition" -> decode.success(AlltypesObservationdefinition)
    "OperationDefinition" -> decode.success(AlltypesOperationdefinition)
    "OperationOutcome" -> decode.success(AlltypesOperationoutcome)
    "Organization" -> decode.success(AlltypesOrganization)
    "OrganizationAffiliation" -> decode.success(AlltypesOrganizationaffiliation)
    "Parameters" -> decode.success(AlltypesParameters)
    "Patient" -> decode.success(AlltypesPatient)
    "PaymentNotice" -> decode.success(AlltypesPaymentnotice)
    "PaymentReconciliation" -> decode.success(AlltypesPaymentreconciliation)
    "Person" -> decode.success(AlltypesPerson)
    "PlanDefinition" -> decode.success(AlltypesPlandefinition)
    "Practitioner" -> decode.success(AlltypesPractitioner)
    "PractitionerRole" -> decode.success(AlltypesPractitionerrole)
    "Procedure" -> decode.success(AlltypesProcedure)
    "Provenance" -> decode.success(AlltypesProvenance)
    "Questionnaire" -> decode.success(AlltypesQuestionnaire)
    "QuestionnaireResponse" -> decode.success(AlltypesQuestionnaireresponse)
    "RelatedPerson" -> decode.success(AlltypesRelatedperson)
    "RequestGroup" -> decode.success(AlltypesRequestgroup)
    "ResearchDefinition" -> decode.success(AlltypesResearchdefinition)
    "ResearchElementDefinition" ->
      decode.success(AlltypesResearchelementdefinition)
    "ResearchStudy" -> decode.success(AlltypesResearchstudy)
    "ResearchSubject" -> decode.success(AlltypesResearchsubject)
    "Resource" -> decode.success(AlltypesResource)
    "RiskAssessment" -> decode.success(AlltypesRiskassessment)
    "RiskEvidenceSynthesis" -> decode.success(AlltypesRiskevidencesynthesis)
    "Schedule" -> decode.success(AlltypesSchedule)
    "SearchParameter" -> decode.success(AlltypesSearchparameter)
    "ServiceRequest" -> decode.success(AlltypesServicerequest)
    "Slot" -> decode.success(AlltypesSlot)
    "Specimen" -> decode.success(AlltypesSpecimen)
    "SpecimenDefinition" -> decode.success(AlltypesSpecimendefinition)
    "StructureDefinition" -> decode.success(AlltypesStructuredefinition)
    "StructureMap" -> decode.success(AlltypesStructuremap)
    "Subscription" -> decode.success(AlltypesSubscription)
    "Substance" -> decode.success(AlltypesSubstance)
    "SubstanceNucleicAcid" -> decode.success(AlltypesSubstancenucleicacid)
    "SubstancePolymer" -> decode.success(AlltypesSubstancepolymer)
    "SubstanceProtein" -> decode.success(AlltypesSubstanceprotein)
    "SubstanceReferenceInformation" ->
      decode.success(AlltypesSubstancereferenceinformation)
    "SubstanceSourceMaterial" -> decode.success(AlltypesSubstancesourcematerial)
    "SubstanceSpecification" -> decode.success(AlltypesSubstancespecification)
    "SupplyDelivery" -> decode.success(AlltypesSupplydelivery)
    "SupplyRequest" -> decode.success(AlltypesSupplyrequest)
    "Task" -> decode.success(AlltypesTask)
    "TerminologyCapabilities" -> decode.success(AlltypesTerminologycapabilities)
    "TestReport" -> decode.success(AlltypesTestreport)
    "TestScript" -> decode.success(AlltypesTestscript)
    "ValueSet" -> decode.success(AlltypesValueset)
    "VerificationResult" -> decode.success(AlltypesVerificationresult)
    "VisionPrescription" -> decode.success(AlltypesVisionprescription)
    "Type" -> decode.success(AlltypesType)
    "Any" -> decode.success(AlltypesAny)
    _ -> decode.failure(AlltypesAddress, "Alltypes")
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
  case variant {
    "document" -> decode.success(BundletypeDocument)
    "message" -> decode.success(BundletypeMessage)
    "transaction" -> decode.success(BundletypeTransaction)
    "transaction-response" -> decode.success(BundletypeTransactionresponse)
    "batch" -> decode.success(BundletypeBatch)
    "batch-response" -> decode.success(BundletypeBatchresponse)
    "history" -> decode.success(BundletypeHistory)
    "searchset" -> decode.success(BundletypeSearchset)
    "collection" -> decode.success(BundletypeCollection)
    _ -> decode.failure(BundletypeDocument, "Bundletype")
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
  case variant {
    "phone" -> decode.success(ContactpointsystemPhone)
    "fax" -> decode.success(ContactpointsystemFax)
    "email" -> decode.success(ContactpointsystemEmail)
    "pager" -> decode.success(ContactpointsystemPager)
    "url" -> decode.success(ContactpointsystemUrl)
    "sms" -> decode.success(ContactpointsystemSms)
    "other" -> decode.success(ContactpointsystemOther)
    _ -> decode.failure(ContactpointsystemPhone, "Contactpointsystem")
  }
}

pub type Contactpointuse {
  ContactpointuseHome
  ContactpointuseWork
  ContactpointuseTemp
  ContactpointuseOld
  ContactpointuseMobile
}

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
  case variant {
    "home" -> decode.success(ContactpointuseHome)
    "work" -> decode.success(ContactpointuseWork)
    "temp" -> decode.success(ContactpointuseTemp)
    "old" -> decode.success(ContactpointuseOld)
    "mobile" -> decode.success(ContactpointuseMobile)
    _ -> decode.failure(ContactpointuseHome, "Contactpointuse")
  }
}

pub type Contributortype {
  ContributortypeAuthor
  ContributortypeEditor
  ContributortypeReviewer
  ContributortypeEndorser
}

pub fn contributortype_to_json(contributortype: Contributortype) -> Json {
  json.string(contributortype_to_code(contributortype))
}

pub fn contributortype_to_code(contributortype: Contributortype) -> String {
  case contributortype {
    ContributortypeAuthor -> "author"
    ContributortypeEditor -> "editor"
    ContributortypeReviewer -> "reviewer"
    ContributortypeEndorser -> "endorser"
  }
}

pub fn contributortype_from_code(code: String) -> Result(Contributortype, Nil) {
  case code {
    "author" -> Ok(ContributortypeAuthor)
    "editor" -> Ok(ContributortypeEditor)
    "reviewer" -> Ok(ContributortypeReviewer)
    "endorser" -> Ok(ContributortypeEndorser)
    _ -> Error(Nil)
  }
}

pub fn contributortype_decoder() -> Decoder(Contributortype) {
  use variant <- decode.then(decode.string)
  case variant {
    "author" -> decode.success(ContributortypeAuthor)
    "editor" -> decode.success(ContributortypeEditor)
    "reviewer" -> decode.success(ContributortypeReviewer)
    "endorser" -> decode.success(ContributortypeEndorser)
    _ -> decode.failure(ContributortypeAuthor, "Contributortype")
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
  case variant {
    "mon" -> decode.success(DaysofweekMon)
    "tue" -> decode.success(DaysofweekTue)
    "wed" -> decode.success(DaysofweekWed)
    "thu" -> decode.success(DaysofweekThu)
    "fri" -> decode.success(DaysofweekFri)
    "sat" -> decode.success(DaysofweekSat)
    "sun" -> decode.success(DaysofweekSun)
    _ -> decode.failure(DaysofweekMon, "Daysofweek")
  }
}

pub type Detailedethnicity {
  Detailedethnicity10009
  Detailedethnicity10025
  Detailedethnicity10041
  Detailedethnicity10066
  Detailedethnicity10082
  Detailedethnicity10108
  Detailedethnicity10116
  Detailedethnicity10124
  Detailedethnicity10132
  Detailedethnicity10140
  Detailedethnicity10157
  Detailedethnicity10165
  Detailedethnicity10173
  Detailedethnicity10181
  Detailedethnicity10199
  Detailedethnicity10215
  Detailedethnicity10223
  Detailedethnicity10231
  Detailedethnicity10249
  Detailedethnicity10264
  Detailedethnicity10280
  Detailedethnicity10306
  Detailedethnicity10314
  Detailedethnicity10330
  Detailedethnicity10355
  Detailedethnicity10371
  Detailedethnicity10397
  Detailedethnicity10413
  Detailedethnicity10421
  Detailedethnicity10447
  Detailedethnicity10454
  Detailedethnicity10462
  Detailedethnicity10470
  Detailedethnicity10488
  Detailedethnicity10496
  Detailedethnicity10504
  Detailedethnicity10512
  Detailedethnicity10538
  Detailedethnicity10546
  Detailedethnicity10553
  Detailedethnicity10561
  Detailedethnicity10579
  Detailedethnicity10587
  Detailedethnicity10595
  Detailedethnicity10603
  Detailedethnicity10611
  Detailedethnicity10629
  Detailedethnicity10637
  Detailedethnicity10645
  Detailedethnicity10652
  Detailedethnicity10660
  Detailedethnicity10686
  Detailedethnicity10694
  Detailedethnicity10702
  Detailedethnicity10710
  Detailedethnicity10728
  Detailedethnicity10736
  Detailedethnicity10744
  Detailedethnicity10769
  Detailedethnicity10785
  Detailedethnicity10801
  Detailedethnicity10827
  Detailedethnicity10835
  Detailedethnicity10843
  Detailedethnicity10868
  Detailedethnicity10884
  Detailedethnicity10892
  Detailedethnicity10900
  Detailedethnicity10918
  Detailedethnicity10926
  Detailedethnicity10934
  Detailedethnicity10942
  Detailedethnicity10959
  Detailedethnicity10967
  Detailedethnicity10975
  Detailedethnicity10983
  Detailedethnicity11007
  Detailedethnicity11023
  Detailedethnicity11031
  Detailedethnicity11049
  Detailedethnicity11064
  Detailedethnicity11080
  Detailedethnicity11098
  Detailedethnicity11106
  Detailedethnicity11122
  Detailedethnicity11148
  Detailedethnicity11155
  Detailedethnicity11163
  Detailedethnicity11171
  Detailedethnicity11189
  Detailedethnicity11197
  Detailedethnicity11205
  Detailedethnicity11213
  Detailedethnicity11239
  Detailedethnicity11247
  Detailedethnicity11254
  Detailedethnicity11262
  Detailedethnicity11270
  Detailedethnicity11288
  Detailedethnicity11296
  Detailedethnicity11304
  Detailedethnicity11312
  Detailedethnicity11320
  Detailedethnicity11338
  Detailedethnicity11346
  Detailedethnicity11353
  Detailedethnicity11361
  Detailedethnicity11379
  Detailedethnicity11387
  Detailedethnicity11395
  Detailedethnicity11403
  Detailedethnicity11411
  Detailedethnicity11429
  Detailedethnicity11437
  Detailedethnicity11445
  Detailedethnicity11452
  Detailedethnicity11460
  Detailedethnicity11478
  Detailedethnicity11486
  Detailedethnicity11502
  Detailedethnicity11510
  Detailedethnicity11536
  Detailedethnicity11551
  Detailedethnicity11569
  Detailedethnicity11577
  Detailedethnicity11585
  Detailedethnicity11593
  Detailedethnicity11601
  Detailedethnicity11627
  Detailedethnicity11635
  Detailedethnicity11650
  Detailedethnicity11676
  Detailedethnicity11692
  Detailedethnicity11718
  Detailedethnicity11734
  Detailedethnicity11759
  Detailedethnicity11767
  Detailedethnicity11783
  Detailedethnicity11809
  Detailedethnicity11825
  Detailedethnicity11841
  Detailedethnicity11866
  Detailedethnicity11874
  Detailedethnicity11890
  Detailedethnicity11916
  Detailedethnicity11932
  Detailedethnicity11940
  Detailedethnicity11957
  Detailedethnicity11965
  Detailedethnicity11973
  Detailedethnicity11981
  Detailedethnicity11999
  Detailedethnicity12005
  Detailedethnicity12013
  Detailedethnicity12021
  Detailedethnicity12039
  Detailedethnicity12047
  Detailedethnicity12054
  Detailedethnicity12070
  Detailedethnicity12096
  Detailedethnicity12112
  Detailedethnicity12120
  Detailedethnicity12146
  Detailedethnicity12153
  Detailedethnicity12161
  Detailedethnicity12179
  Detailedethnicity12187
  Detailedethnicity12195
  Detailedethnicity12203
  Detailedethnicity12229
  Detailedethnicity12237
  Detailedethnicity12245
  Detailedethnicity12252
  Detailedethnicity12260
  Detailedethnicity12278
  Detailedethnicity12286
  Detailedethnicity12294
  Detailedethnicity12302
  Detailedethnicity12310
  Detailedethnicity12336
  Detailedethnicity12344
  Detailedethnicity12351
  Detailedethnicity12369
  Detailedethnicity12377
  Detailedethnicity12385
  Detailedethnicity12393
  Detailedethnicity12401
  Detailedethnicity12419
  Detailedethnicity12427
  Detailedethnicity12435
  Detailedethnicity12443
  Detailedethnicity12450
  Detailedethnicity12468
  Detailedethnicity12476
  Detailedethnicity12484
  Detailedethnicity12500
  Detailedethnicity12526
  Detailedethnicity12542
  Detailedethnicity12567
  Detailedethnicity12583
  Detailedethnicity12609
  Detailedethnicity12625
  Detailedethnicity12641
  Detailedethnicity12658
  Detailedethnicity12674
  Detailedethnicity12690
  Detailedethnicity12716
  Detailedethnicity12724
  Detailedethnicity12732
  Detailedethnicity12757
  Detailedethnicity12773
  Detailedethnicity12799
  Detailedethnicity12815
  Detailedethnicity12823
  Detailedethnicity12831
  Detailedethnicity12856
  Detailedethnicity12864
  Detailedethnicity12872
  Detailedethnicity12880
  Detailedethnicity12898
  Detailedethnicity12906
  Detailedethnicity12914
  Detailedethnicity12922
  Detailedethnicity12930
  Detailedethnicity12948
  Detailedethnicity12955
  Detailedethnicity12971
  Detailedethnicity12997
  Detailedethnicity13011
  Detailedethnicity13037
  Detailedethnicity13052
  Detailedethnicity13060
  Detailedethnicity13078
  Detailedethnicity13094
  Detailedethnicity13102
  Detailedethnicity13128
  Detailedethnicity13136
  Detailedethnicity13144
  Detailedethnicity13151
  Detailedethnicity13177
  Detailedethnicity13193
  Detailedethnicity13219
  Detailedethnicity13235
  Detailedethnicity13250
  Detailedethnicity13268
  Detailedethnicity13276
  Detailedethnicity13284
  Detailedethnicity13292
  Detailedethnicity13318
  Detailedethnicity13326
  Detailedethnicity13334
  Detailedethnicity13342
  Detailedethnicity13359
  Detailedethnicity13367
  Detailedethnicity13375
  Detailedethnicity13383
  Detailedethnicity13409
  Detailedethnicity13425
  Detailedethnicity13441
  Detailedethnicity13458
  Detailedethnicity13466
  Detailedethnicity13482
  Detailedethnicity13508
  Detailedethnicity13524
  Detailedethnicity13540
  Detailedethnicity13565
  Detailedethnicity13581
  Detailedethnicity13599
  Detailedethnicity13607
  Detailedethnicity13615
  Detailedethnicity13631
  Detailedethnicity13656
  Detailedethnicity13664
  Detailedethnicity13680
  Detailedethnicity13706
  Detailedethnicity13722
  Detailedethnicity13748
  Detailedethnicity13763
  Detailedethnicity13789
  Detailedethnicity13805
  Detailedethnicity13821
  Detailedethnicity13839
  Detailedethnicity13847
  Detailedethnicity13854
  Detailedethnicity13870
  Detailedethnicity13896
  Detailedethnicity13912
  Detailedethnicity13920
  Detailedethnicity13938
  Detailedethnicity13946
  Detailedethnicity13953
  Detailedethnicity13961
  Detailedethnicity13979
  Detailedethnicity13987
  Detailedethnicity13995
  Detailedethnicity14001
  Detailedethnicity14019
  Detailedethnicity14035
  Detailedethnicity14050
  Detailedethnicity14076
  Detailedethnicity14092
  Detailedethnicity14118
  Detailedethnicity14126
  Detailedethnicity14134
  Detailedethnicity14142
  Detailedethnicity14167
  Detailedethnicity14175
  Detailedethnicity14183
  Detailedethnicity14191
  Detailedethnicity14209
  Detailedethnicity14217
  Detailedethnicity14225
  Detailedethnicity14233
  Detailedethnicity14241
  Detailedethnicity14258
  Detailedethnicity14266
  Detailedethnicity14274
  Detailedethnicity14282
  Detailedethnicity14290
  Detailedethnicity14308
  Detailedethnicity14316
  Detailedethnicity14324
  Detailedethnicity14332
  Detailedethnicity14340
  Detailedethnicity14357
  Detailedethnicity14365
  Detailedethnicity14373
  Detailedethnicity14399
  Detailedethnicity14415
  Detailedethnicity14423
  Detailedethnicity14431
  Detailedethnicity14456
  Detailedethnicity14464
  Detailedethnicity14480
  Detailedethnicity14506
  Detailedethnicity14514
  Detailedethnicity14530
  Detailedethnicity14548
  Detailedethnicity14563
  Detailedethnicity14571
  Detailedethnicity14589
  Detailedethnicity14605
  Detailedethnicity14621
  Detailedethnicity14647
  Detailedethnicity14654
  Detailedethnicity14662
  Detailedethnicity14670
  Detailedethnicity14688
  Detailedethnicity14696
  Detailedethnicity14704
  Detailedethnicity14712
  Detailedethnicity14720
  Detailedethnicity14746
  Detailedethnicity14753
  Detailedethnicity14761
  Detailedethnicity14787
  Detailedethnicity14795
  Detailedethnicity14803
  Detailedethnicity14811
  Detailedethnicity14829
  Detailedethnicity14837
  Detailedethnicity14845
  Detailedethnicity14852
  Detailedethnicity14878
  Detailedethnicity14894
  Detailedethnicity14902
  Detailedethnicity14910
  Detailedethnicity14928
  Detailedethnicity14936
  Detailedethnicity14944
  Detailedethnicity14951
  Detailedethnicity14969
  Detailedethnicity14977
  Detailedethnicity14985
  Detailedethnicity14993
  Detailedethnicity15008
  Detailedethnicity15016
  Detailedethnicity15024
  Detailedethnicity15032
  Detailedethnicity15040
  Detailedethnicity15057
  Detailedethnicity15065
  Detailedethnicity15073
  Detailedethnicity15081
  Detailedethnicity15099
  Detailedethnicity15107
  Detailedethnicity15115
  Detailedethnicity15123
  Detailedethnicity15131
  Detailedethnicity15149
  Detailedethnicity15156
  Detailedethnicity15164
  Detailedethnicity15180
  Detailedethnicity15198
  Detailedethnicity15206
  Detailedethnicity15214
  Detailedethnicity15222
  Detailedethnicity15230
  Detailedethnicity15248
  Detailedethnicity15255
  Detailedethnicity15263
  Detailedethnicity15271
  Detailedethnicity15289
  Detailedethnicity15297
  Detailedethnicity15305
  Detailedethnicity15313
  Detailedethnicity15321
  Detailedethnicity15339
  Detailedethnicity15347
  Detailedethnicity15354
  Detailedethnicity15362
  Detailedethnicity15370
  Detailedethnicity15388
  Detailedethnicity15396
  Detailedethnicity15412
  Detailedethnicity15438
  Detailedethnicity15453
  Detailedethnicity15479
  Detailedethnicity15495
  Detailedethnicity15511
  Detailedethnicity15529
  Detailedethnicity15537
  Detailedethnicity15545
  Detailedethnicity15560
  Detailedethnicity15586
  Detailedethnicity15602
  Detailedethnicity15628
  Detailedethnicity15644
  Detailedethnicity15669
  Detailedethnicity15677
  Detailedethnicity15685
  Detailedethnicity15693
  Detailedethnicity15701
  Detailedethnicity15719
  Detailedethnicity15735
  Detailedethnicity15743
  Detailedethnicity15768
  Detailedethnicity15784
  Detailedethnicity15792
  Detailedethnicity15800
  Detailedethnicity15826
  Detailedethnicity15842
  Detailedethnicity15867
  Detailedethnicity15875
  Detailedethnicity15883
  Detailedethnicity15891
  Detailedethnicity15909
  Detailedethnicity15917
  Detailedethnicity15925
  Detailedethnicity15933
  Detailedethnicity15941
  Detailedethnicity15958
  Detailedethnicity15966
  Detailedethnicity15974
  Detailedethnicity15982
  Detailedethnicity15990
  Detailedethnicity16006
  Detailedethnicity16022
  Detailedethnicity16030
  Detailedethnicity16048
  Detailedethnicity16055
  Detailedethnicity16071
  Detailedethnicity16097
  Detailedethnicity16105
  Detailedethnicity16113
  Detailedethnicity16121
  Detailedethnicity16139
  Detailedethnicity16147
  Detailedethnicity16154
  Detailedethnicity16162
  Detailedethnicity16170
  Detailedethnicity16188
  Detailedethnicity16196
  Detailedethnicity16204
  Detailedethnicity16212
  Detailedethnicity16220
  Detailedethnicity16238
  Detailedethnicity16246
  Detailedethnicity16253
  Detailedethnicity16261
  Detailedethnicity16279
  Detailedethnicity16287
  Detailedethnicity16295
  Detailedethnicity16303
  Detailedethnicity16311
  Detailedethnicity16329
  Detailedethnicity16337
  Detailedethnicity16345
  Detailedethnicity16352
  Detailedethnicity16360
  Detailedethnicity16378
  Detailedethnicity16386
  Detailedethnicity16394
  Detailedethnicity16402
  Detailedethnicity16410
  Detailedethnicity16436
  Detailedethnicity16451
  Detailedethnicity16477
  Detailedethnicity16493
  Detailedethnicity16519
  Detailedethnicity16535
  Detailedethnicity16543
  Detailedethnicity16550
  Detailedethnicity16568
  Detailedethnicity16576
  Detailedethnicity16592
  Detailedethnicity16618
  Detailedethnicity16634
  Detailedethnicity16659
  Detailedethnicity16675
  Detailedethnicity16683
  Detailedethnicity16709
  Detailedethnicity16717
  Detailedethnicity16725
  Detailedethnicity16733
  Detailedethnicity16758
  Detailedethnicity16774
  Detailedethnicity16790
  Detailedethnicity16808
  Detailedethnicity16816
  Detailedethnicity16832
  Detailedethnicity16857
  Detailedethnicity16873
  Detailedethnicity16881
  Detailedethnicity16899
  Detailedethnicity16907
  Detailedethnicity16923
  Detailedethnicity16949
  Detailedethnicity16964
  Detailedethnicity16972
  Detailedethnicity16980
  Detailedethnicity17004
  Detailedethnicity17020
  Detailedethnicity17046
  Detailedethnicity17053
  Detailedethnicity17079
  Detailedethnicity17095
  Detailedethnicity17111
  Detailedethnicity17129
  Detailedethnicity17137
  Detailedethnicity17152
  Detailedethnicity17178
  Detailedethnicity17186
  Detailedethnicity17194
  Detailedethnicity17202
  Detailedethnicity17228
  Detailedethnicity17244
  Detailedethnicity17251
  Detailedethnicity17269
  Detailedethnicity17277
  Detailedethnicity17285
  Detailedethnicity17293
  Detailedethnicity17301
  Detailedethnicity17319
  Detailedethnicity17327
  Detailedethnicity17335
  Detailedethnicity17350
  Detailedethnicity17376
  Detailedethnicity17392
  Detailedethnicity17400
  Detailedethnicity17418
  Detailedethnicity17426
  Detailedethnicity17434
  Detailedethnicity17442
  Detailedethnicity17459
  Detailedethnicity17467
  Detailedethnicity17475
  Detailedethnicity17483
  Detailedethnicity17491
  Detailedethnicity17509
  Detailedethnicity17517
  Detailedethnicity17525
  Detailedethnicity17533
  Detailedethnicity17541
  Detailedethnicity17558
  Detailedethnicity17566
  Detailedethnicity17574
  Detailedethnicity17582
  Detailedethnicity17590
  Detailedethnicity17608
  Detailedethnicity17616
  Detailedethnicity17624
  Detailedethnicity17632
  Detailedethnicity17640
  Detailedethnicity17657
  Detailedethnicity17665
  Detailedethnicity17673
  Detailedethnicity17681
  Detailedethnicity17699
  Detailedethnicity17707
  Detailedethnicity17715
  Detailedethnicity17723
  Detailedethnicity17731
  Detailedethnicity17749
  Detailedethnicity17756
  Detailedethnicity17764
  Detailedethnicity17772
  Detailedethnicity17780
  Detailedethnicity17798
  Detailedethnicity17806
  Detailedethnicity17814
  Detailedethnicity17822
  Detailedethnicity17830
  Detailedethnicity17848
  Detailedethnicity17855
  Detailedethnicity17863
  Detailedethnicity17871
  Detailedethnicity17889
  Detailedethnicity17897
  Detailedethnicity17905
  Detailedethnicity17913
  Detailedethnicity17921
  Detailedethnicity17939
  Detailedethnicity17947
  Detailedethnicity17954
  Detailedethnicity17962
  Detailedethnicity17970
  Detailedethnicity17988
  Detailedethnicity17996
  Detailedethnicity18002
  Detailedethnicity18010
  Detailedethnicity18028
  Detailedethnicity18036
  Detailedethnicity18044
  Detailedethnicity18051
  Detailedethnicity18069
  Detailedethnicity18077
  Detailedethnicity18085
  Detailedethnicity18093
  Detailedethnicity18119
  Detailedethnicity18135
  Detailedethnicity18143
  Detailedethnicity18150
  Detailedethnicity18168
  Detailedethnicity18176
  Detailedethnicity18184
  Detailedethnicity18192
  Detailedethnicity18200
  Detailedethnicity18218
  Detailedethnicity18226
  Detailedethnicity18234
  Detailedethnicity18242
  Detailedethnicity18259
  Detailedethnicity18267
  Detailedethnicity18275
  Detailedethnicity18283
  Detailedethnicity18291
  Detailedethnicity18309
  Detailedethnicity18317
  Detailedethnicity18325
  Detailedethnicity18333
  Detailedethnicity18341
  Detailedethnicity18358
  Detailedethnicity18374
  Detailedethnicity18382
  Detailedethnicity18408
  Detailedethnicity18424
  Detailedethnicity18440
  Detailedethnicity18457
  Detailedethnicity18465
  Detailedethnicity18473
  Detailedethnicity18481
  Detailedethnicity18499
  Detailedethnicity18507
  Detailedethnicity18515
  Detailedethnicity18523
  Detailedethnicity18531
  Detailedethnicity18549
  Detailedethnicity18556
  Detailedethnicity18564
  Detailedethnicity18572
  Detailedethnicity18580
  Detailedethnicity18598
  Detailedethnicity18606
  Detailedethnicity18614
  Detailedethnicity18622
  Detailedethnicity18630
  Detailedethnicity18648
  Detailedethnicity18655
  Detailedethnicity18663
  Detailedethnicity18671
  Detailedethnicity18689
  Detailedethnicity18697
  Detailedethnicity18705
  Detailedethnicity18713
  Detailedethnicity18721
  Detailedethnicity18739
  Detailedethnicity18747
  Detailedethnicity18754
  Detailedethnicity18762
  Detailedethnicity18770
  Detailedethnicity18788
  Detailedethnicity18796
  Detailedethnicity18804
  Detailedethnicity18812
  Detailedethnicity18820
  Detailedethnicity18838
  Detailedethnicity18846
  Detailedethnicity18853
  Detailedethnicity18861
  Detailedethnicity18879
  Detailedethnicity18887
  Detailedethnicity18895
  Detailedethnicity18911
  Detailedethnicity18929
  Detailedethnicity18937
  Detailedethnicity18945
  Detailedethnicity18960
  Detailedethnicity18978
  Detailedethnicity18986
  Detailedethnicity18994
  Detailedethnicity19000
  Detailedethnicity19018
  Detailedethnicity19026
  Detailedethnicity19034
  Detailedethnicity19042
  Detailedethnicity19059
  Detailedethnicity19067
  Detailedethnicity19075
  Detailedethnicity19083
  Detailedethnicity19091
  Detailedethnicity19109
  Detailedethnicity19117
  Detailedethnicity19125
  Detailedethnicity19133
  Detailedethnicity19141
  Detailedethnicity19158
  Detailedethnicity19166
  Detailedethnicity19174
  Detailedethnicity19182
  Detailedethnicity19190
  Detailedethnicity19208
  Detailedethnicity19216
  Detailedethnicity19224
  Detailedethnicity19232
  Detailedethnicity19240
  Detailedethnicity19257
  Detailedethnicity19265
  Detailedethnicity19273
  Detailedethnicity19281
  Detailedethnicity19299
  Detailedethnicity19307
  Detailedethnicity19315
  Detailedethnicity19323
  Detailedethnicity19331
  Detailedethnicity19349
  Detailedethnicity19356
  Detailedethnicity19364
  Detailedethnicity19372
  Detailedethnicity19380
  Detailedethnicity19398
  Detailedethnicity19406
  Detailedethnicity19414
  Detailedethnicity19422
  Detailedethnicity19430
  Detailedethnicity19448
  Detailedethnicity19455
  Detailedethnicity19463
  Detailedethnicity19471
  Detailedethnicity19489
  Detailedethnicity19497
  Detailedethnicity19505
  Detailedethnicity19513
  Detailedethnicity19521
  Detailedethnicity19539
  Detailedethnicity19547
  Detailedethnicity19554
  Detailedethnicity19562
  Detailedethnicity19570
  Detailedethnicity19588
  Detailedethnicity19596
  Detailedethnicity19604
  Detailedethnicity19612
  Detailedethnicity19620
  Detailedethnicity19638
  Detailedethnicity19646
  Detailedethnicity19661
  Detailedethnicity19687
  Detailedethnicity19695
  Detailedethnicity19703
  Detailedethnicity19729
  Detailedethnicity19737
  Detailedethnicity19745
  Detailedethnicity19752
  Detailedethnicity19760
  Detailedethnicity19778
  Detailedethnicity19786
  Detailedethnicity19794
  Detailedethnicity19802
  Detailedethnicity19810
  Detailedethnicity19828
  Detailedethnicity19844
  Detailedethnicity19851
  Detailedethnicity19869
  Detailedethnicity19877
  Detailedethnicity19885
  Detailedethnicity19901
  Detailedethnicity19927
  Detailedethnicity19935
  Detailedethnicity19943
  Detailedethnicity19950
  Detailedethnicity19968
  Detailedethnicity19976
  Detailedethnicity19984
  Detailedethnicity19992
  Detailedethnicity20008
  Detailedethnicity20024
  Detailedethnicity20040
  Detailedethnicity20065
  Detailedethnicity20073
  Detailedethnicity20081
  Detailedethnicity20099
  Detailedethnicity20107
  Detailedethnicity20115
  Detailedethnicity20123
  Detailedethnicity20131
  Detailedethnicity20149
  Detailedethnicity20156
  Detailedethnicity20164
  Detailedethnicity20172
  Detailedethnicity20180
  Detailedethnicity20198
  Detailedethnicity20206
  Detailedethnicity20214
  Detailedethnicity20222
  Detailedethnicity20230
  Detailedethnicity20248
  Detailedethnicity20255
  Detailedethnicity20263
  Detailedethnicity20289
  Detailedethnicity20297
  Detailedethnicity20305
  Detailedethnicity20313
  Detailedethnicity20321
  Detailedethnicity20339
  Detailedethnicity20347
  Detailedethnicity20354
  Detailedethnicity20362
  Detailedethnicity20370
  Detailedethnicity20388
  Detailedethnicity20396
  Detailedethnicity20404
  Detailedethnicity20412
  Detailedethnicity20420
  Detailedethnicity20438
  Detailedethnicity20446
  Detailedethnicity20453
  Detailedethnicity20461
  Detailedethnicity20479
  Detailedethnicity20487
  Detailedethnicity20495
  Detailedethnicity20503
  Detailedethnicity20511
  Detailedethnicity20529
  Detailedethnicity20545
  Detailedethnicity20560
  Detailedethnicity20586
  Detailedethnicity20602
  Detailedethnicity20610
  Detailedethnicity20628
  Detailedethnicity20636
  Detailedethnicity20644
  Detailedethnicity20651
  Detailedethnicity20669
  Detailedethnicity20677
  Detailedethnicity20685
  Detailedethnicity20693
  Detailedethnicity20701
  Detailedethnicity20719
  Detailedethnicity20727
  Detailedethnicity20735
  Detailedethnicity20743
  Detailedethnicity20750
  Detailedethnicity20768
  Detailedethnicity20784
  Detailedethnicity20792
  Detailedethnicity20800
  Detailedethnicity20818
  Detailedethnicity20826
  Detailedethnicity20834
  Detailedethnicity20859
  Detailedethnicity20867
  Detailedethnicity20875
  Detailedethnicity20883
  Detailedethnicity20891
  Detailedethnicity20909
  Detailedethnicity20917
  Detailedethnicity20925
  Detailedethnicity20933
  Detailedethnicity20941
  Detailedethnicity20958
  Detailedethnicity20966
  Detailedethnicity20974
  Detailedethnicity20982
  Detailedethnicity21006
  Detailedethnicity21014
  Detailedethnicity21022
  Detailedethnicity21030
  Detailedethnicity21048
  Detailedethnicity21063
  Detailedethnicity21089
  Detailedethnicity21097
  Detailedethnicity21105
  Detailedethnicity21113
  Detailedethnicity21121
  Detailedethnicity21139
  Detailedethnicity21147
  Detailedethnicity21154
  Detailedethnicity21162
  Detailedethnicity21188
  Detailedethnicity21196
  Detailedethnicity21204
  Detailedethnicity21212
  Detailedethnicity21220
  Detailedethnicity21238
  Detailedethnicity21246
  Detailedethnicity21253
  Detailedethnicity21261
  Detailedethnicity21279
  Detailedethnicity21295
  Detailedethnicity21311
  Detailedethnicity21337
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
  Detailedethnicity25007
  DetailedethnicityAsku
  DetailedethnicityOth
  DetailedethnicityUnk
}

pub fn detailedethnicity_to_json(detailedethnicity: Detailedethnicity) -> Json {
  json.string(detailedethnicity_to_code(detailedethnicity))
}

pub fn detailedethnicity_to_code(
  detailedethnicity: Detailedethnicity,
) -> String {
  case detailedethnicity {
    Detailedethnicity10009 -> "1000-9"
    Detailedethnicity10025 -> "1002-5"
    Detailedethnicity10041 -> "1004-1"
    Detailedethnicity10066 -> "1006-6"
    Detailedethnicity10082 -> "1008-2"
    Detailedethnicity10108 -> "1010-8"
    Detailedethnicity10116 -> "1011-6"
    Detailedethnicity10124 -> "1012-4"
    Detailedethnicity10132 -> "1013-2"
    Detailedethnicity10140 -> "1014-0"
    Detailedethnicity10157 -> "1015-7"
    Detailedethnicity10165 -> "1016-5"
    Detailedethnicity10173 -> "1017-3"
    Detailedethnicity10181 -> "1018-1"
    Detailedethnicity10199 -> "1019-9"
    Detailedethnicity10215 -> "1021-5"
    Detailedethnicity10223 -> "1022-3"
    Detailedethnicity10231 -> "1023-1"
    Detailedethnicity10249 -> "1024-9"
    Detailedethnicity10264 -> "1026-4"
    Detailedethnicity10280 -> "1028-0"
    Detailedethnicity10306 -> "1030-6"
    Detailedethnicity10314 -> "1031-4"
    Detailedethnicity10330 -> "1033-0"
    Detailedethnicity10355 -> "1035-5"
    Detailedethnicity10371 -> "1037-1"
    Detailedethnicity10397 -> "1039-7"
    Detailedethnicity10413 -> "1041-3"
    Detailedethnicity10421 -> "1042-1"
    Detailedethnicity10447 -> "1044-7"
    Detailedethnicity10454 -> "1045-4"
    Detailedethnicity10462 -> "1046-2"
    Detailedethnicity10470 -> "1047-0"
    Detailedethnicity10488 -> "1048-8"
    Detailedethnicity10496 -> "1049-6"
    Detailedethnicity10504 -> "1050-4"
    Detailedethnicity10512 -> "1051-2"
    Detailedethnicity10538 -> "1053-8"
    Detailedethnicity10546 -> "1054-6"
    Detailedethnicity10553 -> "1055-3"
    Detailedethnicity10561 -> "1056-1"
    Detailedethnicity10579 -> "1057-9"
    Detailedethnicity10587 -> "1058-7"
    Detailedethnicity10595 -> "1059-5"
    Detailedethnicity10603 -> "1060-3"
    Detailedethnicity10611 -> "1061-1"
    Detailedethnicity10629 -> "1062-9"
    Detailedethnicity10637 -> "1063-7"
    Detailedethnicity10645 -> "1064-5"
    Detailedethnicity10652 -> "1065-2"
    Detailedethnicity10660 -> "1066-0"
    Detailedethnicity10686 -> "1068-6"
    Detailedethnicity10694 -> "1069-4"
    Detailedethnicity10702 -> "1070-2"
    Detailedethnicity10710 -> "1071-0"
    Detailedethnicity10728 -> "1072-8"
    Detailedethnicity10736 -> "1073-6"
    Detailedethnicity10744 -> "1074-4"
    Detailedethnicity10769 -> "1076-9"
    Detailedethnicity10785 -> "1078-5"
    Detailedethnicity10801 -> "1080-1"
    Detailedethnicity10827 -> "1082-7"
    Detailedethnicity10835 -> "1083-5"
    Detailedethnicity10843 -> "1084-3"
    Detailedethnicity10868 -> "1086-8"
    Detailedethnicity10884 -> "1088-4"
    Detailedethnicity10892 -> "1089-2"
    Detailedethnicity10900 -> "1090-0"
    Detailedethnicity10918 -> "1091-8"
    Detailedethnicity10926 -> "1092-6"
    Detailedethnicity10934 -> "1093-4"
    Detailedethnicity10942 -> "1094-2"
    Detailedethnicity10959 -> "1095-9"
    Detailedethnicity10967 -> "1096-7"
    Detailedethnicity10975 -> "1097-5"
    Detailedethnicity10983 -> "1098-3"
    Detailedethnicity11007 -> "1100-7"
    Detailedethnicity11023 -> "1102-3"
    Detailedethnicity11031 -> "1103-1"
    Detailedethnicity11049 -> "1104-9"
    Detailedethnicity11064 -> "1106-4"
    Detailedethnicity11080 -> "1108-0"
    Detailedethnicity11098 -> "1109-8"
    Detailedethnicity11106 -> "1110-6"
    Detailedethnicity11122 -> "1112-2"
    Detailedethnicity11148 -> "1114-8"
    Detailedethnicity11155 -> "1115-5"
    Detailedethnicity11163 -> "1116-3"
    Detailedethnicity11171 -> "1117-1"
    Detailedethnicity11189 -> "1118-9"
    Detailedethnicity11197 -> "1119-7"
    Detailedethnicity11205 -> "1120-5"
    Detailedethnicity11213 -> "1121-3"
    Detailedethnicity11239 -> "1123-9"
    Detailedethnicity11247 -> "1124-7"
    Detailedethnicity11254 -> "1125-4"
    Detailedethnicity11262 -> "1126-2"
    Detailedethnicity11270 -> "1127-0"
    Detailedethnicity11288 -> "1128-8"
    Detailedethnicity11296 -> "1129-6"
    Detailedethnicity11304 -> "1130-4"
    Detailedethnicity11312 -> "1131-2"
    Detailedethnicity11320 -> "1132-0"
    Detailedethnicity11338 -> "1133-8"
    Detailedethnicity11346 -> "1134-6"
    Detailedethnicity11353 -> "1135-3"
    Detailedethnicity11361 -> "1136-1"
    Detailedethnicity11379 -> "1137-9"
    Detailedethnicity11387 -> "1138-7"
    Detailedethnicity11395 -> "1139-5"
    Detailedethnicity11403 -> "1140-3"
    Detailedethnicity11411 -> "1141-1"
    Detailedethnicity11429 -> "1142-9"
    Detailedethnicity11437 -> "1143-7"
    Detailedethnicity11445 -> "1144-5"
    Detailedethnicity11452 -> "1145-2"
    Detailedethnicity11460 -> "1146-0"
    Detailedethnicity11478 -> "1147-8"
    Detailedethnicity11486 -> "1148-6"
    Detailedethnicity11502 -> "1150-2"
    Detailedethnicity11510 -> "1151-0"
    Detailedethnicity11536 -> "1153-6"
    Detailedethnicity11551 -> "1155-1"
    Detailedethnicity11569 -> "1156-9"
    Detailedethnicity11577 -> "1157-7"
    Detailedethnicity11585 -> "1158-5"
    Detailedethnicity11593 -> "1159-3"
    Detailedethnicity11601 -> "1160-1"
    Detailedethnicity11627 -> "1162-7"
    Detailedethnicity11635 -> "1163-5"
    Detailedethnicity11650 -> "1165-0"
    Detailedethnicity11676 -> "1167-6"
    Detailedethnicity11692 -> "1169-2"
    Detailedethnicity11718 -> "1171-8"
    Detailedethnicity11734 -> "1173-4"
    Detailedethnicity11759 -> "1175-9"
    Detailedethnicity11767 -> "1176-7"
    Detailedethnicity11783 -> "1178-3"
    Detailedethnicity11809 -> "1180-9"
    Detailedethnicity11825 -> "1182-5"
    Detailedethnicity11841 -> "1184-1"
    Detailedethnicity11866 -> "1186-6"
    Detailedethnicity11874 -> "1187-4"
    Detailedethnicity11890 -> "1189-0"
    Detailedethnicity11916 -> "1191-6"
    Detailedethnicity11932 -> "1193-2"
    Detailedethnicity11940 -> "1194-0"
    Detailedethnicity11957 -> "1195-7"
    Detailedethnicity11965 -> "1196-5"
    Detailedethnicity11973 -> "1197-3"
    Detailedethnicity11981 -> "1198-1"
    Detailedethnicity11999 -> "1199-9"
    Detailedethnicity12005 -> "1200-5"
    Detailedethnicity12013 -> "1201-3"
    Detailedethnicity12021 -> "1202-1"
    Detailedethnicity12039 -> "1203-9"
    Detailedethnicity12047 -> "1204-7"
    Detailedethnicity12054 -> "1205-4"
    Detailedethnicity12070 -> "1207-0"
    Detailedethnicity12096 -> "1209-6"
    Detailedethnicity12112 -> "1211-2"
    Detailedethnicity12120 -> "1212-0"
    Detailedethnicity12146 -> "1214-6"
    Detailedethnicity12153 -> "1215-3"
    Detailedethnicity12161 -> "1216-1"
    Detailedethnicity12179 -> "1217-9"
    Detailedethnicity12187 -> "1218-7"
    Detailedethnicity12195 -> "1219-5"
    Detailedethnicity12203 -> "1220-3"
    Detailedethnicity12229 -> "1222-9"
    Detailedethnicity12237 -> "1223-7"
    Detailedethnicity12245 -> "1224-5"
    Detailedethnicity12252 -> "1225-2"
    Detailedethnicity12260 -> "1226-0"
    Detailedethnicity12278 -> "1227-8"
    Detailedethnicity12286 -> "1228-6"
    Detailedethnicity12294 -> "1229-4"
    Detailedethnicity12302 -> "1230-2"
    Detailedethnicity12310 -> "1231-0"
    Detailedethnicity12336 -> "1233-6"
    Detailedethnicity12344 -> "1234-4"
    Detailedethnicity12351 -> "1235-1"
    Detailedethnicity12369 -> "1236-9"
    Detailedethnicity12377 -> "1237-7"
    Detailedethnicity12385 -> "1238-5"
    Detailedethnicity12393 -> "1239-3"
    Detailedethnicity12401 -> "1240-1"
    Detailedethnicity12419 -> "1241-9"
    Detailedethnicity12427 -> "1242-7"
    Detailedethnicity12435 -> "1243-5"
    Detailedethnicity12443 -> "1244-3"
    Detailedethnicity12450 -> "1245-0"
    Detailedethnicity12468 -> "1246-8"
    Detailedethnicity12476 -> "1247-6"
    Detailedethnicity12484 -> "1248-4"
    Detailedethnicity12500 -> "1250-0"
    Detailedethnicity12526 -> "1252-6"
    Detailedethnicity12542 -> "1254-2"
    Detailedethnicity12567 -> "1256-7"
    Detailedethnicity12583 -> "1258-3"
    Detailedethnicity12609 -> "1260-9"
    Detailedethnicity12625 -> "1262-5"
    Detailedethnicity12641 -> "1264-1"
    Detailedethnicity12658 -> "1265-8"
    Detailedethnicity12674 -> "1267-4"
    Detailedethnicity12690 -> "1269-0"
    Detailedethnicity12716 -> "1271-6"
    Detailedethnicity12724 -> "1272-4"
    Detailedethnicity12732 -> "1273-2"
    Detailedethnicity12757 -> "1275-7"
    Detailedethnicity12773 -> "1277-3"
    Detailedethnicity12799 -> "1279-9"
    Detailedethnicity12815 -> "1281-5"
    Detailedethnicity12823 -> "1282-3"
    Detailedethnicity12831 -> "1283-1"
    Detailedethnicity12856 -> "1285-6"
    Detailedethnicity12864 -> "1286-4"
    Detailedethnicity12872 -> "1287-2"
    Detailedethnicity12880 -> "1288-0"
    Detailedethnicity12898 -> "1289-8"
    Detailedethnicity12906 -> "1290-6"
    Detailedethnicity12914 -> "1291-4"
    Detailedethnicity12922 -> "1292-2"
    Detailedethnicity12930 -> "1293-0"
    Detailedethnicity12948 -> "1294-8"
    Detailedethnicity12955 -> "1295-5"
    Detailedethnicity12971 -> "1297-1"
    Detailedethnicity12997 -> "1299-7"
    Detailedethnicity13011 -> "1301-1"
    Detailedethnicity13037 -> "1303-7"
    Detailedethnicity13052 -> "1305-2"
    Detailedethnicity13060 -> "1306-0"
    Detailedethnicity13078 -> "1307-8"
    Detailedethnicity13094 -> "1309-4"
    Detailedethnicity13102 -> "1310-2"
    Detailedethnicity13128 -> "1312-8"
    Detailedethnicity13136 -> "1313-6"
    Detailedethnicity13144 -> "1314-4"
    Detailedethnicity13151 -> "1315-1"
    Detailedethnicity13177 -> "1317-7"
    Detailedethnicity13193 -> "1319-3"
    Detailedethnicity13219 -> "1321-9"
    Detailedethnicity13235 -> "1323-5"
    Detailedethnicity13250 -> "1325-0"
    Detailedethnicity13268 -> "1326-8"
    Detailedethnicity13276 -> "1327-6"
    Detailedethnicity13284 -> "1328-4"
    Detailedethnicity13292 -> "1329-2"
    Detailedethnicity13318 -> "1331-8"
    Detailedethnicity13326 -> "1332-6"
    Detailedethnicity13334 -> "1333-4"
    Detailedethnicity13342 -> "1334-2"
    Detailedethnicity13359 -> "1335-9"
    Detailedethnicity13367 -> "1336-7"
    Detailedethnicity13375 -> "1337-5"
    Detailedethnicity13383 -> "1338-3"
    Detailedethnicity13409 -> "1340-9"
    Detailedethnicity13425 -> "1342-5"
    Detailedethnicity13441 -> "1344-1"
    Detailedethnicity13458 -> "1345-8"
    Detailedethnicity13466 -> "1346-6"
    Detailedethnicity13482 -> "1348-2"
    Detailedethnicity13508 -> "1350-8"
    Detailedethnicity13524 -> "1352-4"
    Detailedethnicity13540 -> "1354-0"
    Detailedethnicity13565 -> "1356-5"
    Detailedethnicity13581 -> "1358-1"
    Detailedethnicity13599 -> "1359-9"
    Detailedethnicity13607 -> "1360-7"
    Detailedethnicity13615 -> "1361-5"
    Detailedethnicity13631 -> "1363-1"
    Detailedethnicity13656 -> "1365-6"
    Detailedethnicity13664 -> "1366-4"
    Detailedethnicity13680 -> "1368-0"
    Detailedethnicity13706 -> "1370-6"
    Detailedethnicity13722 -> "1372-2"
    Detailedethnicity13748 -> "1374-8"
    Detailedethnicity13763 -> "1376-3"
    Detailedethnicity13789 -> "1378-9"
    Detailedethnicity13805 -> "1380-5"
    Detailedethnicity13821 -> "1382-1"
    Detailedethnicity13839 -> "1383-9"
    Detailedethnicity13847 -> "1384-7"
    Detailedethnicity13854 -> "1385-4"
    Detailedethnicity13870 -> "1387-0"
    Detailedethnicity13896 -> "1389-6"
    Detailedethnicity13912 -> "1391-2"
    Detailedethnicity13920 -> "1392-0"
    Detailedethnicity13938 -> "1393-8"
    Detailedethnicity13946 -> "1394-6"
    Detailedethnicity13953 -> "1395-3"
    Detailedethnicity13961 -> "1396-1"
    Detailedethnicity13979 -> "1397-9"
    Detailedethnicity13987 -> "1398-7"
    Detailedethnicity13995 -> "1399-5"
    Detailedethnicity14001 -> "1400-1"
    Detailedethnicity14019 -> "1401-9"
    Detailedethnicity14035 -> "1403-5"
    Detailedethnicity14050 -> "1405-0"
    Detailedethnicity14076 -> "1407-6"
    Detailedethnicity14092 -> "1409-2"
    Detailedethnicity14118 -> "1411-8"
    Detailedethnicity14126 -> "1412-6"
    Detailedethnicity14134 -> "1413-4"
    Detailedethnicity14142 -> "1414-2"
    Detailedethnicity14167 -> "1416-7"
    Detailedethnicity14175 -> "1417-5"
    Detailedethnicity14183 -> "1418-3"
    Detailedethnicity14191 -> "1419-1"
    Detailedethnicity14209 -> "1420-9"
    Detailedethnicity14217 -> "1421-7"
    Detailedethnicity14225 -> "1422-5"
    Detailedethnicity14233 -> "1423-3"
    Detailedethnicity14241 -> "1424-1"
    Detailedethnicity14258 -> "1425-8"
    Detailedethnicity14266 -> "1426-6"
    Detailedethnicity14274 -> "1427-4"
    Detailedethnicity14282 -> "1428-2"
    Detailedethnicity14290 -> "1429-0"
    Detailedethnicity14308 -> "1430-8"
    Detailedethnicity14316 -> "1431-6"
    Detailedethnicity14324 -> "1432-4"
    Detailedethnicity14332 -> "1433-2"
    Detailedethnicity14340 -> "1434-0"
    Detailedethnicity14357 -> "1435-7"
    Detailedethnicity14365 -> "1436-5"
    Detailedethnicity14373 -> "1437-3"
    Detailedethnicity14399 -> "1439-9"
    Detailedethnicity14415 -> "1441-5"
    Detailedethnicity14423 -> "1442-3"
    Detailedethnicity14431 -> "1443-1"
    Detailedethnicity14456 -> "1445-6"
    Detailedethnicity14464 -> "1446-4"
    Detailedethnicity14480 -> "1448-0"
    Detailedethnicity14506 -> "1450-6"
    Detailedethnicity14514 -> "1451-4"
    Detailedethnicity14530 -> "1453-0"
    Detailedethnicity14548 -> "1454-8"
    Detailedethnicity14563 -> "1456-3"
    Detailedethnicity14571 -> "1457-1"
    Detailedethnicity14589 -> "1458-9"
    Detailedethnicity14605 -> "1460-5"
    Detailedethnicity14621 -> "1462-1"
    Detailedethnicity14647 -> "1464-7"
    Detailedethnicity14654 -> "1465-4"
    Detailedethnicity14662 -> "1466-2"
    Detailedethnicity14670 -> "1467-0"
    Detailedethnicity14688 -> "1468-8"
    Detailedethnicity14696 -> "1469-6"
    Detailedethnicity14704 -> "1470-4"
    Detailedethnicity14712 -> "1471-2"
    Detailedethnicity14720 -> "1472-0"
    Detailedethnicity14746 -> "1474-6"
    Detailedethnicity14753 -> "1475-3"
    Detailedethnicity14761 -> "1476-1"
    Detailedethnicity14787 -> "1478-7"
    Detailedethnicity14795 -> "1479-5"
    Detailedethnicity14803 -> "1480-3"
    Detailedethnicity14811 -> "1481-1"
    Detailedethnicity14829 -> "1482-9"
    Detailedethnicity14837 -> "1483-7"
    Detailedethnicity14845 -> "1484-5"
    Detailedethnicity14852 -> "1485-2"
    Detailedethnicity14878 -> "1487-8"
    Detailedethnicity14894 -> "1489-4"
    Detailedethnicity14902 -> "1490-2"
    Detailedethnicity14910 -> "1491-0"
    Detailedethnicity14928 -> "1492-8"
    Detailedethnicity14936 -> "1493-6"
    Detailedethnicity14944 -> "1494-4"
    Detailedethnicity14951 -> "1495-1"
    Detailedethnicity14969 -> "1496-9"
    Detailedethnicity14977 -> "1497-7"
    Detailedethnicity14985 -> "1498-5"
    Detailedethnicity14993 -> "1499-3"
    Detailedethnicity15008 -> "1500-8"
    Detailedethnicity15016 -> "1501-6"
    Detailedethnicity15024 -> "1502-4"
    Detailedethnicity15032 -> "1503-2"
    Detailedethnicity15040 -> "1504-0"
    Detailedethnicity15057 -> "1505-7"
    Detailedethnicity15065 -> "1506-5"
    Detailedethnicity15073 -> "1507-3"
    Detailedethnicity15081 -> "1508-1"
    Detailedethnicity15099 -> "1509-9"
    Detailedethnicity15107 -> "1510-7"
    Detailedethnicity15115 -> "1511-5"
    Detailedethnicity15123 -> "1512-3"
    Detailedethnicity15131 -> "1513-1"
    Detailedethnicity15149 -> "1514-9"
    Detailedethnicity15156 -> "1515-6"
    Detailedethnicity15164 -> "1516-4"
    Detailedethnicity15180 -> "1518-0"
    Detailedethnicity15198 -> "1519-8"
    Detailedethnicity15206 -> "1520-6"
    Detailedethnicity15214 -> "1521-4"
    Detailedethnicity15222 -> "1522-2"
    Detailedethnicity15230 -> "1523-0"
    Detailedethnicity15248 -> "1524-8"
    Detailedethnicity15255 -> "1525-5"
    Detailedethnicity15263 -> "1526-3"
    Detailedethnicity15271 -> "1527-1"
    Detailedethnicity15289 -> "1528-9"
    Detailedethnicity15297 -> "1529-7"
    Detailedethnicity15305 -> "1530-5"
    Detailedethnicity15313 -> "1531-3"
    Detailedethnicity15321 -> "1532-1"
    Detailedethnicity15339 -> "1533-9"
    Detailedethnicity15347 -> "1534-7"
    Detailedethnicity15354 -> "1535-4"
    Detailedethnicity15362 -> "1536-2"
    Detailedethnicity15370 -> "1537-0"
    Detailedethnicity15388 -> "1538-8"
    Detailedethnicity15396 -> "1539-6"
    Detailedethnicity15412 -> "1541-2"
    Detailedethnicity15438 -> "1543-8"
    Detailedethnicity15453 -> "1545-3"
    Detailedethnicity15479 -> "1547-9"
    Detailedethnicity15495 -> "1549-5"
    Detailedethnicity15511 -> "1551-1"
    Detailedethnicity15529 -> "1552-9"
    Detailedethnicity15537 -> "1553-7"
    Detailedethnicity15545 -> "1554-5"
    Detailedethnicity15560 -> "1556-0"
    Detailedethnicity15586 -> "1558-6"
    Detailedethnicity15602 -> "1560-2"
    Detailedethnicity15628 -> "1562-8"
    Detailedethnicity15644 -> "1564-4"
    Detailedethnicity15669 -> "1566-9"
    Detailedethnicity15677 -> "1567-7"
    Detailedethnicity15685 -> "1568-5"
    Detailedethnicity15693 -> "1569-3"
    Detailedethnicity15701 -> "1570-1"
    Detailedethnicity15719 -> "1571-9"
    Detailedethnicity15735 -> "1573-5"
    Detailedethnicity15743 -> "1574-3"
    Detailedethnicity15768 -> "1576-8"
    Detailedethnicity15784 -> "1578-4"
    Detailedethnicity15792 -> "1579-2"
    Detailedethnicity15800 -> "1580-0"
    Detailedethnicity15826 -> "1582-6"
    Detailedethnicity15842 -> "1584-2"
    Detailedethnicity15867 -> "1586-7"
    Detailedethnicity15875 -> "1587-5"
    Detailedethnicity15883 -> "1588-3"
    Detailedethnicity15891 -> "1589-1"
    Detailedethnicity15909 -> "1590-9"
    Detailedethnicity15917 -> "1591-7"
    Detailedethnicity15925 -> "1592-5"
    Detailedethnicity15933 -> "1593-3"
    Detailedethnicity15941 -> "1594-1"
    Detailedethnicity15958 -> "1595-8"
    Detailedethnicity15966 -> "1596-6"
    Detailedethnicity15974 -> "1597-4"
    Detailedethnicity15982 -> "1598-2"
    Detailedethnicity15990 -> "1599-0"
    Detailedethnicity16006 -> "1600-6"
    Detailedethnicity16022 -> "1602-2"
    Detailedethnicity16030 -> "1603-0"
    Detailedethnicity16048 -> "1604-8"
    Detailedethnicity16055 -> "1605-5"
    Detailedethnicity16071 -> "1607-1"
    Detailedethnicity16097 -> "1609-7"
    Detailedethnicity16105 -> "1610-5"
    Detailedethnicity16113 -> "1611-3"
    Detailedethnicity16121 -> "1612-1"
    Detailedethnicity16139 -> "1613-9"
    Detailedethnicity16147 -> "1614-7"
    Detailedethnicity16154 -> "1615-4"
    Detailedethnicity16162 -> "1616-2"
    Detailedethnicity16170 -> "1617-0"
    Detailedethnicity16188 -> "1618-8"
    Detailedethnicity16196 -> "1619-6"
    Detailedethnicity16204 -> "1620-4"
    Detailedethnicity16212 -> "1621-2"
    Detailedethnicity16220 -> "1622-0"
    Detailedethnicity16238 -> "1623-8"
    Detailedethnicity16246 -> "1624-6"
    Detailedethnicity16253 -> "1625-3"
    Detailedethnicity16261 -> "1626-1"
    Detailedethnicity16279 -> "1627-9"
    Detailedethnicity16287 -> "1628-7"
    Detailedethnicity16295 -> "1629-5"
    Detailedethnicity16303 -> "1630-3"
    Detailedethnicity16311 -> "1631-1"
    Detailedethnicity16329 -> "1632-9"
    Detailedethnicity16337 -> "1633-7"
    Detailedethnicity16345 -> "1634-5"
    Detailedethnicity16352 -> "1635-2"
    Detailedethnicity16360 -> "1636-0"
    Detailedethnicity16378 -> "1637-8"
    Detailedethnicity16386 -> "1638-6"
    Detailedethnicity16394 -> "1639-4"
    Detailedethnicity16402 -> "1640-2"
    Detailedethnicity16410 -> "1641-0"
    Detailedethnicity16436 -> "1643-6"
    Detailedethnicity16451 -> "1645-1"
    Detailedethnicity16477 -> "1647-7"
    Detailedethnicity16493 -> "1649-3"
    Detailedethnicity16519 -> "1651-9"
    Detailedethnicity16535 -> "1653-5"
    Detailedethnicity16543 -> "1654-3"
    Detailedethnicity16550 -> "1655-0"
    Detailedethnicity16568 -> "1656-8"
    Detailedethnicity16576 -> "1657-6"
    Detailedethnicity16592 -> "1659-2"
    Detailedethnicity16618 -> "1661-8"
    Detailedethnicity16634 -> "1663-4"
    Detailedethnicity16659 -> "1665-9"
    Detailedethnicity16675 -> "1667-5"
    Detailedethnicity16683 -> "1668-3"
    Detailedethnicity16709 -> "1670-9"
    Detailedethnicity16717 -> "1671-7"
    Detailedethnicity16725 -> "1672-5"
    Detailedethnicity16733 -> "1673-3"
    Detailedethnicity16758 -> "1675-8"
    Detailedethnicity16774 -> "1677-4"
    Detailedethnicity16790 -> "1679-0"
    Detailedethnicity16808 -> "1680-8"
    Detailedethnicity16816 -> "1681-6"
    Detailedethnicity16832 -> "1683-2"
    Detailedethnicity16857 -> "1685-7"
    Detailedethnicity16873 -> "1687-3"
    Detailedethnicity16881 -> "1688-1"
    Detailedethnicity16899 -> "1689-9"
    Detailedethnicity16907 -> "1690-7"
    Detailedethnicity16923 -> "1692-3"
    Detailedethnicity16949 -> "1694-9"
    Detailedethnicity16964 -> "1696-4"
    Detailedethnicity16972 -> "1697-2"
    Detailedethnicity16980 -> "1698-0"
    Detailedethnicity17004 -> "1700-4"
    Detailedethnicity17020 -> "1702-0"
    Detailedethnicity17046 -> "1704-6"
    Detailedethnicity17053 -> "1705-3"
    Detailedethnicity17079 -> "1707-9"
    Detailedethnicity17095 -> "1709-5"
    Detailedethnicity17111 -> "1711-1"
    Detailedethnicity17129 -> "1712-9"
    Detailedethnicity17137 -> "1713-7"
    Detailedethnicity17152 -> "1715-2"
    Detailedethnicity17178 -> "1717-8"
    Detailedethnicity17186 -> "1718-6"
    Detailedethnicity17194 -> "1719-4"
    Detailedethnicity17202 -> "1720-2"
    Detailedethnicity17228 -> "1722-8"
    Detailedethnicity17244 -> "1724-4"
    Detailedethnicity17251 -> "1725-1"
    Detailedethnicity17269 -> "1726-9"
    Detailedethnicity17277 -> "1727-7"
    Detailedethnicity17285 -> "1728-5"
    Detailedethnicity17293 -> "1729-3"
    Detailedethnicity17301 -> "1730-1"
    Detailedethnicity17319 -> "1731-9"
    Detailedethnicity17327 -> "1732-7"
    Detailedethnicity17335 -> "1733-5"
    Detailedethnicity17350 -> "1735-0"
    Detailedethnicity17376 -> "1737-6"
    Detailedethnicity17392 -> "1739-2"
    Detailedethnicity17400 -> "1740-0"
    Detailedethnicity17418 -> "1741-8"
    Detailedethnicity17426 -> "1742-6"
    Detailedethnicity17434 -> "1743-4"
    Detailedethnicity17442 -> "1744-2"
    Detailedethnicity17459 -> "1745-9"
    Detailedethnicity17467 -> "1746-7"
    Detailedethnicity17475 -> "1747-5"
    Detailedethnicity17483 -> "1748-3"
    Detailedethnicity17491 -> "1749-1"
    Detailedethnicity17509 -> "1750-9"
    Detailedethnicity17517 -> "1751-7"
    Detailedethnicity17525 -> "1752-5"
    Detailedethnicity17533 -> "1753-3"
    Detailedethnicity17541 -> "1754-1"
    Detailedethnicity17558 -> "1755-8"
    Detailedethnicity17566 -> "1756-6"
    Detailedethnicity17574 -> "1757-4"
    Detailedethnicity17582 -> "1758-2"
    Detailedethnicity17590 -> "1759-0"
    Detailedethnicity17608 -> "1760-8"
    Detailedethnicity17616 -> "1761-6"
    Detailedethnicity17624 -> "1762-4"
    Detailedethnicity17632 -> "1763-2"
    Detailedethnicity17640 -> "1764-0"
    Detailedethnicity17657 -> "1765-7"
    Detailedethnicity17665 -> "1766-5"
    Detailedethnicity17673 -> "1767-3"
    Detailedethnicity17681 -> "1768-1"
    Detailedethnicity17699 -> "1769-9"
    Detailedethnicity17707 -> "1770-7"
    Detailedethnicity17715 -> "1771-5"
    Detailedethnicity17723 -> "1772-3"
    Detailedethnicity17731 -> "1773-1"
    Detailedethnicity17749 -> "1774-9"
    Detailedethnicity17756 -> "1775-6"
    Detailedethnicity17764 -> "1776-4"
    Detailedethnicity17772 -> "1777-2"
    Detailedethnicity17780 -> "1778-0"
    Detailedethnicity17798 -> "1779-8"
    Detailedethnicity17806 -> "1780-6"
    Detailedethnicity17814 -> "1781-4"
    Detailedethnicity17822 -> "1782-2"
    Detailedethnicity17830 -> "1783-0"
    Detailedethnicity17848 -> "1784-8"
    Detailedethnicity17855 -> "1785-5"
    Detailedethnicity17863 -> "1786-3"
    Detailedethnicity17871 -> "1787-1"
    Detailedethnicity17889 -> "1788-9"
    Detailedethnicity17897 -> "1789-7"
    Detailedethnicity17905 -> "1790-5"
    Detailedethnicity17913 -> "1791-3"
    Detailedethnicity17921 -> "1792-1"
    Detailedethnicity17939 -> "1793-9"
    Detailedethnicity17947 -> "1794-7"
    Detailedethnicity17954 -> "1795-4"
    Detailedethnicity17962 -> "1796-2"
    Detailedethnicity17970 -> "1797-0"
    Detailedethnicity17988 -> "1798-8"
    Detailedethnicity17996 -> "1799-6"
    Detailedethnicity18002 -> "1800-2"
    Detailedethnicity18010 -> "1801-0"
    Detailedethnicity18028 -> "1802-8"
    Detailedethnicity18036 -> "1803-6"
    Detailedethnicity18044 -> "1804-4"
    Detailedethnicity18051 -> "1805-1"
    Detailedethnicity18069 -> "1806-9"
    Detailedethnicity18077 -> "1807-7"
    Detailedethnicity18085 -> "1808-5"
    Detailedethnicity18093 -> "1809-3"
    Detailedethnicity18119 -> "1811-9"
    Detailedethnicity18135 -> "1813-5"
    Detailedethnicity18143 -> "1814-3"
    Detailedethnicity18150 -> "1815-0"
    Detailedethnicity18168 -> "1816-8"
    Detailedethnicity18176 -> "1817-6"
    Detailedethnicity18184 -> "1818-4"
    Detailedethnicity18192 -> "1819-2"
    Detailedethnicity18200 -> "1820-0"
    Detailedethnicity18218 -> "1821-8"
    Detailedethnicity18226 -> "1822-6"
    Detailedethnicity18234 -> "1823-4"
    Detailedethnicity18242 -> "1824-2"
    Detailedethnicity18259 -> "1825-9"
    Detailedethnicity18267 -> "1826-7"
    Detailedethnicity18275 -> "1827-5"
    Detailedethnicity18283 -> "1828-3"
    Detailedethnicity18291 -> "1829-1"
    Detailedethnicity18309 -> "1830-9"
    Detailedethnicity18317 -> "1831-7"
    Detailedethnicity18325 -> "1832-5"
    Detailedethnicity18333 -> "1833-3"
    Detailedethnicity18341 -> "1834-1"
    Detailedethnicity18358 -> "1835-8"
    Detailedethnicity18374 -> "1837-4"
    Detailedethnicity18382 -> "1838-2"
    Detailedethnicity18408 -> "1840-8"
    Detailedethnicity18424 -> "1842-4"
    Detailedethnicity18440 -> "1844-0"
    Detailedethnicity18457 -> "1845-7"
    Detailedethnicity18465 -> "1846-5"
    Detailedethnicity18473 -> "1847-3"
    Detailedethnicity18481 -> "1848-1"
    Detailedethnicity18499 -> "1849-9"
    Detailedethnicity18507 -> "1850-7"
    Detailedethnicity18515 -> "1851-5"
    Detailedethnicity18523 -> "1852-3"
    Detailedethnicity18531 -> "1853-1"
    Detailedethnicity18549 -> "1854-9"
    Detailedethnicity18556 -> "1855-6"
    Detailedethnicity18564 -> "1856-4"
    Detailedethnicity18572 -> "1857-2"
    Detailedethnicity18580 -> "1858-0"
    Detailedethnicity18598 -> "1859-8"
    Detailedethnicity18606 -> "1860-6"
    Detailedethnicity18614 -> "1861-4"
    Detailedethnicity18622 -> "1862-2"
    Detailedethnicity18630 -> "1863-0"
    Detailedethnicity18648 -> "1864-8"
    Detailedethnicity18655 -> "1865-5"
    Detailedethnicity18663 -> "1866-3"
    Detailedethnicity18671 -> "1867-1"
    Detailedethnicity18689 -> "1868-9"
    Detailedethnicity18697 -> "1869-7"
    Detailedethnicity18705 -> "1870-5"
    Detailedethnicity18713 -> "1871-3"
    Detailedethnicity18721 -> "1872-1"
    Detailedethnicity18739 -> "1873-9"
    Detailedethnicity18747 -> "1874-7"
    Detailedethnicity18754 -> "1875-4"
    Detailedethnicity18762 -> "1876-2"
    Detailedethnicity18770 -> "1877-0"
    Detailedethnicity18788 -> "1878-8"
    Detailedethnicity18796 -> "1879-6"
    Detailedethnicity18804 -> "1880-4"
    Detailedethnicity18812 -> "1881-2"
    Detailedethnicity18820 -> "1882-0"
    Detailedethnicity18838 -> "1883-8"
    Detailedethnicity18846 -> "1884-6"
    Detailedethnicity18853 -> "1885-3"
    Detailedethnicity18861 -> "1886-1"
    Detailedethnicity18879 -> "1887-9"
    Detailedethnicity18887 -> "1888-7"
    Detailedethnicity18895 -> "1889-5"
    Detailedethnicity18911 -> "1891-1"
    Detailedethnicity18929 -> "1892-9"
    Detailedethnicity18937 -> "1893-7"
    Detailedethnicity18945 -> "1894-5"
    Detailedethnicity18960 -> "1896-0"
    Detailedethnicity18978 -> "1897-8"
    Detailedethnicity18986 -> "1898-6"
    Detailedethnicity18994 -> "1899-4"
    Detailedethnicity19000 -> "1900-0"
    Detailedethnicity19018 -> "1901-8"
    Detailedethnicity19026 -> "1902-6"
    Detailedethnicity19034 -> "1903-4"
    Detailedethnicity19042 -> "1904-2"
    Detailedethnicity19059 -> "1905-9"
    Detailedethnicity19067 -> "1906-7"
    Detailedethnicity19075 -> "1907-5"
    Detailedethnicity19083 -> "1908-3"
    Detailedethnicity19091 -> "1909-1"
    Detailedethnicity19109 -> "1910-9"
    Detailedethnicity19117 -> "1911-7"
    Detailedethnicity19125 -> "1912-5"
    Detailedethnicity19133 -> "1913-3"
    Detailedethnicity19141 -> "1914-1"
    Detailedethnicity19158 -> "1915-8"
    Detailedethnicity19166 -> "1916-6"
    Detailedethnicity19174 -> "1917-4"
    Detailedethnicity19182 -> "1918-2"
    Detailedethnicity19190 -> "1919-0"
    Detailedethnicity19208 -> "1920-8"
    Detailedethnicity19216 -> "1921-6"
    Detailedethnicity19224 -> "1922-4"
    Detailedethnicity19232 -> "1923-2"
    Detailedethnicity19240 -> "1924-0"
    Detailedethnicity19257 -> "1925-7"
    Detailedethnicity19265 -> "1926-5"
    Detailedethnicity19273 -> "1927-3"
    Detailedethnicity19281 -> "1928-1"
    Detailedethnicity19299 -> "1929-9"
    Detailedethnicity19307 -> "1930-7"
    Detailedethnicity19315 -> "1931-5"
    Detailedethnicity19323 -> "1932-3"
    Detailedethnicity19331 -> "1933-1"
    Detailedethnicity19349 -> "1934-9"
    Detailedethnicity19356 -> "1935-6"
    Detailedethnicity19364 -> "1936-4"
    Detailedethnicity19372 -> "1937-2"
    Detailedethnicity19380 -> "1938-0"
    Detailedethnicity19398 -> "1939-8"
    Detailedethnicity19406 -> "1940-6"
    Detailedethnicity19414 -> "1941-4"
    Detailedethnicity19422 -> "1942-2"
    Detailedethnicity19430 -> "1943-0"
    Detailedethnicity19448 -> "1944-8"
    Detailedethnicity19455 -> "1945-5"
    Detailedethnicity19463 -> "1946-3"
    Detailedethnicity19471 -> "1947-1"
    Detailedethnicity19489 -> "1948-9"
    Detailedethnicity19497 -> "1949-7"
    Detailedethnicity19505 -> "1950-5"
    Detailedethnicity19513 -> "1951-3"
    Detailedethnicity19521 -> "1952-1"
    Detailedethnicity19539 -> "1953-9"
    Detailedethnicity19547 -> "1954-7"
    Detailedethnicity19554 -> "1955-4"
    Detailedethnicity19562 -> "1956-2"
    Detailedethnicity19570 -> "1957-0"
    Detailedethnicity19588 -> "1958-8"
    Detailedethnicity19596 -> "1959-6"
    Detailedethnicity19604 -> "1960-4"
    Detailedethnicity19612 -> "1961-2"
    Detailedethnicity19620 -> "1962-0"
    Detailedethnicity19638 -> "1963-8"
    Detailedethnicity19646 -> "1964-6"
    Detailedethnicity19661 -> "1966-1"
    Detailedethnicity19687 -> "1968-7"
    Detailedethnicity19695 -> "1969-5"
    Detailedethnicity19703 -> "1970-3"
    Detailedethnicity19729 -> "1972-9"
    Detailedethnicity19737 -> "1973-7"
    Detailedethnicity19745 -> "1974-5"
    Detailedethnicity19752 -> "1975-2"
    Detailedethnicity19760 -> "1976-0"
    Detailedethnicity19778 -> "1977-8"
    Detailedethnicity19786 -> "1978-6"
    Detailedethnicity19794 -> "1979-4"
    Detailedethnicity19802 -> "1980-2"
    Detailedethnicity19810 -> "1981-0"
    Detailedethnicity19828 -> "1982-8"
    Detailedethnicity19844 -> "1984-4"
    Detailedethnicity19851 -> "1985-1"
    Detailedethnicity19869 -> "1986-9"
    Detailedethnicity19877 -> "1987-7"
    Detailedethnicity19885 -> "1988-5"
    Detailedethnicity19901 -> "1990-1"
    Detailedethnicity19927 -> "1992-7"
    Detailedethnicity19935 -> "1993-5"
    Detailedethnicity19943 -> "1994-3"
    Detailedethnicity19950 -> "1995-0"
    Detailedethnicity19968 -> "1996-8"
    Detailedethnicity19976 -> "1997-6"
    Detailedethnicity19984 -> "1998-4"
    Detailedethnicity19992 -> "1999-2"
    Detailedethnicity20008 -> "2000-8"
    Detailedethnicity20024 -> "2002-4"
    Detailedethnicity20040 -> "2004-0"
    Detailedethnicity20065 -> "2006-5"
    Detailedethnicity20073 -> "2007-3"
    Detailedethnicity20081 -> "2008-1"
    Detailedethnicity20099 -> "2009-9"
    Detailedethnicity20107 -> "2010-7"
    Detailedethnicity20115 -> "2011-5"
    Detailedethnicity20123 -> "2012-3"
    Detailedethnicity20131 -> "2013-1"
    Detailedethnicity20149 -> "2014-9"
    Detailedethnicity20156 -> "2015-6"
    Detailedethnicity20164 -> "2016-4"
    Detailedethnicity20172 -> "2017-2"
    Detailedethnicity20180 -> "2018-0"
    Detailedethnicity20198 -> "2019-8"
    Detailedethnicity20206 -> "2020-6"
    Detailedethnicity20214 -> "2021-4"
    Detailedethnicity20222 -> "2022-2"
    Detailedethnicity20230 -> "2023-0"
    Detailedethnicity20248 -> "2024-8"
    Detailedethnicity20255 -> "2025-5"
    Detailedethnicity20263 -> "2026-3"
    Detailedethnicity20289 -> "2028-9"
    Detailedethnicity20297 -> "2029-7"
    Detailedethnicity20305 -> "2030-5"
    Detailedethnicity20313 -> "2031-3"
    Detailedethnicity20321 -> "2032-1"
    Detailedethnicity20339 -> "2033-9"
    Detailedethnicity20347 -> "2034-7"
    Detailedethnicity20354 -> "2035-4"
    Detailedethnicity20362 -> "2036-2"
    Detailedethnicity20370 -> "2037-0"
    Detailedethnicity20388 -> "2038-8"
    Detailedethnicity20396 -> "2039-6"
    Detailedethnicity20404 -> "2040-4"
    Detailedethnicity20412 -> "2041-2"
    Detailedethnicity20420 -> "2042-0"
    Detailedethnicity20438 -> "2043-8"
    Detailedethnicity20446 -> "2044-6"
    Detailedethnicity20453 -> "2045-3"
    Detailedethnicity20461 -> "2046-1"
    Detailedethnicity20479 -> "2047-9"
    Detailedethnicity20487 -> "2048-7"
    Detailedethnicity20495 -> "2049-5"
    Detailedethnicity20503 -> "2050-3"
    Detailedethnicity20511 -> "2051-1"
    Detailedethnicity20529 -> "2052-9"
    Detailedethnicity20545 -> "2054-5"
    Detailedethnicity20560 -> "2056-0"
    Detailedethnicity20586 -> "2058-6"
    Detailedethnicity20602 -> "2060-2"
    Detailedethnicity20610 -> "2061-0"
    Detailedethnicity20628 -> "2062-8"
    Detailedethnicity20636 -> "2063-6"
    Detailedethnicity20644 -> "2064-4"
    Detailedethnicity20651 -> "2065-1"
    Detailedethnicity20669 -> "2066-9"
    Detailedethnicity20677 -> "2067-7"
    Detailedethnicity20685 -> "2068-5"
    Detailedethnicity20693 -> "2069-3"
    Detailedethnicity20701 -> "2070-1"
    Detailedethnicity20719 -> "2071-9"
    Detailedethnicity20727 -> "2072-7"
    Detailedethnicity20735 -> "2073-5"
    Detailedethnicity20743 -> "2074-3"
    Detailedethnicity20750 -> "2075-0"
    Detailedethnicity20768 -> "2076-8"
    Detailedethnicity20784 -> "2078-4"
    Detailedethnicity20792 -> "2079-2"
    Detailedethnicity20800 -> "2080-0"
    Detailedethnicity20818 -> "2081-8"
    Detailedethnicity20826 -> "2082-6"
    Detailedethnicity20834 -> "2083-4"
    Detailedethnicity20859 -> "2085-9"
    Detailedethnicity20867 -> "2086-7"
    Detailedethnicity20875 -> "2087-5"
    Detailedethnicity20883 -> "2088-3"
    Detailedethnicity20891 -> "2089-1"
    Detailedethnicity20909 -> "2090-9"
    Detailedethnicity20917 -> "2091-7"
    Detailedethnicity20925 -> "2092-5"
    Detailedethnicity20933 -> "2093-3"
    Detailedethnicity20941 -> "2094-1"
    Detailedethnicity20958 -> "2095-8"
    Detailedethnicity20966 -> "2096-6"
    Detailedethnicity20974 -> "2097-4"
    Detailedethnicity20982 -> "2098-2"
    Detailedethnicity21006 -> "2100-6"
    Detailedethnicity21014 -> "2101-4"
    Detailedethnicity21022 -> "2102-2"
    Detailedethnicity21030 -> "2103-0"
    Detailedethnicity21048 -> "2104-8"
    Detailedethnicity21063 -> "2106-3"
    Detailedethnicity21089 -> "2108-9"
    Detailedethnicity21097 -> "2109-7"
    Detailedethnicity21105 -> "2110-5"
    Detailedethnicity21113 -> "2111-3"
    Detailedethnicity21121 -> "2112-1"
    Detailedethnicity21139 -> "2113-9"
    Detailedethnicity21147 -> "2114-7"
    Detailedethnicity21154 -> "2115-4"
    Detailedethnicity21162 -> "2116-2"
    Detailedethnicity21188 -> "2118-8"
    Detailedethnicity21196 -> "2119-6"
    Detailedethnicity21204 -> "2120-4"
    Detailedethnicity21212 -> "2121-2"
    Detailedethnicity21220 -> "2122-0"
    Detailedethnicity21238 -> "2123-8"
    Detailedethnicity21246 -> "2124-6"
    Detailedethnicity21253 -> "2125-3"
    Detailedethnicity21261 -> "2126-1"
    Detailedethnicity21279 -> "2127-9"
    Detailedethnicity21295 -> "2129-5"
    Detailedethnicity21311 -> "2131-1"
    Detailedethnicity21337 -> "2133-7"
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
    Detailedethnicity25007 -> "2500-7"
    DetailedethnicityAsku -> "ASKU"
    DetailedethnicityOth -> "OTH"
    DetailedethnicityUnk -> "UNK"
  }
}

pub fn detailedethnicity_from_code_and_system(
  code code: String,
  system system: String,
) -> Result(Detailedethnicity, Nil) {
  case code, system {
    "1000-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10009)
    "1002-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10025)
    "1004-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10041)
    "1006-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10066)
    "1008-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10082)
    "1010-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10108)
    "1011-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10116)
    "1012-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10124)
    "1013-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10132)
    "1014-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10140)
    "1015-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10157)
    "1016-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10165)
    "1017-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10173)
    "1018-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10181)
    "1019-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10199)
    "1021-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10215)
    "1022-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10223)
    "1023-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10231)
    "1024-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10249)
    "1026-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10264)
    "1028-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10280)
    "1030-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10306)
    "1031-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10314)
    "1033-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10330)
    "1035-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10355)
    "1037-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10371)
    "1039-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10397)
    "1041-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10413)
    "1042-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10421)
    "1044-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10447)
    "1045-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10454)
    "1046-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10462)
    "1047-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10470)
    "1048-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10488)
    "1049-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10496)
    "1050-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10504)
    "1051-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10512)
    "1053-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10538)
    "1054-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10546)
    "1055-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10553)
    "1056-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10561)
    "1057-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10579)
    "1058-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10587)
    "1059-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10595)
    "1060-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10603)
    "1061-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10611)
    "1062-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10629)
    "1063-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10637)
    "1064-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10645)
    "1065-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10652)
    "1066-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10660)
    "1068-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10686)
    "1069-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10694)
    "1070-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10702)
    "1071-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10710)
    "1072-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10728)
    "1073-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10736)
    "1074-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10744)
    "1076-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10769)
    "1078-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10785)
    "1080-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10801)
    "1082-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10827)
    "1083-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10835)
    "1084-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10843)
    "1086-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10868)
    "1088-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10884)
    "1089-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10892)
    "1090-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10900)
    "1091-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10918)
    "1092-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10926)
    "1093-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10934)
    "1094-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10942)
    "1095-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10959)
    "1096-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10967)
    "1097-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10975)
    "1098-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity10983)
    "1100-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11007)
    "1102-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11023)
    "1103-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11031)
    "1104-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11049)
    "1106-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11064)
    "1108-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11080)
    "1109-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11098)
    "1110-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11106)
    "1112-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11122)
    "1114-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11148)
    "1115-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11155)
    "1116-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11163)
    "1117-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11171)
    "1118-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11189)
    "1119-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11197)
    "1120-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11205)
    "1121-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11213)
    "1123-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11239)
    "1124-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11247)
    "1125-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11254)
    "1126-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11262)
    "1127-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11270)
    "1128-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11288)
    "1129-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11296)
    "1130-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11304)
    "1131-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11312)
    "1132-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11320)
    "1133-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11338)
    "1134-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11346)
    "1135-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11353)
    "1136-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11361)
    "1137-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11379)
    "1138-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11387)
    "1139-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11395)
    "1140-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11403)
    "1141-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11411)
    "1142-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11429)
    "1143-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11437)
    "1144-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11445)
    "1145-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11452)
    "1146-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11460)
    "1147-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11478)
    "1148-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11486)
    "1150-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11502)
    "1151-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11510)
    "1153-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11536)
    "1155-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11551)
    "1156-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11569)
    "1157-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11577)
    "1158-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11585)
    "1159-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11593)
    "1160-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11601)
    "1162-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11627)
    "1163-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11635)
    "1165-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11650)
    "1167-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11676)
    "1169-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11692)
    "1171-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11718)
    "1173-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11734)
    "1175-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11759)
    "1176-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11767)
    "1178-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11783)
    "1180-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11809)
    "1182-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11825)
    "1184-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11841)
    "1186-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11866)
    "1187-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11874)
    "1189-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11890)
    "1191-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11916)
    "1193-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11932)
    "1194-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11940)
    "1195-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11957)
    "1196-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11965)
    "1197-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11973)
    "1198-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11981)
    "1199-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity11999)
    "1200-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12005)
    "1201-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12013)
    "1202-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12021)
    "1203-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12039)
    "1204-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12047)
    "1205-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12054)
    "1207-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12070)
    "1209-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12096)
    "1211-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12112)
    "1212-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12120)
    "1214-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12146)
    "1215-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12153)
    "1216-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12161)
    "1217-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12179)
    "1218-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12187)
    "1219-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12195)
    "1220-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12203)
    "1222-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12229)
    "1223-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12237)
    "1224-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12245)
    "1225-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12252)
    "1226-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12260)
    "1227-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12278)
    "1228-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12286)
    "1229-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12294)
    "1230-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12302)
    "1231-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12310)
    "1233-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12336)
    "1234-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12344)
    "1235-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12351)
    "1236-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12369)
    "1237-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12377)
    "1238-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12385)
    "1239-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12393)
    "1240-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12401)
    "1241-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12419)
    "1242-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12427)
    "1243-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12435)
    "1244-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12443)
    "1245-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12450)
    "1246-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12468)
    "1247-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12476)
    "1248-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12484)
    "1250-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12500)
    "1252-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12526)
    "1254-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12542)
    "1256-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12567)
    "1258-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12583)
    "1260-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12609)
    "1262-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12625)
    "1264-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12641)
    "1265-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12658)
    "1267-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12674)
    "1269-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12690)
    "1271-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12716)
    "1272-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12724)
    "1273-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12732)
    "1275-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12757)
    "1277-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12773)
    "1279-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12799)
    "1281-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12815)
    "1282-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12823)
    "1283-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12831)
    "1285-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12856)
    "1286-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12864)
    "1287-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12872)
    "1288-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12880)
    "1289-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12898)
    "1290-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12906)
    "1291-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12914)
    "1292-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12922)
    "1293-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12930)
    "1294-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12948)
    "1295-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12955)
    "1297-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12971)
    "1299-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity12997)
    "1301-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13011)
    "1303-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13037)
    "1305-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13052)
    "1306-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13060)
    "1307-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13078)
    "1309-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13094)
    "1310-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13102)
    "1312-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13128)
    "1313-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13136)
    "1314-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13144)
    "1315-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13151)
    "1317-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13177)
    "1319-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13193)
    "1321-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13219)
    "1323-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13235)
    "1325-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13250)
    "1326-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13268)
    "1327-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13276)
    "1328-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13284)
    "1329-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13292)
    "1331-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13318)
    "1332-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13326)
    "1333-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13334)
    "1334-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13342)
    "1335-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13359)
    "1336-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13367)
    "1337-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13375)
    "1338-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13383)
    "1340-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13409)
    "1342-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13425)
    "1344-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13441)
    "1345-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13458)
    "1346-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13466)
    "1348-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13482)
    "1350-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13508)
    "1352-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13524)
    "1354-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13540)
    "1356-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13565)
    "1358-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13581)
    "1359-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13599)
    "1360-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13607)
    "1361-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13615)
    "1363-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13631)
    "1365-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13656)
    "1366-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13664)
    "1368-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13680)
    "1370-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13706)
    "1372-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13722)
    "1374-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13748)
    "1376-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13763)
    "1378-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13789)
    "1380-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13805)
    "1382-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13821)
    "1383-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13839)
    "1384-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13847)
    "1385-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13854)
    "1387-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13870)
    "1389-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13896)
    "1391-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13912)
    "1392-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13920)
    "1393-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13938)
    "1394-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13946)
    "1395-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13953)
    "1396-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13961)
    "1397-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13979)
    "1398-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13987)
    "1399-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity13995)
    "1400-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14001)
    "1401-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14019)
    "1403-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14035)
    "1405-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14050)
    "1407-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14076)
    "1409-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14092)
    "1411-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14118)
    "1412-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14126)
    "1413-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14134)
    "1414-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14142)
    "1416-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14167)
    "1417-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14175)
    "1418-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14183)
    "1419-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14191)
    "1420-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14209)
    "1421-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14217)
    "1422-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14225)
    "1423-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14233)
    "1424-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14241)
    "1425-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14258)
    "1426-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14266)
    "1427-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14274)
    "1428-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14282)
    "1429-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14290)
    "1430-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14308)
    "1431-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14316)
    "1432-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14324)
    "1433-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14332)
    "1434-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14340)
    "1435-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14357)
    "1436-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14365)
    "1437-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14373)
    "1439-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14399)
    "1441-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14415)
    "1442-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14423)
    "1443-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14431)
    "1445-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14456)
    "1446-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14464)
    "1448-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14480)
    "1450-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14506)
    "1451-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14514)
    "1453-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14530)
    "1454-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14548)
    "1456-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14563)
    "1457-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14571)
    "1458-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14589)
    "1460-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14605)
    "1462-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14621)
    "1464-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14647)
    "1465-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14654)
    "1466-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14662)
    "1467-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14670)
    "1468-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14688)
    "1469-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14696)
    "1470-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14704)
    "1471-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14712)
    "1472-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14720)
    "1474-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14746)
    "1475-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14753)
    "1476-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14761)
    "1478-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14787)
    "1479-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14795)
    "1480-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14803)
    "1481-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14811)
    "1482-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14829)
    "1483-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14837)
    "1484-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14845)
    "1485-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14852)
    "1487-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14878)
    "1489-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14894)
    "1490-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14902)
    "1491-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14910)
    "1492-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14928)
    "1493-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14936)
    "1494-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14944)
    "1495-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14951)
    "1496-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14969)
    "1497-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14977)
    "1498-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14985)
    "1499-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity14993)
    "1500-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15008)
    "1501-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15016)
    "1502-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15024)
    "1503-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15032)
    "1504-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15040)
    "1505-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15057)
    "1506-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15065)
    "1507-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15073)
    "1508-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15081)
    "1509-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15099)
    "1510-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15107)
    "1511-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15115)
    "1512-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15123)
    "1513-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15131)
    "1514-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15149)
    "1515-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15156)
    "1516-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15164)
    "1518-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15180)
    "1519-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15198)
    "1520-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15206)
    "1521-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15214)
    "1522-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15222)
    "1523-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15230)
    "1524-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15248)
    "1525-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15255)
    "1526-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15263)
    "1527-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15271)
    "1528-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15289)
    "1529-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15297)
    "1530-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15305)
    "1531-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15313)
    "1532-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15321)
    "1533-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15339)
    "1534-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15347)
    "1535-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15354)
    "1536-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15362)
    "1537-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15370)
    "1538-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15388)
    "1539-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15396)
    "1541-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15412)
    "1543-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15438)
    "1545-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15453)
    "1547-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15479)
    "1549-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15495)
    "1551-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15511)
    "1552-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15529)
    "1553-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15537)
    "1554-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15545)
    "1556-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15560)
    "1558-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15586)
    "1560-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15602)
    "1562-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15628)
    "1564-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15644)
    "1566-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15669)
    "1567-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15677)
    "1568-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15685)
    "1569-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15693)
    "1570-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15701)
    "1571-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15719)
    "1573-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15735)
    "1574-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15743)
    "1576-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15768)
    "1578-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15784)
    "1579-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15792)
    "1580-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15800)
    "1582-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15826)
    "1584-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15842)
    "1586-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15867)
    "1587-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15875)
    "1588-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15883)
    "1589-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15891)
    "1590-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15909)
    "1591-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15917)
    "1592-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15925)
    "1593-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15933)
    "1594-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15941)
    "1595-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15958)
    "1596-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15966)
    "1597-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15974)
    "1598-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15982)
    "1599-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity15990)
    "1600-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16006)
    "1602-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16022)
    "1603-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16030)
    "1604-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16048)
    "1605-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16055)
    "1607-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16071)
    "1609-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16097)
    "1610-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16105)
    "1611-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16113)
    "1612-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16121)
    "1613-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16139)
    "1614-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16147)
    "1615-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16154)
    "1616-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16162)
    "1617-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16170)
    "1618-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16188)
    "1619-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16196)
    "1620-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16204)
    "1621-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16212)
    "1622-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16220)
    "1623-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16238)
    "1624-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16246)
    "1625-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16253)
    "1626-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16261)
    "1627-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16279)
    "1628-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16287)
    "1629-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16295)
    "1630-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16303)
    "1631-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16311)
    "1632-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16329)
    "1633-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16337)
    "1634-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16345)
    "1635-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16352)
    "1636-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16360)
    "1637-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16378)
    "1638-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16386)
    "1639-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16394)
    "1640-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16402)
    "1641-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16410)
    "1643-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16436)
    "1645-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16451)
    "1647-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16477)
    "1649-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16493)
    "1651-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16519)
    "1653-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16535)
    "1654-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16543)
    "1655-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16550)
    "1656-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16568)
    "1657-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16576)
    "1659-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16592)
    "1661-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16618)
    "1663-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16634)
    "1665-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16659)
    "1667-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16675)
    "1668-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16683)
    "1670-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16709)
    "1671-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16717)
    "1672-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16725)
    "1673-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16733)
    "1675-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16758)
    "1677-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16774)
    "1679-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16790)
    "1680-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16808)
    "1681-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16816)
    "1683-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16832)
    "1685-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16857)
    "1687-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16873)
    "1688-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16881)
    "1689-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16899)
    "1690-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16907)
    "1692-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16923)
    "1694-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16949)
    "1696-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16964)
    "1697-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16972)
    "1698-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity16980)
    "1700-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17004)
    "1702-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17020)
    "1704-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17046)
    "1705-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17053)
    "1707-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17079)
    "1709-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17095)
    "1711-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17111)
    "1712-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17129)
    "1713-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17137)
    "1715-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17152)
    "1717-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17178)
    "1718-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17186)
    "1719-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17194)
    "1720-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17202)
    "1722-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17228)
    "1724-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17244)
    "1725-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17251)
    "1726-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17269)
    "1727-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17277)
    "1728-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17285)
    "1729-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17293)
    "1730-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17301)
    "1731-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17319)
    "1732-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17327)
    "1733-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17335)
    "1735-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17350)
    "1737-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17376)
    "1739-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17392)
    "1740-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17400)
    "1741-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17418)
    "1742-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17426)
    "1743-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17434)
    "1744-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17442)
    "1745-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17459)
    "1746-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17467)
    "1747-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17475)
    "1748-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17483)
    "1749-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17491)
    "1750-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17509)
    "1751-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17517)
    "1752-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17525)
    "1753-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17533)
    "1754-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17541)
    "1755-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17558)
    "1756-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17566)
    "1757-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17574)
    "1758-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17582)
    "1759-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17590)
    "1760-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17608)
    "1761-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17616)
    "1762-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17624)
    "1763-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17632)
    "1764-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17640)
    "1765-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17657)
    "1766-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17665)
    "1767-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17673)
    "1768-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17681)
    "1769-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17699)
    "1770-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17707)
    "1771-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17715)
    "1772-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17723)
    "1773-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17731)
    "1774-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17749)
    "1775-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17756)
    "1776-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17764)
    "1777-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17772)
    "1778-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17780)
    "1779-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17798)
    "1780-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17806)
    "1781-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17814)
    "1782-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17822)
    "1783-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17830)
    "1784-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17848)
    "1785-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17855)
    "1786-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17863)
    "1787-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17871)
    "1788-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17889)
    "1789-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17897)
    "1790-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17905)
    "1791-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17913)
    "1792-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17921)
    "1793-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17939)
    "1794-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17947)
    "1795-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17954)
    "1796-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17962)
    "1797-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17970)
    "1798-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17988)
    "1799-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity17996)
    "1800-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18002)
    "1801-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18010)
    "1802-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18028)
    "1803-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18036)
    "1804-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18044)
    "1805-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18051)
    "1806-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18069)
    "1807-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18077)
    "1808-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18085)
    "1809-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18093)
    "1811-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18119)
    "1813-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18135)
    "1814-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18143)
    "1815-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18150)
    "1816-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18168)
    "1817-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18176)
    "1818-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18184)
    "1819-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18192)
    "1820-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18200)
    "1821-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18218)
    "1822-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18226)
    "1823-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18234)
    "1824-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18242)
    "1825-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18259)
    "1826-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18267)
    "1827-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18275)
    "1828-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18283)
    "1829-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18291)
    "1830-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18309)
    "1831-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18317)
    "1832-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18325)
    "1833-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18333)
    "1834-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18341)
    "1835-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18358)
    "1837-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18374)
    "1838-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18382)
    "1840-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18408)
    "1842-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18424)
    "1844-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18440)
    "1845-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18457)
    "1846-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18465)
    "1847-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18473)
    "1848-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18481)
    "1849-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18499)
    "1850-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18507)
    "1851-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18515)
    "1852-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18523)
    "1853-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18531)
    "1854-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18549)
    "1855-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18556)
    "1856-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18564)
    "1857-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18572)
    "1858-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18580)
    "1859-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18598)
    "1860-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18606)
    "1861-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18614)
    "1862-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18622)
    "1863-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18630)
    "1864-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18648)
    "1865-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18655)
    "1866-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18663)
    "1867-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18671)
    "1868-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18689)
    "1869-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18697)
    "1870-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18705)
    "1871-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18713)
    "1872-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18721)
    "1873-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18739)
    "1874-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18747)
    "1875-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18754)
    "1876-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18762)
    "1877-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18770)
    "1878-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18788)
    "1879-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18796)
    "1880-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18804)
    "1881-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18812)
    "1882-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18820)
    "1883-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18838)
    "1884-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18846)
    "1885-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18853)
    "1886-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18861)
    "1887-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18879)
    "1888-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18887)
    "1889-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18895)
    "1891-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18911)
    "1892-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18929)
    "1893-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18937)
    "1894-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18945)
    "1896-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18960)
    "1897-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18978)
    "1898-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18986)
    "1899-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity18994)
    "1900-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19000)
    "1901-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19018)
    "1902-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19026)
    "1903-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19034)
    "1904-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19042)
    "1905-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19059)
    "1906-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19067)
    "1907-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19075)
    "1908-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19083)
    "1909-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19091)
    "1910-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19109)
    "1911-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19117)
    "1912-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19125)
    "1913-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19133)
    "1914-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19141)
    "1915-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19158)
    "1916-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19166)
    "1917-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19174)
    "1918-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19182)
    "1919-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19190)
    "1920-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19208)
    "1921-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19216)
    "1922-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19224)
    "1923-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19232)
    "1924-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19240)
    "1925-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19257)
    "1926-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19265)
    "1927-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19273)
    "1928-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19281)
    "1929-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19299)
    "1930-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19307)
    "1931-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19315)
    "1932-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19323)
    "1933-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19331)
    "1934-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19349)
    "1935-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19356)
    "1936-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19364)
    "1937-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19372)
    "1938-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19380)
    "1939-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19398)
    "1940-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19406)
    "1941-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19414)
    "1942-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19422)
    "1943-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19430)
    "1944-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19448)
    "1945-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19455)
    "1946-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19463)
    "1947-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19471)
    "1948-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19489)
    "1949-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19497)
    "1950-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19505)
    "1951-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19513)
    "1952-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19521)
    "1953-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19539)
    "1954-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19547)
    "1955-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19554)
    "1956-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19562)
    "1957-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19570)
    "1958-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19588)
    "1959-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19596)
    "1960-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19604)
    "1961-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19612)
    "1962-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19620)
    "1963-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19638)
    "1964-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19646)
    "1966-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19661)
    "1968-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19687)
    "1969-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19695)
    "1970-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19703)
    "1972-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19729)
    "1973-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19737)
    "1974-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19745)
    "1975-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19752)
    "1976-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19760)
    "1977-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19778)
    "1978-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19786)
    "1979-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19794)
    "1980-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19802)
    "1981-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19810)
    "1982-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19828)
    "1984-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19844)
    "1985-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19851)
    "1986-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19869)
    "1987-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19877)
    "1988-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19885)
    "1990-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19901)
    "1992-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19927)
    "1993-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19935)
    "1994-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19943)
    "1995-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19950)
    "1996-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19968)
    "1997-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19976)
    "1998-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19984)
    "1999-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity19992)
    "2000-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20008)
    "2002-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20024)
    "2004-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20040)
    "2006-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20065)
    "2007-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20073)
    "2008-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20081)
    "2009-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20099)
    "2010-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20107)
    "2011-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20115)
    "2012-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20123)
    "2013-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20131)
    "2014-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20149)
    "2015-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20156)
    "2016-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20164)
    "2017-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20172)
    "2018-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20180)
    "2019-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20198)
    "2020-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20206)
    "2021-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20214)
    "2022-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20222)
    "2023-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20230)
    "2024-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20248)
    "2025-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20255)
    "2026-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20263)
    "2028-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20289)
    "2029-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20297)
    "2030-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20305)
    "2031-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20313)
    "2032-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20321)
    "2033-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20339)
    "2034-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20347)
    "2035-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20354)
    "2036-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20362)
    "2037-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20370)
    "2038-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20388)
    "2039-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20396)
    "2040-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20404)
    "2041-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20412)
    "2042-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20420)
    "2043-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20438)
    "2044-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20446)
    "2045-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20453)
    "2046-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20461)
    "2047-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20479)
    "2048-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20487)
    "2049-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20495)
    "2050-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20503)
    "2051-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20511)
    "2052-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20529)
    "2054-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20545)
    "2056-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20560)
    "2058-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20586)
    "2060-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20602)
    "2061-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20610)
    "2062-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20628)
    "2063-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20636)
    "2064-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20644)
    "2065-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20651)
    "2066-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20669)
    "2067-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20677)
    "2068-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20685)
    "2069-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20693)
    "2070-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20701)
    "2071-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20719)
    "2072-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20727)
    "2073-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20735)
    "2074-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20743)
    "2075-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20750)
    "2076-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20768)
    "2078-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20784)
    "2079-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20792)
    "2080-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20800)
    "2081-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20818)
    "2082-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20826)
    "2083-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20834)
    "2085-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20859)
    "2086-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20867)
    "2087-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20875)
    "2088-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20883)
    "2089-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20891)
    "2090-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20909)
    "2091-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20917)
    "2092-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20925)
    "2093-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20933)
    "2094-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20941)
    "2095-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20958)
    "2096-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20966)
    "2097-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20974)
    "2098-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity20982)
    "2100-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21006)
    "2101-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21014)
    "2102-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21022)
    "2103-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21030)
    "2104-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21048)
    "2106-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21063)
    "2108-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21089)
    "2109-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21097)
    "2110-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21105)
    "2111-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21113)
    "2112-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21121)
    "2113-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21139)
    "2114-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21147)
    "2115-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21154)
    "2116-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21162)
    "2118-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21188)
    "2119-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21196)
    "2120-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21204)
    "2121-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21212)
    "2122-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21220)
    "2123-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21238)
    "2124-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21246)
    "2125-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21253)
    "2126-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21261)
    "2127-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21279)
    "2129-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21295)
    "2131-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21311)
    "2133-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21337)
    "2135-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21352)
    "2137-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21378)
    "2138-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21386)
    "2139-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21394)
    "2140-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21402)
    "2141-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21410)
    "2142-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21428)
    "2143-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21436)
    "2144-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21444)
    "2145-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21451)
    "2146-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21469)
    "2148-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21485)
    "2149-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21493)
    "2150-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21501)
    "2151-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21519)
    "2152-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21527)
    "2153-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21535)
    "2155-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21550)
    "2156-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21568)
    "2157-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21576)
    "2158-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21584)
    "2159-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21592)
    "2160-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21600)
    "2161-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21618)
    "2162-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21626)
    "2163-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21634)
    "2165-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21659)
    "2166-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21667)
    "2167-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21675)
    "2168-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21683)
    "2169-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21691)
    "2170-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21709)
    "2171-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21717)
    "2172-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21725)
    "2173-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21733)
    "2174-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21741)
    "2175-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21758)
    "2176-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21766)
    "2178-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21782)
    "2180-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21808)
    "2182-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21824)
    "2184-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21840)
    "2186-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity21865)
    "2500-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedethnicity25007)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(DetailedethnicityAsku)
    "OTH", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(DetailedethnicityOth)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(DetailedethnicityUnk)
    _, _ -> Error(Nil)
  }
}

pub fn detailedethnicity_decoder() -> Decoder(Detailedethnicity) {
  use variant <- decode.then(decode.string)
  case variant {
    "1000-9" -> decode.success(Detailedethnicity10009)
    "1002-5" -> decode.success(Detailedethnicity10025)
    "1004-1" -> decode.success(Detailedethnicity10041)
    "1006-6" -> decode.success(Detailedethnicity10066)
    "1008-2" -> decode.success(Detailedethnicity10082)
    "1010-8" -> decode.success(Detailedethnicity10108)
    "1011-6" -> decode.success(Detailedethnicity10116)
    "1012-4" -> decode.success(Detailedethnicity10124)
    "1013-2" -> decode.success(Detailedethnicity10132)
    "1014-0" -> decode.success(Detailedethnicity10140)
    "1015-7" -> decode.success(Detailedethnicity10157)
    "1016-5" -> decode.success(Detailedethnicity10165)
    "1017-3" -> decode.success(Detailedethnicity10173)
    "1018-1" -> decode.success(Detailedethnicity10181)
    "1019-9" -> decode.success(Detailedethnicity10199)
    "1021-5" -> decode.success(Detailedethnicity10215)
    "1022-3" -> decode.success(Detailedethnicity10223)
    "1023-1" -> decode.success(Detailedethnicity10231)
    "1024-9" -> decode.success(Detailedethnicity10249)
    "1026-4" -> decode.success(Detailedethnicity10264)
    "1028-0" -> decode.success(Detailedethnicity10280)
    "1030-6" -> decode.success(Detailedethnicity10306)
    "1031-4" -> decode.success(Detailedethnicity10314)
    "1033-0" -> decode.success(Detailedethnicity10330)
    "1035-5" -> decode.success(Detailedethnicity10355)
    "1037-1" -> decode.success(Detailedethnicity10371)
    "1039-7" -> decode.success(Detailedethnicity10397)
    "1041-3" -> decode.success(Detailedethnicity10413)
    "1042-1" -> decode.success(Detailedethnicity10421)
    "1044-7" -> decode.success(Detailedethnicity10447)
    "1045-4" -> decode.success(Detailedethnicity10454)
    "1046-2" -> decode.success(Detailedethnicity10462)
    "1047-0" -> decode.success(Detailedethnicity10470)
    "1048-8" -> decode.success(Detailedethnicity10488)
    "1049-6" -> decode.success(Detailedethnicity10496)
    "1050-4" -> decode.success(Detailedethnicity10504)
    "1051-2" -> decode.success(Detailedethnicity10512)
    "1053-8" -> decode.success(Detailedethnicity10538)
    "1054-6" -> decode.success(Detailedethnicity10546)
    "1055-3" -> decode.success(Detailedethnicity10553)
    "1056-1" -> decode.success(Detailedethnicity10561)
    "1057-9" -> decode.success(Detailedethnicity10579)
    "1058-7" -> decode.success(Detailedethnicity10587)
    "1059-5" -> decode.success(Detailedethnicity10595)
    "1060-3" -> decode.success(Detailedethnicity10603)
    "1061-1" -> decode.success(Detailedethnicity10611)
    "1062-9" -> decode.success(Detailedethnicity10629)
    "1063-7" -> decode.success(Detailedethnicity10637)
    "1064-5" -> decode.success(Detailedethnicity10645)
    "1065-2" -> decode.success(Detailedethnicity10652)
    "1066-0" -> decode.success(Detailedethnicity10660)
    "1068-6" -> decode.success(Detailedethnicity10686)
    "1069-4" -> decode.success(Detailedethnicity10694)
    "1070-2" -> decode.success(Detailedethnicity10702)
    "1071-0" -> decode.success(Detailedethnicity10710)
    "1072-8" -> decode.success(Detailedethnicity10728)
    "1073-6" -> decode.success(Detailedethnicity10736)
    "1074-4" -> decode.success(Detailedethnicity10744)
    "1076-9" -> decode.success(Detailedethnicity10769)
    "1078-5" -> decode.success(Detailedethnicity10785)
    "1080-1" -> decode.success(Detailedethnicity10801)
    "1082-7" -> decode.success(Detailedethnicity10827)
    "1083-5" -> decode.success(Detailedethnicity10835)
    "1084-3" -> decode.success(Detailedethnicity10843)
    "1086-8" -> decode.success(Detailedethnicity10868)
    "1088-4" -> decode.success(Detailedethnicity10884)
    "1089-2" -> decode.success(Detailedethnicity10892)
    "1090-0" -> decode.success(Detailedethnicity10900)
    "1091-8" -> decode.success(Detailedethnicity10918)
    "1092-6" -> decode.success(Detailedethnicity10926)
    "1093-4" -> decode.success(Detailedethnicity10934)
    "1094-2" -> decode.success(Detailedethnicity10942)
    "1095-9" -> decode.success(Detailedethnicity10959)
    "1096-7" -> decode.success(Detailedethnicity10967)
    "1097-5" -> decode.success(Detailedethnicity10975)
    "1098-3" -> decode.success(Detailedethnicity10983)
    "1100-7" -> decode.success(Detailedethnicity11007)
    "1102-3" -> decode.success(Detailedethnicity11023)
    "1103-1" -> decode.success(Detailedethnicity11031)
    "1104-9" -> decode.success(Detailedethnicity11049)
    "1106-4" -> decode.success(Detailedethnicity11064)
    "1108-0" -> decode.success(Detailedethnicity11080)
    "1109-8" -> decode.success(Detailedethnicity11098)
    "1110-6" -> decode.success(Detailedethnicity11106)
    "1112-2" -> decode.success(Detailedethnicity11122)
    "1114-8" -> decode.success(Detailedethnicity11148)
    "1115-5" -> decode.success(Detailedethnicity11155)
    "1116-3" -> decode.success(Detailedethnicity11163)
    "1117-1" -> decode.success(Detailedethnicity11171)
    "1118-9" -> decode.success(Detailedethnicity11189)
    "1119-7" -> decode.success(Detailedethnicity11197)
    "1120-5" -> decode.success(Detailedethnicity11205)
    "1121-3" -> decode.success(Detailedethnicity11213)
    "1123-9" -> decode.success(Detailedethnicity11239)
    "1124-7" -> decode.success(Detailedethnicity11247)
    "1125-4" -> decode.success(Detailedethnicity11254)
    "1126-2" -> decode.success(Detailedethnicity11262)
    "1127-0" -> decode.success(Detailedethnicity11270)
    "1128-8" -> decode.success(Detailedethnicity11288)
    "1129-6" -> decode.success(Detailedethnicity11296)
    "1130-4" -> decode.success(Detailedethnicity11304)
    "1131-2" -> decode.success(Detailedethnicity11312)
    "1132-0" -> decode.success(Detailedethnicity11320)
    "1133-8" -> decode.success(Detailedethnicity11338)
    "1134-6" -> decode.success(Detailedethnicity11346)
    "1135-3" -> decode.success(Detailedethnicity11353)
    "1136-1" -> decode.success(Detailedethnicity11361)
    "1137-9" -> decode.success(Detailedethnicity11379)
    "1138-7" -> decode.success(Detailedethnicity11387)
    "1139-5" -> decode.success(Detailedethnicity11395)
    "1140-3" -> decode.success(Detailedethnicity11403)
    "1141-1" -> decode.success(Detailedethnicity11411)
    "1142-9" -> decode.success(Detailedethnicity11429)
    "1143-7" -> decode.success(Detailedethnicity11437)
    "1144-5" -> decode.success(Detailedethnicity11445)
    "1145-2" -> decode.success(Detailedethnicity11452)
    "1146-0" -> decode.success(Detailedethnicity11460)
    "1147-8" -> decode.success(Detailedethnicity11478)
    "1148-6" -> decode.success(Detailedethnicity11486)
    "1150-2" -> decode.success(Detailedethnicity11502)
    "1151-0" -> decode.success(Detailedethnicity11510)
    "1153-6" -> decode.success(Detailedethnicity11536)
    "1155-1" -> decode.success(Detailedethnicity11551)
    "1156-9" -> decode.success(Detailedethnicity11569)
    "1157-7" -> decode.success(Detailedethnicity11577)
    "1158-5" -> decode.success(Detailedethnicity11585)
    "1159-3" -> decode.success(Detailedethnicity11593)
    "1160-1" -> decode.success(Detailedethnicity11601)
    "1162-7" -> decode.success(Detailedethnicity11627)
    "1163-5" -> decode.success(Detailedethnicity11635)
    "1165-0" -> decode.success(Detailedethnicity11650)
    "1167-6" -> decode.success(Detailedethnicity11676)
    "1169-2" -> decode.success(Detailedethnicity11692)
    "1171-8" -> decode.success(Detailedethnicity11718)
    "1173-4" -> decode.success(Detailedethnicity11734)
    "1175-9" -> decode.success(Detailedethnicity11759)
    "1176-7" -> decode.success(Detailedethnicity11767)
    "1178-3" -> decode.success(Detailedethnicity11783)
    "1180-9" -> decode.success(Detailedethnicity11809)
    "1182-5" -> decode.success(Detailedethnicity11825)
    "1184-1" -> decode.success(Detailedethnicity11841)
    "1186-6" -> decode.success(Detailedethnicity11866)
    "1187-4" -> decode.success(Detailedethnicity11874)
    "1189-0" -> decode.success(Detailedethnicity11890)
    "1191-6" -> decode.success(Detailedethnicity11916)
    "1193-2" -> decode.success(Detailedethnicity11932)
    "1194-0" -> decode.success(Detailedethnicity11940)
    "1195-7" -> decode.success(Detailedethnicity11957)
    "1196-5" -> decode.success(Detailedethnicity11965)
    "1197-3" -> decode.success(Detailedethnicity11973)
    "1198-1" -> decode.success(Detailedethnicity11981)
    "1199-9" -> decode.success(Detailedethnicity11999)
    "1200-5" -> decode.success(Detailedethnicity12005)
    "1201-3" -> decode.success(Detailedethnicity12013)
    "1202-1" -> decode.success(Detailedethnicity12021)
    "1203-9" -> decode.success(Detailedethnicity12039)
    "1204-7" -> decode.success(Detailedethnicity12047)
    "1205-4" -> decode.success(Detailedethnicity12054)
    "1207-0" -> decode.success(Detailedethnicity12070)
    "1209-6" -> decode.success(Detailedethnicity12096)
    "1211-2" -> decode.success(Detailedethnicity12112)
    "1212-0" -> decode.success(Detailedethnicity12120)
    "1214-6" -> decode.success(Detailedethnicity12146)
    "1215-3" -> decode.success(Detailedethnicity12153)
    "1216-1" -> decode.success(Detailedethnicity12161)
    "1217-9" -> decode.success(Detailedethnicity12179)
    "1218-7" -> decode.success(Detailedethnicity12187)
    "1219-5" -> decode.success(Detailedethnicity12195)
    "1220-3" -> decode.success(Detailedethnicity12203)
    "1222-9" -> decode.success(Detailedethnicity12229)
    "1223-7" -> decode.success(Detailedethnicity12237)
    "1224-5" -> decode.success(Detailedethnicity12245)
    "1225-2" -> decode.success(Detailedethnicity12252)
    "1226-0" -> decode.success(Detailedethnicity12260)
    "1227-8" -> decode.success(Detailedethnicity12278)
    "1228-6" -> decode.success(Detailedethnicity12286)
    "1229-4" -> decode.success(Detailedethnicity12294)
    "1230-2" -> decode.success(Detailedethnicity12302)
    "1231-0" -> decode.success(Detailedethnicity12310)
    "1233-6" -> decode.success(Detailedethnicity12336)
    "1234-4" -> decode.success(Detailedethnicity12344)
    "1235-1" -> decode.success(Detailedethnicity12351)
    "1236-9" -> decode.success(Detailedethnicity12369)
    "1237-7" -> decode.success(Detailedethnicity12377)
    "1238-5" -> decode.success(Detailedethnicity12385)
    "1239-3" -> decode.success(Detailedethnicity12393)
    "1240-1" -> decode.success(Detailedethnicity12401)
    "1241-9" -> decode.success(Detailedethnicity12419)
    "1242-7" -> decode.success(Detailedethnicity12427)
    "1243-5" -> decode.success(Detailedethnicity12435)
    "1244-3" -> decode.success(Detailedethnicity12443)
    "1245-0" -> decode.success(Detailedethnicity12450)
    "1246-8" -> decode.success(Detailedethnicity12468)
    "1247-6" -> decode.success(Detailedethnicity12476)
    "1248-4" -> decode.success(Detailedethnicity12484)
    "1250-0" -> decode.success(Detailedethnicity12500)
    "1252-6" -> decode.success(Detailedethnicity12526)
    "1254-2" -> decode.success(Detailedethnicity12542)
    "1256-7" -> decode.success(Detailedethnicity12567)
    "1258-3" -> decode.success(Detailedethnicity12583)
    "1260-9" -> decode.success(Detailedethnicity12609)
    "1262-5" -> decode.success(Detailedethnicity12625)
    "1264-1" -> decode.success(Detailedethnicity12641)
    "1265-8" -> decode.success(Detailedethnicity12658)
    "1267-4" -> decode.success(Detailedethnicity12674)
    "1269-0" -> decode.success(Detailedethnicity12690)
    "1271-6" -> decode.success(Detailedethnicity12716)
    "1272-4" -> decode.success(Detailedethnicity12724)
    "1273-2" -> decode.success(Detailedethnicity12732)
    "1275-7" -> decode.success(Detailedethnicity12757)
    "1277-3" -> decode.success(Detailedethnicity12773)
    "1279-9" -> decode.success(Detailedethnicity12799)
    "1281-5" -> decode.success(Detailedethnicity12815)
    "1282-3" -> decode.success(Detailedethnicity12823)
    "1283-1" -> decode.success(Detailedethnicity12831)
    "1285-6" -> decode.success(Detailedethnicity12856)
    "1286-4" -> decode.success(Detailedethnicity12864)
    "1287-2" -> decode.success(Detailedethnicity12872)
    "1288-0" -> decode.success(Detailedethnicity12880)
    "1289-8" -> decode.success(Detailedethnicity12898)
    "1290-6" -> decode.success(Detailedethnicity12906)
    "1291-4" -> decode.success(Detailedethnicity12914)
    "1292-2" -> decode.success(Detailedethnicity12922)
    "1293-0" -> decode.success(Detailedethnicity12930)
    "1294-8" -> decode.success(Detailedethnicity12948)
    "1295-5" -> decode.success(Detailedethnicity12955)
    "1297-1" -> decode.success(Detailedethnicity12971)
    "1299-7" -> decode.success(Detailedethnicity12997)
    "1301-1" -> decode.success(Detailedethnicity13011)
    "1303-7" -> decode.success(Detailedethnicity13037)
    "1305-2" -> decode.success(Detailedethnicity13052)
    "1306-0" -> decode.success(Detailedethnicity13060)
    "1307-8" -> decode.success(Detailedethnicity13078)
    "1309-4" -> decode.success(Detailedethnicity13094)
    "1310-2" -> decode.success(Detailedethnicity13102)
    "1312-8" -> decode.success(Detailedethnicity13128)
    "1313-6" -> decode.success(Detailedethnicity13136)
    "1314-4" -> decode.success(Detailedethnicity13144)
    "1315-1" -> decode.success(Detailedethnicity13151)
    "1317-7" -> decode.success(Detailedethnicity13177)
    "1319-3" -> decode.success(Detailedethnicity13193)
    "1321-9" -> decode.success(Detailedethnicity13219)
    "1323-5" -> decode.success(Detailedethnicity13235)
    "1325-0" -> decode.success(Detailedethnicity13250)
    "1326-8" -> decode.success(Detailedethnicity13268)
    "1327-6" -> decode.success(Detailedethnicity13276)
    "1328-4" -> decode.success(Detailedethnicity13284)
    "1329-2" -> decode.success(Detailedethnicity13292)
    "1331-8" -> decode.success(Detailedethnicity13318)
    "1332-6" -> decode.success(Detailedethnicity13326)
    "1333-4" -> decode.success(Detailedethnicity13334)
    "1334-2" -> decode.success(Detailedethnicity13342)
    "1335-9" -> decode.success(Detailedethnicity13359)
    "1336-7" -> decode.success(Detailedethnicity13367)
    "1337-5" -> decode.success(Detailedethnicity13375)
    "1338-3" -> decode.success(Detailedethnicity13383)
    "1340-9" -> decode.success(Detailedethnicity13409)
    "1342-5" -> decode.success(Detailedethnicity13425)
    "1344-1" -> decode.success(Detailedethnicity13441)
    "1345-8" -> decode.success(Detailedethnicity13458)
    "1346-6" -> decode.success(Detailedethnicity13466)
    "1348-2" -> decode.success(Detailedethnicity13482)
    "1350-8" -> decode.success(Detailedethnicity13508)
    "1352-4" -> decode.success(Detailedethnicity13524)
    "1354-0" -> decode.success(Detailedethnicity13540)
    "1356-5" -> decode.success(Detailedethnicity13565)
    "1358-1" -> decode.success(Detailedethnicity13581)
    "1359-9" -> decode.success(Detailedethnicity13599)
    "1360-7" -> decode.success(Detailedethnicity13607)
    "1361-5" -> decode.success(Detailedethnicity13615)
    "1363-1" -> decode.success(Detailedethnicity13631)
    "1365-6" -> decode.success(Detailedethnicity13656)
    "1366-4" -> decode.success(Detailedethnicity13664)
    "1368-0" -> decode.success(Detailedethnicity13680)
    "1370-6" -> decode.success(Detailedethnicity13706)
    "1372-2" -> decode.success(Detailedethnicity13722)
    "1374-8" -> decode.success(Detailedethnicity13748)
    "1376-3" -> decode.success(Detailedethnicity13763)
    "1378-9" -> decode.success(Detailedethnicity13789)
    "1380-5" -> decode.success(Detailedethnicity13805)
    "1382-1" -> decode.success(Detailedethnicity13821)
    "1383-9" -> decode.success(Detailedethnicity13839)
    "1384-7" -> decode.success(Detailedethnicity13847)
    "1385-4" -> decode.success(Detailedethnicity13854)
    "1387-0" -> decode.success(Detailedethnicity13870)
    "1389-6" -> decode.success(Detailedethnicity13896)
    "1391-2" -> decode.success(Detailedethnicity13912)
    "1392-0" -> decode.success(Detailedethnicity13920)
    "1393-8" -> decode.success(Detailedethnicity13938)
    "1394-6" -> decode.success(Detailedethnicity13946)
    "1395-3" -> decode.success(Detailedethnicity13953)
    "1396-1" -> decode.success(Detailedethnicity13961)
    "1397-9" -> decode.success(Detailedethnicity13979)
    "1398-7" -> decode.success(Detailedethnicity13987)
    "1399-5" -> decode.success(Detailedethnicity13995)
    "1400-1" -> decode.success(Detailedethnicity14001)
    "1401-9" -> decode.success(Detailedethnicity14019)
    "1403-5" -> decode.success(Detailedethnicity14035)
    "1405-0" -> decode.success(Detailedethnicity14050)
    "1407-6" -> decode.success(Detailedethnicity14076)
    "1409-2" -> decode.success(Detailedethnicity14092)
    "1411-8" -> decode.success(Detailedethnicity14118)
    "1412-6" -> decode.success(Detailedethnicity14126)
    "1413-4" -> decode.success(Detailedethnicity14134)
    "1414-2" -> decode.success(Detailedethnicity14142)
    "1416-7" -> decode.success(Detailedethnicity14167)
    "1417-5" -> decode.success(Detailedethnicity14175)
    "1418-3" -> decode.success(Detailedethnicity14183)
    "1419-1" -> decode.success(Detailedethnicity14191)
    "1420-9" -> decode.success(Detailedethnicity14209)
    "1421-7" -> decode.success(Detailedethnicity14217)
    "1422-5" -> decode.success(Detailedethnicity14225)
    "1423-3" -> decode.success(Detailedethnicity14233)
    "1424-1" -> decode.success(Detailedethnicity14241)
    "1425-8" -> decode.success(Detailedethnicity14258)
    "1426-6" -> decode.success(Detailedethnicity14266)
    "1427-4" -> decode.success(Detailedethnicity14274)
    "1428-2" -> decode.success(Detailedethnicity14282)
    "1429-0" -> decode.success(Detailedethnicity14290)
    "1430-8" -> decode.success(Detailedethnicity14308)
    "1431-6" -> decode.success(Detailedethnicity14316)
    "1432-4" -> decode.success(Detailedethnicity14324)
    "1433-2" -> decode.success(Detailedethnicity14332)
    "1434-0" -> decode.success(Detailedethnicity14340)
    "1435-7" -> decode.success(Detailedethnicity14357)
    "1436-5" -> decode.success(Detailedethnicity14365)
    "1437-3" -> decode.success(Detailedethnicity14373)
    "1439-9" -> decode.success(Detailedethnicity14399)
    "1441-5" -> decode.success(Detailedethnicity14415)
    "1442-3" -> decode.success(Detailedethnicity14423)
    "1443-1" -> decode.success(Detailedethnicity14431)
    "1445-6" -> decode.success(Detailedethnicity14456)
    "1446-4" -> decode.success(Detailedethnicity14464)
    "1448-0" -> decode.success(Detailedethnicity14480)
    "1450-6" -> decode.success(Detailedethnicity14506)
    "1451-4" -> decode.success(Detailedethnicity14514)
    "1453-0" -> decode.success(Detailedethnicity14530)
    "1454-8" -> decode.success(Detailedethnicity14548)
    "1456-3" -> decode.success(Detailedethnicity14563)
    "1457-1" -> decode.success(Detailedethnicity14571)
    "1458-9" -> decode.success(Detailedethnicity14589)
    "1460-5" -> decode.success(Detailedethnicity14605)
    "1462-1" -> decode.success(Detailedethnicity14621)
    "1464-7" -> decode.success(Detailedethnicity14647)
    "1465-4" -> decode.success(Detailedethnicity14654)
    "1466-2" -> decode.success(Detailedethnicity14662)
    "1467-0" -> decode.success(Detailedethnicity14670)
    "1468-8" -> decode.success(Detailedethnicity14688)
    "1469-6" -> decode.success(Detailedethnicity14696)
    "1470-4" -> decode.success(Detailedethnicity14704)
    "1471-2" -> decode.success(Detailedethnicity14712)
    "1472-0" -> decode.success(Detailedethnicity14720)
    "1474-6" -> decode.success(Detailedethnicity14746)
    "1475-3" -> decode.success(Detailedethnicity14753)
    "1476-1" -> decode.success(Detailedethnicity14761)
    "1478-7" -> decode.success(Detailedethnicity14787)
    "1479-5" -> decode.success(Detailedethnicity14795)
    "1480-3" -> decode.success(Detailedethnicity14803)
    "1481-1" -> decode.success(Detailedethnicity14811)
    "1482-9" -> decode.success(Detailedethnicity14829)
    "1483-7" -> decode.success(Detailedethnicity14837)
    "1484-5" -> decode.success(Detailedethnicity14845)
    "1485-2" -> decode.success(Detailedethnicity14852)
    "1487-8" -> decode.success(Detailedethnicity14878)
    "1489-4" -> decode.success(Detailedethnicity14894)
    "1490-2" -> decode.success(Detailedethnicity14902)
    "1491-0" -> decode.success(Detailedethnicity14910)
    "1492-8" -> decode.success(Detailedethnicity14928)
    "1493-6" -> decode.success(Detailedethnicity14936)
    "1494-4" -> decode.success(Detailedethnicity14944)
    "1495-1" -> decode.success(Detailedethnicity14951)
    "1496-9" -> decode.success(Detailedethnicity14969)
    "1497-7" -> decode.success(Detailedethnicity14977)
    "1498-5" -> decode.success(Detailedethnicity14985)
    "1499-3" -> decode.success(Detailedethnicity14993)
    "1500-8" -> decode.success(Detailedethnicity15008)
    "1501-6" -> decode.success(Detailedethnicity15016)
    "1502-4" -> decode.success(Detailedethnicity15024)
    "1503-2" -> decode.success(Detailedethnicity15032)
    "1504-0" -> decode.success(Detailedethnicity15040)
    "1505-7" -> decode.success(Detailedethnicity15057)
    "1506-5" -> decode.success(Detailedethnicity15065)
    "1507-3" -> decode.success(Detailedethnicity15073)
    "1508-1" -> decode.success(Detailedethnicity15081)
    "1509-9" -> decode.success(Detailedethnicity15099)
    "1510-7" -> decode.success(Detailedethnicity15107)
    "1511-5" -> decode.success(Detailedethnicity15115)
    "1512-3" -> decode.success(Detailedethnicity15123)
    "1513-1" -> decode.success(Detailedethnicity15131)
    "1514-9" -> decode.success(Detailedethnicity15149)
    "1515-6" -> decode.success(Detailedethnicity15156)
    "1516-4" -> decode.success(Detailedethnicity15164)
    "1518-0" -> decode.success(Detailedethnicity15180)
    "1519-8" -> decode.success(Detailedethnicity15198)
    "1520-6" -> decode.success(Detailedethnicity15206)
    "1521-4" -> decode.success(Detailedethnicity15214)
    "1522-2" -> decode.success(Detailedethnicity15222)
    "1523-0" -> decode.success(Detailedethnicity15230)
    "1524-8" -> decode.success(Detailedethnicity15248)
    "1525-5" -> decode.success(Detailedethnicity15255)
    "1526-3" -> decode.success(Detailedethnicity15263)
    "1527-1" -> decode.success(Detailedethnicity15271)
    "1528-9" -> decode.success(Detailedethnicity15289)
    "1529-7" -> decode.success(Detailedethnicity15297)
    "1530-5" -> decode.success(Detailedethnicity15305)
    "1531-3" -> decode.success(Detailedethnicity15313)
    "1532-1" -> decode.success(Detailedethnicity15321)
    "1533-9" -> decode.success(Detailedethnicity15339)
    "1534-7" -> decode.success(Detailedethnicity15347)
    "1535-4" -> decode.success(Detailedethnicity15354)
    "1536-2" -> decode.success(Detailedethnicity15362)
    "1537-0" -> decode.success(Detailedethnicity15370)
    "1538-8" -> decode.success(Detailedethnicity15388)
    "1539-6" -> decode.success(Detailedethnicity15396)
    "1541-2" -> decode.success(Detailedethnicity15412)
    "1543-8" -> decode.success(Detailedethnicity15438)
    "1545-3" -> decode.success(Detailedethnicity15453)
    "1547-9" -> decode.success(Detailedethnicity15479)
    "1549-5" -> decode.success(Detailedethnicity15495)
    "1551-1" -> decode.success(Detailedethnicity15511)
    "1552-9" -> decode.success(Detailedethnicity15529)
    "1553-7" -> decode.success(Detailedethnicity15537)
    "1554-5" -> decode.success(Detailedethnicity15545)
    "1556-0" -> decode.success(Detailedethnicity15560)
    "1558-6" -> decode.success(Detailedethnicity15586)
    "1560-2" -> decode.success(Detailedethnicity15602)
    "1562-8" -> decode.success(Detailedethnicity15628)
    "1564-4" -> decode.success(Detailedethnicity15644)
    "1566-9" -> decode.success(Detailedethnicity15669)
    "1567-7" -> decode.success(Detailedethnicity15677)
    "1568-5" -> decode.success(Detailedethnicity15685)
    "1569-3" -> decode.success(Detailedethnicity15693)
    "1570-1" -> decode.success(Detailedethnicity15701)
    "1571-9" -> decode.success(Detailedethnicity15719)
    "1573-5" -> decode.success(Detailedethnicity15735)
    "1574-3" -> decode.success(Detailedethnicity15743)
    "1576-8" -> decode.success(Detailedethnicity15768)
    "1578-4" -> decode.success(Detailedethnicity15784)
    "1579-2" -> decode.success(Detailedethnicity15792)
    "1580-0" -> decode.success(Detailedethnicity15800)
    "1582-6" -> decode.success(Detailedethnicity15826)
    "1584-2" -> decode.success(Detailedethnicity15842)
    "1586-7" -> decode.success(Detailedethnicity15867)
    "1587-5" -> decode.success(Detailedethnicity15875)
    "1588-3" -> decode.success(Detailedethnicity15883)
    "1589-1" -> decode.success(Detailedethnicity15891)
    "1590-9" -> decode.success(Detailedethnicity15909)
    "1591-7" -> decode.success(Detailedethnicity15917)
    "1592-5" -> decode.success(Detailedethnicity15925)
    "1593-3" -> decode.success(Detailedethnicity15933)
    "1594-1" -> decode.success(Detailedethnicity15941)
    "1595-8" -> decode.success(Detailedethnicity15958)
    "1596-6" -> decode.success(Detailedethnicity15966)
    "1597-4" -> decode.success(Detailedethnicity15974)
    "1598-2" -> decode.success(Detailedethnicity15982)
    "1599-0" -> decode.success(Detailedethnicity15990)
    "1600-6" -> decode.success(Detailedethnicity16006)
    "1602-2" -> decode.success(Detailedethnicity16022)
    "1603-0" -> decode.success(Detailedethnicity16030)
    "1604-8" -> decode.success(Detailedethnicity16048)
    "1605-5" -> decode.success(Detailedethnicity16055)
    "1607-1" -> decode.success(Detailedethnicity16071)
    "1609-7" -> decode.success(Detailedethnicity16097)
    "1610-5" -> decode.success(Detailedethnicity16105)
    "1611-3" -> decode.success(Detailedethnicity16113)
    "1612-1" -> decode.success(Detailedethnicity16121)
    "1613-9" -> decode.success(Detailedethnicity16139)
    "1614-7" -> decode.success(Detailedethnicity16147)
    "1615-4" -> decode.success(Detailedethnicity16154)
    "1616-2" -> decode.success(Detailedethnicity16162)
    "1617-0" -> decode.success(Detailedethnicity16170)
    "1618-8" -> decode.success(Detailedethnicity16188)
    "1619-6" -> decode.success(Detailedethnicity16196)
    "1620-4" -> decode.success(Detailedethnicity16204)
    "1621-2" -> decode.success(Detailedethnicity16212)
    "1622-0" -> decode.success(Detailedethnicity16220)
    "1623-8" -> decode.success(Detailedethnicity16238)
    "1624-6" -> decode.success(Detailedethnicity16246)
    "1625-3" -> decode.success(Detailedethnicity16253)
    "1626-1" -> decode.success(Detailedethnicity16261)
    "1627-9" -> decode.success(Detailedethnicity16279)
    "1628-7" -> decode.success(Detailedethnicity16287)
    "1629-5" -> decode.success(Detailedethnicity16295)
    "1630-3" -> decode.success(Detailedethnicity16303)
    "1631-1" -> decode.success(Detailedethnicity16311)
    "1632-9" -> decode.success(Detailedethnicity16329)
    "1633-7" -> decode.success(Detailedethnicity16337)
    "1634-5" -> decode.success(Detailedethnicity16345)
    "1635-2" -> decode.success(Detailedethnicity16352)
    "1636-0" -> decode.success(Detailedethnicity16360)
    "1637-8" -> decode.success(Detailedethnicity16378)
    "1638-6" -> decode.success(Detailedethnicity16386)
    "1639-4" -> decode.success(Detailedethnicity16394)
    "1640-2" -> decode.success(Detailedethnicity16402)
    "1641-0" -> decode.success(Detailedethnicity16410)
    "1643-6" -> decode.success(Detailedethnicity16436)
    "1645-1" -> decode.success(Detailedethnicity16451)
    "1647-7" -> decode.success(Detailedethnicity16477)
    "1649-3" -> decode.success(Detailedethnicity16493)
    "1651-9" -> decode.success(Detailedethnicity16519)
    "1653-5" -> decode.success(Detailedethnicity16535)
    "1654-3" -> decode.success(Detailedethnicity16543)
    "1655-0" -> decode.success(Detailedethnicity16550)
    "1656-8" -> decode.success(Detailedethnicity16568)
    "1657-6" -> decode.success(Detailedethnicity16576)
    "1659-2" -> decode.success(Detailedethnicity16592)
    "1661-8" -> decode.success(Detailedethnicity16618)
    "1663-4" -> decode.success(Detailedethnicity16634)
    "1665-9" -> decode.success(Detailedethnicity16659)
    "1667-5" -> decode.success(Detailedethnicity16675)
    "1668-3" -> decode.success(Detailedethnicity16683)
    "1670-9" -> decode.success(Detailedethnicity16709)
    "1671-7" -> decode.success(Detailedethnicity16717)
    "1672-5" -> decode.success(Detailedethnicity16725)
    "1673-3" -> decode.success(Detailedethnicity16733)
    "1675-8" -> decode.success(Detailedethnicity16758)
    "1677-4" -> decode.success(Detailedethnicity16774)
    "1679-0" -> decode.success(Detailedethnicity16790)
    "1680-8" -> decode.success(Detailedethnicity16808)
    "1681-6" -> decode.success(Detailedethnicity16816)
    "1683-2" -> decode.success(Detailedethnicity16832)
    "1685-7" -> decode.success(Detailedethnicity16857)
    "1687-3" -> decode.success(Detailedethnicity16873)
    "1688-1" -> decode.success(Detailedethnicity16881)
    "1689-9" -> decode.success(Detailedethnicity16899)
    "1690-7" -> decode.success(Detailedethnicity16907)
    "1692-3" -> decode.success(Detailedethnicity16923)
    "1694-9" -> decode.success(Detailedethnicity16949)
    "1696-4" -> decode.success(Detailedethnicity16964)
    "1697-2" -> decode.success(Detailedethnicity16972)
    "1698-0" -> decode.success(Detailedethnicity16980)
    "1700-4" -> decode.success(Detailedethnicity17004)
    "1702-0" -> decode.success(Detailedethnicity17020)
    "1704-6" -> decode.success(Detailedethnicity17046)
    "1705-3" -> decode.success(Detailedethnicity17053)
    "1707-9" -> decode.success(Detailedethnicity17079)
    "1709-5" -> decode.success(Detailedethnicity17095)
    "1711-1" -> decode.success(Detailedethnicity17111)
    "1712-9" -> decode.success(Detailedethnicity17129)
    "1713-7" -> decode.success(Detailedethnicity17137)
    "1715-2" -> decode.success(Detailedethnicity17152)
    "1717-8" -> decode.success(Detailedethnicity17178)
    "1718-6" -> decode.success(Detailedethnicity17186)
    "1719-4" -> decode.success(Detailedethnicity17194)
    "1720-2" -> decode.success(Detailedethnicity17202)
    "1722-8" -> decode.success(Detailedethnicity17228)
    "1724-4" -> decode.success(Detailedethnicity17244)
    "1725-1" -> decode.success(Detailedethnicity17251)
    "1726-9" -> decode.success(Detailedethnicity17269)
    "1727-7" -> decode.success(Detailedethnicity17277)
    "1728-5" -> decode.success(Detailedethnicity17285)
    "1729-3" -> decode.success(Detailedethnicity17293)
    "1730-1" -> decode.success(Detailedethnicity17301)
    "1731-9" -> decode.success(Detailedethnicity17319)
    "1732-7" -> decode.success(Detailedethnicity17327)
    "1733-5" -> decode.success(Detailedethnicity17335)
    "1735-0" -> decode.success(Detailedethnicity17350)
    "1737-6" -> decode.success(Detailedethnicity17376)
    "1739-2" -> decode.success(Detailedethnicity17392)
    "1740-0" -> decode.success(Detailedethnicity17400)
    "1741-8" -> decode.success(Detailedethnicity17418)
    "1742-6" -> decode.success(Detailedethnicity17426)
    "1743-4" -> decode.success(Detailedethnicity17434)
    "1744-2" -> decode.success(Detailedethnicity17442)
    "1745-9" -> decode.success(Detailedethnicity17459)
    "1746-7" -> decode.success(Detailedethnicity17467)
    "1747-5" -> decode.success(Detailedethnicity17475)
    "1748-3" -> decode.success(Detailedethnicity17483)
    "1749-1" -> decode.success(Detailedethnicity17491)
    "1750-9" -> decode.success(Detailedethnicity17509)
    "1751-7" -> decode.success(Detailedethnicity17517)
    "1752-5" -> decode.success(Detailedethnicity17525)
    "1753-3" -> decode.success(Detailedethnicity17533)
    "1754-1" -> decode.success(Detailedethnicity17541)
    "1755-8" -> decode.success(Detailedethnicity17558)
    "1756-6" -> decode.success(Detailedethnicity17566)
    "1757-4" -> decode.success(Detailedethnicity17574)
    "1758-2" -> decode.success(Detailedethnicity17582)
    "1759-0" -> decode.success(Detailedethnicity17590)
    "1760-8" -> decode.success(Detailedethnicity17608)
    "1761-6" -> decode.success(Detailedethnicity17616)
    "1762-4" -> decode.success(Detailedethnicity17624)
    "1763-2" -> decode.success(Detailedethnicity17632)
    "1764-0" -> decode.success(Detailedethnicity17640)
    "1765-7" -> decode.success(Detailedethnicity17657)
    "1766-5" -> decode.success(Detailedethnicity17665)
    "1767-3" -> decode.success(Detailedethnicity17673)
    "1768-1" -> decode.success(Detailedethnicity17681)
    "1769-9" -> decode.success(Detailedethnicity17699)
    "1770-7" -> decode.success(Detailedethnicity17707)
    "1771-5" -> decode.success(Detailedethnicity17715)
    "1772-3" -> decode.success(Detailedethnicity17723)
    "1773-1" -> decode.success(Detailedethnicity17731)
    "1774-9" -> decode.success(Detailedethnicity17749)
    "1775-6" -> decode.success(Detailedethnicity17756)
    "1776-4" -> decode.success(Detailedethnicity17764)
    "1777-2" -> decode.success(Detailedethnicity17772)
    "1778-0" -> decode.success(Detailedethnicity17780)
    "1779-8" -> decode.success(Detailedethnicity17798)
    "1780-6" -> decode.success(Detailedethnicity17806)
    "1781-4" -> decode.success(Detailedethnicity17814)
    "1782-2" -> decode.success(Detailedethnicity17822)
    "1783-0" -> decode.success(Detailedethnicity17830)
    "1784-8" -> decode.success(Detailedethnicity17848)
    "1785-5" -> decode.success(Detailedethnicity17855)
    "1786-3" -> decode.success(Detailedethnicity17863)
    "1787-1" -> decode.success(Detailedethnicity17871)
    "1788-9" -> decode.success(Detailedethnicity17889)
    "1789-7" -> decode.success(Detailedethnicity17897)
    "1790-5" -> decode.success(Detailedethnicity17905)
    "1791-3" -> decode.success(Detailedethnicity17913)
    "1792-1" -> decode.success(Detailedethnicity17921)
    "1793-9" -> decode.success(Detailedethnicity17939)
    "1794-7" -> decode.success(Detailedethnicity17947)
    "1795-4" -> decode.success(Detailedethnicity17954)
    "1796-2" -> decode.success(Detailedethnicity17962)
    "1797-0" -> decode.success(Detailedethnicity17970)
    "1798-8" -> decode.success(Detailedethnicity17988)
    "1799-6" -> decode.success(Detailedethnicity17996)
    "1800-2" -> decode.success(Detailedethnicity18002)
    "1801-0" -> decode.success(Detailedethnicity18010)
    "1802-8" -> decode.success(Detailedethnicity18028)
    "1803-6" -> decode.success(Detailedethnicity18036)
    "1804-4" -> decode.success(Detailedethnicity18044)
    "1805-1" -> decode.success(Detailedethnicity18051)
    "1806-9" -> decode.success(Detailedethnicity18069)
    "1807-7" -> decode.success(Detailedethnicity18077)
    "1808-5" -> decode.success(Detailedethnicity18085)
    "1809-3" -> decode.success(Detailedethnicity18093)
    "1811-9" -> decode.success(Detailedethnicity18119)
    "1813-5" -> decode.success(Detailedethnicity18135)
    "1814-3" -> decode.success(Detailedethnicity18143)
    "1815-0" -> decode.success(Detailedethnicity18150)
    "1816-8" -> decode.success(Detailedethnicity18168)
    "1817-6" -> decode.success(Detailedethnicity18176)
    "1818-4" -> decode.success(Detailedethnicity18184)
    "1819-2" -> decode.success(Detailedethnicity18192)
    "1820-0" -> decode.success(Detailedethnicity18200)
    "1821-8" -> decode.success(Detailedethnicity18218)
    "1822-6" -> decode.success(Detailedethnicity18226)
    "1823-4" -> decode.success(Detailedethnicity18234)
    "1824-2" -> decode.success(Detailedethnicity18242)
    "1825-9" -> decode.success(Detailedethnicity18259)
    "1826-7" -> decode.success(Detailedethnicity18267)
    "1827-5" -> decode.success(Detailedethnicity18275)
    "1828-3" -> decode.success(Detailedethnicity18283)
    "1829-1" -> decode.success(Detailedethnicity18291)
    "1830-9" -> decode.success(Detailedethnicity18309)
    "1831-7" -> decode.success(Detailedethnicity18317)
    "1832-5" -> decode.success(Detailedethnicity18325)
    "1833-3" -> decode.success(Detailedethnicity18333)
    "1834-1" -> decode.success(Detailedethnicity18341)
    "1835-8" -> decode.success(Detailedethnicity18358)
    "1837-4" -> decode.success(Detailedethnicity18374)
    "1838-2" -> decode.success(Detailedethnicity18382)
    "1840-8" -> decode.success(Detailedethnicity18408)
    "1842-4" -> decode.success(Detailedethnicity18424)
    "1844-0" -> decode.success(Detailedethnicity18440)
    "1845-7" -> decode.success(Detailedethnicity18457)
    "1846-5" -> decode.success(Detailedethnicity18465)
    "1847-3" -> decode.success(Detailedethnicity18473)
    "1848-1" -> decode.success(Detailedethnicity18481)
    "1849-9" -> decode.success(Detailedethnicity18499)
    "1850-7" -> decode.success(Detailedethnicity18507)
    "1851-5" -> decode.success(Detailedethnicity18515)
    "1852-3" -> decode.success(Detailedethnicity18523)
    "1853-1" -> decode.success(Detailedethnicity18531)
    "1854-9" -> decode.success(Detailedethnicity18549)
    "1855-6" -> decode.success(Detailedethnicity18556)
    "1856-4" -> decode.success(Detailedethnicity18564)
    "1857-2" -> decode.success(Detailedethnicity18572)
    "1858-0" -> decode.success(Detailedethnicity18580)
    "1859-8" -> decode.success(Detailedethnicity18598)
    "1860-6" -> decode.success(Detailedethnicity18606)
    "1861-4" -> decode.success(Detailedethnicity18614)
    "1862-2" -> decode.success(Detailedethnicity18622)
    "1863-0" -> decode.success(Detailedethnicity18630)
    "1864-8" -> decode.success(Detailedethnicity18648)
    "1865-5" -> decode.success(Detailedethnicity18655)
    "1866-3" -> decode.success(Detailedethnicity18663)
    "1867-1" -> decode.success(Detailedethnicity18671)
    "1868-9" -> decode.success(Detailedethnicity18689)
    "1869-7" -> decode.success(Detailedethnicity18697)
    "1870-5" -> decode.success(Detailedethnicity18705)
    "1871-3" -> decode.success(Detailedethnicity18713)
    "1872-1" -> decode.success(Detailedethnicity18721)
    "1873-9" -> decode.success(Detailedethnicity18739)
    "1874-7" -> decode.success(Detailedethnicity18747)
    "1875-4" -> decode.success(Detailedethnicity18754)
    "1876-2" -> decode.success(Detailedethnicity18762)
    "1877-0" -> decode.success(Detailedethnicity18770)
    "1878-8" -> decode.success(Detailedethnicity18788)
    "1879-6" -> decode.success(Detailedethnicity18796)
    "1880-4" -> decode.success(Detailedethnicity18804)
    "1881-2" -> decode.success(Detailedethnicity18812)
    "1882-0" -> decode.success(Detailedethnicity18820)
    "1883-8" -> decode.success(Detailedethnicity18838)
    "1884-6" -> decode.success(Detailedethnicity18846)
    "1885-3" -> decode.success(Detailedethnicity18853)
    "1886-1" -> decode.success(Detailedethnicity18861)
    "1887-9" -> decode.success(Detailedethnicity18879)
    "1888-7" -> decode.success(Detailedethnicity18887)
    "1889-5" -> decode.success(Detailedethnicity18895)
    "1891-1" -> decode.success(Detailedethnicity18911)
    "1892-9" -> decode.success(Detailedethnicity18929)
    "1893-7" -> decode.success(Detailedethnicity18937)
    "1894-5" -> decode.success(Detailedethnicity18945)
    "1896-0" -> decode.success(Detailedethnicity18960)
    "1897-8" -> decode.success(Detailedethnicity18978)
    "1898-6" -> decode.success(Detailedethnicity18986)
    "1899-4" -> decode.success(Detailedethnicity18994)
    "1900-0" -> decode.success(Detailedethnicity19000)
    "1901-8" -> decode.success(Detailedethnicity19018)
    "1902-6" -> decode.success(Detailedethnicity19026)
    "1903-4" -> decode.success(Detailedethnicity19034)
    "1904-2" -> decode.success(Detailedethnicity19042)
    "1905-9" -> decode.success(Detailedethnicity19059)
    "1906-7" -> decode.success(Detailedethnicity19067)
    "1907-5" -> decode.success(Detailedethnicity19075)
    "1908-3" -> decode.success(Detailedethnicity19083)
    "1909-1" -> decode.success(Detailedethnicity19091)
    "1910-9" -> decode.success(Detailedethnicity19109)
    "1911-7" -> decode.success(Detailedethnicity19117)
    "1912-5" -> decode.success(Detailedethnicity19125)
    "1913-3" -> decode.success(Detailedethnicity19133)
    "1914-1" -> decode.success(Detailedethnicity19141)
    "1915-8" -> decode.success(Detailedethnicity19158)
    "1916-6" -> decode.success(Detailedethnicity19166)
    "1917-4" -> decode.success(Detailedethnicity19174)
    "1918-2" -> decode.success(Detailedethnicity19182)
    "1919-0" -> decode.success(Detailedethnicity19190)
    "1920-8" -> decode.success(Detailedethnicity19208)
    "1921-6" -> decode.success(Detailedethnicity19216)
    "1922-4" -> decode.success(Detailedethnicity19224)
    "1923-2" -> decode.success(Detailedethnicity19232)
    "1924-0" -> decode.success(Detailedethnicity19240)
    "1925-7" -> decode.success(Detailedethnicity19257)
    "1926-5" -> decode.success(Detailedethnicity19265)
    "1927-3" -> decode.success(Detailedethnicity19273)
    "1928-1" -> decode.success(Detailedethnicity19281)
    "1929-9" -> decode.success(Detailedethnicity19299)
    "1930-7" -> decode.success(Detailedethnicity19307)
    "1931-5" -> decode.success(Detailedethnicity19315)
    "1932-3" -> decode.success(Detailedethnicity19323)
    "1933-1" -> decode.success(Detailedethnicity19331)
    "1934-9" -> decode.success(Detailedethnicity19349)
    "1935-6" -> decode.success(Detailedethnicity19356)
    "1936-4" -> decode.success(Detailedethnicity19364)
    "1937-2" -> decode.success(Detailedethnicity19372)
    "1938-0" -> decode.success(Detailedethnicity19380)
    "1939-8" -> decode.success(Detailedethnicity19398)
    "1940-6" -> decode.success(Detailedethnicity19406)
    "1941-4" -> decode.success(Detailedethnicity19414)
    "1942-2" -> decode.success(Detailedethnicity19422)
    "1943-0" -> decode.success(Detailedethnicity19430)
    "1944-8" -> decode.success(Detailedethnicity19448)
    "1945-5" -> decode.success(Detailedethnicity19455)
    "1946-3" -> decode.success(Detailedethnicity19463)
    "1947-1" -> decode.success(Detailedethnicity19471)
    "1948-9" -> decode.success(Detailedethnicity19489)
    "1949-7" -> decode.success(Detailedethnicity19497)
    "1950-5" -> decode.success(Detailedethnicity19505)
    "1951-3" -> decode.success(Detailedethnicity19513)
    "1952-1" -> decode.success(Detailedethnicity19521)
    "1953-9" -> decode.success(Detailedethnicity19539)
    "1954-7" -> decode.success(Detailedethnicity19547)
    "1955-4" -> decode.success(Detailedethnicity19554)
    "1956-2" -> decode.success(Detailedethnicity19562)
    "1957-0" -> decode.success(Detailedethnicity19570)
    "1958-8" -> decode.success(Detailedethnicity19588)
    "1959-6" -> decode.success(Detailedethnicity19596)
    "1960-4" -> decode.success(Detailedethnicity19604)
    "1961-2" -> decode.success(Detailedethnicity19612)
    "1962-0" -> decode.success(Detailedethnicity19620)
    "1963-8" -> decode.success(Detailedethnicity19638)
    "1964-6" -> decode.success(Detailedethnicity19646)
    "1966-1" -> decode.success(Detailedethnicity19661)
    "1968-7" -> decode.success(Detailedethnicity19687)
    "1969-5" -> decode.success(Detailedethnicity19695)
    "1970-3" -> decode.success(Detailedethnicity19703)
    "1972-9" -> decode.success(Detailedethnicity19729)
    "1973-7" -> decode.success(Detailedethnicity19737)
    "1974-5" -> decode.success(Detailedethnicity19745)
    "1975-2" -> decode.success(Detailedethnicity19752)
    "1976-0" -> decode.success(Detailedethnicity19760)
    "1977-8" -> decode.success(Detailedethnicity19778)
    "1978-6" -> decode.success(Detailedethnicity19786)
    "1979-4" -> decode.success(Detailedethnicity19794)
    "1980-2" -> decode.success(Detailedethnicity19802)
    "1981-0" -> decode.success(Detailedethnicity19810)
    "1982-8" -> decode.success(Detailedethnicity19828)
    "1984-4" -> decode.success(Detailedethnicity19844)
    "1985-1" -> decode.success(Detailedethnicity19851)
    "1986-9" -> decode.success(Detailedethnicity19869)
    "1987-7" -> decode.success(Detailedethnicity19877)
    "1988-5" -> decode.success(Detailedethnicity19885)
    "1990-1" -> decode.success(Detailedethnicity19901)
    "1992-7" -> decode.success(Detailedethnicity19927)
    "1993-5" -> decode.success(Detailedethnicity19935)
    "1994-3" -> decode.success(Detailedethnicity19943)
    "1995-0" -> decode.success(Detailedethnicity19950)
    "1996-8" -> decode.success(Detailedethnicity19968)
    "1997-6" -> decode.success(Detailedethnicity19976)
    "1998-4" -> decode.success(Detailedethnicity19984)
    "1999-2" -> decode.success(Detailedethnicity19992)
    "2000-8" -> decode.success(Detailedethnicity20008)
    "2002-4" -> decode.success(Detailedethnicity20024)
    "2004-0" -> decode.success(Detailedethnicity20040)
    "2006-5" -> decode.success(Detailedethnicity20065)
    "2007-3" -> decode.success(Detailedethnicity20073)
    "2008-1" -> decode.success(Detailedethnicity20081)
    "2009-9" -> decode.success(Detailedethnicity20099)
    "2010-7" -> decode.success(Detailedethnicity20107)
    "2011-5" -> decode.success(Detailedethnicity20115)
    "2012-3" -> decode.success(Detailedethnicity20123)
    "2013-1" -> decode.success(Detailedethnicity20131)
    "2014-9" -> decode.success(Detailedethnicity20149)
    "2015-6" -> decode.success(Detailedethnicity20156)
    "2016-4" -> decode.success(Detailedethnicity20164)
    "2017-2" -> decode.success(Detailedethnicity20172)
    "2018-0" -> decode.success(Detailedethnicity20180)
    "2019-8" -> decode.success(Detailedethnicity20198)
    "2020-6" -> decode.success(Detailedethnicity20206)
    "2021-4" -> decode.success(Detailedethnicity20214)
    "2022-2" -> decode.success(Detailedethnicity20222)
    "2023-0" -> decode.success(Detailedethnicity20230)
    "2024-8" -> decode.success(Detailedethnicity20248)
    "2025-5" -> decode.success(Detailedethnicity20255)
    "2026-3" -> decode.success(Detailedethnicity20263)
    "2028-9" -> decode.success(Detailedethnicity20289)
    "2029-7" -> decode.success(Detailedethnicity20297)
    "2030-5" -> decode.success(Detailedethnicity20305)
    "2031-3" -> decode.success(Detailedethnicity20313)
    "2032-1" -> decode.success(Detailedethnicity20321)
    "2033-9" -> decode.success(Detailedethnicity20339)
    "2034-7" -> decode.success(Detailedethnicity20347)
    "2035-4" -> decode.success(Detailedethnicity20354)
    "2036-2" -> decode.success(Detailedethnicity20362)
    "2037-0" -> decode.success(Detailedethnicity20370)
    "2038-8" -> decode.success(Detailedethnicity20388)
    "2039-6" -> decode.success(Detailedethnicity20396)
    "2040-4" -> decode.success(Detailedethnicity20404)
    "2041-2" -> decode.success(Detailedethnicity20412)
    "2042-0" -> decode.success(Detailedethnicity20420)
    "2043-8" -> decode.success(Detailedethnicity20438)
    "2044-6" -> decode.success(Detailedethnicity20446)
    "2045-3" -> decode.success(Detailedethnicity20453)
    "2046-1" -> decode.success(Detailedethnicity20461)
    "2047-9" -> decode.success(Detailedethnicity20479)
    "2048-7" -> decode.success(Detailedethnicity20487)
    "2049-5" -> decode.success(Detailedethnicity20495)
    "2050-3" -> decode.success(Detailedethnicity20503)
    "2051-1" -> decode.success(Detailedethnicity20511)
    "2052-9" -> decode.success(Detailedethnicity20529)
    "2054-5" -> decode.success(Detailedethnicity20545)
    "2056-0" -> decode.success(Detailedethnicity20560)
    "2058-6" -> decode.success(Detailedethnicity20586)
    "2060-2" -> decode.success(Detailedethnicity20602)
    "2061-0" -> decode.success(Detailedethnicity20610)
    "2062-8" -> decode.success(Detailedethnicity20628)
    "2063-6" -> decode.success(Detailedethnicity20636)
    "2064-4" -> decode.success(Detailedethnicity20644)
    "2065-1" -> decode.success(Detailedethnicity20651)
    "2066-9" -> decode.success(Detailedethnicity20669)
    "2067-7" -> decode.success(Detailedethnicity20677)
    "2068-5" -> decode.success(Detailedethnicity20685)
    "2069-3" -> decode.success(Detailedethnicity20693)
    "2070-1" -> decode.success(Detailedethnicity20701)
    "2071-9" -> decode.success(Detailedethnicity20719)
    "2072-7" -> decode.success(Detailedethnicity20727)
    "2073-5" -> decode.success(Detailedethnicity20735)
    "2074-3" -> decode.success(Detailedethnicity20743)
    "2075-0" -> decode.success(Detailedethnicity20750)
    "2076-8" -> decode.success(Detailedethnicity20768)
    "2078-4" -> decode.success(Detailedethnicity20784)
    "2079-2" -> decode.success(Detailedethnicity20792)
    "2080-0" -> decode.success(Detailedethnicity20800)
    "2081-8" -> decode.success(Detailedethnicity20818)
    "2082-6" -> decode.success(Detailedethnicity20826)
    "2083-4" -> decode.success(Detailedethnicity20834)
    "2085-9" -> decode.success(Detailedethnicity20859)
    "2086-7" -> decode.success(Detailedethnicity20867)
    "2087-5" -> decode.success(Detailedethnicity20875)
    "2088-3" -> decode.success(Detailedethnicity20883)
    "2089-1" -> decode.success(Detailedethnicity20891)
    "2090-9" -> decode.success(Detailedethnicity20909)
    "2091-7" -> decode.success(Detailedethnicity20917)
    "2092-5" -> decode.success(Detailedethnicity20925)
    "2093-3" -> decode.success(Detailedethnicity20933)
    "2094-1" -> decode.success(Detailedethnicity20941)
    "2095-8" -> decode.success(Detailedethnicity20958)
    "2096-6" -> decode.success(Detailedethnicity20966)
    "2097-4" -> decode.success(Detailedethnicity20974)
    "2098-2" -> decode.success(Detailedethnicity20982)
    "2100-6" -> decode.success(Detailedethnicity21006)
    "2101-4" -> decode.success(Detailedethnicity21014)
    "2102-2" -> decode.success(Detailedethnicity21022)
    "2103-0" -> decode.success(Detailedethnicity21030)
    "2104-8" -> decode.success(Detailedethnicity21048)
    "2106-3" -> decode.success(Detailedethnicity21063)
    "2108-9" -> decode.success(Detailedethnicity21089)
    "2109-7" -> decode.success(Detailedethnicity21097)
    "2110-5" -> decode.success(Detailedethnicity21105)
    "2111-3" -> decode.success(Detailedethnicity21113)
    "2112-1" -> decode.success(Detailedethnicity21121)
    "2113-9" -> decode.success(Detailedethnicity21139)
    "2114-7" -> decode.success(Detailedethnicity21147)
    "2115-4" -> decode.success(Detailedethnicity21154)
    "2116-2" -> decode.success(Detailedethnicity21162)
    "2118-8" -> decode.success(Detailedethnicity21188)
    "2119-6" -> decode.success(Detailedethnicity21196)
    "2120-4" -> decode.success(Detailedethnicity21204)
    "2121-2" -> decode.success(Detailedethnicity21212)
    "2122-0" -> decode.success(Detailedethnicity21220)
    "2123-8" -> decode.success(Detailedethnicity21238)
    "2124-6" -> decode.success(Detailedethnicity21246)
    "2125-3" -> decode.success(Detailedethnicity21253)
    "2126-1" -> decode.success(Detailedethnicity21261)
    "2127-9" -> decode.success(Detailedethnicity21279)
    "2129-5" -> decode.success(Detailedethnicity21295)
    "2131-1" -> decode.success(Detailedethnicity21311)
    "2133-7" -> decode.success(Detailedethnicity21337)
    "2135-2" -> decode.success(Detailedethnicity21352)
    "2137-8" -> decode.success(Detailedethnicity21378)
    "2138-6" -> decode.success(Detailedethnicity21386)
    "2139-4" -> decode.success(Detailedethnicity21394)
    "2140-2" -> decode.success(Detailedethnicity21402)
    "2141-0" -> decode.success(Detailedethnicity21410)
    "2142-8" -> decode.success(Detailedethnicity21428)
    "2143-6" -> decode.success(Detailedethnicity21436)
    "2144-4" -> decode.success(Detailedethnicity21444)
    "2145-1" -> decode.success(Detailedethnicity21451)
    "2146-9" -> decode.success(Detailedethnicity21469)
    "2148-5" -> decode.success(Detailedethnicity21485)
    "2149-3" -> decode.success(Detailedethnicity21493)
    "2150-1" -> decode.success(Detailedethnicity21501)
    "2151-9" -> decode.success(Detailedethnicity21519)
    "2152-7" -> decode.success(Detailedethnicity21527)
    "2153-5" -> decode.success(Detailedethnicity21535)
    "2155-0" -> decode.success(Detailedethnicity21550)
    "2156-8" -> decode.success(Detailedethnicity21568)
    "2157-6" -> decode.success(Detailedethnicity21576)
    "2158-4" -> decode.success(Detailedethnicity21584)
    "2159-2" -> decode.success(Detailedethnicity21592)
    "2160-0" -> decode.success(Detailedethnicity21600)
    "2161-8" -> decode.success(Detailedethnicity21618)
    "2162-6" -> decode.success(Detailedethnicity21626)
    "2163-4" -> decode.success(Detailedethnicity21634)
    "2165-9" -> decode.success(Detailedethnicity21659)
    "2166-7" -> decode.success(Detailedethnicity21667)
    "2167-5" -> decode.success(Detailedethnicity21675)
    "2168-3" -> decode.success(Detailedethnicity21683)
    "2169-1" -> decode.success(Detailedethnicity21691)
    "2170-9" -> decode.success(Detailedethnicity21709)
    "2171-7" -> decode.success(Detailedethnicity21717)
    "2172-5" -> decode.success(Detailedethnicity21725)
    "2173-3" -> decode.success(Detailedethnicity21733)
    "2174-1" -> decode.success(Detailedethnicity21741)
    "2175-8" -> decode.success(Detailedethnicity21758)
    "2176-6" -> decode.success(Detailedethnicity21766)
    "2178-2" -> decode.success(Detailedethnicity21782)
    "2180-8" -> decode.success(Detailedethnicity21808)
    "2182-4" -> decode.success(Detailedethnicity21824)
    "2184-0" -> decode.success(Detailedethnicity21840)
    "2186-5" -> decode.success(Detailedethnicity21865)
    "2500-7" -> decode.success(Detailedethnicity25007)
    "ASKU" -> decode.success(DetailedethnicityAsku)
    "OTH" -> decode.success(DetailedethnicityOth)
    "UNK" -> decode.success(DetailedethnicityUnk)
    _ -> decode.failure(Detailedethnicity10009, "Detailedethnicity")
  }
}

pub fn detailedethnicity_system(
  detailedethnicity: Detailedethnicity,
) -> String {
  case detailedethnicity {
    Detailedethnicity10009 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10025 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10041 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10066 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10082 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10108 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10116 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10124 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10132 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10140 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10157 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10165 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10173 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10181 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10199 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10215 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10223 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10231 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10249 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10264 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10280 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10306 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10314 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10330 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10355 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10371 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10397 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10413 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10421 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10447 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10454 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10462 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10470 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10488 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10496 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10504 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10512 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10538 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10546 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10553 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10561 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10579 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10587 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10595 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10603 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10611 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10629 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10637 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10645 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10652 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10660 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10686 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10694 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10702 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10710 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10728 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10736 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10744 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10769 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10785 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10801 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10827 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10835 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10843 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10868 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10884 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10892 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10900 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10918 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10926 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10934 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10942 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10959 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10967 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10975 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity10983 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11007 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11023 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11031 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11049 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11064 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11080 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11098 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11106 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11122 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11148 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11155 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11163 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11171 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11189 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11197 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11205 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11213 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11239 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11247 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11254 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11262 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11270 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11288 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11296 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11304 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11312 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11320 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11338 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11346 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11353 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11361 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11379 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11387 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11395 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11403 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11411 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11429 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11437 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11445 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11452 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11460 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11478 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11486 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11502 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11510 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11536 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11551 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11569 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11577 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11585 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11593 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11601 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11627 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11635 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11650 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11676 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11692 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11718 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11734 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11759 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11767 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11783 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11809 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11825 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11841 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11866 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11874 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11890 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11916 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11932 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11940 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11957 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11965 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11973 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11981 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity11999 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12005 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12013 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12021 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12039 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12047 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12054 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12070 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12096 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12112 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12120 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12146 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12153 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12161 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12179 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12187 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12195 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12203 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12229 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12237 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12245 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12252 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12260 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12278 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12286 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12294 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12302 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12310 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12336 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12344 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12351 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12369 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12377 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12385 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12393 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12401 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12419 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12427 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12435 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12443 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12450 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12468 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12476 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12484 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12500 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12526 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12542 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12567 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12583 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12609 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12625 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12641 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12658 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12674 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12690 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12716 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12724 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12732 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12757 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12773 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12799 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12815 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12823 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12831 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12856 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12864 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12872 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12880 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12898 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12906 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12914 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12922 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12930 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12948 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12955 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12971 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity12997 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13011 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13037 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13052 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13060 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13078 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13094 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13102 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13128 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13136 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13144 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13151 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13177 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13193 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13219 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13235 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13250 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13268 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13276 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13284 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13292 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13318 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13326 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13334 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13342 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13359 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13367 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13375 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13383 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13409 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13425 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13441 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13458 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13466 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13482 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13508 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13524 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13540 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13565 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13581 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13599 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13607 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13615 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13631 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13656 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13664 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13680 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13706 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13722 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13748 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13763 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13789 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13805 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13821 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13839 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13847 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13854 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13870 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13896 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13912 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13920 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13938 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13946 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13953 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13961 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13979 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13987 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity13995 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14001 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14019 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14035 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14050 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14076 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14092 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14118 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14126 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14134 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14142 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14167 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14175 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14183 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14191 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14209 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14217 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14225 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14233 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14241 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14258 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14266 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14274 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14282 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14290 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14308 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14316 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14324 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14332 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14340 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14357 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14365 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14373 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14399 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14415 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14423 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14431 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14456 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14464 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14480 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14506 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14514 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14530 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14548 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14563 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14571 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14589 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14605 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14621 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14647 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14654 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14662 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14670 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14688 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14696 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14704 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14712 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14720 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14746 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14753 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14761 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14787 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14795 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14803 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14811 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14829 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14837 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14845 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14852 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14878 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14894 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14902 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14910 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14928 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14936 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14944 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14951 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14969 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14977 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14985 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity14993 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15008 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15016 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15024 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15032 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15040 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15057 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15065 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15073 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15081 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15099 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15107 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15115 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15123 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15131 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15149 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15156 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15164 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15180 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15198 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15206 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15214 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15222 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15230 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15248 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15255 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15263 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15271 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15289 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15297 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15305 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15313 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15321 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15339 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15347 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15354 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15362 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15370 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15388 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15396 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15412 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15438 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15453 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15479 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15495 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15511 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15529 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15537 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15545 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15560 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15586 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15602 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15628 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15644 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15669 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15677 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15685 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15693 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15701 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15719 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15735 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15743 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15768 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15784 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15792 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15800 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15826 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15842 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15867 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15875 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15883 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15891 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15909 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15917 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15925 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15933 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15941 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15958 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15966 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15974 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15982 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity15990 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16006 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16022 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16030 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16048 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16055 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16071 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16097 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16105 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16113 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16121 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16139 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16147 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16154 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16162 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16170 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16188 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16196 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16204 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16212 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16220 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16238 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16246 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16253 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16261 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16279 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16287 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16295 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16303 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16311 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16329 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16337 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16345 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16352 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16360 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16378 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16386 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16394 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16402 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16410 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16436 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16451 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16477 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16493 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16519 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16535 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16543 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16550 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16568 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16576 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16592 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16618 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16634 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16659 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16675 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16683 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16709 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16717 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16725 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16733 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16758 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16774 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16790 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16808 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16816 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16832 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16857 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16873 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16881 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16899 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16907 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16923 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16949 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16964 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16972 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity16980 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17004 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17020 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17046 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17053 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17079 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17095 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17111 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17129 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17137 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17152 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17178 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17186 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17194 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17202 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17228 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17244 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17251 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17269 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17277 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17285 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17293 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17301 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17319 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17327 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17335 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17350 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17376 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17392 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17400 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17418 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17426 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17434 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17442 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17459 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17467 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17475 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17483 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17491 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17509 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17517 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17525 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17533 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17541 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17558 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17566 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17574 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17582 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17590 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17608 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17616 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17624 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17632 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17640 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17657 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17665 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17673 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17681 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17699 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17707 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17715 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17723 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17731 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17749 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17756 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17764 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17772 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17780 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17798 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17806 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17814 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17822 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17830 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17848 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17855 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17863 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17871 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17889 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17897 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17905 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17913 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17921 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17939 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17947 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17954 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17962 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17970 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17988 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity17996 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18002 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18010 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18028 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18036 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18044 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18051 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18069 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18077 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18085 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18093 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18119 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18135 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18143 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18150 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18168 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18176 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18184 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18192 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18200 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18218 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18226 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18234 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18242 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18259 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18267 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18275 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18283 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18291 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18309 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18317 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18325 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18333 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18341 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18358 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18374 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18382 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18408 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18424 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18440 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18457 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18465 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18473 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18481 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18499 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18507 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18515 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18523 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18531 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18549 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18556 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18564 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18572 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18580 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18598 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18606 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18614 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18622 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18630 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18648 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18655 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18663 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18671 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18689 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18697 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18705 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18713 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18721 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18739 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18747 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18754 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18762 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18770 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18788 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18796 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18804 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18812 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18820 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18838 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18846 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18853 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18861 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18879 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18887 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18895 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18911 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18929 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18937 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18945 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18960 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18978 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18986 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity18994 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19000 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19018 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19026 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19034 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19042 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19059 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19067 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19075 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19083 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19091 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19109 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19117 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19125 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19133 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19141 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19158 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19166 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19174 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19182 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19190 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19208 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19216 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19224 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19232 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19240 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19257 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19265 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19273 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19281 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19299 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19307 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19315 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19323 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19331 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19349 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19356 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19364 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19372 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19380 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19398 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19406 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19414 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19422 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19430 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19448 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19455 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19463 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19471 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19489 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19497 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19505 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19513 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19521 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19539 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19547 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19554 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19562 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19570 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19588 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19596 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19604 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19612 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19620 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19638 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19646 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19661 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19687 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19695 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19703 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19729 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19737 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19745 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19752 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19760 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19778 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19786 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19794 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19802 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19810 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19828 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19844 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19851 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19869 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19877 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19885 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19901 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19927 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19935 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19943 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19950 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19968 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19976 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19984 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity19992 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20008 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20024 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20040 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20065 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20073 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20081 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20099 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20107 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20115 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20123 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20131 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20149 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20156 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20164 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20172 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20180 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20198 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20206 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20214 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20222 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20230 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20248 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20255 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20263 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20289 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20297 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20305 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20313 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20321 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20339 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20347 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20354 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20362 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20370 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20388 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20396 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20404 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20412 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20420 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20438 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20446 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20453 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20461 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20479 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20487 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20495 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20503 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20511 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20529 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20545 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20560 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20586 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20602 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20610 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20628 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20636 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20644 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20651 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20669 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20677 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20685 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20693 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20701 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20719 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20727 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20735 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20743 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20750 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20768 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20784 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20792 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20800 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20818 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20826 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20834 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20859 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20867 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20875 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20883 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20891 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20909 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20917 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20925 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20933 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20941 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20958 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20966 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20974 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity20982 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21006 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21014 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21022 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21030 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21048 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21063 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21089 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21097 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21105 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21113 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21121 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21139 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21147 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21154 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21162 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21188 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21196 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21204 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21212 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21220 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21238 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21246 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21253 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21261 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21279 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21295 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21311 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21337 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21352 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21378 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21386 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21394 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21402 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21410 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21428 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21436 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21444 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21451 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21469 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21485 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21493 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21501 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21519 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21527 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21535 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21550 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21568 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21576 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21584 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21592 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21600 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21618 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21626 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21634 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21659 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21667 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21675 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21683 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21691 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21709 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21717 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21725 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21733 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21741 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21758 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21766 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21782 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21808 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21824 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21840 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity21865 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedethnicity25007 -> "urn:oid:2.16.840.1.113883.6.238"
    DetailedethnicityAsku ->
      "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
    DetailedethnicityOth ->
      "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
    DetailedethnicityUnk ->
      "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
  }
}

pub type Detailedrace {
  Detailedrace10009
  Detailedrace10025
  Detailedrace10041
  Detailedrace10066
  Detailedrace10082
  Detailedrace10108
  Detailedrace10116
  Detailedrace10124
  Detailedrace10132
  Detailedrace10140
  Detailedrace10157
  Detailedrace10165
  Detailedrace10173
  Detailedrace10181
  Detailedrace10199
  Detailedrace10215
  Detailedrace10223
  Detailedrace10231
  Detailedrace10249
  Detailedrace10264
  Detailedrace10280
  Detailedrace10306
  Detailedrace10314
  Detailedrace10330
  Detailedrace10355
  Detailedrace10371
  Detailedrace10397
  Detailedrace10413
  Detailedrace10421
  Detailedrace10447
  Detailedrace10454
  Detailedrace10462
  Detailedrace10470
  Detailedrace10488
  Detailedrace10496
  Detailedrace10504
  Detailedrace10512
  Detailedrace10538
  Detailedrace10546
  Detailedrace10553
  Detailedrace10561
  Detailedrace10579
  Detailedrace10587
  Detailedrace10595
  Detailedrace10603
  Detailedrace10611
  Detailedrace10629
  Detailedrace10637
  Detailedrace10645
  Detailedrace10652
  Detailedrace10660
  Detailedrace10686
  Detailedrace10694
  Detailedrace10702
  Detailedrace10710
  Detailedrace10728
  Detailedrace10736
  Detailedrace10744
  Detailedrace10769
  Detailedrace10785
  Detailedrace10801
  Detailedrace10827
  Detailedrace10835
  Detailedrace10843
  Detailedrace10868
  Detailedrace10884
  Detailedrace10892
  Detailedrace10900
  Detailedrace10918
  Detailedrace10926
  Detailedrace10934
  Detailedrace10942
  Detailedrace10959
  Detailedrace10967
  Detailedrace10975
  Detailedrace10983
  Detailedrace11007
  Detailedrace11023
  Detailedrace11031
  Detailedrace11049
  Detailedrace11064
  Detailedrace11080
  Detailedrace11098
  Detailedrace11106
  Detailedrace11122
  Detailedrace11148
  Detailedrace11155
  Detailedrace11163
  Detailedrace11171
  Detailedrace11189
  Detailedrace11197
  Detailedrace11205
  Detailedrace11213
  Detailedrace11239
  Detailedrace11247
  Detailedrace11254
  Detailedrace11262
  Detailedrace11270
  Detailedrace11288
  Detailedrace11296
  Detailedrace11304
  Detailedrace11312
  Detailedrace11320
  Detailedrace11338
  Detailedrace11346
  Detailedrace11353
  Detailedrace11361
  Detailedrace11379
  Detailedrace11387
  Detailedrace11395
  Detailedrace11403
  Detailedrace11411
  Detailedrace11429
  Detailedrace11437
  Detailedrace11445
  Detailedrace11452
  Detailedrace11460
  Detailedrace11478
  Detailedrace11486
  Detailedrace11502
  Detailedrace11510
  Detailedrace11536
  Detailedrace11551
  Detailedrace11569
  Detailedrace11577
  Detailedrace11585
  Detailedrace11593
  Detailedrace11601
  Detailedrace11627
  Detailedrace11635
  Detailedrace11650
  Detailedrace11676
  Detailedrace11692
  Detailedrace11718
  Detailedrace11734
  Detailedrace11759
  Detailedrace11767
  Detailedrace11783
  Detailedrace11809
  Detailedrace11825
  Detailedrace11841
  Detailedrace11866
  Detailedrace11874
  Detailedrace11890
  Detailedrace11916
  Detailedrace11932
  Detailedrace11940
  Detailedrace11957
  Detailedrace11965
  Detailedrace11973
  Detailedrace11981
  Detailedrace11999
  Detailedrace12005
  Detailedrace12013
  Detailedrace12021
  Detailedrace12039
  Detailedrace12047
  Detailedrace12054
  Detailedrace12070
  Detailedrace12096
  Detailedrace12112
  Detailedrace12120
  Detailedrace12146
  Detailedrace12153
  Detailedrace12161
  Detailedrace12179
  Detailedrace12187
  Detailedrace12195
  Detailedrace12203
  Detailedrace12229
  Detailedrace12237
  Detailedrace12245
  Detailedrace12252
  Detailedrace12260
  Detailedrace12278
  Detailedrace12286
  Detailedrace12294
  Detailedrace12302
  Detailedrace12310
  Detailedrace12336
  Detailedrace12344
  Detailedrace12351
  Detailedrace12369
  Detailedrace12377
  Detailedrace12385
  Detailedrace12393
  Detailedrace12401
  Detailedrace12419
  Detailedrace12427
  Detailedrace12435
  Detailedrace12443
  Detailedrace12450
  Detailedrace12468
  Detailedrace12476
  Detailedrace12484
  Detailedrace12500
  Detailedrace12526
  Detailedrace12542
  Detailedrace12567
  Detailedrace12583
  Detailedrace12609
  Detailedrace12625
  Detailedrace12641
  Detailedrace12658
  Detailedrace12674
  Detailedrace12690
  Detailedrace12716
  Detailedrace12724
  Detailedrace12732
  Detailedrace12757
  Detailedrace12773
  Detailedrace12799
  Detailedrace12815
  Detailedrace12823
  Detailedrace12831
  Detailedrace12856
  Detailedrace12864
  Detailedrace12872
  Detailedrace12880
  Detailedrace12898
  Detailedrace12906
  Detailedrace12914
  Detailedrace12922
  Detailedrace12930
  Detailedrace12948
  Detailedrace12955
  Detailedrace12971
  Detailedrace12997
  Detailedrace13011
  Detailedrace13037
  Detailedrace13052
  Detailedrace13060
  Detailedrace13078
  Detailedrace13094
  Detailedrace13102
  Detailedrace13128
  Detailedrace13136
  Detailedrace13144
  Detailedrace13151
  Detailedrace13177
  Detailedrace13193
  Detailedrace13219
  Detailedrace13235
  Detailedrace13250
  Detailedrace13268
  Detailedrace13276
  Detailedrace13284
  Detailedrace13292
  Detailedrace13318
  Detailedrace13326
  Detailedrace13334
  Detailedrace13342
  Detailedrace13359
  Detailedrace13367
  Detailedrace13375
  Detailedrace13383
  Detailedrace13409
  Detailedrace13425
  Detailedrace13441
  Detailedrace13458
  Detailedrace13466
  Detailedrace13482
  Detailedrace13508
  Detailedrace13524
  Detailedrace13540
  Detailedrace13565
  Detailedrace13581
  Detailedrace13599
  Detailedrace13607
  Detailedrace13615
  Detailedrace13631
  Detailedrace13656
  Detailedrace13664
  Detailedrace13680
  Detailedrace13706
  Detailedrace13722
  Detailedrace13748
  Detailedrace13763
  Detailedrace13789
  Detailedrace13805
  Detailedrace13821
  Detailedrace13839
  Detailedrace13847
  Detailedrace13854
  Detailedrace13870
  Detailedrace13896
  Detailedrace13912
  Detailedrace13920
  Detailedrace13938
  Detailedrace13946
  Detailedrace13953
  Detailedrace13961
  Detailedrace13979
  Detailedrace13987
  Detailedrace13995
  Detailedrace14001
  Detailedrace14019
  Detailedrace14035
  Detailedrace14050
  Detailedrace14076
  Detailedrace14092
  Detailedrace14118
  Detailedrace14126
  Detailedrace14134
  Detailedrace14142
  Detailedrace14167
  Detailedrace14175
  Detailedrace14183
  Detailedrace14191
  Detailedrace14209
  Detailedrace14217
  Detailedrace14225
  Detailedrace14233
  Detailedrace14241
  Detailedrace14258
  Detailedrace14266
  Detailedrace14274
  Detailedrace14282
  Detailedrace14290
  Detailedrace14308
  Detailedrace14316
  Detailedrace14324
  Detailedrace14332
  Detailedrace14340
  Detailedrace14357
  Detailedrace14365
  Detailedrace14373
  Detailedrace14399
  Detailedrace14415
  Detailedrace14423
  Detailedrace14431
  Detailedrace14456
  Detailedrace14464
  Detailedrace14480
  Detailedrace14506
  Detailedrace14514
  Detailedrace14530
  Detailedrace14548
  Detailedrace14563
  Detailedrace14571
  Detailedrace14589
  Detailedrace14605
  Detailedrace14621
  Detailedrace14647
  Detailedrace14654
  Detailedrace14662
  Detailedrace14670
  Detailedrace14688
  Detailedrace14696
  Detailedrace14704
  Detailedrace14712
  Detailedrace14720
  Detailedrace14746
  Detailedrace14753
  Detailedrace14761
  Detailedrace14787
  Detailedrace14795
  Detailedrace14803
  Detailedrace14811
  Detailedrace14829
  Detailedrace14837
  Detailedrace14845
  Detailedrace14852
  Detailedrace14878
  Detailedrace14894
  Detailedrace14902
  Detailedrace14910
  Detailedrace14928
  Detailedrace14936
  Detailedrace14944
  Detailedrace14951
  Detailedrace14969
  Detailedrace14977
  Detailedrace14985
  Detailedrace14993
  Detailedrace15008
  Detailedrace15016
  Detailedrace15024
  Detailedrace15032
  Detailedrace15040
  Detailedrace15057
  Detailedrace15065
  Detailedrace15073
  Detailedrace15081
  Detailedrace15099
  Detailedrace15107
  Detailedrace15115
  Detailedrace15123
  Detailedrace15131
  Detailedrace15149
  Detailedrace15156
  Detailedrace15164
  Detailedrace15180
  Detailedrace15198
  Detailedrace15206
  Detailedrace15214
  Detailedrace15222
  Detailedrace15230
  Detailedrace15248
  Detailedrace15255
  Detailedrace15263
  Detailedrace15271
  Detailedrace15289
  Detailedrace15297
  Detailedrace15305
  Detailedrace15313
  Detailedrace15321
  Detailedrace15339
  Detailedrace15347
  Detailedrace15354
  Detailedrace15362
  Detailedrace15370
  Detailedrace15388
  Detailedrace15396
  Detailedrace15412
  Detailedrace15438
  Detailedrace15453
  Detailedrace15479
  Detailedrace15495
  Detailedrace15511
  Detailedrace15529
  Detailedrace15537
  Detailedrace15545
  Detailedrace15560
  Detailedrace15586
  Detailedrace15602
  Detailedrace15628
  Detailedrace15644
  Detailedrace15669
  Detailedrace15677
  Detailedrace15685
  Detailedrace15693
  Detailedrace15701
  Detailedrace15719
  Detailedrace15735
  Detailedrace15743
  Detailedrace15768
  Detailedrace15784
  Detailedrace15792
  Detailedrace15800
  Detailedrace15826
  Detailedrace15842
  Detailedrace15867
  Detailedrace15875
  Detailedrace15883
  Detailedrace15891
  Detailedrace15909
  Detailedrace15917
  Detailedrace15925
  Detailedrace15933
  Detailedrace15941
  Detailedrace15958
  Detailedrace15966
  Detailedrace15974
  Detailedrace15982
  Detailedrace15990
  Detailedrace16006
  Detailedrace16022
  Detailedrace16030
  Detailedrace16048
  Detailedrace16055
  Detailedrace16071
  Detailedrace16097
  Detailedrace16105
  Detailedrace16113
  Detailedrace16121
  Detailedrace16139
  Detailedrace16147
  Detailedrace16154
  Detailedrace16162
  Detailedrace16170
  Detailedrace16188
  Detailedrace16196
  Detailedrace16204
  Detailedrace16212
  Detailedrace16220
  Detailedrace16238
  Detailedrace16246
  Detailedrace16253
  Detailedrace16261
  Detailedrace16279
  Detailedrace16287
  Detailedrace16295
  Detailedrace16303
  Detailedrace16311
  Detailedrace16329
  Detailedrace16337
  Detailedrace16345
  Detailedrace16352
  Detailedrace16360
  Detailedrace16378
  Detailedrace16386
  Detailedrace16394
  Detailedrace16402
  Detailedrace16410
  Detailedrace16436
  Detailedrace16451
  Detailedrace16477
  Detailedrace16493
  Detailedrace16519
  Detailedrace16535
  Detailedrace16543
  Detailedrace16550
  Detailedrace16568
  Detailedrace16576
  Detailedrace16592
  Detailedrace16618
  Detailedrace16634
  Detailedrace16659
  Detailedrace16675
  Detailedrace16683
  Detailedrace16709
  Detailedrace16717
  Detailedrace16725
  Detailedrace16733
  Detailedrace16758
  Detailedrace16774
  Detailedrace16790
  Detailedrace16808
  Detailedrace16816
  Detailedrace16832
  Detailedrace16857
  Detailedrace16873
  Detailedrace16881
  Detailedrace16899
  Detailedrace16907
  Detailedrace16923
  Detailedrace16949
  Detailedrace16964
  Detailedrace16972
  Detailedrace16980
  Detailedrace17004
  Detailedrace17020
  Detailedrace17046
  Detailedrace17053
  Detailedrace17079
  Detailedrace17095
  Detailedrace17111
  Detailedrace17129
  Detailedrace17137
  Detailedrace17152
  Detailedrace17178
  Detailedrace17186
  Detailedrace17194
  Detailedrace17202
  Detailedrace17228
  Detailedrace17244
  Detailedrace17251
  Detailedrace17269
  Detailedrace17277
  Detailedrace17285
  Detailedrace17293
  Detailedrace17301
  Detailedrace17319
  Detailedrace17327
  Detailedrace17335
  Detailedrace17350
  Detailedrace17376
  Detailedrace17392
  Detailedrace17400
  Detailedrace17418
  Detailedrace17426
  Detailedrace17434
  Detailedrace17442
  Detailedrace17459
  Detailedrace17467
  Detailedrace17475
  Detailedrace17483
  Detailedrace17491
  Detailedrace17509
  Detailedrace17517
  Detailedrace17525
  Detailedrace17533
  Detailedrace17541
  Detailedrace17558
  Detailedrace17566
  Detailedrace17574
  Detailedrace17582
  Detailedrace17590
  Detailedrace17608
  Detailedrace17616
  Detailedrace17624
  Detailedrace17632
  Detailedrace17640
  Detailedrace17657
  Detailedrace17665
  Detailedrace17673
  Detailedrace17681
  Detailedrace17699
  Detailedrace17707
  Detailedrace17715
  Detailedrace17723
  Detailedrace17731
  Detailedrace17749
  Detailedrace17756
  Detailedrace17764
  Detailedrace17772
  Detailedrace17780
  Detailedrace17798
  Detailedrace17806
  Detailedrace17814
  Detailedrace17822
  Detailedrace17830
  Detailedrace17848
  Detailedrace17855
  Detailedrace17863
  Detailedrace17871
  Detailedrace17889
  Detailedrace17897
  Detailedrace17905
  Detailedrace17913
  Detailedrace17921
  Detailedrace17939
  Detailedrace17947
  Detailedrace17954
  Detailedrace17962
  Detailedrace17970
  Detailedrace17988
  Detailedrace17996
  Detailedrace18002
  Detailedrace18010
  Detailedrace18028
  Detailedrace18036
  Detailedrace18044
  Detailedrace18051
  Detailedrace18069
  Detailedrace18077
  Detailedrace18085
  Detailedrace18093
  Detailedrace18119
  Detailedrace18135
  Detailedrace18143
  Detailedrace18150
  Detailedrace18168
  Detailedrace18176
  Detailedrace18184
  Detailedrace18192
  Detailedrace18200
  Detailedrace18218
  Detailedrace18226
  Detailedrace18234
  Detailedrace18242
  Detailedrace18259
  Detailedrace18267
  Detailedrace18275
  Detailedrace18283
  Detailedrace18291
  Detailedrace18309
  Detailedrace18317
  Detailedrace18325
  Detailedrace18333
  Detailedrace18341
  Detailedrace18358
  Detailedrace18374
  Detailedrace18382
  Detailedrace18408
  Detailedrace18424
  Detailedrace18440
  Detailedrace18457
  Detailedrace18465
  Detailedrace18473
  Detailedrace18481
  Detailedrace18499
  Detailedrace18507
  Detailedrace18515
  Detailedrace18523
  Detailedrace18531
  Detailedrace18549
  Detailedrace18556
  Detailedrace18564
  Detailedrace18572
  Detailedrace18580
  Detailedrace18598
  Detailedrace18606
  Detailedrace18614
  Detailedrace18622
  Detailedrace18630
  Detailedrace18648
  Detailedrace18655
  Detailedrace18663
  Detailedrace18671
  Detailedrace18689
  Detailedrace18697
  Detailedrace18705
  Detailedrace18713
  Detailedrace18721
  Detailedrace18739
  Detailedrace18747
  Detailedrace18754
  Detailedrace18762
  Detailedrace18770
  Detailedrace18788
  Detailedrace18796
  Detailedrace18804
  Detailedrace18812
  Detailedrace18820
  Detailedrace18838
  Detailedrace18846
  Detailedrace18853
  Detailedrace18861
  Detailedrace18879
  Detailedrace18887
  Detailedrace18895
  Detailedrace18911
  Detailedrace18929
  Detailedrace18937
  Detailedrace18945
  Detailedrace18960
  Detailedrace18978
  Detailedrace18986
  Detailedrace18994
  Detailedrace19000
  Detailedrace19018
  Detailedrace19026
  Detailedrace19034
  Detailedrace19042
  Detailedrace19059
  Detailedrace19067
  Detailedrace19075
  Detailedrace19083
  Detailedrace19091
  Detailedrace19109
  Detailedrace19117
  Detailedrace19125
  Detailedrace19133
  Detailedrace19141
  Detailedrace19158
  Detailedrace19166
  Detailedrace19174
  Detailedrace19182
  Detailedrace19190
  Detailedrace19208
  Detailedrace19216
  Detailedrace19224
  Detailedrace19232
  Detailedrace19240
  Detailedrace19257
  Detailedrace19265
  Detailedrace19273
  Detailedrace19281
  Detailedrace19299
  Detailedrace19307
  Detailedrace19315
  Detailedrace19323
  Detailedrace19331
  Detailedrace19349
  Detailedrace19356
  Detailedrace19364
  Detailedrace19372
  Detailedrace19380
  Detailedrace19398
  Detailedrace19406
  Detailedrace19414
  Detailedrace19422
  Detailedrace19430
  Detailedrace19448
  Detailedrace19455
  Detailedrace19463
  Detailedrace19471
  Detailedrace19489
  Detailedrace19497
  Detailedrace19505
  Detailedrace19513
  Detailedrace19521
  Detailedrace19539
  Detailedrace19547
  Detailedrace19554
  Detailedrace19562
  Detailedrace19570
  Detailedrace19588
  Detailedrace19596
  Detailedrace19604
  Detailedrace19612
  Detailedrace19620
  Detailedrace19638
  Detailedrace19646
  Detailedrace19661
  Detailedrace19687
  Detailedrace19695
  Detailedrace19703
  Detailedrace19729
  Detailedrace19737
  Detailedrace19745
  Detailedrace19752
  Detailedrace19760
  Detailedrace19778
  Detailedrace19786
  Detailedrace19794
  Detailedrace19802
  Detailedrace19810
  Detailedrace19828
  Detailedrace19844
  Detailedrace19851
  Detailedrace19869
  Detailedrace19877
  Detailedrace19885
  Detailedrace19901
  Detailedrace19927
  Detailedrace19935
  Detailedrace19943
  Detailedrace19950
  Detailedrace19968
  Detailedrace19976
  Detailedrace19984
  Detailedrace19992
  Detailedrace20008
  Detailedrace20024
  Detailedrace20040
  Detailedrace20065
  Detailedrace20073
  Detailedrace20081
  Detailedrace20099
  Detailedrace20107
  Detailedrace20115
  Detailedrace20123
  Detailedrace20131
  Detailedrace20149
  Detailedrace20156
  Detailedrace20164
  Detailedrace20172
  Detailedrace20180
  Detailedrace20198
  Detailedrace20206
  Detailedrace20214
  Detailedrace20222
  Detailedrace20230
  Detailedrace20248
  Detailedrace20255
  Detailedrace20263
  Detailedrace20289
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
  Detailedrace20545
  Detailedrace20560
  Detailedrace20586
  Detailedrace20602
  Detailedrace20610
  Detailedrace20628
  Detailedrace20636
  Detailedrace20644
  Detailedrace20651
  Detailedrace20669
  Detailedrace20677
  Detailedrace20685
  Detailedrace20693
  Detailedrace20701
  Detailedrace20719
  Detailedrace20727
  Detailedrace20735
  Detailedrace20743
  Detailedrace20750
  Detailedrace20768
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
  Detailedrace21063
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
  Detailedrace21337
  Detailedrace21352
  Detailedrace21378
  Detailedrace21386
  Detailedrace21394
  Detailedrace21402
  Detailedrace21410
  Detailedrace21428
  Detailedrace21436
  Detailedrace21444
  Detailedrace21451
  Detailedrace21469
  Detailedrace21485
  Detailedrace21493
  Detailedrace21501
  Detailedrace21519
  Detailedrace21527
  Detailedrace21535
  Detailedrace21550
  Detailedrace21568
  Detailedrace21576
  Detailedrace21584
  Detailedrace21592
  Detailedrace21600
  Detailedrace21618
  Detailedrace21626
  Detailedrace21634
  Detailedrace21659
  Detailedrace21667
  Detailedrace21675
  Detailedrace21683
  Detailedrace21691
  Detailedrace21709
  Detailedrace21717
  Detailedrace21725
  Detailedrace21733
  Detailedrace21741
  Detailedrace21758
  Detailedrace21766
  Detailedrace21782
  Detailedrace21808
  Detailedrace21824
  Detailedrace21840
  Detailedrace21865
  Detailedrace25007
  DetailedraceAsku
  DetailedraceOth
  DetailedraceUnk
}

pub fn detailedrace_to_json(detailedrace: Detailedrace) -> Json {
  json.string(detailedrace_to_code(detailedrace))
}

pub fn detailedrace_to_code(detailedrace: Detailedrace) -> String {
  case detailedrace {
    Detailedrace10009 -> "1000-9"
    Detailedrace10025 -> "1002-5"
    Detailedrace10041 -> "1004-1"
    Detailedrace10066 -> "1006-6"
    Detailedrace10082 -> "1008-2"
    Detailedrace10108 -> "1010-8"
    Detailedrace10116 -> "1011-6"
    Detailedrace10124 -> "1012-4"
    Detailedrace10132 -> "1013-2"
    Detailedrace10140 -> "1014-0"
    Detailedrace10157 -> "1015-7"
    Detailedrace10165 -> "1016-5"
    Detailedrace10173 -> "1017-3"
    Detailedrace10181 -> "1018-1"
    Detailedrace10199 -> "1019-9"
    Detailedrace10215 -> "1021-5"
    Detailedrace10223 -> "1022-3"
    Detailedrace10231 -> "1023-1"
    Detailedrace10249 -> "1024-9"
    Detailedrace10264 -> "1026-4"
    Detailedrace10280 -> "1028-0"
    Detailedrace10306 -> "1030-6"
    Detailedrace10314 -> "1031-4"
    Detailedrace10330 -> "1033-0"
    Detailedrace10355 -> "1035-5"
    Detailedrace10371 -> "1037-1"
    Detailedrace10397 -> "1039-7"
    Detailedrace10413 -> "1041-3"
    Detailedrace10421 -> "1042-1"
    Detailedrace10447 -> "1044-7"
    Detailedrace10454 -> "1045-4"
    Detailedrace10462 -> "1046-2"
    Detailedrace10470 -> "1047-0"
    Detailedrace10488 -> "1048-8"
    Detailedrace10496 -> "1049-6"
    Detailedrace10504 -> "1050-4"
    Detailedrace10512 -> "1051-2"
    Detailedrace10538 -> "1053-8"
    Detailedrace10546 -> "1054-6"
    Detailedrace10553 -> "1055-3"
    Detailedrace10561 -> "1056-1"
    Detailedrace10579 -> "1057-9"
    Detailedrace10587 -> "1058-7"
    Detailedrace10595 -> "1059-5"
    Detailedrace10603 -> "1060-3"
    Detailedrace10611 -> "1061-1"
    Detailedrace10629 -> "1062-9"
    Detailedrace10637 -> "1063-7"
    Detailedrace10645 -> "1064-5"
    Detailedrace10652 -> "1065-2"
    Detailedrace10660 -> "1066-0"
    Detailedrace10686 -> "1068-6"
    Detailedrace10694 -> "1069-4"
    Detailedrace10702 -> "1070-2"
    Detailedrace10710 -> "1071-0"
    Detailedrace10728 -> "1072-8"
    Detailedrace10736 -> "1073-6"
    Detailedrace10744 -> "1074-4"
    Detailedrace10769 -> "1076-9"
    Detailedrace10785 -> "1078-5"
    Detailedrace10801 -> "1080-1"
    Detailedrace10827 -> "1082-7"
    Detailedrace10835 -> "1083-5"
    Detailedrace10843 -> "1084-3"
    Detailedrace10868 -> "1086-8"
    Detailedrace10884 -> "1088-4"
    Detailedrace10892 -> "1089-2"
    Detailedrace10900 -> "1090-0"
    Detailedrace10918 -> "1091-8"
    Detailedrace10926 -> "1092-6"
    Detailedrace10934 -> "1093-4"
    Detailedrace10942 -> "1094-2"
    Detailedrace10959 -> "1095-9"
    Detailedrace10967 -> "1096-7"
    Detailedrace10975 -> "1097-5"
    Detailedrace10983 -> "1098-3"
    Detailedrace11007 -> "1100-7"
    Detailedrace11023 -> "1102-3"
    Detailedrace11031 -> "1103-1"
    Detailedrace11049 -> "1104-9"
    Detailedrace11064 -> "1106-4"
    Detailedrace11080 -> "1108-0"
    Detailedrace11098 -> "1109-8"
    Detailedrace11106 -> "1110-6"
    Detailedrace11122 -> "1112-2"
    Detailedrace11148 -> "1114-8"
    Detailedrace11155 -> "1115-5"
    Detailedrace11163 -> "1116-3"
    Detailedrace11171 -> "1117-1"
    Detailedrace11189 -> "1118-9"
    Detailedrace11197 -> "1119-7"
    Detailedrace11205 -> "1120-5"
    Detailedrace11213 -> "1121-3"
    Detailedrace11239 -> "1123-9"
    Detailedrace11247 -> "1124-7"
    Detailedrace11254 -> "1125-4"
    Detailedrace11262 -> "1126-2"
    Detailedrace11270 -> "1127-0"
    Detailedrace11288 -> "1128-8"
    Detailedrace11296 -> "1129-6"
    Detailedrace11304 -> "1130-4"
    Detailedrace11312 -> "1131-2"
    Detailedrace11320 -> "1132-0"
    Detailedrace11338 -> "1133-8"
    Detailedrace11346 -> "1134-6"
    Detailedrace11353 -> "1135-3"
    Detailedrace11361 -> "1136-1"
    Detailedrace11379 -> "1137-9"
    Detailedrace11387 -> "1138-7"
    Detailedrace11395 -> "1139-5"
    Detailedrace11403 -> "1140-3"
    Detailedrace11411 -> "1141-1"
    Detailedrace11429 -> "1142-9"
    Detailedrace11437 -> "1143-7"
    Detailedrace11445 -> "1144-5"
    Detailedrace11452 -> "1145-2"
    Detailedrace11460 -> "1146-0"
    Detailedrace11478 -> "1147-8"
    Detailedrace11486 -> "1148-6"
    Detailedrace11502 -> "1150-2"
    Detailedrace11510 -> "1151-0"
    Detailedrace11536 -> "1153-6"
    Detailedrace11551 -> "1155-1"
    Detailedrace11569 -> "1156-9"
    Detailedrace11577 -> "1157-7"
    Detailedrace11585 -> "1158-5"
    Detailedrace11593 -> "1159-3"
    Detailedrace11601 -> "1160-1"
    Detailedrace11627 -> "1162-7"
    Detailedrace11635 -> "1163-5"
    Detailedrace11650 -> "1165-0"
    Detailedrace11676 -> "1167-6"
    Detailedrace11692 -> "1169-2"
    Detailedrace11718 -> "1171-8"
    Detailedrace11734 -> "1173-4"
    Detailedrace11759 -> "1175-9"
    Detailedrace11767 -> "1176-7"
    Detailedrace11783 -> "1178-3"
    Detailedrace11809 -> "1180-9"
    Detailedrace11825 -> "1182-5"
    Detailedrace11841 -> "1184-1"
    Detailedrace11866 -> "1186-6"
    Detailedrace11874 -> "1187-4"
    Detailedrace11890 -> "1189-0"
    Detailedrace11916 -> "1191-6"
    Detailedrace11932 -> "1193-2"
    Detailedrace11940 -> "1194-0"
    Detailedrace11957 -> "1195-7"
    Detailedrace11965 -> "1196-5"
    Detailedrace11973 -> "1197-3"
    Detailedrace11981 -> "1198-1"
    Detailedrace11999 -> "1199-9"
    Detailedrace12005 -> "1200-5"
    Detailedrace12013 -> "1201-3"
    Detailedrace12021 -> "1202-1"
    Detailedrace12039 -> "1203-9"
    Detailedrace12047 -> "1204-7"
    Detailedrace12054 -> "1205-4"
    Detailedrace12070 -> "1207-0"
    Detailedrace12096 -> "1209-6"
    Detailedrace12112 -> "1211-2"
    Detailedrace12120 -> "1212-0"
    Detailedrace12146 -> "1214-6"
    Detailedrace12153 -> "1215-3"
    Detailedrace12161 -> "1216-1"
    Detailedrace12179 -> "1217-9"
    Detailedrace12187 -> "1218-7"
    Detailedrace12195 -> "1219-5"
    Detailedrace12203 -> "1220-3"
    Detailedrace12229 -> "1222-9"
    Detailedrace12237 -> "1223-7"
    Detailedrace12245 -> "1224-5"
    Detailedrace12252 -> "1225-2"
    Detailedrace12260 -> "1226-0"
    Detailedrace12278 -> "1227-8"
    Detailedrace12286 -> "1228-6"
    Detailedrace12294 -> "1229-4"
    Detailedrace12302 -> "1230-2"
    Detailedrace12310 -> "1231-0"
    Detailedrace12336 -> "1233-6"
    Detailedrace12344 -> "1234-4"
    Detailedrace12351 -> "1235-1"
    Detailedrace12369 -> "1236-9"
    Detailedrace12377 -> "1237-7"
    Detailedrace12385 -> "1238-5"
    Detailedrace12393 -> "1239-3"
    Detailedrace12401 -> "1240-1"
    Detailedrace12419 -> "1241-9"
    Detailedrace12427 -> "1242-7"
    Detailedrace12435 -> "1243-5"
    Detailedrace12443 -> "1244-3"
    Detailedrace12450 -> "1245-0"
    Detailedrace12468 -> "1246-8"
    Detailedrace12476 -> "1247-6"
    Detailedrace12484 -> "1248-4"
    Detailedrace12500 -> "1250-0"
    Detailedrace12526 -> "1252-6"
    Detailedrace12542 -> "1254-2"
    Detailedrace12567 -> "1256-7"
    Detailedrace12583 -> "1258-3"
    Detailedrace12609 -> "1260-9"
    Detailedrace12625 -> "1262-5"
    Detailedrace12641 -> "1264-1"
    Detailedrace12658 -> "1265-8"
    Detailedrace12674 -> "1267-4"
    Detailedrace12690 -> "1269-0"
    Detailedrace12716 -> "1271-6"
    Detailedrace12724 -> "1272-4"
    Detailedrace12732 -> "1273-2"
    Detailedrace12757 -> "1275-7"
    Detailedrace12773 -> "1277-3"
    Detailedrace12799 -> "1279-9"
    Detailedrace12815 -> "1281-5"
    Detailedrace12823 -> "1282-3"
    Detailedrace12831 -> "1283-1"
    Detailedrace12856 -> "1285-6"
    Detailedrace12864 -> "1286-4"
    Detailedrace12872 -> "1287-2"
    Detailedrace12880 -> "1288-0"
    Detailedrace12898 -> "1289-8"
    Detailedrace12906 -> "1290-6"
    Detailedrace12914 -> "1291-4"
    Detailedrace12922 -> "1292-2"
    Detailedrace12930 -> "1293-0"
    Detailedrace12948 -> "1294-8"
    Detailedrace12955 -> "1295-5"
    Detailedrace12971 -> "1297-1"
    Detailedrace12997 -> "1299-7"
    Detailedrace13011 -> "1301-1"
    Detailedrace13037 -> "1303-7"
    Detailedrace13052 -> "1305-2"
    Detailedrace13060 -> "1306-0"
    Detailedrace13078 -> "1307-8"
    Detailedrace13094 -> "1309-4"
    Detailedrace13102 -> "1310-2"
    Detailedrace13128 -> "1312-8"
    Detailedrace13136 -> "1313-6"
    Detailedrace13144 -> "1314-4"
    Detailedrace13151 -> "1315-1"
    Detailedrace13177 -> "1317-7"
    Detailedrace13193 -> "1319-3"
    Detailedrace13219 -> "1321-9"
    Detailedrace13235 -> "1323-5"
    Detailedrace13250 -> "1325-0"
    Detailedrace13268 -> "1326-8"
    Detailedrace13276 -> "1327-6"
    Detailedrace13284 -> "1328-4"
    Detailedrace13292 -> "1329-2"
    Detailedrace13318 -> "1331-8"
    Detailedrace13326 -> "1332-6"
    Detailedrace13334 -> "1333-4"
    Detailedrace13342 -> "1334-2"
    Detailedrace13359 -> "1335-9"
    Detailedrace13367 -> "1336-7"
    Detailedrace13375 -> "1337-5"
    Detailedrace13383 -> "1338-3"
    Detailedrace13409 -> "1340-9"
    Detailedrace13425 -> "1342-5"
    Detailedrace13441 -> "1344-1"
    Detailedrace13458 -> "1345-8"
    Detailedrace13466 -> "1346-6"
    Detailedrace13482 -> "1348-2"
    Detailedrace13508 -> "1350-8"
    Detailedrace13524 -> "1352-4"
    Detailedrace13540 -> "1354-0"
    Detailedrace13565 -> "1356-5"
    Detailedrace13581 -> "1358-1"
    Detailedrace13599 -> "1359-9"
    Detailedrace13607 -> "1360-7"
    Detailedrace13615 -> "1361-5"
    Detailedrace13631 -> "1363-1"
    Detailedrace13656 -> "1365-6"
    Detailedrace13664 -> "1366-4"
    Detailedrace13680 -> "1368-0"
    Detailedrace13706 -> "1370-6"
    Detailedrace13722 -> "1372-2"
    Detailedrace13748 -> "1374-8"
    Detailedrace13763 -> "1376-3"
    Detailedrace13789 -> "1378-9"
    Detailedrace13805 -> "1380-5"
    Detailedrace13821 -> "1382-1"
    Detailedrace13839 -> "1383-9"
    Detailedrace13847 -> "1384-7"
    Detailedrace13854 -> "1385-4"
    Detailedrace13870 -> "1387-0"
    Detailedrace13896 -> "1389-6"
    Detailedrace13912 -> "1391-2"
    Detailedrace13920 -> "1392-0"
    Detailedrace13938 -> "1393-8"
    Detailedrace13946 -> "1394-6"
    Detailedrace13953 -> "1395-3"
    Detailedrace13961 -> "1396-1"
    Detailedrace13979 -> "1397-9"
    Detailedrace13987 -> "1398-7"
    Detailedrace13995 -> "1399-5"
    Detailedrace14001 -> "1400-1"
    Detailedrace14019 -> "1401-9"
    Detailedrace14035 -> "1403-5"
    Detailedrace14050 -> "1405-0"
    Detailedrace14076 -> "1407-6"
    Detailedrace14092 -> "1409-2"
    Detailedrace14118 -> "1411-8"
    Detailedrace14126 -> "1412-6"
    Detailedrace14134 -> "1413-4"
    Detailedrace14142 -> "1414-2"
    Detailedrace14167 -> "1416-7"
    Detailedrace14175 -> "1417-5"
    Detailedrace14183 -> "1418-3"
    Detailedrace14191 -> "1419-1"
    Detailedrace14209 -> "1420-9"
    Detailedrace14217 -> "1421-7"
    Detailedrace14225 -> "1422-5"
    Detailedrace14233 -> "1423-3"
    Detailedrace14241 -> "1424-1"
    Detailedrace14258 -> "1425-8"
    Detailedrace14266 -> "1426-6"
    Detailedrace14274 -> "1427-4"
    Detailedrace14282 -> "1428-2"
    Detailedrace14290 -> "1429-0"
    Detailedrace14308 -> "1430-8"
    Detailedrace14316 -> "1431-6"
    Detailedrace14324 -> "1432-4"
    Detailedrace14332 -> "1433-2"
    Detailedrace14340 -> "1434-0"
    Detailedrace14357 -> "1435-7"
    Detailedrace14365 -> "1436-5"
    Detailedrace14373 -> "1437-3"
    Detailedrace14399 -> "1439-9"
    Detailedrace14415 -> "1441-5"
    Detailedrace14423 -> "1442-3"
    Detailedrace14431 -> "1443-1"
    Detailedrace14456 -> "1445-6"
    Detailedrace14464 -> "1446-4"
    Detailedrace14480 -> "1448-0"
    Detailedrace14506 -> "1450-6"
    Detailedrace14514 -> "1451-4"
    Detailedrace14530 -> "1453-0"
    Detailedrace14548 -> "1454-8"
    Detailedrace14563 -> "1456-3"
    Detailedrace14571 -> "1457-1"
    Detailedrace14589 -> "1458-9"
    Detailedrace14605 -> "1460-5"
    Detailedrace14621 -> "1462-1"
    Detailedrace14647 -> "1464-7"
    Detailedrace14654 -> "1465-4"
    Detailedrace14662 -> "1466-2"
    Detailedrace14670 -> "1467-0"
    Detailedrace14688 -> "1468-8"
    Detailedrace14696 -> "1469-6"
    Detailedrace14704 -> "1470-4"
    Detailedrace14712 -> "1471-2"
    Detailedrace14720 -> "1472-0"
    Detailedrace14746 -> "1474-6"
    Detailedrace14753 -> "1475-3"
    Detailedrace14761 -> "1476-1"
    Detailedrace14787 -> "1478-7"
    Detailedrace14795 -> "1479-5"
    Detailedrace14803 -> "1480-3"
    Detailedrace14811 -> "1481-1"
    Detailedrace14829 -> "1482-9"
    Detailedrace14837 -> "1483-7"
    Detailedrace14845 -> "1484-5"
    Detailedrace14852 -> "1485-2"
    Detailedrace14878 -> "1487-8"
    Detailedrace14894 -> "1489-4"
    Detailedrace14902 -> "1490-2"
    Detailedrace14910 -> "1491-0"
    Detailedrace14928 -> "1492-8"
    Detailedrace14936 -> "1493-6"
    Detailedrace14944 -> "1494-4"
    Detailedrace14951 -> "1495-1"
    Detailedrace14969 -> "1496-9"
    Detailedrace14977 -> "1497-7"
    Detailedrace14985 -> "1498-5"
    Detailedrace14993 -> "1499-3"
    Detailedrace15008 -> "1500-8"
    Detailedrace15016 -> "1501-6"
    Detailedrace15024 -> "1502-4"
    Detailedrace15032 -> "1503-2"
    Detailedrace15040 -> "1504-0"
    Detailedrace15057 -> "1505-7"
    Detailedrace15065 -> "1506-5"
    Detailedrace15073 -> "1507-3"
    Detailedrace15081 -> "1508-1"
    Detailedrace15099 -> "1509-9"
    Detailedrace15107 -> "1510-7"
    Detailedrace15115 -> "1511-5"
    Detailedrace15123 -> "1512-3"
    Detailedrace15131 -> "1513-1"
    Detailedrace15149 -> "1514-9"
    Detailedrace15156 -> "1515-6"
    Detailedrace15164 -> "1516-4"
    Detailedrace15180 -> "1518-0"
    Detailedrace15198 -> "1519-8"
    Detailedrace15206 -> "1520-6"
    Detailedrace15214 -> "1521-4"
    Detailedrace15222 -> "1522-2"
    Detailedrace15230 -> "1523-0"
    Detailedrace15248 -> "1524-8"
    Detailedrace15255 -> "1525-5"
    Detailedrace15263 -> "1526-3"
    Detailedrace15271 -> "1527-1"
    Detailedrace15289 -> "1528-9"
    Detailedrace15297 -> "1529-7"
    Detailedrace15305 -> "1530-5"
    Detailedrace15313 -> "1531-3"
    Detailedrace15321 -> "1532-1"
    Detailedrace15339 -> "1533-9"
    Detailedrace15347 -> "1534-7"
    Detailedrace15354 -> "1535-4"
    Detailedrace15362 -> "1536-2"
    Detailedrace15370 -> "1537-0"
    Detailedrace15388 -> "1538-8"
    Detailedrace15396 -> "1539-6"
    Detailedrace15412 -> "1541-2"
    Detailedrace15438 -> "1543-8"
    Detailedrace15453 -> "1545-3"
    Detailedrace15479 -> "1547-9"
    Detailedrace15495 -> "1549-5"
    Detailedrace15511 -> "1551-1"
    Detailedrace15529 -> "1552-9"
    Detailedrace15537 -> "1553-7"
    Detailedrace15545 -> "1554-5"
    Detailedrace15560 -> "1556-0"
    Detailedrace15586 -> "1558-6"
    Detailedrace15602 -> "1560-2"
    Detailedrace15628 -> "1562-8"
    Detailedrace15644 -> "1564-4"
    Detailedrace15669 -> "1566-9"
    Detailedrace15677 -> "1567-7"
    Detailedrace15685 -> "1568-5"
    Detailedrace15693 -> "1569-3"
    Detailedrace15701 -> "1570-1"
    Detailedrace15719 -> "1571-9"
    Detailedrace15735 -> "1573-5"
    Detailedrace15743 -> "1574-3"
    Detailedrace15768 -> "1576-8"
    Detailedrace15784 -> "1578-4"
    Detailedrace15792 -> "1579-2"
    Detailedrace15800 -> "1580-0"
    Detailedrace15826 -> "1582-6"
    Detailedrace15842 -> "1584-2"
    Detailedrace15867 -> "1586-7"
    Detailedrace15875 -> "1587-5"
    Detailedrace15883 -> "1588-3"
    Detailedrace15891 -> "1589-1"
    Detailedrace15909 -> "1590-9"
    Detailedrace15917 -> "1591-7"
    Detailedrace15925 -> "1592-5"
    Detailedrace15933 -> "1593-3"
    Detailedrace15941 -> "1594-1"
    Detailedrace15958 -> "1595-8"
    Detailedrace15966 -> "1596-6"
    Detailedrace15974 -> "1597-4"
    Detailedrace15982 -> "1598-2"
    Detailedrace15990 -> "1599-0"
    Detailedrace16006 -> "1600-6"
    Detailedrace16022 -> "1602-2"
    Detailedrace16030 -> "1603-0"
    Detailedrace16048 -> "1604-8"
    Detailedrace16055 -> "1605-5"
    Detailedrace16071 -> "1607-1"
    Detailedrace16097 -> "1609-7"
    Detailedrace16105 -> "1610-5"
    Detailedrace16113 -> "1611-3"
    Detailedrace16121 -> "1612-1"
    Detailedrace16139 -> "1613-9"
    Detailedrace16147 -> "1614-7"
    Detailedrace16154 -> "1615-4"
    Detailedrace16162 -> "1616-2"
    Detailedrace16170 -> "1617-0"
    Detailedrace16188 -> "1618-8"
    Detailedrace16196 -> "1619-6"
    Detailedrace16204 -> "1620-4"
    Detailedrace16212 -> "1621-2"
    Detailedrace16220 -> "1622-0"
    Detailedrace16238 -> "1623-8"
    Detailedrace16246 -> "1624-6"
    Detailedrace16253 -> "1625-3"
    Detailedrace16261 -> "1626-1"
    Detailedrace16279 -> "1627-9"
    Detailedrace16287 -> "1628-7"
    Detailedrace16295 -> "1629-5"
    Detailedrace16303 -> "1630-3"
    Detailedrace16311 -> "1631-1"
    Detailedrace16329 -> "1632-9"
    Detailedrace16337 -> "1633-7"
    Detailedrace16345 -> "1634-5"
    Detailedrace16352 -> "1635-2"
    Detailedrace16360 -> "1636-0"
    Detailedrace16378 -> "1637-8"
    Detailedrace16386 -> "1638-6"
    Detailedrace16394 -> "1639-4"
    Detailedrace16402 -> "1640-2"
    Detailedrace16410 -> "1641-0"
    Detailedrace16436 -> "1643-6"
    Detailedrace16451 -> "1645-1"
    Detailedrace16477 -> "1647-7"
    Detailedrace16493 -> "1649-3"
    Detailedrace16519 -> "1651-9"
    Detailedrace16535 -> "1653-5"
    Detailedrace16543 -> "1654-3"
    Detailedrace16550 -> "1655-0"
    Detailedrace16568 -> "1656-8"
    Detailedrace16576 -> "1657-6"
    Detailedrace16592 -> "1659-2"
    Detailedrace16618 -> "1661-8"
    Detailedrace16634 -> "1663-4"
    Detailedrace16659 -> "1665-9"
    Detailedrace16675 -> "1667-5"
    Detailedrace16683 -> "1668-3"
    Detailedrace16709 -> "1670-9"
    Detailedrace16717 -> "1671-7"
    Detailedrace16725 -> "1672-5"
    Detailedrace16733 -> "1673-3"
    Detailedrace16758 -> "1675-8"
    Detailedrace16774 -> "1677-4"
    Detailedrace16790 -> "1679-0"
    Detailedrace16808 -> "1680-8"
    Detailedrace16816 -> "1681-6"
    Detailedrace16832 -> "1683-2"
    Detailedrace16857 -> "1685-7"
    Detailedrace16873 -> "1687-3"
    Detailedrace16881 -> "1688-1"
    Detailedrace16899 -> "1689-9"
    Detailedrace16907 -> "1690-7"
    Detailedrace16923 -> "1692-3"
    Detailedrace16949 -> "1694-9"
    Detailedrace16964 -> "1696-4"
    Detailedrace16972 -> "1697-2"
    Detailedrace16980 -> "1698-0"
    Detailedrace17004 -> "1700-4"
    Detailedrace17020 -> "1702-0"
    Detailedrace17046 -> "1704-6"
    Detailedrace17053 -> "1705-3"
    Detailedrace17079 -> "1707-9"
    Detailedrace17095 -> "1709-5"
    Detailedrace17111 -> "1711-1"
    Detailedrace17129 -> "1712-9"
    Detailedrace17137 -> "1713-7"
    Detailedrace17152 -> "1715-2"
    Detailedrace17178 -> "1717-8"
    Detailedrace17186 -> "1718-6"
    Detailedrace17194 -> "1719-4"
    Detailedrace17202 -> "1720-2"
    Detailedrace17228 -> "1722-8"
    Detailedrace17244 -> "1724-4"
    Detailedrace17251 -> "1725-1"
    Detailedrace17269 -> "1726-9"
    Detailedrace17277 -> "1727-7"
    Detailedrace17285 -> "1728-5"
    Detailedrace17293 -> "1729-3"
    Detailedrace17301 -> "1730-1"
    Detailedrace17319 -> "1731-9"
    Detailedrace17327 -> "1732-7"
    Detailedrace17335 -> "1733-5"
    Detailedrace17350 -> "1735-0"
    Detailedrace17376 -> "1737-6"
    Detailedrace17392 -> "1739-2"
    Detailedrace17400 -> "1740-0"
    Detailedrace17418 -> "1741-8"
    Detailedrace17426 -> "1742-6"
    Detailedrace17434 -> "1743-4"
    Detailedrace17442 -> "1744-2"
    Detailedrace17459 -> "1745-9"
    Detailedrace17467 -> "1746-7"
    Detailedrace17475 -> "1747-5"
    Detailedrace17483 -> "1748-3"
    Detailedrace17491 -> "1749-1"
    Detailedrace17509 -> "1750-9"
    Detailedrace17517 -> "1751-7"
    Detailedrace17525 -> "1752-5"
    Detailedrace17533 -> "1753-3"
    Detailedrace17541 -> "1754-1"
    Detailedrace17558 -> "1755-8"
    Detailedrace17566 -> "1756-6"
    Detailedrace17574 -> "1757-4"
    Detailedrace17582 -> "1758-2"
    Detailedrace17590 -> "1759-0"
    Detailedrace17608 -> "1760-8"
    Detailedrace17616 -> "1761-6"
    Detailedrace17624 -> "1762-4"
    Detailedrace17632 -> "1763-2"
    Detailedrace17640 -> "1764-0"
    Detailedrace17657 -> "1765-7"
    Detailedrace17665 -> "1766-5"
    Detailedrace17673 -> "1767-3"
    Detailedrace17681 -> "1768-1"
    Detailedrace17699 -> "1769-9"
    Detailedrace17707 -> "1770-7"
    Detailedrace17715 -> "1771-5"
    Detailedrace17723 -> "1772-3"
    Detailedrace17731 -> "1773-1"
    Detailedrace17749 -> "1774-9"
    Detailedrace17756 -> "1775-6"
    Detailedrace17764 -> "1776-4"
    Detailedrace17772 -> "1777-2"
    Detailedrace17780 -> "1778-0"
    Detailedrace17798 -> "1779-8"
    Detailedrace17806 -> "1780-6"
    Detailedrace17814 -> "1781-4"
    Detailedrace17822 -> "1782-2"
    Detailedrace17830 -> "1783-0"
    Detailedrace17848 -> "1784-8"
    Detailedrace17855 -> "1785-5"
    Detailedrace17863 -> "1786-3"
    Detailedrace17871 -> "1787-1"
    Detailedrace17889 -> "1788-9"
    Detailedrace17897 -> "1789-7"
    Detailedrace17905 -> "1790-5"
    Detailedrace17913 -> "1791-3"
    Detailedrace17921 -> "1792-1"
    Detailedrace17939 -> "1793-9"
    Detailedrace17947 -> "1794-7"
    Detailedrace17954 -> "1795-4"
    Detailedrace17962 -> "1796-2"
    Detailedrace17970 -> "1797-0"
    Detailedrace17988 -> "1798-8"
    Detailedrace17996 -> "1799-6"
    Detailedrace18002 -> "1800-2"
    Detailedrace18010 -> "1801-0"
    Detailedrace18028 -> "1802-8"
    Detailedrace18036 -> "1803-6"
    Detailedrace18044 -> "1804-4"
    Detailedrace18051 -> "1805-1"
    Detailedrace18069 -> "1806-9"
    Detailedrace18077 -> "1807-7"
    Detailedrace18085 -> "1808-5"
    Detailedrace18093 -> "1809-3"
    Detailedrace18119 -> "1811-9"
    Detailedrace18135 -> "1813-5"
    Detailedrace18143 -> "1814-3"
    Detailedrace18150 -> "1815-0"
    Detailedrace18168 -> "1816-8"
    Detailedrace18176 -> "1817-6"
    Detailedrace18184 -> "1818-4"
    Detailedrace18192 -> "1819-2"
    Detailedrace18200 -> "1820-0"
    Detailedrace18218 -> "1821-8"
    Detailedrace18226 -> "1822-6"
    Detailedrace18234 -> "1823-4"
    Detailedrace18242 -> "1824-2"
    Detailedrace18259 -> "1825-9"
    Detailedrace18267 -> "1826-7"
    Detailedrace18275 -> "1827-5"
    Detailedrace18283 -> "1828-3"
    Detailedrace18291 -> "1829-1"
    Detailedrace18309 -> "1830-9"
    Detailedrace18317 -> "1831-7"
    Detailedrace18325 -> "1832-5"
    Detailedrace18333 -> "1833-3"
    Detailedrace18341 -> "1834-1"
    Detailedrace18358 -> "1835-8"
    Detailedrace18374 -> "1837-4"
    Detailedrace18382 -> "1838-2"
    Detailedrace18408 -> "1840-8"
    Detailedrace18424 -> "1842-4"
    Detailedrace18440 -> "1844-0"
    Detailedrace18457 -> "1845-7"
    Detailedrace18465 -> "1846-5"
    Detailedrace18473 -> "1847-3"
    Detailedrace18481 -> "1848-1"
    Detailedrace18499 -> "1849-9"
    Detailedrace18507 -> "1850-7"
    Detailedrace18515 -> "1851-5"
    Detailedrace18523 -> "1852-3"
    Detailedrace18531 -> "1853-1"
    Detailedrace18549 -> "1854-9"
    Detailedrace18556 -> "1855-6"
    Detailedrace18564 -> "1856-4"
    Detailedrace18572 -> "1857-2"
    Detailedrace18580 -> "1858-0"
    Detailedrace18598 -> "1859-8"
    Detailedrace18606 -> "1860-6"
    Detailedrace18614 -> "1861-4"
    Detailedrace18622 -> "1862-2"
    Detailedrace18630 -> "1863-0"
    Detailedrace18648 -> "1864-8"
    Detailedrace18655 -> "1865-5"
    Detailedrace18663 -> "1866-3"
    Detailedrace18671 -> "1867-1"
    Detailedrace18689 -> "1868-9"
    Detailedrace18697 -> "1869-7"
    Detailedrace18705 -> "1870-5"
    Detailedrace18713 -> "1871-3"
    Detailedrace18721 -> "1872-1"
    Detailedrace18739 -> "1873-9"
    Detailedrace18747 -> "1874-7"
    Detailedrace18754 -> "1875-4"
    Detailedrace18762 -> "1876-2"
    Detailedrace18770 -> "1877-0"
    Detailedrace18788 -> "1878-8"
    Detailedrace18796 -> "1879-6"
    Detailedrace18804 -> "1880-4"
    Detailedrace18812 -> "1881-2"
    Detailedrace18820 -> "1882-0"
    Detailedrace18838 -> "1883-8"
    Detailedrace18846 -> "1884-6"
    Detailedrace18853 -> "1885-3"
    Detailedrace18861 -> "1886-1"
    Detailedrace18879 -> "1887-9"
    Detailedrace18887 -> "1888-7"
    Detailedrace18895 -> "1889-5"
    Detailedrace18911 -> "1891-1"
    Detailedrace18929 -> "1892-9"
    Detailedrace18937 -> "1893-7"
    Detailedrace18945 -> "1894-5"
    Detailedrace18960 -> "1896-0"
    Detailedrace18978 -> "1897-8"
    Detailedrace18986 -> "1898-6"
    Detailedrace18994 -> "1899-4"
    Detailedrace19000 -> "1900-0"
    Detailedrace19018 -> "1901-8"
    Detailedrace19026 -> "1902-6"
    Detailedrace19034 -> "1903-4"
    Detailedrace19042 -> "1904-2"
    Detailedrace19059 -> "1905-9"
    Detailedrace19067 -> "1906-7"
    Detailedrace19075 -> "1907-5"
    Detailedrace19083 -> "1908-3"
    Detailedrace19091 -> "1909-1"
    Detailedrace19109 -> "1910-9"
    Detailedrace19117 -> "1911-7"
    Detailedrace19125 -> "1912-5"
    Detailedrace19133 -> "1913-3"
    Detailedrace19141 -> "1914-1"
    Detailedrace19158 -> "1915-8"
    Detailedrace19166 -> "1916-6"
    Detailedrace19174 -> "1917-4"
    Detailedrace19182 -> "1918-2"
    Detailedrace19190 -> "1919-0"
    Detailedrace19208 -> "1920-8"
    Detailedrace19216 -> "1921-6"
    Detailedrace19224 -> "1922-4"
    Detailedrace19232 -> "1923-2"
    Detailedrace19240 -> "1924-0"
    Detailedrace19257 -> "1925-7"
    Detailedrace19265 -> "1926-5"
    Detailedrace19273 -> "1927-3"
    Detailedrace19281 -> "1928-1"
    Detailedrace19299 -> "1929-9"
    Detailedrace19307 -> "1930-7"
    Detailedrace19315 -> "1931-5"
    Detailedrace19323 -> "1932-3"
    Detailedrace19331 -> "1933-1"
    Detailedrace19349 -> "1934-9"
    Detailedrace19356 -> "1935-6"
    Detailedrace19364 -> "1936-4"
    Detailedrace19372 -> "1937-2"
    Detailedrace19380 -> "1938-0"
    Detailedrace19398 -> "1939-8"
    Detailedrace19406 -> "1940-6"
    Detailedrace19414 -> "1941-4"
    Detailedrace19422 -> "1942-2"
    Detailedrace19430 -> "1943-0"
    Detailedrace19448 -> "1944-8"
    Detailedrace19455 -> "1945-5"
    Detailedrace19463 -> "1946-3"
    Detailedrace19471 -> "1947-1"
    Detailedrace19489 -> "1948-9"
    Detailedrace19497 -> "1949-7"
    Detailedrace19505 -> "1950-5"
    Detailedrace19513 -> "1951-3"
    Detailedrace19521 -> "1952-1"
    Detailedrace19539 -> "1953-9"
    Detailedrace19547 -> "1954-7"
    Detailedrace19554 -> "1955-4"
    Detailedrace19562 -> "1956-2"
    Detailedrace19570 -> "1957-0"
    Detailedrace19588 -> "1958-8"
    Detailedrace19596 -> "1959-6"
    Detailedrace19604 -> "1960-4"
    Detailedrace19612 -> "1961-2"
    Detailedrace19620 -> "1962-0"
    Detailedrace19638 -> "1963-8"
    Detailedrace19646 -> "1964-6"
    Detailedrace19661 -> "1966-1"
    Detailedrace19687 -> "1968-7"
    Detailedrace19695 -> "1969-5"
    Detailedrace19703 -> "1970-3"
    Detailedrace19729 -> "1972-9"
    Detailedrace19737 -> "1973-7"
    Detailedrace19745 -> "1974-5"
    Detailedrace19752 -> "1975-2"
    Detailedrace19760 -> "1976-0"
    Detailedrace19778 -> "1977-8"
    Detailedrace19786 -> "1978-6"
    Detailedrace19794 -> "1979-4"
    Detailedrace19802 -> "1980-2"
    Detailedrace19810 -> "1981-0"
    Detailedrace19828 -> "1982-8"
    Detailedrace19844 -> "1984-4"
    Detailedrace19851 -> "1985-1"
    Detailedrace19869 -> "1986-9"
    Detailedrace19877 -> "1987-7"
    Detailedrace19885 -> "1988-5"
    Detailedrace19901 -> "1990-1"
    Detailedrace19927 -> "1992-7"
    Detailedrace19935 -> "1993-5"
    Detailedrace19943 -> "1994-3"
    Detailedrace19950 -> "1995-0"
    Detailedrace19968 -> "1996-8"
    Detailedrace19976 -> "1997-6"
    Detailedrace19984 -> "1998-4"
    Detailedrace19992 -> "1999-2"
    Detailedrace20008 -> "2000-8"
    Detailedrace20024 -> "2002-4"
    Detailedrace20040 -> "2004-0"
    Detailedrace20065 -> "2006-5"
    Detailedrace20073 -> "2007-3"
    Detailedrace20081 -> "2008-1"
    Detailedrace20099 -> "2009-9"
    Detailedrace20107 -> "2010-7"
    Detailedrace20115 -> "2011-5"
    Detailedrace20123 -> "2012-3"
    Detailedrace20131 -> "2013-1"
    Detailedrace20149 -> "2014-9"
    Detailedrace20156 -> "2015-6"
    Detailedrace20164 -> "2016-4"
    Detailedrace20172 -> "2017-2"
    Detailedrace20180 -> "2018-0"
    Detailedrace20198 -> "2019-8"
    Detailedrace20206 -> "2020-6"
    Detailedrace20214 -> "2021-4"
    Detailedrace20222 -> "2022-2"
    Detailedrace20230 -> "2023-0"
    Detailedrace20248 -> "2024-8"
    Detailedrace20255 -> "2025-5"
    Detailedrace20263 -> "2026-3"
    Detailedrace20289 -> "2028-9"
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
    Detailedrace20545 -> "2054-5"
    Detailedrace20560 -> "2056-0"
    Detailedrace20586 -> "2058-6"
    Detailedrace20602 -> "2060-2"
    Detailedrace20610 -> "2061-0"
    Detailedrace20628 -> "2062-8"
    Detailedrace20636 -> "2063-6"
    Detailedrace20644 -> "2064-4"
    Detailedrace20651 -> "2065-1"
    Detailedrace20669 -> "2066-9"
    Detailedrace20677 -> "2067-7"
    Detailedrace20685 -> "2068-5"
    Detailedrace20693 -> "2069-3"
    Detailedrace20701 -> "2070-1"
    Detailedrace20719 -> "2071-9"
    Detailedrace20727 -> "2072-7"
    Detailedrace20735 -> "2073-5"
    Detailedrace20743 -> "2074-3"
    Detailedrace20750 -> "2075-0"
    Detailedrace20768 -> "2076-8"
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
    Detailedrace21063 -> "2106-3"
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
    Detailedrace21337 -> "2133-7"
    Detailedrace21352 -> "2135-2"
    Detailedrace21378 -> "2137-8"
    Detailedrace21386 -> "2138-6"
    Detailedrace21394 -> "2139-4"
    Detailedrace21402 -> "2140-2"
    Detailedrace21410 -> "2141-0"
    Detailedrace21428 -> "2142-8"
    Detailedrace21436 -> "2143-6"
    Detailedrace21444 -> "2144-4"
    Detailedrace21451 -> "2145-1"
    Detailedrace21469 -> "2146-9"
    Detailedrace21485 -> "2148-5"
    Detailedrace21493 -> "2149-3"
    Detailedrace21501 -> "2150-1"
    Detailedrace21519 -> "2151-9"
    Detailedrace21527 -> "2152-7"
    Detailedrace21535 -> "2153-5"
    Detailedrace21550 -> "2155-0"
    Detailedrace21568 -> "2156-8"
    Detailedrace21576 -> "2157-6"
    Detailedrace21584 -> "2158-4"
    Detailedrace21592 -> "2159-2"
    Detailedrace21600 -> "2160-0"
    Detailedrace21618 -> "2161-8"
    Detailedrace21626 -> "2162-6"
    Detailedrace21634 -> "2163-4"
    Detailedrace21659 -> "2165-9"
    Detailedrace21667 -> "2166-7"
    Detailedrace21675 -> "2167-5"
    Detailedrace21683 -> "2168-3"
    Detailedrace21691 -> "2169-1"
    Detailedrace21709 -> "2170-9"
    Detailedrace21717 -> "2171-7"
    Detailedrace21725 -> "2172-5"
    Detailedrace21733 -> "2173-3"
    Detailedrace21741 -> "2174-1"
    Detailedrace21758 -> "2175-8"
    Detailedrace21766 -> "2176-6"
    Detailedrace21782 -> "2178-2"
    Detailedrace21808 -> "2180-8"
    Detailedrace21824 -> "2182-4"
    Detailedrace21840 -> "2184-0"
    Detailedrace21865 -> "2186-5"
    Detailedrace25007 -> "2500-7"
    DetailedraceAsku -> "ASKU"
    DetailedraceOth -> "OTH"
    DetailedraceUnk -> "UNK"
  }
}

pub fn detailedrace_from_code_and_system(
  code code: String,
  system system: String,
) -> Result(Detailedrace, Nil) {
  case code, system {
    "1000-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10009)
    "1002-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10025)
    "1004-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10041)
    "1006-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10066)
    "1008-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10082)
    "1010-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10108)
    "1011-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10116)
    "1012-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10124)
    "1013-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10132)
    "1014-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10140)
    "1015-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10157)
    "1016-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10165)
    "1017-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10173)
    "1018-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10181)
    "1019-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10199)
    "1021-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10215)
    "1022-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10223)
    "1023-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10231)
    "1024-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10249)
    "1026-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10264)
    "1028-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10280)
    "1030-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10306)
    "1031-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10314)
    "1033-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10330)
    "1035-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10355)
    "1037-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10371)
    "1039-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10397)
    "1041-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10413)
    "1042-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10421)
    "1044-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10447)
    "1045-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10454)
    "1046-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10462)
    "1047-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10470)
    "1048-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10488)
    "1049-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10496)
    "1050-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10504)
    "1051-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10512)
    "1053-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10538)
    "1054-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10546)
    "1055-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10553)
    "1056-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10561)
    "1057-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10579)
    "1058-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10587)
    "1059-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10595)
    "1060-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10603)
    "1061-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10611)
    "1062-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10629)
    "1063-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10637)
    "1064-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10645)
    "1065-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10652)
    "1066-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10660)
    "1068-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10686)
    "1069-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10694)
    "1070-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10702)
    "1071-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10710)
    "1072-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10728)
    "1073-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10736)
    "1074-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10744)
    "1076-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10769)
    "1078-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10785)
    "1080-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10801)
    "1082-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10827)
    "1083-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10835)
    "1084-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10843)
    "1086-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10868)
    "1088-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10884)
    "1089-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10892)
    "1090-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10900)
    "1091-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10918)
    "1092-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10926)
    "1093-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10934)
    "1094-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10942)
    "1095-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10959)
    "1096-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10967)
    "1097-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10975)
    "1098-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace10983)
    "1100-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11007)
    "1102-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11023)
    "1103-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11031)
    "1104-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11049)
    "1106-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11064)
    "1108-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11080)
    "1109-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11098)
    "1110-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11106)
    "1112-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11122)
    "1114-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11148)
    "1115-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11155)
    "1116-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11163)
    "1117-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11171)
    "1118-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11189)
    "1119-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11197)
    "1120-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11205)
    "1121-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11213)
    "1123-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11239)
    "1124-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11247)
    "1125-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11254)
    "1126-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11262)
    "1127-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11270)
    "1128-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11288)
    "1129-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11296)
    "1130-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11304)
    "1131-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11312)
    "1132-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11320)
    "1133-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11338)
    "1134-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11346)
    "1135-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11353)
    "1136-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11361)
    "1137-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11379)
    "1138-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11387)
    "1139-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11395)
    "1140-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11403)
    "1141-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11411)
    "1142-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11429)
    "1143-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11437)
    "1144-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11445)
    "1145-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11452)
    "1146-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11460)
    "1147-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11478)
    "1148-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11486)
    "1150-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11502)
    "1151-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11510)
    "1153-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11536)
    "1155-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11551)
    "1156-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11569)
    "1157-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11577)
    "1158-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11585)
    "1159-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11593)
    "1160-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11601)
    "1162-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11627)
    "1163-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11635)
    "1165-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11650)
    "1167-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11676)
    "1169-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11692)
    "1171-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11718)
    "1173-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11734)
    "1175-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11759)
    "1176-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11767)
    "1178-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11783)
    "1180-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11809)
    "1182-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11825)
    "1184-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11841)
    "1186-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11866)
    "1187-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11874)
    "1189-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11890)
    "1191-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11916)
    "1193-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11932)
    "1194-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11940)
    "1195-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11957)
    "1196-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11965)
    "1197-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11973)
    "1198-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11981)
    "1199-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace11999)
    "1200-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12005)
    "1201-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12013)
    "1202-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12021)
    "1203-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12039)
    "1204-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12047)
    "1205-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12054)
    "1207-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12070)
    "1209-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12096)
    "1211-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12112)
    "1212-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12120)
    "1214-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12146)
    "1215-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12153)
    "1216-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12161)
    "1217-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12179)
    "1218-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12187)
    "1219-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12195)
    "1220-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12203)
    "1222-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12229)
    "1223-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12237)
    "1224-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12245)
    "1225-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12252)
    "1226-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12260)
    "1227-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12278)
    "1228-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12286)
    "1229-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12294)
    "1230-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12302)
    "1231-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12310)
    "1233-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12336)
    "1234-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12344)
    "1235-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12351)
    "1236-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12369)
    "1237-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12377)
    "1238-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12385)
    "1239-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12393)
    "1240-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12401)
    "1241-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12419)
    "1242-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12427)
    "1243-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12435)
    "1244-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12443)
    "1245-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12450)
    "1246-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12468)
    "1247-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12476)
    "1248-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12484)
    "1250-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12500)
    "1252-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12526)
    "1254-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12542)
    "1256-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12567)
    "1258-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12583)
    "1260-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12609)
    "1262-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12625)
    "1264-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12641)
    "1265-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12658)
    "1267-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12674)
    "1269-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12690)
    "1271-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12716)
    "1272-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12724)
    "1273-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12732)
    "1275-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12757)
    "1277-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12773)
    "1279-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12799)
    "1281-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12815)
    "1282-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12823)
    "1283-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12831)
    "1285-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12856)
    "1286-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12864)
    "1287-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12872)
    "1288-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12880)
    "1289-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12898)
    "1290-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12906)
    "1291-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12914)
    "1292-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12922)
    "1293-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12930)
    "1294-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12948)
    "1295-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12955)
    "1297-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12971)
    "1299-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace12997)
    "1301-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13011)
    "1303-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13037)
    "1305-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13052)
    "1306-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13060)
    "1307-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13078)
    "1309-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13094)
    "1310-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13102)
    "1312-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13128)
    "1313-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13136)
    "1314-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13144)
    "1315-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13151)
    "1317-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13177)
    "1319-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13193)
    "1321-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13219)
    "1323-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13235)
    "1325-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13250)
    "1326-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13268)
    "1327-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13276)
    "1328-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13284)
    "1329-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13292)
    "1331-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13318)
    "1332-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13326)
    "1333-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13334)
    "1334-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13342)
    "1335-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13359)
    "1336-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13367)
    "1337-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13375)
    "1338-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13383)
    "1340-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13409)
    "1342-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13425)
    "1344-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13441)
    "1345-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13458)
    "1346-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13466)
    "1348-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13482)
    "1350-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13508)
    "1352-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13524)
    "1354-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13540)
    "1356-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13565)
    "1358-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13581)
    "1359-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13599)
    "1360-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13607)
    "1361-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13615)
    "1363-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13631)
    "1365-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13656)
    "1366-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13664)
    "1368-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13680)
    "1370-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13706)
    "1372-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13722)
    "1374-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13748)
    "1376-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13763)
    "1378-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13789)
    "1380-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13805)
    "1382-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13821)
    "1383-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13839)
    "1384-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13847)
    "1385-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13854)
    "1387-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13870)
    "1389-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13896)
    "1391-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13912)
    "1392-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13920)
    "1393-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13938)
    "1394-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13946)
    "1395-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13953)
    "1396-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13961)
    "1397-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13979)
    "1398-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13987)
    "1399-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace13995)
    "1400-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14001)
    "1401-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14019)
    "1403-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14035)
    "1405-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14050)
    "1407-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14076)
    "1409-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14092)
    "1411-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14118)
    "1412-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14126)
    "1413-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14134)
    "1414-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14142)
    "1416-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14167)
    "1417-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14175)
    "1418-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14183)
    "1419-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14191)
    "1420-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14209)
    "1421-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14217)
    "1422-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14225)
    "1423-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14233)
    "1424-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14241)
    "1425-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14258)
    "1426-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14266)
    "1427-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14274)
    "1428-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14282)
    "1429-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14290)
    "1430-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14308)
    "1431-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14316)
    "1432-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14324)
    "1433-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14332)
    "1434-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14340)
    "1435-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14357)
    "1436-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14365)
    "1437-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14373)
    "1439-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14399)
    "1441-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14415)
    "1442-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14423)
    "1443-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14431)
    "1445-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14456)
    "1446-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14464)
    "1448-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14480)
    "1450-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14506)
    "1451-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14514)
    "1453-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14530)
    "1454-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14548)
    "1456-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14563)
    "1457-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14571)
    "1458-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14589)
    "1460-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14605)
    "1462-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14621)
    "1464-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14647)
    "1465-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14654)
    "1466-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14662)
    "1467-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14670)
    "1468-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14688)
    "1469-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14696)
    "1470-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14704)
    "1471-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14712)
    "1472-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14720)
    "1474-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14746)
    "1475-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14753)
    "1476-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14761)
    "1478-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14787)
    "1479-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14795)
    "1480-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14803)
    "1481-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14811)
    "1482-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14829)
    "1483-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14837)
    "1484-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14845)
    "1485-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14852)
    "1487-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14878)
    "1489-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14894)
    "1490-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14902)
    "1491-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14910)
    "1492-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14928)
    "1493-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14936)
    "1494-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14944)
    "1495-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14951)
    "1496-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14969)
    "1497-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14977)
    "1498-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14985)
    "1499-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace14993)
    "1500-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15008)
    "1501-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15016)
    "1502-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15024)
    "1503-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15032)
    "1504-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15040)
    "1505-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15057)
    "1506-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15065)
    "1507-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15073)
    "1508-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15081)
    "1509-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15099)
    "1510-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15107)
    "1511-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15115)
    "1512-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15123)
    "1513-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15131)
    "1514-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15149)
    "1515-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15156)
    "1516-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15164)
    "1518-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15180)
    "1519-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15198)
    "1520-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15206)
    "1521-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15214)
    "1522-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15222)
    "1523-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15230)
    "1524-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15248)
    "1525-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15255)
    "1526-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15263)
    "1527-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15271)
    "1528-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15289)
    "1529-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15297)
    "1530-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15305)
    "1531-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15313)
    "1532-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15321)
    "1533-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15339)
    "1534-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15347)
    "1535-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15354)
    "1536-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15362)
    "1537-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15370)
    "1538-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15388)
    "1539-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15396)
    "1541-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15412)
    "1543-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15438)
    "1545-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15453)
    "1547-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15479)
    "1549-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15495)
    "1551-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15511)
    "1552-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15529)
    "1553-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15537)
    "1554-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15545)
    "1556-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15560)
    "1558-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15586)
    "1560-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15602)
    "1562-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15628)
    "1564-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15644)
    "1566-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15669)
    "1567-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15677)
    "1568-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15685)
    "1569-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15693)
    "1570-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15701)
    "1571-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15719)
    "1573-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15735)
    "1574-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15743)
    "1576-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15768)
    "1578-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15784)
    "1579-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15792)
    "1580-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15800)
    "1582-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15826)
    "1584-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15842)
    "1586-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15867)
    "1587-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15875)
    "1588-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15883)
    "1589-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15891)
    "1590-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15909)
    "1591-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15917)
    "1592-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15925)
    "1593-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15933)
    "1594-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15941)
    "1595-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15958)
    "1596-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15966)
    "1597-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15974)
    "1598-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15982)
    "1599-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace15990)
    "1600-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16006)
    "1602-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16022)
    "1603-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16030)
    "1604-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16048)
    "1605-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16055)
    "1607-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16071)
    "1609-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16097)
    "1610-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16105)
    "1611-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16113)
    "1612-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16121)
    "1613-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16139)
    "1614-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16147)
    "1615-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16154)
    "1616-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16162)
    "1617-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16170)
    "1618-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16188)
    "1619-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16196)
    "1620-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16204)
    "1621-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16212)
    "1622-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16220)
    "1623-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16238)
    "1624-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16246)
    "1625-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16253)
    "1626-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16261)
    "1627-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16279)
    "1628-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16287)
    "1629-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16295)
    "1630-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16303)
    "1631-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16311)
    "1632-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16329)
    "1633-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16337)
    "1634-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16345)
    "1635-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16352)
    "1636-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16360)
    "1637-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16378)
    "1638-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16386)
    "1639-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16394)
    "1640-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16402)
    "1641-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16410)
    "1643-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16436)
    "1645-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16451)
    "1647-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16477)
    "1649-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16493)
    "1651-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16519)
    "1653-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16535)
    "1654-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16543)
    "1655-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16550)
    "1656-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16568)
    "1657-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16576)
    "1659-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16592)
    "1661-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16618)
    "1663-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16634)
    "1665-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16659)
    "1667-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16675)
    "1668-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16683)
    "1670-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16709)
    "1671-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16717)
    "1672-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16725)
    "1673-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16733)
    "1675-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16758)
    "1677-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16774)
    "1679-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16790)
    "1680-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16808)
    "1681-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16816)
    "1683-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16832)
    "1685-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16857)
    "1687-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16873)
    "1688-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16881)
    "1689-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16899)
    "1690-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16907)
    "1692-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16923)
    "1694-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16949)
    "1696-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16964)
    "1697-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16972)
    "1698-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace16980)
    "1700-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17004)
    "1702-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17020)
    "1704-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17046)
    "1705-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17053)
    "1707-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17079)
    "1709-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17095)
    "1711-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17111)
    "1712-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17129)
    "1713-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17137)
    "1715-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17152)
    "1717-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17178)
    "1718-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17186)
    "1719-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17194)
    "1720-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17202)
    "1722-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17228)
    "1724-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17244)
    "1725-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17251)
    "1726-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17269)
    "1727-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17277)
    "1728-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17285)
    "1729-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17293)
    "1730-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17301)
    "1731-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17319)
    "1732-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17327)
    "1733-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17335)
    "1735-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17350)
    "1737-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17376)
    "1739-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17392)
    "1740-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17400)
    "1741-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17418)
    "1742-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17426)
    "1743-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17434)
    "1744-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17442)
    "1745-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17459)
    "1746-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17467)
    "1747-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17475)
    "1748-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17483)
    "1749-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17491)
    "1750-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17509)
    "1751-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17517)
    "1752-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17525)
    "1753-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17533)
    "1754-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17541)
    "1755-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17558)
    "1756-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17566)
    "1757-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17574)
    "1758-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17582)
    "1759-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17590)
    "1760-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17608)
    "1761-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17616)
    "1762-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17624)
    "1763-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17632)
    "1764-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17640)
    "1765-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17657)
    "1766-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17665)
    "1767-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17673)
    "1768-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17681)
    "1769-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17699)
    "1770-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17707)
    "1771-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17715)
    "1772-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17723)
    "1773-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17731)
    "1774-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17749)
    "1775-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17756)
    "1776-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17764)
    "1777-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17772)
    "1778-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17780)
    "1779-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17798)
    "1780-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17806)
    "1781-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17814)
    "1782-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17822)
    "1783-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17830)
    "1784-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17848)
    "1785-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17855)
    "1786-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17863)
    "1787-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17871)
    "1788-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17889)
    "1789-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17897)
    "1790-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17905)
    "1791-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17913)
    "1792-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17921)
    "1793-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17939)
    "1794-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17947)
    "1795-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17954)
    "1796-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17962)
    "1797-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17970)
    "1798-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17988)
    "1799-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace17996)
    "1800-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18002)
    "1801-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18010)
    "1802-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18028)
    "1803-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18036)
    "1804-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18044)
    "1805-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18051)
    "1806-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18069)
    "1807-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18077)
    "1808-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18085)
    "1809-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18093)
    "1811-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18119)
    "1813-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18135)
    "1814-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18143)
    "1815-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18150)
    "1816-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18168)
    "1817-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18176)
    "1818-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18184)
    "1819-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18192)
    "1820-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18200)
    "1821-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18218)
    "1822-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18226)
    "1823-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18234)
    "1824-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18242)
    "1825-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18259)
    "1826-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18267)
    "1827-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18275)
    "1828-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18283)
    "1829-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18291)
    "1830-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18309)
    "1831-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18317)
    "1832-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18325)
    "1833-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18333)
    "1834-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18341)
    "1835-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18358)
    "1837-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18374)
    "1838-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18382)
    "1840-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18408)
    "1842-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18424)
    "1844-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18440)
    "1845-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18457)
    "1846-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18465)
    "1847-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18473)
    "1848-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18481)
    "1849-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18499)
    "1850-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18507)
    "1851-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18515)
    "1852-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18523)
    "1853-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18531)
    "1854-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18549)
    "1855-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18556)
    "1856-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18564)
    "1857-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18572)
    "1858-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18580)
    "1859-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18598)
    "1860-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18606)
    "1861-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18614)
    "1862-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18622)
    "1863-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18630)
    "1864-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18648)
    "1865-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18655)
    "1866-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18663)
    "1867-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18671)
    "1868-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18689)
    "1869-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18697)
    "1870-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18705)
    "1871-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18713)
    "1872-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18721)
    "1873-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18739)
    "1874-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18747)
    "1875-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18754)
    "1876-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18762)
    "1877-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18770)
    "1878-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18788)
    "1879-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18796)
    "1880-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18804)
    "1881-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18812)
    "1882-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18820)
    "1883-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18838)
    "1884-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18846)
    "1885-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18853)
    "1886-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18861)
    "1887-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18879)
    "1888-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18887)
    "1889-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18895)
    "1891-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18911)
    "1892-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18929)
    "1893-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18937)
    "1894-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18945)
    "1896-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18960)
    "1897-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18978)
    "1898-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18986)
    "1899-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace18994)
    "1900-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19000)
    "1901-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19018)
    "1902-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19026)
    "1903-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19034)
    "1904-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19042)
    "1905-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19059)
    "1906-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19067)
    "1907-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19075)
    "1908-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19083)
    "1909-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19091)
    "1910-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19109)
    "1911-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19117)
    "1912-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19125)
    "1913-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19133)
    "1914-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19141)
    "1915-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19158)
    "1916-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19166)
    "1917-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19174)
    "1918-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19182)
    "1919-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19190)
    "1920-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19208)
    "1921-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19216)
    "1922-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19224)
    "1923-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19232)
    "1924-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19240)
    "1925-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19257)
    "1926-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19265)
    "1927-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19273)
    "1928-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19281)
    "1929-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19299)
    "1930-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19307)
    "1931-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19315)
    "1932-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19323)
    "1933-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19331)
    "1934-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19349)
    "1935-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19356)
    "1936-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19364)
    "1937-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19372)
    "1938-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19380)
    "1939-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19398)
    "1940-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19406)
    "1941-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19414)
    "1942-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19422)
    "1943-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19430)
    "1944-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19448)
    "1945-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19455)
    "1946-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19463)
    "1947-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19471)
    "1948-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19489)
    "1949-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19497)
    "1950-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19505)
    "1951-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19513)
    "1952-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19521)
    "1953-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19539)
    "1954-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19547)
    "1955-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19554)
    "1956-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19562)
    "1957-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19570)
    "1958-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19588)
    "1959-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19596)
    "1960-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19604)
    "1961-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19612)
    "1962-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19620)
    "1963-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19638)
    "1964-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19646)
    "1966-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19661)
    "1968-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19687)
    "1969-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19695)
    "1970-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19703)
    "1972-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19729)
    "1973-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19737)
    "1974-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19745)
    "1975-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19752)
    "1976-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19760)
    "1977-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19778)
    "1978-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19786)
    "1979-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19794)
    "1980-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19802)
    "1981-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19810)
    "1982-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19828)
    "1984-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19844)
    "1985-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19851)
    "1986-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19869)
    "1987-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19877)
    "1988-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19885)
    "1990-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19901)
    "1992-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19927)
    "1993-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19935)
    "1994-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19943)
    "1995-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19950)
    "1996-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19968)
    "1997-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19976)
    "1998-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19984)
    "1999-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace19992)
    "2000-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20008)
    "2002-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20024)
    "2004-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20040)
    "2006-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20065)
    "2007-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20073)
    "2008-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20081)
    "2009-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20099)
    "2010-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20107)
    "2011-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20115)
    "2012-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20123)
    "2013-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20131)
    "2014-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20149)
    "2015-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20156)
    "2016-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20164)
    "2017-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20172)
    "2018-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20180)
    "2019-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20198)
    "2020-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20206)
    "2021-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20214)
    "2022-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20222)
    "2023-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20230)
    "2024-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20248)
    "2025-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20255)
    "2026-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20263)
    "2028-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20289)
    "2029-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20297)
    "2030-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20305)
    "2031-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20313)
    "2032-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20321)
    "2033-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20339)
    "2034-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20347)
    "2035-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20354)
    "2036-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20362)
    "2037-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20370)
    "2038-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20388)
    "2039-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20396)
    "2040-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20404)
    "2041-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20412)
    "2042-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20420)
    "2043-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20438)
    "2044-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20446)
    "2045-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20453)
    "2046-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20461)
    "2047-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20479)
    "2048-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20487)
    "2049-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20495)
    "2050-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20503)
    "2051-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20511)
    "2052-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20529)
    "2054-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20545)
    "2056-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20560)
    "2058-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20586)
    "2060-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20602)
    "2061-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20610)
    "2062-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20628)
    "2063-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20636)
    "2064-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20644)
    "2065-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20651)
    "2066-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20669)
    "2067-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20677)
    "2068-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20685)
    "2069-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20693)
    "2070-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20701)
    "2071-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20719)
    "2072-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20727)
    "2073-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20735)
    "2074-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20743)
    "2075-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20750)
    "2076-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20768)
    "2078-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20784)
    "2079-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20792)
    "2080-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20800)
    "2081-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20818)
    "2082-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20826)
    "2083-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20834)
    "2085-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20859)
    "2086-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20867)
    "2087-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20875)
    "2088-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20883)
    "2089-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20891)
    "2090-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20909)
    "2091-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20917)
    "2092-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20925)
    "2093-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20933)
    "2094-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20941)
    "2095-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20958)
    "2096-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20966)
    "2097-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20974)
    "2098-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace20982)
    "2100-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21006)
    "2101-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21014)
    "2102-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21022)
    "2103-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21030)
    "2104-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21048)
    "2106-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21063)
    "2108-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21089)
    "2109-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21097)
    "2110-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21105)
    "2111-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21113)
    "2112-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21121)
    "2113-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21139)
    "2114-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21147)
    "2115-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21154)
    "2116-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21162)
    "2118-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21188)
    "2119-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21196)
    "2120-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21204)
    "2121-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21212)
    "2122-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21220)
    "2123-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21238)
    "2124-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21246)
    "2125-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21253)
    "2126-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21261)
    "2127-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21279)
    "2129-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21295)
    "2131-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21311)
    "2133-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21337)
    "2135-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21352)
    "2137-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21378)
    "2138-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21386)
    "2139-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21394)
    "2140-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21402)
    "2141-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21410)
    "2142-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21428)
    "2143-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21436)
    "2144-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21444)
    "2145-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21451)
    "2146-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21469)
    "2148-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21485)
    "2149-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21493)
    "2150-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21501)
    "2151-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21519)
    "2152-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21527)
    "2153-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21535)
    "2155-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21550)
    "2156-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21568)
    "2157-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21576)
    "2158-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21584)
    "2159-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21592)
    "2160-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21600)
    "2161-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21618)
    "2162-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21626)
    "2163-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21634)
    "2165-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21659)
    "2166-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21667)
    "2167-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21675)
    "2168-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21683)
    "2169-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21691)
    "2170-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21709)
    "2171-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21717)
    "2172-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21725)
    "2173-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21733)
    "2174-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21741)
    "2175-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21758)
    "2176-6", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21766)
    "2178-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21782)
    "2180-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21808)
    "2182-4", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21824)
    "2184-0", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21840)
    "2186-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace21865)
    "2500-7", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Detailedrace25007)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(DetailedraceAsku)
    "OTH", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(DetailedraceOth)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(DetailedraceUnk)
    _, _ -> Error(Nil)
  }
}

pub fn detailedrace_decoder() -> Decoder(Detailedrace) {
  use variant <- decode.then(decode.string)
  case variant {
    "1000-9" -> decode.success(Detailedrace10009)
    "1002-5" -> decode.success(Detailedrace10025)
    "1004-1" -> decode.success(Detailedrace10041)
    "1006-6" -> decode.success(Detailedrace10066)
    "1008-2" -> decode.success(Detailedrace10082)
    "1010-8" -> decode.success(Detailedrace10108)
    "1011-6" -> decode.success(Detailedrace10116)
    "1012-4" -> decode.success(Detailedrace10124)
    "1013-2" -> decode.success(Detailedrace10132)
    "1014-0" -> decode.success(Detailedrace10140)
    "1015-7" -> decode.success(Detailedrace10157)
    "1016-5" -> decode.success(Detailedrace10165)
    "1017-3" -> decode.success(Detailedrace10173)
    "1018-1" -> decode.success(Detailedrace10181)
    "1019-9" -> decode.success(Detailedrace10199)
    "1021-5" -> decode.success(Detailedrace10215)
    "1022-3" -> decode.success(Detailedrace10223)
    "1023-1" -> decode.success(Detailedrace10231)
    "1024-9" -> decode.success(Detailedrace10249)
    "1026-4" -> decode.success(Detailedrace10264)
    "1028-0" -> decode.success(Detailedrace10280)
    "1030-6" -> decode.success(Detailedrace10306)
    "1031-4" -> decode.success(Detailedrace10314)
    "1033-0" -> decode.success(Detailedrace10330)
    "1035-5" -> decode.success(Detailedrace10355)
    "1037-1" -> decode.success(Detailedrace10371)
    "1039-7" -> decode.success(Detailedrace10397)
    "1041-3" -> decode.success(Detailedrace10413)
    "1042-1" -> decode.success(Detailedrace10421)
    "1044-7" -> decode.success(Detailedrace10447)
    "1045-4" -> decode.success(Detailedrace10454)
    "1046-2" -> decode.success(Detailedrace10462)
    "1047-0" -> decode.success(Detailedrace10470)
    "1048-8" -> decode.success(Detailedrace10488)
    "1049-6" -> decode.success(Detailedrace10496)
    "1050-4" -> decode.success(Detailedrace10504)
    "1051-2" -> decode.success(Detailedrace10512)
    "1053-8" -> decode.success(Detailedrace10538)
    "1054-6" -> decode.success(Detailedrace10546)
    "1055-3" -> decode.success(Detailedrace10553)
    "1056-1" -> decode.success(Detailedrace10561)
    "1057-9" -> decode.success(Detailedrace10579)
    "1058-7" -> decode.success(Detailedrace10587)
    "1059-5" -> decode.success(Detailedrace10595)
    "1060-3" -> decode.success(Detailedrace10603)
    "1061-1" -> decode.success(Detailedrace10611)
    "1062-9" -> decode.success(Detailedrace10629)
    "1063-7" -> decode.success(Detailedrace10637)
    "1064-5" -> decode.success(Detailedrace10645)
    "1065-2" -> decode.success(Detailedrace10652)
    "1066-0" -> decode.success(Detailedrace10660)
    "1068-6" -> decode.success(Detailedrace10686)
    "1069-4" -> decode.success(Detailedrace10694)
    "1070-2" -> decode.success(Detailedrace10702)
    "1071-0" -> decode.success(Detailedrace10710)
    "1072-8" -> decode.success(Detailedrace10728)
    "1073-6" -> decode.success(Detailedrace10736)
    "1074-4" -> decode.success(Detailedrace10744)
    "1076-9" -> decode.success(Detailedrace10769)
    "1078-5" -> decode.success(Detailedrace10785)
    "1080-1" -> decode.success(Detailedrace10801)
    "1082-7" -> decode.success(Detailedrace10827)
    "1083-5" -> decode.success(Detailedrace10835)
    "1084-3" -> decode.success(Detailedrace10843)
    "1086-8" -> decode.success(Detailedrace10868)
    "1088-4" -> decode.success(Detailedrace10884)
    "1089-2" -> decode.success(Detailedrace10892)
    "1090-0" -> decode.success(Detailedrace10900)
    "1091-8" -> decode.success(Detailedrace10918)
    "1092-6" -> decode.success(Detailedrace10926)
    "1093-4" -> decode.success(Detailedrace10934)
    "1094-2" -> decode.success(Detailedrace10942)
    "1095-9" -> decode.success(Detailedrace10959)
    "1096-7" -> decode.success(Detailedrace10967)
    "1097-5" -> decode.success(Detailedrace10975)
    "1098-3" -> decode.success(Detailedrace10983)
    "1100-7" -> decode.success(Detailedrace11007)
    "1102-3" -> decode.success(Detailedrace11023)
    "1103-1" -> decode.success(Detailedrace11031)
    "1104-9" -> decode.success(Detailedrace11049)
    "1106-4" -> decode.success(Detailedrace11064)
    "1108-0" -> decode.success(Detailedrace11080)
    "1109-8" -> decode.success(Detailedrace11098)
    "1110-6" -> decode.success(Detailedrace11106)
    "1112-2" -> decode.success(Detailedrace11122)
    "1114-8" -> decode.success(Detailedrace11148)
    "1115-5" -> decode.success(Detailedrace11155)
    "1116-3" -> decode.success(Detailedrace11163)
    "1117-1" -> decode.success(Detailedrace11171)
    "1118-9" -> decode.success(Detailedrace11189)
    "1119-7" -> decode.success(Detailedrace11197)
    "1120-5" -> decode.success(Detailedrace11205)
    "1121-3" -> decode.success(Detailedrace11213)
    "1123-9" -> decode.success(Detailedrace11239)
    "1124-7" -> decode.success(Detailedrace11247)
    "1125-4" -> decode.success(Detailedrace11254)
    "1126-2" -> decode.success(Detailedrace11262)
    "1127-0" -> decode.success(Detailedrace11270)
    "1128-8" -> decode.success(Detailedrace11288)
    "1129-6" -> decode.success(Detailedrace11296)
    "1130-4" -> decode.success(Detailedrace11304)
    "1131-2" -> decode.success(Detailedrace11312)
    "1132-0" -> decode.success(Detailedrace11320)
    "1133-8" -> decode.success(Detailedrace11338)
    "1134-6" -> decode.success(Detailedrace11346)
    "1135-3" -> decode.success(Detailedrace11353)
    "1136-1" -> decode.success(Detailedrace11361)
    "1137-9" -> decode.success(Detailedrace11379)
    "1138-7" -> decode.success(Detailedrace11387)
    "1139-5" -> decode.success(Detailedrace11395)
    "1140-3" -> decode.success(Detailedrace11403)
    "1141-1" -> decode.success(Detailedrace11411)
    "1142-9" -> decode.success(Detailedrace11429)
    "1143-7" -> decode.success(Detailedrace11437)
    "1144-5" -> decode.success(Detailedrace11445)
    "1145-2" -> decode.success(Detailedrace11452)
    "1146-0" -> decode.success(Detailedrace11460)
    "1147-8" -> decode.success(Detailedrace11478)
    "1148-6" -> decode.success(Detailedrace11486)
    "1150-2" -> decode.success(Detailedrace11502)
    "1151-0" -> decode.success(Detailedrace11510)
    "1153-6" -> decode.success(Detailedrace11536)
    "1155-1" -> decode.success(Detailedrace11551)
    "1156-9" -> decode.success(Detailedrace11569)
    "1157-7" -> decode.success(Detailedrace11577)
    "1158-5" -> decode.success(Detailedrace11585)
    "1159-3" -> decode.success(Detailedrace11593)
    "1160-1" -> decode.success(Detailedrace11601)
    "1162-7" -> decode.success(Detailedrace11627)
    "1163-5" -> decode.success(Detailedrace11635)
    "1165-0" -> decode.success(Detailedrace11650)
    "1167-6" -> decode.success(Detailedrace11676)
    "1169-2" -> decode.success(Detailedrace11692)
    "1171-8" -> decode.success(Detailedrace11718)
    "1173-4" -> decode.success(Detailedrace11734)
    "1175-9" -> decode.success(Detailedrace11759)
    "1176-7" -> decode.success(Detailedrace11767)
    "1178-3" -> decode.success(Detailedrace11783)
    "1180-9" -> decode.success(Detailedrace11809)
    "1182-5" -> decode.success(Detailedrace11825)
    "1184-1" -> decode.success(Detailedrace11841)
    "1186-6" -> decode.success(Detailedrace11866)
    "1187-4" -> decode.success(Detailedrace11874)
    "1189-0" -> decode.success(Detailedrace11890)
    "1191-6" -> decode.success(Detailedrace11916)
    "1193-2" -> decode.success(Detailedrace11932)
    "1194-0" -> decode.success(Detailedrace11940)
    "1195-7" -> decode.success(Detailedrace11957)
    "1196-5" -> decode.success(Detailedrace11965)
    "1197-3" -> decode.success(Detailedrace11973)
    "1198-1" -> decode.success(Detailedrace11981)
    "1199-9" -> decode.success(Detailedrace11999)
    "1200-5" -> decode.success(Detailedrace12005)
    "1201-3" -> decode.success(Detailedrace12013)
    "1202-1" -> decode.success(Detailedrace12021)
    "1203-9" -> decode.success(Detailedrace12039)
    "1204-7" -> decode.success(Detailedrace12047)
    "1205-4" -> decode.success(Detailedrace12054)
    "1207-0" -> decode.success(Detailedrace12070)
    "1209-6" -> decode.success(Detailedrace12096)
    "1211-2" -> decode.success(Detailedrace12112)
    "1212-0" -> decode.success(Detailedrace12120)
    "1214-6" -> decode.success(Detailedrace12146)
    "1215-3" -> decode.success(Detailedrace12153)
    "1216-1" -> decode.success(Detailedrace12161)
    "1217-9" -> decode.success(Detailedrace12179)
    "1218-7" -> decode.success(Detailedrace12187)
    "1219-5" -> decode.success(Detailedrace12195)
    "1220-3" -> decode.success(Detailedrace12203)
    "1222-9" -> decode.success(Detailedrace12229)
    "1223-7" -> decode.success(Detailedrace12237)
    "1224-5" -> decode.success(Detailedrace12245)
    "1225-2" -> decode.success(Detailedrace12252)
    "1226-0" -> decode.success(Detailedrace12260)
    "1227-8" -> decode.success(Detailedrace12278)
    "1228-6" -> decode.success(Detailedrace12286)
    "1229-4" -> decode.success(Detailedrace12294)
    "1230-2" -> decode.success(Detailedrace12302)
    "1231-0" -> decode.success(Detailedrace12310)
    "1233-6" -> decode.success(Detailedrace12336)
    "1234-4" -> decode.success(Detailedrace12344)
    "1235-1" -> decode.success(Detailedrace12351)
    "1236-9" -> decode.success(Detailedrace12369)
    "1237-7" -> decode.success(Detailedrace12377)
    "1238-5" -> decode.success(Detailedrace12385)
    "1239-3" -> decode.success(Detailedrace12393)
    "1240-1" -> decode.success(Detailedrace12401)
    "1241-9" -> decode.success(Detailedrace12419)
    "1242-7" -> decode.success(Detailedrace12427)
    "1243-5" -> decode.success(Detailedrace12435)
    "1244-3" -> decode.success(Detailedrace12443)
    "1245-0" -> decode.success(Detailedrace12450)
    "1246-8" -> decode.success(Detailedrace12468)
    "1247-6" -> decode.success(Detailedrace12476)
    "1248-4" -> decode.success(Detailedrace12484)
    "1250-0" -> decode.success(Detailedrace12500)
    "1252-6" -> decode.success(Detailedrace12526)
    "1254-2" -> decode.success(Detailedrace12542)
    "1256-7" -> decode.success(Detailedrace12567)
    "1258-3" -> decode.success(Detailedrace12583)
    "1260-9" -> decode.success(Detailedrace12609)
    "1262-5" -> decode.success(Detailedrace12625)
    "1264-1" -> decode.success(Detailedrace12641)
    "1265-8" -> decode.success(Detailedrace12658)
    "1267-4" -> decode.success(Detailedrace12674)
    "1269-0" -> decode.success(Detailedrace12690)
    "1271-6" -> decode.success(Detailedrace12716)
    "1272-4" -> decode.success(Detailedrace12724)
    "1273-2" -> decode.success(Detailedrace12732)
    "1275-7" -> decode.success(Detailedrace12757)
    "1277-3" -> decode.success(Detailedrace12773)
    "1279-9" -> decode.success(Detailedrace12799)
    "1281-5" -> decode.success(Detailedrace12815)
    "1282-3" -> decode.success(Detailedrace12823)
    "1283-1" -> decode.success(Detailedrace12831)
    "1285-6" -> decode.success(Detailedrace12856)
    "1286-4" -> decode.success(Detailedrace12864)
    "1287-2" -> decode.success(Detailedrace12872)
    "1288-0" -> decode.success(Detailedrace12880)
    "1289-8" -> decode.success(Detailedrace12898)
    "1290-6" -> decode.success(Detailedrace12906)
    "1291-4" -> decode.success(Detailedrace12914)
    "1292-2" -> decode.success(Detailedrace12922)
    "1293-0" -> decode.success(Detailedrace12930)
    "1294-8" -> decode.success(Detailedrace12948)
    "1295-5" -> decode.success(Detailedrace12955)
    "1297-1" -> decode.success(Detailedrace12971)
    "1299-7" -> decode.success(Detailedrace12997)
    "1301-1" -> decode.success(Detailedrace13011)
    "1303-7" -> decode.success(Detailedrace13037)
    "1305-2" -> decode.success(Detailedrace13052)
    "1306-0" -> decode.success(Detailedrace13060)
    "1307-8" -> decode.success(Detailedrace13078)
    "1309-4" -> decode.success(Detailedrace13094)
    "1310-2" -> decode.success(Detailedrace13102)
    "1312-8" -> decode.success(Detailedrace13128)
    "1313-6" -> decode.success(Detailedrace13136)
    "1314-4" -> decode.success(Detailedrace13144)
    "1315-1" -> decode.success(Detailedrace13151)
    "1317-7" -> decode.success(Detailedrace13177)
    "1319-3" -> decode.success(Detailedrace13193)
    "1321-9" -> decode.success(Detailedrace13219)
    "1323-5" -> decode.success(Detailedrace13235)
    "1325-0" -> decode.success(Detailedrace13250)
    "1326-8" -> decode.success(Detailedrace13268)
    "1327-6" -> decode.success(Detailedrace13276)
    "1328-4" -> decode.success(Detailedrace13284)
    "1329-2" -> decode.success(Detailedrace13292)
    "1331-8" -> decode.success(Detailedrace13318)
    "1332-6" -> decode.success(Detailedrace13326)
    "1333-4" -> decode.success(Detailedrace13334)
    "1334-2" -> decode.success(Detailedrace13342)
    "1335-9" -> decode.success(Detailedrace13359)
    "1336-7" -> decode.success(Detailedrace13367)
    "1337-5" -> decode.success(Detailedrace13375)
    "1338-3" -> decode.success(Detailedrace13383)
    "1340-9" -> decode.success(Detailedrace13409)
    "1342-5" -> decode.success(Detailedrace13425)
    "1344-1" -> decode.success(Detailedrace13441)
    "1345-8" -> decode.success(Detailedrace13458)
    "1346-6" -> decode.success(Detailedrace13466)
    "1348-2" -> decode.success(Detailedrace13482)
    "1350-8" -> decode.success(Detailedrace13508)
    "1352-4" -> decode.success(Detailedrace13524)
    "1354-0" -> decode.success(Detailedrace13540)
    "1356-5" -> decode.success(Detailedrace13565)
    "1358-1" -> decode.success(Detailedrace13581)
    "1359-9" -> decode.success(Detailedrace13599)
    "1360-7" -> decode.success(Detailedrace13607)
    "1361-5" -> decode.success(Detailedrace13615)
    "1363-1" -> decode.success(Detailedrace13631)
    "1365-6" -> decode.success(Detailedrace13656)
    "1366-4" -> decode.success(Detailedrace13664)
    "1368-0" -> decode.success(Detailedrace13680)
    "1370-6" -> decode.success(Detailedrace13706)
    "1372-2" -> decode.success(Detailedrace13722)
    "1374-8" -> decode.success(Detailedrace13748)
    "1376-3" -> decode.success(Detailedrace13763)
    "1378-9" -> decode.success(Detailedrace13789)
    "1380-5" -> decode.success(Detailedrace13805)
    "1382-1" -> decode.success(Detailedrace13821)
    "1383-9" -> decode.success(Detailedrace13839)
    "1384-7" -> decode.success(Detailedrace13847)
    "1385-4" -> decode.success(Detailedrace13854)
    "1387-0" -> decode.success(Detailedrace13870)
    "1389-6" -> decode.success(Detailedrace13896)
    "1391-2" -> decode.success(Detailedrace13912)
    "1392-0" -> decode.success(Detailedrace13920)
    "1393-8" -> decode.success(Detailedrace13938)
    "1394-6" -> decode.success(Detailedrace13946)
    "1395-3" -> decode.success(Detailedrace13953)
    "1396-1" -> decode.success(Detailedrace13961)
    "1397-9" -> decode.success(Detailedrace13979)
    "1398-7" -> decode.success(Detailedrace13987)
    "1399-5" -> decode.success(Detailedrace13995)
    "1400-1" -> decode.success(Detailedrace14001)
    "1401-9" -> decode.success(Detailedrace14019)
    "1403-5" -> decode.success(Detailedrace14035)
    "1405-0" -> decode.success(Detailedrace14050)
    "1407-6" -> decode.success(Detailedrace14076)
    "1409-2" -> decode.success(Detailedrace14092)
    "1411-8" -> decode.success(Detailedrace14118)
    "1412-6" -> decode.success(Detailedrace14126)
    "1413-4" -> decode.success(Detailedrace14134)
    "1414-2" -> decode.success(Detailedrace14142)
    "1416-7" -> decode.success(Detailedrace14167)
    "1417-5" -> decode.success(Detailedrace14175)
    "1418-3" -> decode.success(Detailedrace14183)
    "1419-1" -> decode.success(Detailedrace14191)
    "1420-9" -> decode.success(Detailedrace14209)
    "1421-7" -> decode.success(Detailedrace14217)
    "1422-5" -> decode.success(Detailedrace14225)
    "1423-3" -> decode.success(Detailedrace14233)
    "1424-1" -> decode.success(Detailedrace14241)
    "1425-8" -> decode.success(Detailedrace14258)
    "1426-6" -> decode.success(Detailedrace14266)
    "1427-4" -> decode.success(Detailedrace14274)
    "1428-2" -> decode.success(Detailedrace14282)
    "1429-0" -> decode.success(Detailedrace14290)
    "1430-8" -> decode.success(Detailedrace14308)
    "1431-6" -> decode.success(Detailedrace14316)
    "1432-4" -> decode.success(Detailedrace14324)
    "1433-2" -> decode.success(Detailedrace14332)
    "1434-0" -> decode.success(Detailedrace14340)
    "1435-7" -> decode.success(Detailedrace14357)
    "1436-5" -> decode.success(Detailedrace14365)
    "1437-3" -> decode.success(Detailedrace14373)
    "1439-9" -> decode.success(Detailedrace14399)
    "1441-5" -> decode.success(Detailedrace14415)
    "1442-3" -> decode.success(Detailedrace14423)
    "1443-1" -> decode.success(Detailedrace14431)
    "1445-6" -> decode.success(Detailedrace14456)
    "1446-4" -> decode.success(Detailedrace14464)
    "1448-0" -> decode.success(Detailedrace14480)
    "1450-6" -> decode.success(Detailedrace14506)
    "1451-4" -> decode.success(Detailedrace14514)
    "1453-0" -> decode.success(Detailedrace14530)
    "1454-8" -> decode.success(Detailedrace14548)
    "1456-3" -> decode.success(Detailedrace14563)
    "1457-1" -> decode.success(Detailedrace14571)
    "1458-9" -> decode.success(Detailedrace14589)
    "1460-5" -> decode.success(Detailedrace14605)
    "1462-1" -> decode.success(Detailedrace14621)
    "1464-7" -> decode.success(Detailedrace14647)
    "1465-4" -> decode.success(Detailedrace14654)
    "1466-2" -> decode.success(Detailedrace14662)
    "1467-0" -> decode.success(Detailedrace14670)
    "1468-8" -> decode.success(Detailedrace14688)
    "1469-6" -> decode.success(Detailedrace14696)
    "1470-4" -> decode.success(Detailedrace14704)
    "1471-2" -> decode.success(Detailedrace14712)
    "1472-0" -> decode.success(Detailedrace14720)
    "1474-6" -> decode.success(Detailedrace14746)
    "1475-3" -> decode.success(Detailedrace14753)
    "1476-1" -> decode.success(Detailedrace14761)
    "1478-7" -> decode.success(Detailedrace14787)
    "1479-5" -> decode.success(Detailedrace14795)
    "1480-3" -> decode.success(Detailedrace14803)
    "1481-1" -> decode.success(Detailedrace14811)
    "1482-9" -> decode.success(Detailedrace14829)
    "1483-7" -> decode.success(Detailedrace14837)
    "1484-5" -> decode.success(Detailedrace14845)
    "1485-2" -> decode.success(Detailedrace14852)
    "1487-8" -> decode.success(Detailedrace14878)
    "1489-4" -> decode.success(Detailedrace14894)
    "1490-2" -> decode.success(Detailedrace14902)
    "1491-0" -> decode.success(Detailedrace14910)
    "1492-8" -> decode.success(Detailedrace14928)
    "1493-6" -> decode.success(Detailedrace14936)
    "1494-4" -> decode.success(Detailedrace14944)
    "1495-1" -> decode.success(Detailedrace14951)
    "1496-9" -> decode.success(Detailedrace14969)
    "1497-7" -> decode.success(Detailedrace14977)
    "1498-5" -> decode.success(Detailedrace14985)
    "1499-3" -> decode.success(Detailedrace14993)
    "1500-8" -> decode.success(Detailedrace15008)
    "1501-6" -> decode.success(Detailedrace15016)
    "1502-4" -> decode.success(Detailedrace15024)
    "1503-2" -> decode.success(Detailedrace15032)
    "1504-0" -> decode.success(Detailedrace15040)
    "1505-7" -> decode.success(Detailedrace15057)
    "1506-5" -> decode.success(Detailedrace15065)
    "1507-3" -> decode.success(Detailedrace15073)
    "1508-1" -> decode.success(Detailedrace15081)
    "1509-9" -> decode.success(Detailedrace15099)
    "1510-7" -> decode.success(Detailedrace15107)
    "1511-5" -> decode.success(Detailedrace15115)
    "1512-3" -> decode.success(Detailedrace15123)
    "1513-1" -> decode.success(Detailedrace15131)
    "1514-9" -> decode.success(Detailedrace15149)
    "1515-6" -> decode.success(Detailedrace15156)
    "1516-4" -> decode.success(Detailedrace15164)
    "1518-0" -> decode.success(Detailedrace15180)
    "1519-8" -> decode.success(Detailedrace15198)
    "1520-6" -> decode.success(Detailedrace15206)
    "1521-4" -> decode.success(Detailedrace15214)
    "1522-2" -> decode.success(Detailedrace15222)
    "1523-0" -> decode.success(Detailedrace15230)
    "1524-8" -> decode.success(Detailedrace15248)
    "1525-5" -> decode.success(Detailedrace15255)
    "1526-3" -> decode.success(Detailedrace15263)
    "1527-1" -> decode.success(Detailedrace15271)
    "1528-9" -> decode.success(Detailedrace15289)
    "1529-7" -> decode.success(Detailedrace15297)
    "1530-5" -> decode.success(Detailedrace15305)
    "1531-3" -> decode.success(Detailedrace15313)
    "1532-1" -> decode.success(Detailedrace15321)
    "1533-9" -> decode.success(Detailedrace15339)
    "1534-7" -> decode.success(Detailedrace15347)
    "1535-4" -> decode.success(Detailedrace15354)
    "1536-2" -> decode.success(Detailedrace15362)
    "1537-0" -> decode.success(Detailedrace15370)
    "1538-8" -> decode.success(Detailedrace15388)
    "1539-6" -> decode.success(Detailedrace15396)
    "1541-2" -> decode.success(Detailedrace15412)
    "1543-8" -> decode.success(Detailedrace15438)
    "1545-3" -> decode.success(Detailedrace15453)
    "1547-9" -> decode.success(Detailedrace15479)
    "1549-5" -> decode.success(Detailedrace15495)
    "1551-1" -> decode.success(Detailedrace15511)
    "1552-9" -> decode.success(Detailedrace15529)
    "1553-7" -> decode.success(Detailedrace15537)
    "1554-5" -> decode.success(Detailedrace15545)
    "1556-0" -> decode.success(Detailedrace15560)
    "1558-6" -> decode.success(Detailedrace15586)
    "1560-2" -> decode.success(Detailedrace15602)
    "1562-8" -> decode.success(Detailedrace15628)
    "1564-4" -> decode.success(Detailedrace15644)
    "1566-9" -> decode.success(Detailedrace15669)
    "1567-7" -> decode.success(Detailedrace15677)
    "1568-5" -> decode.success(Detailedrace15685)
    "1569-3" -> decode.success(Detailedrace15693)
    "1570-1" -> decode.success(Detailedrace15701)
    "1571-9" -> decode.success(Detailedrace15719)
    "1573-5" -> decode.success(Detailedrace15735)
    "1574-3" -> decode.success(Detailedrace15743)
    "1576-8" -> decode.success(Detailedrace15768)
    "1578-4" -> decode.success(Detailedrace15784)
    "1579-2" -> decode.success(Detailedrace15792)
    "1580-0" -> decode.success(Detailedrace15800)
    "1582-6" -> decode.success(Detailedrace15826)
    "1584-2" -> decode.success(Detailedrace15842)
    "1586-7" -> decode.success(Detailedrace15867)
    "1587-5" -> decode.success(Detailedrace15875)
    "1588-3" -> decode.success(Detailedrace15883)
    "1589-1" -> decode.success(Detailedrace15891)
    "1590-9" -> decode.success(Detailedrace15909)
    "1591-7" -> decode.success(Detailedrace15917)
    "1592-5" -> decode.success(Detailedrace15925)
    "1593-3" -> decode.success(Detailedrace15933)
    "1594-1" -> decode.success(Detailedrace15941)
    "1595-8" -> decode.success(Detailedrace15958)
    "1596-6" -> decode.success(Detailedrace15966)
    "1597-4" -> decode.success(Detailedrace15974)
    "1598-2" -> decode.success(Detailedrace15982)
    "1599-0" -> decode.success(Detailedrace15990)
    "1600-6" -> decode.success(Detailedrace16006)
    "1602-2" -> decode.success(Detailedrace16022)
    "1603-0" -> decode.success(Detailedrace16030)
    "1604-8" -> decode.success(Detailedrace16048)
    "1605-5" -> decode.success(Detailedrace16055)
    "1607-1" -> decode.success(Detailedrace16071)
    "1609-7" -> decode.success(Detailedrace16097)
    "1610-5" -> decode.success(Detailedrace16105)
    "1611-3" -> decode.success(Detailedrace16113)
    "1612-1" -> decode.success(Detailedrace16121)
    "1613-9" -> decode.success(Detailedrace16139)
    "1614-7" -> decode.success(Detailedrace16147)
    "1615-4" -> decode.success(Detailedrace16154)
    "1616-2" -> decode.success(Detailedrace16162)
    "1617-0" -> decode.success(Detailedrace16170)
    "1618-8" -> decode.success(Detailedrace16188)
    "1619-6" -> decode.success(Detailedrace16196)
    "1620-4" -> decode.success(Detailedrace16204)
    "1621-2" -> decode.success(Detailedrace16212)
    "1622-0" -> decode.success(Detailedrace16220)
    "1623-8" -> decode.success(Detailedrace16238)
    "1624-6" -> decode.success(Detailedrace16246)
    "1625-3" -> decode.success(Detailedrace16253)
    "1626-1" -> decode.success(Detailedrace16261)
    "1627-9" -> decode.success(Detailedrace16279)
    "1628-7" -> decode.success(Detailedrace16287)
    "1629-5" -> decode.success(Detailedrace16295)
    "1630-3" -> decode.success(Detailedrace16303)
    "1631-1" -> decode.success(Detailedrace16311)
    "1632-9" -> decode.success(Detailedrace16329)
    "1633-7" -> decode.success(Detailedrace16337)
    "1634-5" -> decode.success(Detailedrace16345)
    "1635-2" -> decode.success(Detailedrace16352)
    "1636-0" -> decode.success(Detailedrace16360)
    "1637-8" -> decode.success(Detailedrace16378)
    "1638-6" -> decode.success(Detailedrace16386)
    "1639-4" -> decode.success(Detailedrace16394)
    "1640-2" -> decode.success(Detailedrace16402)
    "1641-0" -> decode.success(Detailedrace16410)
    "1643-6" -> decode.success(Detailedrace16436)
    "1645-1" -> decode.success(Detailedrace16451)
    "1647-7" -> decode.success(Detailedrace16477)
    "1649-3" -> decode.success(Detailedrace16493)
    "1651-9" -> decode.success(Detailedrace16519)
    "1653-5" -> decode.success(Detailedrace16535)
    "1654-3" -> decode.success(Detailedrace16543)
    "1655-0" -> decode.success(Detailedrace16550)
    "1656-8" -> decode.success(Detailedrace16568)
    "1657-6" -> decode.success(Detailedrace16576)
    "1659-2" -> decode.success(Detailedrace16592)
    "1661-8" -> decode.success(Detailedrace16618)
    "1663-4" -> decode.success(Detailedrace16634)
    "1665-9" -> decode.success(Detailedrace16659)
    "1667-5" -> decode.success(Detailedrace16675)
    "1668-3" -> decode.success(Detailedrace16683)
    "1670-9" -> decode.success(Detailedrace16709)
    "1671-7" -> decode.success(Detailedrace16717)
    "1672-5" -> decode.success(Detailedrace16725)
    "1673-3" -> decode.success(Detailedrace16733)
    "1675-8" -> decode.success(Detailedrace16758)
    "1677-4" -> decode.success(Detailedrace16774)
    "1679-0" -> decode.success(Detailedrace16790)
    "1680-8" -> decode.success(Detailedrace16808)
    "1681-6" -> decode.success(Detailedrace16816)
    "1683-2" -> decode.success(Detailedrace16832)
    "1685-7" -> decode.success(Detailedrace16857)
    "1687-3" -> decode.success(Detailedrace16873)
    "1688-1" -> decode.success(Detailedrace16881)
    "1689-9" -> decode.success(Detailedrace16899)
    "1690-7" -> decode.success(Detailedrace16907)
    "1692-3" -> decode.success(Detailedrace16923)
    "1694-9" -> decode.success(Detailedrace16949)
    "1696-4" -> decode.success(Detailedrace16964)
    "1697-2" -> decode.success(Detailedrace16972)
    "1698-0" -> decode.success(Detailedrace16980)
    "1700-4" -> decode.success(Detailedrace17004)
    "1702-0" -> decode.success(Detailedrace17020)
    "1704-6" -> decode.success(Detailedrace17046)
    "1705-3" -> decode.success(Detailedrace17053)
    "1707-9" -> decode.success(Detailedrace17079)
    "1709-5" -> decode.success(Detailedrace17095)
    "1711-1" -> decode.success(Detailedrace17111)
    "1712-9" -> decode.success(Detailedrace17129)
    "1713-7" -> decode.success(Detailedrace17137)
    "1715-2" -> decode.success(Detailedrace17152)
    "1717-8" -> decode.success(Detailedrace17178)
    "1718-6" -> decode.success(Detailedrace17186)
    "1719-4" -> decode.success(Detailedrace17194)
    "1720-2" -> decode.success(Detailedrace17202)
    "1722-8" -> decode.success(Detailedrace17228)
    "1724-4" -> decode.success(Detailedrace17244)
    "1725-1" -> decode.success(Detailedrace17251)
    "1726-9" -> decode.success(Detailedrace17269)
    "1727-7" -> decode.success(Detailedrace17277)
    "1728-5" -> decode.success(Detailedrace17285)
    "1729-3" -> decode.success(Detailedrace17293)
    "1730-1" -> decode.success(Detailedrace17301)
    "1731-9" -> decode.success(Detailedrace17319)
    "1732-7" -> decode.success(Detailedrace17327)
    "1733-5" -> decode.success(Detailedrace17335)
    "1735-0" -> decode.success(Detailedrace17350)
    "1737-6" -> decode.success(Detailedrace17376)
    "1739-2" -> decode.success(Detailedrace17392)
    "1740-0" -> decode.success(Detailedrace17400)
    "1741-8" -> decode.success(Detailedrace17418)
    "1742-6" -> decode.success(Detailedrace17426)
    "1743-4" -> decode.success(Detailedrace17434)
    "1744-2" -> decode.success(Detailedrace17442)
    "1745-9" -> decode.success(Detailedrace17459)
    "1746-7" -> decode.success(Detailedrace17467)
    "1747-5" -> decode.success(Detailedrace17475)
    "1748-3" -> decode.success(Detailedrace17483)
    "1749-1" -> decode.success(Detailedrace17491)
    "1750-9" -> decode.success(Detailedrace17509)
    "1751-7" -> decode.success(Detailedrace17517)
    "1752-5" -> decode.success(Detailedrace17525)
    "1753-3" -> decode.success(Detailedrace17533)
    "1754-1" -> decode.success(Detailedrace17541)
    "1755-8" -> decode.success(Detailedrace17558)
    "1756-6" -> decode.success(Detailedrace17566)
    "1757-4" -> decode.success(Detailedrace17574)
    "1758-2" -> decode.success(Detailedrace17582)
    "1759-0" -> decode.success(Detailedrace17590)
    "1760-8" -> decode.success(Detailedrace17608)
    "1761-6" -> decode.success(Detailedrace17616)
    "1762-4" -> decode.success(Detailedrace17624)
    "1763-2" -> decode.success(Detailedrace17632)
    "1764-0" -> decode.success(Detailedrace17640)
    "1765-7" -> decode.success(Detailedrace17657)
    "1766-5" -> decode.success(Detailedrace17665)
    "1767-3" -> decode.success(Detailedrace17673)
    "1768-1" -> decode.success(Detailedrace17681)
    "1769-9" -> decode.success(Detailedrace17699)
    "1770-7" -> decode.success(Detailedrace17707)
    "1771-5" -> decode.success(Detailedrace17715)
    "1772-3" -> decode.success(Detailedrace17723)
    "1773-1" -> decode.success(Detailedrace17731)
    "1774-9" -> decode.success(Detailedrace17749)
    "1775-6" -> decode.success(Detailedrace17756)
    "1776-4" -> decode.success(Detailedrace17764)
    "1777-2" -> decode.success(Detailedrace17772)
    "1778-0" -> decode.success(Detailedrace17780)
    "1779-8" -> decode.success(Detailedrace17798)
    "1780-6" -> decode.success(Detailedrace17806)
    "1781-4" -> decode.success(Detailedrace17814)
    "1782-2" -> decode.success(Detailedrace17822)
    "1783-0" -> decode.success(Detailedrace17830)
    "1784-8" -> decode.success(Detailedrace17848)
    "1785-5" -> decode.success(Detailedrace17855)
    "1786-3" -> decode.success(Detailedrace17863)
    "1787-1" -> decode.success(Detailedrace17871)
    "1788-9" -> decode.success(Detailedrace17889)
    "1789-7" -> decode.success(Detailedrace17897)
    "1790-5" -> decode.success(Detailedrace17905)
    "1791-3" -> decode.success(Detailedrace17913)
    "1792-1" -> decode.success(Detailedrace17921)
    "1793-9" -> decode.success(Detailedrace17939)
    "1794-7" -> decode.success(Detailedrace17947)
    "1795-4" -> decode.success(Detailedrace17954)
    "1796-2" -> decode.success(Detailedrace17962)
    "1797-0" -> decode.success(Detailedrace17970)
    "1798-8" -> decode.success(Detailedrace17988)
    "1799-6" -> decode.success(Detailedrace17996)
    "1800-2" -> decode.success(Detailedrace18002)
    "1801-0" -> decode.success(Detailedrace18010)
    "1802-8" -> decode.success(Detailedrace18028)
    "1803-6" -> decode.success(Detailedrace18036)
    "1804-4" -> decode.success(Detailedrace18044)
    "1805-1" -> decode.success(Detailedrace18051)
    "1806-9" -> decode.success(Detailedrace18069)
    "1807-7" -> decode.success(Detailedrace18077)
    "1808-5" -> decode.success(Detailedrace18085)
    "1809-3" -> decode.success(Detailedrace18093)
    "1811-9" -> decode.success(Detailedrace18119)
    "1813-5" -> decode.success(Detailedrace18135)
    "1814-3" -> decode.success(Detailedrace18143)
    "1815-0" -> decode.success(Detailedrace18150)
    "1816-8" -> decode.success(Detailedrace18168)
    "1817-6" -> decode.success(Detailedrace18176)
    "1818-4" -> decode.success(Detailedrace18184)
    "1819-2" -> decode.success(Detailedrace18192)
    "1820-0" -> decode.success(Detailedrace18200)
    "1821-8" -> decode.success(Detailedrace18218)
    "1822-6" -> decode.success(Detailedrace18226)
    "1823-4" -> decode.success(Detailedrace18234)
    "1824-2" -> decode.success(Detailedrace18242)
    "1825-9" -> decode.success(Detailedrace18259)
    "1826-7" -> decode.success(Detailedrace18267)
    "1827-5" -> decode.success(Detailedrace18275)
    "1828-3" -> decode.success(Detailedrace18283)
    "1829-1" -> decode.success(Detailedrace18291)
    "1830-9" -> decode.success(Detailedrace18309)
    "1831-7" -> decode.success(Detailedrace18317)
    "1832-5" -> decode.success(Detailedrace18325)
    "1833-3" -> decode.success(Detailedrace18333)
    "1834-1" -> decode.success(Detailedrace18341)
    "1835-8" -> decode.success(Detailedrace18358)
    "1837-4" -> decode.success(Detailedrace18374)
    "1838-2" -> decode.success(Detailedrace18382)
    "1840-8" -> decode.success(Detailedrace18408)
    "1842-4" -> decode.success(Detailedrace18424)
    "1844-0" -> decode.success(Detailedrace18440)
    "1845-7" -> decode.success(Detailedrace18457)
    "1846-5" -> decode.success(Detailedrace18465)
    "1847-3" -> decode.success(Detailedrace18473)
    "1848-1" -> decode.success(Detailedrace18481)
    "1849-9" -> decode.success(Detailedrace18499)
    "1850-7" -> decode.success(Detailedrace18507)
    "1851-5" -> decode.success(Detailedrace18515)
    "1852-3" -> decode.success(Detailedrace18523)
    "1853-1" -> decode.success(Detailedrace18531)
    "1854-9" -> decode.success(Detailedrace18549)
    "1855-6" -> decode.success(Detailedrace18556)
    "1856-4" -> decode.success(Detailedrace18564)
    "1857-2" -> decode.success(Detailedrace18572)
    "1858-0" -> decode.success(Detailedrace18580)
    "1859-8" -> decode.success(Detailedrace18598)
    "1860-6" -> decode.success(Detailedrace18606)
    "1861-4" -> decode.success(Detailedrace18614)
    "1862-2" -> decode.success(Detailedrace18622)
    "1863-0" -> decode.success(Detailedrace18630)
    "1864-8" -> decode.success(Detailedrace18648)
    "1865-5" -> decode.success(Detailedrace18655)
    "1866-3" -> decode.success(Detailedrace18663)
    "1867-1" -> decode.success(Detailedrace18671)
    "1868-9" -> decode.success(Detailedrace18689)
    "1869-7" -> decode.success(Detailedrace18697)
    "1870-5" -> decode.success(Detailedrace18705)
    "1871-3" -> decode.success(Detailedrace18713)
    "1872-1" -> decode.success(Detailedrace18721)
    "1873-9" -> decode.success(Detailedrace18739)
    "1874-7" -> decode.success(Detailedrace18747)
    "1875-4" -> decode.success(Detailedrace18754)
    "1876-2" -> decode.success(Detailedrace18762)
    "1877-0" -> decode.success(Detailedrace18770)
    "1878-8" -> decode.success(Detailedrace18788)
    "1879-6" -> decode.success(Detailedrace18796)
    "1880-4" -> decode.success(Detailedrace18804)
    "1881-2" -> decode.success(Detailedrace18812)
    "1882-0" -> decode.success(Detailedrace18820)
    "1883-8" -> decode.success(Detailedrace18838)
    "1884-6" -> decode.success(Detailedrace18846)
    "1885-3" -> decode.success(Detailedrace18853)
    "1886-1" -> decode.success(Detailedrace18861)
    "1887-9" -> decode.success(Detailedrace18879)
    "1888-7" -> decode.success(Detailedrace18887)
    "1889-5" -> decode.success(Detailedrace18895)
    "1891-1" -> decode.success(Detailedrace18911)
    "1892-9" -> decode.success(Detailedrace18929)
    "1893-7" -> decode.success(Detailedrace18937)
    "1894-5" -> decode.success(Detailedrace18945)
    "1896-0" -> decode.success(Detailedrace18960)
    "1897-8" -> decode.success(Detailedrace18978)
    "1898-6" -> decode.success(Detailedrace18986)
    "1899-4" -> decode.success(Detailedrace18994)
    "1900-0" -> decode.success(Detailedrace19000)
    "1901-8" -> decode.success(Detailedrace19018)
    "1902-6" -> decode.success(Detailedrace19026)
    "1903-4" -> decode.success(Detailedrace19034)
    "1904-2" -> decode.success(Detailedrace19042)
    "1905-9" -> decode.success(Detailedrace19059)
    "1906-7" -> decode.success(Detailedrace19067)
    "1907-5" -> decode.success(Detailedrace19075)
    "1908-3" -> decode.success(Detailedrace19083)
    "1909-1" -> decode.success(Detailedrace19091)
    "1910-9" -> decode.success(Detailedrace19109)
    "1911-7" -> decode.success(Detailedrace19117)
    "1912-5" -> decode.success(Detailedrace19125)
    "1913-3" -> decode.success(Detailedrace19133)
    "1914-1" -> decode.success(Detailedrace19141)
    "1915-8" -> decode.success(Detailedrace19158)
    "1916-6" -> decode.success(Detailedrace19166)
    "1917-4" -> decode.success(Detailedrace19174)
    "1918-2" -> decode.success(Detailedrace19182)
    "1919-0" -> decode.success(Detailedrace19190)
    "1920-8" -> decode.success(Detailedrace19208)
    "1921-6" -> decode.success(Detailedrace19216)
    "1922-4" -> decode.success(Detailedrace19224)
    "1923-2" -> decode.success(Detailedrace19232)
    "1924-0" -> decode.success(Detailedrace19240)
    "1925-7" -> decode.success(Detailedrace19257)
    "1926-5" -> decode.success(Detailedrace19265)
    "1927-3" -> decode.success(Detailedrace19273)
    "1928-1" -> decode.success(Detailedrace19281)
    "1929-9" -> decode.success(Detailedrace19299)
    "1930-7" -> decode.success(Detailedrace19307)
    "1931-5" -> decode.success(Detailedrace19315)
    "1932-3" -> decode.success(Detailedrace19323)
    "1933-1" -> decode.success(Detailedrace19331)
    "1934-9" -> decode.success(Detailedrace19349)
    "1935-6" -> decode.success(Detailedrace19356)
    "1936-4" -> decode.success(Detailedrace19364)
    "1937-2" -> decode.success(Detailedrace19372)
    "1938-0" -> decode.success(Detailedrace19380)
    "1939-8" -> decode.success(Detailedrace19398)
    "1940-6" -> decode.success(Detailedrace19406)
    "1941-4" -> decode.success(Detailedrace19414)
    "1942-2" -> decode.success(Detailedrace19422)
    "1943-0" -> decode.success(Detailedrace19430)
    "1944-8" -> decode.success(Detailedrace19448)
    "1945-5" -> decode.success(Detailedrace19455)
    "1946-3" -> decode.success(Detailedrace19463)
    "1947-1" -> decode.success(Detailedrace19471)
    "1948-9" -> decode.success(Detailedrace19489)
    "1949-7" -> decode.success(Detailedrace19497)
    "1950-5" -> decode.success(Detailedrace19505)
    "1951-3" -> decode.success(Detailedrace19513)
    "1952-1" -> decode.success(Detailedrace19521)
    "1953-9" -> decode.success(Detailedrace19539)
    "1954-7" -> decode.success(Detailedrace19547)
    "1955-4" -> decode.success(Detailedrace19554)
    "1956-2" -> decode.success(Detailedrace19562)
    "1957-0" -> decode.success(Detailedrace19570)
    "1958-8" -> decode.success(Detailedrace19588)
    "1959-6" -> decode.success(Detailedrace19596)
    "1960-4" -> decode.success(Detailedrace19604)
    "1961-2" -> decode.success(Detailedrace19612)
    "1962-0" -> decode.success(Detailedrace19620)
    "1963-8" -> decode.success(Detailedrace19638)
    "1964-6" -> decode.success(Detailedrace19646)
    "1966-1" -> decode.success(Detailedrace19661)
    "1968-7" -> decode.success(Detailedrace19687)
    "1969-5" -> decode.success(Detailedrace19695)
    "1970-3" -> decode.success(Detailedrace19703)
    "1972-9" -> decode.success(Detailedrace19729)
    "1973-7" -> decode.success(Detailedrace19737)
    "1974-5" -> decode.success(Detailedrace19745)
    "1975-2" -> decode.success(Detailedrace19752)
    "1976-0" -> decode.success(Detailedrace19760)
    "1977-8" -> decode.success(Detailedrace19778)
    "1978-6" -> decode.success(Detailedrace19786)
    "1979-4" -> decode.success(Detailedrace19794)
    "1980-2" -> decode.success(Detailedrace19802)
    "1981-0" -> decode.success(Detailedrace19810)
    "1982-8" -> decode.success(Detailedrace19828)
    "1984-4" -> decode.success(Detailedrace19844)
    "1985-1" -> decode.success(Detailedrace19851)
    "1986-9" -> decode.success(Detailedrace19869)
    "1987-7" -> decode.success(Detailedrace19877)
    "1988-5" -> decode.success(Detailedrace19885)
    "1990-1" -> decode.success(Detailedrace19901)
    "1992-7" -> decode.success(Detailedrace19927)
    "1993-5" -> decode.success(Detailedrace19935)
    "1994-3" -> decode.success(Detailedrace19943)
    "1995-0" -> decode.success(Detailedrace19950)
    "1996-8" -> decode.success(Detailedrace19968)
    "1997-6" -> decode.success(Detailedrace19976)
    "1998-4" -> decode.success(Detailedrace19984)
    "1999-2" -> decode.success(Detailedrace19992)
    "2000-8" -> decode.success(Detailedrace20008)
    "2002-4" -> decode.success(Detailedrace20024)
    "2004-0" -> decode.success(Detailedrace20040)
    "2006-5" -> decode.success(Detailedrace20065)
    "2007-3" -> decode.success(Detailedrace20073)
    "2008-1" -> decode.success(Detailedrace20081)
    "2009-9" -> decode.success(Detailedrace20099)
    "2010-7" -> decode.success(Detailedrace20107)
    "2011-5" -> decode.success(Detailedrace20115)
    "2012-3" -> decode.success(Detailedrace20123)
    "2013-1" -> decode.success(Detailedrace20131)
    "2014-9" -> decode.success(Detailedrace20149)
    "2015-6" -> decode.success(Detailedrace20156)
    "2016-4" -> decode.success(Detailedrace20164)
    "2017-2" -> decode.success(Detailedrace20172)
    "2018-0" -> decode.success(Detailedrace20180)
    "2019-8" -> decode.success(Detailedrace20198)
    "2020-6" -> decode.success(Detailedrace20206)
    "2021-4" -> decode.success(Detailedrace20214)
    "2022-2" -> decode.success(Detailedrace20222)
    "2023-0" -> decode.success(Detailedrace20230)
    "2024-8" -> decode.success(Detailedrace20248)
    "2025-5" -> decode.success(Detailedrace20255)
    "2026-3" -> decode.success(Detailedrace20263)
    "2028-9" -> decode.success(Detailedrace20289)
    "2029-7" -> decode.success(Detailedrace20297)
    "2030-5" -> decode.success(Detailedrace20305)
    "2031-3" -> decode.success(Detailedrace20313)
    "2032-1" -> decode.success(Detailedrace20321)
    "2033-9" -> decode.success(Detailedrace20339)
    "2034-7" -> decode.success(Detailedrace20347)
    "2035-4" -> decode.success(Detailedrace20354)
    "2036-2" -> decode.success(Detailedrace20362)
    "2037-0" -> decode.success(Detailedrace20370)
    "2038-8" -> decode.success(Detailedrace20388)
    "2039-6" -> decode.success(Detailedrace20396)
    "2040-4" -> decode.success(Detailedrace20404)
    "2041-2" -> decode.success(Detailedrace20412)
    "2042-0" -> decode.success(Detailedrace20420)
    "2043-8" -> decode.success(Detailedrace20438)
    "2044-6" -> decode.success(Detailedrace20446)
    "2045-3" -> decode.success(Detailedrace20453)
    "2046-1" -> decode.success(Detailedrace20461)
    "2047-9" -> decode.success(Detailedrace20479)
    "2048-7" -> decode.success(Detailedrace20487)
    "2049-5" -> decode.success(Detailedrace20495)
    "2050-3" -> decode.success(Detailedrace20503)
    "2051-1" -> decode.success(Detailedrace20511)
    "2052-9" -> decode.success(Detailedrace20529)
    "2054-5" -> decode.success(Detailedrace20545)
    "2056-0" -> decode.success(Detailedrace20560)
    "2058-6" -> decode.success(Detailedrace20586)
    "2060-2" -> decode.success(Detailedrace20602)
    "2061-0" -> decode.success(Detailedrace20610)
    "2062-8" -> decode.success(Detailedrace20628)
    "2063-6" -> decode.success(Detailedrace20636)
    "2064-4" -> decode.success(Detailedrace20644)
    "2065-1" -> decode.success(Detailedrace20651)
    "2066-9" -> decode.success(Detailedrace20669)
    "2067-7" -> decode.success(Detailedrace20677)
    "2068-5" -> decode.success(Detailedrace20685)
    "2069-3" -> decode.success(Detailedrace20693)
    "2070-1" -> decode.success(Detailedrace20701)
    "2071-9" -> decode.success(Detailedrace20719)
    "2072-7" -> decode.success(Detailedrace20727)
    "2073-5" -> decode.success(Detailedrace20735)
    "2074-3" -> decode.success(Detailedrace20743)
    "2075-0" -> decode.success(Detailedrace20750)
    "2076-8" -> decode.success(Detailedrace20768)
    "2078-4" -> decode.success(Detailedrace20784)
    "2079-2" -> decode.success(Detailedrace20792)
    "2080-0" -> decode.success(Detailedrace20800)
    "2081-8" -> decode.success(Detailedrace20818)
    "2082-6" -> decode.success(Detailedrace20826)
    "2083-4" -> decode.success(Detailedrace20834)
    "2085-9" -> decode.success(Detailedrace20859)
    "2086-7" -> decode.success(Detailedrace20867)
    "2087-5" -> decode.success(Detailedrace20875)
    "2088-3" -> decode.success(Detailedrace20883)
    "2089-1" -> decode.success(Detailedrace20891)
    "2090-9" -> decode.success(Detailedrace20909)
    "2091-7" -> decode.success(Detailedrace20917)
    "2092-5" -> decode.success(Detailedrace20925)
    "2093-3" -> decode.success(Detailedrace20933)
    "2094-1" -> decode.success(Detailedrace20941)
    "2095-8" -> decode.success(Detailedrace20958)
    "2096-6" -> decode.success(Detailedrace20966)
    "2097-4" -> decode.success(Detailedrace20974)
    "2098-2" -> decode.success(Detailedrace20982)
    "2100-6" -> decode.success(Detailedrace21006)
    "2101-4" -> decode.success(Detailedrace21014)
    "2102-2" -> decode.success(Detailedrace21022)
    "2103-0" -> decode.success(Detailedrace21030)
    "2104-8" -> decode.success(Detailedrace21048)
    "2106-3" -> decode.success(Detailedrace21063)
    "2108-9" -> decode.success(Detailedrace21089)
    "2109-7" -> decode.success(Detailedrace21097)
    "2110-5" -> decode.success(Detailedrace21105)
    "2111-3" -> decode.success(Detailedrace21113)
    "2112-1" -> decode.success(Detailedrace21121)
    "2113-9" -> decode.success(Detailedrace21139)
    "2114-7" -> decode.success(Detailedrace21147)
    "2115-4" -> decode.success(Detailedrace21154)
    "2116-2" -> decode.success(Detailedrace21162)
    "2118-8" -> decode.success(Detailedrace21188)
    "2119-6" -> decode.success(Detailedrace21196)
    "2120-4" -> decode.success(Detailedrace21204)
    "2121-2" -> decode.success(Detailedrace21212)
    "2122-0" -> decode.success(Detailedrace21220)
    "2123-8" -> decode.success(Detailedrace21238)
    "2124-6" -> decode.success(Detailedrace21246)
    "2125-3" -> decode.success(Detailedrace21253)
    "2126-1" -> decode.success(Detailedrace21261)
    "2127-9" -> decode.success(Detailedrace21279)
    "2129-5" -> decode.success(Detailedrace21295)
    "2131-1" -> decode.success(Detailedrace21311)
    "2133-7" -> decode.success(Detailedrace21337)
    "2135-2" -> decode.success(Detailedrace21352)
    "2137-8" -> decode.success(Detailedrace21378)
    "2138-6" -> decode.success(Detailedrace21386)
    "2139-4" -> decode.success(Detailedrace21394)
    "2140-2" -> decode.success(Detailedrace21402)
    "2141-0" -> decode.success(Detailedrace21410)
    "2142-8" -> decode.success(Detailedrace21428)
    "2143-6" -> decode.success(Detailedrace21436)
    "2144-4" -> decode.success(Detailedrace21444)
    "2145-1" -> decode.success(Detailedrace21451)
    "2146-9" -> decode.success(Detailedrace21469)
    "2148-5" -> decode.success(Detailedrace21485)
    "2149-3" -> decode.success(Detailedrace21493)
    "2150-1" -> decode.success(Detailedrace21501)
    "2151-9" -> decode.success(Detailedrace21519)
    "2152-7" -> decode.success(Detailedrace21527)
    "2153-5" -> decode.success(Detailedrace21535)
    "2155-0" -> decode.success(Detailedrace21550)
    "2156-8" -> decode.success(Detailedrace21568)
    "2157-6" -> decode.success(Detailedrace21576)
    "2158-4" -> decode.success(Detailedrace21584)
    "2159-2" -> decode.success(Detailedrace21592)
    "2160-0" -> decode.success(Detailedrace21600)
    "2161-8" -> decode.success(Detailedrace21618)
    "2162-6" -> decode.success(Detailedrace21626)
    "2163-4" -> decode.success(Detailedrace21634)
    "2165-9" -> decode.success(Detailedrace21659)
    "2166-7" -> decode.success(Detailedrace21667)
    "2167-5" -> decode.success(Detailedrace21675)
    "2168-3" -> decode.success(Detailedrace21683)
    "2169-1" -> decode.success(Detailedrace21691)
    "2170-9" -> decode.success(Detailedrace21709)
    "2171-7" -> decode.success(Detailedrace21717)
    "2172-5" -> decode.success(Detailedrace21725)
    "2173-3" -> decode.success(Detailedrace21733)
    "2174-1" -> decode.success(Detailedrace21741)
    "2175-8" -> decode.success(Detailedrace21758)
    "2176-6" -> decode.success(Detailedrace21766)
    "2178-2" -> decode.success(Detailedrace21782)
    "2180-8" -> decode.success(Detailedrace21808)
    "2182-4" -> decode.success(Detailedrace21824)
    "2184-0" -> decode.success(Detailedrace21840)
    "2186-5" -> decode.success(Detailedrace21865)
    "2500-7" -> decode.success(Detailedrace25007)
    "ASKU" -> decode.success(DetailedraceAsku)
    "OTH" -> decode.success(DetailedraceOth)
    "UNK" -> decode.success(DetailedraceUnk)
    _ -> decode.failure(Detailedrace10009, "Detailedrace")
  }
}

pub fn detailedrace_system(detailedrace: Detailedrace) -> String {
  case detailedrace {
    Detailedrace10009 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10025 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10041 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10066 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10082 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10108 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10116 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10124 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10132 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10140 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10157 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10165 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10173 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10181 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10199 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10215 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10223 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10231 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10249 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10264 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10280 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10306 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10314 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10330 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10355 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10371 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10397 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10413 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10421 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10447 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10454 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10462 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10470 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10488 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10496 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10504 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10512 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10538 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10546 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10553 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10561 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10579 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10587 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10595 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10603 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10611 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10629 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10637 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10645 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10652 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10660 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10686 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10694 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10702 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10710 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10728 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10736 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10744 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10769 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10785 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10801 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10827 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10835 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10843 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10868 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10884 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10892 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10900 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10918 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10926 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10934 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10942 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10959 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10967 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10975 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace10983 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11007 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11023 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11031 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11049 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11064 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11080 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11098 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11106 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11122 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11148 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11155 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11163 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11171 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11189 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11197 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11205 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11213 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11239 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11247 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11254 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11262 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11270 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11288 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11296 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11304 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11312 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11320 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11338 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11346 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11353 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11361 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11379 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11387 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11395 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11403 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11411 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11429 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11437 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11445 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11452 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11460 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11478 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11486 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11502 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11510 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11536 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11551 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11569 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11577 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11585 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11593 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11601 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11627 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11635 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11650 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11676 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11692 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11718 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11734 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11759 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11767 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11783 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11809 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11825 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11841 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11866 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11874 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11890 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11916 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11932 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11940 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11957 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11965 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11973 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11981 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace11999 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12005 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12013 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12021 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12039 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12047 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12054 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12070 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12096 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12112 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12120 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12146 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12153 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12161 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12179 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12187 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12195 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12203 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12229 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12237 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12245 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12252 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12260 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12278 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12286 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12294 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12302 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12310 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12336 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12344 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12351 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12369 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12377 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12385 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12393 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12401 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12419 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12427 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12435 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12443 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12450 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12468 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12476 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12484 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12500 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12526 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12542 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12567 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12583 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12609 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12625 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12641 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12658 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12674 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12690 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12716 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12724 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12732 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12757 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12773 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12799 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12815 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12823 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12831 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12856 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12864 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12872 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12880 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12898 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12906 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12914 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12922 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12930 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12948 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12955 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12971 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace12997 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13011 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13037 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13052 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13060 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13078 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13094 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13102 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13128 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13136 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13144 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13151 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13177 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13193 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13219 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13235 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13250 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13268 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13276 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13284 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13292 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13318 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13326 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13334 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13342 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13359 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13367 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13375 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13383 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13409 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13425 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13441 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13458 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13466 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13482 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13508 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13524 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13540 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13565 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13581 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13599 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13607 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13615 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13631 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13656 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13664 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13680 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13706 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13722 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13748 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13763 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13789 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13805 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13821 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13839 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13847 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13854 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13870 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13896 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13912 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13920 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13938 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13946 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13953 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13961 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13979 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13987 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace13995 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14001 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14019 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14035 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14050 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14076 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14092 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14118 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14126 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14134 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14142 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14167 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14175 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14183 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14191 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14209 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14217 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14225 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14233 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14241 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14258 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14266 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14274 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14282 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14290 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14308 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14316 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14324 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14332 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14340 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14357 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14365 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14373 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14399 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14415 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14423 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14431 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14456 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14464 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14480 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14506 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14514 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14530 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14548 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14563 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14571 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14589 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14605 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14621 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14647 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14654 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14662 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14670 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14688 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14696 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14704 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14712 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14720 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14746 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14753 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14761 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14787 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14795 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14803 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14811 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14829 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14837 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14845 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14852 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14878 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14894 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14902 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14910 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14928 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14936 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14944 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14951 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14969 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14977 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14985 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace14993 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15008 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15016 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15024 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15032 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15040 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15057 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15065 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15073 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15081 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15099 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15107 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15115 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15123 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15131 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15149 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15156 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15164 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15180 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15198 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15206 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15214 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15222 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15230 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15248 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15255 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15263 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15271 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15289 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15297 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15305 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15313 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15321 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15339 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15347 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15354 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15362 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15370 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15388 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15396 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15412 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15438 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15453 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15479 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15495 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15511 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15529 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15537 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15545 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15560 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15586 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15602 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15628 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15644 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15669 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15677 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15685 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15693 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15701 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15719 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15735 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15743 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15768 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15784 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15792 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15800 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15826 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15842 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15867 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15875 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15883 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15891 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15909 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15917 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15925 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15933 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15941 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15958 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15966 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15974 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15982 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace15990 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16006 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16022 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16030 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16048 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16055 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16071 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16097 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16105 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16113 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16121 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16139 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16147 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16154 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16162 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16170 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16188 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16196 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16204 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16212 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16220 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16238 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16246 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16253 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16261 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16279 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16287 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16295 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16303 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16311 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16329 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16337 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16345 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16352 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16360 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16378 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16386 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16394 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16402 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16410 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16436 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16451 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16477 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16493 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16519 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16535 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16543 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16550 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16568 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16576 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16592 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16618 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16634 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16659 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16675 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16683 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16709 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16717 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16725 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16733 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16758 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16774 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16790 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16808 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16816 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16832 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16857 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16873 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16881 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16899 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16907 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16923 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16949 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16964 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16972 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace16980 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17004 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17020 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17046 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17053 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17079 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17095 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17111 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17129 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17137 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17152 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17178 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17186 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17194 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17202 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17228 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17244 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17251 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17269 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17277 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17285 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17293 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17301 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17319 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17327 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17335 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17350 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17376 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17392 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17400 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17418 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17426 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17434 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17442 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17459 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17467 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17475 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17483 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17491 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17509 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17517 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17525 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17533 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17541 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17558 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17566 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17574 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17582 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17590 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17608 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17616 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17624 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17632 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17640 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17657 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17665 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17673 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17681 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17699 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17707 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17715 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17723 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17731 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17749 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17756 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17764 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17772 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17780 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17798 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17806 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17814 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17822 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17830 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17848 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17855 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17863 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17871 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17889 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17897 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17905 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17913 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17921 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17939 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17947 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17954 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17962 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17970 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17988 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace17996 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18002 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18010 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18028 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18036 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18044 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18051 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18069 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18077 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18085 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18093 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18119 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18135 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18143 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18150 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18168 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18176 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18184 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18192 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18200 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18218 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18226 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18234 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18242 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18259 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18267 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18275 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18283 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18291 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18309 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18317 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18325 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18333 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18341 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18358 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18374 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18382 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18408 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18424 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18440 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18457 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18465 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18473 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18481 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18499 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18507 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18515 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18523 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18531 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18549 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18556 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18564 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18572 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18580 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18598 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18606 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18614 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18622 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18630 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18648 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18655 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18663 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18671 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18689 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18697 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18705 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18713 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18721 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18739 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18747 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18754 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18762 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18770 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18788 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18796 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18804 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18812 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18820 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18838 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18846 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18853 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18861 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18879 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18887 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18895 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18911 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18929 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18937 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18945 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18960 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18978 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18986 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace18994 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19000 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19018 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19026 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19034 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19042 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19059 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19067 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19075 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19083 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19091 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19109 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19117 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19125 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19133 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19141 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19158 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19166 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19174 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19182 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19190 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19208 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19216 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19224 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19232 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19240 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19257 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19265 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19273 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19281 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19299 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19307 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19315 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19323 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19331 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19349 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19356 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19364 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19372 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19380 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19398 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19406 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19414 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19422 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19430 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19448 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19455 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19463 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19471 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19489 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19497 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19505 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19513 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19521 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19539 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19547 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19554 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19562 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19570 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19588 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19596 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19604 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19612 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19620 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19638 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19646 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19661 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19687 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19695 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19703 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19729 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19737 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19745 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19752 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19760 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19778 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19786 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19794 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19802 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19810 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19828 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19844 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19851 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19869 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19877 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19885 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19901 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19927 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19935 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19943 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19950 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19968 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19976 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19984 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace19992 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20008 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20024 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20040 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20065 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20073 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20081 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20099 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20107 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20115 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20123 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20131 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20149 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20156 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20164 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20172 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20180 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20198 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20206 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20214 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20222 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20230 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20248 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20255 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20263 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20289 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20297 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20305 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20313 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20321 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20339 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20347 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20354 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20362 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20370 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20388 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20396 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20404 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20412 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20420 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20438 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20446 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20453 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20461 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20479 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20487 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20495 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20503 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20511 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20529 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20545 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20560 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20586 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20602 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20610 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20628 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20636 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20644 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20651 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20669 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20677 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20685 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20693 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20701 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20719 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20727 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20735 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20743 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20750 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20768 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20784 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20792 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20800 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20818 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20826 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20834 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20859 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20867 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20875 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20883 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20891 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20909 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20917 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20925 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20933 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20941 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20958 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20966 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20974 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace20982 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21006 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21014 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21022 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21030 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21048 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21063 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21089 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21097 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21105 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21113 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21121 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21139 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21147 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21154 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21162 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21188 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21196 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21204 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21212 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21220 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21238 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21246 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21253 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21261 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21279 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21295 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21311 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21337 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21352 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21378 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21386 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21394 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21402 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21410 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21428 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21436 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21444 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21451 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21469 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21485 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21493 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21501 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21519 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21527 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21535 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21550 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21568 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21576 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21584 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21592 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21600 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21618 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21626 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21634 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21659 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21667 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21675 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21683 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21691 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21709 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21717 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21725 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21733 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21741 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21758 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21766 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21782 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21808 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21824 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21840 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace21865 -> "urn:oid:2.16.840.1.113883.6.238"
    Detailedrace25007 -> "urn:oid:2.16.840.1.113883.6.238"
    DetailedraceAsku -> "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
    DetailedraceOth -> "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
    DetailedraceUnk -> "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
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
  case variant {
    "MORN" -> decode.success(EventtimingMorn)
    "MORN.early" -> decode.success(EventtimingMornearly)
    "MORN.late" -> decode.success(EventtimingMornlate)
    "NOON" -> decode.success(EventtimingNoon)
    "AFT" -> decode.success(EventtimingAft)
    "AFT.early" -> decode.success(EventtimingAftearly)
    "AFT.late" -> decode.success(EventtimingAftlate)
    "EVE" -> decode.success(EventtimingEve)
    "EVE.early" -> decode.success(EventtimingEveearly)
    "EVE.late" -> decode.success(EventtimingEvelate)
    "NIGHT" -> decode.success(EventtimingNight)
    "PHS" -> decode.success(EventtimingPhs)
    "HS" -> decode.success(EventtimingHs)
    "WAKE" -> decode.success(EventtimingWake)
    "C" -> decode.success(EventtimingC)
    "CM" -> decode.success(EventtimingCm)
    "CD" -> decode.success(EventtimingCd)
    "CV" -> decode.success(EventtimingCv)
    "AC" -> decode.success(EventtimingAc)
    "ACM" -> decode.success(EventtimingAcm)
    "ACD" -> decode.success(EventtimingAcd)
    "ACV" -> decode.success(EventtimingAcv)
    "PC" -> decode.success(EventtimingPc)
    "PCM" -> decode.success(EventtimingPcm)
    "PCD" -> decode.success(EventtimingPcd)
    "PCV" -> decode.success(EventtimingPcv)
    _ -> decode.failure(EventtimingMorn, "Eventtiming")
  }
}

pub type Httpverb {
  HttpverbGet
  HttpverbHead
  HttpverbPost
  HttpverbPut
  HttpverbDelete
  HttpverbPatch
}

pub fn httpverb_to_json(httpverb: Httpverb) -> Json {
  json.string(httpverb_to_code(httpverb))
}

pub fn httpverb_to_code(httpverb: Httpverb) -> String {
  case httpverb {
    HttpverbGet -> "GET"
    HttpverbHead -> "HEAD"
    HttpverbPost -> "POST"
    HttpverbPut -> "PUT"
    HttpverbDelete -> "DELETE"
    HttpverbPatch -> "PATCH"
  }
}

pub fn httpverb_from_code(code: String) -> Result(Httpverb, Nil) {
  case code {
    "GET" -> Ok(HttpverbGet)
    "HEAD" -> Ok(HttpverbHead)
    "POST" -> Ok(HttpverbPost)
    "PUT" -> Ok(HttpverbPut)
    "DELETE" -> Ok(HttpverbDelete)
    "PATCH" -> Ok(HttpverbPatch)
    _ -> Error(Nil)
  }
}

pub fn httpverb_decoder() -> Decoder(Httpverb) {
  use variant <- decode.then(decode.string)
  case variant {
    "GET" -> decode.success(HttpverbGet)
    "HEAD" -> decode.success(HttpverbHead)
    "POST" -> decode.success(HttpverbPost)
    "PUT" -> decode.success(HttpverbPut)
    "DELETE" -> decode.success(HttpverbDelete)
    "PATCH" -> decode.success(HttpverbPatch)
    _ -> decode.failure(HttpverbGet, "Httpverb")
  }
}

pub type Identifieruse {
  IdentifieruseUsual
  IdentifieruseOfficial
  IdentifieruseTemp
  IdentifieruseSecondary
  IdentifieruseOld
}

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
  case variant {
    "usual" -> decode.success(IdentifieruseUsual)
    "official" -> decode.success(IdentifieruseOfficial)
    "temp" -> decode.success(IdentifieruseTemp)
    "secondary" -> decode.success(IdentifieruseSecondary)
    "old" -> decode.success(IdentifieruseOld)
    _ -> decode.failure(IdentifieruseUsual, "Identifieruse")
  }
}

pub type Issueseverity {
  IssueseverityFatal
  IssueseverityError
  IssueseverityWarning
  IssueseverityInformation
}

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
  case variant {
    "fatal" -> decode.success(IssueseverityFatal)
    "error" -> decode.success(IssueseverityError)
    "warning" -> decode.success(IssueseverityWarning)
    "information" -> decode.success(IssueseverityInformation)
    _ -> decode.failure(IssueseverityFatal, "Issueseverity")
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
  case variant {
    "invalid" -> decode.success(IssuetypeInvalid)
    "structure" -> decode.success(IssuetypeStructure)
    "required" -> decode.success(IssuetypeRequired)
    "value" -> decode.success(IssuetypeValue)
    "invariant" -> decode.success(IssuetypeInvariant)
    "security" -> decode.success(IssuetypeSecurity)
    "login" -> decode.success(IssuetypeLogin)
    "unknown" -> decode.success(IssuetypeUnknown)
    "expired" -> decode.success(IssuetypeExpired)
    "forbidden" -> decode.success(IssuetypeForbidden)
    "suppressed" -> decode.success(IssuetypeSuppressed)
    "processing" -> decode.success(IssuetypeProcessing)
    "not-supported" -> decode.success(IssuetypeNotsupported)
    "duplicate" -> decode.success(IssuetypeDuplicate)
    "multiple-matches" -> decode.success(IssuetypeMultiplematches)
    "not-found" -> decode.success(IssuetypeNotfound)
    "deleted" -> decode.success(IssuetypeDeleted)
    "too-long" -> decode.success(IssuetypeToolong)
    "code-invalid" -> decode.success(IssuetypeCodeinvalid)
    "extension" -> decode.success(IssuetypeExtension)
    "too-costly" -> decode.success(IssuetypeToocostly)
    "business-rule" -> decode.success(IssuetypeBusinessrule)
    "conflict" -> decode.success(IssuetypeConflict)
    "transient" -> decode.success(IssuetypeTransient)
    "lock-error" -> decode.success(IssuetypeLockerror)
    "no-store" -> decode.success(IssuetypeNostore)
    "exception" -> decode.success(IssuetypeException)
    "timeout" -> decode.success(IssuetypeTimeout)
    "incomplete" -> decode.success(IssuetypeIncomplete)
    "throttled" -> decode.success(IssuetypeThrottled)
    "informational" -> decode.success(IssuetypeInformational)
    _ -> decode.failure(IssuetypeInvalid, "Issuetype")
  }
}

pub type Linktype {
  LinktypeReplacedby
  LinktypeReplaces
  LinktypeRefer
  LinktypeSeealso
}

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
  case variant {
    "replaced-by" -> decode.success(LinktypeReplacedby)
    "replaces" -> decode.success(LinktypeReplaces)
    "refer" -> decode.success(LinktypeRefer)
    "seealso" -> decode.success(LinktypeSeealso)
    _ -> decode.failure(LinktypeReplacedby, "Linktype")
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
  case variant {
    "usual" -> decode.success(NameuseUsual)
    "official" -> decode.success(NameuseOfficial)
    "temp" -> decode.success(NameuseTemp)
    "nickname" -> decode.success(NameuseNickname)
    "anonymous" -> decode.success(NameuseAnonymous)
    "old" -> decode.success(NameuseOld)
    "maiden" -> decode.success(NameuseMaiden)
    _ -> decode.failure(NameuseUsual, "Nameuse")
  }
}

pub type Narrativestatus {
  NarrativestatusGenerated
  NarrativestatusExtensions
  NarrativestatusAdditional
  NarrativestatusEmpty
}

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
  case variant {
    "generated" -> decode.success(NarrativestatusGenerated)
    "extensions" -> decode.success(NarrativestatusExtensions)
    "additional" -> decode.success(NarrativestatusAdditional)
    "empty" -> decode.success(NarrativestatusEmpty)
    _ -> decode.failure(NarrativestatusGenerated, "Narrativestatus")
  }
}

pub type Ombethnicitycategory {
  Ombethnicitycategory21352
  Ombethnicitycategory21865
  OmbethnicitycategoryAsku
  OmbethnicitycategoryUnk
}

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

pub fn ombethnicitycategory_from_code_and_system(
  code code: String,
  system system: String,
) -> Result(Ombethnicitycategory, Nil) {
  case code, system {
    "2135-2", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombethnicitycategory21352)
    "2186-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombethnicitycategory21865)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(OmbethnicitycategoryAsku)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(OmbethnicitycategoryUnk)
    _, _ -> Error(Nil)
  }
}

pub fn ombethnicitycategory_decoder() -> Decoder(Ombethnicitycategory) {
  use variant <- decode.then(decode.string)
  case variant {
    "2135-2" -> decode.success(Ombethnicitycategory21352)
    "2186-5" -> decode.success(Ombethnicitycategory21865)
    "ASKU" -> decode.success(OmbethnicitycategoryAsku)
    "UNK" -> decode.success(OmbethnicitycategoryUnk)
    _ -> decode.failure(Ombethnicitycategory21352, "Ombethnicitycategory")
  }
}

pub fn ombethnicitycategory_system(
  ombethnicitycategory: Ombethnicitycategory,
) -> String {
  case ombethnicitycategory {
    Ombethnicitycategory21352 -> "urn:oid:2.16.840.1.113883.6.238"
    Ombethnicitycategory21865 -> "urn:oid:2.16.840.1.113883.6.238"
    OmbethnicitycategoryAsku ->
      "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
    OmbethnicitycategoryUnk ->
      "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
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

pub fn ombracecategory_from_code_and_system(
  code code: String,
  system system: String,
) -> Result(Ombracecategory, Nil) {
  case code, system {
    "1002-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombracecategory10025)
    "2028-9", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombracecategory20289)
    "2054-5", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombracecategory20545)
    "2076-8", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombracecategory20768)
    "2106-3", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombracecategory21063)
    "2131-1", "urn:oid:2.16.840.1.113883.6.238" -> Ok(Ombracecategory21311)
    "ASKU", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(OmbracecategoryAsku)
    "UNK", "http://terminology.hl7.org/CodeSystem/v3-NullFlavor" ->
      Ok(OmbracecategoryUnk)
    _, _ -> Error(Nil)
  }
}

pub fn ombracecategory_decoder() -> Decoder(Ombracecategory) {
  use variant <- decode.then(decode.string)
  case variant {
    "1002-5" -> decode.success(Ombracecategory10025)
    "2028-9" -> decode.success(Ombracecategory20289)
    "2054-5" -> decode.success(Ombracecategory20545)
    "2076-8" -> decode.success(Ombracecategory20768)
    "2106-3" -> decode.success(Ombracecategory21063)
    "2131-1" -> decode.success(Ombracecategory21311)
    "ASKU" -> decode.success(OmbracecategoryAsku)
    "UNK" -> decode.success(OmbracecategoryUnk)
    _ -> decode.failure(Ombracecategory10025, "Ombracecategory")
  }
}

pub fn ombracecategory_system(ombracecategory: Ombracecategory) -> String {
  case ombracecategory {
    Ombracecategory10025 -> "urn:oid:2.16.840.1.113883.6.238"
    Ombracecategory20289 -> "urn:oid:2.16.840.1.113883.6.238"
    Ombracecategory20545 -> "urn:oid:2.16.840.1.113883.6.238"
    Ombracecategory20768 -> "urn:oid:2.16.840.1.113883.6.238"
    Ombracecategory21063 -> "urn:oid:2.16.840.1.113883.6.238"
    Ombracecategory21311 -> "urn:oid:2.16.840.1.113883.6.238"
    OmbracecategoryAsku -> "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
    OmbracecategoryUnk -> "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
  }
}

pub type Operationparameteruse {
  OperationparameteruseIn
  OperationparameteruseOut
}

pub fn operationparameteruse_to_json(
  operationparameteruse: Operationparameteruse,
) -> Json {
  json.string(operationparameteruse_to_code(operationparameteruse))
}

pub fn operationparameteruse_to_code(
  operationparameteruse: Operationparameteruse,
) -> String {
  case operationparameteruse {
    OperationparameteruseIn -> "in"
    OperationparameteruseOut -> "out"
  }
}

pub fn operationparameteruse_from_code(
  code: String,
) -> Result(Operationparameteruse, Nil) {
  case code {
    "in" -> Ok(OperationparameteruseIn)
    "out" -> Ok(OperationparameteruseOut)
    _ -> Error(Nil)
  }
}

pub fn operationparameteruse_decoder() -> Decoder(Operationparameteruse) {
  use variant <- decode.then(decode.string)
  case variant {
    "in" -> decode.success(OperationparameteruseIn)
    "out" -> decode.success(OperationparameteruseOut)
    _ -> decode.failure(OperationparameteruseIn, "Operationparameteruse")
  }
}

pub type Quantitycomparator {
  QuantitycomparatorLessthan
  QuantitycomparatorLessthanequal
  QuantitycomparatorGreaterthanequal
  QuantitycomparatorGreaterthan
}

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
  case variant {
    "<" -> decode.success(QuantitycomparatorLessthan)
    "<=" -> decode.success(QuantitycomparatorLessthanequal)
    ">=" -> decode.success(QuantitycomparatorGreaterthanequal)
    ">" -> decode.success(QuantitycomparatorGreaterthan)
    _ -> decode.failure(QuantitycomparatorLessthan, "Quantitycomparator")
  }
}

pub type Reactioneventseverity {
  ReactioneventseverityMild
  ReactioneventseverityModerate
  ReactioneventseveritySevere
}

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
  case variant {
    "mild" -> decode.success(ReactioneventseverityMild)
    "moderate" -> decode.success(ReactioneventseverityModerate)
    "severe" -> decode.success(ReactioneventseveritySevere)
    _ -> decode.failure(ReactioneventseverityMild, "Reactioneventseverity")
  }
}

pub type Relatedartifacttype {
  RelatedartifacttypeDocumentation
  RelatedartifacttypeJustification
  RelatedartifacttypeCitation
  RelatedartifacttypePredecessor
  RelatedartifacttypeSuccessor
  RelatedartifacttypeDerivedfrom
  RelatedartifacttypeDependson
  RelatedartifacttypeComposedof
}

pub fn relatedartifacttype_to_json(
  relatedartifacttype: Relatedartifacttype,
) -> Json {
  json.string(relatedartifacttype_to_code(relatedartifacttype))
}

pub fn relatedartifacttype_to_code(
  relatedartifacttype: Relatedartifacttype,
) -> String {
  case relatedartifacttype {
    RelatedartifacttypeDocumentation -> "documentation"
    RelatedartifacttypeJustification -> "justification"
    RelatedartifacttypeCitation -> "citation"
    RelatedartifacttypePredecessor -> "predecessor"
    RelatedartifacttypeSuccessor -> "successor"
    RelatedartifacttypeDerivedfrom -> "derived-from"
    RelatedartifacttypeDependson -> "depends-on"
    RelatedartifacttypeComposedof -> "composed-of"
  }
}

pub fn relatedartifacttype_from_code(
  code: String,
) -> Result(Relatedartifacttype, Nil) {
  case code {
    "documentation" -> Ok(RelatedartifacttypeDocumentation)
    "justification" -> Ok(RelatedartifacttypeJustification)
    "citation" -> Ok(RelatedartifacttypeCitation)
    "predecessor" -> Ok(RelatedartifacttypePredecessor)
    "successor" -> Ok(RelatedartifacttypeSuccessor)
    "derived-from" -> Ok(RelatedartifacttypeDerivedfrom)
    "depends-on" -> Ok(RelatedartifacttypeDependson)
    "composed-of" -> Ok(RelatedartifacttypeComposedof)
    _ -> Error(Nil)
  }
}

pub fn relatedartifacttype_decoder() -> Decoder(Relatedartifacttype) {
  use variant <- decode.then(decode.string)
  case variant {
    "documentation" -> decode.success(RelatedartifacttypeDocumentation)
    "justification" -> decode.success(RelatedartifacttypeJustification)
    "citation" -> decode.success(RelatedartifacttypeCitation)
    "predecessor" -> decode.success(RelatedartifacttypePredecessor)
    "successor" -> decode.success(RelatedartifacttypeSuccessor)
    "derived-from" -> decode.success(RelatedartifacttypeDerivedfrom)
    "depends-on" -> decode.success(RelatedartifacttypeDependson)
    "composed-of" -> decode.success(RelatedartifacttypeComposedof)
    _ -> decode.failure(RelatedartifacttypeDocumentation, "Relatedartifacttype")
  }
}

pub type Searchentrymode {
  SearchentrymodeMatch
  SearchentrymodeInclude
  SearchentrymodeOutcome
}

pub fn searchentrymode_to_json(searchentrymode: Searchentrymode) -> Json {
  json.string(searchentrymode_to_code(searchentrymode))
}

pub fn searchentrymode_to_code(searchentrymode: Searchentrymode) -> String {
  case searchentrymode {
    SearchentrymodeMatch -> "match"
    SearchentrymodeInclude -> "include"
    SearchentrymodeOutcome -> "outcome"
  }
}

pub fn searchentrymode_from_code(code: String) -> Result(Searchentrymode, Nil) {
  case code {
    "match" -> Ok(SearchentrymodeMatch)
    "include" -> Ok(SearchentrymodeInclude)
    "outcome" -> Ok(SearchentrymodeOutcome)
    _ -> Error(Nil)
  }
}

pub fn searchentrymode_decoder() -> Decoder(Searchentrymode) {
  use variant <- decode.then(decode.string)
  case variant {
    "match" -> decode.success(SearchentrymodeMatch)
    "include" -> decode.success(SearchentrymodeInclude)
    "outcome" -> decode.success(SearchentrymodeOutcome)
    _ -> decode.failure(SearchentrymodeMatch, "Searchentrymode")
  }
}

pub type Sortdirection {
  SortdirectionAscending
  SortdirectionDescending
}

pub fn sortdirection_to_json(sortdirection: Sortdirection) -> Json {
  json.string(sortdirection_to_code(sortdirection))
}

pub fn sortdirection_to_code(sortdirection: Sortdirection) -> String {
  case sortdirection {
    SortdirectionAscending -> "ascending"
    SortdirectionDescending -> "descending"
  }
}

pub fn sortdirection_from_code(code: String) -> Result(Sortdirection, Nil) {
  case code {
    "ascending" -> Ok(SortdirectionAscending)
    "descending" -> Ok(SortdirectionDescending)
    _ -> Error(Nil)
  }
}

pub fn sortdirection_decoder() -> Decoder(Sortdirection) {
  use variant <- decode.then(decode.string)
  case variant {
    "ascending" -> decode.success(SortdirectionAscending)
    "descending" -> decode.success(SortdirectionDescending)
    _ -> decode.failure(SortdirectionAscending, "Sortdirection")
  }
}

pub type Triggertype {
  TriggertypeNamedevent
  TriggertypePeriodic
  TriggertypeDatachanged
  TriggertypeDataadded
  TriggertypeDatamodified
  TriggertypeDataremoved
  TriggertypeDataaccessed
  TriggertypeDataaccessended
}

pub fn triggertype_to_json(triggertype: Triggertype) -> Json {
  json.string(triggertype_to_code(triggertype))
}

pub fn triggertype_to_code(triggertype: Triggertype) -> String {
  case triggertype {
    TriggertypeNamedevent -> "named-event"
    TriggertypePeriodic -> "periodic"
    TriggertypeDatachanged -> "data-changed"
    TriggertypeDataadded -> "data-added"
    TriggertypeDatamodified -> "data-modified"
    TriggertypeDataremoved -> "data-removed"
    TriggertypeDataaccessed -> "data-accessed"
    TriggertypeDataaccessended -> "data-access-ended"
  }
}

pub fn triggertype_from_code(code: String) -> Result(Triggertype, Nil) {
  case code {
    "named-event" -> Ok(TriggertypeNamedevent)
    "periodic" -> Ok(TriggertypePeriodic)
    "data-changed" -> Ok(TriggertypeDatachanged)
    "data-added" -> Ok(TriggertypeDataadded)
    "data-modified" -> Ok(TriggertypeDatamodified)
    "data-removed" -> Ok(TriggertypeDataremoved)
    "data-accessed" -> Ok(TriggertypeDataaccessed)
    "data-access-ended" -> Ok(TriggertypeDataaccessended)
    _ -> Error(Nil)
  }
}

pub fn triggertype_decoder() -> Decoder(Triggertype) {
  use variant <- decode.then(decode.string)
  case variant {
    "named-event" -> decode.success(TriggertypeNamedevent)
    "periodic" -> decode.success(TriggertypePeriodic)
    "data-changed" -> decode.success(TriggertypeDatachanged)
    "data-added" -> decode.success(TriggertypeDataadded)
    "data-modified" -> decode.success(TriggertypeDatamodified)
    "data-removed" -> decode.success(TriggertypeDataremoved)
    "data-accessed" -> decode.success(TriggertypeDataaccessed)
    "data-access-ended" -> decode.success(TriggertypeDataaccessended)
    _ -> decode.failure(TriggertypeNamedevent, "Triggertype")
  }
}

pub type Two16840111376214102124 {
  Two16840111376214102124F
  Two16840111376214102124M
  Two16840111376214102124Askeddeclined
  Two16840111376214102124Asku
  Two16840111376214102124Oth
  Two16840111376214102124Unk
}

pub fn two16840111376214102124_to_json(
  two16840111376214102124: Two16840111376214102124,
) -> Json {
  json.string(two16840111376214102124_to_code(two16840111376214102124))
}

pub fn two16840111376214102124_to_code(
  two16840111376214102124: Two16840111376214102124,
) -> String {
  case two16840111376214102124 {
    Two16840111376214102124F -> "F"
    Two16840111376214102124M -> "M"
    Two16840111376214102124Askeddeclined -> "asked-declined"
    Two16840111376214102124Asku -> "ASKU"
    Two16840111376214102124Oth -> "OTH"
    Two16840111376214102124Unk -> "UNK"
  }
}

pub fn two16840111376214102124_from_code(
  code: String,
) -> Result(Two16840111376214102124, Nil) {
  case code {
    "F" -> Ok(Two16840111376214102124F)
    "M" -> Ok(Two16840111376214102124M)
    "asked-declined" -> Ok(Two16840111376214102124Askeddeclined)
    "ASKU" -> Ok(Two16840111376214102124Asku)
    "OTH" -> Ok(Two16840111376214102124Oth)
    "UNK" -> Ok(Two16840111376214102124Unk)
    _ -> Error(Nil)
  }
}

pub fn two16840111376214102124_decoder() -> Decoder(Two16840111376214102124) {
  use variant <- decode.then(decode.string)
  case variant {
    "F" -> decode.success(Two16840111376214102124F)
    "M" -> decode.success(Two16840111376214102124M)
    "asked-declined" -> decode.success(Two16840111376214102124Askeddeclined)
    "ASKU" -> decode.success(Two16840111376214102124Asku)
    "OTH" -> decode.success(Two16840111376214102124Oth)
    "UNK" -> decode.success(Two16840111376214102124Unk)
    _ -> decode.failure(Two16840111376214102124F, "Two16840111376214102124")
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
  case variant {
    "s" -> decode.success(UnitsoftimeS)
    "min" -> decode.success(UnitsoftimeMin)
    "h" -> decode.success(UnitsoftimeH)
    "d" -> decode.success(UnitsoftimeD)
    "wk" -> decode.success(UnitsoftimeWk)
    "mo" -> decode.success(UnitsoftimeMo)
    "a" -> decode.success(UnitsoftimeA)
    _ -> decode.failure(UnitsoftimeS, "Unitsoftime")
  }
}
