-- Ejercicio 3
-- La interfaz del tip o abstracto Map es la siguiente:
--  Como una lista de pares-clave valor sin claves rep etidas


emptyM :: Map k v
-- Propósito: devuelve un map vacío
assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una aso ciación clave-valor al map.
lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: b orra una aso ciación dada una clave.
keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.