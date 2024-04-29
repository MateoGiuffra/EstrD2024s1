module MultiSet (MultiSet,
            emptyMS,
            addMS,
            ocurrencesMS,
            unionMS,
            intersectionMS,
            multiSetToList)where

import MapV1 -- Version de Map sin elementos repetidos 

data MultiSet a = M (MapV1.Map a Int)

ms1 = addMS "Mateo" 
      $ addMS "Mateo" $ addMS "Mateo" $ addMS "Bian" $ addMS "Bian"  emptyMS


ms2 = addMS "Kick" 
      $ addMS "Kick" $ addMS "Twitch" $ addMS "Twitch" $ addMS "Bian"  emptyMS

emptyMS :: MultiSet a
-- Propósito: denota un multiconjunto vacío.
-- EFICIENCIA: O(1) por emptyM 
emptyMS = M emptyM



addMS :: Ord a => a -> MultiSet a -> MultiSet a
-- Propósito: dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al multiconjunto.
-- EFICIENCIA: O(n) # por assocApariciones sobre map.  
addMS e (M map) = M (assocApariciones e map)

assocApariciones :: Eq a => a -> Map a Int -> Map a Int
-- PROPOSITO: Dado un elemento a agregar al map dado, lo agrega asociado con su cantidad de apariciones en el map. 
-- EIFICIENCIA: O(n) 
-- O
--(n  # por lookupM sobre map
-- + 
-- n) # por assocM sobre map   
assocApariciones e map = case lookupM e map of 
                            Nothing -> assocM e 1 map 
                            Just n  -> assocM e (n+1) map  

ocurrencesMS :: Ord a => a -> MultiSet a -> Int
-- Propósito: dados un elemento y un multiconjunto indica la cantidad de apariciones de ese
-- elemento en el multiconjunto.
-- EFICIENCIA: 
-- O(n # por ocurrencesM)
ocurrencesMS e (M map) = ocurrencesM e map 


ocurrencesM :: Ord a => a -> Map a Int -> Int
-- Propósito: dados un elemento y un map indica la cantidad de apariciones de ese
-- elemento en el map.
-- EFICIENCIA: O(n)
-- O(n # por lookupM sobre map)
ocurrencesM e map = case lookupM e map of 
                            Nothing -> 0
                            Just n  -> n 

unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
-- Propósito: dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de
-- ambos multiconjuntos.
-- EFICIENCIA: O(n + n*(n+m))
-- O(n     # siendo n la cantidad de elementos del map1
-- +       # tambien se hace:
-- n*(n+m) # por unionM siendo m la cantidad de elementos del segundo map.
--)
unionMS (M map1) (M map2) = M (unionM (keys map1) map1 map2) 

unionM :: (Eq a, Ord a) =>  [a] -> Map a Int -> Map a Int -> Map a Int
-- PROPOSITO: Dada una lista de claves, y dos maps (map1 y map2), devuelve un map con todos los elementos 
-- de ambos maps.
-- PRECONDICION: La lista de claves tienen que ser las claves del map1. 
-- EFICIENCIA: O(n*(n+m))
-- O(n # siendo n la longitud de la lista de claves ya que se hace RE sobre la misma.
-- *   # por cada k de ks se hace:
-- (n  # se hace un lookupM de k map1
-- +   # tambien se hace:
-- 1   # por JustFrom
-- +
-- m   # por lookupM siendo m la cantidad de elementos del map2
-- + 
-- m   # assocM sobre k y la recursion es n pero sobre map2 es m, asi que por el peor caso pongo m
-- ))
-- O(n*(n+1+m+m))
-- O(n*(n+2m))  # el uno se va ya que es indiferente y se juntan las m multiplicadas por 2.
-- O(n*(n+m))   # porque se suprime la constante 2m
unionM []     map1 map2 = map2
unionM (k:ks) map1 map2 = let m = justFrom (lookupM k map1) in 
                         case lookupM k map2 of
                            Nothing -> assocM k m map2
                            Just  n -> assocM k (n+m) (unionM ks map1 map2)

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
-- Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos 
-- multiconjuntos tienen en común.
-- EFICIENCIA: n + n*(m+n) 
-- O(n          # siendo n la cantidad de elementos de map1 
-- +            # y tambien se hace:
-- (n*(m+n))    # por intersectionM siendo m la cantidad de elementos de map2 
-- n + n*(m+n)  # resultado
intersectionMS (M map1) (M map2) = M (intersectionM (keys map1) map1 map2)



intersectionM :: (Eq a, Ord a) => [a] -> Map a Int -> Map a Int -> Map a Int
-- PROPOSITO: Dada una lista de claves, y dos maps (map1 y map2), devuelve un map con los elementos que 
-- ambos tienen en comun.
-- PRECONDICION: La lista de claves tienen que ser las claves del map1. 
-- EFICIENCIA: O(n*(m+n))
-- O(n # siendo n la longitud de la lista de claves del map1 ya que se hace RE sobre la misma 
-- *   # por cada k de ks se hace:
--(m   # por lookupM siendo m la cantidad de elementos del map2
-- +   # 
-- n   # por assocM sobre k y la recursion siendo n la longitud de la lista de claves
-- +   
-- n   # por ocurrencesM sobre map1 que es de la misma longitud que la lista de claves. -- Como se por inv rep que no hay elems repetidos, se que son el mismo numero
--))
-- O(n*(m+n+n))
-- O(n*(m+2n))
-- O(n*(m+n))
intersectionM []     map1 map2 = emptyM 
intersectionM (k:ks) map1 map2 = case lookupM k map2 of
                                    Nothing -> intersectionM ks map1 map2
                                    Just  n -> assocM k (ocurrencesM k map1 + n) (intersectionM ks map1 map2) 


multiSetToList :: Eq a => MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con to dos los elementos del conjunto y
-- su cantidad de ocurrencias.
-- 
multiSetToList (M map) = (mapToList map)

-- FUNCIONES AUXILIARES DE MapUser
mapToList :: Eq k => Map k v -> [(k, v)]
-- Proposito: convierte un map en una lista de pares clave valor.
--EFICIENCIA: O(n + (n^2))
-- O( n # siendo n la cantidad de elementos del map
-- +      
-- O(n^2)) por mapToList' 
-- O(n + (n^2))
mapToList map = mapToList' (keys map) map
                

mapToList' :: Eq k =>  [k] -> Map k v -> [(k, v)]
-- PROPOSITO: Dada una lista de claves y un map, te devuelve la lista de pares del map. 
-- PRECONDICION: La lista de claves deben ser claves que pertenecen al map dado.
-- EFICIENCIA: O(n*m) 
-- O(n # siendo n la longitud de la lista de claves ya que se hace RE sobre la misma
-- *   # por cada k de ks se hace:
-- (n  # por lookupM de k sobre map que por invariante son la misma cant de elementos. 
-- + 
-- 1   # por justFrom y cons
-- ))
-- O(n*(n+1))
-- O(n*n)
-- O(n^2) 
mapToList' [] map     = [] 
mapToList' (k:ks) map = (k,justFrom (lookupM k map)) : mapToList' ks map 

justFrom :: Maybe a -> a 
-- PROPOSITO: Dado un Maybe a devuelve a. 
-- PRECONDICION: Maybe a debe ser un Just a. 
-- EFICIENCIA: O(1) por patter matching sobre Maybe. 
justFrom (Just a) =  a


