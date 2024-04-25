-- Ejercicio 1
-- La siguiente interfaz representa colas de prioridad, llamadas priority queue, en inglés. La misma
-- posee operaciones para insertar elementos, y obtener y borrar el mínimo elemento de la estructura.
-- Implementarla usando listas, e indicando el costo de cada operación.

module PriorityQueueV1
                    (PriorityQueue,
                    emptyPQ,
                    isEmptyPQ,
                    insertPQ,
                    findMinPQ,
                    deleteMinPQ) where
data PriorityQueue a = PQ [a]
 
emptyPQ :: PriorityQueue a
-- Propósito: devuelve una priority queue vacía.
-- O(1) porque se usa el constructor. 
emptyPQ = PQ []


isEmptyPQ :: PriorityQueue a -> Bool
-- Propósito: indica si la priority queue está vacía.
-- O(1) porque se usa null sobre xs 
isEmptyPQ (PQ xs) =  null xs 

insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a
-- Propósito: inserta un elemento en la priority queue.
-- O(n) # siendo n la longitud de xs porque se usa agregarEnOrden sobre la misma.   
insertPQ e (PQ xs) = PQ (agregarEnOrden e xs) 

agregarEnOrden :: Ord a => a -> [a] -> [a]
-- PROPOSITO: Dado un elemento lo agrega en la lista para que quede ordenada de manera ascendiente. 
-- O(n # siendo n la longitud de xs ya que se hace RE sobre la misma. 
-- *(1 ya que por cada recursion, se compara el elemento dado con un elemento de xs) 
-- )
-- O(n) 
agregarEnOrden e [] = [e]
agregarEnOrden e (x:xs) = if e < x 
                            then e : (x:xs) 
                            else x : agregarEnOrden e xs  

findMinPQ :: Ord a => PriorityQueue a -> a
-- Propósito: devuelve el elemento más prioriotario (el mínimo) de la priority queue.
-- Precondición: parcial en caso de priority queue vacía.
-- O(1) porque se usa head sobre xs 
findMinPQ (PQ xs) = head xs 

deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a
-- Propósito: devuelve una priority queue sin el elemento más prioritario (el mínimo).
-- Precondición: parcial en caso de priority queue vacía
-- O(1) porque se usa tail sobre xs 
deleteMinPQ (PQ xs) =  PQ (tail xs) 

pq = insertPQ 10 
     $ insertPQ 12 
     $ insertPQ 8 
     $ insertPQ 20 emptyPQ