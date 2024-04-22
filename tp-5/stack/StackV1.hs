module StackV1 
            (Stack,
            emptyS,
            isEmptyS,
            push,
            top,
            pop,
            lenS) where 
data Stack a = S [a] Int 
                -- elementos / cantidad de elementos
emptyS :: Stack a
-- O(1) Porque se crea una instancia de tipo Stack. 
-- Crea una pila vacía.
emptyS = S [] 0 

isEmptyS :: Stack a -> Bool
-- Costo: O(1) por null sobre xs 
-- Dada una pila indica si está vacía.
isEmptyS (S xs _) = null xs 

push :: a -> Stack a -> Stack a
-- Dados un elemento y una pila, agrega el elemento a la pila.
-- O(1) ya que se hace agrega un elemento a la lista del stack. 
push e (S xs n)  = S (e:xs) (n+1) 

top :: Stack a -> a
-- Dada un pila devuelve el elemento del tope de la pila.
-- O(1) ya que se hace patter matching sobre la lista del stack. 
top (S (x:xs) _) = x  

pop :: Stack a -> Stack a
-- Dada una pila devuelve la pila sin el primer elemento.
-- O(1) ya que se hace patter matching sobre la lista del stack. 
pop (S (x:xs) n) = S xs n

lenS :: Stack a -> Int
-- Dada la cantidad de elementos en la pila.
-- Costo: constante.
lenS (S _ n) = n 

pila = push "ultimo" (push "5to" (push "4to" (push "3ero" (push "2do" (push "primero" emptyS )))))