-- Nave Espacial
-- En este examen modelaremos una Nave como un tipo abstracto, el cual nos permite construir una nave espacial, dividida en
-- sectores, a los cuales podemos asignar tripulantes y componentes. Para esto, damos por hecho que:

-- Imports necesarios 
-- import Nombre     -- (sinonimo de string, son unicos) 
-- import Sector     -- (contiene componentes y tripulantes asignados)
-- import Tripulante -- (posee nombre, rango y sectores asignados)
-- import SectorId   -- (sinonimo de string, identifica al sector de forma univoca)
-- import Rango      -- (sinonimo de string)
-- import MapV1      -- (SectorId Sector) (Nombre Tripulante)
-- import MaxHeap    -- (MaxHeap) => (Tripulante) (ordenado por rango, el que tiene mas rango es el primero)
-- import SetV1

type Nombre = String
data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
data Barril = Comida | Oxigeno | Torpedo | Combustible

data Nave = N (Map SectorId Sector) (Map Nombre Tripulante) (MaxHeap Tripulante)

{- a)
            INV. REP: Dada una Nave: N (m1 sId s) (m2 nombre tri) (mh t)
            * Los tripulantes de mh tienen que existir y ser los MISMOS en m2 y viceversa. 
            * En m1, por cada sectorId que este asociado a un tripulante "x", tiene que aparecer 
              como sectorId en el set de SectorId de "x".
            * En m2, por cada Tripulante que este asociado a un SectorId "x", tiene que aparecer 
              como Tripulante en el conjunto de Tripulantes de "x".
            * Cada s de m1 tiene que estar asociado a un solo sid, el cual es univoco en la nave.
            * Cada tri de m2 tiene que estar asociado a un solo nombre, el cual es univoco en la nave o en m2? 
            * Los tripulantes asignados de los sectores de m1 tienen que existir en m2 y en mh.

            OBSERVACIONES: 
            Un sector está vacío cuando no tiene tripulantes, y la nave está vacía si no tiene ningún tripulante.
            Puede haber tripulantes sin sectores asignados.         

-}

-- Implementación
-- siendo T la cantidad de tripulantes y S la cantidad de sectores:

-- b) 
construir :: [SectorId] -> Nave
-- Propósito: Construye una nave con sectores vacíos, en base a una lista de identificadores de sectores.
-- Eficiencia: O(S)
-- EFICIENCIA: S*(Log S) # por crearSectores sobre el primer Map.
construir ss = N (crearSectores ss emptyM) (emptyM)(emptyH)

crearSectores :: [SectorId] -> Map SectorId Sector -> Map SectorId Sector 
-- PROPOSITO: Dada una lista de SectorId y un Map, devuelve ese Map con los Sectores agregados a el. 
-- EFICIENCIA: 
-- (s      # siendo S la longitud de la lista de SectorId ya que se hace RE sobre la misma. 
-- *       # por cada s de ss
-- (log s  # por assocM ya que se sobre la RE  
-- ))
-- s*(Log s)
crearSectores []     map = map 
crearSectores (s:ss) map = assocM s (crearS s) (crearSectores ss map)

-- si para agregarlo uso un lookupM para ver si ya estaba en la nave, esta bien o de eso se encarga el map?

-- c) 
ingresarT :: Nombre -> Rango -> Nave -> Nave
-- Propósito: Incorpora un tripulante a la nave, sin asignarle un sector.
-- Eficiencia: O(log T)
-- log T + log T # por assocM sobre m2 e insertH sobre mh siendo T la misma cantidad de tripulantes por invariante.  
-- 2log T        # por agrupacion de terminos semajentes 
-- log T         # porque se suprime 2log T 
ingresarT n r (N m1 m2 mh) = let trip = (crearT n r) in 
                             N m1 (assocM n m2 ) (insertH trip mh)

-- d) 
sectoresAsignados :: Nombre -> Nave -> Set SectorId
-- Propósito: Devuelve los sectores asignados a un tripulante.
-- Precondición: Existe un tripulante con dicho nombre.
-- Eficiencia: O(log M) # siendo M la cantidad de tripulantes del map m2
sectoresAsignados n (N m1 m2 mh) = case lookupM n m2 of 
                                    Nothing -> error"No existe el tripulante"
                                    Just t  -> sectoresT t 

-- e) 
datosDeSector :: SectorId -> Nave -> (Set Nombre, [Componente])
-- Propósito: Dado un sector, devuelve los tripulantes y los componentes asignados a ese sector.
-- Precondición: Existe un sector con dicho id.
-- Eficiencia: O(log S) 
-- # por lookupM sobre el map m1. tripulantesS y componentesS son de costo constante. 
datosDeSector sId (N m1 m2 mh) = case lookupM sId m1 of
                                  Nothing -> error"No existe un sector con dicho id" 
                                  Just s  -> ((tripulantesS s), componentesS s)

-- f) 
tripulantesN :: Nave -> [Tripulante]
-- Propósito: Devuelve la lista de tripulantes ordenada por rango, de mayor a menor.
-- Eficiencia: O(log T)
-- EFICIENCIA: O(T*(log T))  # por tripulantesMH sobre el MaxHeap de la nave.
tripulantesN (N _ _ mh) = tripulantesMH mh 

