import MapV1 
import SetV1 

type Title    = String
type Author   = String
type ISBN     = String
type Keyword  = String

data Book = B Title Author ISBN (Set Keyword) 
                    deriving (Show, Eq)

data Library = L (Map ISBN Book) 
                    deriving (Show, Eq)

-- Vamos a diseñar un TAD llamado Library. La idea de esta estructura es manejar una biblioteca de libros,
-- donde cada libro tiene un título, un autor, un ISBN (número único de identificación) y un conjunto de palabras clave.
-- Los libros se almacenan en un Map (donde la clave es el ISBN) y se deben proporcionar operaciones
-- para agregar libros, eliminar libros, buscar libros por diferentes criterios (ISBN, autor, palabra clave) y
-- obtener listas de libros ordenadas por título o por autor.

{-
    INV.REP: 
        * El ISBN de un libro debe ser el mismo ISBN con el que esta asociado como clave en el Map.
-}
addBook :: Book -> Library -> Library
--Propósito: Agrega un nuevo libro a la biblioteca si no existe ya un libro con el mismo ISBN.
--Eficiencia: O(log n) donde n es el número de libros en la biblioteca.
-- por assocM es logaritmico 
addBook b (L map) = L (assocM (isbnDe b) b map)

isbnDe :: Book -> ISBN 
isbnDe (B _ _ i _) = i 

removeBook :: ISBN -> Library -> Library
--Propósito: Elimina un libro de la biblioteca por su ISBN.
--Eficiencia: O(log n) donde n es el número de libros en la biblioteca.
removeBook i (L m) = L (deleteM i m) 

findBookByISBN :: ISBN -> Library -> Maybe Book
--Propósito: Busca un libro en la biblioteca por su ISBN y devuelve Just Book si lo encuentra, Nothing en caso contrario.
--Eficiencia: O(log n) donde n es el número de libros en la biblioteca.
findBookByISBN i (L m) = lookupM i m 

findBooksByAuthor :: Author -> Library -> [Book]
--Propósito: Devuelve una lista de libros de un autor específico.
--Eficiencia: O(n) donde n es el número de libros en la biblioteca.
--EFICIENCIA: O(n*log n) # por booksOf, como i y K salen del mismo map, entonces i y K son n. Tambien se usa keysM de costo n, pero 
-- el costo n * log n a la larga va a ser mas costoso, por eso queda solo ese como costo.  
findBooksByAuthor a (L m) = booksOf a (keysM m) m  

booksOf :: Author -> [ISBN] -> Map ISBN Book -> [Book]
-- PROPOSITO: Dado un autor, una lista de ISBN y un Map ISBN Book, devuelve todos los books escrito por el autor dado.
-- EFICIENCIA:O(i log K) 
-- O(i   # siendo i la longitud de la lista de ISBN ya que se hace RE sobre la misma. 
-- *     # por la RE 
-- Log K # por lookupM sobre el map dado.    
--)
booksOf a [] m = []
booksOf a (i:is) m = case lookupM i m of 
                        Nothing -> booksOf a is m 
                        Just b  -> if writtenBy a b 
                                    then b : booksOf a is m 
                                    else booksOf a is m

