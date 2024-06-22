#include "Set.h"
#include "LinkedList.h"
#include <cstddef>
#include <iostream>
using namespace std; 
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
    Set s = new SetSt;
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
    
    NodoS* actual = s->primero; 
    NodoS* anterior = NULL; 
    while(actual->siguiente != NULL && x != actual->elem){
        anterior = actual; 
        actual = actual->siguiente; 
    }

    if (actual->siguiente !=NULL){
        if (anterior == NULL){ //significa que es el primero 
        s->primero = actual->siguiente; 
        }else{
        anterior->siguiente = actual->siguiente;
        }
    s->cantidad--;
    delete actual;    
    }
    return; 
    
}

// Devuelve la cantidad de elementos.
int sizeS(Set s) {
    return s->cantidad;
}

// Devuelve una lista con los elementos del conjunto.
LinkedList setToList(Set s) {
    LinkedListSt* lista = nil(); 
    NodoS* nodoActual = s->primero; 
    while (nodoActual->siguiente != NULL && nodoActual != NULL){
        Cons(nodoActual->elem,lista);
    }
    return lista; 
}

// Libera la memoria ocupada por el conjunto.
void DestroyS(Set s) {
    delete s; 
}


int main(){
    Set s = emptyS();
    AddS(1,s);
    AddS(2,s);
    AddS(3,s);
    AddS(4,s);
    AddS(5,s);
    AddS(6,s);
    
    cout<< "Se agregaron a un Set vacio los elementos del 1 al 6, entonces la cantidad de elementos seria  6 == " << sizeS(s) << 
    " Se chequea que el numero 6 exista: 1 == " << belongsS(6,s) << "Pero despues se hace un remove 6, asi que chequea que haya cambio en estos dos tests"<<endl; 
    RemoveS(6,s);
    cout<< "La cantidad seria 5 == " << sizeS(s) << " Y no existe el 6: 0 == " <<belongsS(6,s) <<endl; 
    RemoveS(10,s);
    cout<< "Y ahora se borra el 10, numero que no existe, por ende deberia de seguir estando la misma cantidad de elementos, o sea 5 == " << sizeS(s)<<endl;

}