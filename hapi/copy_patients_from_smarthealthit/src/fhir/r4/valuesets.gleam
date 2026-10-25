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

pub const alltypes: List(Alltypes) = [
  AlltypesAddress,
  AlltypesAge,
  AlltypesAnnotation,
  AlltypesAttachment,
  AlltypesBackboneelement,
  AlltypesCodeableconcept,
  AlltypesCoding,
  AlltypesContactdetail,
  AlltypesContactpoint,
  AlltypesContributor,
  AlltypesCount,
  AlltypesDatarequirement,
  AlltypesDistance,
  AlltypesDosage,
  AlltypesDuration,
  AlltypesElement,
  AlltypesElementdefinition,
  AlltypesExpression,
  AlltypesExtension,
  AlltypesHumanname,
  AlltypesIdentifier,
  AlltypesMarketingstatus,
  AlltypesMeta,
  AlltypesMoney,
  AlltypesMoneyquantity,
  AlltypesNarrative,
  AlltypesParameterdefinition,
  AlltypesPeriod,
  AlltypesPopulation,
  AlltypesProdcharacteristic,
  AlltypesProductshelflife,
  AlltypesQuantity,
  AlltypesRange,
  AlltypesRatio,
  AlltypesReference,
  AlltypesRelatedartifact,
  AlltypesSampleddata,
  AlltypesSignature,
  AlltypesSimplequantity,
  AlltypesSubstanceamount,
  AlltypesTiming,
  AlltypesTriggerdefinition,
  AlltypesUsagecontext,
  AlltypesBase64binary,
  AlltypesBoolean,
  AlltypesCanonical,
  AlltypesCode,
  AlltypesDate,
  AlltypesDatetime,
  AlltypesDecimal,
  AlltypesId,
  AlltypesInstant,
  AlltypesInteger,
  AlltypesMarkdown,
  AlltypesOid,
  AlltypesPositiveint,
  AlltypesString,
  AlltypesTime,
  AlltypesUnsignedint,
  AlltypesUri,
  AlltypesUrl,
  AlltypesUuid,
  AlltypesXhtml,
  AlltypesAccount,
  AlltypesActivitydefinition,
  AlltypesAdverseevent,
  AlltypesAllergyintolerance,
  AlltypesAppointment,
  AlltypesAppointmentresponse,
  AlltypesAuditevent,
  AlltypesBasic,
  AlltypesBinary,
  AlltypesBiologicallyderivedproduct,
  AlltypesBodystructure,
  AlltypesBundle,
  AlltypesCapabilitystatement,
  AlltypesCareplan,
  AlltypesCareteam,
  AlltypesCatalogentry,
  AlltypesChargeitem,
  AlltypesChargeitemdefinition,
  AlltypesClaim,
  AlltypesClaimresponse,
  AlltypesClinicalimpression,
  AlltypesCodesystem,
  AlltypesCommunication,
  AlltypesCommunicationrequest,
  AlltypesCompartmentdefinition,
  AlltypesComposition,
  AlltypesConceptmap,
  AlltypesCondition,
  AlltypesConsent,
  AlltypesContract,
  AlltypesCoverage,
  AlltypesCoverageeligibilityrequest,
  AlltypesCoverageeligibilityresponse,
  AlltypesDetectedissue,
  AlltypesDevice,
  AlltypesDevicedefinition,
  AlltypesDevicemetric,
  AlltypesDevicerequest,
  AlltypesDeviceusestatement,
  AlltypesDiagnosticreport,
  AlltypesDocumentmanifest,
  AlltypesDocumentreference,
  AlltypesDomainresource,
  AlltypesEffectevidencesynthesis,
  AlltypesEncounter,
  AlltypesEndpoint,
  AlltypesEnrollmentrequest,
  AlltypesEnrollmentresponse,
  AlltypesEpisodeofcare,
  AlltypesEventdefinition,
  AlltypesEvidence,
  AlltypesEvidencevariable,
  AlltypesExamplescenario,
  AlltypesExplanationofbenefit,
  AlltypesFamilymemberhistory,
  AlltypesFlag,
  AlltypesGoal,
  AlltypesGraphdefinition,
  AlltypesGroup,
  AlltypesGuidanceresponse,
  AlltypesHealthcareservice,
  AlltypesImagingstudy,
  AlltypesImmunization,
  AlltypesImmunizationevaluation,
  AlltypesImmunizationrecommendation,
  AlltypesImplementationguide,
  AlltypesInsuranceplan,
  AlltypesInvoice,
  AlltypesLibrary,
  AlltypesLinkage,
  AlltypesList,
  AlltypesLocation,
  AlltypesMeasure,
  AlltypesMeasurereport,
  AlltypesMedia,
  AlltypesMedication,
  AlltypesMedicationadministration,
  AlltypesMedicationdispense,
  AlltypesMedicationknowledge,
  AlltypesMedicationrequest,
  AlltypesMedicationstatement,
  AlltypesMedicinalproduct,
  AlltypesMedicinalproductauthorization,
  AlltypesMedicinalproductcontraindication,
  AlltypesMedicinalproductindication,
  AlltypesMedicinalproductingredient,
  AlltypesMedicinalproductinteraction,
  AlltypesMedicinalproductmanufactured,
  AlltypesMedicinalproductpackaged,
  AlltypesMedicinalproductpharmaceutical,
  AlltypesMedicinalproductundesirableeffect,
  AlltypesMessagedefinition,
  AlltypesMessageheader,
  AlltypesMolecularsequence,
  AlltypesNamingsystem,
  AlltypesNutritionorder,
  AlltypesObservation,
  AlltypesObservationdefinition,
  AlltypesOperationdefinition,
  AlltypesOperationoutcome,
  AlltypesOrganization,
  AlltypesOrganizationaffiliation,
  AlltypesParameters,
  AlltypesPatient,
  AlltypesPaymentnotice,
  AlltypesPaymentreconciliation,
  AlltypesPerson,
  AlltypesPlandefinition,
  AlltypesPractitioner,
  AlltypesPractitionerrole,
  AlltypesProcedure,
  AlltypesProvenance,
  AlltypesQuestionnaire,
  AlltypesQuestionnaireresponse,
  AlltypesRelatedperson,
  AlltypesRequestgroup,
  AlltypesResearchdefinition,
  AlltypesResearchelementdefinition,
  AlltypesResearchstudy,
  AlltypesResearchsubject,
  AlltypesResource,
  AlltypesRiskassessment,
  AlltypesRiskevidencesynthesis,
  AlltypesSchedule,
  AlltypesSearchparameter,
  AlltypesServicerequest,
  AlltypesSlot,
  AlltypesSpecimen,
  AlltypesSpecimendefinition,
  AlltypesStructuredefinition,
  AlltypesStructuremap,
  AlltypesSubscription,
  AlltypesSubstance,
  AlltypesSubstancenucleicacid,
  AlltypesSubstancepolymer,
  AlltypesSubstanceprotein,
  AlltypesSubstancereferenceinformation,
  AlltypesSubstancesourcematerial,
  AlltypesSubstancespecification,
  AlltypesSupplydelivery,
  AlltypesSupplyrequest,
  AlltypesTask,
  AlltypesTerminologycapabilities,
  AlltypesTestreport,
  AlltypesTestscript,
  AlltypesValueset,
  AlltypesVerificationresult,
  AlltypesVisionprescription,
  AlltypesType,
  AlltypesAny,
]

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
  case alltypes_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        AlltypesAddress,
        "Alltypes",
        alltypes,
        alltypes_to_code,
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

