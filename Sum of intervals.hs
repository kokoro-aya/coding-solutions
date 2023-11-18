-- 4 kyu, 3 yr

module SumOfIntervals (sumOfIntervals) where

import Data.Set(fromList, empty, union)

intervalToRange :: (Int, Int) -> [Int]
intervalToRange (n, m) = [n .. m - 1]

sumOfIntervals :: [(Int, Int)] -> Int
sumOfIntervals intervals = length . foldr union empty $ map (fromList . intervalToRange) intervals