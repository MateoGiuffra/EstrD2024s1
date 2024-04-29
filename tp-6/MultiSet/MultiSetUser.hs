import MultiSet 

ocurrencesMSUser :: [Char] -> MultiSet Char 
-- PROPOSITO: Dada una lista de char o una string, devuelve un Multiset con las chars incluidas.
-- EFICIENCIA: O(n^2) 
-- O(n # siendo n la longitud de la lista de Char ya que se hace RE sobre la misma. 
-- *   # por cada s de ss 
-- n)   # por addS sobre la RE
-- O(n^2)
ocurrencesMSUser []     = emptyMS 
ocurrencesMSUser (s:ss) = addMS s (ocurrencesMSUser ss)