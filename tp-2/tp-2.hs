num = [1,2,3,4,5,6,7,8,9,10]

sumatoria :: [Int] -> Int
--Dada una lista de enteros devuelve la suma de todos sus elementos.
sumatoria []     = 0 
sumatoria (x:xs) = x + sumatoria xs

--2. 
longitud :: [a] -> Int
--Dada una lista de elementos de algún tipo devuelve el largo de esa lista, es decir, la cantidad
--de elementos que posee.
longitud []     = 0 
longitud (x:xs) = 1 + longitud xs 
--3. 
sucesores :: [Int] -> [Int]
--Dada una lista de enteros, devuelve la lista de los sucesores de cada entero.
sucesores []     = []
sucesores (x:xs) = (x + 1) : sucesores xs 
--4. 
conjuncion :: [Bool] -> Bool
--Dada una lista de booleanos devuelve True si todos sus elementos son True.
conjuncion [] = True 
conjuncion (x:xs) = x  && conjuncion xs  

--5. 
disyuncion :: [Bool] -> Bool
--Dada una lista de booleanos devuelve True si alguno de sus elementos es True.
disyuncion []     = False 
disyuncion (x:xs) = x || disyuncion xs 

--6. 
aplanar :: [[a]] -> [a]
--Dada una lista de listas, devuelve una única lista con todos sus elementos.
aplanar []       = []
aplanar (xs:xss) = xs ++ aplanar xss

--7. 
pertenece :: Eq a => a -> [a] -> Bool
--Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual
--a e.
pertenece a []     = False 
pertenece a (x:xs) = a == x || pertenece a xs    
--8. 
apariciones :: Eq a => a -> [a] -> Int
--Dados un elemento e y una lista xs cuenta la cantidad de apariciones de e en xs.
apariciones a []     = 0 
apariciones a (x:xs) = if a == x 
                          then 1 + apariciones a xs 
                          else apariciones a xs  
--9. 
losMenoresA :: Int -> [Int] -> [Int]
--Dados un número n y una lista xs, devuelve todos los elementos de xs que son menores a n.
losMenoresA n []     = []
losMenoresA n (x:xs) = if n > x 
                          then x : losMenoresA n xs 
                          else losMenoresA n xs 

--10. 
lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
--Dados un número n y una lista de listas, devuelve la lista de aquellas listas que tienen más
--de n elementos.
lasDeLongitudMayorA n []       = []
lasDeLongitudMayorA n (xs:xss) = if longitud xs > n 
                                    then xs : lasDeLongitudMayorA n xss 
                                    else xs : lasDeLongitudMayorA n xss   
--11. 
agregarAlFinal :: [a] -> a -> [a]
--Dados una lista y un elemento, devuelve una lista con ese elemento agregado al nal de la
--lista.
agregarAlFinal  []    a = [a]
agregarAlFinal (x:xs) a = x : agregarAlFinal xs a  
--12. 
agregar :: [a] -> [a] -> [a]
--Dadas dos listas devuelve la lista con todos los elementos de la primera lista y todos los
--elementos de la segunda a continuación. Denida en Haskell como (++).
agregar [] ys     = ys 
agregar xs []     = xs
agregar xs (y:ys) = y : agregar xs ys 

--13. 
reversa :: [a] -> [a]
--Dada una lista devuelve la lista con los mismos elementos de atrás para adelante. Denida
--en Haskell como reverse.
reversa []     = []
reversa (x:xs) = x : tail (reversa xs) 

-- [1,2,3,4]
-- 1:2:3:4:[]
-- 1 : [2,3,4]
-- 4:3:2:1:[]
--14. 
zipMaximos :: [Int] -> [Int] -> [Int]
--Dadas dos listas de enteros, devuelve una lista donde el elemento en la posición n es el
--máximo entre el elemento n de la primera lista y de la segunda lista, teniendo en cuenta que
--las listas no necesariamente tienen la misma longitud.
zipMaximos xs      []    = xs 
zipMaximos []      ys    = ys 
zipMaximos (x:xs) (y:ys) = if x > y then x : zipMaximos xs ys else y : zipMaximos xs ys  
--15. 
elMinimo :: Ord a => [a] -> a
--Dada una lista devuelve el mínimo
elMinimo []     = error "Es una lista vacia"
elMinimo (x:[]) = x 
elMinimo (x:xs) = if x < elMinimo xs 
                    then x 
                    else elMinimo xs 

--2) Recursión sobre números
--Defina las siguientes funciones utilizando recursión sobre números enteros, salvo que se indique
--lo contrario:
--1 
factorial :: Int -> Int
--Dado un número n se devuelve la multiplicación de este número y todos sus anteriores hasta
--llegar a 0. Si n es 0 devuelve 1. La función es parcial si n es negativo.
-- PRECONDICION = El numero dado no puede ser negativo.
factorial 0 = 1 
factorial n = (n - 1) * factorial n  
--2. 
cuentaRegresiva :: Int -> [Int]
--Dado un número n devuelve una lista cuyos elementos sean los números comprendidos entre
--n y 1 (incluidos). Si el número es inferior a 1, devuelve la lista vacía.
cuentaRegresiva 1 = []
cuentaRegresiva n = n - 1 : cuentaRegresiva n 
--3. 
--repetir :: Int -> a -> [a]
----Dado un número n y un elemento e devuelve una lista en la que el elemento e repite n veces.
----4. 
--losPrimeros :: Int -> [a] -> [a]
----Dados un número n y una lista xs, devuelve una lista con los n primeros elementos de xs.
----Si la lista es vacía, devuelve una lista vacía.
----5. 
--sinLosPrimeros :: Int -> [a] -> [a]
----Dados un número n y una lista xs, devuelve una lista sin los primeros n elementos de lista
----recibida. Si n es cero, devuelve la lista completa.
