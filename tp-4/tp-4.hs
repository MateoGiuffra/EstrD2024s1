--1.1)
data Pizza = Prepizza | Capa Ingrediente Pizza
            deriving Show
data Ingrediente = Salsa| Queso | Jamon | Aceitunas Int
            deriving Show


pizza =  Capa (Aceitunas 2) (Capa Jamon (Capa Queso (Capa Jamon (Capa Queso Prepizza))))
p2    =  Capa (Aceitunas 2) (Capa Jamon (Capa Queso (Prepizza)))
p3    =  Capa (Aceitunas 2) (Capa Jamon Prepizza)

-- Denir las siguientes funciones:
-- 1.a)
cantidadDeCapas :: Pizza -> Int
-- Dada una pizza devuelve la cantidad de ingredientes
cantidadDeCapas Prepizza   = 0 
cantidadDeCapas (Capa i p) = 1 + cantidadDeCapas p  
-- 1.b)
armarPizza :: [Ingrediente] -> Pizza
-- Dada una lista de ingredientes construye una pizza
armarPizza []     = Prepizza
armarPizza (i:is) = (Capa i (armarPizza is)) 
-- 1.c)
sacarJamon :: Pizza -> Pizza
-- Le saca los ingredientes que sean jamón a la pizza
sacarJamon Prepizza   = Prepizza
sacarJamon (Capa i p) = if esJamon i 
                            then sacarJamon p 
                            else (Capa i (sacarJamon p))

esJamon :: Ingrediente -> Bool 
esJamon Jamon = True 
esJamon _     = False  

-- 1.d)
tieneSoloSalsaYQueso :: Pizza -> Bool
-- Dice si una pizza tiene solamente salsa y queso (o sea, no tiene de otros ingredientes. En
-- particular, la prepizza, al no tener ningún ingrediente, debería dar verdadero.)
tieneSoloSalsaYQueso Prepizza    = True 
tieneSoloSalsaYQueso (Capa i p ) = (esSalsa i || esQueso i) &&  tieneSoloSalsaYQueso p

esSalsa :: Ingrediente -> Bool 
esSalsa Salsa = True 
esSalsa _     = False 

esQueso :: Ingrediente -> Bool 
esQueso Queso = True 
esQueso _     = False 

-- 1.e)
duplicarAceitunas :: Pizza -> Pizza
-- Recorre cada ingrediente y si es aceitunas duplica su cantidad
duplicarAceitunas Prepizza   = Prepizza 
duplicarAceitunas (Capa i p) = if esAceituna i 
                                then (Capa (dobleDeAceitunas i) (duplicarAceitunas p) )
                                else (Capa i  (duplicarAceitunas p))  

esAceituna :: Ingrediente -> Bool 
esAceituna (Aceitunas n ) = True 
esAceituna _             = False 

dobleDeAceitunas :: Ingrediente -> Ingrediente 
-- PROPOSITO: Dada una aceituna, duplica su cantidad. 
-- PRECONDICION: El ingrediente dado tiene que ser una aceituna. 
dobleDeAceitunas (Aceitunas n ) = (Aceitunas (n*2) )


-- 1.f)
cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
-- Dada una lista de pizzas devuelve un par donde la primera componente es la cantidad de
-- ingredientes de la pizza, y la respectiva pizza como segunda componente.
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = ((cantidadDeCapas p),p) : cantCapasPorPizza ps


--2.1) 

-- Un mapa de tesoros es un árbol con bifurcaciones que terminan en cofres. Cada bifurcación y
-- cada cofre tiene un objeto, que puede ser chatarra o un tesoro.
data Dir = Izq | Der
    deriving Show
data Objeto = Tesoro | Chatarra
    deriving Show
data Cofre = Cofre [Objeto]
    deriving Show
data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa
    deriving Show

mp = (Bifurcacion c1 (Bifurcacion c2 (Fin c3 )(Fin c4)) (Bifurcacion c5 (Fin c6)(Fin c7)))

c1 = Cofre []
c2 = Cofre []
c3 = Cofre []
c4 = Cofre []
c5 = Cofre [Tesoro]
c6 = Cofre []
c7 = Cofre []

