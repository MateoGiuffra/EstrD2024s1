-- Ejercicio 4
-- Dado la siguiente representación para el tipo abstrcto Empresa:
-- Donde se observa que:
{-
    * los empleados son un tipo abstracto.

    * el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
    * el segundo map relaciona empleados con su número de CUIL.
    * un empleado puede estar asignado a más de un sector
    
    * tanto Map como Set exponen una interfaz eciente con costos logarítmicos para inserción,
    * búsqueda y borrado, tal cual vimos en clase.
-}


import MapV1 
import SetV1

type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)

{-
        INV.REP: en ConsE (m1 sectorId SetE) (m2 Cuil E)
           
            * Si un empleado existe en SetE del m1 entonces tiene que existir como value en m2, pero no viceversa,
             y ademas tiene que ser exactamente el MISMO empleado. 
            * Cada E de m2 tiene un unico Cuil. -- es INV del Map? 
            * En m1, por cada sectorId que este asociado a un empleado "x" perteneciente de su SetE, tiene que aparecer 
            como sectorId en la lista de sectores de "x". Ademas, tiene que ser el MISMO sectorId.
            
           (pero no viceversa) no todos los empleados que aparecen como value en m2 tienen que tener asignado un sector. ???


            OBSERVACIONES:
            * el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
            * el segundo map relaciona empleados con su número de CUIL. 
            * Un empleado de SetE no tiene porque estar asociado a un unico Sid. 
-}

-- Interfaz de Empleado: 

-- consEmpleado :: CUIL -> Empleado
-- Propósito: construye un empleado con dicho CUIL.
-- Costo: O(1)
-- cuil :: Empleado -> CUIL
-- Propósito: indica el CUIL de un empleado.
-- Costo: O(1)
-- incorporarSector :: SectorId -> Empleado -> Empleado
-- Propósito: incorpora un sector al conjunto de sectores en los que trabaja un empleado.
-- Costo: O(log S), siendo S la cantidad de sectores que el empleado tiene asignados.
-- sectores :: Empleado -> [SectorId]
-- Propósito: indica los sectores en los que el empleado trabaja.
-- Costo: O(S)


consEmpresa :: Empresa
-- Propósito: construye una empresa vacía.
-- Costo: O(1)
consEmpresa = ConsE emptyM emptyM

buscarPorCUIL :: CUIL -> Empresa -> Empleado
-- Propósito: devuelve el empleado con dicho CUIL.
-- Precondición: el CUIL es de un empleado de la empresa.
-- Costo: O(log E)
-- log E # porque se usa lookupM siendo E la cantidad de los elementos del m2.
buscarPorCUIL cuit (ConsE _ m2) = justFrom (lookupM cuit m2) 

-- Map -> addS  - deleteM - lookupM Log M 
-- Set -> addS  - deleteS           Log S

empleadosDelSector :: SectorId -> Empresa -> [Empleado]
-- Propósito: indica los empleados que trabajan en un sector dado.
-- Costo: O(log S + E)
-- log S # por lookupM sobre m1 siendo S la cantidad de elementos de m1.
-- +     # tambien se hace:
-- E     # por setToList sobre set siendo E todos los elementos del set. 
empleadosDelSector sId (ConsE m1 _) = case lookupM sId m1 of
                                        Nothing  -> []
                                        Just set -> setToList set    


todosLosCUIL :: Empresa -> [CUIL]
-- Propósito: indica todos los CUIL de empleados de la empresa.
-- Costo: O(E) # siendo E la cantidad de elementos del m2.
todosLosCUIL (ConsE _ m2) = keys m2  

todosLosSectores :: Empresa -> [SectorId]
-- Propósito: indica todos los sectores de la empresa.
-- Costo: O(S) # siendo S la cantidad de elementos del m1.
todosLosSectores (ConsE m1 _) = keys m1 

agregarSector :: SectorId -> Empresa -> Empresa
-- Propósito: agrega un sector a la empresa, inicialmente sin empleados.
-- Costo: O(log S) # por assocM sobre m1. 
agregarASector sId (ConsE m1 m2) = ConsE (assocM sId emptyS m1) m2

agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un empleado a la empresa, que trabajará en dichos sectores y tendrá el CUIL dado.
-- Costo: 
-- O(n*log S)  # por incorporarSectores, siendo n la lontitud de ss y siendo S la cantidad de SectorId que el empleado tiene asignados. 
-- + 
-- log E       # por lookupM sobre m2 siendo E la cantidad de elementos de m2. 
-- + 
-- log E      # por assocM sobre m2, siendo E la cantidad de elementos de m2.
-- + 
-- O(n * (Log E  + Log V)) # por sectoresA, siendo V la cantidad de empleados del SetEmpleado de m1.


