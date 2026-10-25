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

pub type AllTypes {
  AllTypesAddress
  AllTypesAge
  AllTypesAnnotation
  AllTypesAttachment
  AllTypesBackboneelement
  AllTypesCodeableconcept
  AllTypesCoding
  AllTypesContactdetail
  AllTypesContactpoint
  AllTypesContributor
  AllTypesCount
  AllTypesDatarequirement
  AllTypesDistance
  AllTypesDosage
  AllTypesDuration
  AllTypesElement
  AllTypesElementdefinition
  AllTypesExpression
  AllTypesExtension
  AllTypesHumanname
  AllTypesIdentifier
  AllTypesMarketingstatus
  AllTypesMeta
  AllTypesMoney
  AllTypesMoneyquantity
  AllTypesNarrative
  AllTypesParameterdefinition
  AllTypesPeriod
  AllTypesPopulation
  AllTypesProdcharacteristic
  AllTypesProductshelflife
  AllTypesQuantity
  AllTypesRange
  AllTypesRatio
  AllTypesReference
  AllTypesRelatedartifact
  AllTypesSampleddata
  AllTypesSignature
  AllTypesSimplequantity
  AllTypesSubstanceamount
  AllTypesTiming
  AllTypesTriggerdefinition
  AllTypesUsagecontext
  AllTypesBase64binary
  AllTypesBoolean
  AllTypesCanonical
  AllTypesCode
  AllTypesDate
  AllTypesDatetime
  AllTypesDecimal
  AllTypesId
  AllTypesInstant
  AllTypesInteger
  AllTypesMarkdown
  AllTypesOid
  AllTypesPositiveint
  AllTypesString
  AllTypesTime
  AllTypesUnsignedint
  AllTypesUri
  AllTypesUrl
  AllTypesUuid
  AllTypesXhtml
  AllTypesAccount
  AllTypesActivitydefinition
  AllTypesAdverseevent
  AllTypesAllergyintolerance
  AllTypesAppointment
  AllTypesAppointmentresponse
  AllTypesAuditevent
  AllTypesBasic
  AllTypesBinary
  AllTypesBiologicallyderivedproduct
  AllTypesBodystructure
  AllTypesBundle
  AllTypesCapabilitystatement
  AllTypesCareplan
  AllTypesCareteam
  AllTypesCatalogentry
  AllTypesChargeitem
  AllTypesChargeitemdefinition
  AllTypesClaim
  AllTypesClaimresponse
  AllTypesClinicalimpression
  AllTypesCodesystem
  AllTypesCommunication
  AllTypesCommunicationrequest
  AllTypesCompartmentdefinition
  AllTypesComposition
  AllTypesConceptmap
  AllTypesCondition
  AllTypesConsent
  AllTypesContract
  AllTypesCoverage
  AllTypesCoverageeligibilityrequest
  AllTypesCoverageeligibilityresponse
  AllTypesDetectedissue
  AllTypesDevice
  AllTypesDevicedefinition
  AllTypesDevicemetric
  AllTypesDevicerequest
  AllTypesDeviceusestatement
  AllTypesDiagnosticreport
  AllTypesDocumentmanifest
  AllTypesDocumentreference
  AllTypesDomainresource
  AllTypesEffectevidencesynthesis
  AllTypesEncounter
  AllTypesEndpoint
  AllTypesEnrollmentrequest
  AllTypesEnrollmentresponse
  AllTypesEpisodeofcare
  AllTypesEventdefinition
  AllTypesEvidence
  AllTypesEvidencevariable
  AllTypesExamplescenario
  AllTypesExplanationofbenefit
  AllTypesFamilymemberhistory
  AllTypesFlag
  AllTypesGoal
  AllTypesGraphdefinition
  AllTypesGroup
  AllTypesGuidanceresponse
  AllTypesHealthcareservice
  AllTypesImagingstudy
  AllTypesImmunization
  AllTypesImmunizationevaluation
  AllTypesImmunizationrecommendation
  AllTypesImplementationguide
  AllTypesInsuranceplan
  AllTypesInvoice
  AllTypesLibrary
  AllTypesLinkage
  AllTypesList
  AllTypesLocation
  AllTypesMeasure
  AllTypesMeasurereport
  AllTypesMedia
  AllTypesMedication
  AllTypesMedicationadministration
  AllTypesMedicationdispense
  AllTypesMedicationknowledge
  AllTypesMedicationrequest
  AllTypesMedicationstatement
  AllTypesMedicinalproduct
  AllTypesMedicinalproductauthorization
  AllTypesMedicinalproductcontraindication
  AllTypesMedicinalproductindication
  AllTypesMedicinalproductingredient
  AllTypesMedicinalproductinteraction
  AllTypesMedicinalproductmanufactured
  AllTypesMedicinalproductpackaged
  AllTypesMedicinalproductpharmaceutical
  AllTypesMedicinalproductundesirableeffect
  AllTypesMessagedefinition
  AllTypesMessageheader
  AllTypesMolecularsequence
  AllTypesNamingsystem
  AllTypesNutritionorder
  AllTypesObservation
  AllTypesObservationdefinition
  AllTypesOperationdefinition
  AllTypesOperationoutcome
  AllTypesOrganization
  AllTypesOrganizationaffiliation
  AllTypesParameters
  AllTypesPatient
  AllTypesPaymentnotice
  AllTypesPaymentreconciliation
  AllTypesPerson
  AllTypesPlandefinition
  AllTypesPractitioner
  AllTypesPractitionerrole
  AllTypesProcedure
  AllTypesProvenance
  AllTypesQuestionnaire
  AllTypesQuestionnaireresponse
  AllTypesRelatedperson
  AllTypesRequestgroup
  AllTypesResearchdefinition
  AllTypesResearchelementdefinition
  AllTypesResearchstudy
  AllTypesResearchsubject
  AllTypesResource
  AllTypesRiskassessment
  AllTypesRiskevidencesynthesis
  AllTypesSchedule
  AllTypesSearchparameter
  AllTypesServicerequest
  AllTypesSlot
  AllTypesSpecimen
  AllTypesSpecimendefinition
  AllTypesStructuredefinition
  AllTypesStructuremap
  AllTypesSubscription
  AllTypesSubstance
  AllTypesSubstancenucleicacid
  AllTypesSubstancepolymer
  AllTypesSubstanceprotein
  AllTypesSubstancereferenceinformation
  AllTypesSubstancesourcematerial
  AllTypesSubstancespecification
  AllTypesSupplydelivery
  AllTypesSupplyrequest
  AllTypesTask
  AllTypesTerminologycapabilities
  AllTypesTestreport
  AllTypesTestscript
  AllTypesValueset
  AllTypesVerificationresult
  AllTypesVisionprescription
  AllTypesType
  AllTypesAny
}

