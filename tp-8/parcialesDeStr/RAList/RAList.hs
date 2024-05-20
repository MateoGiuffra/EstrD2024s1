module RAList (RAList,
                emptyRAL,
                isEmptyRAL,
                get,
                lengthRAL,
                minRAL,
                add,
                elems,
                remove,
                set,
                addAt) where

import MapV1
import MinHeap 
data RAList a = MkR Int (Map Int a) (MinHeap a)
-- En dicha representación se observa:
-- Un Int, que representa la próxima posición a ocupar en la lista. Es decir, cuando se agregue un elemento al final, debe
-- agregarse en dicha posición, que luego será incrementada. Cuando la estructura está vacía, el número es 0.
-- Un Map Int a, que representa la relación entre índices (claves) y valores de la estructura.
-- Una Heap a que contiene todos los valores de la estructura

{-
    INV.REP:
            En MkR i (map mi ma) (heap a):
        * Los a del heap tienen que ser los mismos que los ma del map y viceversa. 
        * i debe ser igual a la cantidad de elementos del map o del heap. Y si es 0, entonces el map y el heap estan vacios.  
        * El primer mi del map tiene que ser 0 y a medida de que ingresen nuevos elemento, mi tiene que ir aumentando en uno. 
        * El ultimo mi del map tiene que ser igual a i-1.
-}

ral = add "F" 
      $ add "E" 
      $ add "D" 
      $ add "C" 
      $ add "B" 
      $ add "A" emptyRAL

-- a) 
emptyRAL :: RAList a
-- Propósito: devuelve una lista vacía.
-- Eficiencia: O(1) # porque se usa el constructor, emptyM y emptyH que son de costo constante. 
emptyRAL = MkR 0 emptyM emptyH
-- b) 
isEmptyRAL :: RAList a -> Bool
-- Propósito: indica si la lista está vacía.
-- Eficiencia: O(1) # por == sobre numeros. 
isEmptyRAL (MkR n m h) = n == 0
-- c) 
lengthRAL :: RAList a -> Int
-- Propósito: devuelve la cantidad de elementos.
-- Eficiencia: O(1) # por hacer patter matching sobre la RAL y restar numeros. 
lengthRAL (MkR n m h) = (n - 1)
-- d) 
get :: Int -> RAList a -> a
-- Propósito: devuelve el elemento en el índice dado.
-- Precondición: el índice debe existir.
-- Eficiencia: O(log N) # por lookupM sobre el m, siendo N la cantidad de elemnentos de la RAList.
get n (MkR i m h) = case lookupM n m  of
                        Nothing -> error"No existe el indice" 
                        Just a  -> a 
-- e) 
minRAL :: Ord a => RAList a -> a
-- Propósito: devuelve el mínimo elemento de la lista.
-- Precondición: la lista no está vacía.
-- Eficiencia: O(1) # porque se usa findMin sobre h. 
minRAL (MkR n m h) = findMin h 
-- f) 
add :: Ord a => a -> RAList a -> RAList a
-- Propósito: agrega un elemento al final de la lista.
-- Eficiencia: O(log N). # por assocM sobre el map e insertH sobre el heap, siendo N la cantidad de elementos de la estructura. 
add e (MkR n m h) =  if n == 0 
                  then MkR 1 (assocM 0 e m) (insertH e h)                  
                  else MkR (n+1) (assocM n e m) (insertH e h) 
-- g) 
elems :: Ord a => RAList a -> [a]
-- Propósito: transforma una RAList en una lista, respetando el orden de los elementos.
-- Eficiencia: O(N log N).
-- N # por keys sobre el map. 
-- + 
-- N* log N # por elementosDe, ya que la cantidad de elementos del map y la longitud de la lista de Ints son el mismo. 
-- N + (N * log N)
-- N * (1 + logN) # por igualdad.
-- N log N        # porque no importa la constante 1.
elems (MkR n m h) = elementosDe (keys m) m 

elementosDe :: Ord a => [Int] -> Map Int a -> [a]
-- PROPOSITO:Dada una lista de Ints, un Map de tipo Int a, te devuelve todos los elementos que estan asociados a los Ints dados.  
-- EFICIENCIA: O(n*log K)
-- O(n   # siendo n la longitud de la lista de Ints, ya que se hace RE sobre la misma. 
-- *     # por cada n de ns se hace: 
-- log K # lookupM sobre el map dado, siendo K la cantidad de elementos del map.
-- )
-- O(n*log K)
elementosDe [] m = []
elementosDe (n:ns) m = case lookupM n m of
                        Nothing -> elementosDe ns m 
                        Just a  -> a : elementosDe ns m  

