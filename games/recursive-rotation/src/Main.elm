module Main exposing (main)

import Color exposing (black, rgb, rgb255, white)
import Html exposing (Html)
import Playground3d exposing (Computer, Shape, block, configurations, cube, gameWithConfigurations, getColor, getFloat, group, moveX, moveY, rotateY, scale, spin, wave)
import Playground3d.Camera exposing (Camera, orthographic)
import Playground3d.Scene as Scene


main =
    gameWithConfigurations view update initialConfigurations init


type alias Model =
    {}



-- INIT


initialConfigurations =
    configurations
        [ ( "camera elevation", ( 1.4, 1.57, 1.57 ) )
        ]
        []


init : Computer -> Model
init _ =
    {}



-- UPDATE


update : Computer -> Model -> Model
update _ model =
    model



-- VIEW


camera : Computer -> Camera
camera computer =
    orthographic
        { focalPoint = { x = 0, y = 2, z = 0 }
        , azimuth = 0
        , elevation = getFloat "camera elevation" computer
        , viewportHeight = 2
        }


view : Computer -> Model -> Html Never
view computer _ =
    Scene.sunny
        { devicePixelRatio = computer.devicePixelRatio
        , screen = computer.screen
        , camera = camera computer
        , backgroundColor = white
        , sunlightAzimuth = degrees 90
        , sunlightElevation = -(degrees 180)
        }
        [ twentyBlocks computer
        ]


twentyBlocks : Computer -> Shape
twentyBlocks computer =
    helper computer 20


helper : Computer -> Int -> Shape
helper computer i =
    let
        angle =
            degrees (spin 8 computer.time) / 4

        scaling =
            0.707 / cos (pi / 4 - angle)

        color =
            if modBy 2 i == 0 then
                rgb255 17 147 216

            else
                white
    in
    if i == 0 then
        group []

    else
        group
            [ cube color 1
            , helper computer (i - 1)
                |> scale scaling
                |> rotateY angle
                |> moveY 0.3
            ]
