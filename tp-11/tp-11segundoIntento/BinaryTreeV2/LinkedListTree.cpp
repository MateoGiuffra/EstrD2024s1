#include "TreeV2.h"
#include <iostream>

struct NodoL {
    Tree elem; // valor del nodo
    NodoL* siguiente; // puntero al siguiente nodo
};

struct LinkedListSt {
    int cantidad; // cantidad de elementos
    NodoL* primero; // puntero al primer nodo
    NodoL* ultimo; // puntero al último nodo
};

typedef LinkedListSt* TreeLinkedList; // INV.REP.: el puntero NO es NULL

struct IteratorSt {
    NodoL* current;
};

typedef IteratorSt* TreeListIterator;

TreeLinkedList nil() {
    // Crea una lista vacía.
    LinkedListSt* xs = new LinkedListSt; 
    xs->cantidad = 0; 
    xs->primero = nullptr; 
    xs->ultimo = nullptr; 
    return xs; 
}

bool isEmpty(TreeLinkedList xs) {
    // Indica si la lista está vacía.
    return xs->cantidad == 0; 
}

Tree head(TreeLinkedList xs) {
    // Devuelve el primer elemento.
    if (xs->primero != nullptr) {
        return xs->primero->elem;
    }
    // Manejo de error si la lista está vacía, puede lanzarse una excepción o un error
    throw std::runtime_error("La lista está vacía");
}

void Cons(Tree x, TreeLinkedList xs) {
    // Agrega un elemento al principio de la lista.
    NodoL* n = new NodoL; 
    n->elem = x;
    n->siguiente = xs->primero; 
    xs->primero = n;
    if (xs->ultimo == nullptr) {
        xs->ultimo = n; 
    } 
    xs->cantidad++; 
}

void Tail(TreeLinkedList xs) {
    // Quita el primer elemento.
    if (xs->primero != nullptr) {
        NodoL* temp = xs->primero; 
        xs->primero = xs->primero->siguiente;
        delete temp;
        xs->cantidad--;  
        if (xs->cantidad == 0) {
            xs->ultimo = nullptr;
        }
    }
}

int length(TreeLinkedList xs) {
    // Devuelve la cantidad de elementos.
    return xs->cantidad;
}

void Snoc(Tree x, TreeLinkedList xs) {
    // Agrega un elemento al final de la lista.
    NodoL* nodoNuevo = new NodoL; 
    nodoNuevo->elem = x; 
    nodoNuevo->siguiente = nullptr; 
    if (xs->ultimo == nullptr) {
        xs->primero = nodoNuevo;
        xs->ultimo = nodoNuevo; 
    } else {
        xs->ultimo->siguiente = nodoNuevo; 
        xs->ultimo = nodoNuevo; 
    }
    xs->cantidad++;
}

TreeListIterator getIterator(TreeLinkedList xs) {
    // Apunta el recorrido al primer elemento.
    TreeListIterator i = new IteratorSt; 
    i->current = xs->primero;
    return i; 
}

Tree current(TreeListIterator ixs) {
    // Devuelve el elemento actual en el recorrido.
    if (ixs->current != nullptr) {
        return ixs->current->elem;
    }
    // Manejo de error si el iterador ha terminado, puede lanzarse una excepción o un error
    throw std::runtime_error("El iterador ha terminado");
}

void SetCurrent(Tree x, TreeListIterator ixs) {
    // Reemplaza el elemento actual por otro elemento.
    if (ixs->current != nullptr) {
        ixs->current->elem = x; 
    } 
}

void Next(TreeListIterator ixs) {
    // Pasa al siguiente elemento.
    if (ixs->current != nullptr) {
        ixs->current = ixs->current->siguiente;
    } 
}
bool NextIsEnd(TreeListIterator ixs){
    return ixs->current->siguiente == NULL;
}

bool atEnd(TreeListIterator ixs) {
    // Indica si el recorrido ha terminado.
    return ixs->current == nullptr; 
}

void DisposeIterator(TreeListIterator ixs) {
    // Libera la memoria ocupada por el iterador.
    delete ixs; 
}

void DestroyL(TreeLinkedList xs) {
    // Libera la memoria ocupada por la lista.
    NodoL* actual = xs->primero;
    NodoL* temp;
    while (actual != nullptr) {
        temp = actual;
        actual = actual->siguiente;
        delete temp;
    }
    delete xs; 

    
}
