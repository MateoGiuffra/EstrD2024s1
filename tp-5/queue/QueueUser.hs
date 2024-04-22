import QueueV3

-- 3. Como usuario del tipo abstracto Queue implementar las siguientes funciones:
lengthQ :: Queue a -> Int
-- Cuenta la cantidad de elementos de la cola.
lengthQ q = if isEmptyQ q 
                then 0 
                else 1 + lengthQ (dequeue q) 

queueToList :: Queue a -> [a]
-- Dada una cola devuelve la lista con los mismos elementos,
-- donde el orden de la lista es el de la cola.
-- Nota: chequear que los elementos queden en el orden correcto.
queueToList q = if isEmptyQ q 
                    then []
                    else firstQ q : queueToList (dequeue q) 

unionQ :: Queue a -> Queue a -> Queue a
-- Inserta todos los elementos de la segunda cola en la primera.
unionQ q1 q2 = if isEmptyQ q1 
                then q2 
                else enqueue (firstQ q1 ) (unionQ (dequeue q1) q2)

cola1 = enqueue 1 (enqueue 2 (enqueue 3 (enqueue 4 (enqueue 5 emptyQ ) )))
cola2 = enqueue 10 (enqueue 20 (enqueue 30 (enqueue 40 (enqueue 50 emptyQ ) )))
dobleCola = enqueue 1 (enqueue 2 (enqueue 3 (enqueue 4 (enqueue 5 emptyQ ) )))
