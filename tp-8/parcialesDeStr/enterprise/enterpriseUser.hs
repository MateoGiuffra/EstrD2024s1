import Enterprise 

-- a) Implementar las siguientes funciones como usuario del TAD N ave, establecer su eficiencia y justificarla:
-- a) 
tripulantes :: Nave -> Set Tripulante
-- Eficiencia: O(S * (T log T) + (log S)) + S
-- O(S * (T log T) + (log S) # por tripulantesDeLos siendo S la cantidad de sectores de la nave.
-- + 
-- (S))                      # por sectores sobre la nave. 
-- O(S * (T log T) + (log S)) + S
tripulantes nave = tripulantesDeLos (sectores nave) nave

tripulantesDeLos :: [Sector] -> Nave -> Set Tripulante
-- Eficiencia:  (s * (T log T) + (log S))
-- O(s       # por RE sobre la lista de sectores, siendo s la longitud de dicha lista.
-- *         # por cada s de ss se hace:
-- (T log T) # por unionS sobre los sets de los tripulantes. 
-- +         # porque tambien se hace 
-- (log S))  # por tripulantesDe siendo S la cantidad de sectores de la nave.
tripulantesDeLos []     nave = emptyM  
tripulantesDeLos (s:ss) nave = unionS (tripulantesDe s nave) (tripulantesDeLos ss nave) 