-- 1.a)
hayTesoro :: Mapa -> Bool
-- Indica si hay un tesoro en alguna parte del mapa.
hayTesoro  (Fin cf)                 = hayTesoroEnCofre cf
hayTesoro  (Bifurcacion cf mp1 mp2) = hayTesoroEnCofre cf || hayTesoro mp1 || hayTesoro mp2

hayTesoroEnCofre :: Cofre -> Bool 
hayTesoroEnCofre (Cofre obs) = hayUnTesoro obs 

-- funciones del tp3: 
hayUnTesoro :: [Objeto] -> Bool 
hayUnTesoro []     = False 
hayUnTesoro (ob:obs) = esTesoro ob || hayUnTesoro obs  

esTesoro :: Objeto -> Bool 
esTesoro Tesoro = True 
esTesoro _      = False 

-- 1.b)
hayTesoroEn :: [Dir] -> Mapa -> Bool
-- Indica si al nal del camino hay un tesoro. Nota: el nal de un camino se representa con una lista vacía de direcciones.
hayTesoroEn [] mp      = hayTesoroEnCofre (cofreDe mp)
hayTesoroEn _ (Fin cf) = False 
hayTesoroEn (d:ds) (Bifurcacion cf mp1 mp2) = hayTesoroEn ds mp1 || hayTesoroEn ds mp2  
-- DUDA: Si llegue al fin del camino sin antes agotar la lista de direcciones, me fijo si el 
-- cofre del Fin del mapa tiene un tesoro o doy False directamente?  

cofreDe :: Mapa -> Cofre 
cofreDe (Fin cf)             = cf
cofreDe (Bifurcacion cf _ _) = cf

-- 1.c)
caminoAlTesoro :: Mapa -> [Dir]
-- Indica el camino al tesoro. 
-- Precondición: existe un tesoro y es único.
caminoAlTesoro (Fin cf)                  = []
caminoAlTesoro (Bifurcacion cf mp1 mp2 ) = if (hayTesoroEnCofre cf)
                                            then caminoAlTesoro mp1 ++ caminoAlTesoro mp2
                                            else Izq : caminoAlTesoro mp1 ++ (Der : caminoAlTesoro mp2)
 

-- 1.d)
caminoDeLaRamaMasLarga :: Mapa -> [Dir]
-- Indica el camino de la rama más larga.
caminoDeLaRamaMasLarga (Fin cf)                 = []
caminoDeLaRamaMasLarga (Bifurcacion cf mp1 mp2) = if length (caminoDeLaRamaMasLarga mp1) > length (caminoDeLaRamaMasLarga mp1)
                                                    then Izq : caminoDeLaRamaMasLarga mp1
                                                    else Der : caminoDeLaRamaMasLarga mp1
-- 1.e)
tesorosPorNivel :: Mapa -> [[Objeto]]
-- Devuelve los tesoros separados por nivel en el árbol.
tesorosPorNivel (Fin cf)                 =  [soloTesoros cf]
tesorosPorNivel (Bifurcacion cf mp1 mp2) = (soloTesoros cf) : tesorosPorNivel mp1 ++ tesorosPorNivel mp2  

soloTesoros :: Cofre -> [Objeto]
soloTesoros (Cofre obs) = tesoros obs 

tesoros :: [Objeto] -> [Objeto]
tesoros [] = []
tesoros (ob:obs) = if esTesoro ob 
                    then ob : tesoros obs 
                    else tesoros obs 

-- 1.f)
todosLosCaminos :: Mapa -> [[Dir]]
-- Devuelve todos lo caminos en el mapa.
todosLosCaminos (Fin cf)                 = []
todosLosCaminos (Bifurcacion cf mp1 mp2) = [Izq] : caminosPasados Izq (todosLosCaminos mp1) ++ 
                                           [Der] : caminosPasados Der (todosLosCaminos mp2)

caminosPasados :: Dir -> [[Dir]] -> [[Dir]]
caminosPasados dir []       = []
caminosPasados dir (dr:drs) = (dir : dr) : caminosPasados dir drs  

