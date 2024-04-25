-- Especicar el costo operacional de las siguientes funciones:

-- abrir constructores, operaciones matematicas, de  comparacion (depende que, si es un TAD o String etc  consultar),
-- operadores logicos, cons son de costo 1
                                             

-- O(1) porque se hace patter matching sobre la lista
head' :: [a] -> a
head' (x:xs) = x

-- O(1) porque se usa +  que es de costo constante. 
sumar :: Int -> Int
sumar x = x + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1

-- O(n) siendo n el numero dado, ya que se hace RE n veces. 
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

-- O(n) siendo n la longitud de la lista ya que se hace RE sobre la misma. 
longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

-- O( n # siendo n la longitud de la lista ya que se hace RE sobre la misma.  
-- *
-- ( m  # siendo m el numero dado, ya que se hace RE m veces. 
-- ))
-- O(n*m)
factoriales :: [Int] -> [Int]
factoriales [] = []
factoriales (x:xs) = factorial x : factoriales xs

-- O(n # siendo n la longitud de la lista ya que se hace RE sobre la misma.  
-- *
-- ( 1 porque se usa || por cada elemento de la lista en el peor caso.  
-- ))
-- O(n*1)
-- O(n)
pertenece :: Eq a => a -> [a] -> Bool
pertenece n [] = False
pertenece n (x:xs) = n == x || pertenece n xs

-- O(n # siendo n la longitud de la lista ya que se hace RE sobre la misma.
-- *
-- ( n #  siendo n la longitud de la lista ya que se hace elem del mismo costo. 
-- ))
-- O(n*n)
-- O(n^2)
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if elem x xs
                            then sinRepetidos xs
                            else x : sinRepetidos xs

-- equivalente a (++)
-- O(n # siendo n la longitud de la lista ya que se hace RE sobre la misma.
-- *
-- ( 1 ya que se hace const en la lista
-- ))
-- O(n*1)
-- O(n)
append :: [a] -> [a] -> [a]
append [] ys = ys
append (x:xs) ys = x : append xs ys

-- O(n # siendo n la longitud de la lista ya que se hace RE sobre la misma.
-- *
-- ( m # siendo m el costo del append por cada elemento de la lista
-- ))
-- O(n+m)
concatenar :: [String] -> String
concatenar [] = []
concatenar (x:xs) = x ++ concatenar xs


-- O(n # siendo n el numero menor entre el Int dado y la longitud de la lista )
-- O(n)
takeN :: Int -> [a] -> [a]
takeN 0 xs = []
takeN n [] = []
takeN n (x:xs) = x : takeN (n-1) xs

-- O(n # siendo n el numero menor entre el Int dado y la longitud de la lista )
-- O(n)
dropN :: Int -> [a] -> [a]
dropN 0 xs = xs
dropN n [] = []
dropN n (x:xs) = dropN (n-1) xs


-- O(n # por el takeN de la lista
-- + 
-- n # por el dropN de la lista
-- )
-- O(n+n)
-- O(2n)
-- O(n)
partir :: Int -> [a] -> ([a], [a])
partir n xs = (takeN n xs, dropN n xs)

-- O(n # siendo n la longitud de la lista ya que se hace RE sobre la misma.
-- * (
-- 1 # por min de la lista    
-- ))
-- O(n*1)
-- O(n)

minimo :: Ord a => [a] -> a
minimo [x]    = x
minimo (x:xs) = min x (minimo xs)


-- O(n donde n es la longitud de la lista porque se realiza RE sobre la misma
-- *
-- ( 1 # por == en la lista
-- ))
-- O(n*1)
-- O(n)
sacar :: Eq a => a -> [a] -> [a]
sacar n []     = []
sacar n (x:xs) = if n == x
                    then xs
                    else x : sacar n xs

-- O(n donde n es la longitud de la lista porque se realiza RE sobre la misma
-- * -> si es recursion va por(*) 
-- n por el minimo de la lista
-- +
-- n por el sacar de la lista
-- O(n*(n+n))
-- O(n*(n))
-- O (n^2)
ordenar :: Ord a => [a] -> [a]
ordenar [] = []
orderar xs = let m = minimo xs in m : ordenar (sacar m xs)

{- INV. REPRESENTACION: 

* No poner cosas incomprobables. 
* Tiene que tener caso invalido y valido. 
* No aclarar obviedades como, la edad de una persona tiene que ser un numero cuando ya puse que es un Int. (P String Int)
                                                                                                         -- Nombre Edad

-}

borrar :: Eq a => a -> [a] -> [a]
borrar _ [] = []
borrar x (y:ys) = if x == y then ys else x : borrar x ys