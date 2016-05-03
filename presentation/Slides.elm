module Slides (slides, update, view, inputs) where

import Html exposing (Html, h1, img, text, ul, li, a, p, div, small, span)
import Html.Attributes exposing (href, style, src, class)
import SliceShow.Slide exposing (..)
import SliceShow.Content exposing (..)
import Markdown
import Effects exposing (Effects)
import Time exposing (Time)


{- Model type of the custom content -}
type alias Model = Time


{- Action type for the custom content -}
type alias Action = Time


{- Update function for the custom content -}
update : Action -> Model -> (Model, Effects Action)
update elapsed time =
  (time + elapsed, Effects.none)


{- View function for the custom content that shows elapsed time for the slide -}
view : Signal.Address Action -> Model -> Html
view _ time =
  small
    [ style [("position", "absolute"), ("bottom", "0"), ("right", "0")] ]
    [ text
        ( "the slide is visible for " ++
          (Time.inSeconds time |> round |> toString) ++
          " seconds"
        )
    ]


{- Inputs for the custom content -}
inputs : List (Signal Action)
inputs = [Time.fps 1]


{- The list of slides -}
slides : List (Slide Action)
slides =
  [ [ item <| h1 [] [ text "Functional Reactive Programming for the Web using Elm" ]
    , item <| p [style [("margin-bottom", "10px")]] [ text "Magnus Rundberget" ]
    , item <| div
                [style [("display", "flex"), ("height", "20px"), ("align-items", "center")]]
                [img [src "assets/twitter.png"] []
                , span [style [("font-size", "15px")]] [text "@mrundberget"]
                ]
    ]
  , [ item <| h1 [] [ text "Agenda" ]
    , bullets
        [ bullet "About Elm" |> hide
        , bullet "Functional Reactive Programming and Signals" |> hide
        , bullet "Diving into The Elm Architecture (Live coding)" |> hide
        , bullet "The Elm Platform and ecosystem" |> hide
        , bullet "Summary" |> hide
        ]
    ]
  , [ item <| h1 [] [ text "About me" ]
    , item
        <| img
            [ src "assets/magnus.png"
            , style [ ( "position", "absolute" ), ( "left", "50%" ), ( "margin-left", "-250px" ) ]
            ]
            []
    ]
  , [ item <| h1 [] [ text "What is Elm ?" ]
    , bullets
        [ bullet "Created by Evan Czaplicki (2012)" |> hide
        , bullet "Functional and statically typed" |> hide
        , bullet "ML family syntax" |> hide
        , bullet "Compiles to JavaScript (ES5)" |> hide
        ]
    ]
  , [ item <| h1 [] [ text "Goals ?" ]
    , item <| p [ style [ ( "font-style", "italic" ) ] ]
                [ text "Make Functional Programming (with types) for the Web mainstream"]
    , bullets
        [ bullet "Easy to learn and become productive, yet powerful" |> hide
        , bullet "Reliable - No runtime exceptions !" |> hide
        , bullet "The compiler should be a helpful assistant" |> hide
        , bullet "Manage complexity by embracing best of FP properties" |> hide
        ]
    , (item <| p [ style [( "font-style", "italic" ), ("margin-top", "100px"), ("color", "blue")]]
                 [ text "Do check out: \"Let's be mainstream, User-focused design in Elm\" (Evan Czaplicki)" ]) |> hide
    ]
  , [ item <| h1 [] [ text "Functional Reactive Programming" ]
    , item <| p [ style [ ( "font-style", "italic" ) ] ] [ Markdown.toHtml "a programming paradigm for reactive programming (**asynchronous dataflow** programming) using the building blocks of functional programming (e.g. map, reduce, filter). FRP has been used for programming graphical user interfaces (GUIs), robotics, and music, aiming to simplify these problems by **explicitly modeling time**" ]
    ]
  , [ item <| h1 [] [ text "FRP example" ]
    , (item <| img [ src "assets/frp1.png", style [ ( "margin-left", "-100px" ) ] ] []) |> hide
    , (item <| img [ src "assets/frp2.png", style [ ( "margin-left", "-100px" ) ] ] []) |> hide
    , (item <| img [ src "assets/frp3.png", style [ ( "margin-left", "-100px" ) ] ] []) |> hide
    , (item <| img [ src "assets/frp4.png", style [ ( "margin-left", "-100px" ) ] ] []) |> hide
    ]
  , [ item <| h1 [] [ text "Signals in Elm" ]
    , column
        [ style [ ( "display", "flex" ) ] ]
        [ column
            [ style [ ( "width", "80%" ) ] ]
            [ bullets
                [ bullet "Signal is a value that changes over time" |> hide
                , bullet "Known/computed at compile time" |> hide
                , bullet "Forms a static Signal graph" |> hide
                , bullet "Not allowed to change at runtime" |> hide
                ]
            ]
        , column
            []
            [ item <| img [ src "assets/signalgraph.png", style [ ( "height", "450px" ) ] ] [] ]
        ]
    ]
  , [ item <| h1 [] [ text "The Elm Architecture"]
    , item <| img [src "assets/tea.png"] []
    ]
  , [ item <| h1 [] [ text "Live Coding" ]
    , item
        <| div
            [ style [ ( "display", "flex" ), ( "justify-content", "center" ) ] ]
            [ img [ src "assets/demo.png" ] [] ]
    ]
  , [ item <| h1 [] [ text "The Elm platform and ecosystem"]
    , bullets
        [ bullet "elm-make" |> hide
        , bullet "elm-repl" |> hide
        , bullet "elm-reactor" |> hide
        , bullet "elm-package" |> hide
        , subBullets
            [ bullet "Community"
            ,  bullets
                [ bullet "elm-format"
                , bullet "editor plugins - Vim, Emacs, VSCode, Light Table (yours truly), Sublime, Atom"
                , bullet "Packages, node integrations and much more"
                ]
            ] |> hide
        ]
    ]
  , [ item <| h1 [] [ text "JavaScript interop"]
    , column
        [ style [("display", "flex")]]
        [ column
            [style [("width", "40%")]]
            [item <| img [src "assets/ports.png"] []]
        , column
            [style [("width", "60%")]]
            [ bullets
                [ bullet "Customs and border protection" |> hide
                , bullet "Conversion of JS to Elm types and vice versa" |> hide
                , bullet "Safe guard against runtime exceptions in your Elm app" |> hide
                ]
            ]
        ]
    ]
  , [ item <| h1 [] [ text "Future of Elm" ]
    , bullets
        [ bullet "Next version" |> hide
        , bullet "UI Components" |> hide
        , bullet "Ready for production use ?" |> hide
        ]
    ]
  , [ item <| h1 [] [ text "Summary" ]
    , bullets
        [ bullet "Elm is an exciting and friendly language" |> hide
        , bullet "Elm makes Functional Reactive Programming surprisingly approachable" |> hide
        , bullet "The Elm Architecture is a promising solution for composing scalable architectures" |> hide
        ]
    , p [] [text "It’s fun and well worth a closer look !"] |> item |> hide
    ]
  ]
    |> List.map paddedSlide



