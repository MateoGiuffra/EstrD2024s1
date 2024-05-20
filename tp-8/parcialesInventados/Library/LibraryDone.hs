import qualified Data.Map as Map
import qualified Data.Set as Set
import Data.List (sortBy)
import Data.Ord (comparing)

-- Agregar un libro si no existe uno con el mismo ISBN
addBook :: Book -> Library -> Library
addBook newBook (Library books) =
    if Map.member (isbn newBook) books
    then Library books
    else Library (Map.insert (isbn newBook) newBook books)

-- Eliminar un libro por ISBN
removeBook :: String -> Library -> Library
removeBook isbnRemove (Library books) =
    Library (Map.delete isbnRemove books)

-- Buscar un libro por ISBN
findBookByISBN :: String -> Library -> Maybe Book
findBookByISBN isbnSearch (Library books) =
    Map.lookup isbnSearch books

-- Buscar libros por autor
findBooksByAuthor :: String -> Library -> [Book]
findBooksByAuthor authorSearch (Library books) =
    filter (\book -> author book == authorSearch) (Map.elems books)

-- Buscar libros por palabra clave
findBooksByKeyword :: String -> Library -> [Book]
findBooksByKeyword keywordSearch (Library books) =
    filter (\book -> Set.member keywordSearch (keywords book)) (Map.elems books)

-- Obtener libros ordenados alfabéticamente por título
getBooksSortedByTitle :: Library -> [Book]
getBooksSortedByTitle (Library books) =
    sortBy (comparing title) (Map.elems books)

-- Obtener libros ordenados alfabéticamente por autor
getBooksSortedByAuthor :: Library -> [Book]
getBooksSortedByAuthor (Library books) =
    sortBy (comparing author) (Map.elems books)


-- Crear algunos libros
let book1 = Book "Haskell Programming" "Author A" "ISBN123" (Set.fromList ["programming", "functional"])
let book2 = Book "Learn You a Haskell" "Author B" "ISBN456" (Set.fromList ["haskell", "tutorial"])
let book3 = Book "Real World Haskell" "Author A" "ISBN789" (Set.fromList ["haskell", "practical"])

-- Crear una biblioteca vacía
let emptyLibrary = Library Map.empty

-- Agregar libros a la biblioteca
let library1 = addBook book1 emptyLibrary
let library2 = addBook book2 library1
let library3 = addBook book3 library2

-- Buscar un libro por ISBN
findBookByISBN "ISBN456" library3

-- Buscar libros por autor
findBooksByAuthor "Author A" library3

-- Buscar libros por palabra clave
findBooksByKeyword "haskell" library3

-- Obtener libros ordenados por título
getBooksSortedByTitle library3

-- Obtener libros ordenados por autor
getBooksSortedByAuthor library3
