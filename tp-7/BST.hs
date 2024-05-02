-- Ejercicio 2
-- Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
-- invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
-- desbalancearse al insertar o borrar elementos). En todos los costos, N es la cantidad de elementos
-- del árbol. Justicar por qué la implementación satisface los costos dados.

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
            deriving Show

            
bst = insertBST 9
        $ insertBST 200  
        $ insertBST 30
        $ insertBST 10 
        $ insertBST 190         
        $ insertBST 195
        $ insertBST 201
        $ insertBST 100 EmptyT 

noBST = NodeT 10 (NodeT 100 EmptyT EmptyT) (NodeT 9 EmptyT EmptyT)
falsoBST = NodeT  30 (NodeT 14 (NodeT 16 EmptyT EmptyT)((NodeT 8 EmptyT EmptyT))) (NodeT 34 EmptyT EmptyT)

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST e EmptyT            = False 
belongsBST e (NodeT x izq der) = if e == x 
                                    then True 
                                    else if e < x
                                        then  belongsBST e izq 
                                        else  belongsBST e der

insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
insertBST e EmptyT          = NodeT e EmptyT EmptyT 
insertBST e (NodeT x ti td) = if e == x
                                then NodeT e ti td  
                                    else if e < x 
                                      then NodeT x (insertBST e ti) td  
                                      else NodeT x ti (insertBST e td)
root :: Tree a -> a
root (NodeT a _ _) = a                            
-- deleteBST :: Ord a => a -> Tree a -> Tree a
-- -- Propósito: dado un BST borra un elemento en el árbol.
-- -- Costo: O(log N)
-- deleteBST _ EmptyT          = EmptyT 
-- deleteBST e (NodeT x ti td) = if x == e 
--                                 then reArmarBST ti td 
--                                 else if e < x 
--                                 then NodeT x (deleteBST e ti) td
--                                 else NodeT x ti (deleteBST e td)   

-- reArmarBST :: Ord a => Tree a -> Tree a -> Tree a 



splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N) 
-- PRECONDICION: El arbol no puede ser vacio. 
splitMinBST  EmptyT             = error"No existe minimo de un arbol vacio" 
splitMinBST (NodeT x EmptyT td) = (x,td)     
splitMinBST (NodeT x ti td)     = let (m,arbolSinM) = splitMinBST ti in 
                                       (m, (NodeT x arbolSinM td ) )

isEmptyT :: Tree a -> Bool 
isEmptyT EmptyT = True
isEmptyT _      = False 

splitMaxBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
-- PRECONDICION: El arbol no puede ser vacio. 
splitMaxBST  EmptyT             = error"No existe minimo de un arbol vacio" 
splitMaxBST (NodeT x ti EmptyT) = (x,ti)     
splitMaxBST (NodeT x ti td)     = let (m,arbolSinM) = splitMaxBST td in 
                                       (m, (NodeT x ti arbolSinM ) )

esBST :: Ord a =>  Tree a -> Bool
-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N2)
esBST EmptyT          = True 
esBST (NodeT x ti td) = esMayorQueTodos x ti && esMenorQueTodos x td  && esBST ti && esBST td

esMayorQueTodos :: Ord a => a -> Tree a -> Bool 
esMayorQueTodos r EmptyT          = True 
esMayorQueTodos r (NodeT x ti td) = r >= x && esMayorQueTodos r ti && esMayorQueTodos r td  

esMenorQueTodos :: Ord a => a -> Tree a -> Bool 
esMenorQueTodos r EmptyT          = True 
esMenorQueTodos r (NodeT x ti td) = r <= x && esMenorQueTodos r ti && esMenorQueTodos r td  



elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al elemento dado.
-- Costo: O(log N)
elMaximoMenorA e EmptyT          = Nothing 
elMaximoMenorA e (NodeT x ti td) =  if isEmptyT ti 
                                    then Nothing
                                    else if e < x  
                                        then elMaximoMenorA e ti  
                                        else elMaximoMenorA e td 

maxMaybes ::  Ord a => Maybe a -> Maybe a -> Maybe a
maxMaybes m1 m2 = if isNothing m1 || isNothing m2 
                    then Nothing 
                    else if justFrom m1 > justFrom m2 
                        then m1 
                        else m2 
justFrom :: Maybe a -> a 
justFrom (Just a) = a 

isNothing ::Maybe a -> Bool 
isNothing Nothing = True 
isNothing _       = False
-- if e < x  
--                                   then case elMaximoMenorA e ti of
--                                        Nothing -> Just x 
--                                        Just r  -> Just (max r x)
--                                   else case elMaximoMenorA e td of
--                                        Nothing -> Just x
--                                        Just r  -> Just (max r x)   

elMaximoEntre :: Ord a => Maybe a -> Maybe a -> Maybe a
--PRECONDICION: Maybe a tiene que ser Just.
elMaximoEntre m1 m2 = let (Just a) = m1 in  
                        let (Just b) = m2 in 
                         if a > b
                          then m1
                          else m2  
                    

-- elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
-- -- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- -- elemento dado.
-- -- Costo: O(log N)
-- balanceado :: Tree a -> Bool
-- -- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
-- nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- -- Costo: O(N2)