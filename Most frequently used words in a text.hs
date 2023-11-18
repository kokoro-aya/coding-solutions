-- 4 kyu, 11 mo

module TopWords (top3) where

import Text.Parsec
import Data.Char (isLetter, toLower)
import Data.List (group, sortBy)
import qualified Data.Map as Map

validChar c = isLetter c || c == '\''

vchar = satisfy validChar :: Parsec String () Char

white = satisfy (not . isLetter)

word = (do
            cs <- many1 $ satisfy (== '\'')
            x <- satisfy isLetter
            rem <- many vchar
            pure (cs ++ x:rem))
        <|> (do
            c <- satisfy isLetter
            xs <- many vchar
            pure (c:xs))

delim = many1 white :: Parsec String () String

str = do
    option [] delim
    sepEndBy word delim

parser = parse str ""

top3 :: [Char] -> [[Char]]
top3 s =
    case parser s of
        Left err -> error "Parse error"
        Right xs ->
            map fst
                . take 3
                . sortBy (\(_, a) (_, b) -> compare b a)
                . Map.toList
                . foldr (\(x, i) ms ->
                    case (x `Map.lookup` ms) of
                        Nothing -> Map.insert x i ms
                        Just y -> Map.adjust (+ i) x ms
                        ) Map.empty
                . map (\xs@(x:_) -> (x, length xs))
                . group
                . map (map toLower) $ xs