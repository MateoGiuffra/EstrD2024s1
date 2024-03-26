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
reversa (x:xs) = agregarAlFinal (reversa xs) x 

--14. 
zipMaximos :: [Int] -> [Int] -> [Int]
--Dadas dos listas de enteros, devuelve una lista donde el elemento en la posición n es el
--máximo entre el elemento n de la primera lista y de la segunda lista, teniendo en cuenta que
--las listas no necesariamente tienen la misma longitud.
zipMaximos xs      []    = xs 
zipMaximos []      ys    = ys 
zipMaximos (x:xs) (y:ys) = if x > y 
                              then x : zipMaximos xs ys 
                              else y : zipMaximos xs ys  
--15. 
elMinimo :: Ord a => [a] -> a
--Dada una lista devuelve el mínimo
-- PRECONDICION: La lista no puede ser vacia. 
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
repetir :: Int -> a -> [a]
--Dado un número n y un elemento e devuelve una lista en la que el elemento e repite n veces.
repetir 0 _      = []
repetir n x = x : repetir (n-1) x
--4. 
losPrimeros :: Int -> [a] -> [a]
--Dados un número n y una lista xs, devuelve una lista con los n primeros elementos de xs.
--Si la lista es vacía, devuelve una lista vacía.
losPrimeros 0  _ = []
losPrimeros _ [] = []
losPrimeros n (x:xs) = x : losPrimeros (n-1) xs

--5. 
sinLosPrimeros :: Int -> [a] -> [a]
--Dados un número n y una lista xs, devuelve una lista sin los primeros n elementos de lista
--recibida. Si n es cero, devuelve la lista completa.
sinLosPrimeros 0 xs = xs 
sinLosPrimeros _ [] = []
sinLosPrimeros n (x:xs) = sinLosPrimeros (n-1) xs 


--3. Registros
--1. Denir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las
--siguientes funciones:

data Persona = P String Int 
            deriving Show
                  -- Nombre Edad

p1 = (P "1" 10) 
p2 = (P "1" 10)
p3 = (P "1" 100)
p4 = (P "1" 10)
p5 = (P "1" 11)

personas = [p1,p2,p3,p4,p5]

mayoresA :: Int -> [Persona] -> [Persona]
--Dados una edad y una lista de personas devuelve a las personas mayores a esa edad.
mayoresA _ []     = []
mayoresA n (x:xs) = if esMayorA n x 
                        then x : mayoresA n xs 
                        else mayoresA n xs 

esMayorA :: Int -> Persona -> Bool 
esMayorA n (P _ e) = e > n 

promedioEdad :: [Persona] -> Int
--Dada una lista de personas devuelve el promedio de edad entre esas personas. Precondición: la lista al menos 
-- posee una persona
promedioEdad ps = div (sumaDeEdades ps) (longitud ps) 

sumaDeEdades :: [Persona] -> Int 
sumaDeEdades []     = 0 
sumaDeEdades (p:ps) = edadDe p + sumaDeEdades ps 

edadDe :: Persona -> Int 
edadDe (P _ e) = e 

elMasViejo :: [Persona] -> Persona
--Dada una lista de personas devuelve la persona más vieja de la lista. Precondición: la
--lista al menos posee una persona.
elMasViejo (p:[]) = p 
elMasViejo (p:ps) = if edadDe p > edadDe (elMasViejo ps) 
                        then p 
                        else elMasViejo ps 

-- 2. Modicaremos la representación de Entreador y Pokemon de la práctica anterior de la siguiente manera:
data TipoDePokemon = Agua | Fuego | Planta
data Pokemon = PK TipoDePokemon Int
data Entrenador = E String [Pokemon]

sonIguales :: TipoDePokemon -> TipoDePokemon -> Bool 
sonIguales Agua Agua     = True  
sonIguales Fuego Fuego   = True 
sonIguales Planta Planta = True 
sonIguales _      _      = False

estePokemonEsTipo :: Pokemon -> TipoDePokemon -> Bool
-- Indica si el pokemon dado es del tipo dado. 
estePokemonEsTipo (PK t _ ) tipo =  sonIguales t tipo 

esMasFuerte :: TipoDePokemon -> TipoDePokemon  -> Bool 
esMasFuerte Agua Fuego   = True
esMasFuerte Fuego Planta = True 
esMasFuerte Planta Agua  = True 
esMasFuerte _      _     = False

tipoDe :: Pokemon -> TipoDePokemon
tipoDe (PK t _) = t 

