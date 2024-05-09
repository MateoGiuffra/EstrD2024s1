-- Usuario
-- Implementar las siguientes funciones como usuario del tipo Nave, indicando la eficiencia obtenida para cada operación:
-- i) 
sectores :: Nave -> Set SectorId
-- Propósito: Devuelve todos los sectores no vacíos (con tripulantes asignados).
-- Eficiencia: T*(S*(log S)) + (T*(log T))
-- (T*(S*(log S))) # por sectoresDe sobre la nave, siendo T la cantidad de tripulantes de esa nave, y S la cantidad de sectores de la nave.
-- + 
-- O(T*(log T))    # por tripulantesN sobre la nave. 
-- T*(S*(log S)) + (T*(log T))
sectores n = sectoresDe (tripulantesN n)

sectoresDe :: [Tripulante] -> Set SectorId
-- PROPOSITO: Dada una lista de tripulantes, te devuelve todos los sectores a los que estan asignados. 
-- EFICIENCIA: O(n*(s*(log s)))  
-- O(n # siendo n la longitud de la lista de tripulantes ya que se hace RE sobre la misma. 
-- (*  # por cada n de ns se hace: 
-- s*(log s)   # por uniosS sobre los sectores de los tripulantes.   
-- + 
-- 1   # por sectoresT sobre t  
--)
-- (n*(s*(log s) + 1))
-- (n*(s*(log s)))      # porque no importa la constante 1 
sectoresDe []     = emptyS 
sectoresDe (t:ts) = unionS (sectoresT t) (sectoresDe ts n )

-- j) 
sinSectoresAsignados :: Nave -> [Tripulante]
-- Propósito: Devuelve los tripulantes que no poseen sectores asignados.
-- EFICIENCIA: O(T*(log T))
-- T              # por soloNoAsinados sobre la lista de tripulantes de la nave.   
-- + 
-- (T*(log T))    # por tripulantesN sobre la nave. 
-- O(T*(log T) + T)
-- O(T*(log T))   # porque queda lo mas costoso. 
sinSectoresAsignados n = soloNoAsinados (tripulantesN n)

soloNoAsinados :: [Tripulante] -> [Tripulante] 
-- PROPOSITO: Dada una lista de tripulantes, te devuelve la lista actualizada con los tripulantes sin 
-- sectores asignados. 
-- EFICIENCIA: O(n)
-- O(n # siendo n la longitud de la lista de tripulantes ya que se hace RE sobre la misma. 
-- * 
-- 1)  # por isEmptyS, sectoresT y cons.
-- O(n)
soloNoAsinados []     = []
soloNoAsinados (t:ts) = if isEmptyS (sectoresT t)
                            then t : soloNoAsinados ts 
                            else soloNoAsinados ts
-- k) 
barriles :: Nave -> [Barril]
-- Propósito: Devuelve todos los barriles de los sectores asignados de la nave.
-- EFICIENCIA: O(T(log T) + T*(S+c))
-- T(log T)  # por tripulantesN sobre la nave, siendo T la cantidad de tripulantes de la nave. 
-- + 
-- (T*(S+c)) # por barrilesDe, siendo S la cantidad de sectores de la nave. 
-- O(T(log T) + T*(S+c))
barriles n = barrilesDe (tripulantesN n)


barrilesDe :: [Tripulante] -> [Barril]
-- PROPOSITO: Dada una lista de tripulantes, te devuelve todos los barriles de los sectores asignados a esos tripulantes.
-- EFICIENCIA: O(n*(s+c))
-- n( # siendo t la longitud de la lista de Tripulante dada ya que se hace RE sobre la misma
-- *  # por cada t de ts se hace  
--(1  # sectoresT 
-- + 
-- s  # por setToList siendo s la cantidad de sectores asignados a un tripulante
-- + 
-- c  # por soloBarriles siendo c la longitud de la lista de componentes de los sectores 
-- O(n*(1+s+c))
-- O(n*(s+c))
barrilesDe [] = []
barrilesDe (t:ts) = soloBarriles (setToList (sectoresT t)) ++ barrilesDe ts 

soloBarriles :: [Componente] -> [Barril]
--PROPOSITO: Filtra los componentes que son barriles 
-- EFICIENCIA: O(n)
-- n # siendo c la longitud de la lista de componentes dada ya que se hace RE sobre la misma 
-- * # por cada c de cs se hace 
-- 1 # isBarril y cons 
-- O(n*1)
-- O(n)   # porque no importa la constante 1.

soloBarriles [] = []
soloBarriles (c:cs) = if isBarril c 
                        then c : soloBarriles cs
                        else soloBarriles cs

-- ==============================================================================================================================================================================
--                  Anexo de interfaces                 Anexo de interfaces                 Anexo de interfaces
-- ==============================================================================================================================================================================

-- Sector, siendo C la cantidad de contenedres y T la cantidad de tripulantes:
-- crearS :: SectorId -> Sector                      O(1)
-- sectorId :: Sector -> SectorId                    O(1)
-- componentesS :: Sector -> [Componente]            O(1)
-- tripulantesS :: Sector -> Set Nombre              O(1)
-- agregarC :: Componente -> Sector -> Sector        O(1)
-- agregarT :: Nombre -> Sector -> Sector            O(log T)


-- Tripulante, siendo S la cantidad de sectores:

-- crearT :: Nombre -> Rango -> Tripulante           O(1)
-- asignarS :: SectorId -> Tripulante -> Tripulante  O(log S)
-- sectoresT :: Tripulante -> Set SectorId           O(1)
-- nombre :: Tripulante -> String                    O(1)
-- rango :: Tripulante -> Rango                      O(1)


-- Set, siendo N la cantidad de elementos del conjunto:

-- emptyS :: Set a                                  O(1)
-- addS :: a -> Set a -> Set a                      O(log N)
-- belongsS :: a -> Set a -> Bool                   O(log N)
-- unionS :: Set a -> Set a -> Set a                O(N log N)
-- setToList :: Set a -> [a]                        O(N)
-- sizeS :: Set a -> Int                            O(1)


-- MaxHeap, siendo M la cantidad de elementos en la heap:

-- emptyH :: MaxHeap a                              O(1)
-- isEmptyH :: MaxHeap a -> Bool                    O(1)
-- insertH :: a -> MaxHeap a -> MaxHeap a           O(log M)
-- maxH :: MaxHeap a -> a                           O(1)
-- deleteMaxH :: MaxHeap a -> MaxHeap a             O(log M)


-- Map, siendo K la cantidad de claves distintas en el map:

-- emptyM :: Map k v                                O(1)
-- assocM :: k -> v -> Map k v -> Map k v           O(log K)
-- lookupM :: k -> Map k v -> Maybe v               O(log K)
-- deleteM :: k -> Map k v -> Map k v               O(log K)
-- domM :: Map k v -> [k]                           O(K)
