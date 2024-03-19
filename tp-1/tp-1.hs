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
siguiente Este  = Sur 
siguiente Sur   = Oeste
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
empiezaConM Martes     = True 
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
--En Haskell ya está Definida como not.
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
--En Haskell ya está Definida como \&\&.
yTambien True b  = b
yTambien False _ = False 

--3.d) 
oBien :: Bool -> Bool -> Bool
--Dados dos booleanos si alguno de ellos es True devuelve True, sino devuelve False.
--Esta función NO debe realizar doble pattern matching.
--En Haskell ya está Definida como ||.
oBien False b = b 
oBien True  _ = True

--4.1)

--1. Denir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las siguientes funciones:


data Persona = P String Int 
            deriving Show
                  -- Nombre Edad

--1.a)
nombre :: Persona -> String
--Devuelve el nombre de una persona
nombre (P n _) = n 
--1.b)
edad :: Persona -> Int
--Devuelve la edad de una persona
edad (P _ e) = e 
--1.c)
crecer :: Persona -> Persona
--Aumenta en uno la edad de la persona.
crecer (P n e ) = (P n (e+1))
--1.d)
cambioDeNombre :: String -> Persona -> Persona
--Dados un nombre y una persona, devuelve una persona con la edad de la persona y el
--nuevo nombre.
cambioDeNombre nn (P n e ) = (P nn e)
--1.e)
esMayorQueLaOtra :: Persona -> Persona -> Bool
--Dadas dos personas indica si la primera es mayor que la segunda.
esMayorQueLaOtra p1 p2 = edad p1 > edad p2 
--1.f)
laQueEsMayor :: Persona -> Persona -> Persona
--Dadas dos personas devuelve a la persona que sea mayor.
laQueEsMayor p1 p2 = if (esMayorQueLaOtra p1 p2) then p1 else p2 


mateo :: Persona 
mateo = (P "Mateo" 19)     

matias :: Persona 
matias = (P "Matias" 30) 


--4.2) 
-- Denir los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta) y un
-- porcentaje de energía; y Entrenador, como un nombre y dos Pokémon. Luego denir las
-- siguientes funciones:

data Pokemon       = Pk TipoDePokemon Int
                    deriving Show
data TipoDePokemon = Agua | Fuego | Planta 
                    deriving Show
data Entrenador    = E String Pokemon Pokemon
                    deriving Show

ash :: Entrenador
ash = (E "Ash" (pikachu) (charmander))

e2 :: Entrenador
e2 = (E "e2" (pikachu) (charmander))



charmander :: Pokemon
charmander =  (Pk Fuego 30)  

pikachu :: Pokemon
pikachu = (Pk Agua 50)

--2.a)
superaA :: Pokemon -> Pokemon -> Bool
--Dados dos Pokémon indica si el primero, en base al tipo, es superior al segundo. Agua
--supera a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
superaA (Pk t1 _) (Pk t2 _ ) = esMasFuerte t1 t2 

--2.b)
esMasFuerte :: TipoDePokemon -> TipoDePokemon  -> Bool 
esMasFuerte Agua Fuego   = True
esMasFuerte Fuego Planta = True 
esMasFuerte Planta Agua  = True 
esMasFuerte _      _     = False 

cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
--Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantidadDePokemonDe tipo (E _ p1 p2) = unoSi (estePokemonEsTipo p1 tipo) + unoSi (estePokemonEsTipo p2 tipo)

estePokemonEsTipo :: Pokemon -> TipoDePokemon -> Bool
-- Indica si el pokemon dado es del tipo dado. 
estePokemonEsTipo (Pk t _ ) tipo =  sonIguales t tipo 

sonIguales :: TipoDePokemon -> TipoDePokemon -> Bool 
sonIguales Agua Agua     = True  
sonIguales Fuego Fuego   = True 
sonIguales Planta Planta = True 
sonIguales _      _      = False

unoSi :: Bool -> Int 
unoSi True  = 1 
unoSi False = 0 

--2.c)
juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
--Dado un par de entrenadores, devuelve a sus Pokémon en una lista
juntarPokemon (e1, e2) = listaPokemonDe e1 ++ listaPokemonDe e2  

listaPokemonDe :: Entrenador -> [Pokemon]
listaPokemonDe (E _ p1 p2 ) = [p1,p2]

--5) Funciones polimórcas
--5.1) Defina las siguientes funciones polimórcas:

--1.a) 
loMismo :: a -> a
--Dado un elemento de algún tipo devuelve ese mismo elemento.
loMismo a = a 

--1.b) 
siempreSiete :: a -> Int
--Dado un elemento de algún tipo devuelve el número 7.
siempreSiete a = 7 
--1.c) 
swap :: (a,b) -> (b, a)
--Dadas una tupla, invierte sus componentes.
swap (a,b) = (b,a)
{-

¾Por qué existen dos variables de tipo diferentes?
 - Porque asi expresas que la funcion requiere dos argumentos de distinto tipo, aunque no rompa si le das del mismo. 
2. Responda la siguiente pregunta: ¾Por qué estas funciones son polimórcas?
 - Porque puede ir cualquier tipo de elemento en ellas.


6)
6.1) Pattern matching sobre lista
1.a)
 Defina las siguientes funciones polimórcas utilizando pattern matching sobre listas (no
utilizar las funciones que ya vienen con Haskell):

-}


--1.b) 
estaVacia :: [a] -> Bool
--Dada una lista de elementos, si es vacía devuelve True, sino devuelve False.
--Definida en Haskell como null.
estaVacia [] = True 
estaVacia _  = False 
--1.c) 
elPrimero :: [a] -> a
--Dada una lista devuelve su primer elemento.
--Definida en Haskell como head.
--Nota: tener en cuenta que el constructor de listas es :
elPrimero (a:_) = a 

--1.d) 
sinElPrimero :: [a] -> [a]
--Dada una lista devuelve esa lista menos el primer elemento.
--Definida en Haskell como tail.
--Nota: tener en cuenta que el constructor de listas es :
sinElPrimero (_:xs) = xs 

--1.e) 
splitHead :: [a] -> (a, [a])
--Dada una lista devuelve un par, donde la primera componente es el primer elemento de la
--lista, y la segunda componente es esa lista pero sin el primero.
--Nota: tener en cuenta que el constructor de listas es :
splitHead (x:xs) = (x, xs)