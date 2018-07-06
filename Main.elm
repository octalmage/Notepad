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


type Menu
    = File
    | Edit
    | Format
    | View
    | Help


enumMenu : List Menu
enumMenu =
    [ File, Edit, Format, View, Help ]



-- MODEL


type alias Model =
    { text : String
    , title : String
    , maximized : Bool
    , selectedMenu : Maybe Menu
    }


init : String -> ( Model, Cmd Msg )
init text =
    ( Model text "Untitled - Notepad" False Nothing
    , Cmd.none
    )



-- UPDATE


type Msg
    = UpdateText String
    | Maximize
    | Minimize
    | Close
    | UpdateMaximize Bool
    | OpenMenu (Maybe Menu)
    | ClickedOutside String


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

        OpenMenu menuItem ->
            ( { model | selectedMenu = menuItem }, Cmd.none )

        ClickedOutside element ->
            let
                dummy =
                    Debug.log "element" element
            in
            ( model, Cmd.none )



-- VIEW
-- onClick : msg -> Attribute msg
-- onClick message =
--     onWithOptions
--         "click"
--         { stopPropagation = True
--         , preventDefault = False
--         }
--         (Decode.succeed message)


targetElement : Decode.Decoder String
targetElement =
    Decode.at [ "target" ] Decode.string


onClickEverywhere : (String -> msg) -> Attribute msg
onClickEverywhere tagger =
    on "input" (Decode.map tagger targetElement)


view : Model -> Html Msg
view model =
    div [ onClickEverywhere ClickedOutside ]
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
                [ img
                    [ src
                        (case model.maximized of
                            True ->
                                "assets/img/titlebar/unmaximize.png"

                            False ->
                                "assets/img/titlebar/maximize.png"
                        )
                    ]
                    []
                ]
            , div [ id "titlebarMinimize", onClick Minimize ]
                [ img [ src "assets/img/titlebar/minimize.png" ] []
                ]
            ]
        , div [ id "menubar" ]
            [ div [ id "fileMenu", class "menubarItem", onClick (OpenMenu (Just File)) ] [ text "File" ]
            , div
                [ classList
                    [ ( "dropdown-content", True )
                    , ( "show", model.selectedMenu == Just File )
                    ]
                ]
                [ a [ href "#" ] [ text "New" ]
                , a [ href "#" ] [ text "Open" ]
                , a [ href "#" ] [ text "Save" ]
                ]
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



-- INCOMING PORTS


port maximizeStatus : (Bool -> msg) -> Sub msg



-- OUTGOING PORTS


port windowEvents : String -> Cmd msg



-- HTTP
