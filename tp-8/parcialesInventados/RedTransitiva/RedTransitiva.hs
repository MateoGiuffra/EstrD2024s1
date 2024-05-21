{-
 RedTransitiva

 El TAD (Tipo Abstracto de Datos) RedTransitiva es una estructura diseñada para gestionar redes transitivas de elementos.
 Una red transitiva es un conjunto de elementos donde cada par de elementos está relacionado de manera transitiva a través
 de una secuencia de conexiones directas o indirectas.

 Características Principales:

 - Almacenamiento de Elementos: Utiliza un conjunto para almacenar los elementos de la red.
 - Gestión de Conexiones: Utiliza un mapa para mantener las conexiones directas entre los elementos.
 - Gestión de Componentes: Utiliza un mapa para rastrear los componentes conexos dentro de la red.

 Propósito:

 El propósito principal de RedTransitiva es facilitar la gestión y el análisis de relaciones transitivas entre elementos.
 Permite agregar nuevos elementos y conexiones, verificar si dos elementos están conectados transitivamente, y obtener
 todos los elementos conectados a un elemento específico.

 Este TAD es útil en contextos como el análisis de redes sociales, sistemas de recomendación, y cualquier otro dominio donde
 las relaciones transitivas entre elementos sean relevantes. Ofrece una interfaz robusta y eficiente para administrar y analizar
 las conexiones dentro de una red transitiva.
-}

module RedTransitiva (
    RedTransitiva,
    Elemento,
    nuevaRed,
    agregarElemento,
    conectarElementos,
    estanConectados,
    obtenerConexiones
) where

import SetV1
import MapV1

type Elemento = Int
type Conexiones = Set Elemento
type Componentes = Map Elemento Conexiones

data RedTransitiva = RT (Set Elemento) (Map Elemento Conexiones) (Map Elemento Conexiones)
    deriving (Show, Eq)

nuevaRed :: RedTransitiva
-- Descripción: Crea una nueva red transitiva vacía.
-- Costo: O(1)
nuevaRed = RT Set.empty Map.empty Map.empty

agregarElemento :: Elemento -> RedTransitiva -> RedTransitiva
-- Descripción: Agrega un nuevo elemento a la red transitiva.
-- Precondición: El elemento no debe estar ya presente en la red.
-- Costo: O(log N), donde N es la cantidad de elementos en la red.
agregarElemento = undefined

conectarElementos :: Elemento -> Elemento -> RedTransitiva -> RedTransitiva
-- Descripción: Conecta dos elementos de la red transitiva, estableciendo una conexión directa.
-- Precondición: Ambos elementos deben estar presentes en la red.
-- Costo: O(log N + log K), donde N es la cantidad de elementos en la red y K es la cantidad de conexiones del primer elemento.
conectarElementos = undefined

estanConectados :: Elemento -> Elemento -> RedTransitiva -> Bool
-- Descripción: Verifica si dos elementos están conectados transitivamente en la red.
-- Precondición: Ambos elementos deben estar presentes en la red.
-- Costo: O(log N), donde N es la cantidad de elementos en la red.
estanConectados = undefined

obtenerConexiones :: Elemento -> RedTransitiva -> [Elemento]
-- Descripción: Obtiene todos los elementos conectados transitivamente a un elemento específico.
-- Precondición: El elemento debe estar presente en la red.
-- Costo: O(K log K), donde K es la cantidad de conexiones directas e indirectas del elemento.
obtenerConexiones = undefined

-- ==============================================================================================================================================================================
--                  Anexo de interfaces                 Anexo de interfaces                 Anexo de interfaces
-- ==============================================================================================================================================================================

-- Set, siendo N la cantidad de elementos del conjunto:

-- emptyS :: Set a                                  O(1)
-- addS :: a -> Set a -> Set a                      O(log N)
-- belongsS :: a -> Set a -> Bool                   O(log N)
-- unionS :: Set a -> Set a -> Set a                O(N log N)
-- setToList :: Set a -> [a]                        O(N)
-- sizeS :: Set a -> Int                            O(1)

-- Map, siendo K la cantidad de claves distintas en el map:

-- emptyM :: Map k v                                O(1)
-- assocM :: k -> v -> Map k v -> Map k v           O(log K)
-- lookupM :: k -> Map k v -> Maybe v               O(log K)
-- deleteM :: k -> Map k v -> Map k v               O(log K)
-- domM :: Map k v -> [k]                           O(K)
