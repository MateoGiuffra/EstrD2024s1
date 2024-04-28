import MapV1 -- map sin claves repetidas. 

valuesM :: Eq k => Map k v -> [Maybe v]
-- Proposito: obtiene los valores asociados a cada clave del map.
-- EFICIENCIA: 
valuesM map = lookupsM (keys map) map 

lookupsM :: Eq k => [k] -> Map k v -> [Maybe v]
-- EFICIENCIA: O(n*m) 
-- O(n # siendo n la longitud de la lista de ks ya que es hace RE sobre la misma
-- * # por cada elemento de ks se hace
-- m # lookupM de k a map que es de costo m
--))
{-           
            el map en realidad tiene estos pares porque admite repetidos       
keys de -> [("Mateo",21),("Mateo",22),("Nico",30)]               
pero te devuelve sin repetidos las keys
-> ["Mateo","Nico"]                  
-> long 2 

pero si yo hago lookupM en 
lookupM de -> [("Mateo",21),("Mateo",22),("Nico",30)] 
en el peor de los casos no recorre 2, recorre 3 elementos, entonces no son el mismo n.
por ende, pongo m en vez de n. 

en este caso, estoy usando map que no tiene claves repetidas, entonces se que es cuadratica, pero si no 
lo supiera, cual es la respuesta correcta? 
-}
lookupsM []     map = []  
lookupsM (k:ks) map = lookupM k map : (lookupsM ks map )

todasAsociadas :: Eq k => [k] -> Map k v -> Bool
-- Proposito: indica si en el map se encuentran to das las claves dadas.
-- EFICIENCIA: O(n*m)
-- O(n # siendo n la longitud de ks ya que se hace RE sobre la misma. 
-- *   # por cada k de ks se hace:
-- (m   # por lookupM, siendo m la cantidad de elementos del map.
-- + 
-- 1   # por noEsNothing que es de costo constante. 
-- ))
-- O(n*(m + 1))
-- O(n*m)
todasAsociadas []      map = True 
todasAsociadas (k:ks)  map = noEsNothing (lookupM k map) && todasAsociadas ks map 

noEsNothing :: Maybe a -> Bool 
-- PROPOSITO: Dado un Maybe indica si no es Nothing.
-- EFICIENCIA: O(1) ya que se hace patter matching sobre Maybe a. 
noEsNothing Nothing = False 
noEsNothing _       = True 


listToMap :: Eq k => [(k, v)] -> Map k v
-- Proposito: convierte una lista de pares clave valor en un map.
-- EFICIENCIA: O(n*m)
-- O(n # siendo n la longitud de la lista de pares ya que se hace RE sobre la misma
-- *   # por cada (k,v) de kvs se hace:
-- m   # por assocM sobre la RE 
-- ))
listToMap []          = emptyM 
listToMap ((k,v):kvs) = assocM k v (listToMap kvs) 


mapToList :: Eq k => Map k v -> [(k, v)]
-- Proposito: convierte un map en una lista de pares clave valor.
mapToList map = mapToList' (keys map) map
                

mapToList' :: Eq k =>  [k] -> Map k v -> [(k, v)]
-- PROPOSITO: Dada una lista de claves y un map, te devuelve la lista de pares del map. 
-- PRECONDICION: La lista de claves deben ser claves que pertencen al map dado.
-- EFICIENCIA: O(n*m) 
-- O(n # siendo n la longitud de la lista de claves ya que se hace RE sobre la misma
-- *   # por cada k de ks se hace:
-- (m  # por lookupM de k sobre map. 
-- + 
-- 1   # por justFrom y cons
-- ))
-- O(n*(m+1))
-- O(n*m) 
mapToList' [] map     = [] 
mapToList' (k:ks) map = (k,justFrom (lookupM k map)) : mapToList' ks map 

justFrom :: Maybe a -> a 
-- PROPOSITO: Dado un Maybe a devuelve a. 
-- PRECONDICION: Maybe a debe ser un Just a. 
-- EFICIENCIA: O(1) por patter matching sobre Maybe. 
justFrom (Just a) =  a 

agruparEq :: Eq k => [(k, v)] -> Map k [v]
-- Proposito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan la misma clave.
-- EFICIENCIA: O(n*m)
-- O(n # siendo n la longitud de la lista de pares ya que se hace RE sobre la misma
-- *   # por cada (k,v) de kvs se hace:
-- (m  # por lookupM de k y la RE 
-- +   # tambien se hace: 
-- m   # assocM de k y v sobre la RE
-- ))
-- O(n*(m+m))
-- O(n*(2m))
-- O(n*m)
agruparEq []            = emptyM
agruparEq ((k,v):kvs)   = case lookupM k (agruparEq kvs) of 
                            Nothing  -> assocM k [v] (agruparEq kvs)
                            Just vs  -> assocM k (v:vs) (agruparEq kvs)

