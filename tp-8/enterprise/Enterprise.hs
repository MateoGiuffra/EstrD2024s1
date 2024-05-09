
module Enterprise (
        Nave, 
        naveVacia,
        tripulantesDe,
        sectores,
        conMayorRango,
        conMasTripulantes,
        conRango,
        sectorDe,
        agregarTripulante,
        )where 
import MapV1
import SetV1
import MaxHeap
import TripulanteEnterprise
type Sector = String 
data Nave = MkN (Map Sector (Set Tripulante)) (MaxHeap Tripulante) (Sector, Int)


-- Donde:
-- Cada tripulante puede estar en un sector como máximo.
-- Se guarda al sector con más tripulantes de la nave y cuántos tripulantes tiene ese sector.
-- Los tripulantes se ordenan por rango de mayor a menor en la Heap
-- (no se confunda, findMin devuelve al tripulante con mayor rango)

{-
        INV. REP: En MkN (map sector setT) (h trip) (sector, int)
            * Si un tripulante "X" forma parte del Set Tripulante asignado al 
              sector "Y", no puede aparecer como tripulante asignado en otro sector de la nave. 
            * Los tripulantes del setT asignados a los sectores del map, tienen
              que existir y ser identicos a los tripulantes de h. 
            * En el par (sector, int): 
              El sector debe ser el que mas tripulantes asignados tiene y existe como clave en el map.
              El int debe ser la cantidad de tripulantes asignados a ese sector.  
-}


naveVacia :: [Sector] -> Nave
-- Propósito: Crea una nave con todos esos sectores sin tripulantes.
-- Precondición: la lista de sectores no está vacía
-- Costo: O(S log S) siendo S la cantidad de sectores de la lista.
-- (1         # por head sobre ss
-- + 
-- (S*Log K)) # por asignarSectores sobre emptyM, y como la cantidad de elementos del map depende de la 
--            # longitud de la lista de Sector, K es S, por ende quedaria:  
-- O(1 + S*Log S) 
-- O(S*Log S) # porque no importa la constante 1.  
naveVacia ss = MkN (asignarSectores ss emptyM) emptyH (head ss, 0)

asignarSectores :: [Sector] ->  Map Sector (Set Tripulante) -> Map Sector (Set Tripulante)
-- PROPOSITO: Dada una lista de sectores y un map, agrega esos sectores sin sectores asignados a dichom map.
-- EFICIENCIA:
-- (S     # siendo S la longitud de la lista de Sector, ya que se hace RE sobre la misma. 
-- *      # por cada s de ss se hace:  
-- (log K # por assocM sobre el map, siendo K la cantidad de claves distintas en el map
-- ))
-- O(S*Log K) 
asignarSectores [] m   = m  
asignarSectores (s:ss) m = assocM s emptyS (asignarSectores ss m) 

tripulantesDe :: Sector -> Nave -> Set Tripulante
-- Propósito: Obtiene los tripulantes de un sector.
-- Costo: O(log S) siendo S la cantidad de sectores.
-- Precondicion: El sector debe existir. 
-- Eficiencia: 
-- log S # por lookupM siendo S la cantidad de sectores. 
tripulantesDe sector (MkN m h sInt) = case lookupM sector m of
                                        Nothing  -> error"El sector no existe"
                                        Just set -> set    

sectores :: Nave -> [Sector]
-- Propósito: Denota los sectores de la nave
-- Costo: O(S) siendo S la cantidad de sectores.
-- Justificacion: por keys sobre el map de la nave. 
sectores (MkN m _ _) = keys m 

conMayorRango :: Nave -> Tripulante
-- Propósito: Denota el tripulante con mayor rango.
-- Precondición: la nave no está vacía.
-- Costo: O(1).
-- Justificacion: Por findMin sobre h que es de costo constante. 
conMayorRango  (MkN _ h _) = maxH h 

conMasTripulantes :: Nave -> Sector
-- Propósito: Denota el sector de la nave con más tripulantes.
-- Costo: O(1). # ya que se hace patter matching sobre el par sInt.  
conMasTripulantes (MkN m h sInt) = let (s,i) = sInt in s 

conRango :: Rango -> Nave -> Set Tripulante
-- Propósito: Denota el conjunto de tripulantes con dicho rango.
-- Costo: O(P log P ) siendo P la cantidad de tripulantes.
conRango r (MkN m h sInt) = tripulantesConRango r h 

tripulantesConRango :: Rango -> MaxHeap Tripulante -> Set Tripulante 
tripulantesConRango r emptyH = emptyS
tripulantesConRango r h      = let t = maxH h in 
                                if rango t == r 
                                    then addS t (tripulantesConRango r (deleteMaxH h))
                                    else tripulantesConRango r (deleteMaxH h)

