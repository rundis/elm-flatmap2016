module Utils where

import Html exposing (..)
import Html.Attributes exposing (..)
import String

css : String -> Html
css path =
  node "link" [ rel "stylesheet", href path ] []

bsCss : Html
bsCss  = css "bootstrap.min.css"


bsInput : String -> List Html.Attribute -> List Html -> Html
bsInput label' attr children =
  div
    [ class "form-group" ]
    [ label [class "control-label"] [text label']
    , input (List.append [class "form-control"] attr) children
    ]


toStr : Maybe Int -> String
toStr val =
  Maybe.map toString val |> Maybe.withDefault ""


maybeAge : Maybe Int -> String -> Maybe Int
maybeAge current newAge =
  case (current, String.toInt newAge |> Result.toMaybe) of
    (Just curr, Nothing ) ->
      if newAge == "" then Nothing else Just curr
    (_, Just new) ->
      Just new
    (_, _) ->
      Nothing


loginForm : Html
loginForm =
  div
    [ class "container-fluid" ]
    [ bsCss
    , h1 [] [ text "Login Form" ]
    , Html.form
        []
        [ bsInput
            "Username"
            []
            []
        , bsInput
            "Password"
            []
            []
        , button
            [ class "btn btn-default" ]
            [ text "Login" ]
        ]
    ]