incrementar :: Eq k => [k] -> Map k Int -> Map k Int
-- Proposito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
-- cada número asociado con dichas claves.
-- EFICIENCIA: O(n*m)
-- O(n # siendo n la longitud de la lista de tipo k ya que se hace RE sobre la misma
-- *   # por cada k de ks se hace:
-- (m  # por lookupM de k y la RE 
-- +   # tambien se hace: 
-- m   # assocM de k y n sobre la RE
-- ))
-- O(n*(m+m+1))
-- O(n*(2m+1))
-- O(n*(m+1))
-- O(n*m)
incrementar [] map     = map       
incrementar (k:ks) map = case lookupM k map of 
                            Nothing -> incrementar ks map
                            Just n  -> assocM k (n+1) (incrementar ks (deleteM k map)) 


mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
-- Proposito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
-- una clave del primero existe en el segundo, es reemplazada por la del primero.
-- EFICIENCIA: 
mergeMaps map1 map2 = mergeMaps' (keys map1) map1 map2 

mergeMaps' :: Eq k => [k] -> Map k v -> Map k v -> Map k v
-- PROPOSITO: Dada una lista de tipo k, dos maps de tipo k v, se agregan las k y v del 
-- primer map al segundo. Si una clave del primero existe en el segundo, es reemplazada por la del primero.
-- PRECONDICION: La lista de tipo k tienen que ser las keys del primer map. 
-- EFICIENCIA: 
-- O(n # siendo n la longitud de la lista de tipo k ya que se hace RE sobre la misma
-- *   # por cada k de ks se hace:
-- (m  # por lookupM de k y la RE 
-- +   # tambien se hace: 
-- m   # assoc sobre la RE
-- +   
-- 1   # por justFrom
-- ))
-- 
mergeMaps' []     map1 map2  = map2  
mergeMaps' (k:ks) map1 map2  = assocM k (justFrom (lookupM k map1)) (mergeMaps' ks map1 map2) 



-- Ejercicio 5
-- Implemente estas otras funciones como usuario de Map:
                     -- else assocM (last (claves) + 1) v (indexar vs) 

indexar :: [a] -> Map Int a
indexar []     = emptyM 
indexar (v:vs) = assocConClaveAumentada v (indexar vs)
                        -- else assocM (last (claves) + 1) v (indexar vs) 

assocConClaveAumentada :: a -> Map Int a -> Map Int a 
assocConClaveAumentada v map = assocM (ultimaClaveAumentada map) v map

ultimaClaveAumentada :: Map Int a -> Int 
ultimaClaveAumentada map = if null (keys map)
                              then 0 
                              else last (keys map) + 1 



ocurrencias :: String -> Map Char Int
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.
-- EFICIENCIA: 
-- O(n # siendo n la longitud de la lista de Strings ya que se hace RE sobre la misma
-- *   # por cada s de ss se hace:
-- (m  # assocM sobre RE -> m puede ser que sea n tambien? porque estoy haciendo assocM sobre RE?
-- +   # tambien se hace
--  n  # por cantDeApariciones sobre la lista de Strings 
--))
-- O(n(n+m))
ocurrencias []     = emptyM 
ocurrencias (s:ss) = assocM s (cantDeApariciones s ss) (ocurrencias ss)

cantDeApariciones ::  Char -> [Char] -> Int 
-- PROPOSITO: Dado un Caracter y una lista de Caracteres, devuelve la cantidad de veces que aparece 
-- el Caracter dado en la lista. 
-- EFICIENCIA: O(n)
-- O(n  # siendo n la longitud de la lista de string ya que se hace RE sobre la misma
-- *    # por cada c de cc se hace:
-- 1    # por la comparacion de c2 y c
--))
cantDeApariciones _ []      = 1 
cantDeApariciones c2 (c:cc) = unoSi (c2 == c) + cantDeApariciones c2 cc 


unoSi ::Bool -> Int 
unoSi True  = 1 
unoSi False = 0

-- Indicar los ordenes de complejidad en p eor caso de cada función del usuario en base a la
-- implementación elegida, justicando las respuestas.
-- 

-- INTENTOS
{-
-- 1)
indexar :: [a] -> Map Int a
indexar []     = emptyM 
indexar (v:vs) = let claves = (keys (indexar ( vs) )) in 
                    if null claves 
                        then assocM 0 v (indexar vs)
   

aumentarClave :: Map Int a -> Map Int a
aumentarClave v map = let claves = (keys map) in 
                            if null claves 
                                then assocM 0 v map
                                else assocM (last (claves) + 1) v map 

-- 2)
-- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- su posición en la lista.
indexar vs = indexarLista (length vs - 1) vs (indexar ( vs)) 

indexarLista :: Int -> [a] -> Map Int a -> Map Int a  
indexarLista n []     map = emptyM  
indexarLista n (v:vs) map = if n < 0 
                            then map 
                            else assocM n v (indexarLista (n-1) vs map)
-}