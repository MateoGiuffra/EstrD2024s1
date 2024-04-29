import PriorityQueueV1
-- Ejercicio 2
-- Implementar la función heapSort :: Ord a => [a] -> [a], que dada una lista la ordena de
-- menor a mayor utilizando una Priority Queue como estructura auxiliar. ¾Cuál es su costo?
-- OBSERVACIÓN: el nombre heapSort se deb e a una implementación particular de las Priority
-- Queues basada en una estructura concreta llamada Heap, que será traba jada en la siguiente
-- práctica.

heapSort :: Ord a => [a] -> [a]
-- EFICIENCIA: O(m + m^2)
-- O( m  # por pqToList  
-- +
-- (m^2) # por insertListToPQ
-- )
-- O(m+m^2)
-- O(m^2) ?? estabien?
heapSort xs = pqToList (insertListToPQ xs emptyPQ) 

insertListToPQ :: Ord a => [a] -> PriorityQueue a  -> PriorityQueue a 
-- EFICIENCIA: O(n^2)
-- O( n # siendo n la longitud de la lista de xs ya que se hace RE sobre la misma.
-- *    # por cada x de xs se hace:
-- (n   # por insertPQ en la RE 
-- ))
-- O(n^2)
insertListToPQ [] pq     = pq 
insertListToPQ (x:xs) pq = insertPQ x (insertListToPQ xs pq) 

pqToList :: Ord a => PriorityQueue a -> [a]
-- EFICIENCIA: O(n) 
-- O(n # siendo n la cantidad de elementos de pq ya que se hace RE sobre la misma.
-- *  
-- 1   # por findMinPQ, deleteMinPQ y cons 
-- )
pqToList pq = if isEmptyPQ pq 
                then []
                else findMinPQ pq : (pqToList (deleteMinPQ  pq))
                
-- findMinPQ -  deleteMinPq - insertPQ
-- 1            1             n    