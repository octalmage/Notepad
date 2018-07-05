port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode


main =
    Html.program
        { init = init ""
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { text : String
    , title : String
    , maximized : Bool
    }


init : String -> ( Model, Cmd Msg )
init text =
    ( Model text "Untitled - Notepad" False
    , Cmd.none
    )



-- UPDATE


type Msg
    = UpdateText String
    | Maximize
    | Minimize
    | Close
    | UpdateMaximize Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( { model | text = text }, Cmd.none )

        Maximize ->
            ( model, windowEvents "maximize" )

        Minimize ->
            ( model, windowEvents "minimize" )

        Close ->
            ( model, windowEvents "close" )

        UpdateMaximize status ->
            ( { model | maximized = status }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [ id "titlebar" ]
            [ div [ id "titlebarIcon" ]
                [ img [ src "assets/img/titlebar/icon.png" ] []
                ]
            , div
                [ id "titlebarTitle" ]
                [ text model.title ]
            , div [ id "titlebarClose", onClick Close ]
                [ img [ src "assets/img/titlebar/close.png" ] []
                ]
            , div [ id "titlebarMaximize", onClick Maximize ]
                [ img [ src "assets/img/titlebar/maximize.png" ] []
                ]
            , div [ id "titlebarMinimize", onClick Minimize ]
                [ img [ src "assets/img/titlebar/minimize.png" ] []
                ]
            ]
        , div [ id "menubar" ]
            [ div [ id "fileMenu", class "menubarItem" ] [ text "File" ]
            , div [ id "editMenu", class "menubarItem" ] [ text "Edit" ]
            , div [ id "formatMenu", class "menubarItem" ] [ text "Format" ]
            , div [ id "viewMenu", class "menubarItem" ] [ text "View" ]
            , div [ id "helpMenu", class "menubarItem" ] [ text "Help" ]
            ]
        , textarea [ id "mainText", onInput UpdateText ] [ text model.text ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    maximizeStatus UpdateMaximize



-- PORTS


port windowEvents : String -> Cmd msg


port maximizeStatus : (Bool -> msg) -> Sub msg



-- HTTP
