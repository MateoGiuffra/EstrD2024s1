{-
 GrafoEtiquetadoDinamico

 El TAD (Tipo Abstracto de Datos) GrafoEtiquetadoDinamico es una estructura diseñada para gestionar grafos dirigidos y etiquetados
 con capacidad de actualización dinámica de etiquetas. En este grafo, cada arista tiene una etiqueta y los nodos pueden cambiar de etiqueta
 de manera dinámica sin perder sus conexiones.

 Características Principales:

 - Almacenamiento de Nodos: Utiliza un conjunto para almacenar los nodos del grafo.
 - Gestión de Aristas y Etiquetas: Utiliza un mapa para mantener las aristas etiquetadas de los nodos y otro mapa para rastrear las etiquetas de los nodos.
 - Conectividad Dinámica: Permite agregar, eliminar y actualizar etiquetas de nodos y aristas de manera dinámica.

 Propósito:

 El propósito principal de GrafoEtiquetadoDinamico es facilitar la gestión y el análisis de grafos dirigidos donde las etiquetas de nodos y aristas son dinámicas.
 Permite agregar nuevos nodos y aristas, actualizar etiquetas de nodos y aristas, y verificar la conectividad y las etiquetas de manera eficiente.

 Este TAD es útil en contextos como la planificación de rutas, análisis de redes de comunicación, y cualquier otro dominio donde las relaciones etiquetadas y dinámicas
 entre elementos sean relevantes. Ofrece una interfaz robusta y flexible para administrar y analizar grafos dirigidos y etiquetados.
-}

module GrafoEtiquetadoDinamico (
    GrafoEtiquetadoDinamico,
    Nodo,
    Etiqueta,
    agregarNodo,
    eliminarNodo,
    agregarArista,
    eliminarArista,
    actualizarEtiquetaNodo,
    actualizarEtiquetaArista,
    obtenerEtiquetaNodo,
    obtenerEtiquetaArista
) where

import qualified Data.Set as Set
import qualified Data.Map as Map

type Nodo = Int
type Etiqueta = String

data GrafoEtiquetadoDinamico = GED (Set.Set Nodo) (Map.Map Nodo (Map.Map Nodo Etiqueta)) (Map.Map Nodo Etiqueta)
    deriving (Show, Eq)

-- Construcción del TAD con invariantes:
-- INV.REP:
-- * Los nodos en el mapa de etiquetas deben estar en el conjunto de nodos.
-- * Los nodos en el mapa de aristas deben estar en el conjunto de nodos.
-- * Las aristas solo deben existir entre nodos presentes en el conjunto de nodos.

agregarNodo :: Nodo -> Etiqueta -> GrafoEtiquetadoDinamico -> GrafoEtiquetadoDinamico
-- Descripción: Agrega un nuevo nodo con una etiqueta al grafo.
-- Precondición: El nodo no debe estar ya presente en el grafo.
-- Costo: O(log N), donde N es la cantidad de nodos en el grafo.
agregarNodo = undefined

eliminarNodo :: Nodo -> GrafoEtiquetadoDinamico -> GrafoEtiquetadoDinamico
-- Descripción: Elimina un nodo y todas sus aristas del grafo.
-- Precondición: El nodo debe estar presente en el grafo.
-- Costo: O(N log N), donde N es la cantidad de nodos en el grafo.
eliminarNodo = undefined

agregarArista :: Nodo -> Nodo -> Etiqueta -> GrafoEtiquetadoDinamico -> GrafoEtiquetadoDinamico
-- Descripción: Agrega una arista dirigida entre dos nodos con una etiqueta.
-- Precondición: Ambos nodos deben estar presentes en el grafo.
-- Costo: O(log N + log K), donde N es la cantidad de nodos y K es la cantidad de aristas del nodo de origen.
agregarArista = undefined

eliminarArista :: Nodo -> Nodo -> GrafoEtiquetadoDinamico -> GrafoEtiquetadoDinamico
-- Descripción: Elimina una arista dirigida entre dos nodos.
-- Precondición: Ambos nodos deben estar presentes en el grafo y debe existir una arista entre ellos.
-- Costo: O(log N + log K), donde N es la cantidad de nodos y K es la cantidad de aristas del nodo de origen.
eliminarArista = undefined

actualizarEtiquetaNodo :: Nodo -> Etiqueta -> GrafoEtiquetadoDinamico -> GrafoEtiquetadoDinamico
-- Descripción: Actualiza la etiqueta de un nodo en el grafo.
-- Precondición: El nodo debe estar presente en el grafo.
-- Costo: O(log N), donde N es la cantidad de nodos en el grafo.
actualizarEtiquetaNodo = undefined

actualizarEtiquetaArista :: Nodo -> Nodo -> Etiqueta -> GrafoEtiquetadoDinamico -> GrafoEtiquetadoDinamico
-- Descripción: Actualiza la etiqueta de una arista dirigida entre dos nodos.
-- Precondición: Ambos nodos deben estar presentes en el grafo y debe existir una arista entre ellos.
-- Costo: O(log N + log K), donde N es la cantidad de nodos y K es la cantidad de aristas del nodo de origen.
actualizarEtiquetaArista = undefined

obtenerEtiquetaNodo :: Nodo -> GrafoEtiquetadoDinamico -> Maybe Etiqueta
-- Descripción: Obtiene la etiqueta de un nodo en el grafo.
-- Precondición: El nodo debe estar presente en el grafo.
-- Costo: O(log N), donde N es la cantidad de nodos en el grafo.
obtenerEtiquetaNodo = undefined

obtenerEtiquetaArista :: Nodo -> Nodo -> GrafoEtiquetadoDinamico -> Maybe Etiqueta
-- Descripción: Obtiene la etiqueta de una arista dirigida entre dos nodos en el grafo.
-- Precondición: Ambos nodos deben estar presentes en el grafo y debe existir una arista entre ellos.
-- Costo: O(log N + log K), donde N es la cantidad de nodos y K es la cantidad de aristas del nodo de origen.
obtenerEtiquetaArista = undefined

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