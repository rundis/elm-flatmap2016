module Form where


import Html exposing (..)
import Html.Attributes exposing (class, value, placeholder, type')
import Html.Events exposing (..)
import StartApp.Simple as StartApp
import Utils


-- Model

type alias Model =
  { username : String
  , password : String
  , loginStatus : LoginStatus
  }


type LoginStatus
  = None
  | Success
  | Error String


initialModel : Model
initialModel =
  Model "" "" None


-- Update

type Action
  = NoOp
  | SetUsername String
  | SetPassword String
  | Login


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetUsername v ->
      { model | username = v }

    SetPassword v ->
      { model | password = v }

    Login ->
      if model.password == "secret" then
        { model | loginStatus = Success, password = ""}

      else
        { model | loginStatus = Error "invalid username/password" }


-- View
view : Signal.Address Action -> Model -> Html
view address model =
  div
    [class "container-fluid"]
    ( [Utils.bsCss
      , h1 [] [text "Login Form For Realz "]] ++ loginView address model)


loginView : Signal.Address Action -> Model -> List Html
loginView address model =
  case model.loginStatus of
    None ->
      [ loginForm address model ]

    Success ->
      [ div
          [ class "alert alert-success" ]
          [ text ("Welcome: " ++ model.username) ] ]

    Error msg ->
      [ div [ class "alert alert-danger" ] [ text msg ]
      , loginForm address model
      ]


loginForm : Signal.Address Action -> Model -> Html
loginForm address model =
  let
    onInput action =
      on "input" targetValue (\s -> Signal.message address (action s))
  in
    form
      []
      [ Utils.bsInput
          "Username"
          [ value model.username
          , onInput SetUsername
          ]
          []
      , Utils.bsInput
          "Password"
          [ value model.password
          , type' "password"
          , onInput SetPassword
          ]
          []
      , button
          [ class "btn btn-default"
          , type' "button"
          , onClick address Login
          ]
          [text "Login"]
      ]


actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp



model : Signal Model
model =
  Signal.foldp update initialModel actions.signal




main : Signal Html
main =
  Signal.map (view actions.address) model





{- main : Html
main =
  --div [] [h1 [] [text "Login Form Demo"]]
  Utils.loginForm
 -}

























































