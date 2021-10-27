#!/usr/bin/env stack
-- stack --resolver lts-12.26 script --package random

import           System.Environment
import           System.IO
import           System.Random

-- starman.hs
-- Jeremy Singer
-- based on a Functional Programming
-- exercise from Glasgow,
-- (inherited from John O'Donnell)
-- added random functionality (Nestor Diaz)

check :: String -> String -> Char -> (Bool, String)
-- check whether a single char is in the mystery word
check word display c
  = (c `elem` word, [if x==c
          then c
          else y | (x,y) <- zip word display])

turn :: String -> String -> Int -> IO ()
-- single turn for user
turn word display n =
  do if n==0
       then
       putStrLn ("You lose" ++ ". Word was: " ++ word)
       else if word==display
            then putStrLn "You win!"
            else mkguess word display n

mkguess :: String -> String -> Int -> IO ()
-- user inputs a single char (first on the line)
mkguess word display n =
  do putStrLn (display ++ "  " ++ take n (repeat '*'))
     putStr "  Enter your guess: "
     q <- getLine
     let (correct, display') = check word display (q!!0)
     let n' = if correct then n else n-1
     turn word display' n'

-- notice how turn and mkguess have the same signatures,
-- and are mutually recursive. Is this elegant?

starman :: String -> Int -> IO ()
-- top-level function. Usage: starman "WORD" NUM_TURNS
starman word n = turn word ['-' | x <- word] n

main = do
  args <- getArgs
  let theFile = (args !! 0)
  let theChances = read (args !! 1)::Int
  handle <- openFile theFile ReadMode
  contents <- hGetContents handle
  g <- getStdGen
  let allLines = lines contents
  let totLines = length allLines
  let theIndex = (fst (randomR (0,totLines - 1) g))
  let theWord = allLines !! theIndex
  starman theWord theChances
  hClose handle
