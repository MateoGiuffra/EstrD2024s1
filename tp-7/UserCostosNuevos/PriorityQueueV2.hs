--import PriorityQueueV1

-- Ejercicio 2
-- Indicar el costo de heapsort :: Ord a => [a] -> [a] (de la práctica anterior) suponiendo que
-- el usuario utiliza una priority queue con costos logarítmicos de inserción y borrado (o sea, usa una
-- Heap como tipo de representación).


heapSort :: Ord a => [a] -> [a]
-- EFICIENCIA:O(m * (log m))
-- O(n*(log n))   # por pqToList siendo n la longitud de la lista
-- + 
-- O(n * (log n)) # por insertListToPQ
-- O(n * (log n) + n * (log n))
-- O(n * (log n)) # porque se suprime 
heapSort xs = pqToList (insertListToPQ xs emptyPQ) 

insertListToPQ :: Ord a => [a] -> PriorityQueue a  -> PriorityQueue a 
-- EFICIENCIA: O(m*(log m) 
-- O(m  # siendo m la longitud de la lista ya que se hace RE sobre la misma. 
-- *    # por cada x de xs 
-- (log m   # por insertPQ sobre RE       
-- ))
-- O(m * (log m))
insertListToPQ [] pq     = pq 
insertListToPQ (x:xs) pq = insertPQ x (insertListToPQ xs pq) 

pqToList :: Ord a => PriorityQueue a -> [a]
-- EFICIENCIA:O(n*(log n))
-- O(n   # siendo n los elementos de la pq ya que se hace RE sobre la misma.
-- *     # por la RE 
-- (1    # por findMinPQ sobre la RE 
-- + 
-- log n # por deleteMinPQ sobre pq     
-- ))
-- O(n*(1+log n))
-- O(n*(log n))
pqToList pq = if isEmptyPQ pq 
                then []
                else findMinPQ pq : (pqToList (deleteMinPQ  pq))
                
-- findMinPQ -  deleteMinPq - insertPQ
-- 1            log n         log n
