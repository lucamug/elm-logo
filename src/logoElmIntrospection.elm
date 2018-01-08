module LogoElmIntrospection exposing (..)

import LogoElm as Logo


logoTypes : List Logo.Type
logoTypes =
    [ Logo.Colorful
    , Logo.Color Logo.Orange
    , Logo.Color Logo.Green
    , Logo.Color Logo.LightBlue
    , Logo.Color Logo.Blue
    , Logo.Color Logo.White
    , Logo.Color Logo.Black
    ]


logoTypeDefault : Logo.Type
logoTypeDefault =
    Logo.Colorful


convertLogoTypeToString : Logo.Type -> String
convertLogoTypeToString logoType =
    case logoType of
        Logo.Color color ->
            "Color " ++ convertLogoColorToString color

        Logo.Colorful ->
            "Colorful"


convertLogoColorToString : Logo.Color -> String
convertLogoColorToString colorType =
    case colorType of
        Logo.Orange ->
            "Orange"

        Logo.Green ->
            "Green"

        Logo.LightBlue ->
            "LightBlue"

        Logo.Blue ->
            "Blue"

        Logo.White ->
            "White"

        Logo.Black ->
            "Black"
