-- Ejercicio 3
-- La interfaz del tip o abstracto Map es la siguiente:

-- Como una lista de pares-clave valor con claves repetidas

module MapV2(
        Map,
        emptyM,
        assocM,
        lookupM,
        deleteM,
        keys) where

data Map k v = M [(k,v)]

emptyM :: Map k v
-- Propósito: devuelve un map vacío
-- EFICIENCIA: O(1) # porque se usa el constructor.
emptyM = M []

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una aso ciación clave-valor al map.
-- EFICIENCIA O(1) # ya que se usa cons sobre kvs 
assocM k v (M kvs) = M (((k,v):kvs))

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
-- EFICIENCIA: O(n) # porque se usa buscarValorAsociado siendo n longitud de la lista de pares. 
lookupM k (M kvs) = buscarValorAsociado k kvs

buscarValorAsociado :: Eq k => k -> [(k,v)] -> Maybe v
-- PROPOSITO: Dada una clave y una lista de pares de tipo clave,valor, 
-- devuelve el valor asociado como un Maybe v a dicho k, o sea con quien comparte par. 
-- EFICIENCIA: O(n)
-- O(n # siendo n la longitud de la lista de pares ya que se hace RE sobre la misma.
-- * # por cada elemento se hace: (
-- 1 # comparacion entre las claves k2 y k         
-- ))
buscarValorAsociado k []  = Nothing 
buscarValorAsociado k ((k2,v2):kvs) = if k == k2 
                                        then Just v2 
                                        else buscarValorAsociado k kvs  

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
-- O(n) # porque se usa borrarAsociacion siendo n longitud de la lista de pares. 
deleteM  k (M kvs) = M (borrarAsociacion k kvs)

borrarAsociacion :: Eq k => k -> [(k,v)] -> [(k,v)] 
-- PROPOSITO: Dada una clave y una lista de pares de tipo (clave,valor), 
-- se borran los pares que tienen dicha clave. 
-- EFICIENCIA: O(n)
-- O(n # siendo n la longitud de la lista de pares ya que se hace RE sobre la misma.
-- * # por cada elemento se hace: (
-- 1 # comparacion entre las claves k2 y k         
-- ))
borrarAsociacion _ []  = []
borrarAsociacion k ((k2,v2):kvs) = if k == k2 
                                    then borrarAsociacion k kvs 
                                    else (k2,v2) : borrarAsociacion k kvs 


keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.
-- O(n) ya que se usa listaDeFNDs, siendo n la longitud de la lista
keys (M kvs) = listaDeFstDe kvs 
-- Aca tengo que usar el sin repetidos?

listaDeFNDs :: [(k,v)] -> [k]
-- PROPOSITO: Dada una lista de pares de tipo (clave,valor), devuelve todas las claves en una lista. 
-- O(n) # siendo n la longitud de la lista ya que se hace RE sobre la misma.  
listaDeFNDs []          = []
listaDeFNDs ((k,v):kvs) = k : listaDeFNDs kvs   

map =  assocM "Mateo" 20 
      $ assocM "Julian" 80
      $ assocM "Fede" 18
      $ assocM "Ivan" 21 emptyM

     