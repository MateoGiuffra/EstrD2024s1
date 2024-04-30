-- Ejercicio 2
-- Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
-- invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
-- desbalancearse al insertar o borrar elementos). En todos los costos, N es la cantidad de elementos
-- del árbol. Justicar por qué la implementación satisface los costos dados.

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST e EmptyT            = False 
belongsBST e (NodeT x izq der) = e == x || belongsBST izq || belongsBST der 

insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMaxBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
esBST :: Tree a -> Bool
-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N2)
elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
elemento dado.
-- Costo: O(log N)
elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
elemento dado.
-- Costo: O(log N)
balanceado :: Tree a -> Bool
-- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- Costo: O(N2)