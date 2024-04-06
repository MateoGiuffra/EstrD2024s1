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