-- 3.1) Nave Espacial

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
                deriving Show
data Barril = Comida | Oxigeno | Torpedo | Combustible
                deriving Show
data Sector = S SectorId [Componente] [Tripulante]
                deriving Show
type SectorId = String

type Tripulante = String
                
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
                deriving Show
data Nave = N (Tree Sector) 
                deriving Show

nave      = N (sectoress)
sectoress = NodeT s1 (NodeT s2 EmptyT EmptyT) (NodeT s3 EmptyT EmptyT)
s1 = S "s" [LanzaTorpedos] ["a"]
s2 = S "s" [Motor 2] ["b"]
s3 = S "s" [Motor 2] ["c"]

-- Implementar las siguientes funciones utilizando recursión estructural:

-- 1.a)
sectores :: Nave -> [SectorId]
-- Propósito: Devuelve todos los sectores de la nave.
sectores (N tree ) = sectoresIdTree tree

sectoresIdTree :: Tree Sector -> [SectorId]
sectoresIdTree EmptyT            = []
sectoresIdTree (NodeT s izq der) = sectorIdDe s : (sectoresIdTree izq ++ sectoresIdTree der)

sectorIdDe :: Sector -> SectorId 
sectorIdDe (S id _ _ ) = id 

-- 1.b)
poderDePropulsion :: Nave -> Int
-- Propósito: Devuelve la suma de poder de propulsión de todos los motores de la nave. Nota:
-- el poder de propulsión es el número que acompaña al constructor de motores.
poderDePropulsion (N tree) = poderDePropulsionTree tree 

poderDePropulsionTree :: Tree Sector -> Int 
poderDePropulsionTree EmptyT            = 0 
poderDePropulsionTree (NodeT s izq der) = poderDePropulsionComps (compsDe s) + poderDePropulsionTree izq + poderDePropulsionTree der 

compsDe :: Sector -> [Componente] 
-- PROPOSITO: Dado un sector devuelve sus componentes. 
compsDe (S _ cs _) = cs 

poderDePropulsionComps :: [Componente] -> Int 
poderDePropulsionComps []     = 0 
poderDePropulsionComps (c:cs) = let  resto = poderDePropulsionComps cs in 
                                     case c of 
                                        (Motor i) -> i + resto 
                                        _         -> resto 
-- 1.c)
barriles :: Nave -> [Barril]
-- Propósito: Devuelve todos los barriles de la nave.
barriles (N tree) = barrilesTree tree 

barrilesTree :: Tree Sector -> [Barril]
barrilesTree EmptyT            = []
barrilesTree (NodeT s izq der) = barrilesDeComps (compsDe s) ++ (barrilesTree izq ++ barrilesTree der)


barrilesDeComps :: [Componente] -> [Barril]
barrilesDeComps []    = []
barrilesDeComps (c:cs) = let resto = barrilesDeComps cs in 
                            case c of
                            (Almacen bs) -> bs ++ resto 
                            _            -> resto   


-- 1.d)
agregarASector :: [Componente] -> SectorId -> Nave -> Nave
-- Propósito: Añade una lista de componentes a un sector de la nave.
-- Nota: ese sector puede no existir, en cuyo caso no añade componentes.
agregarASector [] _ n          = n 
agregarASector cs sId (N tree) = N (agregarASectorTree cs sId tree)  

agregarASectorTree :: [Componente] -> SectorId -> Tree Sector -> Tree Sector  
agregarASectorTree cs sId EmptyT            = EmptyT 
agregarASectorTree cs sId (NodeT s izq der) = NodeT (agregarCompsSi cs sId s) 
                                              (agregarASectorTree cs sId izq) (agregarASectorTree cs sId  der)

agregarCompsSi :: [Componente] -> SectorId -> Sector -> Sector
-- Proposito: Dada una lista de componentes, un sectorId y un sector, agrega la lista dada si son el mismo sector, caso contrario devuelve el sector dado. 
agregarCompsSi cs sId s = if  sId == idDe s 
                            then agregarComponentes cs s 
                            else s 