writtenBy :: Author -> Book -> Bool 
writtenBy a (B _ a' _ _) = a == a' 

findBooksByKeyword :: Keyword -> Library -> [Book]
--Propósito: Devuelve una lista de libros que contienen una palabra clave específica.
--Eficiencia: O(n) donde n es el número de libros en la biblioteca.
--EFICIENCIA: O(n*log n + log S) 
-- O(n*log n + log S) # por booksOf, como i y K salen del mismo map, entonces i y K son n. Tambien se usa keysM de costo n, pero 
-- el costo n * log n a la larga va a ser mas costoso, por eso queda solo ese como costo.  
findBooksByKeyword k (L m) = booksWith k (keysM m) m  

booksWith :: Keyword -> [ISBN] -> Map ISBN Book -> [Book]
-- PROPOSITO: Dado una keyword, una lista de ISBN y un Map ISBN Book, devuelve todos los books que contienen la keyword dada.
-- EFICIENCIA:O(i log K + log S) 
-- O(i   # siendo i la longitud de la lista de ISBN ya que se hace RE sobre la misma. 
-- *     # por la RE 
-- Log K # por lookupM sobre el map dado.    
-- + 
-- Log S # por haveSameK 
--)
booksWith a [] m = []
booksWith a (i:is) m = case lookupM i m of 
                        Nothing -> booksWith a is m 
                        Just b  -> if haveSameK a b 
                                    then b : booksWith a is m 
                                    else booksWith a is m

haveSameK :: Keyword -> Book -> Bool 
-- PROPOSITO: Indicia si la keyword dada existe como keyword en el book dado. 
-- EFICIENCIA: O(Log S) 
-- Log S por belongsS sobre el set Keyword del book. 
haveSameK k (B _ _ _ setK) =  belongsS k setK

getBooksSortedByTitle :: Library -> [Book]
--Propósito: Devuelve una lista de libros ordenados alfabéticamente por título.
--Eficiencia: O(n log n) donde n es el número de libros en la biblioteca.
--EFICIENCIA: O(n*( log n + n)) # siendo n la cantidad de books en la biblioteca. 
getBooksSortedByTitle (L m) =  booksSortedByTitle (keysM m) m 

booksSortedByTitle :: [ISBN] -> Map ISBN Book -> [Book]
--Propósito: Devuelve una lista de libros ordenados alfabéticamente por título.
--Eficiencia: O(i*( log K + i))
-- O(i # siendo i la longitud de la lista de ISBN ya que se hace RE sobre la misma. 
-- *   # por cada i de is se hace 
-- log K # por lookupM sobre el map. 
-- + 
-- i   # por addBookInOrder sobre la RE, que depende de la cantidad de ISBN. 
booksSortedByTitle []     m = []
booksSortedByTitle (i:is) m = case lookupM i m of 
                                Just b  -> addBookInOrder b (booksSortedByTitle is m)  
                                Nothing -> booksSortedByTitle is m

addBookInOrder :: Book -> [Book] -> [Book] 
-- PROPOSITO: Dado un book y una lista de book, devuelve la lista de books actualizada con el book dado agregado en orden alfabetico 
-- segun el titulo.
-- EFICIENCIA: O(b) siendo b la longitud de Book.
addBookInOrder b    []   = [b]
addBookInOrder b1 (b:bs) = if (titleOf b1 > titleOf b) 
                            then (b:b1:bs)
                            else  b : addBookInOrder b1 bs 
titleOf :: Book -> Title
-- PROPOSITO: Devuelve el titulo del book dado.
-- EFICIENCIA: O(1) # por patter matching sobre Book.  
titleOf (B t _ _ _) = t 

getBooksSortedByAuthor :: Library -> [Book]
--Propósito: Devuelve una lista de libros ordenados alfabéticamente por autor.
--Eficiencia: O(n log n) donde n es el número de libros en la biblioteca.
getBooksSortedByAuthor = undefined



-- ==============================================================================================================================================================================
--                  Anexo de interfaces                 Anexo de interfaces                 Anexo de interfaces
-- ==============================================================================================================================================================================


-- La interfaz de Map, siendo K la cantidad de claves distintas en el map:

-- emptyM :: Map k v                                O(1)
-- assocM :: Ord k => k -> v -> Map k v -> Map k v  O(log K)
-- lookupM :: Ord k => Map k v -> k -> Maybe v      O(log K)
-- deleteM :: Ord k => k ->Map k v -> Map k v       O(log K)
-- keysM :: Map k v -> [k]                           O(K)


-- Set, siendo S la cantidad de elementos del conjunto:

-- emptyS :: Set a                                  O(1)
-- addS :: a -> Set a -> Set a                      O(log S)
-- belongsS :: a -> Set a -> Bool                   O(log S)
-- unionS :: Set a -> Set a -> Set a                O(S log S)
-- setToList :: Set a -> [a]                        O(S)
-- sizeS :: Set a -> Int                            O(1)
