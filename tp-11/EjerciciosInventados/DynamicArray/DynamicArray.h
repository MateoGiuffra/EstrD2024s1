#ifndef DYNAMICARRAY_H
#define DYNAMICARRAY_H

//TAD DynamicArray proporciona una implementación de un array dinámico en C. Un array dinámico es una
//estructura de datos que permite almacenar un conjunto de elementos de manera secuencial y que puede crecer
//o reducir su tamaño automáticamente según la cantidad de elementos que se añadan o eliminen. Esto se logra
//usando memoria dinámica (malloc y free), permitiendo una gestión eficiente de la memoria y evitando memory 
//leaks mediante la liberación apropiada de la memoria asignada.

// Estructura del DynamicArray
typedef struct {
    int *data;      // Puntero a los datos del array
    int size;       // Tamaño actual del array
    int capacity;   // Capacidad total del array
} DynamicArray;

// Prototipos de funciones
DynamicArray* createDynamicArray();        // Crea un DynamicArray vacío
void destroyDynamicArray(DynamicArray *arr);   // Libera la memoria del DynamicArray
void addElement(DynamicArray *arr, int element);   // Agrega un elemento al final del array
int getElement(DynamicArray *arr, int index);   // Obtiene el elemento en la posición index

#endif /* DYNAMICARRAY_H */