agregarComponentes :: [Componente] -> Sector -> Sector 
agregarComponentes cs (S id cs' ts) = (S id (cs'++cs) ts)   


idDe :: Sector -> SectorId 
idDe (S id _ _) = id 


-- 1.e)
asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave
-- Propósito: Incorpora un tripulante a una lista de sectores de la nave.
-- Precondición: Todos los id de la lista existen en la nave.
asignarTripulanteA t [] n = n 
asignarTripulanteA t ss (N tree) = N (asignarTripulanteATree t ss tree)

asignarTripulanteATree :: Tripulante -> [SectorId] -> Tree Sector -> Tree Sector 
asignarTripulanteATree _ _  EmptyT            = EmptyT
asignarTripulanteATree t ss (NodeT s izq der) = NodeT (agregarTripulanteA t ss s) 
                                        (asignarTripulanteATree t ss der)  (asignarTripulanteATree  t ss der)  

agregarTripulanteA :: Tripulante -> [SectorId] -> Sector -> Sector 
agregarTripulanteA t []     s' = s'
agregarTripulanteA t (s:ss) s' = if s == idDe s' 
                                    then agregarTripulante  t s' 
                                    else agregarTripulanteA t ss s'                                 

agregarTripulante :: Tripulante -> Sector -> Sector 
agregarTripulante t (S id cs ts) =  (S id cs (t:ts))

-- 1.f)
sectoresAsignados :: Tripulante -> Nave -> [SectorId]
-- Propósito: Devuelve los sectores en donde aparece un tripulante dado.
sectoresAsignados t (N tree) = sectoresAsignadosTree t tree   

sectoresAsignadosTree :: Tripulante -> Tree Sector -> [SectorId]
sectoresAsignadosTree t EmptyT            = []
sectoresAsignadosTree t (NodeT s izq der) = if pertenece t (tripulantesDe s) 
                                                then idDe s : (sectoresAsignadosTree t izq ++sectoresAsignadosTree t der  )
                                                else sectoresAsignadosTree t izq ++ sectoresAsignadosTree t der
-- funcion del tp2 
pertenece :: Eq a => a -> [a] -> Bool
--Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual
--a e.
pertenece a []     = False 
pertenece a (x:xs) = a == x || pertenece a xs  


tripulantesDe :: Sector -> [Tripulante]                                                
tripulantesDe (S _ _ ts) = ts 

-- 1.g)
tripulantes :: Nave -> [Tripulante]
-- Propósito: Devuelve la lista de tripulantes, sin elementos repetidos
tripulantes (N tree) = sinRepetidos (tripulantesTree tree) 

tripulantesTree :: Tree Sector -> [Tripulante]
tripulantesTree EmptyT            = []
tripulantesTree (NodeT s izq der) = tripulantesDe s ++ tripulantesTree izq ++ tripulantesTree der  

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if pertenece x xs 
                        then sinRepetidos xs 
                        else x : sinRepetidos xs 

--4) Manada de lobos
-- Modelaremos una manada de lobos, como un tipo Manada, que es un simple registro compuesto
-- de una estructura llamada Lobo, que representa una jerarquía entre estos animales.
-- Los diferentes casos de lobos que forman la jerarquía son los siguientes:
-- Los cazadores poseen nombre, una lista de especies de presas cazadas y 3 lobos a cargo.
-- Los exploradores poseen nombre, una lista de nombres de territorio explorado (nombres de
-- bosques, ríos, etc.), y poseen 2 lobos a cargo.
-- Las crías poseen sólo un nombre y no poseen lobos a cargo.
-- La estructura es la siguiente:

type Presa      = String
type Territorio = String
type Nombre     = String

data Lobo   = Cazador Nombre [Presa] Lobo Lobo Lobo | Explorador Nombre [Territorio] Lobo Lobo | Cria Nombre
                deriving Show
data Manada = M Lobo
-- 1. Construir un valor de tipo Manada que posea 1 cazador, 2 exploradores y que el resto sean crias
-- (Cazador "h" presas  (Explorador "e1" [] (cr1) (cr2)) exp2 (cr5))


