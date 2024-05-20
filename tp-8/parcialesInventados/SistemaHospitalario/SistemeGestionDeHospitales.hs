{-
 Sistema de Gestión de Hospitales

 El TAD (Tipo Abstracto de Datos) de Sistema de Gestión de Hospitales es una estructura diseñada para gestionar la información
 de pacientes, doctores, habitaciones y tratamientos en un hospital. Su objetivo principal es proporcionar una forma eficiente
 de administrar y coordinar todos los aspectos relacionados con la atención médica dentro de un hospital.

 Características Principales:

 - Almacenamiento de Pacientes: Utiliza un mapa para almacenar los pacientes, donde cada paciente se identifica por un ID único 
   (PatientID).
 - Gestión de Doctores: Utiliza un conjunto para mantener un registro de los doctores disponibles en el hospital.
 - Asignación de Habitaciones: Utiliza una cola de prioridad para asignar habitaciones a los pacientes en función de la urgencia.
 - Seguimiento de Tratamientos: Utiliza un grafo dirigido para gestionar los tratamientos, sus etapas y dependencias.
 - Gestión de Citas: Utiliza un mapa adicional para programar y gestionar citas entre pacientes y doctores.

 Propósito:

 El propósito principal del Sistema de Gestión de Hospitales es facilitar la organización y gestión de todos los aspectos
 relacionados con la atención médica dentro de un hospital. Permite a los usuarios registrar nuevos pacientes y doctores,
 asignar habitaciones de manera eficiente, gestionar tratamientos complejos con dependencias y programar citas médicas.
 Además, proporciona mecanismos para asegurar que los tratamientos se realicen en el orden correcto y que los recursos
 hospitalarios se utilicen de manera óptima.

 Este sistema es útil en contextos hospitalarios, clínicas y centros de salud, donde la coordinación y gestión eficiente
 de los recursos y tratamientos médicos es crucial para proporcionar una atención médica de calidad. Ofrece una interfaz
 robusta y eficiente para administrar y hacer un seguimiento de todos los aspectos operativos de un hospital.
-}

module HospitalManagement (
    HospitalManagement,
    Patient(..),
    Doctor(..),
    Room(..),
    Treatment(..),
    addPatient,
    registerDoctor,
    assignRoom,
    trackTreatment,
    scheduleAppointment
) where

import MapV1
import SetV1
import PriorityQueueV1
import qualified Data.Graph as Graph

type PatientID     = Int
type DoctorID      = Int
type RoomID        = Int
type AppointmentID = Int

data Patient = P PatientID String 
            deriving (Show, Eq, Ord)

data Doctor = D DoctorID String 
            deriving (Show, Eq, Ord)

data Room = R RoomID 
            deriving (Show, Eq, Ord)

data Treatment = TT String [String] 
            deriving (Show, Eq, Ord)

data HospitalManagement = HM (Map PatientID Patient) 
                           (Set Doctor) 
                           (PriorityQueue (Int, PatientID, RoomID)) 
                           (Graph.Graph Treatment) 
                           (Map AppointmentID (PatientID, DoctorID))
                           deriving (Show, Eq)

addPatient :: Patient -> HospitalManagement -> HospitalManagement
-- Descripción: Agrega un nuevo paciente al sistema de gestión de hospitales.
-- Precondición: El paciente no debe estar ya presente en el sistema.
-- Costo: O(log P), donde P es la cantidad de pacientes en el sistema.
addPatient = undefined

registerDoctor :: Doctor -> HospitalManagement -> HospitalManagement
-- Descripción: Registra un nuevo doctor en el sistema de gestión de hospitales.
-- Precondición: El doctor no debe estar ya presente en el sistema.
-- Costo: O(log D), donde D es la cantidad de doctores en el sistema.
registerDoctor = undefined

assignRoom :: Int -> PatientID -> RoomID -> HospitalManagement -> HospitalManagement
-- Descripción: Asigna una habitación a un paciente en función de la urgencia (prioridad).
-- Precondición: El paciente y la habitación deben estar presentes en el sistema.
-- Costo: O(log R), donde R es la cantidad de asignaciones en la cola de prioridad.
assignRoom = undefined

trackTreatment :: Treatment -> HospitalManagement -> HospitalManagement
-- Descripción: Rastrea un nuevo tratamiento y sus etapas en el sistema de gestión de hospitales.
-- Precondición: El tratamiento no debe estar ya presente en el sistema.
-- Costo: O(log T), donde T es la cantidad de tratamientos en el grafo.
trackTreatment = undefined

scheduleAppointment :: AppointmentID -> PatientID -> DoctorID -> HospitalManagement -> HospitalManagement
-- Descripción: Programa una cita entre un paciente y un doctor en el sistema de gestión de hospitales.
-- Precondición: El paciente y el doctor deben estar presentes en el sistema.
-- Costo: O(log A), donde A es la cantidad de citas en el sistema.
scheduleAppointment = undefined

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

-- PriorityQueue, siendo M la cantidad de elementos en la estructura:

-- emptyPQ :: PriorityQueue a                                      O(1)
-- isEmptyPQ :: PriorityQueue a -> Bool                            O(1)
-- insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a    O(log M)
-- maxPQ :: PriorityQueue a -> a                                   O(1)
-- deleteMaxPQ :: Ord a => PriorityQueue a -> PriorityQueue a      O(log M)

-- Graph, siendo G la cantidad de nodos/arcos en el grafo:

-- emptyG :: Graph a                                  O(1)
-- addNodeG :: a -> Graph a -> Graph a                O(log G)
-- addEdgeG :: (a, a) -> Graph a -> Graph a           O(log G)
-- nodesG :: Graph a -> [a]                           O(G)
-- edgesG :: Graph a -> [(a, a)]                      O(G)
