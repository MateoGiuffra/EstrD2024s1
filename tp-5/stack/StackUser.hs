import StackV1

apilar :: [a] -> Stack a
-- Dada una lista devuelve una pila sin alterar el orden de los elementos.
apilar []     = emptyS 
apilar (x:xs) = push x (apilar xs) 

desapilar :: Stack a -> [a]
-- Dada una pila devuelve una lista sin alterar el orden de los elementos.
desapilar s = if isEmptyS s 
                then []
                else top s : desapilar (pop s) 

insertarEnPos :: Int -> a -> Stack a -> Stack a
-- Dada una posicion válida en la stack y un elemento, ubica dicho elemento en dicha
-- posición (se desapilan elementos hasta dicha posición y se inserta en ese lugar).
insertarEnPos n e s = if isEmptyS s 
                        then s 
                        else if n == 0 
                            then push e (push (top s) (insertarEnPos (n-1) e (pop s)))
                            else push (top s) (insertarEnPos (n-1) e (pop s)) 
-- no entiendo bien el proposito de este, no se como quedaria


pila = push "ultimo" (push "5to" (push "4to" (push "3ero" (push "2do" (push "primero" emptyS )))))