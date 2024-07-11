#ifndef DEQUE_H
#define DEQUE_H

// Estructura del nodo de la deque
typedef struct DequeNode {
    int data;                   // Valor del nodo
    struct DequeNode* next;     // Puntero al siguiente nodo
    struct DequeNode* prev;     // Puntero al nodo anterior
} DequeNode;

// Estructura de la deque
typedef struct {
    DequeNode* front;           // Puntero al primer nodo
    DequeNode* rear;            // Puntero al último nodo
    int size;                   // Tamaño de la deque
} Deque;

// Prototipos de funciones

Deque* createDeque();                            // Crea una deque vacía
void destroyDeque(Deque* dq);                    // Libera la memoria de la deque
void insertFront(Deque* dq, int data);           // Inserta un elemento al frente de la deque
void insertRear(Deque* dq, int data);            // Inserta un elemento al final de la deque
void deleteFront(Deque* dq);                     // Elimina un elemento del frente de la deque
void deleteRear(Deque* dq);                      // Elimina un elemento del final de la deque
int getFront(Deque* dq);                         // Obtiene el elemento del frente de la deque
int getRear(Deque* dq);                          // Obtiene el elemento del final de la deque
int isEmptyDeque(Deque* dq);                     // Comprueba si la deque está vacía
int getSizeDeque(Deque* dq);                     // Obtiene el tamaño de la deque

#endif /* DEQUE_H */
