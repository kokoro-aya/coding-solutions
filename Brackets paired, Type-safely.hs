-- 4 kyu, 11 mo

{-# LANGUAGE KindSignatures, DataKinds, GADTs #-}

module Kata.PairedBracket where 


data Nat = Z | S Nat deriving Show

instance Show (Paren n) where
    show PEmpty = ""
    show (PLeft p) = '(' : show p
    show (PRight p) = ')' : show p

instance Eq (Paren n) where
    PEmpty == PEmpty = True
    (PLeft n1) == (PLeft n2)  = n1 == n2
    (PRight n1) == (PRight n2)  = n1 == n2
    _ == _ = False

-- data definition, implement Paren encoding to contain balancing information.

data Paren :: Nat -> * where
    PEmpty :: Paren Z
    PLeft :: (Paren (S x)) -> Paren x
    PRight :: Paren x -> Paren (S x)

-- use the Paren data definition


-- makeNestedParenOfSize :: Int -> Paren 
-- makeNestedParenOfSize n | n <= 0 = PEmpty
-- makeNestedParenOfSize n = foldr ($) PEmpty (replicate n PLeft ++ replicate n PRight)

-- implement the above function with your `Paren :: Nat -> *` definition.

addLeft :: Paren (S n) -> Paren n
addLeft = PLeft


addRight :: Paren (n) -> Paren (S n)
addRight PEmpty = PRight PEmpty
addRight (PLeft px) = PLeft (addRight px)
addRight (PRight px) = PRight (PRight px)


makeNestedParenOfSize :: Int -> Paren Z
makeNestedParenOfSize n | n <= 0 = PEmpty
                        | otherwise = addLeft . addRight . makeNestedParenOfSize $ (n - 1)