-- Ejercicio 3
-- La interfaz del tip o abstracto Map es la siguiente:
--  Como una lista de pares-clave valor sin claves rep etidas
module MapV1(
        emptyM,
        assocM,
        lookupM,
        deleteM,
        keys) where

data Map k v = M [(k,v)]

emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M []


assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una aso ciación clave-valor al map.
assocM k v (M kvs) = M (asociarKV k v kvs)

asociarKV :: Eq k => k -> v -> [(k,v)] -> [(k,v)]
asociarKV k v []            = [(k,v)]
asociarKV k v ((k2,v2):kvs) = if k == k2 
                                then (k2,v)  : kvs 
                                else (k2,v2) : asociarKV k v kvs
 
lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k (M kvs) = buscarValorAsociado k kvs

buscarValorAsociado :: Eq k => k -> [(k,v)] -> Maybe v
buscarValorAsociado k []  = Nothing 
buscarValorAsociado k ((k2,v2):kvs) = if k == k2 
                                        then Just v2 
                                        else buscarValorAsociado k kvs  

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: b orra una aso ciación dada una clave.
deleteM  k (M kvs) = M (borrarAsociacion k kvs)

borrarAsociacion :: Eq k => k -> [(k,v)] -> [(k,v)] 
borrarAsociacion _ []  = []
borrarAsociacion k ((k2,v2):kvs) = if k == k2 
                                    then borrarAsociacion k kvs 
                                    else (k2,v2) : borrarAsociacion k kvs 


keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M kvs) = listaDeFndDe kvs 


listaDeFndDe :: [(k,v)] -> [k]
listaDeFndDe []          = []
listaDeFndDe ((k,v):kvs) = k : listaDeFndDe kvs   

map =  assocM "Mateo" 20 
      $ assocM "Julian" 80
      $ assocM "Fede" 18
      $ assocM "Ivan" 21 emptyM

