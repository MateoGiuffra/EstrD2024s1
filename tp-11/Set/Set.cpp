#include "Set.h"
#include "LinkedList.h"

// struct NodoS {
// int elem; // valor del nodo
// NodoS* siguiente; // puntero al siguiente nodo
// }
// struct SetSt {
// int cantidad; // cantidad de elementos diferentes
// NodoS* primero; // puntero al primer nodo
// }
//typedef SetSt* Set;

// Crea un conjunto vacío.
Set emptyS() {
    SetSt* s = new Set;
    s->cantidad = 0; s->primero = NULL; 
    return s;
}

// Indica si el conjunto está vacío.
bool isEmptyS(Set s) {
    return s->cantidad == 0;
}

// Indica si el elemento pertenece al conjunto.
bool belongsS(int x, Set s) {
    
    NodoS* nodo = s->primero; 
    while(nodo != NULL && x!= nodo->elem){
        nodo = nodo->siguiente; 
    }

    return nodo != NULL;
}

// Agrega un elemento al conjunto.
void AddS(int x, Set s) {
    if (belongsS(x, s)) {
        return; // Si ya existe, no se agrega
    }
    
    NodoS* n = new NodoS; 
    n->elem = x;
    n->siguiente = s->primero; // El nuevo nodo apunta al antiguo primer nodo
    s->primero = n;            // El nuevo nodo se convierte en el primer nodo
    s->cantidad++;             // Incrementa la cantidad de elementos en el conjunto
}


// Quita un elemento dado.
void RemoveS(int x, Set s) {
    NodoS* nodo = s->primero; 
    while(nodo != NULL && x!= nodo->elem){
        nodo = nodo->siguiente; 
    }
    if (nodo != NULL){
        delete nodo; 
    }
}

// Devuelve la cantidad de elementos.
int sizeS(Set s) {
    // Implementación aquí
    return 0;
}

// Devuelve una lista con los elementos del conjunto.
LinkedList setToList(Set s) {
    // Implementación aquí
    return nullptr;
}

// Libera la memoria ocupada por el conjunto.
void DestroyS(Set s) {
    // Implementación aquí
}


int main(){
    return 0;
}