pub const all_types: List(AllTypes) = [
  AllTypesAddress,
  AllTypesAge,
  AllTypesAnnotation,
  AllTypesAttachment,
  AllTypesBackboneelement,
  AllTypesCodeableconcept,
  AllTypesCoding,
  AllTypesContactdetail,
  AllTypesContactpoint,
  AllTypesContributor,
  AllTypesCount,
  AllTypesDatarequirement,
  AllTypesDistance,
  AllTypesDosage,
  AllTypesDuration,
  AllTypesElement,
  AllTypesElementdefinition,
  AllTypesExpression,
  AllTypesExtension,
  AllTypesHumanname,
  AllTypesIdentifier,
  AllTypesMarketingstatus,
  AllTypesMeta,
  AllTypesMoney,
  AllTypesMoneyquantity,
  AllTypesNarrative,
  AllTypesParameterdefinition,
  AllTypesPeriod,
  AllTypesPopulation,
  AllTypesProdcharacteristic,
  AllTypesProductshelflife,
  AllTypesQuantity,
  AllTypesRange,
  AllTypesRatio,
  AllTypesReference,
  AllTypesRelatedartifact,
  AllTypesSampleddata,
  AllTypesSignature,
  AllTypesSimplequantity,
  AllTypesSubstanceamount,
  AllTypesTiming,
  AllTypesTriggerdefinition,
  AllTypesUsagecontext,
  AllTypesBase64binary,
  AllTypesBoolean,
  AllTypesCanonical,
  AllTypesCode,
  AllTypesDate,
  AllTypesDatetime,
  AllTypesDecimal,
  AllTypesId,
  AllTypesInstant,
  AllTypesInteger,
  AllTypesMarkdown,
  AllTypesOid,
  AllTypesPositiveint,
  AllTypesString,
  AllTypesTime,
  AllTypesUnsignedint,
  AllTypesUri,
  AllTypesUrl,
  AllTypesUuid,
  AllTypesXhtml,
  AllTypesAccount,
  AllTypesActivitydefinition,
  AllTypesAdverseevent,
  AllTypesAllergyintolerance,
  AllTypesAppointment,
  AllTypesAppointmentresponse,
  AllTypesAuditevent,
  AllTypesBasic,
  AllTypesBinary,
  AllTypesBiologicallyderivedproduct,
  AllTypesBodystructure,
  AllTypesBundle,
  AllTypesCapabilitystatement,
  AllTypesCareplan,
  AllTypesCareteam,
  AllTypesCatalogentry,
  AllTypesChargeitem,
  AllTypesChargeitemdefinition,
  AllTypesClaim,
  AllTypesClaimresponse,
  AllTypesClinicalimpression,
  AllTypesCodesystem,
  AllTypesCommunication,
  AllTypesCommunicationrequest,
  AllTypesCompartmentdefinition,
  AllTypesComposition,
  AllTypesConceptmap,
  AllTypesCondition,
  AllTypesConsent,
  AllTypesContract,
  AllTypesCoverage,
  AllTypesCoverageeligibilityrequest,
  AllTypesCoverageeligibilityresponse,
  AllTypesDetectedissue,
  AllTypesDevice,
  AllTypesDevicedefinition,
  AllTypesDevicemetric,
  AllTypesDevicerequest,
  AllTypesDeviceusestatement,
  AllTypesDiagnosticreport,
  AllTypesDocumentmanifest,
  AllTypesDocumentreference,
  AllTypesDomainresource,
  AllTypesEffectevidencesynthesis,
  AllTypesEncounter,
  AllTypesEndpoint,
  AllTypesEnrollmentrequest,
  AllTypesEnrollmentresponse,
  AllTypesEpisodeofcare,
  AllTypesEventdefinition,
  AllTypesEvidence,
  AllTypesEvidencevariable,
  AllTypesExamplescenario,
  AllTypesExplanationofbenefit,
  AllTypesFamilymemberhistory,
  AllTypesFlag,
  AllTypesGoal,
  AllTypesGraphdefinition,
  AllTypesGroup,
  AllTypesGuidanceresponse,
  AllTypesHealthcareservice,
  AllTypesImagingstudy,
  AllTypesImmunization,
  AllTypesImmunizationevaluation,
  AllTypesImmunizationrecommendation,
  AllTypesImplementationguide,
  AllTypesInsuranceplan,
  AllTypesInvoice,
  AllTypesLibrary,
  AllTypesLinkage,
  AllTypesList,
  AllTypesLocation,
  AllTypesMeasure,
  AllTypesMeasurereport,
  AllTypesMedia,
  AllTypesMedication,
  AllTypesMedicationadministration,
  AllTypesMedicationdispense,
  AllTypesMedicationknowledge,
  AllTypesMedicationrequest,
  AllTypesMedicationstatement,
  AllTypesMedicinalproduct,
  AllTypesMedicinalproductauthorization,
  AllTypesMedicinalproductcontraindication,
  AllTypesMedicinalproductindication,
  AllTypesMedicinalproductingredient,
  AllTypesMedicinalproductinteraction,
  AllTypesMedicinalproductmanufactured,
  AllTypesMedicinalproductpackaged,
  AllTypesMedicinalproductpharmaceutical,
  AllTypesMedicinalproductundesirableeffect,
  AllTypesMessagedefinition,
  AllTypesMessageheader,
  AllTypesMolecularsequence,
  AllTypesNamingsystem,
  AllTypesNutritionorder,
  AllTypesObservation,
  AllTypesObservationdefinition,
  AllTypesOperationdefinition,
  AllTypesOperationoutcome,
  AllTypesOrganization,
  AllTypesOrganizationaffiliation,
  AllTypesParameters,
  AllTypesPatient,
  AllTypesPaymentnotice,
  AllTypesPaymentreconciliation,
  AllTypesPerson,
  AllTypesPlandefinition,
  AllTypesPractitioner,
  AllTypesPractitionerrole,
  AllTypesProcedure,
  AllTypesProvenance,
  AllTypesQuestionnaire,
  AllTypesQuestionnaireresponse,
  AllTypesRelatedperson,
  AllTypesRequestgroup,
  AllTypesResearchdefinition,
  AllTypesResearchelementdefinition,
  AllTypesResearchstudy,
  AllTypesResearchsubject,
  AllTypesResource,
  AllTypesRiskassessment,
  AllTypesRiskevidencesynthesis,
  AllTypesSchedule,
  AllTypesSearchparameter,
  AllTypesServicerequest,
  AllTypesSlot,
  AllTypesSpecimen,
  AllTypesSpecimendefinition,
  AllTypesStructuredefinition,
  AllTypesStructuremap,
  AllTypesSubscription,
  AllTypesSubstance,
  AllTypesSubstancenucleicacid,
  AllTypesSubstancepolymer,
  AllTypesSubstanceprotein,
  AllTypesSubstancereferenceinformation,
  AllTypesSubstancesourcematerial,
  AllTypesSubstancespecification,
  AllTypesSupplydelivery,
  AllTypesSupplyrequest,
  AllTypesTask,
  AllTypesTerminologycapabilities,
  AllTypesTestreport,
  AllTypesTestscript,
  AllTypesValueset,
  AllTypesVerificationresult,
  AllTypesVisionprescription,
  AllTypesType,
  AllTypesAny,
]

pub fn all_types_to_json(all_types: AllTypes) -> Json {
  json.string(all_types_to_code(all_types))
}

