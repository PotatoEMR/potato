import gleam/list
import gleam/option.{None, Some}
import gleam/uri.{Uri}
import lustre/attribute as a
import lustre/element/html as h
import lustre/event
import modem

const css_files = [
  "bahunya",
  "bamboo",
  "kacit",
  "mvp",
  "pico",
  "tacit",
  "water",
  "yorha",
]

pub type Msg {
  Theme(theme: String)
}

pub fn update_effect(msg: Msg) {
  modem.load(Uri(
    scheme: None,
    userinfo: None,
    host: None,
    port: None,
    path: "/settings",
    query: Some("theme=" <> msg.theme),
    fragment: None,
  ))
}

pub fn view(current_theme: String) {
  h.div([], [
    h.label([a.for("theme")], [h.text("theme")]),
    h.select(
      [
        a.id("theme"),
        event.on_input(Theme),
      ],
      list.map(css_files, fn(css_file) {
        h.option([a.selected(css_file == current_theme)], css_file)
      }),
    ),
  ])
}
