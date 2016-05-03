module Intro where

import Graphics.Element exposing (..)
import Text
import Mouse




main : Element
main =
  showLarge "Hello Flatmap 2016!"



showLarge : a -> Element
showLarge val =
  leftAligned (Text.height 40 (Text.fromString (toString val)))



