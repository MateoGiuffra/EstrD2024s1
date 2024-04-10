--1.1)

data Color = Azul | Rojo 
            deriving Show  
data Celda = Bolita Color Celda | CeldaVacia
            deriving Show 

c1 = Bolita Rojo (Bolita Rojo CeldaVacia) 
c2 = Bolita Rojo (Bolita Azul (Bolita Rojo (Bolita Azul CeldaVacia)) )

--1.a)
nroBolitas :: Color -> Celda -> Int
--Dados un color y una celda, indica la cantidad de bolitas de ese color. Nota: pensar si ya
--existe una operación sobre listas que ayude a resolver el problema.
nroBolitas _ CeldaVacia     = 0 
nroBolitas c (Bolita cr cd) = unoSi (sonMismoColor c cr) + nroBolitas c cd

unoSi :: Bool -> Int 
unoSi True  = 1 
unoSi False = 0 

sonMismoColor :: Color -> Color -> Bool 
sonMismoColor Rojo Rojo = True 
sonMismoColor Azul Azul = True 
sonMismoColor _    _    = False 

--1.b)
poner :: Color -> Celda -> Celda
--Dado un color y una celda, agrega una bolita de dicho color a la celda.
poner  c celda = (Bolita c celda) 
--1.c)
sacar :: Color -> Celda -> Celda
--Dado un color y una celda, quita una bolita de dicho color de la celda. Nota: a diferencia de
--Gobstones, esta función es total.
sacar _ CeldaVacia     = CeldaVacia  
sacar c (Bolita cl cd) = if (sonMismoColor c cl) 
                            then cd 
                            else (Bolita cl (sacar c cd)) 

--1.d)
ponerN :: Int -> Color -> Celda -> Celda
--Dado un número n, un color c, y una celda, agrega n bolitas de color c a la celda.
ponerN 0 c cd = cd 
ponerN n c cd = Bolita c (ponerN (n-1) c cd)

--1.2. Camino hacia el tesoro

data Objeto = Cacharro | Tesoro
            deriving Show
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino
            deriving Show

-- aca se recorren 3 pasos o 2 ? 

{-
f Fin            =   
f (Nada  cm)     = 
f (Cofre obs cm) =
-}


--2.a)
hayTesoro :: Camino -> Bool
--Indica si hay un cofre con un tesoro en el camino.
hayTesoro Fin            = False 
hayTesoro (Nada  cm)     = hayTesoro cm 
hayTesoro (Cofre obs cm) = hayUnTesoro obs || hayTesoro cm  

hayUnTesoro :: [Objeto] -> Bool 
hayUnTesoro []     = False 
hayUnTesoro (ob:obs) = esTesoro ob || hayUnTesoro obs  

esTesoro :: Objeto -> Bool 
esTesoro Tesoro = True 
esTesoro _      = False 

--2.b)
pasosHastaTesoro :: Camino -> Int
--Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
--Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
--Precondición: tiene que haber al menos un tesoro.
pasosHastaTesoro Fin            = 0  
pasosHastaTesoro (Nada  cm)     = 1 + pasosHastaTesoro cm 
pasosHastaTesoro (Cofre obs cm) = if (hayUnTesoro obs) 
                                    then pasosHastaTesoro Fin 
                                    else 1 + pasosHastaTesoro cm 

camino1 = Cofre [] (Cofre [] (Nada (Cofre [Tesoro] Fin)))
camino2 = Cofre [] (Cofre [Tesoro] (Nada (Cofre [Tesoro] Fin)))

--2.c)
hayTesoroEn :: Int -> Camino -> Bool
--Indica si hay un tesoro en una cierta cantidad exacta de pasos. Por ejemplo, si el número de
--pasos es 5, indica si hay un tesoro en 5 pasos.
-- PRECONDCION: El numero tiene que ser igual o mayor a 0. 
hayTesoroEn 0 camino         = hayTesoroAca camino
hayTesoroEn n Fin            = False 
hayTesoroEn n (Nada  cm)     = hayTesoroEn (n-1) cm
hayTesoroEn n (Cofre obs cm) = hayTesoroEn (n-1) cm 

hayTesoroAca :: Camino -> Bool 
hayTesoroAca (Cofre obs cm) = hayUnTesoro obs 
hayTesoroAca _              = False 

--2.d)
alMenosNTesoros :: Int -> Camino -> Bool
--Indica si hay al menos n tesoros en el camino.
alMenosNTesoros n cm = cantDeTesoros cm >= n 

cantDeTesoros :: Camino -> Int 
cantDeTesoros Fin            = 0    
cantDeTesoros (Nada  cm)     = cantDeTesoros cm 
cantDeTesoros (Cofre obs cm) = cantTesoros obs + cantDeTesoros cm 

