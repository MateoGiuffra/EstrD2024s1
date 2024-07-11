#include <cassert>
#include "LinkedListV3.h"
#include <cstddef> 
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

struct IteratorSt {
    NodoL* current;
};



LinkedList nil(){
// Crea una lista vacía.;
    LinkedList xs = new LinkedListSt;
    xs->cantidad = 0; 
    xs->primero = NULL; xs->ultimo = NULL; 
    return xs; 
}
bool isEmpty(LinkedList xs){
// Indica si la lista está vacía.;
    return xs->cantidad == 0; 
}
int head(LinkedList xs){
// Devuelve el primer elemento.;
    return xs->primero->elem; 
}
void Cons(int x, LinkedList xs){
// Agrega un elemento al principio de la lista.;
    NodoL* n = new NodoL; 
    n->elem = x; 
    if (xs->cantidad == 0){
        n->siguiente = NULL; 
        xs->ultimo = n; 
    }else{
        n->siguiente = xs->primero; 
    } 
    xs->primero = n;
    xs->cantidad++; 
}
void Tail(LinkedList xs){
// Quita el primer elemento.;
    if (xs->cantidad == 0) return; 
    NodoL* temp = xs->primero; 
    xs->primero = xs->primero->siguiente;
    delete temp;  
    xs->cantidad--; 
}
int length(LinkedList xs){
// Devuelve la cantidad de elementos.;
    return xs->cantidad; 
}
void Snoc(int x, LinkedList xs){
// Agrega un elemento al final de la lista.;
    NodoL* n = new NodoL; 
    n->elem = x; 
    n->siguiente = NULL;
    if (xs->cantidad == 0){
        xs->primero = n;  
    }else{
        xs->ultimo->siguiente =  n; 
    }
    xs->ultimo = n; 
    xs->cantidad++; 
}

ListIterator getIterator(LinkedList xs){
// Apunta el recorrido al primer elemento.;
    ListIterator i = new IteratorSt;
    i->current = xs->primero;
    return i; 
}

int current(ListIterator ixs){
// Devuelve el elemento actual en el recorrido.;
    return ixs->current->elem; 
}
void SetCurrent(int x, ListIterator ixs){
// Reemplaza el elemento actual por otro elemento.;
    ixs->current->elem = x; 
}
void Next(ListIterator ixs){
// Pasa al siguiente elemento.;
    ixs->current = ixs->current->siguiente;
}
bool atEnd(ListIterator ixs){
// Indica si el recorrido ha terminado.;
    return ixs->current == NULL; 
}
void DisposeIterator(ListIterator ixs){
// Libera la memoria ocupada por el iterador.;
    delete ixs; 
}
void DestroyL(LinkedList xs){
// Libera la memoria ocupada por la lista.;
    while(xs->primero != NULL){
        NodoL* temp = xs->primero; 
        xs->primero = xs->primero->siguiente; 
        delete temp; 
        xs->cantidad--; 
    }
    delete xs; 
}



// int main() {
//     // Crear una lista vacía
//     LinkedList list = nil();
//     assert(isEmpty(list) == true);

//     // Agregar elementos a la lista
//     Cons(1, list);
//     assert(isEmpty(list) == false);
//     assert(head(list) == 1);
    
//     Cons(2, list);
//     assert(head(list) == 2);
    
//     Snoc(3, list);
//     assert(length(list) == 3);

//     // Remover elementos de la lista
//     Tail(list);
//     // Después de Tail, la lista debería ser [1, 3]
//     assert(head(list) == 1);
//     assert(length(list) == 2);

//     Tail(list);
//     // Después de Tail, la lista debería ser [3]
//     assert(head(list) == 3);
//     assert(length(list) == 1);

//     // Uso del iterador
//     ListIterator it = getIterator(list);
//     assert(current(it) == 3); // El único elemento restante es 3
//     assert(atEnd(it) == false);
    
//     Next(it);
//     assert(atEnd(it) == true);
//     DisposeIterator(it);

//     // Destruir la lista
//     DestroyL(list);

//     // Asegurar que el mensaje se imprima inmediatamente
//     std::cout << "Todos los tests pasaron correctamente!" << std::endl;
//     std::cout.flush();

//     return 0;
// }
