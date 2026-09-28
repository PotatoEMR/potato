gleam run -m codegen r4 download custom=hl7.fhir.us.core/7.0.0 CapabilityStatement=CapabilityStatement-us-core-server.json structuredefinitions=USCorePatientProfile,USCorePractitionerProfile
rm src/fhir/hl7_fhir_us_core_7_0_0/client_rsvp.gleam
gleam format
