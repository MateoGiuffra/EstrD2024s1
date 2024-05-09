data Color = Rojo | Negro |Azul | Verde 
                deriving Show
data Fila = Final 
            | Celda (Color -> Int) Fila 
            -- deriving Show
 
instance Show Fila where 
    show Final = "Final"
    show (Celda funcion fila) =   "Celda " ++ show Verde ++ " " ++ show (funcion Verde) ++ "" ++  
                                    " (Celda " ++ show Rojo ++ " " ++ show (funcion Rojo) ++ "" ++   
                                    " ((Celda " ++ show Negro ++ " " ++ show (funcion Negro) ++ "" ++  
                                    " (((Celda " ++ show Azul ++ " " ++ show (funcion Azul) ++ " " ++  show fila ++ ")))"

filaEjemplo = Celda (\color -> case color of
                                Rojo -> 2
                                Verde -> 3  
                                _     -> 0 ) Final


nroBolitas :: Color -> Fila -> Int
nroBolitas c Final           = 0
nroBolitas c (Celda funcion f) = funcion c + (nroBolitas c f) 

hayBolitas :: Color -> Fila -> Bool
hayBolitas c Final             = False
hayBolitas c (Celda funcion f) = funcion c > 0  

-- poner :: Color -> Int -> Fila -> Fila
-- poner c 0 fila              = fila
-- poner c n (Celda funcion f) = Celda (\color -> n) (poner c (n-1) (Celda funcion f)) 


sonIguales :: Color -> Color -> Bool
sonIguales Rojo Rojo    = True
sonIguales Azul Azul    = True
sonIguales Negro Negro  = True
sonIguales Verde Verde  = True
sonIguales _ _          = False