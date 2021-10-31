#!/usr/bin/env stack
-- stack --resolver lts-12.21 script


-- 0. pattern matching

-- filter' :: (a -> Bool) -> [a] -> [a]
-- filter' f []     = []
-- filter' f (x:xs) = if f(x) then x:(filter' f xs) else filter' f xs


-- 1. if then else

-- filter' :: (a -> Bool) -> [a] -> [a]
-- filter' f lst =
--   if  length lst == 0 then []
--   else
--     let x:xs = lst
--     in  (if f x then x:(filter' f (xs)) else filter' f xs)


-- 2. guards

-- filter' :: (a -> Bool) -> [a] -> [a]
-- filter' f xs
--   | length xs == 0 = []
--   | otherwise = if f (head xs) then head xs : filter' f (tail xs) else filter' f (tail xs)


-- 3. where

-- filter' :: (a -> Bool) -> [a] -> [a]
-- filter' = f' where
--   f' f []     = []
--   f' f (x:xs) = if f x then x:(f' f xs) else f' f xs


-- 4. website

-- filter' pred lst
--   | null lst = []
--   | otherwise = if pred x
--      then x:filter' pred xs
--      else filter' pred xs
--        where x:xs=lst
