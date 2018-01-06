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
        [ h1 [] [ text "Elm logo" ]
        , logoTest Color.white "white"
        , logoTest Color.lightGray "light gray"
        , logoTest Color.gray "gray"
        , logoTest Color.darkGray "dark gray"
        , logoTest Color.darkCharcoal "charcoal"
        , logoTest Color.lightYellow "light yellow"
        , a [ href "https://github.com/lucamug/elm-logo" ]
            [ img
                [ style [ ( "position", "absolute" ), ( "top", "0" ), ( "right", "0" ), ( "border", "0" ) ]
                , src "https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67"
                , alt "Fork me on GitHub"
                ]
                []
            ]
        ]


logoTest : Color.Color -> String -> Html msg
logoTest color name =
    div []
        [ h2 [] [ text name ]
        , div
            [ style
                [ ( "background-color", colorToString color ) ]
            ]
            [ node "style" [] [ text css ]
            , div
                []
                (List.map
                    (\item ->
                        div
                            [ style
                                [ ( "padding", "50px" )
                                , ( "display", "inline-block" )
                                ]
                            ]
                            [ item ]
                    )
                    (logoSeries "100")
                )
            ]
        ]


logoSeries : String -> List (Html msg)
logoSeries s =
    [ Logo.elm Logo.Colored s s
    , Logo.elm Logo.Orange s s
    , Logo.elm Logo.Green s s
    , Logo.elm Logo.LightBlue s s
    , Logo.elm Logo.Blue s s
    , Logo.elm Logo.White s s
    , Logo.elm Logo.Black s s
    ]


colorToString : Color.Color -> String
colorToString color =
    let
        c =
            Color.toRgb color
    in
    "rgb("
        ++ String.join ","
            (List.map
                (\item -> toString item)
                [ c.red, c.green, c.blue ]
            )
        ++ ")"


css : String
css =
    """
body {
    background-color: #eee;
    font-family: sans-serif;
    color: #999;
    padding: 40px;
    margin: 0;
}
h2 {
    padding-top: 40px;
    padding-bottom: 20px;
    font-weight: normal;
}
"""
