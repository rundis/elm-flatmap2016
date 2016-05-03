module BHtml where

import String
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal
import StartApp.Simple as StartApp
import Native.Signal as NSig



-- MODEL

type alias Model =
  {name : String}


initialModel : Model
initialModel =
  Model "Flatmap"


-- Update

type Action
  = NoOp
  | SetName String


update :  Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetName n ->
      { model | name = String.toUpper n }



-- VIEW

view : Signal.Address Action -> Model -> Html
view  address model =
  div
    []
    [ input
        [value model.name
        ,on "input" targetValue (\str -> Signal.message address <| SetName str) ]
        []
    , p [] [text ("Hello " ++ model.name)]
    ]


-- Wiring
{- actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


model : Signal Model
model = Signal.foldp update initialModel actions.signal


main : Signal Html
main = Signal.map (view actions.address) model
 -}

-- Alt
main : Signal Html
main = StartApp.start
        { model = initialModel
        , update = update
        , view = view
        }


