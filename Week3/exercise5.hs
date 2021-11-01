#!/usr/bin/env stack
-- stack --resolver lts-12.21 script

-- step 8
--foldr (\acc elt -> elt ++ [acc]) "" "Reversing a string"

prepend :: [a] -> a -> [a]
prepend = (\xs x -> x:xs)

prepend' :: a -> [a] -> [a]
prepend' = (\x xs -> xs ++ [x])

reversel :: Foldable t => t Char -> [Char]
reversel = foldl prepend ""

reverser :: Foldable t => t Char -> [Char]
reverser = foldr prepend' ""

sum :: (Foldable t, Num a) => t a -> a
sum xs = foldr (+) 0 xs

sum' :: (Foldable t, Num b) => t b -> b
sum' = foldr (+) 0

--let x = foldl prepend "" "asrt"

--foldl prepend "" "arst"

--foldr prepend' "" "arst"

main :: IO ()
main = do
  putStrLn (
    foldr (\acc elt -> elt ++ [acc]) "" "Reversing a string"
    )
  putStrLn (reversel  "Hello World")
  putStrLn (reverser "Hello World")
  putStrLn (
    foldl (\xs x -> xs ++ [x]) "" "A String"
    )
  putStrLn (show (foldr (/) 1 [2,4,8]))
  putStrLn (show (foldl (/) 16 [8,4,2,1]))