-- h) 
remove :: Ord a => RAList a -> RAList a
-- Propósito: elimina el último elemento de la lista.
-- Precondición: la lista no está vacía.
-- Eficiencia: O(N log N).
-- log K + H * Log H # por eliminarElemento, pero como el map y el heap tienen la misma cantidad de elementos, entonces K y H son N
-- quedaria: log N + N log N 
-- N log N # porque es de mayor costo.
remove (MkR n m h) = if n == 0 
                        then error"La RAL no puede estar vacia"
                        else let (m',h') = eliminarElemento (n-1) m h in 
                             MkR (n-1) m' h' 

eliminarElemento :: Ord a => Int -> Map Int a -> MinHeap a -> (Map Int a, MinHeap a)
-- PROPOSITO: Elimina el elemento asociado al int dado del map y el heap. Si el Int no existe en el map, te devuelve el mismo map y heap.
-- EFICIENCIA: O(log K + H * Log H)
-- log K # por lookupM siendo K la cantidad de elementos del map. 
-- + 
-- log K # por deleteM sobre el map. 
-- + 
-- H * Log H # por borrarElemH sobre el heap, siendo H su cantidad de elementos.
-- log K + log K + H * Log H 
-- 2log K + H * Log H  # por agrupacion de terminos semejantes. 
-- log K + (H * Log H)   
eliminarElemento n map heap = case lookupM n map of
                                    Nothing -> (map,heap)
                                    Just a  -> (deleteM n map, borrarElemH a heap)  

borrarElemH :: Ord a => a -> MinHeap a -> MinHeap a 
-- PROPOSITO: Borra el elemento dado del heap. 
-- EFICIENCIA: O(H * Log H)
-- O(H # siendo H la cantidad de elementos del Heap, ya que se hace RE sobre la misma. 
-- *   # por cada a del heap se hace:  
--(1   # findMin sobre el heap 
-- +
-- log H # por insertH
-- + 
-- log H # por deleteMin sobre el heap
-- )
-- O(H * (1 + Log H + Log H))
-- O(H * (1 + 2Log H)) # por agrupacion de terminos semejantes. 
-- O(H * (Log H))      # porque no importan las constantes 2 y 1. 
borrarElemH a emptyH = emptyH 
borrarElemH a mh     = if a == findMin mh 
                        then borrarElemH a mh 
                        else insertH (findMin mh) (borrarElemH a (deleteMin mh))

-- i) 
set :: Ord a => Int -> a -> RAList a -> RAList a
-- Propósito: reemplaza el elemento en la posición dada.
-- Precondición: el índice debe existir.
-- Eficiencia: O(N log N).
-- log K + H * Log H # por reemplazarElemento, pero como el map y el heap tienen la misma cantidad de elementos, entonces K y H son N
-- quedaria: log N + N log N 
-- N log N # porque es de mayor costo 
set m a (MkR n map h) = let (m',h') = reemplazarElemento m a map h in 
                            (MkR n m' h')



reemplazarElemento ::Ord a => Int -> a -> Map Int a -> MinHeap a -> (Map Int a, MinHeap a)
-- PROPOSITO: Reemplaza el elemento asociado al int dado con "a" en el map y en el heap. Si el Int no existe en el map, te devuelve el mismo map y heap.
-- EFICIENCIA: O(log K + H * Log H)
-- log K # por lookupM siendo K la cantidad de elementos del map. 
-- + 
-- log K #por de assocM sobre el map. 
-- + 
-- H * Log H # por borrarElemH sobre el heap, siendo H su cantidad de elementos.
-- log K + log K + H * Log H 
-- 2log K + H * Log H  # por agrupacion de terminos semejantes. 
-- log K + H * Log H 
reemplazarElemento n a map heap = case lookupM n map of
                                    Nothing -> (map,heap)
                                    Just b  -> ((assocM n a map), (reemplazarElementoH b a heap))

