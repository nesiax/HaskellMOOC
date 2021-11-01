#!/usr/bin/env stack
-- stack --resolver lts-12.21 script

data Tree = Leaf | Node Int Tree Tree deriving Show

theTree = Node 3 Leaf (Node 5 (Node 7 Leaf (Node 8 Leaf Leaf)) Leaf)

treeDepth :: Tree -> Int
treeDepth Leaf = 0
treeDepth (Node _ leftSubtree rightSubtree) =
  1 + max (treeDepth leftSubtree) (treeDepth rightSubtree)


treeSum :: Tree -> Int
treeSum Leaf = 0
treeSum (Node value leftSubtree rightSubtree) = value + (treeSum leftSubtree) + (treeSum rightSubtree)


isSortedTree :: Tree -> Int -> Int -> Bool
isSortedTree Leaf _ _ = True
isSortedTree (Node x leftSubtree rightSubtree) minVal maxVal =
    let leftSorted   = isSortedTree leftSubtree minVal x
        rightSorted = isSortedTree rightSubtree x maxVal
    in x >= minVal && x< maxVal && leftSorted && rightSorted

addNewMax :: Tree -> Tree
-- add a new max element to tree
addNewMax Leaf             = Node 0 Leaf Leaf  -- input tree with no nodes
addNewMax (Node x t1 Leaf) = Node x t1 (Node (x+1) Leaf Leaf)  -- this is the rightmost Node
addNewMax (Node x t1 t2)   = Node x t1 (addNewMax t2) -- intermediate node, go down right subtree

-- Can you write functions to insert a value into a Tree in order, or to convert from a Tree into a list?

treeToList :: Tree -> [Int]
treeToList (Leaf)         = []
treeToList (Node x t1 t2) = (treeToList t1) ++ [x] ++ (treeToList t2)


insertTree :: Tree -> Int -> Tree
insertTree Leaf v           = Node v Leaf Leaf
insertTree (Node x left right) newv = if newv < x
                          then (Node x (insertTree left newv) right)
                          else (Node x left (insertTree right newv))

addcomma :: Foldable t => t [Char] -> [[Char]]
addcomma lst = foldl (\xs x -> xs ++ (if null xs then [x] else [", " ++ x])) [] lst

main :: IO ()
main = do
  let n1 = Leaf
      n2 = insertTree n1 50
      n3 = insertTree n2 150
      n4 = insertTree n3 20
  putStrLn (concat (addcomma (map (show) (treeToList n4))))
