module Model exposing (..)


type alias Card =
    { id : String, state : CardState }


type CardState
    = Open
    | Closed
    | Matched


type alias Model =
    { cards : List Card }


type Msg
    = CardClick Card
