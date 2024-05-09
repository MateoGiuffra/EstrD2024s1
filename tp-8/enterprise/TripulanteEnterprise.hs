module TripulanteEnterprise (
                            Tripulante,
                            Rango,
                            crearT,
                            rango)
                            where

data Tripulante = T String Rango     
               deriving Show
instance Ord Tripulante where
     t <= t2 = rango t <= rango t2

instance Eq Tripulante where
     t == t2 = rango t == rango t2


type Rango = Int
rango :: Tripulante -> Rango 
rango (T _ n) = n  

crearT :: String -> Rango -> Tripulante
crearT s r = (T s r)