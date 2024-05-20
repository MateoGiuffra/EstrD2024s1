module Sector (
    Sector,
    SectorId,
    Componente (..),
    Rango,
    crearS,
    sectorId,
    componentesS,
    tripulantesS,
    agregarC,
    agregarT
) where

import Data.Set (Set)
import qualified Data.Set as Set
import Nombre (Nombre)  -- Importa Nombre aquí

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril] deriving (Show, Eq)

data Barril = Comida | Oxigeno | Torpedo | Combustible deriving (Show, Eq)

type SectorId = String

type Rango = String

data Sector = Sector SectorId [Componente] (Set Nombre) deriving (Show, Eq)

-- crearS :: SectorId -> Sector
crearS :: SectorId -> Sector
crearS sid = Sector sid [] Set.empty

-- sectorId :: Sector -> SectorId
sectorId :: Sector -> SectorId
sectorId (Sector sid _ _) = sid

-- componentesS :: Sector -> [Componente]
componentesS :: Sector -> [Componente]
componentesS (Sector _ comps _) = comps

-- tripulantesS :: Sector -> Set Nombre
tripulantesS :: Sector -> Set Nombre
tripulantesS (Sector _ _ tripu) = tripu

-- agregarC :: Componente -> Sector -> Sector
agregarC :: Componente -> Sector -> Sector
agregarC c (Sector sid comps tripu) = Sector sid (c:comps) tripu

-- agregarT :: Nombre -> Sector -> Sector
agregarT :: Nombre -> Sector -> Sector
agregarT n (Sector sid comps tripu) = Sector sid comps (Set.insert n tripu)
