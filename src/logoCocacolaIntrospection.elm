module LogoCocacolaIntrospection exposing (..)

import LogoCocacola as Logo


logoTypes : List Logo.Type
logoTypes =
    [ Logo.Color Logo.Red
    , Logo.Color Logo.White
    , Logo.Color Logo.Black
    ]


logoTypeDefault : Logo.Type
logoTypeDefault =
    Logo.Color Logo.Red


logoColors : List Logo.Color
logoColors =
    [ Logo.Red
    , Logo.White
    , Logo.Black
    ]


convertLogoColorToString : Logo.Color -> String
convertLogoColorToString logoColor =
    case logoColor of
        Logo.Red ->
            "Red"

        Logo.Black ->
            "Black"

        Logo.White ->
            "White"


convertLogoTypeToString : Logo.Type -> String
convertLogoTypeToString logoType =
    case logoType of
        Logo.Color colorType ->
            "Color " ++ convertLogoColorToString colorType