cantTesoros :: [Objeto] -> Int 
cantTesoros  []      = 0 
cantTesoros (ob:obs) = unoSi (esTesoro ob) + cantTesoros obs

--(desafío) 2.e) 
cantTesorosEntre :: Int -> Int -> Camino -> Int
--Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
--el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
--incluidos tanto 3 como 5 en el resultado.
cantTesorosEntre _ _ Fin            = 0  
cantTesorosEntre 0 0 _              = 0 
cantTesorosEntre n m (Nada  cm)     = cantTesorosEntre (n - 1) (m - 1) cm
cantTesorosEntre n m (Cofre obs cm) = if n <= 0  
                                        then (cantTesoros obs) + cantTesorosEntre n (m-1) cm
                                        else cantTesorosEntre (n - 1) (m - 1) cm


-- 2. Tipos arbóreos
-- 2.1)


data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
                deriving Show
arbol1 :: Tree Int 
arbol1 =                (NodeT 1  
                            (NodeT 2 
                                 (NodeT 2 EmptyT EmptyT)  (NodeT 6 (NodeT 6 EmptyT EmptyT) 
                                                                        (NodeT 8 EmptyT EmptyT)))    EmptyT)    
                                                                                                    -- este EmptyT iria dos lineas arriba 
arbol2 :: Tree Int 
arbol2 = (NodeT 1 (NodeT 2 (NodeT 4 EmptyT EmptyT)(NodeT 6 (NodeT 8 EmptyT EmptyT) EmptyT)) (NodeT 3 (NodeT 5 EmptyT EmptyT) (NodeT 7 EmptyT EmptyT)))
-- (8,6,4,2,1,3,5,7)

--1.a) 
sumarT :: Tree Int -> Int
-- Dado un árbol binario de enteros devuelve la suma entre sus elementos.
sumarT EmptyT            = 0 
sumarT (NodeT n izq der) = n + sumarT izq +  sumarT der   

--1.b)
sizeT :: Tree a -> Int
-- Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
sizeT EmptyT            = 0 
sizeT (NodeT n izq der) = 1 + sizeT izq + sizeT der 

--1.c)
mapDobleT :: Tree Int -> Tree Int
--Dado un árbol de enteros devuelve un árbol con el doble de cada número.
mapDobleT EmptyT            = EmptyT  
mapDobleT (NodeT n izq der) = (NodeT (n*2) (mapDobleT izq) (mapDobleT der))

--1.d)
perteneceT :: Eq a => a -> Tree a -> Bool
--Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
perteneceT a EmptyT            = False  
perteneceT a (NodeT n izq der) = n == a || perteneceT a izq || perteneceT a der 
--1.e)
aparicionesT :: Eq a => a -> Tree a -> Int
--Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
aparicionesT e EmptyT             = 0 
aparicionesT e (NodeT n izq der ) = unoSi (e == n) + (aparicionesT e izq) + (aparicionesT e der) 


--1.f)
leaves :: Tree a -> [a]
-- Dado un árbol devuelve los elementos que se encuentran en sus hojas.
leaves EmptyT            = []
leaves (NodeT n izq der) =  if isEmptyT izq && isEmptyT der 
                              then n : (leaves izq ++ leaves der)
                              else leaves izq ++ leaves der 

isEmptyT :: Tree a -> Bool 
isEmptyT EmptyT = True 
isEmptyT _      = False 
--1.g) 
heightT :: Tree a -> Int
--Dado un árbol devuelve su altura.
--Nota: la altura de un árbol (height en inglés), también llamada profundidad, es la cantidad de niveles del árbol. 
--La altura para EmptyT es 0, y para una hoja es 1.
heightT EmptyT            = 0 
heightT (NodeT _ izq der) = if heightT izq > heightT der 
                                then 1 + heightT izq  
                                else 1 + heightT der 

--1.h) 
mirrorT :: Tree a -> Tree a
--Dado un árbol devuelve el árbol resultante de intercambiar el hijo izquierdo con el derecho,
--en cada nodo del árbol.
mirrorT EmptyT            = EmptyT 
mirrorT (NodeT n izq der) = (NodeT n der izq )

--1.j)
toList :: Tree a -> [a]
--Dado un árbol devuelve una lista que representa el resultado de recorrerlo en modo in-order.
--Nota: En el modo in-order primero se procesan los elementos del hijo izquierdo, luego la raiz y luego los elementos del hijo derecho.
toList EmptyT            = []
toList (NodeT n izq der) = toList izq ++ [n] ++ toList der 