tripulantesMH :: MaxHeap Tripulante -> [Tripulante]
-- PROPOSITO: Devuelve la lista de tripulantes ordenada por rango, de mayor a menor.
-- EFICIENCIA: O(T*(log T)) 
-- O( T   # ya que se hace RE sobre MaxHeap 
-- *      # por cada tripulante del MaxHeap se hace:
-- (log T # por deleteMaxH sobre el MaxHeap, por eso es el mismo T 
--  + 
--  1))   # por MaxHeap 
-- O(T*(log T + 1))
-- O(T*(log T))     # porque se queda lo mas costoso.
tripulantesMH emptyH =  []
tripulantesMH mh     =  (MaxHeap mh) : (tripulantesMH (deleteMaxH mh))



-- g) 
agregarASector :: [Componente] -> SectorId -> Nave -> Nave
-- Propósito: Asigna una lista de componentes a un sector de la nave.
-- Eficiencia: O(C + log S), siendo C la cantidad de componentes dados.
-- O(S # por lookupM sobre el map de sectores m1  
-- + 
-- C   # por agregarComponentes)
-- O(log S + C)
agregarASector cs sid (N m1 m2 mh) = case lookupM sid m1 of
                                         Nothing -> error"No existe sector con ese id"
                                         Just  s -> N (assocM sid (agregarComponentes cs s)  m1) m2 mh

agregarComponentes :: [Componente]  ->  Sector ->  Sector
-- PROPOSITO: Asigna la lista de componentes dada a el sector dado. 
-- EFICIENCIA: O(C)
-- C # siendo C la longitud de lista de componentes dada, ya que se hace RE sobre la misma
-- * # por cada c de cs se hace: 
-- 1 # por agregarC 
-- O(C*1)
-- O(C)
agregarComponentes []     s = s 
agregarComponentes (c:cs) s = agregarC c (agregarComponentes cs s)

-- h) 
asignarASector :: Nombre -> SectorId -> Nave -> Nave
-- Propósito: Asigna un sector a un tripulante.
-- Nota: No importa si el tripulante ya tiene asignado dicho sector.
-- Precondición: El tripulante y el sector existen.
-- Eficiencia: O(log S + log T + T log T)
-- O(Log T + Log S + T*(Log T + Log S)) 

-- O(Log T + Log S    # por asignarTripulanteA sobre el map m1 
-- + 
-- O(Log T + Log S    # por asignarSectorA a el map m2 
-- + 
-- O(T*(Log T + Log S # por updateTripulante sobre el maxheap mh 
-- ))
-- O(Log T + Log S  +  Log T + Log S + T*(Log T + Log S)) 
-- O(2Log T + 2Log S + T*(Log T + Log S))   # por agrupacion de terminos asemejantes
-- O(Log T + Log S + T*(Log T + Log S))     # porque se suprime 2Log T y 2Log S

asignarASector n sid (N m1 m2 mh) = (N (asignarTripulanteA sid n m1) (asignarSectorA sid n m2) (updateTripulante n mh)) 

updateTripulante :: SectorId -> Nombre -> MaxHeap Tripulante -> MaxHeap Tripulante
-- PROPOSITO: Asigna el sector dado a un tripulante con el nombre dado a el MaxHeap Tripulante dado. 
-- PRECONDICION: El tripulante y el sector existen. 
-- EFICIENCIA:O(T*(Log T + Log S)) 
-- O(T     # siendo T la cantidad de tripulantes del MaxHeap ya que se hace RE sobre el mismo.
-- *       # por cada tripulante del MaxHeap se hace: 
-- (Log T  # por insertH sobre la RE 
-- +    
-- Log T   # por deleteMaxH sobre la RE  
-- + 
-- Log S   # asignarS siendo S la cantidad de Sectores.
-- ))
-- O(T*(Log T+Log T+Log S))
-- O(T*(2Log T + Log S)) # por agrupacion de terminos asemejantes
-- O(T*(Log T + Log S))  # porque se suprime 2Log T

updateTripulante sid n emptyH = emptyH 
updateTripulante sid n mh     = let trip = maxH mh in 
                                if nombre trip  == n 
                                  then insertH (asignarS sid trip) mh 
                                  else insertH trip (updateTripulante(deleteMaxH mh))

asignarTripulanteA :: SectorId -> Nombre -> Map SectorId Sector -> Map SectorId Sector
-- EFICIENCIA:O(Log T + Log S)
-- O Log S # por lookupM sobre el map de Sectores 
-- + 
-- Log S  # por assocM sobre el map
-- + 
-- Log T # por agregarT siendo T la cantidad de tripulantes
-- O(Log S + Log T + Log S)
-- O(Log T + Log S)

asignarTripulanteA sid n m = case lookupM sid m of
                                  Nothing -> error "No existe"
                                  Just  s -> assocM sid (agregarT n s) m 


asignarSectorA :: SectorId -> Nombre -> Map Nombre Tripulante -> Map Nombre Tripulante
-- EFICIENCIA:O(Log T + Log S)
-- O Log T # por lookupM sobre el map de Tripulantes 
-- + 
-- Log T  # por assocM sobre el map
-- + 
-- Log S # por asignarS siendo S la cantidad de sectores
-- O(Log T + Log T + Log S)
-- O(Log T + Log S)

asignarSectorA sid n m = case lookupM n m of
                          Nothing -> error "No existe"
                          Just  t -> assocM n (asignarS sid t) m 

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