lobo   = (Cazador "h" presas exp1 exp2 exp3)
manada = M lobo 
-- [("Selva-Norte",["e2","e3"]) ("Selva-Sur",["e2","e3"]) ("Selva-Oeste",["e3"]) ("Selva-Este" , ["e3"])]

exp1 = (Explorador "e1" ninguno (cr2) (cr2))
exp2 = (Explorador "e2" algunos (cr1) (cr2))
exp3 = (Explorador "e3" todos   (cr2) (cr4))


exp4 = (Explorador "e4" todos   (cr3) (cr4))


ninguno = []
algunos = ["Selva-Norte", "Selva-Sur"]
todos   = ["Selva-Norte", "Selva-Sur","Selva-Oeste","Selva-Este"]



presas   = ["p1","p2","p3","p4","p5","p6"]
nopresas = []

cr1 = Cria "c1"
cr2 = Cria "c2"
cr3 = Cria "c3"
cr4 = Cria "c4"
cr5 = Cria "c5"

-- crías. Resolver las siguientes funciones utilizando recursión estructural sobre la estructura
-- que corresponda en cada caso:

{-
f (Cria n)                 =
f (Explorador n ts l1 l2 ) = 
f (Cazador n ps l1 l2 l3 ) = 
-}

--2) 
buenaCaza :: Manada -> Bool
-- Propósito: dada una manada, indica si la cantidad de alimento cazado es mayor a la cantidad de crías.
buenaCaza (M lobo) = cantCrias lobo < cantPresas lobo 

cantCrias :: Lobo -> Int 
cantCrias (Cria _)                 = 1
cantCrias (Explorador n ts l1 l2 ) = cantCrias l1 + cantCrias l2 
cantCrias (Cazador n ps l1 l2 l3 ) = cantCrias l1 + cantCrias l2 + cantCrias l3

cantPresas :: Lobo -> Int 
cantPresas (Cria _)                 = 0 
cantPresas (Explorador _ _ l1 l2 )  = cantPresas l1 + cantPresas l2
cantPresas (Cazador _ ps l1 l2 l3 ) = length ps + cantPresas l1 + cantPresas l2 + cantPresas l3 

--3. 
elAlfa :: Manada -> (Nombre, Int)
--Propósito: dada una manada, devuelve el nombre del lobo con más presas cazadas, junto
--con su cantidad de presas. Nota: se considera que los exploradores y crías tienen cero presas
--cazadas, y que podrían formar parte del resultado si es que no existen cazadores con más de
--cero presas.
elAlfa (M lobo) = elLoboAlfa lobo

elLoboAlfa :: Lobo -> (Nombre, Int)
elLoboAlfa (Cria n)                 = (n,0)
elLoboAlfa (Explorador n ts l1 l2 ) = (n,0)
elLoboAlfa (Cazador n ps l1 l2 l3 ) = let loboAlfa   = elAlfaEntre (elLoboAlfa l1) (elLoboAlfa l2) (elLoboAlfa l3) in 
                                      let cantPresas = length ps in 
                                        if cantPresas > snd loboAlfa  
                                            then (n,cantPresas)
                                            else loboAlfa

elAlfaEntre ::  (Nombre, Int) ->  (Nombre, Int) ->  (Nombre, Int) -> (Nombre, Int)
-- PROPOSITO: Dada 3 tuplas, con el nombre de un lobo y su cantidad de presas, devuelve aquel que tenga el mayor numero de presas. 
elAlfaEntre t1 t2 t3 = elMayor t1 (elMayor t2 t3)

elMayor ::   (Nombre, Int) ->  (Nombre, Int) ->  (Nombre, Int)
-- PROPOSITO: Dado dos tuplas de tipo (Nombre, Int) devuelve aquella con el Int mayor. 
elMayor (n1,i1) (n2,i2) = if i1 > i2 
                            then (n1,i1) 
                            else (n2,i2) 

--4. 
losQueExploraron :: Territorio -> Manada -> [Nombre]
--Propósito: dado un territorio y una manada, devuelve los nombres de los exploradores que pasaron por dicho territorio.
losQueExploraron t (M lobo) = lobosQueExploraron t lobo 

