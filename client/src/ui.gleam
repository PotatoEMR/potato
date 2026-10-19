import fhir/hl7_fhir_us_core_7_0_0/primitive_types
import gleam/string
import lustre/attribute as a
import lustre/element/html as h

pub fn field(label_text, attrs) {
  h.label([a.attribute("data-field", "")], [
    h.text(label_text),
    h.input(attrs),
  ])
}

pub fn vstack(elts) {
  h.div([a.class("vstack")], elts)
}

pub fn instant_to_datetime_local(time: primitive_types.Instant) {
  time |> primitive_types.instant_to_string |> string.slice(0, 16) |> a.value
}
