-- 4 kyu, 11 mo

{-# LANGUAGE RankNTypes #-}

module Haskell.Codewars.Church where

import Prelude hiding (succ)

newtype Number = Nr (forall a. (a -> a) -> a -> a)

zero :: Number
zero = Nr (\ _ z -> z)

succ :: Number -> Number
succ (Nr a) = Nr (\ s z -> s (a s z))

one :: Number
one = succ zero

add :: Number -> Number -> Number
add (Nr m) (Nr n) = Nr (\ f x -> m f (n f x))

mult :: Number -> Number -> Number
mult (Nr m) (Nr n) = Nr (m . n)

pow :: Number -> Number -> Number
pow (Nr m) (Nr n) = Nr (n m)
