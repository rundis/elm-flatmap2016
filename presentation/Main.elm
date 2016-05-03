
import Html exposing (Html)
import Task exposing (Task)
import Effects exposing (Never)
import SliceShow exposing (..)
import Slides exposing (slides, update, view, inputs)


sliceShow : SliceShow
sliceShow =
  init slides
    |> setDimensions windowDimensions
    |> setHash locationHash
    |> setInputs inputs
    |> setUpdate update
    |> setView view
    |> show


main : Signal Html
main = sliceShow.html


port tasks : Signal (Task Never ())
port tasks = sliceShow.tasks


port windowDimensions : (Int, Int)


port locationHash : String

