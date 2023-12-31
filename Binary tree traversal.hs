-- 5 kyu, 3 yr

module BinaryTreeTraversal
  ( preOrder
  , inOrder
  , postOrder
  ) where

import BinaryTreeTraversal.Types

{-
data Tree a = Nil | Node (Tree a) a (Tree a)
-}

-- 1.) Root node, 2.) traverse left subtree, 3.) traverse right subtree.
preOrder :: Tree a -> [a]
preOrder x = case x of
    Nil  -> []
    Node left cur right -> [cur] ++ preOrder left ++ preOrder right

-- 1.) Traverse left subtree, 2.) root node, 3.) traverse right subtree.
inOrder :: Tree a -> [a]
inOrder x = case x of
    Nil -> []
    Node left cur right -> inOrder left ++ [cur] ++ inOrder right

-- 1.) Traverse left subtree, 2.) traverse right subtree, 3.) root node.
postOrder :: Tree a -> [a]
postOrder x = case x of
    Nil -> []
    Node left cur right -> postOrder left ++ postOrder right ++ [cur]