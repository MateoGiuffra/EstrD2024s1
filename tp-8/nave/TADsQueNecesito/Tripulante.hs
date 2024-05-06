module Tripulante (
    Tripulante,
    Rango,
    SectorId,
    crearT,
    asignarS,
    sectoresT,
    nombre,
    rango
) where

import Data.Set (Set)
import qualified Data.Set as Set
import Nombre (Nombre)

type Nombre = String

type Rango = String

type SectorId = String

data Tripulante = Tripulante Nombre Rango (Set SectorId)

instance Eq Tripulante where
    (Tripulante n1 r1 s1) == (Tripulante n2 r2 s2) = n1 == n2 && r1 == r2 && s1 == s2

instance Show Tripulante where
    show (Tripulante n r s) = "Tripulante " ++ n ++ " (" ++ r ++ ") - Sectores asignados: " ++ show (Set.toList s)

-- crearT :: Nombre -> Rango -> Tripulante
crearT :: Nombre -> Rango -> Tripulante
crearT n r = Tripulante n r Set.empty

-- asignarS :: SectorId -> Tripulante -> Tripulante
asignarS :: SectorId -> Tripulante -> Tripulante
asignarS sid (Tripulante n r sectores) = Tripulante n r (Set.insert sid sectores)

-- sectoresT :: Tripulante -> Set SectorId
sectoresT :: Tripulante -> Set SectorId
sectoresT (Tripulante _ _ sectores) = sectores

-- nombre :: Tripulante -> String
nombre :: Tripulante -> String
nombre (Tripulante n _ _) = n

-- rango :: Tripulante -> Rango
rango :: Tripulante -> Rango
rango (Tripulante _ r _) = r
