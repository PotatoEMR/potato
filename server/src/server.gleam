import argus
import fhir/hl7_fhir_us_core_7_0_0/client_httpc
import fhir/hl7_fhir_us_core_7_0_0/complex_types.{List1}
import fhir/hl7_fhir_us_core_7_0_0/resources
import fhir/hl7_fhir_us_core_7_0_0/sansio
import gleam/dynamic/decode
import gleam/erlang/process
import gleam/http.{Get, Post}
import gleam/http/request
import gleam/http/response
import gleam/httpc
import gleam/int
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
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

  let assert Ok(users) = setup_user_database()

  let assert Ok(priv_directory) = wisp.priv_directory("server")

  let assert Ok(_) =
    handle_request(users, priv_directory, _)
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
  users: storail.Collection(User),
  static_directory: String,
  request: Request,
) -> Response {
  use request <- app_middleware(request, static_directory)

  case request.method, wisp.path_segments(request) {
    Get, [] -> serve_index(request)
    Get, ["auth", "signup"] -> serve_signup(None)
    Post, ["auth", "signup"] -> handle_signup(users, request)
    Get, ["auth", "login"] -> serve_login(None)
    Post, ["auth", "login"] -> handle_login(users, request)
    _, ["api", ..rest_path] -> {
      case wisp.get_cookie(request:, name: "username", security: wisp.Signed) {
        Error(_) -> simple_resp("need to log in", 401)
        Ok(username) -> {
          case read_user(users, username) {
            Ok(user) ->
              case user.role {
                Practitioner -> {
                  forward_to_fhir_server(request, rest_path)
                }
                Patient -> {
                  echo "need to check if allowed maybe start with https://hl7.org/fhir/R4/compartmentdefinition.html#bnr"
                  todo
                }
              }
            Error(_) -> simple_resp("invalid cookie username", 500)
          }
        }
      }
    }
    _, _ -> wisp.not_found()
  }
}

fn forward_to_fhir_server(
  from original: request.Request(wisp.Connection),
  to_fhir_endpoint rest_path: List(String),
) -> response.Response(wisp.Body) {
  use body <- wisp.require_string_body(original)
  // copying or not copying host/port explicitly
  // https://discord.com/channels/768594524158427167/1047099923897794590/threads/1553011371073867876
  case
    request.Request(
      method: original.method,
      query: original.query,
      body:,
      // need to get rid of this header
      // #("accept-encoding", "gzip, deflate, br, zstd")
      // otherwise fhir server returns some non utf-8 response which httpc errors on
      // although maybe keeping response compressed from fhir server -> wisp server -> back to client would perform better
      // if it's supported in httpc or another http client
      headers: [
        #("accept", "application/fhir+json"),
        #("content-type", "application/fhir+json"),
      ],
      path: ["fhir", ..rest_path] |> string.join("/"),
      scheme: http.Http,
      host: "localhost",
      port: Some(8080),
    )
    |> httpc.send
  {
    Ok(fhir_response) ->
      wisp.json_response(fhir_response.body, fhir_response.status)
    Error(err) ->
      case err {
        httpc.InvalidUtf8Response ->
          simple_resp("invalid utf-8 from fhir server", 502)
        httpc.FailedToConnect(_ip4, _ip6) ->
          simple_resp("could not connect to fhir server", 502)
        httpc.ResponseTimeout ->
          simple_resp("timed out connecting to fhir server", 504)
      }
  }
}

