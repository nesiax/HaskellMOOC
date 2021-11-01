#!/usr/bin/env stack
-- stack --resolver lts-12.21 script

xxs = ["apple","banana","coconut", "orange", "pine"]

-- spell ["apple"] -> "a is for apple
-- speel: children spell of a word
spell :: [Char] -> [Char]
spell lst
  | null lst = []
  | otherwise = x : " is for " ++ lst
    where x:xs = lst

-- f2 ["apple", "banana", "coconut"]
-- ["a is for apple","b is for banana","c is for coconut"]
-- spells is spell applied to a list
spells lst = map spell lst

-- addand: add 'and' to the begining of the last element of a list
-- addand ["a is for apple", "b is for banana",   "c is for coconut"] ->
--    ["a is for apple", "b is for banana", "and c is for coconut"]
addand :: [[Char]] -> [[Char]]
addand lst =
  if (length lst > 1) then
    (foldr (\x xs -> ( if null xs then ("and " ++ x) else x ):xs) [] lst)
  else lst

-- addcomma: add a comma after [1..] elements of the list
addcomma :: Foldable t => t [Char] -> [[Char]]
addcomma lst = foldl (\xs x -> xs ++ (if null xs then [x] else [", " ++ x])) [] lst

-- speller: beauty print all the above.
speller :: [[Char]] -> [Char]
speller lst = foldl (\x xs -> x ++ xs) [] ((addcomma . addand . spells) lst)

main :: IO ()
main = do
  putStrLn (speller (take 1 xxs))
  putStrLn (speller (take 0 xxs))
  putStrLn (speller (take 3 xxs))
  putStrLn (speller (take 2 xxs))
