--1.1)
data Pizza = Prepizza | Capa Ingrediente Pizza
            deriving Show
data Ingrediente = Salsa| Queso | Jamon | Aceitunas Int
            deriving Show
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

pizza =  Capa (Aceitunas 2) (Capa Jamon (Capa Queso (Capa Jamon (Capa Queso Prepizza))))

-- 1.f)
-- cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
-- Dada una lista de pizzas devuelve un par donde la primera componente es la cantidad de
-- ingredientes de la pizza, y la respectiva pizza como segunda componente.
