module CForm where


import Html exposing (..)
import Html.Attributes exposing (class, value, placeholder, type')
import Html.Events exposing (..)
import String
import StartApp.Simple as StartApp




import Utils


type alias Model =
  { name : String
  , age : Maybe Int
  , status : Status
  }

type Status = Pristine | Changed


pristine : Model
pristine =
  Model "" Nothing Pristine



-- Update
type Action
  = NoOp
  | SetName String
  | SetAge String


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetName newName ->
      { model | name = newName, status = Changed }

    SetAge newAge ->
      { model | age = Maybe.oneOf [ String.toInt newAge |> Result.toMaybe, model.age ]
              , status = Changed }


-- View


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "container-fluid" ]
    [ Utils.css "bootstrap.min.css"
    , h2 [] [text "Person"]
    , form
        []
        [ Utils.bsInput
            "Name"
            [ value model.name
            , on "input" targetValue (\str -> Signal.message address (SetName str))
            ]
            []
        , Utils.bsInput
            "Age"
            [ value (Utils.toStr model.age)
            , on "input" targetValue (\str -> Signal.message address (SetAge str))
            ]
            []
        ]
    , p [] [text (model.name ++ ", " ++ (Utils.toStr model.age) ++ " : " ++ (toString model.status))]
    ]


{- actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


model : Signal Model
model =
  Signal.foldp update pristine actions.signal
 -}

main : Signal Html
main =
  StartApp.start
    { model = pristine
    , update = update
    , view = view
    }
  --Signal.map (view actions.address) model



--- LOGIN FORM
{-
type alias Model =
  { userName : String
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


type Action
  = NoOp
  | SetUserName String
  | SetPassword String
  | Login


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetUserName new ->
      { model | userName = new }

    SetPassword  new ->
      { model | password = new }

    Login ->
      if model.password == "secret" then
        { model | loginStatus = Success, password = "" }
      else
        { model | loginStatus = Error "Invalid username and/or password" }


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "container-fluid"]
    ([ Utils.bsCss
     , h1 [] [text "Login"]
     ] ++ loginView address model)



loginView : Signal.Address Action -> Model -> List Html
loginView address model =
  case model.loginStatus of
    None ->
      [ loginForm address model ]

    Success ->
      [ div
          [ class "alert alert-success" ]
          [ text ("Welcome: " ++ model.userName) ] ]

    Error msg ->
      [ div [ class "alert alert-danger" ] [ text msg ]
      , loginForm address model
      ]


loginForm : Signal.Address Action -> Model -> Html
loginForm address model =
  form
    []
    [ Utils.bsInput
        "Username"
        [ value model.userName
        , on "input" targetValue (\str -> Signal.message address (SetUserName str))
        ]
        []
    , Utils.bsInput
        "Password"
        [ value model.password
        , type' "password"
        , on "input" targetValue (\str -> Signal.message address (SetPassword str))
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


-}
