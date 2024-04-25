-- Ejercicio 3
-- La interfaz del tip o abstracto Map es la siguiente:
-- Como dos listas, una de claves y otra de valores, donde la clave ubicada en la p osición i está
-- aso ciada al valor en la misma p osición, p ero de la otra lista.


module MapV1(
        Map,
        emptyM,
        assocM,
        lookupM,
        deleteM,
        keys) where

data Map k v = M [k] [v]

emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M [] []


assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una aso ciación clave-valor al map.
assocM k v (M ks vs) = M (k:ks) (v:vs)

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Prop ósito: encuentra un valor dado una clave.
lookupM k (M ks vs) = lookupKsVs k ks vs 

lookupKsVs :: Eq k => k -> [k] -> [v] -> Maybe v 
lookupKsVs _ ks     []     = Nothing
lookupKsVs _ []     vs     = Nothing 
lookupKsVs k (k2:ks) (v:vs) = if k == k2 
                                then Just v 
                                else lookupKsVs k ks vs    

deleteM :: Eq k => k -> Map k v -> Map k v
-- Prop ósito: b orra una aso ciación dada una clave.
deleteM k (M ks vs) = (M (borrarKey k ks) (borrarAsociacionCon k ks vs))

borrarAsociacionCon :: Eq k => k -> [k] -> [v] -> [v]
borrarAsociacionCon _ ks     []     = []
borrarAsociacionCon _ []     vs     = [] 
borrarAsociacionCon k (k2:ks) (v:vs) = if k == k2 
                                        then borrarAsociacionCon k ks vs
                                        else v : borrarAsociacionCon k ks vs 


borrarKey :: Eq k => k -> [k] -> [k]
borrarKey _ [] = []
borrarKey k2 (k:ks) = if k == k2 
                        then borrarKey k2 ks 
                        else k : borrarKey k2 ks  

keys :: Map k v -> [k]
-- Prop ósito: devuelve las claves del map
keys (M ks _ ) = ks 

map =  assocM "Mateo" 20 
      $ assocM "Julian" 80
      $ assocM "Fede" 18
      $ assocM "Ivan" 21 emptyM

