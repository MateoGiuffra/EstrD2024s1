module MinHeap (
    MinHeap,
    emptyH,
    isEmptyH,
    findMinH,
    insertH,
    deleteMinH
) where

data MinHeap a = EmptyH | NodeH a Int (MinHeap a) (MinHeap a) deriving (Show, Eq)

-- | Crea un heap vacío
emptyH :: MinHeap a
emptyH = EmptyH

-- | Comprueba si el heap está vacío
isEmptyH :: MinHeap a -> Bool
isEmptyH EmptyH = True
isEmptyH _      = False

-- | Encuentra el mínimo elemento en el heap
findMinH :: MinHeap a -> Maybe a
findMinH EmptyH          = Nothing
findMinH (NodeH x _ _ _) = Just x

-- | Inserta un elemento en el heap
insertH :: Ord a => a -> MinHeap a -> MinHeap a
insertH x heap = mergeH (NodeH x 1 EmptyH EmptyH) heap

-- | Elimina el mínimo elemento del heap
deleteMinH :: Ord a => MinHeap a -> MinHeap a
deleteMinH EmptyH          = EmptyH
deleteMinH (NodeH _ _ l r) = mergeH l r

-- | Combina dos heaps en uno
mergeH :: Ord a => MinHeap a -> MinHeap a -> MinHeap a
mergeH heap EmptyH = heap
mergeH EmptyH heap = heap
mergeH h1@(NodeH x1 r1 l1 r1') h2@(NodeH x2 r2 l2 r2')
    | x1 <= x2  = makeT x1 (r1 + 1) l1 (mergeH r1' h2)
    | otherwise = makeT x2 (r2 + 1) l2 (mergeH h1 r2')
  where
    makeT x rank l r
        | rankH l >= rankH r = NodeH x rank l r
        | otherwise          = NodeH x (rankH r + 1) r l

-- | Obtiene el rango de un heap
rankH :: MinHeap a -> Int
rankH EmptyH          = 0
rankH (NodeH _ r _ _) = r
