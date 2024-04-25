import PriorityQueueV1
-- Ejercicio 2
-- Implementar la función heapSort :: Ord a => [a] -> [a], que dada una lista la ordena de
-- menor a mayor utilizando una Priority Queue como estructura auxiliar. ¾Cuál es su costo?
-- OBSERVACIÓN: el nombre heapSort se deb e a una implementación particular de las Priority
-- Queues basada en una estructura concreta llamada Heap, que será traba jada en la siguiente
-- práctica.

heapSort :: Ord a => [a] -> [a]
heapSort xs = pqToList (insertListToPQ xs emptyPQ) 

insertListToPQ :: Ord a => [a] -> PriorityQueue a  -> PriorityQueue a 
insertListToPQ [] pq     = pq 
insertListToPQ (x:xs) pq = insertPQ x (insertListToPQ xs pq) 

pqToList :: Ord a => PriorityQueue a -> [a]
pqToList pq = if isEmptyPQ pq 
                then []
                else findMinPQ pq : (pqToList (deleteMinPQ  pq))