pub fn all_types_to_code(all_types: AllTypes) -> String {
  case all_types {
    AllTypesAddress -> "Address"
    AllTypesAge -> "Age"
    AllTypesAnnotation -> "Annotation"
    AllTypesAttachment -> "Attachment"
    AllTypesBackboneelement -> "BackboneElement"
    AllTypesCodeableconcept -> "CodeableConcept"
    AllTypesCoding -> "Coding"
    AllTypesContactdetail -> "ContactDetail"
    AllTypesContactpoint -> "ContactPoint"
    AllTypesContributor -> "Contributor"
    AllTypesCount -> "Count"
    AllTypesDatarequirement -> "DataRequirement"
    AllTypesDistance -> "Distance"
    AllTypesDosage -> "Dosage"
    AllTypesDuration -> "Duration"
    AllTypesElement -> "Element"
    AllTypesElementdefinition -> "ElementDefinition"
    AllTypesExpression -> "Expression"
    AllTypesExtension -> "Extension"
    AllTypesHumanname -> "HumanName"
    AllTypesIdentifier -> "Identifier"
    AllTypesMarketingstatus -> "MarketingStatus"
    AllTypesMeta -> "Meta"
    AllTypesMoney -> "Money"
    AllTypesMoneyquantity -> "MoneyQuantity"
    AllTypesNarrative -> "Narrative"
    AllTypesParameterdefinition -> "ParameterDefinition"
    AllTypesPeriod -> "Period"
    AllTypesPopulation -> "Population"
    AllTypesProdcharacteristic -> "ProdCharacteristic"
    AllTypesProductshelflife -> "ProductShelfLife"
    AllTypesQuantity -> "Quantity"
    AllTypesRange -> "Range"
    AllTypesRatio -> "Ratio"
    AllTypesReference -> "Reference"
    AllTypesRelatedartifact -> "RelatedArtifact"
    AllTypesSampleddata -> "SampledData"
    AllTypesSignature -> "Signature"
    AllTypesSimplequantity -> "SimpleQuantity"
    AllTypesSubstanceamount -> "SubstanceAmount"
    AllTypesTiming -> "Timing"
    AllTypesTriggerdefinition -> "TriggerDefinition"
    AllTypesUsagecontext -> "UsageContext"
    AllTypesBase64binary -> "base64Binary"
    AllTypesBoolean -> "boolean"
    AllTypesCanonical -> "canonical"
    AllTypesCode -> "code"
    AllTypesDate -> "date"
    AllTypesDatetime -> "dateTime"
    AllTypesDecimal -> "decimal"
    AllTypesId -> "id"
    AllTypesInstant -> "instant"
    AllTypesInteger -> "integer"
    AllTypesMarkdown -> "markdown"
    AllTypesOid -> "oid"
    AllTypesPositiveint -> "positiveInt"
    AllTypesString -> "string"
    AllTypesTime -> "time"
    AllTypesUnsignedint -> "unsignedInt"
    AllTypesUri -> "uri"
    AllTypesUrl -> "url"
    AllTypesUuid -> "uuid"
    AllTypesXhtml -> "xhtml"
    AllTypesAccount -> "Account"
    AllTypesActivitydefinition -> "ActivityDefinition"
    AllTypesAdverseevent -> "AdverseEvent"
    AllTypesAllergyintolerance -> "AllergyIntolerance"
    AllTypesAppointment -> "Appointment"
    AllTypesAppointmentresponse -> "AppointmentResponse"
    AllTypesAuditevent -> "AuditEvent"
    AllTypesBasic -> "Basic"
    AllTypesBinary -> "Binary"
    AllTypesBiologicallyderivedproduct -> "BiologicallyDerivedProduct"
    AllTypesBodystructure -> "BodyStructure"
    AllTypesBundle -> "Bundle"
    AllTypesCapabilitystatement -> "CapabilityStatement"
    AllTypesCareplan -> "CarePlan"
    AllTypesCareteam -> "CareTeam"
    AllTypesCatalogentry -> "CatalogEntry"
    AllTypesChargeitem -> "ChargeItem"
    AllTypesChargeitemdefinition -> "ChargeItemDefinition"
    AllTypesClaim -> "Claim"
    AllTypesClaimresponse -> "ClaimResponse"
    AllTypesClinicalimpression -> "ClinicalImpression"
    AllTypesCodesystem -> "CodeSystem"
    AllTypesCommunication -> "Communication"
    AllTypesCommunicationrequest -> "CommunicationRequest"
    AllTypesCompartmentdefinition -> "CompartmentDefinition"
    AllTypesComposition -> "Composition"
    AllTypesConceptmap -> "ConceptMap"
    AllTypesCondition -> "Condition"
    AllTypesConsent -> "Consent"
    AllTypesContract -> "Contract"
    AllTypesCoverage -> "Coverage"
    AllTypesCoverageeligibilityrequest -> "CoverageEligibilityRequest"
    AllTypesCoverageeligibilityresponse -> "CoverageEligibilityResponse"
    AllTypesDetectedissue -> "DetectedIssue"
    AllTypesDevice -> "Device"
    AllTypesDevicedefinition -> "DeviceDefinition"
    AllTypesDevicemetric -> "DeviceMetric"
    AllTypesDevicerequest -> "DeviceRequest"
    AllTypesDeviceusestatement -> "DeviceUseStatement"
    AllTypesDiagnosticreport -> "DiagnosticReport"
    AllTypesDocumentmanifest -> "DocumentManifest"
    AllTypesDocumentreference -> "DocumentReference"
    AllTypesDomainresource -> "DomainResource"
    AllTypesEffectevidencesynthesis -> "EffectEvidenceSynthesis"
    AllTypesEncounter -> "Encounter"
    AllTypesEndpoint -> "Endpoint"
    AllTypesEnrollmentrequest -> "EnrollmentRequest"
    AllTypesEnrollmentresponse -> "EnrollmentResponse"
    AllTypesEpisodeofcare -> "EpisodeOfCare"
    AllTypesEventdefinition -> "EventDefinition"
    AllTypesEvidence -> "Evidence"
    AllTypesEvidencevariable -> "EvidenceVariable"
    AllTypesExamplescenario -> "ExampleScenario"
    AllTypesExplanationofbenefit -> "ExplanationOfBenefit"
    AllTypesFamilymemberhistory -> "FamilyMemberHistory"
    AllTypesFlag -> "Flag"
    AllTypesGoal -> "Goal"
    AllTypesGraphdefinition -> "GraphDefinition"
    AllTypesGroup -> "Group"
    AllTypesGuidanceresponse -> "GuidanceResponse"
    AllTypesHealthcareservice -> "HealthcareService"
    AllTypesImagingstudy -> "ImagingStudy"
    AllTypesImmunization -> "Immunization"
    AllTypesImmunizationevaluation -> "ImmunizationEvaluation"
    AllTypesImmunizationrecommendation -> "ImmunizationRecommendation"
    AllTypesImplementationguide -> "ImplementationGuide"
    AllTypesInsuranceplan -> "InsurancePlan"
    AllTypesInvoice -> "Invoice"
    AllTypesLibrary -> "Library"
    AllTypesLinkage -> "Linkage"
    AllTypesList -> "List"
    AllTypesLocation -> "Location"
    AllTypesMeasure -> "Measure"
    AllTypesMeasurereport -> "MeasureReport"
    AllTypesMedia -> "Media"
    AllTypesMedication -> "Medication"
    AllTypesMedicationadministration -> "MedicationAdministration"
    AllTypesMedicationdispense -> "MedicationDispense"
    AllTypesMedicationknowledge -> "MedicationKnowledge"
    AllTypesMedicationrequest -> "MedicationRequest"
    AllTypesMedicationstatement -> "MedicationStatement"
    AllTypesMedicinalproduct -> "MedicinalProduct"
    AllTypesMedicinalproductauthorization -> "MedicinalProductAuthorization"
    AllTypesMedicinalproductcontraindication ->
      "MedicinalProductContraindication"
    AllTypesMedicinalproductindication -> "MedicinalProductIndication"
    AllTypesMedicinalproductingredient -> "MedicinalProductIngredient"
    AllTypesMedicinalproductinteraction -> "MedicinalProductInteraction"
    AllTypesMedicinalproductmanufactured -> "MedicinalProductManufactured"
    AllTypesMedicinalproductpackaged -> "MedicinalProductPackaged"
    AllTypesMedicinalproductpharmaceutical -> "MedicinalProductPharmaceutical"
    AllTypesMedicinalproductundesirableeffect ->
      "MedicinalProductUndesirableEffect"
    AllTypesMessagedefinition -> "MessageDefinition"
    AllTypesMessageheader -> "MessageHeader"
    AllTypesMolecularsequence -> "MolecularSequence"
    AllTypesNamingsystem -> "NamingSystem"
    AllTypesNutritionorder -> "NutritionOrder"
    AllTypesObservation -> "Observation"
    AllTypesObservationdefinition -> "ObservationDefinition"
    AllTypesOperationdefinition -> "OperationDefinition"
    AllTypesOperationoutcome -> "OperationOutcome"
    AllTypesOrganization -> "Organization"
    AllTypesOrganizationaffiliation -> "OrganizationAffiliation"
    AllTypesParameters -> "Parameters"
    AllTypesPatient -> "Patient"
    AllTypesPaymentnotice -> "PaymentNotice"
    AllTypesPaymentreconciliation -> "PaymentReconciliation"
    AllTypesPerson -> "Person"
    AllTypesPlandefinition -> "PlanDefinition"
    AllTypesPractitioner -> "Practitioner"
    AllTypesPractitionerrole -> "PractitionerRole"
    AllTypesProcedure -> "Procedure"
    AllTypesProvenance -> "Provenance"
    AllTypesQuestionnaire -> "Questionnaire"
    AllTypesQuestionnaireresponse -> "QuestionnaireResponse"
    AllTypesRelatedperson -> "RelatedPerson"
    AllTypesRequestgroup -> "RequestGroup"
    AllTypesResearchdefinition -> "ResearchDefinition"
    AllTypesResearchelementdefinition -> "ResearchElementDefinition"
    AllTypesResearchstudy -> "ResearchStudy"
    AllTypesResearchsubject -> "ResearchSubject"
    AllTypesResource -> "Resource"
    AllTypesRiskassessment -> "RiskAssessment"
    AllTypesRiskevidencesynthesis -> "RiskEvidenceSynthesis"
    AllTypesSchedule -> "Schedule"
    AllTypesSearchparameter -> "SearchParameter"
    AllTypesServicerequest -> "ServiceRequest"
    AllTypesSlot -> "Slot"
    AllTypesSpecimen -> "Specimen"
    AllTypesSpecimendefinition -> "SpecimenDefinition"
    AllTypesStructuredefinition -> "StructureDefinition"
    AllTypesStructuremap -> "StructureMap"
    AllTypesSubscription -> "Subscription"
    AllTypesSubstance -> "Substance"
    AllTypesSubstancenucleicacid -> "SubstanceNucleicAcid"
    AllTypesSubstancepolymer -> "SubstancePolymer"
    AllTypesSubstanceprotein -> "SubstanceProtein"
    AllTypesSubstancereferenceinformation -> "SubstanceReferenceInformation"
    AllTypesSubstancesourcematerial -> "SubstanceSourceMaterial"
    AllTypesSubstancespecification -> "SubstanceSpecification"
    AllTypesSupplydelivery -> "SupplyDelivery"
    AllTypesSupplyrequest -> "SupplyRequest"
    AllTypesTask -> "Task"
    AllTypesTerminologycapabilities -> "TerminologyCapabilities"
    AllTypesTestreport -> "TestReport"
    AllTypesTestscript -> "TestScript"
    AllTypesValueset -> "ValueSet"
    AllTypesVerificationresult -> "VerificationResult"
    AllTypesVisionprescription -> "VisionPrescription"
    AllTypesType -> "Type"
    AllTypesAny -> "Any"
  }
}

