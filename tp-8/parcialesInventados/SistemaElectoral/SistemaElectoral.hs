{-
 Sistema de Elecciones
 
 El TAD (Tipo Abstracto de Datos) de Sistema de Elecciones es una estructura diseñada para gestionar elecciones,
 donde se registran candidatos y votantes, y se emiten y contabilizan votos. Su objetivo principal es proporcionar
 una forma eficiente de manejar el proceso de votación, asegurando que los votos sean emitidos por votantes registrados
 y que cada votante pueda votar una sola vez.

 Características Principales:

 - Registro de Candidatos: Utiliza un conjunto para almacenar los candidatos registrados, asegurando que no haya duplicados.
 - Registro de Votantes: Utiliza otro conjunto para almacenar los votantes registrados, asegurando la unicidad de los votantes.
 - Emisión de Votos: Utiliza un mapa para almacenar los votos emitidos, donde la clave es el ID del votante y el valor es el nombre del candidato.
 - Rastreo de Preferencias: Utiliza un mapa adicional para almacenar las preferencias de los votantes por candidatos.

 Propósito:

 El propósito principal del Sistema de Elecciones es facilitar la organización y gestión de elecciones. Permite a los usuarios
 registrar candidatos y votantes, emitir votos de manera segura y contabilizar los votos de forma eficiente. Además, proporciona
 mecanismos para rastrear las preferencias de los votantes, lo que puede ser útil para análisis posteriores.

 Este sistema es útil en una variedad de contextos, como elecciones estudiantiles, elecciones en organizaciones comunitarias,
 y encuestas de opinión. Ofrece una interfaz simple y eficiente para administrar y hacer un seguimiento de los votos y las preferencias
 de los votantes.
-}

module ElectionSystem (
    ElectionSystem,
    Candidate(..),
    Voter(..),
    addCandidate,
    registerVoter,
    castVote,
    countVotes,
    getWinner
) where

import MapV1
import SetV1

type CandidateName = String
type VoterID = Int
type Vote = CandidateName

data Candidate = Candidate CandidateName deriving (Show, Eq, Ord)
data Voter = Voter VoterID deriving (Show, Eq, Ord)

data ElectionSystem = ES (Set Candidate) (Set Voter) (Map VoterID Vote) (Map Voter (Set Candidate))
    deriving (Show, Eq)

addCandidate :: Candidate -> ElectionSystem -> ElectionSystem
-- Descripción: Agrega un nuevo candidato al sistema de elecciones.
-- Precondición: El candidato no debe estar ya presente en el sistema.
-- Costo: O(log N), donde N es la cantidad de candidatos en el sistema.
addCandidate = undefined

registerVoter :: Voter -> ElectionSystem -> ElectionSystem
-- Descripción: Registra un nuevo votante en el sistema de elecciones.
-- Precondición: El votante no debe estar ya presente en el sistema.
-- Costo: O(log N), donde N es la cantidad de votantes en el sistema.
registerVoter = undefined

castVote :: Voter -> Candidate -> ElectionSystem -> ElectionSystem
-- Descripción: Permite a un votante registrado emitir un voto por un candidato registrado.
-- Precondición: El votante debe estar registrado en el sistema y el candidato debe estar registrado en el sistema.
-- Costo: O(log N), donde N es la cantidad de votantes en el sistema.
castVote = undefined

countVotes :: ElectionSystem -> Map.Map CandidateName Int
-- Descripción: Cuenta los votos emitidos y devuelve un mapa con el nombre de cada candidato y su respectiva cantidad de votos.
-- Costo: O(V), donde V es la cantidad de votos emitidos.
countVotes = undefined

getWinner :: ElectionSystem -> Maybe CandidateName
-- Descripción: Devuelve el nombre del candidato con más votos. Si hay empate, devuelve uno de los candidatos con más votos.
-- Costo: O(V), donde V es la cantidad de votos emitidos.
getWinner = undefined

-- Funciones auxiliares para obtener el identificador del votante y el nombre del candidato
voterID :: Voter -> VoterID
voterID (Voter id) = id

candidateName :: Candidate -> CandidateName
candidateName (Candidate name) = name

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
