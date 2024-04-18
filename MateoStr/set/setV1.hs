module SetV1 
        (Set,
        emptyS,
        addS,
        belongs,
        sizeS,
        removeS,
        unionS,
        setToList)where 
data Set a = S []         Int 
            -- elementos, cantidad de elementos

emptyS :: Set a
-- Crea un conjunto vacío.
emptyS = S [] 0 
addS :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto. 
addS e (S (xs) n) = if elem e xs 
                       then (S xs n)   
                       else (S (e:xs) n+1)

belongs :: Eq a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.

sizeS :: Eq a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.
removeS :: Eq a => a -> Set a -> Set a
-- Borra un elemento del conjunto.
unionS :: Eq a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos. conjuntos.
setToList :: Eq a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.



