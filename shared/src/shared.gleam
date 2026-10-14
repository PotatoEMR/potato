import gleam/dynamic/decode
import gleam/json

pub type SharedUser {
  SharedUser(
    id: String,
    //settings_theme could be an enum but idc
    settings_theme: String,
  )
}

pub fn shared_user_decoder() -> decode.Decoder(SharedUser) {
  use id <- decode.field("id", decode.string)
  use settings_theme <- decode.field("settings_theme", decode.string)
  decode.success(SharedUser(id:, settings_theme:))
}

pub fn shared_user_to_json(user: SharedUser) {
  [
    #("id", json.string(user.id)),
    #("settings_theme", json.string(user.settings_theme)),
  ]
  |> json.object
}
