module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import List exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = { cards = cards }, view = viewCards, update = update }


cards : List Card
cards =
    [ { id = "1", state = Closed }, { id = "2", state = Closed }, { id = "3", state = Closed } ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        CardClick card ->
            updateCardsModel model card


updateCardsModel : Model -> Card -> Model
updateCardsModel model card =
    { model | cards = updateCardInList model.cards card }


updateCardInList : List Card -> Card -> List Card
updateCardInList cards card =
    List.map (\c -> updateCard c card) cards


updateCard : Card -> Card -> Card
updateCard orgCard newCard =
    if orgCard.id == newCard.id then
        updateCardState newCard
    else
        orgCard


updateCardState : Card -> Card
updateCardState card =
    case card.state of
        Open ->
            { card | state = Closed }

        Closed ->
            { card | state = Open }

        Matched ->
            card


viewCards : Model -> Html Msg
viewCards model =
    List.map viewCard model.cards |> div []


viewCard : Card -> Html Msg
viewCard card =
    img [ cardClass card |> class, cardImage card |> src, onClick (CardClick card) ] []


cardImage : Card -> String
cardImage card =
    case card.state of
        Closed ->
            "/static/cats/closed.png"

        _ ->
            "static/cats/" ++ card.id ++ ".jpg"


cardClass : Card -> String
cardClass card =
    case card.state of
        Open ->
            "open"

        Closed ->
            "closed"

        Matched ->
            "matched"


setCard : CardState -> Card -> Card
setCard state card =
    { card | state = state }
