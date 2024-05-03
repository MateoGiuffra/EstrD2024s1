-- Ejercicio 2
-- Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
-- invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
-- desbalancearse al insertar o borrar elementos). En todos los costos, N es la cantidad de elementos
-- del árbol. Justicar por qué la implementación satisface los costos dados.

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)


-- VARIABLES: 
            
bst = insertBST 9
        $ insertBST 200  
        $ insertBST 30
        $ insertBST 10 
        $ insertBST 190         
        $ insertBST 195
        $ insertBST 201
        $ insertBST 100 EmptyT 
                             
bstBalanceado = (NodeT 100 (NodeT 20 (NodeT 10 (NodeT 5 EmptyT EmptyT)(NodeT 15 EmptyT EmptyT)) (NodeT 30 (NodeT 29 EmptyT EmptyT) (NodeT 33 EmptyT EmptyT))) (NodeT 200 (NodeT 150 (NodeT 120 EmptyT EmptyT) (NodeT 180 EmptyT EmptyT)) (NodeT 300 (NodeT 250 EmptyT EmptyT) (NodeT 350 EmptyT EmptyT))))
avl           = NodeT 100 (NodeT 10 (NodeT 9 EmptyT EmptyT)(NodeT 30 EmptyT EmptyT)) (NodeT 195 (NodeT 190 EmptyT EmptyT)(NodeT 201 (NodeT 200 EmptyT EmptyT)EmptyT))
noBST         = NodeT 10 (NodeT 100 EmptyT EmptyT) (NodeT 9 EmptyT EmptyT)
falsoBST      = NodeT  30 (NodeT 14 (NodeT 16 EmptyT EmptyT)((NodeT 8 EmptyT EmptyT))) (NodeT 34 EmptyT EmptyT)

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

deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
deleteBST _ EmptyT          = EmptyT 
deleteBST e (NodeT x ti td) = if x == e 
                                then reArmarBST ti td 
                                else if e < x 
                                then NodeT x (deleteBST e ti) td
                                else NodeT x ti (deleteBST e td)   

reArmarBST :: Ord a => Tree a -> Tree a -> Tree a 
reArmarBST ti td = let (r,arbolSinMax) = splitMaxBST ti in
                    NodeT r arbolSinMax td

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
elMaximoMenorA e (NodeT x ti td) = if e > x
                                   then case elMaximoMenorA e td of
                                      Nothing -> Just x 
                                      Just r  -> Just (max x r)
                                     else elMaximoMenorA e ti 
justFrom :: Maybe a -> a 
justFrom (Just a) = a 

isNothing ::Maybe a -> Bool 
isNothing Nothing = True 
isNothing _       = False

                    
elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- elemento dado.
-- Costo: O(log N)
elMinimoMayorA e EmptyT          = Nothing    
elMinimoMayorA e (NodeT x ti td) = if e < x
                                   then case elMinimoMayorA e ti of
                                      Nothing -> Just x 
                                      Just r  -> Just (min x r)
                                    else elMinimoMayorA e td  
balanceado :: Tree a -> Bool
-- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
-- nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- Costo: O(N2)
balanceado EmptyT          = True 
balanceado (NodeT x ti td) = (heightT  ti - heightT  td ) <= 1 && balanceado ti && balanceado td

-- FUNCION AUXILIAR TP3
heightT :: Tree a -> Int
--Dado un árbol devuelve su altura.
--Nota: la altura de un árbol (height en inglés), también llamada profundidad, es la cantidad de niveles del árbol. 
--La altura para EmptyT es 0, y para una hoja es 1.
heightT EmptyT            = 0 
heightT (NodeT _ izq der) = if heightT izq > heightT der 
                                then 1 + heightT izq  
                                else 1 + heightT der 