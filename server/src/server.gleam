import argus
import gleam/dynamic/decode
import gleam/erlang/process
import gleam/http.{Get, Post}
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import lustre/attribute as a
import lustre/element
import lustre/element/html as h
import mist
import storail
import wisp.{type Request, type Response}
import wisp/wisp_mist

type Role {
  Practitioner
  Patient
}

// stored in storail with username key
type User {
  User(password_hash: String, role: Role, id: String)
}

fn user_to_json(user: User) -> json.Json {
  json.object([
    #("password_hash", json.string(user.password_hash)),
    #(
      "role",
      json.string(case user.role {
        Practitioner -> "practitioner"
        Patient -> "patient"
      }),
    ),
    #("id", json.string(user.id)),
  ])
}

fn user_decoder() -> decode.Decoder(User) {
  use password_hash <- decode.field("password_hash", decode.string)
  use id <- decode.field("id", decode.string)
  use role <- decode.field("role", decode.string)
  case role {
    "practitioner" ->
      decode.success(User(password_hash:, role: Practitioner, id:))
    "patient" -> decode.success(User(password_hash:, role: Patient, id:))
    _ ->
      decode.failure(
        User(password_hash:, role: Practitioner, id:),
        "patient or practitionr",
      )
  }
}

pub fn main() {
  wisp.configure_logger()
  let secret_key_base = wisp.random_string(64)

  let assert Ok(user_db) = setup_user_database()

  let assert Ok(priv_directory) = wisp.priv_directory("server")

  let assert Ok(_) =
    handle_request(user_db, priv_directory, _)
    |> wisp_mist.handler(secret_key_base)
    |> mist.new
    |> mist.port(3000)
    |> mist.start

  process.sleep_forever()
}

// REQUEST HANDLERS ------------------------------------------------------------

fn app_middleware(
  req: Request,
  static_directory: String,
  next: fn(Request) -> Response,
) -> Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)
  use <- wisp.serve_static(req, under: "/static", from: static_directory)

  next(req)
}

fn handle_request(
  db: storail.Collection(User),
  static_directory: String,
  req: Request,
) -> Response {
  use req <- app_middleware(req, static_directory)

  case req.method, wisp.path_segments(req) {
    Get, [] -> serve_index()
    Get, ["auth", "signup"] -> serve_signup(None)
    Post, ["auth", "signup"] -> handle_signup(db, req)
    Get, ["auth", "login"] -> serve_login(None)
    Post, ["auth", "login"] -> handle_login(db, req)
    _, _ -> wisp.not_found()
  }
}

const full = [
  #("height", "100%"),
  #("width", "100%"),
  #("margin", "0px"),
  #("padding", "0px"),
]

fn potatoemr() {
  [
    h.link([
      a.href(
        "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='1em' font-size='80'>🥔</text></svg>",
      ),
      a.rel("icon"),
    ]),
    h.title([], "PotatoEMR"),
  ]
}

fn auth_shell(contents, error_msg) {
  let html =
    h.html([a.styles(full)], [
      h.head([], potatoemr()),
      h.body(
        [
          a.style(
            "font-family",
            "ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\"",
          ),
          a.style("background-image", "url('/static/potato-bg.jpg')"),
          a.style("background-repeat", "no-repeat"),
          a.style("background-attachment", "fixed"),
          a.style("background-size", "cover"),
          a.style("display", "flex"),
          a.style("justify-content", "center"),
          a.style("align-items", "center"),
          a.styles(full),
        ],
        [
          h.main(
            [
              a.style("padding", "2em"),
              a.style("border-radius", "0.5em"),
              a.style("background-color", "white"),
              a.style("box-shadow", "0 0 5px rgba(0, 0, 0, 0.8)"),
            ],
            [
              h.h1([], [h.text("PotatoEMR")]),
              h.form(
                [
                  a.method("post"),
                  a.style("display", "flex"),
                  a.style("flex-direction", "column"),
                  a.style("gap", "5px"),
                ],
                [
                  h.input([
                    a.style("padding", "5px"),
                    a.name("username"),
                    a.placeholder("username"),
                  ]),
                  h.input([
                    a.style("padding", "5px"),
                    a.name("password"),
                    a.type_("password"),
                    a.placeholder("password"),
                  ]),
                  ..contents
                ],
              ),
              h.p(
                [
                  a.style("height", "3em"),
                  a.style("width", "10em"),
                  a.style("color", "red"),
                ],
                [
                  case error_msg {
                    None -> element.none()
                    Some(error_msg) -> h.text(error_msg)
                  },
                ],
              ),
            ],
          ),
        ],
      ),
    ])

  html
  |> element.to_document_string
  |> wisp.html_response(200)
}

