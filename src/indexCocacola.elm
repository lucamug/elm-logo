module Main exposing (..)

import Color
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import LogoCocacola as Logo
import LogoCocacolaIntrospection as LogoIntrospection


-- import LogoElm as Logo
-- import LogoElmIntrospection as LogoIntrospection


type alias Model =
    { logoType : Logo.Type
    , logoSize : Logo.Size
    , backgroundColor : Color.Color
    }


init : ( Model, Cmd msg )
init =
    ( { logoType = LogoIntrospection.logoTypeDefault
      , logoSize = 64
      , backgroundColor = Color.white
      }
    , Cmd.none
    )


type Msg
    = SelectLogoType Logo.Type
    | SelectLogoSize Logo.Size
    | SelectLogoSizeFromInput String
    | SelectBackgroundColor Color.Color


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        SelectLogoType logoType ->
            ( { model | logoType = logoType }, Cmd.none )

        SelectLogoSize logoSize ->
            ( { model | logoSize = logoSize }, Cmd.none )

        SelectLogoSizeFromInput logoSizeString ->
            let
                size =
                    String.toInt logoSizeString
            in
            case size of
                Ok sizeInt ->
                    ( { model | logoSize = sizeInt }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        SelectBackgroundColor backgroundColor ->
            ( { model | backgroundColor = backgroundColor }, Cmd.none )



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


view : Model -> Html Msg
view model =
    div
        []
        [ node "style" [] [ text css ]
        , h1 [ class "widthSideMargins" ]
            [ text "elm "
            , span [ class "important" ] [ text "logo" ]
            ]
        , div [ class "elmLogoContainer widthSideMargins" ]
            [ div
                [ class "elmLogo"
                , style [ ( "backgroundColor", colorToCssRgb model.backgroundColor ) ]
                ]
                [ Logo.logo model.logoType model.logoSize
                ]
            , text <| "logo " ++ LogoIntrospection.convertLogoTypeToString model.logoType ++ " " ++ toString model.logoSize
            ]
        , div [ class "widthSideMargins" ]
            [ h2 [] [ text "Type" ]
            , div []
                (List.map
                    (\logoType ->
                        div
                            [ class "clickable"
                            , style
                                [ ( "display", "inline-block" )
                                , ( "height", "32px" )
                                ]
                            , onClick (SelectLogoType logoType)
                            ]
                            [ --text <| convertLogoTypeToString logoType
                              Logo.logo logoType 32
                            ]
                    )
                    LogoIntrospection.logoTypes
                )
            ]
        , div [ class "widthSideMargins" ]
            [ h2 [] [ text "Size" ]
            , div []
                (List.map
                    (\logoSize ->
                        let
                            height =
                                toString logoSize

                            width =
                                toString <| floor <| toFloat logoSize * Logo.ratio
                        in
                        div
                            [ class "clickable"
                            , style
                                [ ( "display", "inline-block" )
                                , ( "height", height ++ "px" )
                                , ( "width", width ++ "px" )
                                , ( "border", "1px solid #ddd" )
                                , ( "text-align", "center" )
                                ]
                            , onClick (SelectLogoSize logoSize)
                            ]
                            [ --text <| convertLogoTypeToString logoType
                              text <| width ++ " x " ++ height
                            ]
                    )
                    logoSizes
                )
            , input
                [ type_ "number"
                , value <| toString model.logoSize
                , onInput SelectLogoSizeFromInput
                ]
                []
            ]
        , div [ class "widthSideMargins" ]
            [ h2 [] [ text "Background" ]
            , div []
                (List.map
                    (\( backgroundColor, colorName ) ->
                        div
                            [ class "clickable"
                            , style
                                [ ( "display", "inline-block" )
                                , ( "background-color", colorToCssRgb backgroundColor )
                                , ( "width", "16px" )
                                , ( "height", "16px" )
                                ]
                            , onClick (SelectBackgroundColor backgroundColor)
                            ]
                            []
                    )
                    colors
                )
            , input
                [ type_ "text"
                , value <| colorToCssRgb model.backgroundColor
                ]
                []
            ]
        , h2 [ class "widthSideMargins" ] [ text "Combinations" ]
        , logoCombinations
        , a [ href "https://github.com/lucamug/elm-logo" ]
            [ img
                [ style [ ( "position", "absolute" ), ( "top", "0" ), ( "right", "0" ), ( "border", "0" ) ]
                , src "https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67"
                , alt "Fork me on GitHub"
                ]
                []
            ]
        , lucamug
        ]


logoSizes : List Logo.Size
logoSizes =
    [ 16
    , 32
    , 48
    , 64
    , 80
    ]


colors : List ( Color.Color, String )
colors =
    [ ( Color.white, "white" )
    , ( Color.lightGray, "light gray" )
    , ( Color.gray, "gray" )
    , ( Color.darkGray, "dark gray" )
    , ( Color.lightCharcoal, "light charcoal" )
    , ( Color.charcoal, "charcoal" )
    , ( Color.darkCharcoal, "dark charcoal" )
    , ( Color.black, "black" )
    , ( Color.lightYellow, "light yellow" )
    , ( Color.lightOrange, "light orange" )
    , ( Color.lightGreen, "light green" )
    , ( Color.lightRed, "light red" )
    , ( Color.lightBlue, "light blue" )
    , ( Color.lightPurple, "light purple" )
    , ( Color.lightBrown, "light brown" )
    , ( Color.darkYellow, "dark yellow" )
    , ( Color.darkOrange, "dark orange" )
    , ( Color.darkGreen, "dark green" )
    , ( Color.darkRed, "dark red" )
    , ( Color.darkBlue, "dark blue" )
    , ( Color.darkPurple, "dark purple" )
    , ( Color.darkBrown, "dark brown" )
    ]


logoCombinations : Html msg
logoCombinations =
    div
        []
        (List.map
            (\( color, colorText ) -> logoTest color colorText)
            colors
        )


logoTest : Color.Color -> String -> Html msg
logoTest color name =
    let
        cssRgb =
            colorToCssRgb color

        ( textColor, secondaryColor ) =
            if luminance color < 160 then
                ( "#eee", "#bbb" )
            else
                ( "#333", "#777" )
    in
    div
        [ class "logoContainer"
        , style
            [ ( "background-color", cssRgb ) ]
        ]
        [ h2
            [ class "widthSideMargins", style [ ( "color", textColor ) ] ]
            [ text <| "on " ++ name
            , span
                [ style
                    [ ( "color", secondaryColor )
                    , ( "font-size", "16px" )
                    , ( "display", "inline-block" )
                    , ( "padding-left", "40px" )
                    ]
                ]
                [ text <| " " ++ cssRgb
                , text " luminance "
                , text <| toString <| floor <| luminance color
                ]
            ]
        , div [ class "svgsContainer" ]
            (List.map
                (\item -> div [ class "svgContainer" ] [ item ])
                (logoSeries 60)
            )
        ]


luminance : Color.Color -> Float
luminance color =
    let
        { red, green, blue, alpha } =
            Color.toRgb color
    in
    0.299 * toFloat red + 0.587 * toFloat green + 0.114 * toFloat blue


logoSeries : Logo.Size -> List (Html msg)
logoSeries size =
    List.map (\logoType -> Logo.logo logoType size) LogoIntrospection.logoTypes


colorToCssRgb : Color.Color -> String
colorToCssRgb color =
    let
        { red, green, blue, alpha } =
            Color.toRgb color
    in
    String.join ""
        [ "rgb("
        , String.join ","
            [ toString red
            , toString green
            , toString blue
            ]
        , ")"
        ]


css : String
css =
    """
@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro');
body {
    background-color: #fff;
    font-family: 'Source Sans Pro', sans-serif;
    color: #bbb;
    padding: 0;
    margin: 0;
}
.important {
    color: black;
}
.widthSideMargins, .lucamug {
    padding-left: 60px;
    padding-right: 60px;
}
h1, h2 {
    font-weight: normal;
    margin: 0;
}
.lucamug {
    padding-top: 30px;
    padding-bottom: 60px;
}
a {
    color: #bbb;
}
h1 {
    padding-top: 80px;
    font-size: 60px;
}
h2 {
    padding-top: 40px;
    padding-bottom: 20px;
}
.logoContainer {
    padding-bottom: 40px;
}
.svgsContainer {
    padding: 0 30px 0 30px;
}
.svgContainer {
    padding: 30px;
    display: inline-block;
}
.elmLogoContainer {
    text-align: right;
    display: inline-block;
    position: absolute;
    right: 0px;
}
.elmLogo {
    padding: 20px;
}
.clickable {
    cursor: pointer;
}
input {
    font-size: 20px;
    padding: 6px;
}
"""



-- MADE BY LUCAMUG


lucamug : Html msg
lucamug =
    a [ class "lucamug", href "https://github.com/lucamug" ]
        [ node "style" [] [ text """
        .lucamug{opacity:.4;color:#000;display:block;text-decoration:none}
        .lucamug:hover{opacity:.5}
        .lucamug:hover .lucamugSpin{transform:rotate(0deg);padding:0;position:relative;top:0;}
        .lucamugSpin{color:red ;display:inline-block;transition:all .4s ease-in-out; transform:rotate(60deg);padding:0 2px 0 4px;position:relative;top:-4px;}""" ]
        , text "made with "
        , span [ class "lucamugSpin" ] [ text "凸" ]
        , text " by lucamug"
        ]
