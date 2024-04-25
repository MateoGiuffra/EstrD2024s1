import MapV1 

valuesM :: Eq k => Map k v -> [Maybe v]
-- Proposito: obtiene los valores asociados a cada clave del map.
valuesM k map = lookupsM (keys map) map 

lookupsM :: Eq k => [k] -> Map k v -> [Maybe v]
lookupsM []     map = []  
lookupsM (k:ks) map = lookupM k map : (lookupsM ks map )

todasAsociadas :: Eq k => [k] -> Map k v -> Bool
-- Proposito: indica si en el map se encuentran to das las claves dadas.
todasAsociadas ks map = existenEn ks (keys map)

existenEn :: Eq k => [k] -> [k] -> Bool 
existenEn []      ks2 = True 
existenEn (k:ks)  ks2 = elem k ks2 && existenEn ks ks2 


listToMap :: Eq k => [(k, v)] -> Map k v
-- Proposito: convierte una lista de pares clave valor en un map.
listToMap [] map          = map 
listToMap ((k,v):kvs) map = assocM k v (listToMap kvs map) 


mapToList :: Eq k => Map k v -> [(k, v)]
-- Proposito: convierte un map en una lista de pares clave valor.
mapToList map = mapToList' (keys map) map
                

mapToList' :: Eq k =>  [k] -> Map k v -> [(k, v)]
mapToList' [] map     = [] 
mapToList' (k:ks) map = (k,justFrom (lookupM m map)) : mapToList' ks map 

justFrom :: Maybe a -> a 
justFrom (Just a) =  a 

agruparEq :: Eq k => [(k, v)] -> Map k [v]
-- Proposito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
-- la misma clave.
agruparEq kvs = 


incrementar :: Eq k => [k] -> Map k Int -> Map k Int
-- Proposito: dada una lista de claves de tip o k y un map que va de k a Int, le suma uno a
-- cada número asociado con dichas claves.

mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
-- Proposito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
-- una clave del primero existe en el segundo, es reemplazada p or la del primero