pub fn all_types_parse_code(code: String) -> Result(AllTypes, Nil) {
  case code {
    "Address" -> Ok(AllTypesAddress)
    "Age" -> Ok(AllTypesAge)
    "Annotation" -> Ok(AllTypesAnnotation)
    "Attachment" -> Ok(AllTypesAttachment)
    "BackboneElement" -> Ok(AllTypesBackboneelement)
    "CodeableConcept" -> Ok(AllTypesCodeableconcept)
    "Coding" -> Ok(AllTypesCoding)
    "ContactDetail" -> Ok(AllTypesContactdetail)
    "ContactPoint" -> Ok(AllTypesContactpoint)
    "Contributor" -> Ok(AllTypesContributor)
    "Count" -> Ok(AllTypesCount)
    "DataRequirement" -> Ok(AllTypesDatarequirement)
    "Distance" -> Ok(AllTypesDistance)
    "Dosage" -> Ok(AllTypesDosage)
    "Duration" -> Ok(AllTypesDuration)
    "Element" -> Ok(AllTypesElement)
    "ElementDefinition" -> Ok(AllTypesElementdefinition)
    "Expression" -> Ok(AllTypesExpression)
    "Extension" -> Ok(AllTypesExtension)
    "HumanName" -> Ok(AllTypesHumanname)
    "Identifier" -> Ok(AllTypesIdentifier)
    "MarketingStatus" -> Ok(AllTypesMarketingstatus)
    "Meta" -> Ok(AllTypesMeta)
    "Money" -> Ok(AllTypesMoney)
    "MoneyQuantity" -> Ok(AllTypesMoneyquantity)
    "Narrative" -> Ok(AllTypesNarrative)
    "ParameterDefinition" -> Ok(AllTypesParameterdefinition)
    "Period" -> Ok(AllTypesPeriod)
    "Population" -> Ok(AllTypesPopulation)
    "ProdCharacteristic" -> Ok(AllTypesProdcharacteristic)
    "ProductShelfLife" -> Ok(AllTypesProductshelflife)
    "Quantity" -> Ok(AllTypesQuantity)
    "Range" -> Ok(AllTypesRange)
    "Ratio" -> Ok(AllTypesRatio)
    "Reference" -> Ok(AllTypesReference)
    "RelatedArtifact" -> Ok(AllTypesRelatedartifact)
    "SampledData" -> Ok(AllTypesSampleddata)
    "Signature" -> Ok(AllTypesSignature)
    "SimpleQuantity" -> Ok(AllTypesSimplequantity)
    "SubstanceAmount" -> Ok(AllTypesSubstanceamount)
    "Timing" -> Ok(AllTypesTiming)
    "TriggerDefinition" -> Ok(AllTypesTriggerdefinition)
    "UsageContext" -> Ok(AllTypesUsagecontext)
    "base64Binary" -> Ok(AllTypesBase64binary)
    "boolean" -> Ok(AllTypesBoolean)
    "canonical" -> Ok(AllTypesCanonical)
    "code" -> Ok(AllTypesCode)
    "date" -> Ok(AllTypesDate)
    "dateTime" -> Ok(AllTypesDatetime)
    "decimal" -> Ok(AllTypesDecimal)
    "id" -> Ok(AllTypesId)
    "instant" -> Ok(AllTypesInstant)
    "integer" -> Ok(AllTypesInteger)
    "markdown" -> Ok(AllTypesMarkdown)
    "oid" -> Ok(AllTypesOid)
    "positiveInt" -> Ok(AllTypesPositiveint)
    "string" -> Ok(AllTypesString)
    "time" -> Ok(AllTypesTime)
    "unsignedInt" -> Ok(AllTypesUnsignedint)
    "uri" -> Ok(AllTypesUri)
    "url" -> Ok(AllTypesUrl)
    "uuid" -> Ok(AllTypesUuid)
    "xhtml" -> Ok(AllTypesXhtml)
    "Account" -> Ok(AllTypesAccount)
    "ActivityDefinition" -> Ok(AllTypesActivitydefinition)
    "AdverseEvent" -> Ok(AllTypesAdverseevent)
    "AllergyIntolerance" -> Ok(AllTypesAllergyintolerance)
    "Appointment" -> Ok(AllTypesAppointment)
    "AppointmentResponse" -> Ok(AllTypesAppointmentresponse)
    "AuditEvent" -> Ok(AllTypesAuditevent)
    "Basic" -> Ok(AllTypesBasic)
    "Binary" -> Ok(AllTypesBinary)
    "BiologicallyDerivedProduct" -> Ok(AllTypesBiologicallyderivedproduct)
    "BodyStructure" -> Ok(AllTypesBodystructure)
    "Bundle" -> Ok(AllTypesBundle)
    "CapabilityStatement" -> Ok(AllTypesCapabilitystatement)
    "CarePlan" -> Ok(AllTypesCareplan)
    "CareTeam" -> Ok(AllTypesCareteam)
    "CatalogEntry" -> Ok(AllTypesCatalogentry)
    "ChargeItem" -> Ok(AllTypesChargeitem)
    "ChargeItemDefinition" -> Ok(AllTypesChargeitemdefinition)
    "Claim" -> Ok(AllTypesClaim)
    "ClaimResponse" -> Ok(AllTypesClaimresponse)
    "ClinicalImpression" -> Ok(AllTypesClinicalimpression)
    "CodeSystem" -> Ok(AllTypesCodesystem)
    "Communication" -> Ok(AllTypesCommunication)
    "CommunicationRequest" -> Ok(AllTypesCommunicationrequest)
    "CompartmentDefinition" -> Ok(AllTypesCompartmentdefinition)
    "Composition" -> Ok(AllTypesComposition)
    "ConceptMap" -> Ok(AllTypesConceptmap)
    "Condition" -> Ok(AllTypesCondition)
    "Consent" -> Ok(AllTypesConsent)
    "Contract" -> Ok(AllTypesContract)
    "Coverage" -> Ok(AllTypesCoverage)
    "CoverageEligibilityRequest" -> Ok(AllTypesCoverageeligibilityrequest)
    "CoverageEligibilityResponse" -> Ok(AllTypesCoverageeligibilityresponse)
    "DetectedIssue" -> Ok(AllTypesDetectedissue)
    "Device" -> Ok(AllTypesDevice)
    "DeviceDefinition" -> Ok(AllTypesDevicedefinition)
    "DeviceMetric" -> Ok(AllTypesDevicemetric)
    "DeviceRequest" -> Ok(AllTypesDevicerequest)
    "DeviceUseStatement" -> Ok(AllTypesDeviceusestatement)
    "DiagnosticReport" -> Ok(AllTypesDiagnosticreport)
    "DocumentManifest" -> Ok(AllTypesDocumentmanifest)
    "DocumentReference" -> Ok(AllTypesDocumentreference)
    "DomainResource" -> Ok(AllTypesDomainresource)
    "EffectEvidenceSynthesis" -> Ok(AllTypesEffectevidencesynthesis)
    "Encounter" -> Ok(AllTypesEncounter)
    "Endpoint" -> Ok(AllTypesEndpoint)
    "EnrollmentRequest" -> Ok(AllTypesEnrollmentrequest)
    "EnrollmentResponse" -> Ok(AllTypesEnrollmentresponse)
    "EpisodeOfCare" -> Ok(AllTypesEpisodeofcare)
    "EventDefinition" -> Ok(AllTypesEventdefinition)
    "Evidence" -> Ok(AllTypesEvidence)
    "EvidenceVariable" -> Ok(AllTypesEvidencevariable)
    "ExampleScenario" -> Ok(AllTypesExamplescenario)
    "ExplanationOfBenefit" -> Ok(AllTypesExplanationofbenefit)
    "FamilyMemberHistory" -> Ok(AllTypesFamilymemberhistory)
    "Flag" -> Ok(AllTypesFlag)
    "Goal" -> Ok(AllTypesGoal)
    "GraphDefinition" -> Ok(AllTypesGraphdefinition)
    "Group" -> Ok(AllTypesGroup)
    "GuidanceResponse" -> Ok(AllTypesGuidanceresponse)
    "HealthcareService" -> Ok(AllTypesHealthcareservice)
    "ImagingStudy" -> Ok(AllTypesImagingstudy)
    "Immunization" -> Ok(AllTypesImmunization)
    "ImmunizationEvaluation" -> Ok(AllTypesImmunizationevaluation)
    "ImmunizationRecommendation" -> Ok(AllTypesImmunizationrecommendation)
    "ImplementationGuide" -> Ok(AllTypesImplementationguide)
    "InsurancePlan" -> Ok(AllTypesInsuranceplan)
    "Invoice" -> Ok(AllTypesInvoice)
    "Library" -> Ok(AllTypesLibrary)
    "Linkage" -> Ok(AllTypesLinkage)
    "List" -> Ok(AllTypesList)
    "Location" -> Ok(AllTypesLocation)
    "Measure" -> Ok(AllTypesMeasure)
    "MeasureReport" -> Ok(AllTypesMeasurereport)
    "Media" -> Ok(AllTypesMedia)
    "Medication" -> Ok(AllTypesMedication)
    "MedicationAdministration" -> Ok(AllTypesMedicationadministration)
    "MedicationDispense" -> Ok(AllTypesMedicationdispense)
    "MedicationKnowledge" -> Ok(AllTypesMedicationknowledge)
    "MedicationRequest" -> Ok(AllTypesMedicationrequest)
    "MedicationStatement" -> Ok(AllTypesMedicationstatement)
    "MedicinalProduct" -> Ok(AllTypesMedicinalproduct)
    "MedicinalProductAuthorization" -> Ok(AllTypesMedicinalproductauthorization)
    "MedicinalProductContraindication" ->
      Ok(AllTypesMedicinalproductcontraindication)
    "MedicinalProductIndication" -> Ok(AllTypesMedicinalproductindication)
    "MedicinalProductIngredient" -> Ok(AllTypesMedicinalproductingredient)
    "MedicinalProductInteraction" -> Ok(AllTypesMedicinalproductinteraction)
    "MedicinalProductManufactured" -> Ok(AllTypesMedicinalproductmanufactured)
    "MedicinalProductPackaged" -> Ok(AllTypesMedicinalproductpackaged)
    "MedicinalProductPharmaceutical" ->
      Ok(AllTypesMedicinalproductpharmaceutical)
    "MedicinalProductUndesirableEffect" ->
      Ok(AllTypesMedicinalproductundesirableeffect)
    "MessageDefinition" -> Ok(AllTypesMessagedefinition)
    "MessageHeader" -> Ok(AllTypesMessageheader)
    "MolecularSequence" -> Ok(AllTypesMolecularsequence)
    "NamingSystem" -> Ok(AllTypesNamingsystem)
    "NutritionOrder" -> Ok(AllTypesNutritionorder)
    "Observation" -> Ok(AllTypesObservation)
    "ObservationDefinition" -> Ok(AllTypesObservationdefinition)
    "OperationDefinition" -> Ok(AllTypesOperationdefinition)
    "OperationOutcome" -> Ok(AllTypesOperationoutcome)
    "Organization" -> Ok(AllTypesOrganization)
    "OrganizationAffiliation" -> Ok(AllTypesOrganizationaffiliation)
    "Parameters" -> Ok(AllTypesParameters)
    "Patient" -> Ok(AllTypesPatient)
    "PaymentNotice" -> Ok(AllTypesPaymentnotice)
    "PaymentReconciliation" -> Ok(AllTypesPaymentreconciliation)
    "Person" -> Ok(AllTypesPerson)
    "PlanDefinition" -> Ok(AllTypesPlandefinition)
    "Practitioner" -> Ok(AllTypesPractitioner)
    "PractitionerRole" -> Ok(AllTypesPractitionerrole)
    "Procedure" -> Ok(AllTypesProcedure)
    "Provenance" -> Ok(AllTypesProvenance)
    "Questionnaire" -> Ok(AllTypesQuestionnaire)
    "QuestionnaireResponse" -> Ok(AllTypesQuestionnaireresponse)
    "RelatedPerson" -> Ok(AllTypesRelatedperson)
    "RequestGroup" -> Ok(AllTypesRequestgroup)
    "ResearchDefinition" -> Ok(AllTypesResearchdefinition)
    "ResearchElementDefinition" -> Ok(AllTypesResearchelementdefinition)
    "ResearchStudy" -> Ok(AllTypesResearchstudy)
    "ResearchSubject" -> Ok(AllTypesResearchsubject)
    "Resource" -> Ok(AllTypesResource)
    "RiskAssessment" -> Ok(AllTypesRiskassessment)
    "RiskEvidenceSynthesis" -> Ok(AllTypesRiskevidencesynthesis)
    "Schedule" -> Ok(AllTypesSchedule)
    "SearchParameter" -> Ok(AllTypesSearchparameter)
    "ServiceRequest" -> Ok(AllTypesServicerequest)
    "Slot" -> Ok(AllTypesSlot)
    "Specimen" -> Ok(AllTypesSpecimen)
    "SpecimenDefinition" -> Ok(AllTypesSpecimendefinition)
    "StructureDefinition" -> Ok(AllTypesStructuredefinition)
    "StructureMap" -> Ok(AllTypesStructuremap)
    "Subscription" -> Ok(AllTypesSubscription)
    "Substance" -> Ok(AllTypesSubstance)
    "SubstanceNucleicAcid" -> Ok(AllTypesSubstancenucleicacid)
    "SubstancePolymer" -> Ok(AllTypesSubstancepolymer)
    "SubstanceProtein" -> Ok(AllTypesSubstanceprotein)
    "SubstanceReferenceInformation" -> Ok(AllTypesSubstancereferenceinformation)
    "SubstanceSourceMaterial" -> Ok(AllTypesSubstancesourcematerial)
    "SubstanceSpecification" -> Ok(AllTypesSubstancespecification)
    "SupplyDelivery" -> Ok(AllTypesSupplydelivery)
    "SupplyRequest" -> Ok(AllTypesSupplyrequest)
    "Task" -> Ok(AllTypesTask)
    "TerminologyCapabilities" -> Ok(AllTypesTerminologycapabilities)
    "TestReport" -> Ok(AllTypesTestreport)
    "TestScript" -> Ok(AllTypesTestscript)
    "ValueSet" -> Ok(AllTypesValueset)
    "VerificationResult" -> Ok(AllTypesVerificationresult)
    "VisionPrescription" -> Ok(AllTypesVisionprescription)
    "Type" -> Ok(AllTypesType)
    "Any" -> Ok(AllTypesAny)
    _ -> Error(Nil)
  }
}

