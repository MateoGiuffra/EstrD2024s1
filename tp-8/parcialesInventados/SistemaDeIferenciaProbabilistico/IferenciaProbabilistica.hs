{-
  Sistema de Inferencia Probabilístico

  El TAD (Tipo Abstracto de Datos) Sistema de Inferencia Probabilístico es una estructura compleja diseñada para modelar
  y resolver problemas de inferencia estadística donde se deben considerar múltiples variables con incertidumbre y dependencia
  entre ellas. Este sistema utiliza técnicas de razonamiento probabilístico para calcular la probabilidad de ocurrencia de
  eventos dados ciertos estados observados de otras variables.

  Características Principales:

  - Representación de Variables: Utiliza un conjunto para almacenar las variables del sistema, donde cada variable puede tomar
    uno o más valores discretos.
  - Modelado de Dependencias: Utiliza un grafo dirigido acíclico (DAG) para representar las dependencias entre las variables.
    Las aristas del grafo indican la influencia directa de una variable sobre otra.
  - Inferencia Probabilística: Utiliza algoritmos de propagación de creencias y técnicas de muestreo Monte Carlo para calcular
    las probabilidades marginales y condicionales de las variables dadas ciertas evidencias observadas.
  - Actualización Dinámica: Permite la actualización dinámica de las creencias sobre las variables en función de nuevas evidencias
    y datos observados.

  Propósito:

  El propósito principal del Sistema de Inferencia Probabilístico es proporcionar una herramienta avanzada para modelar,
  analizar y resolver problemas de inferencia estadística en entornos con incertidumbre y dependencia entre variables. Este
  TAD es útil en una amplia gama de aplicaciones, incluyendo la inteligencia artificial, el análisis de riesgos, la toma de
  decisiones y la investigación científica, donde se requiere una comprensión profunda de la probabilidad y la incertidumbre
  en los datos y los modelos.

  Este TAD ofrece una interfaz compleja pero poderosa para representar y resolver problemas de inferencia probabilística,
  permitiendo a los usuarios modelar y analizar relaciones complejas entre variables y tomar decisiones informadas en
  situaciones de incertidumbre.

-}

module SistemaInferenciaProbabilistico (
    SistemaInferenciaProbabilistico,
    Variable,
    Valor,
    Evidencia,
    agregarVariable,
    eliminarVariable,
    agregarDependencia,
    eliminarDependencia,
    calcularProbabilidadMarginal,
    calcularProbabilidadCondicional,
    actualizarEvidencia
) where

import qualified Data.Set as Set
import qualified Data.Map as Map

type Variable = String
type Valor = String
type Evidencia = Map.Map Variable Valor

data SistemaInferenciaProbabilistico = SIP (Set Variable) (Map Variable (Set Variable)) (Map Variable (Map Valor Double))
    deriving (Show, Eq)

-- Construcción del TAD con invariantes:
-- INV.REP:
-- * Todas las variables de las dependencias deben estar presentes en el conjunto de variables.
-- * Todas las variables en el mapa de probabilidades deben estar presentes en el conjunto de variables.
-- * Todos los valores en los mapas de probabilidades deben sumar 1.

agregarVariable :: Variable -> SistemaInferenciaProbabilistico -> SistemaInferenciaProbabilistico
-- Descripción: Agrega una nueva variable al sistema con un conjunto vacío de dependencias y un conjunto de probabilidades vacío.
-- Precondición: La variable no debe estar ya presente en el sistema.
-- Costo: O(1), operaciones de conjunto y mapa.
agregarVariable = undefined

eliminarVariable :: Variable -> SistemaInferenciaProbabilistico -> SistemaInferenciaProbabilistico
-- Descripción: Elimina una variable y todas sus dependencias y probabilidades asociadas del sistema.
-- Precondición: La variable debe estar presente en el sistema.
-- Costo: O(N), donde N es la cantidad de variables en el sistema.
eliminarVariable = undefined

agregarDependencia :: Variable -> Variable -> SistemaInferenciaProbabilistico -> SistemaInferenciaProbabilistico
-- Descripción: Agrega una dependencia entre dos variables en el sistema.
-- Precondición: Ambas variables deben estar presentes en el sistema y no debe haber un ciclo de dependencia entre ellas.
-- Costo: O(1), operaciones de conjunto y mapa.
agregarDependencia = undefined

eliminarDependencia :: Variable -> Variable -> SistemaInferenciaProbabilistico -> SistemaInferenciaProbabilistico
-- Descripción: Elimina una dependencia entre dos variables en el
