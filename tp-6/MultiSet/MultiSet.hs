module MultiSet (MultiSet,
            emptyMS,
            addMS,
            ocurrencesMS,
            unionMS,
            intersectionMS,
            multiSetToList)where

import MapV1

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

unionMS (M map1) (M map2) = M (unionM (keys map1) map1 map2) 

unionM :: (Eq a, Ord a) =>  [a] -> Map a Int -> Map a Int -> Map a Int
unionM []     map1 map2 = map2
unionM (k:ks) map1 map2 = let m = justFrom (lookupM k map1) in 
                         case lookupM k map2 of
                            Nothing -> assocM k m map2
                            Just  n -> assocM k (n+m) (unionM ks map1 map2)

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
-- Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos 
-- multiconjuntos tienen en común.
intersectionMS (M map1) (M map2) = M (intersectionM (keys map1) map1 map2)

intersectionM :: (Eq a, Ord a) => [a] -> Map a Int -> Map a Int -> Map a Int
intersectionM []     map1 map2 = emptyM 
intersectionM (k:ks) map1 map2 = case lookupM k map2 of
                                    Nothing -> intersectionM ks map1 map2
                                    Just  n -> assocM k (ocurrencesM k map1 + n) (intersectionM ks map1 map2) 


multiSetToList :: Eq a => MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con to dos los elementos del conjunto y
-- su cantidad de o currencias
multiSetToList (M map) = (mapToList map)

-- FUNCIONES AUXILIARES DE MapUser
mapToList :: Eq k => Map k v -> [(k, v)]
-- Proposito: convierte un map en una lista de pares clave valor.
mapToList map = mapToList' (keys map) map
                
mapToList' :: Eq k =>  [k] -> Map k v -> [(k, v)]
mapToList' [] map     = [] 
mapToList' (k:ks) map = (k,justFrom (lookupM k map)) : mapToList' ks map 

justFrom :: Maybe a -> a 
justFrom (Just a) =  a 


