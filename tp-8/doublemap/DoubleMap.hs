
data DoubleMap k v = BM (Map k (Map k v)) 
                        (Map k (Map k v)) 
{-
    INV.REP: 
        * Para ambos maps se cumple que, cualquier clave k1 asociado a el valor m2,
        cada clave k2 asociado al valor v en m2 es clave en el otro map del DoubleMap 
        asociado a un map que tiene a la vez a k1 asociado a v. 



-}
assocDM :: Eq k => k-> k -> v -> DoubleMap k v -> DoubleMap k v 
-- O log k1 + log k2 
assocDM k1 k2 v (BM m1 m2) = 
        BM (assocCM2 k1 k2 v m1) (assocCM2 k2 k1 v m2) 


-- que dado k1 y k2 asocia en m a k1 
-- o bien el resutlado de asociar k2 a v en caso de existir un map previo 
-- o bien el resutlado de asociar k2 a unnuevo mpa 
-- o 
-- log ka + # por assocM y lookupM sobre k1 
-- log kb   # por assocM sobre k2 
assocCM2 :: 
assocCM2 k1 k2 v m = 
        case lookupM k1 m of
        Just m2  -> assocM k1 (assocM k2 v m2) m 
        Nothing ->  assocM k1 (assocM k2 v emptyM) m

lookupBM  :: Either k k -> DoubleMap k v -> [(k,v)]
-- EFICIENCIA: 
-- max (log K1 + K2 log K2) (log K2 + K1 log K1)
-- segun ale porque no puede haber un sector con todos los trips de la nave, no tiene sentido,
-- aunque pueda llegar a pasar, no se contempla asi.
-- en el contexto del parcial, es rarisimo que un Alumno califico a TODOS los Profesores,
-- puede llegar a pasar, pero las chances son tan bajas que no se deberia de tomar en cuenta.
-- Tanto que si llega a pasar, pierde sentido la propia estructura. 
-- max (log K1 + K12 log K12) (log K2 + K21 log K21)
-- porque eventualmente se aplica a m1 y m2 o m2 y m1 respectivamente. 
lookupBM (Left k1) (BM m1 m2)  = subtarea k1 m1 
lookupBM (Right k1) (BM m1 m2) = subtarea k2 m2 

subtarea ::  Eq k =>  k -> Map k (Map k v) ->  [(k,v)]
-- O log m + # por lookupM en m 
-- m' + # por keysM sobre map anidado 
-- m' * # por RE sobre el resultado de keysM (o es knv)
-- log m' 
-- ) 
-- (log m + m' log m')
subtarea  k map =  case lookupM k map of
                        Just m2 -> knv (keys m2) m2   
                        Nothing -> [] 



knv :: Eq k => [k] -> Map k v ->   [(k,v)]
-- esta tiene una precondicion no se cual 
knv []  m    = []
knv (k:ks) m = case lookupM k m of
                Just v  -> (k,v) : knv ks m 
                Nothing -> knv ks m 

keysCm :: DoubleMap k v -> ([k],[k])
-- por keysM sobre ambos maps.
keysCm (BM m1 m2) = (keysM m1, keysM m2)

 
topNMasAfines :: Calificaciones -> Nombre -> Int -> [(Int, Nombre)]
-- medio falopa la explicacion de este, pero despues tenes que sacar factor comun con los 
-- logk12 de la linea 73 y 74, quedando log k12 * (N + k12)
-- log k1 + k12 log k12 + # por lookupCM 
-- k12 log k12 +          # por armarHeap sobre el maximo de los docentes calificados 
-- N * log k12            #  
topNMasAfines c an = takeNH n (armarHeap (lookupCM (Left a) c ))

takeNH :: 
-- EFICIENCIA: min (n h) * log h
takeNH n h = if esvacio h o es 0 n 
                then []
                else findMaxH h : (takeNH (n-1) (deleteMaxH h))

armarHeap :: [(Nombre,(Int,Int))] -> Heap (Int, Nombre)
-- EFICIENCIA
-- n * # por RE sobre la lista 
-- log n + # por insertG sobre una heap que eventualmente tiene la misma cardinalidad que la lista. 
armarHeap [] = emptyH 
armarHeap (x:xs) = let (x1,x2) = x in insertH ((afinidad x2, x1)) armarHeap xs