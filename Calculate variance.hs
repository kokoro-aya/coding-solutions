-- 5 kyu, 3 yr

module Variance (variance) where

variance :: [Double] -> Double
variance xs = (sum $ map (\x -> (x - mean) * (x - mean)) xs) / (fromIntegral (length xs):: Double)
    where mean = sum xs / fromIntegral (length xs):: Double