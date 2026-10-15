import gleam/dynamic/decode
import gleam/json

pub type SharedUser {
  SharedUser(
    id: String,
    // settings_theme is css stylesheet, could be an enum but idc
    settings_theme: String,
    // could put a practitioner profile in here but for now only using name
    name: String,
  )
}

pub fn shared_user_decoder() -> decode.Decoder(SharedUser) {
  use id <- decode.field("id", decode.string)
  use settings_theme <- decode.field("settings_theme", decode.string)
  use name <- decode.field("name", decode.string)
  decode.success(SharedUser(id:, settings_theme:, name:))
}

pub fn shared_user_to_json(user: SharedUser) {
  [
    #("id", json.string(user.id)),
    #("settings_theme", json.string(user.settings_theme)),
    #("name", json.string(user.name)),
  ]
  |> json.object
}
