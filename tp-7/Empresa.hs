-- Ejercicio 4
-- Dado la siguiente representación para el tipo abstrcto Empresa:
import MapV1 
import SetV1

type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)
-- Donde se observa que:
{-
    * los empleados son un tipo abstracto.

    * el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
    * el segundo map relaciona empleados con su número de CUIL.
    * un empleado puede estar asignado a más de un sector
    
    * tanto Map como Set exponen una interfaz eciente con costos logarítmicos para inserción,
    * búsqueda y borrado, tal cual vimos en clase.
-}

{-
        INV.REP: en ConsE (m1 Sid SetE) (m2 C E)
           
            * Si un empleado existe en SetE del m1 entonces tiene que existir como value en m2, pero no viceversa,
             y ademas tiene que ser exactamente el mismo empleado. 
            * Cada E de m2 tiene un unico C. -- es INV del Map? 

            no todos los empleados que aparecen como value en m2 tienen que tener asignado un sector. ???

            OBSERVACIONES:
            * el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
            * el segundo map relaciona empleados con su número de CUIL. 
            * Un empleado de SetE no tiene porque estar asociado a un unico Sid. 
-}

-- Y sabemos que la interfaz de Empleado es:

{-
consEmpleado :: CUIL -> Empleado
-- Propósito: construye un empleado con dicho CUIL.
-- Costo: O(1)
cuil :: Empleado -> CUIL
-- Propósito: indica el CUIL de un empleado.
-- Costo: O(1)
incorporarSector :: SectorId -> Empleado -> Empleado
-- Propósito: incorpora un sector al conjunto de sectores en los que trabaja un empleado.
-- Costo: O(log S), siendo S la cantidad de sectores que el empleado tiene asignados.
sectores :: Empleado -> [SectorId]
-- Propósito: indica los sectores en los que el empleado trabaja.
-- Costo: O(S)
-}



-- Dicho esto, indicar invariantes de representación adecuados para la estructura y definir la
-- siguiente interfaz de Empresa, respetando los costos dados y calculando los faltantes. Justificar
-- todos los costos dados. En los costos, S es la cantidad de sectores de la empresa, y E es la
-- cantidad de empleados.


consEmpresa :: Empresa
-- Propósito: construye una empresa vacía.
-- Costo: O(1)
consEmpresa = ConsE emptyM emptyM

buscarPorCUIL :: CUIL -> Empresa -> Empleado
-- Propósito: devuelve el empleado con dicho CUIL.
-- Precondición: el CUIL es de un empleado de la empresa.
-- Costo: O(log E)
buscarPorCUIL cuit (ConsE _ m2) = justFrom (lookupM cuit m2) 

empleadosDelSector :: SectorId -> Empresa -> [Empleado]
-- Propósito: indica los empleados que trabajan en un sector dado.
-- Costo: O(log S + E)
todosLosCUIL :: Empresa -> [CUIL]
-- Propósito: indica todos los CUIL de empleados de la empresa.
-- Costo: O(E)
todosLosSectores :: Empresa -> [SectorId]
-- Propósito: indica todos los sectores de la empresa.
-- Costo: O(S)
agregarSector :: SectorId -> Empresa -> Empresa
-- Propósito: agrega un sector a la empresa, inicialmente sin empleados.
-- Costo: O(log S)
agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un empleado a la empresa, que trabajará en dichos sectores y tendrá el CUIL dado.
-- Costo: calcular.
agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: calcular.
borrarEmpleado :: CUIL -> Empresa -> Empresa
-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: calcular


justFrom :: Maybe a -> a 
justFrom (Just a) = a 