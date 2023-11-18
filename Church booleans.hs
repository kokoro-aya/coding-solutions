-- 5 kyu, 3 yr

{-# Language RankNTypes #-}

module Church (not,and,or,xor) where

import Prelude hiding (Bool,False,True,not,and,or,(&&),(||),(==),(/=))
import Church.Preloaded (Boolean,false,true)

not :: Boolean -> Boolean
and,or,xor :: Boolean -> Boolean -> Boolean

not = \ a   -> a false true
and = \ a b -> a b a
or  = \ a b -> a a b
xor = \ a b -> a (not b) b