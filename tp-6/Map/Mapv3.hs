-- Ejercicio 3
-- La interfaz del tip o abstracto Map es la siguiente:
-- Como dos listas, una de claves y otra de valores, donde la clave ubicada en la posición i está
-- asociada al valor en la misma posición, pero de la otra lista.


module MapV3(
        Map,
        emptyM,
        assocM,
        lookupM,
        deleteM,
        keys) where

data Map k v = M [k] [v]

{-
INV. REP: 
        Dado un map del estilo M ks vs
         * La longitud de las listas ks y vs deben de ser iguales. 
         * El valor de una clave tiene que estar en la misma posicion en vs que la de su clave en ksw. 
-}

emptyM :: Map k v
-- Propósito: devuelve un map vacío
-- EFICIENCIA: O(1) # Porque solamente se esta creando una instancia de Map vacia
emptyM = M [] []


assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
-- EFICIENCIA: O(1) # porque se usa el cons que es de costo 1. 
assocM k v (M ks vs) = M (k:ks) (v:vs)

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
-- EFICIENCIA: O(n) # porque se usa lookupKsVs siendo n longitud de la lista claves o de valores (tienen la misma longitud por invariante) 
lookupM k (M ks vs) = lookupKsVs k ks vs 

lookupKsVs :: Eq k => k -> [k] -> [v] -> Maybe v
-- PROPOSITO: Dada una clave, una lista de claves y otra lista de valores, 
-- devuelve el valor asociado como un Maybe v a dicho k, o sea con quien comparte misma posicion en la lista. 
-- EFICIENCIA: O(n)
-- O(n # siendo n la longitud de la lista de claves o de valores (tienen la misma longitud por invariante)
-- ya que se hace RE sobre la misma.
-- * # por cada elemento se hace: (
-- 1 # comparacion entre las claves k2 y k     
-- ))
lookupKsVs _ ks     []     = Nothing
lookupKsVs _ []     vs     = Nothing 
lookupKsVs k (k2:ks) (v:vs) = if k == k2 
                                then Just v 
                                else lookupKsVs k ks vs    

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
-- EFICIENCIA: O(n) # ya que se usa borrarElem y borrarAsociacionCon siendo n la longitud de la 
-- lista ks o vs ya que son la misma
deleteM k (M ks vs) = (M (borrarElem k ks) (borrarAsociacionCon k ks vs))

borrarAsociacionCon :: Eq k => k -> [k] -> [v] -> [v]
-- PROPOSITO: Dada una clave, una lista de claves y otra lista de valores, 
-- se borran las claves y valores asociadas a la clave dada. 
-- EFICIENCIA: O(n)
-- O(n # siendo n la longitud de la lista claves o de valores (tienen la misma longitud por invariante)
-- ya que se hace RE sobre las mismas.
-- * # por cada elemento se hace: (
-- 1 # comparacion entre las claves k2 y k         
-- ))
borrarAsociacionCon _ ks     []     = []
borrarAsociacionCon _ []     vs     = [] 
borrarAsociacionCon k (k2:ks) (v:vs) = if k == k2 
                                        then borrarAsociacionCon k ks vs
                                        else v : borrarAsociacionCon k ks vs 

borrarElem :: Eq a => a -> [a] -> [a]
-- PROPOSITO: Dado un valor y una lista del mismo tipo que el valor, borra el elemento dado. 
-- EFICIENCIA: O(n)
-- O(n # siendo n la longitud de la lista ya que se hace RE sobre las mismas.
-- * # por cada elemento se hace: (
-- 1 # comparacion entre x e y         
-- ))
borrarElem _ [] = []
borrarElem y (x:xs) = if x == y 
                        then borrarKey y xs  
                        else x : borrarKey y xs  

keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map
-- EFICIENCIA: O(1) # ya que se hace patter matching sobre Map.
keys (M ks _ ) = ks 

map =  assocM "Mateo" 20 
      $ assocM "Julian" 80
      $ assocM "Fede" 18
      $ assocM "Ivan" 21 emptyM