fn serve_index() -> Response {
  let html =
    h.html([], [
      h.head([], [
        h.script([a.type_("module"), a.src("/static/potato.js")], ""),
        ..potatoemr()
      ]),
      h.body([], [h.div([a.id("app")], [])]),
    ])

  html
  |> element.to_document_string
  |> wisp.html_response(200)
}

fn serve_signup(error_msg: Option(String)) -> Response {
  auth_shell(
    [
      h.button(
        [
          a.style("padding", "5px"),
        ],
        [h.text("Sign Up")],
      ),
      h.a([a.href("/auth/login")], [h.text("or log in")]),
    ],
    error_msg,
  )
}

fn serve_login(error_msg: Option(String)) -> Response {
  auth_shell(
    [
      h.button(
        [
          a.style("padding", "5px"),
        ],
        [h.text("Log In")],
      ),
      h.a([a.href("/auth/signup")], [h.text("or sign up")]),
    ],
    error_msg,
  )
}

fn require_username_password(
  request: Request,
  next: fn(#(String, String)) -> Response,
) -> Response {
  use form <- wisp.require_form(request)
  case
    find_form_name(form.values, "username"),
    find_form_name(form.values, "password")
  {
    Ok(username), Ok(password) -> next(#(username.1, password.1))
    _, _ -> wisp.bad_request("wrong params")
  }
}

fn find_form_name(values: List(#(String, String)), name) {
  list.find(values, fn(value) { value.0 == name })
}

fn handle_signup(db: storail.Collection(User), req: Request) -> Response {
  use #(username, password) <- require_username_password(req)
  let assert Ok(hashes) =
    argus.hasher()
    |> argus.hash(password)
  let password_hash = hashes.encoded_hash
  let new_user = User(password_hash:, id: "idk xd", role: Practitioner)
  case write_user(db, new_user, username) {
    Ok(_) -> serve_index() |> set_user_cookie(req, username)
    Error(err) ->
      serve_signup(
        Some(case err {
          UsernameExists -> "username exists"
          StorailError(err) ->
            case err {
              storail.ObjectNotFound(_, _) -> "username not found"
              _ -> "internal sever error"
            }
        }),
      )
  }
}

fn handle_login(db: storail.Collection(User), req: Request) -> Response {
  use #(username, password) <- require_username_password(req)
  case read_user(db, username) {
    Ok(user) -> {
      case argus.verify(user.password_hash, password) {
        Ok(True) -> serve_index() |> set_user_cookie(req, username)
        _ -> not_found()
      }
    }
    Error(_) -> not_found()
  }
}

fn not_found() {
  serve_login(Some("username/password not found"))
}

fn set_user_cookie(response, request, username) {
  wisp.set_cookie(
    response:,
    request:,
    name: "username",
    value: username,
    security: wisp.Signed,
    max_age: 60 * 60 * 24 * 365,
  )
}

// USER DATABASE --------------------------------------------------------------------

fn setup_user_database() -> Result(storail.Collection(User), Nil) {
  let config = storail.Config(storage_path: "./users")

  let items =
    storail.Collection(
      name: "user_list",
      to_json: user_to_json,
      decoder: user_decoder(),
      config:,
    )

  Ok(items)
}

type WriteUsernameError {
  UsernameExists
  StorailError(error: storail.StorailError)
}

fn write_user(
  db db: storail.Collection(User),
  new user: User,
  new_username username: String,
) -> Result(Nil, WriteUsernameError) {
  let key = storail.key(db, username)
  case storail.read(key) {
    Ok(_) -> Error(UsernameExists)
    Error(_) -> storail.write(key, user) |> result.map_error(StorailError)
  }
}

fn read_user(db: storail.Collection(User), username: String) {
  storail.key(db, username) |> storail.read
}
