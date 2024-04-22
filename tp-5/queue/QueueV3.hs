-- Queue con dos listas
-- Implemente la interfaz de Queue pero en lugar de una lista utilice dos listas. Esto permitirá
-- que todas las operaciones sean constantes (aunque alguna/s de forma amortizada).


-- La estructura funciona de la siguiente manera. Llamemos a una de las listas fs (front stack) y
-- a la otra bs (back stack). Quitaremos elementos a través de fs y agregaremos a través de bs, pero
-- todas las operaciones deben garantizar el siguiente invariante de representación: Si fs se encuentra
-- vacía, entonces la cola se encuentra vacía.
-- ¾Qué ventaja tiene esta representación de Queue con respecto a la que usa una sola lista?

module QueueV3
        (Queue,
        emptyQ,
        isEmptyQ, 
        enqueue,
        firstQ,
        dequeue)
        where 

data Queue a = Q [a] [a] 
                -- firstQ  

dobleCola = enqueue 1 (enqueue 2 (enqueue 3 (enqueue 4 (enqueue 5 emptyQ ) )))
-- consultar bien como funciona cola con dos listas

emptyQ :: Queue a
-- Crea una cola vacía.
emptyQ = Q [] []

isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
isEmptyQ (Q fs bs) = null fs 

enqueue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue e (Q fs bs) = if null fs 
                        then (Q (e:fs) bs) 
                        else (Q fs (e:bs)) 

firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
firstQ (Q fs _) = head fs 
                         


dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
dequeue (Q fs bs) = if null fs 
                       then Q  bs []
                       else Q (tail fs) bs 

dequeue :: Queue a -> Queue a
dequeue (Q fs bs) =
    if null (tail fs)
     then Q (reverse bs) []
     else Q (tail fs) bs

-- Q  [] [4,3,2,1]



