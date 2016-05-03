module AMouse where

import Mouse
import Time
import Graphics.Element exposing (show, Element)

main : Signal Element
main =
  Signal.map show Mouse.position
  --Signal.map show (Signal.map2 (,) Mouse.x Mouse.y)
  --Signal.map show (Signal.sampleOn (Time.fps 5) Mouse.position)
  --Signal.map show Mouse.clicks
  --Signal.map show <| Signal.foldp (\_ x -> x + 1) 0 Mouse.clicks