pub fn all_types_decoder() -> Decoder(AllTypes) {
  use variant <- decode.then(decode.string)
  case all_types_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AllTypesAddress,
        "AllTypes",
        all_types,
        all_types_to_code,
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

pub type ContributorType {
  ContributorTypeAuthor
  ContributorTypeEditor
  ContributorTypeReviewer
  ContributorTypeEndorser
}

pub const contributor_type: List(ContributorType) = [
  ContributorTypeAuthor,
  ContributorTypeEditor,
  ContributorTypeReviewer,
  ContributorTypeEndorser,
]

pub fn contributor_type_to_json(contributor_type: ContributorType) -> Json {
  json.string(contributor_type_to_code(contributor_type))
}

pub fn contributor_type_to_code(contributor_type: ContributorType) -> String {
  case contributor_type {
    ContributorTypeAuthor -> "author"
    ContributorTypeEditor -> "editor"
    ContributorTypeReviewer -> "reviewer"
    ContributorTypeEndorser -> "endorser"
  }
}

pub fn contributor_type_parse_code(
  code: String,
) -> Result(ContributorType, Nil) {
  case code {
    "author" -> Ok(ContributorTypeAuthor)
    "editor" -> Ok(ContributorTypeEditor)
    "reviewer" -> Ok(ContributorTypeReviewer)
    "endorser" -> Ok(ContributorTypeEndorser)
    _ -> Error(Nil)
  }
}

pub fn contributor_type_decoder() -> Decoder(ContributorType) {
  use variant <- decode.then(decode.string)
  case contributor_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ContributorTypeAuthor,
        "ContributorType",
        contributor_type,
        contributor_type_to_code,
      )
  }
}

pub type Currencies {
  CurrenciesAed
  CurrenciesAfn
  CurrenciesAll
  CurrenciesAmd
  CurrenciesAng
  CurrenciesAoa
  CurrenciesArs
  CurrenciesAud
  CurrenciesAwg
  CurrenciesAzn
  CurrenciesBam
  CurrenciesBbd
  CurrenciesBdt
  CurrenciesBgn
  CurrenciesBhd
  CurrenciesBif
  CurrenciesBmd
  CurrenciesBnd
  CurrenciesBob
  CurrenciesBov
  CurrenciesBrl
  CurrenciesBsd
  CurrenciesBtn
  CurrenciesBwp
  CurrenciesByn
  CurrenciesBzd
  CurrenciesCad
  CurrenciesCdf
  CurrenciesChe
  CurrenciesChf
  CurrenciesChw
  CurrenciesClf
  CurrenciesClp
  CurrenciesCny
  CurrenciesCop
  CurrenciesCou
  CurrenciesCrc
  CurrenciesCuc
  CurrenciesCup
  CurrenciesCve
  CurrenciesCzk
  CurrenciesDjf
  CurrenciesDkk
  CurrenciesDop
  CurrenciesDzd
  CurrenciesEgp
  CurrenciesErn
  CurrenciesEtb
  CurrenciesEur
  CurrenciesFjd
  CurrenciesFkp
  CurrenciesGbp
  CurrenciesGel
  CurrenciesGgp
  CurrenciesGhs
  CurrenciesGip
  CurrenciesGmd
  CurrenciesGnf
  CurrenciesGtq
  CurrenciesGyd
  CurrenciesHkd
  CurrenciesHnl
  CurrenciesHrk
  CurrenciesHtg
  CurrenciesHuf
  CurrenciesIdr
  CurrenciesIls
  CurrenciesImp
  CurrenciesInr
  CurrenciesIqd
  CurrenciesIrr
  CurrenciesIsk
  CurrenciesJep
  CurrenciesJmd
  CurrenciesJod
  CurrenciesJpy
  CurrenciesKes
  CurrenciesKgs
  CurrenciesKhr
  CurrenciesKmf
  CurrenciesKpw
  CurrenciesKrw
  CurrenciesKwd
  CurrenciesKyd
  CurrenciesKzt
  CurrenciesLak
  CurrenciesLbp
  CurrenciesLkr
  CurrenciesLrd
  CurrenciesLsl
  CurrenciesLyd
  CurrenciesMad
  CurrenciesMdl
  CurrenciesMga
  CurrenciesMkd
  CurrenciesMmk
  CurrenciesMnt
  CurrenciesMop
  CurrenciesMru
  CurrenciesMur
  CurrenciesMvr
  CurrenciesMwk
  CurrenciesMxn
  CurrenciesMxv
  CurrenciesMyr
  CurrenciesMzn
  CurrenciesNad
  CurrenciesNgn
  CurrenciesNio
  CurrenciesNok
  CurrenciesNpr
  CurrenciesNzd
  CurrenciesOmr
  CurrenciesPab
  CurrenciesPen
  CurrenciesPgk
  CurrenciesPhp
  CurrenciesPkr
  CurrenciesPln
  CurrenciesPyg
  CurrenciesQar
  CurrenciesRon
  CurrenciesRsd
  CurrenciesRub
  CurrenciesRwf
  CurrenciesSar
  CurrenciesSbd
  CurrenciesScr
  CurrenciesSdg
  CurrenciesSek
  CurrenciesSgd
  CurrenciesShp
  CurrenciesSll
  CurrenciesSos
  CurrenciesSrd
  CurrenciesSsp
  CurrenciesStn
  CurrenciesSvc
  CurrenciesSyp
  CurrenciesSzl
  CurrenciesThb
  CurrenciesTjs
  CurrenciesTmt
  CurrenciesTnd
  CurrenciesTop
  CurrenciesTry
  CurrenciesTtd
  CurrenciesTvd
  CurrenciesTwd
  CurrenciesTzs
  CurrenciesUah
  CurrenciesUgx
  CurrenciesUsd
  CurrenciesUsn
  CurrenciesUyi
  CurrenciesUyu
  CurrenciesUzs
  CurrenciesVef
  CurrenciesVnd
  CurrenciesVuv
  CurrenciesWst
  CurrenciesXaf
  CurrenciesXag
  CurrenciesXau
  CurrenciesXba
  CurrenciesXbb
  CurrenciesXbc
  CurrenciesXbd
  CurrenciesXcd
  CurrenciesXdr
  CurrenciesXof
  CurrenciesXpd
  CurrenciesXpf
  CurrenciesXpt
  CurrenciesXsu
  CurrenciesXts
  CurrenciesXua
  CurrenciesXxx
  CurrenciesYer
  CurrenciesZar
  CurrenciesZmw
  CurrenciesZwl
}

