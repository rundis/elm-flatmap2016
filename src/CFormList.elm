module CFormList where


import Html exposing (..)
import Html.Attributes exposing (class, value, placeholder)
import Html.Events exposing (..)
import StartApp.Simple as StartApp

import CForm


type alias Model =
  { forms : List (FormId, CForm.Model)
  , nextFormId : FormId
  }

type alias FormId = Int

initialModel : Model
initialModel =
  Model [(0, CForm.pristine)] 1

-- Update

type Action
  = NoOp
  | Add
  | FormAction FormId CForm.Action


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Add ->
      {model | nextFormId = model.nextFormId + 1
             , forms = List.append model.forms [(model.nextFormId, CForm.pristine)]}

    FormAction formId formAction ->
      let
        updateForm (id, formModel) =
          if id == formId then
            (id, CForm.update formAction formModel)
          else
            (id, formModel)
      in
        { model | forms = List.map updateForm model.forms }


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [table
      [class "table table-striped"]
      (List.map (formRow address) model.forms)
    , button
        [class "btn btn-default"
        , onClick address Add
        ]
        [text "Add"]]


formRow : Signal.Address Action -> (FormId, CForm.Model) -> Html
formRow address (formId, formModel) =
  tr
    []
    [ td
        []
        [CForm.view (Signal.forwardTo address (FormAction formId)) formModel]
    ]


main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , update = update
    , view = view
    }