unoSi :: Bool -> Int 
unoSi True  = 1 
unoSi False = 0 

-- e1 = [Fuego, Planta] 
-- e2 = [Planta, Planta] 
--  1

-- e3 = [Fuego, Planta] 
-- e4 = [Agua, Planta] 
--  0 


ash :: Entrenador
ash = (E "Ash" [charmander, pk3]) 

e2 :: Entrenador
e2 = (E "e2" [pk3,pk3])

e3= (E "a" [charmander, pk3])
e4= (E "b" [pikachu, pk3])

charmander :: Pokemon
charmander =  (PK Fuego 30)  

pikachu :: Pokemon
pikachu = (PK Agua 50)

pk3 = (PK Planta 12)

--1.a)
cantPokemon :: Entrenador -> Int
--Devuelve la cantidad de Pokémon que posee el entrenador.
cantPokemon (E _ pks ) = longitud pks 

--1.b)
cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
--Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantPokemonDe t (E _ pks) = cantPokemonTipo t pks

cantPokemonTipo :: TipoDePokemon -> [Pokemon] -> Int 
cantPokemonTipo _ []       = 0 
cantPokemonTipo t (pk:pks) = unoSi (estePokemonEsTipo pk t) + cantPokemonTipo t pks 


--1.c)
--cuantosDeTipo_De_LeGananATodosLosDe_
cuantosDeTipo_De_LeGananATodosLosDe_  :: TipoDePokemon -> Entrenador -> Entrenador -> Int 
--Dados dos entrenadores, indica la cantidad de Pokemon de cierto tipo, que le ganarían
--a los Pokemon del segundo entrenador.
cuantosDeTipo_De_LeGananATodosLosDe_ t (E _ pks) (E _ pks2) = cuantosDeEsteTipoLeGananATodos t pks pks2

cuantosDeEsteTipoLeGananATodos :: TipoDePokemon -> [Pokemon] -> [Pokemon] -> Int
cuantosDeEsteTipoLeGananATodos t [] _      = 0
cuantosDeEsteTipoLeGananATodos t xs []     = cantPokemonTipo t xs  
cuantosDeEsteTipoLeGananATodos t (x:xs) ys = unoSi (pokemonEsDeTipo t x  && esteTipoLeGanaATodos t ys ) + 
                                 cuantosDeEsteTipoLeGananATodos t xs ys 

esteTipoLeGanaATodos :: TipoDePokemon -> [Pokemon] -> Bool 
esteTipoLeGanaATodos _ []       = True 
esteTipoLeGanaATodos t (pk:pks) = esMasFuerte t (tipoDe pk) && esteTipoLeGanaATodos t pks 

pokemonEsDeTipo :: TipoDePokemon -> Pokemon  -> Bool 
pokemonEsDeTipo t (PK tp _) = sonIguales tp t 


--1.d)
esMaestroPokemon :: Entrenador -> Bool
--Dado un entrenador, devuelve True si posee al menos un Pokémon de cada tipo posible.
esMaestroPokemon (E _ pks) = hayUnoDelTipo Fuego pks && 
                             hayUnoDelTipo Agua  pks && 
                             hayUnoDelTipo Planta pks 

hayUnoDelTipo :: TipoDePokemon -> [Pokemon] -> Bool 
-- PROPOSITO: Dada una lista de pokemones, indica si existe algun pokemon del TipoDePokemon dado. 
hayUnoDelTipo _ []       = False 
hayUnoDelTipo t (pk:pks) = pokemonEsDeTipo t pk || hayUnoDelTipo t pks   


--3. El tipo de dato Rol representa los roles (desarollo o management) de empleados IT dentro
--de una empresa de software, junto al proyecto en el que se encuentran. Así, una empresa es
--una lista de personas con diferente rol. La denición es la siguiente:
data Seniority = Junior | SemiSenior | Senior
                  deriving Show
data Proyecto = Pr String
                  deriving Show
data Rol = Developer Seniority Proyecto | Management Seniority Proyecto
                  deriving Show
data Empresa = Em [Rol]
                  deriving Show

pr1 = Pr "p1"
pr2 = Pr "p2"
pr3 = Pr "p3"
pr4 = Pr "p4"
emp1 = Developer Senior pr2 
emp2 = Developer Senior pr2 
emp3 = Management Senior pr4
emp4 = Management Junior pr4 

empresa = Em [emp1, emp2, emp3, emp4]

