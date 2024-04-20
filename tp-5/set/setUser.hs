import SetV1 

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

set1 = agregarListaASet [1,2,3,4] emptyS
set2 = agregarListaASet [5,6,7,8,8] emptyS
treeSet = NodeT set1 (NodeT set2 EmptyT EmptyT) EmptyT


-- O(n*m)  # ya que se usa soloRepetidos. 
losQuePertenecen :: Eq a => [a] -> Set a -> [a]
-- Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen
-- al conjunto. 
losQuePertenecen xs set = soloRepetidos xs (setToList set)   

-- O( n # siendo n la longitud de la lista ya que se hace RE sobre la misma.  
-- *
-- ( m  # siendo n la longitud de la lista ys ya que se usa elem con ella.  
-- )) 
-- O(n*m)
soloRepetidos ::  Eq a => [a] -> [a] -> [a]
soloRepetidos xs     [] = []
soloRepetidos []     ys = []
soloRepetidos (x:xs) ys = if elem x ys 
                            then x : soloRepetidos xs ys 
                            else soloRepetidos xs ys 


sinRepetidoss :: Eq a =>  [a] -> [a]
-- Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
sinRepetidoss xs = setToList (agregarListaASet xs emptyS)


agregarListaASet :: Eq a => [a] -> Set a -> Set a
agregarListaASet [] set     = emptyS 
agregarListaASet (x:xs) set = addS x (agregarListaASet xs set)

unirTodos :: Eq a => Tree (Set a) -> Set a
-- Dado un arbol de conjuntos devuelve un conjunto con la union de todos los conjuntos
-- del arbol.
unirTodos EmptyT            = emptyS 
unirTodos (NodeT s izq der) = unionS s (unionS (unirTodos izq) (unirTodos der))

