module QueueV1
        (Queue,
        emptyQ,
        isEmptyQ, 
        enqueue,
        firstQ,
        dequeue)
        where 

data Queue a = Q [a] 

-- Implemente el tipo abstracto Queue utilizando listas. Los elementos deben encolarse por el
-- nal de la lista y desencolarse por delante.

cola = enqueue 1 (enqueue 2 (enqueue 3 (enqueue 4 (enqueue 5 emptyQ ) )))

--O(1)
emptyQ :: Queue a
-- Crea una cola vacía.
emptyQ = Q []


--O(1) por null sobre xs 
isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
isEmptyQ (Q xs) = null xs 

--O(1) porque se usa el cons 
enqueue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue e (Q xs) = (Q (e:xs))

-- O(n) ya que se usa last sobre xs  
firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
firstQ (Q xs) = last xs

-- O(n) porque se usa sinPrimerElemento sobre xs 
dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
dequeue (Q xs )= Q (sinPrimerElemento xs) 


-- O(n # siendo n la longitud de la lista 
-- )
sinPrimerElemento :: [a] -> [a]
-- Precondicion: La lista no puede ser vacia 
sinPrimerElemento (x:[]) = []
sinPrimerElemento (x:xs) = x : sinPrimerElemento xs

