-- 5 kyu, 3 yr

module Codewars.G964.WeightSort where

import Data.List(sortBy)

orderWeight :: [Char] -> [Char]
orderWeight = unwords . sortBy weightCmp . words
    where weightCmp x y = if weight x > weight y 
                            then GT 
                            else if weight x < weight y
                            then LT
                            else x `compare` y
            where weight = sum . map (\xx -> read [xx] :: Int)