lobosQueExploraron :: Territorio -> Lobo -> [Nombre]
lobosQueExploraron t (Cria _)                 = []
lobosQueExploraron t (Cazador n _ l1 l2 l3 ) = lobosQueExploraron t l1 ++ lobosQueExploraron t l2 ++ lobosQueExploraron t l3
lobosQueExploraron t (Explorador n ts l1 l2 ) = if pertenece t ts 
                                                then n : (lobosQueExploraron t l1 ++ lobosQueExploraron t l2)
                                                else lobosQueExploraron t l1 ++ lobosQueExploraron t l2  


--6. 
superioresDelCazador :: Nombre -> Manada -> [Nombre]
--Propósito: dado un nombre de cazador y una manada, indica el nombre de todos los
--cazadores que tienen como subordinado al cazador dado (directa o indirectamente).
--Precondición: hay un cazador con dicho nombre y es único.
superioresDelCazador n (M lobo) = lobosSuperioresDelCazador n lobo

lobosSuperioresDelCazador :: Nombre -> Lobo -> [Nombre]
lobosSuperioresDelCazador n' (Cria n)                 = []
lobosSuperioresDelCazador n' (Explorador n ts l1 l2 ) = if n == n' 
                                                        then []
                                                        else n : (lobosSuperioresDelCazador n' l1 ++ lobosSuperioresDelCazador n' l2)
lobosSuperioresDelCazador n' (Cazador n ps l1 l2 l3 ) = if n == n' 
                                                        then []
                                                        else n : (lobosSuperioresDelCazador n' l1 ++ lobosSuperioresDelCazador n' l2 ++ lobosSuperioresDelCazador n' l3)
                                                        


--5. 
exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
-- Propósito: dada una manada, denota la lista de los pares cuyo primer elemento es un territorio y cuyo segundo elemento es la lista de 
-- los nombres de los exploradores que exploraron dicho territorio. Los territorios no deben repetirse.
exploradoresPorTerritorio (M lobo) = lobosExploradoresPorTerritorio lobo 


lobosExploradoresPorTerritorio :: Lobo -> [(Territorio, [Nombre])]
lobosExploradoresPorTerritorio (Cria n)                 = []
lobosExploradoresPorTerritorio (Explorador n ts l1 l2 ) = agregarExplorador n ts (combinarResultados (lobosExploradoresPorTerritorio l1) (lobosExploradoresPorTerritorio l2))
lobosExploradoresPorTerritorio (Cazador n ps l1 l2 l3 ) = combinarResultados (combinarResultados (lobosExploradoresPorTerritorio l1) (lobosExploradoresPorTerritorio l2)) (lobosExploradoresPorTerritorio l3)

agregarExplorador :: Nombre -> [Territorio] -> [(Territorio, [Nombre])]-> [(Territorio, [Nombre])]
agregarExplorador n []     tns = []
agregarExplorador n (t:ts) tns = (t,[n]) : agregarExplorador n ts tns 

combinarResultados ::  [(Territorio, [Nombre])] ->  [(Territorio, [Nombre])] ->  [(Territorio, [Nombre])]
combinarResultados  []       tns2  = tns2
combinarResultados (tn:tns)  tns2  = let (t,ns) = tn in
                                        agregarNombresATerritorio t ns (combinarResultados tns tns2)

agregarNombresATerritorio :: Territorio -> [Nombre] -> [(Territorio, [Nombre])] ->  [(Territorio, [Nombre])]
agregarNombresATerritorio t ns [] = [(t,ns)] 
agregarNombresATerritorio t ns ((t2,ns2):tns) = if t == t2 
                                                    then (t,(combinarNombres ns ns2)) : tns 
                                                    else (t2, ns2) : (agregarNombresATerritorio t ns tns) 

combinarNombres :: [Nombre] -> [Nombre] -> [Nombre]
combinarNombres xs     [] = xs
combinarNombres []     ys = ys
combinarNombres (x:xs) ys = if pertenece x ys
                                then combinarNombres xs ys 
                                else x : (combinarNombres xs ys) 