fn simple_resp(text: String, status: Int) {
  text
  |> json.string
  |> json.to_string
  |> wisp.json_response(status)
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
    h.html(
      [
        a.styles(full),
        a.style(
          "font-family",
          "ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\"",
        ),
        a.style("background-image", "url('/static/potato-bg.jpg')"),
        a.style("background-repeat", "no-repeat"),
        a.style("background-attachment", "fixed"),
        a.style("background-size", "cover"),
      ],
      [
        h.head([], potatoemr()),
        h.body(
          [
            a.style("display", "flex"),
            a.style("justify-content", "center"),
            a.style("align-items", "center"),
            a.styles(full),
          ],
          [
            h.main(
              [
                a.style("width", "20em"),
                a.style("height", "20em"),
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
                      a.required(True),
                      a.style("padding", "5px"),
                      a.name("username"),
                      a.placeholder("username"),
                    ]),
                    h.input([
                      a.required(True),
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
      ],
    )

  html
  |> element.to_document_string
  |> wisp.html_response(200)
}

fn serve_index(request) -> Response {
  case wisp.get_cookie(request:, name: "username", security: wisp.Signed) {
    Error(_) -> wisp.redirect(to: "/auth/login")
    Ok(username) -> {
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
  }
}

fn serve_signup(error_msg: Option(String)) -> Response {
  auth_shell(
    [
      h.div(
        [
          a.style("display", "flex"),
          a.style("gap", "5px"),
        ],
        [
          h.input([
            a.style("flex", "1"),
            a.style("min-width", "0"),
            a.style("padding", "5px"),
            a.name("first_name"),
            a.placeholder("firstname"),
          ]),
          h.input([
            a.style("flex", "1"),
            a.style("min-width", "0"),
            a.style("padding", "5px"),
            a.name("last_name"),
            a.placeholder("lastname"),
            a.required(True),
          ]),
        ],
      ),
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
  form: wisp.FormData,
  next: fn(#(String, String)) -> Response,
) -> Response {
  case
    find_form_name(form.values, "username"),
    find_form_name(form.values, "password")
  {
    Ok(username), Ok(password) -> next(#(username, password))
    _, _ -> wisp.bad_request("wrong params")
  }
}

fn find_form_name(values: List(#(String, String)), name) {
  case list.find(values, fn(value) { value.0 == name && value.1 != "" }) {
    Ok(val) -> Ok(val.1)
    Error(_) -> Error(Nil)
  }
}

fn as_list1(item) {
  List1(first: item, rest: [])
}

fn handle_signup(users: storail.Collection(User), req: Request) -> Response {
  use form <- wisp.require_form(req)
  use #(username, password) <- require_username_password(form)
  let assert Ok(client) = sansio.fhirclient_new("127.0.0.1:8080/fhir")
  let client =
    sansio.FhirClient(..client, print_sent_requests: sansio.LoggingOn)
  let potatoemr_username =
    resources.us_core_practitioner_identifier_new(
      "https://potatoemr.com/system/username",
      username,
    )
    |> resources.UsCorePractitionerIdentifierComponentOpen
    |> as_list1
  case find_form_name(form.values, "last_name") {
    Error(_) -> serve_signup(Some("last name required"))
    Ok(last_name) -> {
      let given = find_form_name(form.values, "first_name")
      let name = resources.us_core_practitioner_name_new(family: last_name)
      let name =
        case given {
          Error(_) -> name
          Ok(first_name) ->
            resources.UsCorePractitionerName(..name, given: [first_name])
        }
        |> as_list1
      let new_practitioner =
        echo resources.us_core_practitioner_new(potatoemr_username, name)
      let new_practitioner =
        client_httpc.us_core_practitioner_create(new_practitioner, client)
      case new_practitioner {
        Error(err) -> {
          echo err
          serve_signup(Some(
            "Unable to create new user. Perhaps FHIR server is not running. Try /potato/hapi/download_and_run.sh",
          ))
        }
        Ok(new_practitioner) -> {
          case new_practitioner.id {
            None ->
              serve_signup(Some(
                "very strange, FHIR server created practitioner but did not assign ID",
              ))
            Some(id) -> {
              let assert Ok(hashes) =
                argus.hasher()
                |> argus.hash(password)
              let password_hash = hashes.encoded_hash
              let new_user = User(password_hash:, id:, role: Practitioner)
              case write_user(users, new_user, username) {
                Ok(_) -> wisp.redirect("/") |> set_user_cookie(req, username)
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
          }
        }
      }
    }
  }
}

fn handle_login(users: storail.Collection(User), req: Request) -> Response {
  use form <- wisp.require_form(req)
  use #(username, password) <- require_username_password(form)
  case read_user(users, username) {
    Ok(user) -> {
      case argus.verify(user.password_hash, password) {
        Ok(True) -> wisp.redirect("/") |> set_user_cookie(req, username)
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
  to users: storail.Collection(User),
  write user: User,
  new_username username: String,
) -> Result(Nil, WriteUsernameError) {
  let key = storail.key(users, username)
  case storail.read(key) {
    Ok(_) -> Error(UsernameExists)
    Error(_) -> storail.write(key, user) |> result.map_error(StorailError)
  }
}

fn read_user(from users: storail.Collection(User), read username: String) {
  storail.key(users, username) |> storail.read
}
