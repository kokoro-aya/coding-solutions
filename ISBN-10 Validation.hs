-- 5 kyu, 3 yr

module ISBN10 where

import Data.Char(digitToInt)

validISBN10 :: String -> Bool
validISBN10 xx = if length xx /= 10 then False
                 else if not . null . filter (\x -> not $ x `elem` ['0' .. '9'] ++ ['X']) $ xx then False
                 else if 'X' `elem` take 9 xx then False
                 else
                     ((sum
                     $ map (\(x, y) -> x * y)
                     $ zip [1 .. 10]
                     $ map (\x -> case () of
                                _ | x == 'X' -> 10
                                  | x `elem` ['0' .. '9'] -> digitToInt x
                                  | otherwise -> error "This could not happen"
                         ) xx) `mod` 11) == 0
                         