--Denir las siguientes funciones sobre el tipo Empresa:

--1.a)
proyectos :: Empresa -> [Proyecto]
--Dada una empresa denota la lista de proyectos en los que trabaja, sin elementos repetidos.
proyectos (Em rs) = proyectosSinRepetir (proyectosDe rs) 

proyectosDe :: [Rol] -> [Proyecto]
proyectosDe []     = []
proyectosDe (r:rs) = proyectoDe r : proyectosDe rs  

proyectoDe :: Rol -> Proyecto 
proyectoDe (Developer _ p)  = p 
proyectoDe (Management _ p) = p 

proyectosSinRepetir :: [Proyecto] -> [Proyecto] 
proyectosSinRepetir []     = []
proyectosSinRepetir (p:ps) = if (elProyectoExisteEn p ps) 
                                then proyectosSinRepetir ps 
                                else p : proyectosSinRepetir ps  

elProyectoExisteEn :: Proyecto -> [Proyecto] -> Bool 
elProyectoExisteEn pr []     = True 
elProyectoExisteEn pr (p:ps) = nombreDel pr == nombreDel p && elProyectoExisteEn pr ps 

nombreDel :: Proyecto -> String 
nombreDel (Pr n) = n 

--1.b)
losDevSenior :: Empresa -> [Proyecto] -> Int
--Dada una empresa indica la cantidad de desarrolladores senior que posee, 
-- que pertecen además a los proyectos dados por parámetro.
losDevSenior (Em rs) ps = cantDevSenior rs ps 


cantDevSenior :: [Rol] -> [Proyecto] -> Int  
cantDevSenior [] _      = 0 
cantDevSenior (r:rs) ps = unoSi (esDeveloper r && esSenior r && trabajaEnLosProyectos r ps) + cantDevSenior rs ps

trabajaEnLosProyectos :: Rol -> [Proyecto] -> Bool 
trabajaEnLosProyectos _ []     = True 
trabajaEnLosProyectos r (p:ps) = trabajaEnElProyecto r p && trabajaEnLosProyectos r ps 

trabajaEnElProyecto :: Rol -> Proyecto -> Bool 
trabajaEnElProyecto r p = sonElMismoProy p  (proyectoDelEmp r)


proyectoDelEmp :: Rol -> Proyecto 
proyectoDelEmp (Developer _ p ) = p 
proyectoDelEmp (Management _ p) = p 

esSenior :: Rol -> Bool 
esSenior (Developer Senior _)   =  True 
esSenior (Management Senior  _) =  True
esSenior _                      = False   

esDeveloper :: Rol -> Bool 
esDeveloper (Developer _ _ ) = True 
esDeveloper (Management _ _) = False 

----1.c)
cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
----Indica la cantidad de empleados que trabajan en alguno de los proyectos dados.
cantQueTrabajanEn ps (Em rs) = cantTrabajadores ps rs 

cantTrabajadores :: [Proyecto] -> [Rol] -> Int 
cantTrabajadores [] _  = 0 
cantTrabajadores _  [] = 0     
cantTrabajadores ps (r:rs) = unoSi (trabajaEnAlgunProyecto r ps) + cantTrabajadores ps rs  

trabajaEnAlgunProyecto :: Rol -> [Proyecto] -> Bool 
trabajaEnAlgunProyecto _ []     = False 
trabajaEnAlgunProyecto r (p:ps) = trabajaEnElProyecto r p || trabajaEnAlgunProyecto  r ps 


-- 1.d)
asignadosPorProyecto :: Empresa -> [(Proyecto, Int)] 
--Devuelve una lista de pares que representa a los proyectos (sin repetir) junto con su
--cantidad de personas involucradas.
asignadosPorProyecto (Em rs) =  asignados rs 

asignados :: [Rol] ->  [(Proyecto, Int)] 
asignados []     = [] 
asignados (r:rs) = asignadosPorTuplas (proyectoDe r) (asignados rs) 

asignadosPorTuplas :: Proyecto -> [(Proyecto, Int)] -> [(Proyecto, Int)]
asignadosPorTuplas p []            = (p,1) : [] 
asignadosPorTuplas p ((p1, n): ps) = if sonElMismoProy p p1 
                                          then ((p1, n+1): ps)  
                                          else ((p1, n)  : asignadosPorTuplas p ps)  

sonElMismoProy :: Proyecto -> Proyecto -> Bool 
sonElMismoProy p1 p2 = nombreDel p1 == nombreDel p2 