pub const currencies: List(Currencies) = [
  CurrenciesAed,
  CurrenciesAfn,
  CurrenciesAll,
  CurrenciesAmd,
  CurrenciesAng,
  CurrenciesAoa,
  CurrenciesArs,
  CurrenciesAud,
  CurrenciesAwg,
  CurrenciesAzn,
  CurrenciesBam,
  CurrenciesBbd,
  CurrenciesBdt,
  CurrenciesBgn,
  CurrenciesBhd,
  CurrenciesBif,
  CurrenciesBmd,
  CurrenciesBnd,
  CurrenciesBob,
  CurrenciesBov,
  CurrenciesBrl,
  CurrenciesBsd,
  CurrenciesBtn,
  CurrenciesBwp,
  CurrenciesByn,
  CurrenciesBzd,
  CurrenciesCad,
  CurrenciesCdf,
  CurrenciesChe,
  CurrenciesChf,
  CurrenciesChw,
  CurrenciesClf,
  CurrenciesClp,
  CurrenciesCny,
  CurrenciesCop,
  CurrenciesCou,
  CurrenciesCrc,
  CurrenciesCuc,
  CurrenciesCup,
  CurrenciesCve,
  CurrenciesCzk,
  CurrenciesDjf,
  CurrenciesDkk,
  CurrenciesDop,
  CurrenciesDzd,
  CurrenciesEgp,
  CurrenciesErn,
  CurrenciesEtb,
  CurrenciesEur,
  CurrenciesFjd,
  CurrenciesFkp,
  CurrenciesGbp,
  CurrenciesGel,
  CurrenciesGgp,
  CurrenciesGhs,
  CurrenciesGip,
  CurrenciesGmd,
  CurrenciesGnf,
  CurrenciesGtq,
  CurrenciesGyd,
  CurrenciesHkd,
  CurrenciesHnl,
  CurrenciesHrk,
  CurrenciesHtg,
  CurrenciesHuf,
  CurrenciesIdr,
  CurrenciesIls,
  CurrenciesImp,
  CurrenciesInr,
  CurrenciesIqd,
  CurrenciesIrr,
  CurrenciesIsk,
  CurrenciesJep,
  CurrenciesJmd,
  CurrenciesJod,
  CurrenciesJpy,
  CurrenciesKes,
  CurrenciesKgs,
  CurrenciesKhr,
  CurrenciesKmf,
  CurrenciesKpw,
  CurrenciesKrw,
  CurrenciesKwd,
  CurrenciesKyd,
  CurrenciesKzt,
  CurrenciesLak,
  CurrenciesLbp,
  CurrenciesLkr,
  CurrenciesLrd,
  CurrenciesLsl,
  CurrenciesLyd,
  CurrenciesMad,
  CurrenciesMdl,
  CurrenciesMga,
  CurrenciesMkd,
  CurrenciesMmk,
  CurrenciesMnt,
  CurrenciesMop,
  CurrenciesMru,
  CurrenciesMur,
  CurrenciesMvr,
  CurrenciesMwk,
  CurrenciesMxn,
  CurrenciesMxv,
  CurrenciesMyr,
  CurrenciesMzn,
  CurrenciesNad,
  CurrenciesNgn,
  CurrenciesNio,
  CurrenciesNok,
  CurrenciesNpr,
  CurrenciesNzd,
  CurrenciesOmr,
  CurrenciesPab,
  CurrenciesPen,
  CurrenciesPgk,
  CurrenciesPhp,
  CurrenciesPkr,
  CurrenciesPln,
  CurrenciesPyg,
  CurrenciesQar,
  CurrenciesRon,
  CurrenciesRsd,
  CurrenciesRub,
  CurrenciesRwf,
  CurrenciesSar,
  CurrenciesSbd,
  CurrenciesScr,
  CurrenciesSdg,
  CurrenciesSek,
  CurrenciesSgd,
  CurrenciesShp,
  CurrenciesSll,
  CurrenciesSos,
  CurrenciesSrd,
  CurrenciesSsp,
  CurrenciesStn,
  CurrenciesSvc,
  CurrenciesSyp,
  CurrenciesSzl,
  CurrenciesThb,
  CurrenciesTjs,
  CurrenciesTmt,
  CurrenciesTnd,
  CurrenciesTop,
  CurrenciesTry,
  CurrenciesTtd,
  CurrenciesTvd,
  CurrenciesTwd,
  CurrenciesTzs,
  CurrenciesUah,
  CurrenciesUgx,
  CurrenciesUsd,
  CurrenciesUsn,
  CurrenciesUyi,
  CurrenciesUyu,
  CurrenciesUzs,
  CurrenciesVef,
  CurrenciesVnd,
  CurrenciesVuv,
  CurrenciesWst,
  CurrenciesXaf,
  CurrenciesXag,
  CurrenciesXau,
  CurrenciesXba,
  CurrenciesXbb,
  CurrenciesXbc,
  CurrenciesXbd,
  CurrenciesXcd,
  CurrenciesXdr,
  CurrenciesXof,
  CurrenciesXpd,
  CurrenciesXpf,
  CurrenciesXpt,
  CurrenciesXsu,
  CurrenciesXts,
  CurrenciesXua,
  CurrenciesXxx,
  CurrenciesYer,
  CurrenciesZar,
  CurrenciesZmw,
  CurrenciesZwl,
]

pub fn currencies_to_json(currencies: Currencies) -> Json {
  json.string(currencies_to_code(currencies))
}

pub fn currencies_to_code(currencies: Currencies) -> String {
  case currencies {
    CurrenciesAed -> "AED"
    CurrenciesAfn -> "AFN"
    CurrenciesAll -> "ALL"
    CurrenciesAmd -> "AMD"
    CurrenciesAng -> "ANG"
    CurrenciesAoa -> "AOA"
    CurrenciesArs -> "ARS"
    CurrenciesAud -> "AUD"
    CurrenciesAwg -> "AWG"
    CurrenciesAzn -> "AZN"
    CurrenciesBam -> "BAM"
    CurrenciesBbd -> "BBD"
    CurrenciesBdt -> "BDT"
    CurrenciesBgn -> "BGN"
    CurrenciesBhd -> "BHD"
    CurrenciesBif -> "BIF"
    CurrenciesBmd -> "BMD"
    CurrenciesBnd -> "BND"
    CurrenciesBob -> "BOB"
    CurrenciesBov -> "BOV"
    CurrenciesBrl -> "BRL"
    CurrenciesBsd -> "BSD"
    CurrenciesBtn -> "BTN"
    CurrenciesBwp -> "BWP"
    CurrenciesByn -> "BYN"
    CurrenciesBzd -> "BZD"
    CurrenciesCad -> "CAD"
    CurrenciesCdf -> "CDF"
    CurrenciesChe -> "CHE"
    CurrenciesChf -> "CHF"
    CurrenciesChw -> "CHW"
    CurrenciesClf -> "CLF"
    CurrenciesClp -> "CLP"
    CurrenciesCny -> "CNY"
    CurrenciesCop -> "COP"
    CurrenciesCou -> "COU"
    CurrenciesCrc -> "CRC"
    CurrenciesCuc -> "CUC"
    CurrenciesCup -> "CUP"
    CurrenciesCve -> "CVE"
    CurrenciesCzk -> "CZK"
    CurrenciesDjf -> "DJF"
    CurrenciesDkk -> "DKK"
    CurrenciesDop -> "DOP"
    CurrenciesDzd -> "DZD"
    CurrenciesEgp -> "EGP"
    CurrenciesErn -> "ERN"
    CurrenciesEtb -> "ETB"
    CurrenciesEur -> "EUR"
    CurrenciesFjd -> "FJD"
    CurrenciesFkp -> "FKP"
    CurrenciesGbp -> "GBP"
    CurrenciesGel -> "GEL"
    CurrenciesGgp -> "GGP"
    CurrenciesGhs -> "GHS"
    CurrenciesGip -> "GIP"
    CurrenciesGmd -> "GMD"
    CurrenciesGnf -> "GNF"
    CurrenciesGtq -> "GTQ"
    CurrenciesGyd -> "GYD"
    CurrenciesHkd -> "HKD"
    CurrenciesHnl -> "HNL"
    CurrenciesHrk -> "HRK"
    CurrenciesHtg -> "HTG"
    CurrenciesHuf -> "HUF"
    CurrenciesIdr -> "IDR"
    CurrenciesIls -> "ILS"
    CurrenciesImp -> "IMP"
    CurrenciesInr -> "INR"
    CurrenciesIqd -> "IQD"
    CurrenciesIrr -> "IRR"
    CurrenciesIsk -> "ISK"
    CurrenciesJep -> "JEP"
    CurrenciesJmd -> "JMD"
    CurrenciesJod -> "JOD"
    CurrenciesJpy -> "JPY"
    CurrenciesKes -> "KES"
    CurrenciesKgs -> "KGS"
    CurrenciesKhr -> "KHR"
    CurrenciesKmf -> "KMF"
    CurrenciesKpw -> "KPW"
    CurrenciesKrw -> "KRW"
    CurrenciesKwd -> "KWD"
    CurrenciesKyd -> "KYD"
    CurrenciesKzt -> "KZT"
    CurrenciesLak -> "LAK"
    CurrenciesLbp -> "LBP"
    CurrenciesLkr -> "LKR"
    CurrenciesLrd -> "LRD"
    CurrenciesLsl -> "LSL"
    CurrenciesLyd -> "LYD"
    CurrenciesMad -> "MAD"
    CurrenciesMdl -> "MDL"
    CurrenciesMga -> "MGA"
    CurrenciesMkd -> "MKD"
    CurrenciesMmk -> "MMK"
    CurrenciesMnt -> "MNT"
    CurrenciesMop -> "MOP"
    CurrenciesMru -> "MRU"
    CurrenciesMur -> "MUR"
    CurrenciesMvr -> "MVR"
    CurrenciesMwk -> "MWK"
    CurrenciesMxn -> "MXN"
    CurrenciesMxv -> "MXV"
    CurrenciesMyr -> "MYR"
    CurrenciesMzn -> "MZN"
    CurrenciesNad -> "NAD"
    CurrenciesNgn -> "NGN"
    CurrenciesNio -> "NIO"
    CurrenciesNok -> "NOK"
    CurrenciesNpr -> "NPR"
    CurrenciesNzd -> "NZD"
    CurrenciesOmr -> "OMR"
    CurrenciesPab -> "PAB"
    CurrenciesPen -> "PEN"
    CurrenciesPgk -> "PGK"
    CurrenciesPhp -> "PHP"
    CurrenciesPkr -> "PKR"
    CurrenciesPln -> "PLN"
    CurrenciesPyg -> "PYG"
    CurrenciesQar -> "QAR"
    CurrenciesRon -> "RON"
    CurrenciesRsd -> "RSD"
    CurrenciesRub -> "RUB"
    CurrenciesRwf -> "RWF"
    CurrenciesSar -> "SAR"
    CurrenciesSbd -> "SBD"
    CurrenciesScr -> "SCR"
    CurrenciesSdg -> "SDG"
    CurrenciesSek -> "SEK"
    CurrenciesSgd -> "SGD"
    CurrenciesShp -> "SHP"
    CurrenciesSll -> "SLL"
    CurrenciesSos -> "SOS"
    CurrenciesSrd -> "SRD"
    CurrenciesSsp -> "SSP"
    CurrenciesStn -> "STN"
    CurrenciesSvc -> "SVC"
    CurrenciesSyp -> "SYP"
    CurrenciesSzl -> "SZL"
    CurrenciesThb -> "THB"
    CurrenciesTjs -> "TJS"
    CurrenciesTmt -> "TMT"
    CurrenciesTnd -> "TND"
    CurrenciesTop -> "TOP"
    CurrenciesTry -> "TRY"
    CurrenciesTtd -> "TTD"
    CurrenciesTvd -> "TVD"
    CurrenciesTwd -> "TWD"
    CurrenciesTzs -> "TZS"
    CurrenciesUah -> "UAH"
    CurrenciesUgx -> "UGX"
    CurrenciesUsd -> "USD"
    CurrenciesUsn -> "USN"
    CurrenciesUyi -> "UYI"
    CurrenciesUyu -> "UYU"
    CurrenciesUzs -> "UZS"
    CurrenciesVef -> "VEF"
    CurrenciesVnd -> "VND"
    CurrenciesVuv -> "VUV"
    CurrenciesWst -> "WST"
    CurrenciesXaf -> "XAF"
    CurrenciesXag -> "XAG"
    CurrenciesXau -> "XAU"
    CurrenciesXba -> "XBA"
    CurrenciesXbb -> "XBB"
    CurrenciesXbc -> "XBC"
    CurrenciesXbd -> "XBD"
    CurrenciesXcd -> "XCD"
    CurrenciesXdr -> "XDR"
    CurrenciesXof -> "XOF"
    CurrenciesXpd -> "XPD"
    CurrenciesXpf -> "XPF"
    CurrenciesXpt -> "XPT"
    CurrenciesXsu -> "XSU"
    CurrenciesXts -> "XTS"
    CurrenciesXua -> "XUA"
    CurrenciesXxx -> "XXX"
    CurrenciesYer -> "YER"
    CurrenciesZar -> "ZAR"
    CurrenciesZmw -> "ZMW"
    CurrenciesZwl -> "ZWL"
  }
}

