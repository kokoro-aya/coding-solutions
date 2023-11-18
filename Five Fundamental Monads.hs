-- 4 kyu, 2 yr

{-# LANGUAGE NoImplicitPrelude #-}
module Monads where

import Prelude hiding (Monad, Identity, Maybe(..), State, Reader, Writer)
import Data.Monoid

class Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b

data Identity a = Identity a
  deriving (Show, Eq)

data Maybe a = Nothing | Just a
  deriving (Show, Eq)

data State s a = State {runState :: s -> (a, s)}

data Reader s a = Reader {runReader :: s -> a }

data Writer w a = Writer {runWriter :: (w, a)}

instance Monad Identity where
  return = Identity
  (Identity v) >>= f = f v

instance Monad Maybe where
  return = Just
  Nothing >>= _ = Nothing
  (Just v) >>= f = f v

instance Monad (State s) where
  return = \a -> State $ \x -> (a, x)
  (State g) >>= f = State $ \st -> 
    let (as, bs) = g st
    in runState (f as) bs

instance Monad (Reader s) where
  return = \a -> Reader { runReader = \_ -> a }
  (Reader g) >>= f = Reader $ \r -> runReader (f (runReader (Reader g) r)) r

instance Monoid w => Monad (Writer w) where
  return = \b -> Writer { runWriter = (mempty, b) }
  (Writer (s, v)) >>= f = Writer $ 
    let (ws, as) = runWriter (Writer (s, v))
    in let (wx, bs) = runWriter (f $ as)
    in (ws `mappend` wx, bs)