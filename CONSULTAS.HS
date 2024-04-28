{-
 MapV3
LINEA: 17 {-
INV. REP: 
        Dado un map del estilo M ks vs
         * La longitud de las listas ks y vs deben de ser iguales. 
         * El valor de una clave tiene que estar en la misma posicion en vs que la de su clave en ksw. 
-}

LINEA 30: -- EFICIENCIA: O(n) # porque se usa lookupKsVs siendo n longitud de la lista claves o de valores (tienen la misma longitud por invariante) 
                                                        -- CONSULTAR: ...

BORRARASOCIACION O LOOKUPSKSVS tienen la misma justificacion, estan bien? 
-- O(n # siendo n la longitud de la lista claves o de valores (tienen la misma longitud por invariante)
-- ya que se hace RE sobre las mismas.

LINEA 90:
-- EFICIENCIA: O(1) # ya que se hace patter matching sobre Map.
Esta bien la justificacion?
-}

{- MapV2.hs

LINEA 63: 
keys - un Map puede tener claves repetidas?


-}

{- MapV2.hs
estan bien las invariantes? 
{-
INV.REP:
        Dado un map: M [(k,v)]
         * v debe ser un valor asociado a k.
         * No puede existir el mismo k en otros pares. 
-}

-}

{- MapUSER.hs

-- LINEA 8: Consultar eficiencia de lookupsM
-- Si son el mismo numero, cambiar eficiencia de lookupsM y mergeMaps por cuadraticas. 


-- Cuando hablo de la cantidad de elementos de un TAD, tengo que usar letras mayusculas como N?

-- LINEA 177: DUDA CON EFICIENCIA
-- Si son el mismo n cambiar a cuadratica. 
-}

