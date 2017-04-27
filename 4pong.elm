--Jerry and Merritt
import Html exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Keyboard
import Text
import Time exposing (..)
import Window


main = program {init = (initialGame, initialSizeCmd)
               , view = view
               , update = update
               , subscriptions = subscriptions
               }

 -- The game screen, or MODEL
(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)

-- Play/pause button
type State = Play | Pause


type alias Ball =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  }


type alias Player =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  , score : Int
  }


type alias Game =
  { state : State
  , ball : Ball
  , player1 : Player
  , player2 : Player
  , player3 : Player
  , player4 : Player
  }

player : Float -> Player
player x =
  Player x 0 0 0 0

-- default game state, 4 players and one ball
-- Need to figure out how to set (x,y) coords for the paddles, currently only takes (x)
defaultGame : Game
defaultGame =
  { state = Pause
  , ball = Ball 0 0 200 200
  , player1 = player (20-halfWidth)
  , player2 = player (halfWidth-20)
  , player3 = player (20 - halfWidth)
  , player4 = player (halfWidth -20)
  }


  -- VIEW
  view : (Int,Int) -> Game -> Element
  view (w,h) game =
    let
      scores =
        txt (Text.height 50) (toString game.player1.score ++ "  " ++ toString game.player2.score ++ " " ++ toString game.player3.score ++ " " ++ toString game.player4.score)
    in
      container w h middle <|
      collage gameWidth gameHeight
        [ rect gameWidth gameHeight
            |> filled pongGreen
        , oval 15 15
            |> make game.ball
        , rect 10 40
            |> make game.player1
        , rect 10 40
            |> make game.player2
        , rect 40 10 -- 40 10 makes the paddle horizontal
            |> make game.player3
        , rect 40 10
            |> make game.player4
        , toForm scores
            |> move (0, gameHeight/2 - 40)
        ]


-- default colors, black background with a white ball
  pongBlack =
    rgb rgb 0 0 0

  textWhite =
    rgb 255 255 255
