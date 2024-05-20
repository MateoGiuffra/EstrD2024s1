module MaxHeap(
    MaxHeap,
    emptyH,
    isEmptyH,
    insertH,
    maxH,
    deleteMaxH
) where

data MaxHeap a = EmptyH | NodeH a (MaxHeap a) (MaxHeap a) deriving (Show)

-- emptyH :: MaxHeap a                              O(1)
emptyH :: MaxHeap a
emptyH = EmptyH

-- isEmptyH :: MaxHeap a -> Bool                    O(1)
isEmptyH :: MaxHeap a -> Bool
isEmptyH EmptyH = True
isEmptyH _      = False

-- insertH :: Ord a => a -> MaxHeap a -> MaxHeap a  O(log M)
insertH :: Ord a => a -> MaxHeap a -> MaxHeap a
insertH x EmptyH = NodeH x EmptyH EmptyH
insertH x (NodeH y left right)
    | x >= y    = NodeH x (insertH y right) left
    | otherwise = NodeH y (insertH x right) left

-- maxH :: MaxHeap a -> a                           O(1)
maxH :: MaxHeap a -> a
maxH (NodeH x _ _) = x

-- deleteMaxH :: Ord a => MaxHeap a -> MaxHeap a    O(log M)
deleteMaxH :: Ord a => MaxHeap a -> MaxHeap a
deleteMaxH EmptyH = error "Can't delete from an empty heap"
deleteMaxH (NodeH _ left right) = mergeHeaps left right

-- Función auxiliar para combinar dos montículos
mergeHeaps :: Ord a => MaxHeap a -> MaxHeap a -> MaxHeap a
mergeHeaps h EmptyH = h
mergeHeaps EmptyH h = h
mergeHeaps h1@(NodeH x left1 right1) h2@(NodeH y left2 right2)
    | x >= y    = NodeH x (mergeHeaps right1 h2) left1
    | otherwise = NodeH y (mergeHeaps h1 right2) left2