-- O (n*(log S) + log E + log E + (n*(Log E + Log V)))
-- O (n* log S + 2log E + n*(Log E + Log V))

agregarEmpleado ss cuil (ConsE m1 m2) = let empleado = (incorporarSectores ss (consEmpleado cuil)) in    
                                            case lookupM cuil m2 of 
                                            Nothing -> ConsE (sectoresA ss empleado m1) (assocM cuil empleado m2)
                                            Just  x -> error "Ya existe este empleado"


-- ==================================================================================================================================================================
-- INICIO DE             FUNCIONES AUXILIARES                  FUNCIONES AUXILIARES                  FUNCIONES AUXILIARES                  FUNCIONES AUXILIARES
-- ==================================================================================================================================================================


sectoresA :: [SectorId] -> Empleado -> (Map SectorId (Set Empleado)) -> (Map SectorId (Set Empleado))
-- PROPOSITO: Dado una lista de SectorId, un empleado y un Map SectorId (Set Empleado), describe un nuevo map con el empleado agregado a cada SectorId de la lista dada.  
-- COSTO: O(n * (Log M  + Log S))
--O(n # siendo n la longitud de la lista de SectorId ya que se hace RE sobre la misma. 
-- *  # por cada s de ss se hace:
-- (Log M  + Log S) # por sectorA siendo M la cantidad de elemtos del Map y S la cantidad de elementos del (Set Empleado) del Map. 
-- )
-- O(n * (Log M  + Log S))
sectoresA []     e map = map
sectoresA (s:ss) e map = sectorA s e (sectoresA ss e map)

sectorA :: SectorId -> Empleado -> (Map SectorId (Set Empleado)) -> (Map SectorId (Set Empleado))
-- PROPOSITO: Dado un SectorId, un empleado y un Map SectorId (Set Empleado), describe un nuevo map con el empleado agreagado al SectorId dado.  
-- COSTO: O(Log M  + Log S)
-- Log M # siendo M la cantidad de elementos del map. 
-- +     # tambien se hace 
-- Log M # assocM sobre el map
-- + 
-- Log S               # por addS sobre es (SetEmpleado) siendo S la cantidad de elementos del Set.
-- O(Log M + Log M +Log S)
-- O(2Log M + Log S)   # por equivalencia
-- O(Log M  + Log S)   # porque se suprime el 2

sectorA s e map = case lookupM s map of
                    Nothing -> assocM s (addS e emptyS) map 
                    Just es -> assocM s (addS e es    ) map 

incorporarSectores ::  [SectorId] -> Empleado -> Empleado
-- PROPOSITO: Dado una lista de SectorId y un empleado, devuelve al empleado con esos sectores incorporados.
-- COSTO: O(n*log S) 
-- O(n # siendo n la longitud de la lsita de SectorId ya que se hace RE sobre la misma.
-- *   # por cada s de ss se hace: 
-- ((log S)) # por incorporarSector siendo S la cantidad de sectores que el empleado tiene asignados.
-- O(n*log S) 
incorporarSectores [] e = e 
incorporarSectores (s:ss) e = incorporarSector s (incorporarSectores ss e)

-- ==================================================================================================================================================================
-- FIN DE          FUNCIONES AUXILIARES                  FUNCIONES AUXILIARES                  FUNCIONES AUXILIARES                  FUNCIONES AUXILIARES
-- ==================================================================================================================================================================


agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: calcular.
agregarASector sId cuil (ConsE m1 m2) = case lookupM cuil m2 of
                                            Nothing -> "No existe el empleado"
                                            Just  e -> ConsE (sectorA sId (incorporarSector sId e) m1) (assocM cuil (incorporarSector sId e) m2)     

borrarEmpleado :: CUIL -> Empresa -> Empresa
-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: calcular
borrarEmpleado cuil (ConsE m1 m2) = case lookupM cuil m2 of
                                        Nothing -> (ConsE m1 m2)
                                        Just  e -> (ConsE (eliminarEmpleadoDeLosSets (sectores e) e  m1) (deleteM cuil m2) )  

eliminarEmpleadoDeLosSets :: [SectorId] -> Empleado -> (Map SectorId (Set Empleado)) -> (Map SectorId (Set Empleado))
-- PROPOSITO: Dado una lista de SectorId, un empleado y un Map SectorId (Set Empleado), describe un nuevo map con el empleado eliminado de cada SectorId de la lista.
eliminarEmpleadoDeLosSets [] e map     = map 
eliminarEmpleadoDeLosSets (s:ss) e map = case lookupM s map of
                                            Nothing   -> error"Se rompio la invariante"
                                            Just setE -> assocM s (deleteM e setE) (eliminarEmpleadoDeLosSets ss e map)
 

justFrom :: Maybe a -> a 
justFrom (Just a) = a 