pub fn currencies_parse_code(code: String) -> Result(Currencies, Nil) {
  case code {
    "AED" -> Ok(CurrenciesAed)
    "AFN" -> Ok(CurrenciesAfn)
    "ALL" -> Ok(CurrenciesAll)
    "AMD" -> Ok(CurrenciesAmd)
    "ANG" -> Ok(CurrenciesAng)
    "AOA" -> Ok(CurrenciesAoa)
    "ARS" -> Ok(CurrenciesArs)
    "AUD" -> Ok(CurrenciesAud)
    "AWG" -> Ok(CurrenciesAwg)
    "AZN" -> Ok(CurrenciesAzn)
    "BAM" -> Ok(CurrenciesBam)
    "BBD" -> Ok(CurrenciesBbd)
    "BDT" -> Ok(CurrenciesBdt)
    "BGN" -> Ok(CurrenciesBgn)
    "BHD" -> Ok(CurrenciesBhd)
    "BIF" -> Ok(CurrenciesBif)
    "BMD" -> Ok(CurrenciesBmd)
    "BND" -> Ok(CurrenciesBnd)
    "BOB" -> Ok(CurrenciesBob)
    "BOV" -> Ok(CurrenciesBov)
    "BRL" -> Ok(CurrenciesBrl)
    "BSD" -> Ok(CurrenciesBsd)
    "BTN" -> Ok(CurrenciesBtn)
    "BWP" -> Ok(CurrenciesBwp)
    "BYN" -> Ok(CurrenciesByn)
    "BZD" -> Ok(CurrenciesBzd)
    "CAD" -> Ok(CurrenciesCad)
    "CDF" -> Ok(CurrenciesCdf)
    "CHE" -> Ok(CurrenciesChe)
    "CHF" -> Ok(CurrenciesChf)
    "CHW" -> Ok(CurrenciesChw)
    "CLF" -> Ok(CurrenciesClf)
    "CLP" -> Ok(CurrenciesClp)
    "CNY" -> Ok(CurrenciesCny)
    "COP" -> Ok(CurrenciesCop)
    "COU" -> Ok(CurrenciesCou)
    "CRC" -> Ok(CurrenciesCrc)
    "CUC" -> Ok(CurrenciesCuc)
    "CUP" -> Ok(CurrenciesCup)
    "CVE" -> Ok(CurrenciesCve)
    "CZK" -> Ok(CurrenciesCzk)
    "DJF" -> Ok(CurrenciesDjf)
    "DKK" -> Ok(CurrenciesDkk)
    "DOP" -> Ok(CurrenciesDop)
    "DZD" -> Ok(CurrenciesDzd)
    "EGP" -> Ok(CurrenciesEgp)
    "ERN" -> Ok(CurrenciesErn)
    "ETB" -> Ok(CurrenciesEtb)
    "EUR" -> Ok(CurrenciesEur)
    "FJD" -> Ok(CurrenciesFjd)
    "FKP" -> Ok(CurrenciesFkp)
    "GBP" -> Ok(CurrenciesGbp)
    "GEL" -> Ok(CurrenciesGel)
    "GGP" -> Ok(CurrenciesGgp)
    "GHS" -> Ok(CurrenciesGhs)
    "GIP" -> Ok(CurrenciesGip)
    "GMD" -> Ok(CurrenciesGmd)
    "GNF" -> Ok(CurrenciesGnf)
    "GTQ" -> Ok(CurrenciesGtq)
    "GYD" -> Ok(CurrenciesGyd)
    "HKD" -> Ok(CurrenciesHkd)
    "HNL" -> Ok(CurrenciesHnl)
    "HRK" -> Ok(CurrenciesHrk)
    "HTG" -> Ok(CurrenciesHtg)
    "HUF" -> Ok(CurrenciesHuf)
    "IDR" -> Ok(CurrenciesIdr)
    "ILS" -> Ok(CurrenciesIls)
    "IMP" -> Ok(CurrenciesImp)
    "INR" -> Ok(CurrenciesInr)
    "IQD" -> Ok(CurrenciesIqd)
    "IRR" -> Ok(CurrenciesIrr)
    "ISK" -> Ok(CurrenciesIsk)
    "JEP" -> Ok(CurrenciesJep)
    "JMD" -> Ok(CurrenciesJmd)
    "JOD" -> Ok(CurrenciesJod)
    "JPY" -> Ok(CurrenciesJpy)
    "KES" -> Ok(CurrenciesKes)
    "KGS" -> Ok(CurrenciesKgs)
    "KHR" -> Ok(CurrenciesKhr)
    "KMF" -> Ok(CurrenciesKmf)
    "KPW" -> Ok(CurrenciesKpw)
    "KRW" -> Ok(CurrenciesKrw)
    "KWD" -> Ok(CurrenciesKwd)
    "KYD" -> Ok(CurrenciesKyd)
    "KZT" -> Ok(CurrenciesKzt)
    "LAK" -> Ok(CurrenciesLak)
    "LBP" -> Ok(CurrenciesLbp)
    "LKR" -> Ok(CurrenciesLkr)
    "LRD" -> Ok(CurrenciesLrd)
    "LSL" -> Ok(CurrenciesLsl)
    "LYD" -> Ok(CurrenciesLyd)
    "MAD" -> Ok(CurrenciesMad)
    "MDL" -> Ok(CurrenciesMdl)
    "MGA" -> Ok(CurrenciesMga)
    "MKD" -> Ok(CurrenciesMkd)
    "MMK" -> Ok(CurrenciesMmk)
    "MNT" -> Ok(CurrenciesMnt)
    "MOP" -> Ok(CurrenciesMop)
    "MRU" -> Ok(CurrenciesMru)
    "MUR" -> Ok(CurrenciesMur)
    "MVR" -> Ok(CurrenciesMvr)
    "MWK" -> Ok(CurrenciesMwk)
    "MXN" -> Ok(CurrenciesMxn)
    "MXV" -> Ok(CurrenciesMxv)
    "MYR" -> Ok(CurrenciesMyr)
    "MZN" -> Ok(CurrenciesMzn)
    "NAD" -> Ok(CurrenciesNad)
    "NGN" -> Ok(CurrenciesNgn)
    "NIO" -> Ok(CurrenciesNio)
    "NOK" -> Ok(CurrenciesNok)
    "NPR" -> Ok(CurrenciesNpr)
    "NZD" -> Ok(CurrenciesNzd)
    "OMR" -> Ok(CurrenciesOmr)
    "PAB" -> Ok(CurrenciesPab)
    "PEN" -> Ok(CurrenciesPen)
    "PGK" -> Ok(CurrenciesPgk)
    "PHP" -> Ok(CurrenciesPhp)
    "PKR" -> Ok(CurrenciesPkr)
    "PLN" -> Ok(CurrenciesPln)
    "PYG" -> Ok(CurrenciesPyg)
    "QAR" -> Ok(CurrenciesQar)
    "RON" -> Ok(CurrenciesRon)
    "RSD" -> Ok(CurrenciesRsd)
    "RUB" -> Ok(CurrenciesRub)
    "RWF" -> Ok(CurrenciesRwf)
    "SAR" -> Ok(CurrenciesSar)
    "SBD" -> Ok(CurrenciesSbd)
    "SCR" -> Ok(CurrenciesScr)
    "SDG" -> Ok(CurrenciesSdg)
    "SEK" -> Ok(CurrenciesSek)
    "SGD" -> Ok(CurrenciesSgd)
    "SHP" -> Ok(CurrenciesShp)
    "SLL" -> Ok(CurrenciesSll)
    "SOS" -> Ok(CurrenciesSos)
    "SRD" -> Ok(CurrenciesSrd)
    "SSP" -> Ok(CurrenciesSsp)
    "STN" -> Ok(CurrenciesStn)
    "SVC" -> Ok(CurrenciesSvc)
    "SYP" -> Ok(CurrenciesSyp)
    "SZL" -> Ok(CurrenciesSzl)
    "THB" -> Ok(CurrenciesThb)
    "TJS" -> Ok(CurrenciesTjs)
    "TMT" -> Ok(CurrenciesTmt)
    "TND" -> Ok(CurrenciesTnd)
    "TOP" -> Ok(CurrenciesTop)
    "TRY" -> Ok(CurrenciesTry)
    "TTD" -> Ok(CurrenciesTtd)
    "TVD" -> Ok(CurrenciesTvd)
    "TWD" -> Ok(CurrenciesTwd)
    "TZS" -> Ok(CurrenciesTzs)
    "UAH" -> Ok(CurrenciesUah)
    "UGX" -> Ok(CurrenciesUgx)
    "USD" -> Ok(CurrenciesUsd)
    "USN" -> Ok(CurrenciesUsn)
    "UYI" -> Ok(CurrenciesUyi)
    "UYU" -> Ok(CurrenciesUyu)
    "UZS" -> Ok(CurrenciesUzs)
    "VEF" -> Ok(CurrenciesVef)
    "VND" -> Ok(CurrenciesVnd)
    "VUV" -> Ok(CurrenciesVuv)
    "WST" -> Ok(CurrenciesWst)
    "XAF" -> Ok(CurrenciesXaf)
    "XAG" -> Ok(CurrenciesXag)
    "XAU" -> Ok(CurrenciesXau)
    "XBA" -> Ok(CurrenciesXba)
    "XBB" -> Ok(CurrenciesXbb)
    "XBC" -> Ok(CurrenciesXbc)
    "XBD" -> Ok(CurrenciesXbd)
    "XCD" -> Ok(CurrenciesXcd)
    "XDR" -> Ok(CurrenciesXdr)
    "XOF" -> Ok(CurrenciesXof)
    "XPD" -> Ok(CurrenciesXpd)
    "XPF" -> Ok(CurrenciesXpf)
    "XPT" -> Ok(CurrenciesXpt)
    "XSU" -> Ok(CurrenciesXsu)
    "XTS" -> Ok(CurrenciesXts)
    "XUA" -> Ok(CurrenciesXua)
    "XXX" -> Ok(CurrenciesXxx)
    "YER" -> Ok(CurrenciesYer)
    "ZAR" -> Ok(CurrenciesZar)
    "ZMW" -> Ok(CurrenciesZmw)
    "ZWL" -> Ok(CurrenciesZwl)
    _ -> Error(Nil)
  }
}

