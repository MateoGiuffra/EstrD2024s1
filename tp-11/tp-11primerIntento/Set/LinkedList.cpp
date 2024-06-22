#include <iostream>
#include "LinkedList.h"
using namespace std;

LinkedList nil() {
    // Crea una lista vacía.
    LinkedListSt* ll = new LinkedListSt;
    ll->cantidad = 0;
    ll->primero = NULL;
    return ll; 
}

bool isEmpty(LinkedList xs) {
    // Indica si la lista está vacía.
    return xs->cantidad == 0; 
}

int head(LinkedList xs) {
    // Devuelve el primer elemento.
    return xs->primero->elem; 
}

void Cons(int x, LinkedList xs) {
    // Agrega un elemento al principio de la lista.
    NodoL* nodoNuevo = new NodoL; 
    nodoNuevo->elem = x; 
    nodoNuevo->siguiente = xs->primero;
    xs->primero = nodoNuevo; 
    xs->cantidad++;  
}

void Tail(LinkedList xs) {
    // Quita el primer elemento.
    if (xs->cantidad == 0) {
        return; // La lista es vacía entonces no se saca nada.
    } else {
        NodoL* temp = xs->primero;
        xs->primero = xs->primero->siguiente; 
        delete temp; // Libera memoria del nodo eliminado.
        xs->cantidad--;
    }
}

int length(LinkedList xs) {
    // Devuelve la cantidad de elementos.
    return xs->cantidad; 
}

void Snoc(int x, LinkedList xs) {
    // Agrega un elemento al final de la lista.
    NodoL* nodoNuevo = new NodoL;
    nodoNuevo->elem = x; 
    nodoNuevo->siguiente = NULL;

    if (xs->cantidad == 0) {
        xs->primero = nodoNuevo;
    } else {
        NodoL* sig = xs->primero;
        while (sig->siguiente != NULL) {
            sig = sig->siguiente;
        }
        sig->siguiente = nodoNuevo;
    }
    xs->cantidad++;
}

ListIterator getIterator(LinkedList xs) {
    // Apunta el recorrido al primer elemento.
    IteratorSt* iterator = new IteratorSt; 
    iterator->current = xs->primero;
    return iterator; 
}

int current(ListIterator ixs) {
    // Devuelve el elemento actual en el recorrido.
    return ixs->current->elem; 
}

void SetCurrent(int x, ListIterator ixs) {
    // Reemplaza el elemento actual por otro elemento.
    ixs->current->elem = x;
}

void Next(ListIterator ixs) {
    // Pasa al siguiente elemento.
    if (ixs->current != NULL) {
        ixs->current = ixs->current->siguiente; 
    }
}

bool atEnd(ListIterator ixs) {
    // Indica si el recorrido ha terminado.
    return ixs->current == NULL; 
}

void DisposeIterator(ListIterator ixs) {
    // Libera la memoria ocupada por el iterador.
    delete ixs; 
}

void DestroyL(LinkedList xs) {
    // Libera la memoria ocupada por la lista.
    NodoL* nodoActual = xs->primero;
    while(nodoActual != NULL){
        nodoActual = nodoActual->siguiente;
        delete nodoActual;  
    }
    delete xs;
}

// int main() {

//     // lista con snoc
//     LinkedList xs = nil();
//     Snoc(100,xs); 
//     Snoc(1000,xs); 
//     Snoc(10000,xs); 
//     cout<<head(xs)<<endl; // da 100 

//     // lista con cons
//     LinkedList xs = nil();
//     cons(100,xs); 
//     cons(1000,xs); 
//     cons(10000,xs); 
//     cout<<head(xs)<<endl; // da 10000 
//     // esta al reves no? 



// }