sectorDe :: Tripulante -> Nave -> Sector
-- Propósito: Devuelve el sector en el que se encuentra un tripulante.
-- Precondición: el tripulante pertenece a la nave.
-- Costo: O(S log S log P ) siendo S la cantidad de sectores y P la cantidad de tripulantes.´
-- Mi Eficiencia: O(S + S*(Log S + Log P))
-- O(S # por keys sobre el map. 
-- + 
-- (s*(Log K + Log P)) # por sectorDel sobre el map. Como la lista de Sector y el Log K dependen del map, s y K son S. 
-- (S*(Log S + Log P))
-- O(S + S*(Log S + Log P))
sectorDe t (MkN m h sInt) =  sectorDel t (keys m) m 

sectorDel :: Tripulante -> [Sector] -> Map Sector (Set Tripulante) -> Sector
-- Proposito: Dado un tripulante, una lista de Sector y un Map Sector (Set Tripulante), te devuelve el Sector en el que pertenece Tripulante,
-- en caso contrario te devuelve un error.
-- Eficiencia: 
-- O(s     # siendo s la longitud de la lista de Sector, ya que se hace RE sobre la misma. 
-- *       # por cada s de ss se hace:  
-- (log K  # lookupM siendo K la cantidad de elementos del Map.  
-- + 
-- Log P)) #  belongS sobre el set de tripulantes, siendo P la cantidad de tripulantes
-- O(s*(Log K + Log P))
sectorDel t []     m = error "El tripulante no esta asignado a ningun sector"
sectorDel t (s:ss) m = case lookupM s m of 
                        Nothing ->  error"No existe el sector"
                        Just set -> if belongsS t set 
                                    then s 
                                    else sectorDel t ss m  

agregarTripulante :: Tripulante -> Sector -> Nave -> Nave
-- Propósito: Agrega un tripulante a ese sector de la nave.
-- Precondición: El sector está en la nave y el tripulante no.
-- Costo: No hay datos (justifique su elección).
agregarTripulante t s (MkN m h sInt) = MkN  (asignarTrip s t m) 
                                            (insertH t h) 
                                            (updatePar sInt (updateSectorMembers s t m)) 

asignarTrip :: Sector -> Tripulante ->  Map Sector (Set Tripulante) ->  Map Sector (Set Tripulante)
asignarTrip s t map = let (s',setUpdated) = updateSectorMembers s t map  in 
                        assocM s' setUpdated map    
    
    
updateSectorMembers :: Sector -> Tripulante ->  Map Sector (Set Tripulante) -> (Sector, (Set Tripulante))
updateSectorMembers s t map  = case lookupM s map  of
                                Nothing  -> error"No existe el sector"
                                Just set -> addNewMember t s set map  


addNewMember :: Tripulante -> Sector -> Set Tripulante ->  Map Sector (Set Tripulante) -> (Sector, (Set Tripulante))
addNewMember t s set m = if alreadyExists t (keys m) m
                            then (s,set) 
                            else (s, addS t set)

alreadyExists :: Tripulante ->  [Sector] -> Map Sector (Set Tripulante) -> Bool 
alreadyExists t []     m = False 
alreadyExists t (s:ss) m = case lookupM s m of
                                Nothing  -> error"No existe el sector"
                                Just set -> (belongsS t set) || alreadyExists t ss m  


updatePar :: (Sector, Int) -> (Sector, Set Tripulante) -> (Sector, Int)
updatePar (s1,n) (s2,set) = if n > sizeS set 
                             then (s1,n)
                             else (s2 , sizeS set) 

-- Los tipos Tripulante, Rango y Sector son abstractos. Pero sabemos que son comparables (Ord, Eq) y que el tipo T ripulante
-- posee esta función en su interfaz (la única que nos interesa):



-- ==============================================================================================================================================================================
--                  Anexo de interfaces                 Anexo de interfaces                 Anexo de interfaces
-- ==============================================================================================================================================================================

-- Set, siendo N la cantidad de elementos del conjunto:

-- emptyS :: Set a                                  O(1)
-- addS :: a -> Set a -> Set a                      O(log N)
-- belongsS :: a -> Set a -> Bool                   O(log N)
-- unionS :: Set a -> Set a -> Set a                O(N log N)
-- setToList :: Set a -> [a]                        O(N)
-- sizeS :: Set a -> Int                            O(1)

-- La interfaz de Heap, siendo N la cantidad de elementos de la heap:

-- emptyH :: Heap a                                 O(1)
-- isEmptyH :: Heap a -> Bool                       O(1)
-- insertH :: a -> Heap a -> Heap a                 O(log N )
-- findMin :: Heap a -> a                           O(1)
-- deleteMin :: Heap a -> Heap a                    O(log N )
-- splitMin :: Heap a -> (a, Heap a)                O(log N )


-- Map, siendo K la cantidad de claves distintas en el map:

-- emptyM :: Map k v                                O(1)
-- assocM :: k -> v -> Map k v -> Map k v           O(log K)
-- lookupM :: k -> Map k v -> Maybe v               O(log K)
-- deleteM :: k -> Map k v -> Map k v               O(log K)
-- domM :: Map k v -> [k]                           O(K)


-- Tripulante, siendo S la cantidad de sectores:

-- rango :: Tripulante -> Rango                      O(1)
