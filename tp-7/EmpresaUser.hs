import Empresa 
-- Ejercicio 5
-- Como usuario del tipo Empresa implementar las siguientes operaciones, 
-- calculando el Costo obtenido al implementarlas, y justificando cada uno adecuadamente.

--5.a)
comenzarCon :: [SectorId] -> [CUIL] -> Empresa
-- Propósito: construye una empresa con la información de empleados dada. Los sectores no tienen empleados.
-- Costo: calcular.
-- Los sectores tienen que estar vacios??
comenzarCon = undefined 

--5.b)
recorteDePersonal :: Empresa -> Empresa
-- Propósito: dada una empresa elimina a la mitad de sus empleados (sin importar a quiénes).
-- Costo: calcular.
recorteDePersonal emp = let listaDeCuil = todosLosCUIL emp in 
                        despedirALaMitad listaDeCuil (div (length listaDeCuil) 2) emp 


despedirALaMitad :: [CUIL] -> Int -> Empresa -> Empresa
despedirALaMitad  _     0 emp = emp 
despedirALaMitad (c:cc) n emp = borrarEmpleado c (despedirALaMitad cc (n-1) emp) 

--5.c)
convertirEnComodin :: CUIL -> Empresa -> Empresa
-- Propósito: dado un CUIL de empleado le asigna todos los sectores de la empresa.
-- Costo: calcular.
convertirEnComodin cuil emp = agregarASectores (todosLosSectores emp) cuil emp

agregarASectores :: [SectorId] -> CUIL -> Empresa -> Empresa
agregarASectores []     emp = emp 
agregarASectores (s:ss) emp = agregarASector s cuil (agregarASectores ss cuil emp )

--5.d)
esComodin :: CUIL -> Empresa -> Bool
-- Propósito: dado un CUIL de empleado indica si el empleado está en todos los sectores.
-- Costo: calcular.
-- (S    # por todosLosSectores siendo la cantidad de sectores de la empresa
-- + 
-- log E # por buscarPorCUIL siendo E la cantidad de empleados de la empresa. 
-- + 
-- (S* (log S + E + E)) # por esComodinEn sobre todosLosSectores, buscarPorCUIL, siendo j la cantidad de empleados asignados a un sector.

-- S + Log E + (S*Log S + E + j)
-- S + (S*Log S + E + E)  + Log E   # por propiedad conmutativa  
-- (S*(1 + Log S + E + E) + Log E)  # porque meto el S de afuera sumando a multiplicarse por uno dentro del paretensis.
-- (S*(1 + Log S + 2E) + Log E)     # porque se juntan las E con 2

-- (S*(Log S + 2E) + Log E)         # porque 1 es de costo constante y queda lo de mas costo 
-- (S*(Log S + E) + Log E)          # porque se suprime 2E
esComodin cuil emp = esComodinEn (todosLosSectores emp) (buscarPorCUIL cuil emp) emp 


-- PROPOSITO: Dada una lista de SectorId, un Empleado y una Empresa, describe si el empleado trabaja en todos los SectorId.
-- EFICIENCIA: O(n * (log S + E + j))
-- (n           # siendo n la longitud de la lista de SectorId ya que se hace RE sobre la misma.
-- *            # por cada s de ss se hace:             
-- (log S + E   # por empleadosDelSector siendo S la cantidad de SectorIds de la empresa y E 
--              # la cantidad de empleados asignados a un SectorId 
-- + 
-- j))          # por elem siendo E la longitud de la lista de empleados que devuelve empleadosDelSector.
-- (n * (log S + E + E))
esComodinEn :: [SectorId] -> Empleado -> Empresa -> Bool 
esComodinEn [] _  _      = True 
esComodinEn (s:ss) e emp = elem e (empleadosDelSector s emp) && (esComodinEn ss emp)


-- ALTERNATIVO: (si es que tengo acceso a la Interfaz de Empleado)
esComodin :: CUIL -> Empresa -> Bool
-- Propósito: dado un CUIL de empleado indica si el empleado está en todos los sectores.
-- Costo: calcular.
-- (S    # por todosLosSectores siendo la cantidad de sectores de la empresa
-- + 
-- log E # por buscarPorCUIL siendo E la cantidad de empleados de la empresa. 
-- + 
-- A mal  # por sectores, siendo A la cantidad de sectores que el empleado tiene asignados, 
-- S bien # que en el peor caso serian TODOS los sectores de la empresa, por ende es S
-- +
-- S*S   # por sonMismosSectores sobre todosLosSectores y sectores  
-- (S + Log E + S + S*S)
--  2S + Log E + S^2     # por agrupación de términos semejantes 

--  S + Log E + S^2      # porque se suprime 2S
-- (Log E + S^2)         # porque S^2 es mas grande que S
esComodin cuil emp = sonMismosSectores (todosLosSectores emp) sectores (buscarPorCUIL cuil emp)

sonMismosSectores :: [SectorId] -> [SectorId] -> [SectorId]
-- EFICIENCIA:
-- O(n # siendo n la longitud de la segunda lista de SectorId ya que se hace RE sobre la misma. 
-- *   # por cada s de ss se hace: 
-- m)) # por elem  siendo m la longitud de la primer lista de SectorId
sonMismosSectores ss []      = True  
sonMismosSectores [] ss      = False 
sonMismosSectores ss1 (s:ss) = elem s ss1 && sonMismosSectores ss1 ss