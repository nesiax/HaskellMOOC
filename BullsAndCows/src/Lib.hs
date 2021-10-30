module Lib
    ( someFunc
    , start
    ) where

import           System.Random
import           Text.Printf

someFunc :: IO ()
someFunc = putStrLn "someFusss!!"

enumerate :: (Num a, Enum a) => [b] -> [(a, b)]
enumerate str = zip ([0..]) str

-- xs = enumerate "arst"
-- ys = enumerate "brts"

-- *Lib System.Random> xs
-- [(0,'a'),(1,'r'),(2,'s'),(3,'t')]
-- *Lib System.Random> ys
-- [(0,'b'),(1,'r'),(2,'t'),(3,'s')]

bulls :: Eq a => [a] -> [a] -> Int
bulls xs ys = length $ filter (\((i,a),(j,b)) -> i == j && a == b) [(x,y) | x <- enumerate xs, y <- enumerate ys]

cows :: Eq a => [a] -> [a] -> Int
cows xs ys  = length $ filter (\((i,a),(j,b)) -> i /= j && a == b) [(x,y) | x <- enumerate xs, y <- enumerate ys]

check :: Eq a => [a] -> [a] -> (Int, Int)
check s1 s2 = (bulls s1 s2 , cows s1 s2)

turn :: (Show t, Num t) => String -> String -> t -> IO ()
turn word guess n = do
  let (bulls, cows) = check word guess
  putStrLn ("Try: " ++ show n ++  ", Bulls: " ++ show bulls ++ ", Cows: " ++ show cows )
  if word == guess
       then
          putStrLn ("You guessed !")
       else
       mkguess word (n+1)

mkguess :: (Show t, Num t) => String -> t -> IO ()
mkguess code n =
  do
    putStr "Enter your guess: "
    guess <- getLine
    turn code guess n


rmdups :: (Eq a) => [a] -> [a]
rmdups []     = []
rmdups [x]    = [x]
rmdups (x:xs) = x : [ k  | k <- rmdups(xs), k /=x ]


genCode :: Int -> IO String
genCode n = do
   r1 <- getStdGen
   let (x, r2) = randomR (0::Int,(10^n-1)::Int) r1
       fmt = "%0" ++ show n ++ "d"
   setStdGen r2
   return (printf fmt x)

start :: IO ()
start =
    do
      theCode <- genCode 4
      if (theCode == (rmdups theCode)) then
        do
          putStrLn ("The secret code is: " ++ theCode)
          mkguess theCode 1
        else
        start
