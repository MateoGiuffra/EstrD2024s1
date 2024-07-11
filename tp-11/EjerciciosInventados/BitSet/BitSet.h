// TAD BitSet
// Descripción Teórica
// Un BitSet es una estructura de datos que representa un conjunto de bits, donde cada bit puede estar en uno de dos estados: 
// encendido (1) o apagado (0). 
// Esta estructura es útil para manejar conjuntos grandes de datos booleanos con eficiencia en espacio y puede ser usada para
// realizar operaciones a nivel de bits rápidamente. Los BitSets son particularmente útiles en aplicaciones que requieren una 
// gestión eficiente de grandes cantidades de estados booleanos, como filtros de Bloom, conjuntos de bits en gráficos y en algoritmos de compresión.

// Invariante de Representación (INV.REP.)
// bits es un array de enteros que representa los bits del BitSet.
// size es el número de bits en el BitSet.
// capacity es el tamaño del array bits en términos del número de enteros.

typedef struct {
    unsigned int* bits; // Array de enteros que contiene los bits
    int size;           // Número de bits en el BitSet
    int capacity;       // Capacidad del array en términos del número de enteros
} BitSet;


#ifndef BITSET_H
#define BITSET_H

#include <stdbool.h>

typedef struct {
    unsigned int* bits; // Array de enteros que contiene los bits
    int size;           // Número de bits en el BitSet
    int capacity;       // Capacidad del array en términos del número de enteros
} BitSet;

BitSet* createBitSet(int size);
// Crea un BitSet con un número específico de bits.

void destroyBitSet(BitSet* bs);
// Libera la memoria asignada al BitSet.

void setBit(BitSet* bs, int index);
// Establece el bit en el índice especificado a 1.

void clearBit(BitSet* bs, int index);
// Establece el bit en el índice especificado a 0.

bool getBit(BitSet* bs, int index);
// Devuelve el valor del bit en el índice especificado.

int countBits(BitSet* bs);
// Devuelve el número de bits establecidos a 1 en el BitSet.

void flipBit(BitSet* bs, int index);
// Cambia el valor del bit en el índice especificado (de 1 a 0 o de 0 a 1).

#endif // BITSET_H