reemplazarElementoH :: Ord a => a -> a -> MinHeap a -> MinHeap a 
-- PROPOSITO: Reemplaza el primer elemento dado por el segundo dado en el heap. 
-- EFICIENCIA: O(H * Log H)
-- O(H # siendo H la cantidad de elementos del Heap, ya que se hace RE sobre la misma. 
-- *   # por cada h del heap se hace:  
--(1   # findMin sobre el heap 
-- +
-- log H 
-- + 
-- log H insertH y deleteMin sobre el heap, ambos del mismo costo 
-- )
-- O(H * (1 + Log H + Log H))
-- O(H * (1 + 2Log H)) # por agrupacion de terminos semejantes. 
-- O(H * (Log H))      # porque no importan las constantes 2 y 1. 
reemplazarElementoH b a emptyH = emptyH 
reemplazarElementoH b a mh     = if b == findMin mh 
                                    then insertH a (reemplazarElementoH b a (deleteMin mh)) 
                                    else insertH (findMin mh) (reemplazarElementoH b a (deleteMin mh))

-- j) 
addAt :: Ord a => Int -> a -> RAList a -> RAList a
-- Propósito: agrega un elemento en la posición dada.
-- Precondición: el índice debe estar entre 0 y la longitud de la lista.
-- Observación: cada elemento en una posición posterior a la dada pasa a estar en su posición siguiente.
-- Eficiencia: O(N log N).
-- Sugerencia: definir una subtarea que corra los elementos del Map en una posición a partir de una posición dada. Pasar
-- también como argumento la máxima posición posible
-- EFICIENCIA:  
-- K(Log K) # por agregarYDesplazar sobre el map, como K es N ya que N es la cantidad de elementos del map, quedaria:
-- N log N 
-- + 
-- log N   # por insertH sobre el heap.   
-- log N + N Log N 
-- N Log N # porque N Log N es mas costoso. 
addAt i a (MkR n map h) = MkR (n+1) (agregarYDesplazar n i a map) (insertH a h)

agregarYDesplazar :: Int -> Int -> a -> Map Int a -> Map Int a 
-- PROPOSITO: Agrega el elemento dado en el indice dado y desplaza todos los indices despues de ese. 
-- Precondición: el índice debe estar entre 0 y la longitud de la lista.
-- EFICIENCIA: K(Log K)  
-- K       # siendo K la cantidad de elementos del map, ya que se hace RE sobre la misma. 
-- *       # por cada Int del map se hace:  
-- ( log K # por assocM sobre la RE.
-- + 
-- ( log K # por lookupM sobre el map.
-- K*(log K + log K)
-- K*(2log K )         # por agrupacion de terminos semejantes. 
-- K(Log K)            # porque no importa la constante 2. 
agregarYDesplazar mx n a map = if n > mx || n < 0
                                then error "El índice debe estar entre 0 y la longitud de la lista."
                                else (assocM n a (case lookupM n map of
                                      Nothing -> map 
                                      Just x  -> assocM (n+1) x (agregarYDesplazar mx (n+1) a map))) 
                                



-- else (assocM n a (desplazar (lookupM n map) n map))
desplazar :: Maybe a -> Int  -> Map Int a -> Map Int a 
desplazar Nothing _  m = m 
desplazar (Just a) n m = assocM (n+1) a m 

-- ==============================================================================================================================================================================
--                  Anexo de interfaces                 Anexo de interfaces                 Anexo de interfaces
-- ==============================================================================================================================================================================


-- La interfaz de Map, siendo K la cantidad de claves distintas en el map:

-- emptyM :: Map k v                                O(1)
-- assocM :: Ord k => k -> v -> Map k v -> Map k v  O(log K)
-- lookupM :: Ord k => Map k v -> k -> Maybe v      O(log K)
-- deleteM :: Ord k => k ->Map k v -> Map k v       O(log K)
-- keysM :: Map k v -> [k]                           O(K)


-- La interfaz de Heap, siendo H la cantidad de elementos en la heap:

-- emptyH :: Heap a                                 O(1)
-- isEmptyH :: Heap a -> Bool                       O(1)
-- findMin :: Heap a -> a                           O(1)
-- insertH :: Ord a => a -> Heap a -> Heap a        O(log H)
-- deleteMin :: Ord a => Heap a -> Heap a           O(log H)

