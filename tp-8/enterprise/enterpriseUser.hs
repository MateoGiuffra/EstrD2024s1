import Enterprise 

-- a) Implementar las siguientes funciones como usuario del TAD N ave, establecer su eficiencia y justificarla:
-- a) 
tripulantes :: Nave -> Set Tripulante
tripulantes nave = tripulantesDe (sectores nave) nave

tripulantesDeLos :: [Sector] -> Nave -> Set Tripulante
tripulantesDeLos []     nave = emptyM  
tripulantesDeLos (s:ss) nave = unionS (tripulantesDe s nave) (tripulantesDeLos ss nave) 