--1.k)
levelN :: Int -> Tree a -> [a]
-- Dados un número n y un árbol devuelve una lista con los nodos de nivel n. El nivel de un
-- nodo es la distancia que hay de la raíz hasta él. La distancia de la raiz a sí misma es 0, y la
-- distancia de la raiz a uno de sus hijos es 1.
-- Nota: El primer nivel de un árbol (su raíz) es 0.
levelN _ EmptyT             = []
levelN 0 (NodeT x izq der ) = x : (levelN (-1) izq ++ levelN (-1) der ) 
levelN n (NodeT x izq der ) = if n < 0  
                                 then [] 
                                 else (levelN (n-1) izq ++ levelN (n-1) der )  
--1.l)                                  
listPerLevel :: Tree a -> [[a]]
-- Dado un árbol devuelve una lista de listas en la que cada elemento representa un nivel de dicho árbol.
listPerLevel EmptyT             = []
listPerLevel (NodeT n izq der)  = [n] : unirPorMismaPosicion (listPerLevel izq ) (listPerLevel der)   

unirPorMismaPosicion :: [[a]] -> [[a]] -> [[a]]
unirPorMismaPosicion  []     ys     = ys 
unirPorMismaPosicion  xs []         = xs
unirPorMismaPosicion  (x:xs) (y:ys) = (x++y) : unirPorMismaPosicion xs ys 


--  resultado: [[1],[2,5],[3,4,6,7]]

tree = NodeT 1 (NodeT 2 (NodeT 3 EmptyT EmptyT)(NodeT 4 EmptyT EmptyT)) (NodeT 5 (NodeT 6 EmptyT EmptyT)(NodeT 7 EmptyT EmptyT))

--1.ñ)
ramaMasLarga :: Tree a -> [a]
-- Devuelve los elementos de la rama más larga del árbol
ramaMasLarga EmptyT             = []
ramaMasLarga (NodeT n izq der)  = if length (ramaMasLarga izq )  > length  (ramaMasLarga der )  
                                    then n : ramaMasLarga izq 
                                    else n : ramaMasLarga der   

--1.o)
todosLosCaminos :: Tree a -> [[a]]
-- Dado un árbol devuelve todos los caminos, es decir, los caminos desde la raíz hasta cualquiera de los nodos.
todosLosCaminos EmptyT            = []
todosLosCaminos (NodeT n izq der) = [n] : (caminosPasados n (todosLosCaminos izq)) ++ (caminosPasados n (todosLosCaminos der)) 

caminosPasados :: a -> [[a]] ->  [[a]]
caminosPasados n []     = []  
caminosPasados n (as:ass) = (n : as) : (caminosPasados n ass) 


caminoss = (NodeT 1 (NodeT 2 (NodeT 3 (NodeT 8 EmptyT EmptyT) EmptyT) EmptyT) (NodeT 4 (NodeT 5 EmptyT EmptyT) EmptyT))


-- 2.2) Expresiones Aritméticas
-- El tipo algebraico ExpA modela expresiones aritméticas de la siguiente manera:
data ExpA = Valor Int | Sum ExpA ExpA | Prod ExpA ExpA | Neg ExpA
                    deriving Show


-- 2.a) 
eval :: ExpA -> Int
-- Dada una expresión aritmética devuelve el resultado evaluarla.
eval (Neg n)    = (eval n) * (- 1)
eval (Sum n m)  = (eval n) + (eval m)   
eval (Prod n m) = (eval n) * (eval m)
eval (Valor n)  = n 

n1 :: ExpA
n1 = (Sum (Valor 10) (Valor 5)) 

-- 2.b) 
simplificar :: ExpA -> ExpA
-- Dada una expresión aritmética, la simplica según los siguientes criterios (descritos utilizando
-- notación matemática convencional): 
simplificar (Sum n m)  = simplificarSuma n  m 
simplificar (Prod n m) = simplificarProd n  m 
simplificar (Neg n)    = simplificarNeg  n 
simplificar  n         = n 

simplificarProd :: ExpA -> ExpA -> ExpA
simplificarProd (Valor 1) m = m
simplificarProd n (Valor 1) = n
simplificarProd (Valor 0) m = (Valor 0)
simplificarProd n (Valor 0) = (Valor 0)
simplificarProd n m         =  (Prod n m) 

simplificarSuma :: ExpA -> ExpA -> ExpA 
simplificarSuma (Valor 0) m = m 
simplificarSuma n (Valor 0) = n 
simplificarSuma n    m      = (Sum n m)

simplificarNeg :: ExpA -> ExpA 
simplificarNeg (Neg e) = e 
simplificarNeg e       = (Neg e)
                  


-- a) 0 + x = x + 0 = x
-- b) 0 * x = x * 0 = 0
-- c) 1 * x = x * 1 = x
-- d) - (- x) = x       
