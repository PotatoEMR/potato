import gleam/list
import gleam/option.{None, Some}
import gleam/uri.{Uri}
import lustre/attribute as a
import lustre/element/html as h
import lustre/event
import modem

const css_files = ["bahunya", "pico", "water"]

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
    h.label([], [h.text("theme")]),
    h.select(
      [
        event.on_input(Theme),
      ],
      list.map(css_files, fn(css_file) {
        echo css_file
        echo current_theme
        h.option([a.selected(css_file == current_theme)], css_file)
      }),
    ),
  ])
}
