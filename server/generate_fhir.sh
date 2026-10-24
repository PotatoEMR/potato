gleam run -m codegen r4 custom=potato.server/1.0.0 structuredefinitions=PotatoServerPractitioner download
rm src/fhir/potato_server_1_0_0/client_rsvp.gleam
gleam format
