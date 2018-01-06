module Logo exposing (..)

import Html
import Svg
import Svg.Attributes


-- Original from https://github.com/elm-lang/svg/blob/master/examples/Logo.elm


type LogoColor
    = Colored
    | Orange
    | Green
    | LightBlue
    | Blue
    | White
    | Black


color : LogoColor -> String
color color =
    case color of
        Orange ->
            "#F0AD00"

        Green ->
            "#7FD13B"

        LightBlue ->
            "#60B5CC"

        Blue ->
            "#5A6378"

        _ ->
            "black"


elm : LogoColor -> String -> String -> Html.Html msg
elm colorName x y =
    let
        f =
            Svg.Attributes.fill

        d =
            Svg.Attributes.d

        p =
            Svg.path

        orange =
            color Orange

        green =
            color Green

        lightBlue =
            color LightBlue

        blue =
            color Blue

        c =
            case colorName of
                Colored ->
                    { c1 = orange, c2 = green, c3 = lightBlue, c4 = blue }

                Orange ->
                    { c1 = orange, c2 = orange, c3 = orange, c4 = orange }

                Green ->
                    { c1 = green, c2 = green, c3 = green, c4 = green }

                LightBlue ->
                    { c1 = lightBlue, c2 = lightBlue, c3 = lightBlue, c4 = lightBlue }

                Blue ->
                    { c1 = blue, c2 = blue, c3 = blue, c4 = blue }

                White ->
                    { c1 = "white", c2 = "white", c3 = "white", c4 = "white" }

                Black ->
                    { c1 = "black", c2 = "black", c3 = "black", c4 = "black" }
    in
    Svg.svg
        [ Svg.Attributes.version "1"
        , Svg.Attributes.viewBox "0 0 323 323"
        , Svg.Attributes.width x
        , Svg.Attributes.height y
        ]
        [ p [ f c.c1, d "M162 153l70-70H92zm94 94l67 67V179z" ] []
        , p [ f c.c2, d "M9 0l70 70h153L162 0zm238 85l77 76-77 77-76-77z" ] []
        , p [ f c.c3, d "M323 144V0H180zm-161 27L9 323h305z" ] []
        , p [ f c.c4, d "M153 162L0 9v305z" ] []
        ]
