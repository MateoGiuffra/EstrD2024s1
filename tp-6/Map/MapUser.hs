import MapV1 

valuesM :: Eq k => Map k v -> [Maybe v]
-- Proposito: obtiene los valores asociados a cada clave del map.
valuesM map = lookupsM (keys map) map 

lookupsM :: Eq k => [k] -> Map k v -> [Maybe v]
lookupsM []     map = []  
lookupsM (k:ks) map = lookupM k map : (lookupsM ks map )

todasAsociadas :: Eq k => [k] -> Map k v -> Bool
-- Proposito: indica si en el map se encuentran to das las claves dadas.
todasAsociadas []      map = True 
todasAsociadas (k:ks)  map = noEsNothing (lookupM k map) && todasAsociadas ks map 

noEsNothing :: Maybe a -> Bool 
noEsNothing Nothing = False 
noEsNothing _       = True 


listToMap :: Eq k => [(k, v)] -> Map k v
-- Proposito: convierte una lista de pares clave valor en un map.
listToMap []          = emptyM 
listToMap ((k,v):kvs) = assocM k v (listToMap kvs) 


mapToList :: Eq k => Map k v -> [(k, v)]
-- Proposito: convierte un map en una lista de pares clave valor.
mapToList map = mapToList' (keys map) map
                

mapToList' :: Eq k =>  [k] -> Map k v -> [(k, v)]
mapToList' [] map     = [] 
mapToList' (k:ks) map = (k,justFrom (lookupM k map)) : mapToList' ks map 

justFrom :: Maybe a -> a 
justFrom (Just a) =  a 

agruparEq :: Eq k => [(k, v)] -> Map k [v]
-- Proposito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
-- la misma clave.
agruparEq []            = emptyM
agruparEq ((k,v):kvs)   = case lookupM k (agruparEq kvs) of 
                            Nothing  -> assocM k [v] (agruparEq kvs)
                            Just vs  -> assocM k (v:vs) (agruparEq kvs)

incrementar :: Eq k => [k] -> Map k Int -> Map k Int
-- Proposito: dada una lista de claves de tip o k y un map que va de k a Int, le suma uno a
-- cada número asociado con dichas claves.
incrementar [] map     = map       
incrementar (k:ks) map = case lookupM k map of 
                            Nothing -> (incrementar ks map)
                            Just n  -> assocM k (n+1) (incrementar ks (deleteM k map)) 


mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
-- Proposito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
-- una clave del primero existe en el segundo, es reemplazada por la del primero
mergeMaps map1 map2 = mergeMaps' (keys map1) map1 map2 

mergeMaps' :: Eq k => [k] -> Map k v -> Map k v -> Map k v
mergeMaps' []     map1 map2  = map2  
mergeMaps' (k:ks) map1 map2  = assocM k (justFrom (lookupM k map1)) (mergeMaps' ks map1 map2) 



-- Ejercicio 5
-- Implemente estas otras funciones como usuario de Map:
indexar :: [a] -> Map Int a
indexar []     = emptyM 
indexar (v:vs) = let claves = (keys (indexar ( vs) )) in 
                    if null claves 
                        then assocM 0 v (indexar vs)
                        else assocM (last (claves) + 1) v (indexar vs) 
    

-- aumentarClave :: Map Int a -> Map Int a
-- aumentarClave v map = let claves = (keys map) in 
--                             if null claves 
--                                 then assocM 0 v map
--                                 else assocM (last (claves) + 1) v map 


-- -- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- -- su posición en la lista.
-- indexar vs = indexarLista (length vs - 1) vs (indexar ( vs)) 

-- indexarLista :: Int -> [a] -> Map Int a -> Map Int a  
-- indexarLista n []     map = emptyM  
-- indexarLista n (v:vs) map = if n < 0 
--                             then map 
--                             else assocM n v (indexarLista (n-1) vs map)

-- ocurrencias :: String -> Map Char Int
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.


-- Indicar los ordenes de complejidad en p eor caso de cada función del usuario en base a la
-- implementación elegida, justicando las respuestas.
-- 