#ifndef DICTIONARY_H
#define DICTIONARY_H

#include <cstddef> // Para NULL
#include <string>
struct DictionaryStruct {
    char** keys;  // Array de cadenas de caracteres para las claves
    int* values; // Array de enteros para los valores
    int maxSize; // Capacidad máxima del diccionario
    int size;    // Tamaño actual del 
    
};

typedef DictionaryStruct* Dictionary;


// Función para crear un diccionario con una capacidad máxima especificada
// Precondición: maxSize > 0
// Propósito: Crear un diccionario vacío con capacidad para maxSize elementos
// Eficiencia: O(1)
// Dictionry createDictionary(int maxSize);


// Función para destruir el diccionario y liberar la memoria asignada
// Precondición: dict no es NULL
// Propósito: Liberar la memoria utilizada por el diccionario
// Eficiencia: O(n)
void destroyDictionary(Dictionary* dict);

void aumentarEspacio(Dictionary dict); 
// Función para agregar una clave y su valor asociado al diccionario
// Precondición: dict no es NULL, key no es NULL, dict no está lleno
// Propósito: Insertar un nuevo par clave-valor en el diccionario
// Eficiencia: O(n) en el peor caso (si se verifica la existencia de la clave)
void add(Dictionary* dict, const char* key, int value);

// Función para obtener el valor asociado a una clave específica
// Precondición: dict no es NULL, key no es NULL
// Propósito: Devolver el valor asociado a la clave dada
// Eficiencia: O(n) en el peor caso
int get(Dictionary* dict, const char* key);

// Función para verificar si una clave existe en el diccionario
// Precondición: dict no es NULL, key no es NULL
// Propósito: Comprobar si la clave está presente en el diccionario
// Eficiencia: O(n) en el peor caso
bool contains(Dictionary* dict, const char* key);

// Función para eliminar una clave y su valor asociado del diccionario
// Precondición: dict no es NULL, key no es NULL
// Propósito: Remover el par clave-valor del diccionario
// Eficiencia: O(n) en el peor caso
void removeKey(Dictionary* dict, const char* key);

#endif // DICTIONARY_H