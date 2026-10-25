import fhir/potato_client_1_0_0/primitive_type
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

pub fn instant_to_datetime_local(time: primitive_type.Instant) {
  time |> primitive_type.instant_to_string |> string.slice(0, 16) |> a.value
}