pub fn currencies_decoder() -> Decoder(Currencies) {
  use variant <- decode.then(decode.string)
  case currencies_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        CurrenciesAed,
        "Currencies",
        currencies,
        currencies_to_code,
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

pub type OperationParameterUse {
  OperationParameterUseIn
  OperationParameterUseOut
}

pub const operation_parameter_use: List(OperationParameterUse) = [
  OperationParameterUseIn,
  OperationParameterUseOut,
]

pub fn operation_parameter_use_to_json(
  operation_parameter_use: OperationParameterUse,
) -> Json {
  json.string(operation_parameter_use_to_code(operation_parameter_use))
}

pub fn operation_parameter_use_to_code(
  operation_parameter_use: OperationParameterUse,
) -> String {
  case operation_parameter_use {
    OperationParameterUseIn -> "in"
    OperationParameterUseOut -> "out"
  }
}

pub fn operation_parameter_use_parse_code(
  code: String,
) -> Result(OperationParameterUse, Nil) {
  case code {
    "in" -> Ok(OperationParameterUseIn)
    "out" -> Ok(OperationParameterUseOut)
    _ -> Error(Nil)
  }
}

pub fn operation_parameter_use_decoder() -> Decoder(OperationParameterUse) {
  use variant <- decode.then(decode.string)
  case operation_parameter_use_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        OperationParameterUseIn,
        "OperationParameterUse",
        operation_parameter_use,
        operation_parameter_use_to_code,
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

pub type RelatedartifactType {
  RelatedartifactTypeDocumentation
  RelatedartifactTypeJustification
  RelatedartifactTypeCitation
  RelatedartifactTypePredecessor
  RelatedartifactTypeSuccessor
  RelatedartifactTypeDerivedfrom
  RelatedartifactTypeDependson
  RelatedartifactTypeComposedof
}

pub const relatedartifact_type: List(RelatedartifactType) = [
  RelatedartifactTypeDocumentation,
  RelatedartifactTypeJustification,
  RelatedartifactTypeCitation,
  RelatedartifactTypePredecessor,
  RelatedartifactTypeSuccessor,
  RelatedartifactTypeDerivedfrom,
  RelatedartifactTypeDependson,
  RelatedartifactTypeComposedof,
]

pub fn relatedartifact_type_to_json(
  relatedartifact_type: RelatedartifactType,
) -> Json {
  json.string(relatedartifact_type_to_code(relatedartifact_type))
}

pub fn relatedartifact_type_to_code(
  relatedartifact_type: RelatedartifactType,
) -> String {
  case relatedartifact_type {
    RelatedartifactTypeDocumentation -> "documentation"
    RelatedartifactTypeJustification -> "justification"
    RelatedartifactTypeCitation -> "citation"
    RelatedartifactTypePredecessor -> "predecessor"
    RelatedartifactTypeSuccessor -> "successor"
    RelatedartifactTypeDerivedfrom -> "derived-from"
    RelatedartifactTypeDependson -> "depends-on"
    RelatedartifactTypeComposedof -> "composed-of"
  }
}

pub fn relatedartifact_type_parse_code(
  code: String,
) -> Result(RelatedartifactType, Nil) {
  case code {
    "documentation" -> Ok(RelatedartifactTypeDocumentation)
    "justification" -> Ok(RelatedartifactTypeJustification)
    "citation" -> Ok(RelatedartifactTypeCitation)
    "predecessor" -> Ok(RelatedartifactTypePredecessor)
    "successor" -> Ok(RelatedartifactTypeSuccessor)
    "derived-from" -> Ok(RelatedartifactTypeDerivedfrom)
    "depends-on" -> Ok(RelatedartifactTypeDependson)
    "composed-of" -> Ok(RelatedartifactTypeComposedof)
    _ -> Error(Nil)
  }
}

pub fn relatedartifact_type_decoder() -> Decoder(RelatedartifactType) {
  use variant <- decode.then(decode.string)
  case relatedartifact_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        RelatedartifactTypeDocumentation,
        "RelatedartifactType",
        relatedartifact_type,
        relatedartifact_type_to_code,
      )
  }
}

pub type SortDirection {
  SortDirectionAscending
  SortDirectionDescending
}

pub const sort_direction: List(SortDirection) = [
  SortDirectionAscending,
  SortDirectionDescending,
]

pub fn sort_direction_to_json(sort_direction: SortDirection) -> Json {
  json.string(sort_direction_to_code(sort_direction))
}

pub fn sort_direction_to_code(sort_direction: SortDirection) -> String {
  case sort_direction {
    SortDirectionAscending -> "ascending"
    SortDirectionDescending -> "descending"
  }
}

pub fn sort_direction_parse_code(code: String) -> Result(SortDirection, Nil) {
  case code {
    "ascending" -> Ok(SortDirectionAscending)
    "descending" -> Ok(SortDirectionDescending)
    _ -> Error(Nil)
  }
}

pub fn sort_direction_decoder() -> Decoder(SortDirection) {
  use variant <- decode.then(decode.string)
  case sort_direction_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        SortDirectionAscending,
        "SortDirection",
        sort_direction,
        sort_direction_to_code,
      )
  }
}

pub type TriggerType {
  TriggerTypeNamedevent
  TriggerTypePeriodic
  TriggerTypeDatachanged
  TriggerTypeDataadded
  TriggerTypeDatamodified
  TriggerTypeDataremoved
  TriggerTypeDataaccessed
  TriggerTypeDataaccessended
}

pub const trigger_type: List(TriggerType) = [
  TriggerTypeNamedevent,
  TriggerTypePeriodic,
  TriggerTypeDatachanged,
  TriggerTypeDataadded,
  TriggerTypeDatamodified,
  TriggerTypeDataremoved,
  TriggerTypeDataaccessed,
  TriggerTypeDataaccessended,
]

pub fn trigger_type_to_json(trigger_type: TriggerType) -> Json {
  json.string(trigger_type_to_code(trigger_type))
}

pub fn trigger_type_to_code(trigger_type: TriggerType) -> String {
  case trigger_type {
    TriggerTypeNamedevent -> "named-event"
    TriggerTypePeriodic -> "periodic"
    TriggerTypeDatachanged -> "data-changed"
    TriggerTypeDataadded -> "data-added"
    TriggerTypeDatamodified -> "data-modified"
    TriggerTypeDataremoved -> "data-removed"
    TriggerTypeDataaccessed -> "data-accessed"
    TriggerTypeDataaccessended -> "data-access-ended"
  }
}

pub fn trigger_type_parse_code(code: String) -> Result(TriggerType, Nil) {
  case code {
    "named-event" -> Ok(TriggerTypeNamedevent)
    "periodic" -> Ok(TriggerTypePeriodic)
    "data-changed" -> Ok(TriggerTypeDatachanged)
    "data-added" -> Ok(TriggerTypeDataadded)
    "data-modified" -> Ok(TriggerTypeDatamodified)
    "data-removed" -> Ok(TriggerTypeDataremoved)
    "data-accessed" -> Ok(TriggerTypeDataaccessed)
    "data-access-ended" -> Ok(TriggerTypeDataaccessended)
    _ -> Error(Nil)
  }
}

pub fn trigger_type_decoder() -> Decoder(TriggerType) {
  use variant <- decode.then(decode.string)
  case trigger_type_parse_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        TriggerTypeNamedevent,
        "TriggerType",
        trigger_type,
        trigger_type_to_code,
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