pub type Contributortype {
  ContributortypeAuthor
  ContributortypeEditor
  ContributortypeReviewer
  ContributortypeEndorser
}

pub const contributortype: List(Contributortype) = [
  ContributortypeAuthor,
  ContributortypeEditor,
  ContributortypeReviewer,
  ContributortypeEndorser,
]

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
  case contributortype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        ContributortypeAuthor,
        "Contributortype",
        contributortype,
        contributortype_to_code,
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

pub fn currencies_from_code(code: String) -> Result(Currencies, Nil) {
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
  case currencies_from_code(variant) {
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

pub type Operationparameteruse {
  OperationparameteruseIn
  OperationparameteruseOut
}

pub const operationparameteruse: List(Operationparameteruse) = [
  OperationparameteruseIn,
  OperationparameteruseOut,
]

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
  case operationparameteruse_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        OperationparameteruseIn,
        "Operationparameteruse",
        operationparameteruse,
        operationparameteruse_to_code,
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

pub const relatedartifacttype: List(Relatedartifacttype) = [
  RelatedartifacttypeDocumentation,
  RelatedartifacttypeJustification,
  RelatedartifacttypeCitation,
  RelatedartifacttypePredecessor,
  RelatedartifacttypeSuccessor,
  RelatedartifacttypeDerivedfrom,
  RelatedartifacttypeDependson,
  RelatedartifacttypeComposedof,
]

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
  case relatedartifacttype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        RelatedartifacttypeDocumentation,
        "Relatedartifacttype",
        relatedartifacttype,
        relatedartifacttype_to_code,
      )
  }
}

pub type Sortdirection {
  SortdirectionAscending
  SortdirectionDescending
}

pub const sortdirection: List(Sortdirection) = [
  SortdirectionAscending,
  SortdirectionDescending,
]

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
  case sortdirection_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        SortdirectionAscending,
        "Sortdirection",
        sortdirection,
        sortdirection_to_code,
      )
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

pub const triggertype: List(Triggertype) = [
  TriggertypeNamedevent,
  TriggertypePeriodic,
  TriggertypeDatachanged,
  TriggertypeDataadded,
  TriggertypeDatamodified,
  TriggertypeDataremoved,
  TriggertypeDataaccessed,
  TriggertypeDataaccessended,
]

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
  case triggertype_from_code(variant) {
    Ok(code) -> decode.success(code)
    Error(_) ->
      not_included_failure(
        variant,
        TriggertypeNamedevent,
        "Triggertype",
        triggertype,
        triggertype_to_code,
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
