////[https://hl7.org/fhir/r4](https://hl7.org/fhir/r4) r4 search params

import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/uri

pub fn to_string(params: List(#(String, Option(String)))) -> String {
  list.fold(
    from: [],
    over: params,
    with: fn(acc, param: #(String, Option(String))) {
      case param.1 {
        None -> acc
        Some(p) -> [#(param.0, p), ..acc]
      }
    },
  )
  |> list.reverse
  |> uri.query_to_string
}

pub type Bundle {
  Bundle(
    identifier: Option(String),
    composition: Option(String),
    type_: Option(String),
    message: Option(String),
    timestamp: Option(String),
  )
}

pub type Operationoutcome {
  Operationoutcome
}

pub type PotatoAllergyintolerance {
  PotatoAllergyintolerance(
    severity: Option(String),
    date: Option(String),
    identifier: Option(String),
    manifestation: Option(String),
    recorder: Option(String),
    code: Option(String),
    verification_status: Option(String),
    criticality: Option(String),
    clinical_status: Option(String),
    type_: Option(String),
    onset: Option(String),
    route: Option(String),
    asserter: Option(String),
    patient: Option(String),
    category: Option(String),
    last_date: Option(String),
  )
}

pub type PotatoAppointment {
  PotatoAppointment(
    date: Option(String),
    identifier: Option(String),
    specialty: Option(String),
    service_category: Option(String),
    practitioner: Option(String),
    part_status: Option(String),
    appointment_type: Option(String),
    service_type: Option(String),
    slot: Option(String),
    reason_code: Option(String),
    actor: Option(String),
    based_on: Option(String),
    patient: Option(String),
    reason_reference: Option(String),
    supporting_info: Option(String),
    location: Option(String),
    status: Option(String),
  )
}

pub type PotatoCondition {
  PotatoCondition(
    severity: Option(String),
    evidence_detail: Option(String),
    identifier: Option(String),
    onset_info: Option(String),
    recorded_date: Option(String),
    code: Option(String),
    evidence: Option(String),
    subject: Option(String),
    verification_status: Option(String),
    clinical_status: Option(String),
    encounter: Option(String),
    onset_date: Option(String),
    abatement_date: Option(String),
    asserter: Option(String),
    stage: Option(String),
    abatement_string: Option(String),
    patient: Option(String),
    onset_age: Option(String),
    abatement_age: Option(String),
    category: Option(String),
    body_site: Option(String),
  )
}

pub type PotatoDocumentreference {
  PotatoDocumentreference(
    date: Option(String),
    subject: Option(String),
    description: Option(String),
    language: Option(String),
    type_: Option(String),
    relation: Option(String),
    setting: Option(String),
    related: Option(String),
    patient: Option(String),
    relationship: Option(String),
    event: Option(String),
    authenticator: Option(String),
    identifier: Option(String),
    period: Option(String),
    custodian: Option(String),
    author: Option(String),
    format: Option(String),
    encounter: Option(String),
    contenttype: Option(String),
    security_label: Option(String),
    location: Option(String),
    category: Option(String),
    relatesto: Option(String),
    facility: Option(String),
    status: Option(String),
  )
}

pub type PotatoEncounter {
  PotatoEncounter(
    date: Option(String),
    identifier: Option(String),
    participant_type: Option(String),
    practitioner: Option(String),
    subject: Option(String),
    length: Option(String),
    episode_of_care: Option(String),
    diagnosis: Option(String),
    appointment: Option(String),
    part_of: Option(String),
    type_: Option(String),
    reason_code: Option(String),
    participant: Option(String),
    based_on: Option(String),
    patient: Option(String),
    reason_reference: Option(String),
    location_period: Option(String),
    location: Option(String),
    service_provider: Option(String),
    special_arrangement: Option(String),
    class: Option(String),
    account: Option(String),
    status: Option(String),
  )
}

pub type PotatoImmunization {
  PotatoImmunization(
    date: Option(String),
    identifier: Option(String),
    performer: Option(String),
    reaction: Option(String),
    lot_number: Option(String),
    status_reason: Option(String),
    reason_code: Option(String),
    manufacturer: Option(String),
    target_disease: Option(String),
    patient: Option(String),
    series: Option(String),
    vaccine_code: Option(String),
    reason_reference: Option(String),
    location: Option(String),
    status: Option(String),
    reaction_date: Option(String),
  )
}

pub type PotatoMedicationrequest {
  PotatoMedicationrequest(
    requester: Option(String),
    date: Option(String),
    identifier: Option(String),
    intended_dispenser: Option(String),
    authoredon: Option(String),
    code: Option(String),
    subject: Option(String),
    medication: Option(String),
    encounter: Option(String),
    priority: Option(String),
    intent: Option(String),
    patient: Option(String),
    intended_performer: Option(String),
    intended_performertype: Option(String),
    category: Option(String),
    status: Option(String),
  )
}

pub type PotatoMedicationstatement {
  PotatoMedicationstatement(
    identifier: Option(String),
    effective: Option(String),
    code: Option(String),
    subject: Option(String),
    patient: Option(String),
    context: Option(String),
    medication: Option(String),
    part_of: Option(String),
    source: Option(String),
    category: Option(String),
    status: Option(String),
  )
}

pub type PotatoPatient {
  PotatoPatient(
    identifier: Option(String),
    given: Option(String),
    address: Option(String),
    birthdate: Option(String),
    deceased: Option(String),
    address_state: Option(String),
    gender: Option(String),
    general_practitioner: Option(String),
    link: Option(String),
    active: Option(String),
    language: Option(String),
    address_postalcode: Option(String),
    address_country: Option(String),
    death_date: Option(String),
    phonetic: Option(String),
    phone: Option(String),
    organization: Option(String),
    name: Option(String),
    address_use: Option(String),
    telecom: Option(String),
    family: Option(String),
    address_city: Option(String),
    email: Option(String),
  )
}

pub fn bundle_new() -> Bundle {
  Bundle(None, None, None, None, None)
}

pub fn operationoutcome_new() -> Operationoutcome {
  Operationoutcome
}

pub fn potato_allergyintolerance_new() -> PotatoAllergyintolerance {
  PotatoAllergyintolerance(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_appointment_new() -> PotatoAppointment {
  PotatoAppointment(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_condition_new() -> PotatoCondition {
  PotatoCondition(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_documentreference_new() -> PotatoDocumentreference {
  PotatoDocumentreference(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_encounter_new() -> PotatoEncounter {
  PotatoEncounter(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_immunization_new() -> PotatoImmunization {
  PotatoImmunization(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_medicationrequest_new() -> PotatoMedicationrequest {
  PotatoMedicationrequest(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_medicationstatement_new() -> PotatoMedicationstatement {
  PotatoMedicationstatement(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}

pub fn potato_patient_new() -> PotatoPatient {
  PotatoPatient(
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
  )
}
