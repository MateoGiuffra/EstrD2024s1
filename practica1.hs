-- 1)
--1.a
sucesor :: Int -> Int
--Dado un número devuelve su sucesor
sucesor n = n + 1
--1.b
sumar :: Int -> Int -> Int
--Dados dos números devuelve su suma utilizando la operación +.
sumar n m = n + m 
--1.c
divisionYResto :: Int -> Int -> (Int, Int)
--Dado dos números, devuelve un par donde la primera componente es la división del
--primero por el segundo, y la segunda componente es el resto de dicha división.
-- Precondicion: El segundo numero no puede ser 0. 
divisionYResto n m = (div n m, mod n m)
--1.d
maxDelPar :: (Int,Int) -> Int
--Dado un par de números devuelve el mayor de estos.
maxDelPar (n,m) = if n < m  
                   then m 
                   else n 
-- 2)
--2.a
{-
sucesor 9
sumar 5 5
divisionYResto 100 10
maxDelPar (10,1)
-}

-- 3.1)

data Dir = Norte | Sur | Oeste | Este

--1.a) 
opuesto :: Dir -> Dir
--Dada una dirección devuelve su opuesta.
opuesto Norte = Sur
opuesto Sur = Norte 
opuesto Oeste = Este 
opuesto Este = Oeste 

--1.b) 
iguales :: Dir -> Dir -> Bool
--Dadas dos direcciones, indica si son la misma. Nota: utilizar pattern matching y no ==.
iguales Norte Norte  = True 
iguales Sur   Sur    = True 
iguales Oeste Oeste  = True 
iguales Este Este    = True 
iguales _    _       = False
--1.c)
siguiente :: Dir -> Dir
--Dada una dirección devuelve su siguiente, en sentido horario, y suponiendo que no existe
--la siguiente dirección a Oeste. ¾Posee una precondición esta función? ¾Es una función
--total o parcial? ¾Por qué?
siguiente Norte = Este 
siguiente Este = Sur 
siguiente Sur  = Oeste
siguiente Oeste = Norte 

-- Si no existiera una dir siguiente a Oeste, entonces deberia de haber una precondicion y por ende parcial.

--3.2)
data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo
                deriving Show
--2.a) 
primeroYUltimoDia :: (DiaDeSemana, DiaDeSemana)
--Devuelve un par donde la primera componente es el primer día de la semana, y la
--segunda componente es el último día de la semana. Considerar denir subtareas útiles
--que puedan servir después.
primeroYUltimoDia = (Lunes, Domingo)
--2.b) 
empiezaConM :: DiaDeSemana -> Bool
--Dado un día de la semana indica si comienza con la letra M.
empiezaConM Martes = True 
empiezaConM Miercoles  = True 
empiezaConM _          = False 
--2.c) 
vieneDespues :: DiaDeSemana -> DiaDeSemana -> Bool
--Dado dos días de semana, indica si el primero viene después que el segundo. Analizar
--la calidad de la solución respecto de la cantidad de casos analizados (entre los casos
--analizados en esta y cualquier subtarea, deberían ser no más de 9 casos).
vieneDespues d1 d2 = nroDiaSemanal d1 > nroDiaSemanal d2  

--2.d) 
estaEnElMedio :: DiaDeSemana -> Bool
--Dado un día de la semana indica si no es ni el primer ni el ultimo dia.
estaEnElMedio Lunes   = False 
estaEnElMedio Domingo = False 
estaEnElMedio _       = True 

nroDiaSemanal :: DiaDeSemana -> Int 
nroDiaSemanal Lunes     = 1 
nroDiaSemanal Martes    = 2
nroDiaSemanal Miercoles = 3
nroDiaSemanal Jueves    = 4
nroDiaSemanal Viernes   = 5 
nroDiaSemanal Sabado    = 6
nroDiaSemanal Domingo   = 7


--3.3)

--3.a) 
negar :: Bool -> Bool
--Dado un booleano, si es True devuelve False, y si es False devuelve True.
--En Haskell ya está denida como not.
negar True  = False 
negar False = True 

--3.b) 
implica :: Bool -> Bool -> Bool
--Dados dos booleanos, si el primero es True y el segundo es False, devuelve False, sino
--devuelve True.
--Esta función NO debe realizar doble pattern matching.
--Nota: no viene implementada en Haskell.  
implica True b  = b 
implica False _ = True

--3.c) 
yTambien :: Bool -> Bool -> Bool
--Dados dos booleanos si ambos son True devuelve True, sino devuelve False.
--Esta función NO debe realizar doble pattern matching.
--En Haskell ya está denida como \&\&.
yTambien True b  = b
yTambien False _ = False 

--3.d) 
oBien :: Bool -> Bool -> Bool
--Dados dos booleanos si alguno de ellos es True devuelve True, sino devuelve False.
--Esta función NO debe realizar doble pattern matching.
--En Haskell ya está denida como ||.
oBien False b = b 
oBien True  _ = True




