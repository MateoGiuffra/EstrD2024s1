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
NodoL* ultimo; 
};

typedef LinkedListSt* LinkedList; // INV.REP.: el puntero NO es NULL
struct IteratorSt {
NodoL* current;
};


LinkedList nil(){
// Crea una lista vacía.
    LinkedListSt* xs = new LinkedListSt; 
    xs->cantidad = 0; 
    xs->primero = NULL; 
    xs->ultimo = NULL; 
    return xs; 
}
bool isEmpty(LinkedList xs){
// Indica si la lista está vacía.
    return xs->cantidad == 0; 
}
int head(LinkedList xs){
// Devuelve el primer elemento.
    return xs->primero->elem;
}
void Cons(int x, LinkedList xs){
// Agrega un elemento al principio de la lista.
    NodoL* n = new NodoL; 
    n->elem = x;
    n->siguiente = xs->primero; 
    xs->primero = n;
    if (xs->primero == NULL){
        xs->ultimo = n; 
    } 
    xs->cantidad++; 
}
void Tail(LinkedList xs){
// Quita el primer elemento.
    if (xs->primero!= NULL){
        NodoL*  temp = xs->primero; 
        xs->primero = temp->siguiente;
        delete temp;
        xs->cantidad--;  
    }
}
int length(LinkedList xs){
// Devuelve la cantidad de elementos.
    return xs->cantidad;
}
void Snoc(int x, LinkedList xs){
// Agrega un elemento al final de la lista.
    NodoL* n = new NodoL; 
    n->elem = x; 
    n->siguiente = NULL; 
    xs->cantidad++;  
    xs->ultimo = n; 
    if (xs->ultimo == NULL){
        xs->primero = n; 
    }
    xs->ultimo->siguiente = n;

}
ListIterator getIterator(LinkedList xs){
// Apunta el recorrido al primer elemento.
    IteratorSt* i = new IteratorSt; 
    i->current =xs->primero;
    return i; 
}
int current(ListIterator ixs){
// Devuelve el elemento actual en el recorrido.
    return ixs->current->elem; 
}
void SetCurrent(int x, ListIterator ixs){
// Reemplaza el elemento actual por otro elemento.
    ixs->current->elem = x; 
}
void Next(ListIterator ixs){
// Pasa al siguiente elemento.
    ixs->current = ixs->current->siguiente;
}
bool atEnd(ListIterator ixs){
// Indica si el recorrido ha terminado.
    return ixs->current == NULL; 
}
void DisposeIterator(ListIterator ixs){
// Libera la memoria ocupada por el iterador.
    delete ixs; 
}

void DestroyL(LinkedList xs){
// Libera la memoria ocupada por la lista.
    NodoL* actual = new NodoL; 
    actual = xs->primero; 
    NodoL* temp = new NodoL; 
    if (actual != NULL){
        while(actual->siguiente != NULL){
        temp = actual; 
        actual = temp->siguiente;
        delete temp;  
        }
    }
    delete xs; 
}
