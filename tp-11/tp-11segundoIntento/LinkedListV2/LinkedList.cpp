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

LinkedList nil() {
    // Crea una lista vacía.
    LinkedListSt* xs = new LinkedListSt; 
    xs->cantidad = 0; 
    xs->primero = NULL; 
    xs->ultimo = NULL; 
    return xs; 
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
    NodoL* n = new NodoL; 
    n->elem = x;
    n->siguiente = xs->primero; 
    xs->primero = n;
    if (xs->ultimo == NULL) {
        xs->ultimo = n; 
    } 
    xs->cantidad++; 
}

void Tail(LinkedList xs) {
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

int length(LinkedList xs) {
    // Devuelve la cantidad de elementos.
    return xs->cantidad;
}

void Snoc(int x, LinkedList xs) {
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

ListIterator getIterator(LinkedList xs) {
    // Apunta el recorrido al primer elemento.
    IteratorSt* i = new IteratorSt; 
    i->current = xs->primero;
    return i; 
}

int current(ListIterator ixs) {
    // Devuelve el elemento actual en el recorrido.
    return ixs->current->elem;
    
}

void SetCurrent(int x, ListIterator ixs) {
    // Reemplaza el elemento actual por otro elemento.
    if (ixs->current != NULL) {
        ixs->current->elem = x; 
    } 
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
    NodoL* actual = xs->primero;
    NodoL* temp;
    while (actual != NULL) {
        temp = actual;
        actual = actual->siguiente;
        delete temp;
    }
    delete xs; 
}

void reverse(LinkedList xs){
    if (xs->cantidad > 1){
        NodoL* ant = xs->primero; 
        NodoL* cur = ant->siguiente; 
        NodoL* next; 
        while (cur != NULL){
            next = cur->siguiente; 
            cur->siguiente =  ant; 
            ant = cur; 
            cur = next; 
        }
        xs->ultimo = xs->primero; 
        xs->primero = ant; 
    }
}

LinkedList from(int* values, int size){
    LinkedList xs = new LinkedListSt;
    xs->primero = NULL; xs->ultimo = NULL; xs->cantidad = 0; 
    if (size <= 0) return xs; 
    for (int i = 0; i<size; i++){
        NodoL* cur = new NodoL;
        cur->elem = values[i];
        cur->siguiente = NULL;
        if (i == 0) {
            xs->primero = cur;
        } else {
            xs->ultimo->siguiente = cur;
        }
        xs->ultimo = cur; 
        xs->cantidad++; 
    }
    return xs; 
}

int* toArray(LinkedList xs){
    if (xs->cantidad <= 0) return new int[0];
    int* res   = new int[xs->cantidad];
    NodoL* cur = xs->primero; 
    for (int i = 0; i<xs->cantidad; i++){
        res[i] = cur->elem; 
        cur = cur->siguiente; 
    }
    return res; 
}



void imprimir(LinkedList xs) {
    if (isEmpty(xs)) {
        cout << "[]" << endl;

    }
    
    ListIterator it = getIterator(xs);
    cout << "[";
    while (!atEnd(it)) {
        cout << current(it);
        Next(it);
        if (!atEnd(it)) {
            cout << ", ";
        }
    }
    cout << "]" << endl;
    DisposeIterator(it);
}

int main(){
    LinkedList xs = nil();  
    Cons(5,xs);
    Cons(4,xs);
    Cons(3,xs);
    Cons(2,xs);
    Cons(1,xs); // esto es igual a [3,2,1] == 3 : 2 : 1: [] 
    int* res = toArray(xs);
    cout << res[0] <<endl; //  1
    int size = 5;
    int* arr = new int[size];

    // Inicialización del array
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;
    arr[3] = 40;
    arr[4] = 50;
    LinkedList ys = from(arr, size);
    cout << head(ys) <<endl; 
    // imprimir(ys);     

    // cout << "Antes del reverse quedaria:" << endl; 
    // cout << head(xs) <<endl; // 1
    // Tail(xs); 
    // cout << head(xs) <<endl; // 2
    // Tail(xs); 
    // cout << head(xs) <<endl; // 3
    // Tail(xs); 
    // cout << head(xs) <<endl; // 4
    // Tail(xs); 
    // cout << head(xs) <<endl; // 5
    // Tail(xs); 

    // Cons(5,xs);
    // Cons(4,xs);
    // Cons(3,xs);
    // Cons(2,xs);
    // Cons(1,xs); // esto es igual a [3,2,1] == 3 : 2 : 1: [] 
    
    // reverse(xs);
    
    // imprimir(xs);
    
    // cout << "Despues del reverse quedaria:" << endl; 
    // cout << head(xs) <<endl; // 5
    // Tail(xs); 
    // cout << head(xs) <<endl; // 4
    // Tail(xs); 
    // cout << head(xs) <<endl; // 3
    // Tail(xs); 
    // cout << head(xs) <<endl; // 2
    // Tail(xs); 
    // cout << head(xs) <<endl; // 1
    // Tail(xs); 
    // imprimir(xs);

}