centeredText : String -> Content b
centeredText str =
  div
    [ style
        [ ( "position", "absolute" )
        , ( "left", "0" )
        , ( "right", "0" )
        , ( "top", "0" )
        , ( "bottom", "0" )
        , ("padding", "50px 100px")
        , ( "text-align", "center" )
        , ( "display", "flex" )
        , ( "align-items", "center" )
        ]
    ]
    [ div [] [ text str ] ]
    |> item


column : List Html.Attribute -> List (Content Model) -> Content Model
column attr =
  container (div attr)


bullets : List (Content Model) -> Content Model
bullets =
  container (ul [])

subBullets : List (Content Model) -> Content Model
subBullets =
  container (li [])


bullet : String -> Content Model
bullet str =
  item (li [] [text str])


bulletLink : String -> String -> Content Model
bulletLink str url =
  item (li [] [a [href url] [text str]])


{- Syntax higlighted code block, needs highlight.js in index.html -}
code : String -> String -> Content Model
code lang str =
  item (Markdown.toHtml ("```" ++ lang ++ "\n" ++ str ++ "\n```"))


{- Custom slide that sets the padding and appends the custom content -}
paddedSlide : List (Content Model) -> Slide Model
paddedSlide content =
  slide
    [ container
        (div [style [("padding", "50px 100px")]])
        content --(content ++ [custom 0])
    ]
