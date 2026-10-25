gleam run -m codegen r4 structuredefinitions=Patient download
rm src/fhir/r4/client_rsvp.gleam
gleam format