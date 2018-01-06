module Main exposing (..)

import Color
import Html exposing (..)
import Html.Attributes exposing (..)
import Logo


-- http://tango.freedesktop.org/Tango_Icon_Theme_Guidelines


main : Html.Html msg
main =
    div
        []
        [ node "style" [] [ text css ]
        , h1 []
            [ text "elm "
            , span [ class "important" ] [ text "logo" ]
            ]
        , logoTest Color.white "white"
        , logoTest Color.lightGray "light gray"
        , logoTest Color.gray "gray"
        , logoTest Color.darkGray "dark gray"
        , logoTest Color.lightCharcoal "light charcoal"
        , logoTest Color.charcoal "charcoal"
        , logoTest Color.darkCharcoal "dark charcoal"
        , logoTest Color.black "black"
        , logoTest Color.lightYellow "light yellow"
        , logoTest Color.lightOrange "light orange"
        , logoTest Color.lightGreen "light green"
        , logoTest Color.lightRed "light red"
        , logoTest Color.lightBlue "light blue"
        , logoTest Color.lightPurple "light purple"
        , logoTest Color.lightBrown "light brown"
        , logoTest Color.darkYellow "dark yellow"
        , logoTest Color.darkOrange "dark orange"
        , logoTest Color.darkGreen "dark green"
        , logoTest Color.darkRed "dark red"
        , logoTest Color.darkBlue "dark blue"
        , logoTest Color.darkPurple "dark purple"
        , logoTest Color.darkBrown "dark brown"
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
    div []
        [ div
            [ class "logoContainer"
            , style
                [ ( "background-color", cssRgb ) ]
            ]
            [ h2
                [ style [ ( "color", textColor ) ] ]
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
                    (logoSeries "100")
                )
            ]
        ]


luminance : Color.Color -> Float
luminance color =
    let
        { red, green, blue, alpha } =
            Color.toRgb color
    in
    0.299 * toFloat red + 0.587 * toFloat green + 0.114 * toFloat blue


logoSeries : String -> List (Html msg)
logoSeries size =
    [ Logo.elm Logo.Colored size
    , Logo.elm (Logo.Monochrome Logo.Orange) size
    , Logo.elm (Logo.Monochrome Logo.Green) size
    , Logo.elm (Logo.Monochrome Logo.LightBlue) size
    , Logo.elm (Logo.Monochrome Logo.Blue) size
    , Logo.elm (Logo.Monochrome Logo.White) size
    , Logo.elm (Logo.Monochrome Logo.Black) size
    ]


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
    background-color: white;
    font-family: 'Source Sans Pro', sans-serif;
    color: #bbb;
    padding: 0;
    margin: 0;
}
.important {
    color: black;
}
h1, h2 {
    font-weight: normal;
    padding-left: 60px;
    margin: 0;
}
.lucamug {
    padding: 60px;
}
a {
    color: #bbb;
}
h1 {
    padding-top: 80px;
    font-size: 60px;
}
h2 {
    padding-top: 80px;
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
"""



-- MADE BY LUCAMUG


lucamug : Html msg
lucamug =
    a [ class "lucamug", href "https://github.com/lucamug" ]
        [ node "style" [] [ text """.lucamug{opacity:.4;color:#000;display:block;text-decoration:none}.lucamug:hover{opacity:.5}.lucamug:hover .lucamugSpin{transform:rotate(360deg)}.lucamugSpin{color:#3d8a9f ;display:inline-block;transition:transform .6s ease-in-out}""" ]
        , text "made with "
        , span [ class "lucamugSpin" ] [ text "凸" ]
        , text " by lucamug"
        ]
