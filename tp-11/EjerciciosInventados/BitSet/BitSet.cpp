#include "BitSet.h"
#include <cstdlib>

BitSet* createBitSet(int size) {
    // Crea un BitSet con un número específico de bits.
    // Complejidad: O(n) donde n es el número de bits.
}

void destroyBitSet(BitSet* bs) {
    // Libera la memoria asignada al BitSet.
    // Complejidad: O(1)
   
}

void setBit(BitSet* bs, int index) {
    // Establece el bit en el índice especificado a 1.
    // Complejidad: O(1)

}

void clearBit(BitSet* bs, int index) {
    // Establece el bit en el índice especificado a 0.
    // Complejidad: O(1)

}

bool getBit(BitSet* bs, int index) {
    // Devuelve el valor del bit en el índice especificado.
    // Complejidad: O(1)

}

int countBits(BitSet* bs) {
    // Devuelve el número de bits establecidos a 1 en el BitSet.
    // Complejidad: O(n) donde n es el número de bits.

}

void flipBit(BitSet* bs, int index) {
    // Cambia el valor del bit en el índice especificado (de 1 a 0 o de 0 a 1).
    // Complejidad: O(1)

}

