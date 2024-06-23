#include "LinkedList.h"
#include <iostream>
using namespace std;

struct NodoL {
    int elem; // valor del nodo
    NodoL* siguiente; // puntero al siguiente nodo
};

struct LinkedListSt {
    // INV.REP.: cantidad indica la cantidad de nodos que se pueden recorrer
    // desde primero por siguiente hasta alcanzar a NULL
    // * Si cantidad es 0 entonces primero es NULL 
    // * Si primero es NULL, ultimo es NULL y viceversa. 
    int cantidad; // cantidad de elementos
    NodoL* primero; // puntero al primer nodo
    NodoL* ultimo; // puntero al último nodo
};

typedef LinkedListSt* LinkedList; // INV.REP.: el puntero NO es NULL

struct IteratorSt {
    NodoL* current;
};

typedef IteratorSt* ListIterator;

LinkedList nilL() {
    // Crea una lista vacía.
    LinkedListSt* xs = new LinkedListSt; 
    xs->cantidad = 0; 
    xs->primero = NULL; 
    xs->ultimo = NULL; 
    return xs; 
}

bool isEmptyL(LinkedList xs) {
    // Indica si la lista está vacía.
    return xs->cantidad == 0; 
}

int headL(LinkedList xs) {
    // Devuelve el primer elemento.
   return xs->primero->elem;

}

void ConsL(int x, LinkedList xs) {
    // Agrega un elemento al principio de la lista.
    NodoL* n = new NodoL; 
    n->elem = x;
    n->siguiente = xs->primero; 
    xs->primero = n;
    if (xs->ultimo == NULL) {
        xs->ultimo = n; 
    } 
    xs->cantidad++; 
}

void TailL(LinkedList xs) {
    // Quita el primer elemento.
    if (xs->primero != NULL) {
        NodoL* temp = xs->primero; 
        xs->primero = xs->primero->siguiente;
        delete temp;
        xs->cantidad--;  
        if (xs->cantidad == 0) {
            xs->ultimo = NULL;
        }
    }
}

int lengthL(LinkedList xs) {
    // Devuelve la cantidad de elementos.
    return xs->cantidad;
}

void SnocL(int x, LinkedList xs) {
    // Agrega un elemento al final de la lista.
    NodoL* nodoNuevo = new NodoL; 
    nodoNuevo->elem = x; 
    nodoNuevo->siguiente = NULL; 
    if (xs->ultimo == NULL) {
        xs->primero = nodoNuevo;
        xs->ultimo = nodoNuevo; 
    } else {
        xs->ultimo->siguiente = nodoNuevo; 
        xs->ultimo = nodoNuevo; 
    }
    xs->cantidad++;
}

ListIterator getIteratorL(LinkedList xs) {
    // Apunta el recorrido al primer elemento.
    IteratorSt* i = new IteratorSt; 
    i->current = xs->primero;
    return i; 
}

int currentL(ListIterator ixs) {
    // Devuelve el elemento actual en el recorrido.
    return ixs->current->elem;
    
}

void SetCurrentL(int x, ListIterator ixs) {
    // Reemplaza el elemento actual por otro elemento.
    if (ixs->current != NULL) {
        ixs->current->elem = x; 
    } 
}

void NextL(ListIterator ixs) {
    // Pasa al siguiente elemento.
    if (ixs->current != NULL) {
        ixs->current = ixs->current->siguiente;
    } 
}

bool atEndL(ListIterator ixs) {
    // Indica si el recorrido ha terminado.
    return ixs->current == NULL; 
}

void DisposeIteratorL(ListIterator ixs) {
    // Libera la memoria ocupada por el iterador.
    delete ixs; 
}

void DestroyLL(LinkedList xs) {
    // Libera la memoria ocupada por la lista.
    NodoL* actual = xs->primero;
    NodoL* temp;
    while (actual != NULL) {
        temp = actual;
        actual = actual->siguiente;
        delete temp;
    }
    delete xs; 
}


