#include "Set.h"
#include "LinkedList.h"
#include <cstddef>
#include <iostream>
using namespace std; 

struct NodoS {
int elem; // valor del nodo
NodoS* siguiente; // puntero al siguiente nodo
};
struct SetSt {
    /* INV. REP: 
        Si primero es NULL entonces cantidad es 0. 
        Cantidad es la cantidad de nodos a recorrer hasta que el siguiente de algun nodo sea NULL. 
    */
int cantidad; // cantidad de elementos diferentes
NodoS* primero; // puntero al primer nodo
};
typedef SetSt* Set;

// Crea un conjunto vacío.
Set emptyS(){
    Set s = new SetSt; 
    s->cantidad = 0; 
    s->primero = NULL; 
    return s; 
}

// Indica si el conjunto está vacío.
bool isEmptyS(Set s){
    return s->cantidad == 0; 
}

// Indica si el elemento pertenece al conjunto.
bool belongsS(int x, Set s){
    NodoS* current = s->primero; 
    while(current != NULL && current->elem != x){
        current = current->siguiente; 
    }
    return current != NULL;
}

// Agrega un elemento al conjunto.
void AddS(int x, Set s){

    if (!belongsS(x,s)){
    NodoS* nuevoNodo = new NodoS; 
    nuevoNodo->elem = x; 
    if (s->primero == NULL){
        nuevoNodo->siguiente = NULL; 
    }else{
       nuevoNodo->siguiente = s->primero; 
    }
    s->primero = nuevoNodo; 
    s->cantidad++; 
    }
}




// Quita un elemento dado.
void RemoveS(int x, Set s){
    if(s->primero !=  NULL){
        NodoS* current = s->primero; 
        NodoS* anterior = new NodoS; 
        while(current != NULL && current->elem != x){ //lo busco
        anterior = current; 
        current = current->siguiente; 
        }

        if(current != NULL){ //si no es NULL significa que lo encontre
            if (s->primero == current){
                s->primero = current->siguiente;  //si es el primero, cambio el primero de s 
            }else{
                anterior->siguiente = current->siguiente; //si es uno del medio, uso el anterior
            }
            s->cantidad--; 
        }
    }
   
}

// Devuelve la cantidad de elementos.
int sizeS(Set s){
    return s->cantidad; 
}

// Devuelve una lista con los elementos del conjunto.
LinkedList setToList(Set s){
    LinkedList linkedList = nil();
    NodoS* current = s->primero; 
    while(current!=NULL){
        Snoc(current->elem,linkedList);    
        current = current->siguiente;
    }

    return linkedList; 
}

// Libera la memoria ocupada por el conjunto.
void DestroyS(Set s){
    // if(s->primero != NULL){
    //     NodoS* current = s->primero; 
    //     NodoS* temp = new NodoS; 
    //     while(current!=NULL){
    //         temp = current; 
    //         s->primero = current->siguiente;
    //         delete temp;  
    //     }
    //     delete s; 
    // }
}
void imprimir(LinkedList xs){
// Devuelve la suma de todos los elementos.
    IteratorSt* i = getIterator(xs); 

    cout << " [" ;
    if(!atEnd(i)){
    while(!atEnd(i)){
        cout << current(i) ;
        cout << ", ";
        Next(i);
    }
    } 
    cout << "]" ;
    DisposeIterator(i);

}

int main(){
    Set conjunto = emptyS();
    AddS(1,conjunto);
    AddS(2,conjunto);
    AddS(3,conjunto);
    AddS(3,conjunto);


    cout << sizeS(conjunto) <<endl;

    RemoveS(1,conjunto);
    RemoveS(2,conjunto);
    RemoveS(3,conjunto);
    RemoveS(3,conjunto);
    cout << sizeS(conjunto) <<endl;


       AddS(1,conjunto);
    AddS(2,conjunto);
    AddS(3,conjunto);
    AddS(3,conjunto);
    LinkedList xs = setToList(conjunto);
    imprimir(xs);

    return 0;
}