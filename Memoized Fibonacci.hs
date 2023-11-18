-- 5 kyu, 3 yr

module Fibonacci where

fibs' :: [Integer]
fibs' = 0 : 1 : zipWith (+) fibs' (tail fibs')

fibonacci :: Int -> Integer
fibonacci x = fibs' !! x