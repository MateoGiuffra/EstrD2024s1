import Empresa 
-- Ejercicio 5
-- Como usuario del tipo Empresa implementar las siguientes operaciones, calculando el Costo obtenido al implementarlas, y justicando cada uno adecuadamente.

comenzarCon :: [SectorId] -> [CUIL] -> Empresa
-- Propósito: construye una empresa con la información de empleados dada. Los sectores no tienen empleados.
-- Costo: calcular.
comenzarCon ss []         = consEmpresa  
comenzarCon [] cc         = consEmpresa  
comenzarCon (s:ss) (c:cc) = (agregarSector s (comenzarCon ss cc))

recorteDePersonal :: Empresa -> Empresa
-- Propósito: dada una empresa elimina a la mitad de sus empleados (sin importar a quiénes).
-- Costo: calcular.
convertirEnComodin :: CUIL -> Empresa -> Empresa
-- Propósito: dado un CUIL de empleado le asigna todos los sectores de la empresa.
-- Costo: calcular.
esComodin :: CUIL -> Empresa -> Bool
-- Propósito: dado un CUIL de empleado indica si el empleado está en todos los sectores.
-- Costo: calcular.

