module Intro where

import Graphics.Element exposing (..)
import Text
import Mouse



main : Signal Element
main =
  Signal.map showLarge (Signal.foldp (\_ count -> count + 1 ) 0 Mouse.clicks)



showLarge : a -> Element
showLarge val =
  leftAligned (Text.height 40 (Text.fromString (toString val)))



