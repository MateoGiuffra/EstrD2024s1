module QueueV2
        (Queue,
        emptyQ,
        isEmptyQ, 
        enqueue,
        firstQ,
        dequeue)
        where 

data Queue a = Q [a] 

-- Implemente ahora la versión que agrega por delante y quita por el nal de la lista. Compare
-- la eciencia entre ambas implementaciones.

cola2 = enqueue 1 (enqueue 2 (enqueue 3 (enqueue 4 (enqueue 5 emptyQ ) )))


emptyQ :: Queue a
-- Crea una cola vacía.
emptyQ = Q []


isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
isEmptyQ (Q xs) = null xs 


enqueue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue e (Q xs)  = (Q (xs ++ [e]))


firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
firstQ (Q (x:_))  = x


dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
dequeue (Q (x:xs)) = Q xs 
