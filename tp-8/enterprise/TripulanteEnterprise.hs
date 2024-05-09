module TripulanteEnterprise (
                            Tripulante,
                            Rango,
                            rango)
                            where

data Tripulante = T Rango     

instance Ord Tripulante where
     t <= t2 = rango t <= rango t2

instance Eq Tripulante where
     t == t2 = rango t == rango t2


type Rango = Int
rango :: Tripulante -> Rango 
rango (T n) = n  