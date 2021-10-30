#!/usr/bin/env stack
-- stack --resolver lts-12.21 script --ghc-options -isrc --package random

module Main where

import           Lib

main :: IO ()
main = start
