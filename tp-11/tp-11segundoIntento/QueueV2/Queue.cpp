#include "Queue.h"
#include <iostream>
#include <cstddef>
using namespace std;  

struct NodoQ {
int elem; // valor del nodo
NodoQ* siguiente; // puntero al siguiente nodo
};
struct QueueSt {
    /* INV.REP: 
        Si primero es NULL entonces cantidad es 0. 
        Si primero es NULL entonces ultimo es NULL y viceversa.
        */
int cantidad; // cantidad de elementos
NodoQ* primero; // puntero al primer nodo
NodoQ* ultimo; // puntero al ultimo nodo
};

typedef QueueSt* Queue;

// Crea una lista vacía.
// Costo: O(1).
Queue emptyQ(){
    Queue q = new QueueSt; 
    q->cantidad = 0; q->primero = NULL; q->ultimo = NULL;
    return q; 
}

// Indica si la lista está vacía.
// Costo: O(1).
bool isEmptyQ(Queue q){
    return q->cantidad == 0; 
}

// Devuelve el primer elemento.
// Costo: O(1).
int firstQ(Queue q){
    return q->primero->elem; 
}

// Agrega un elemento al final de la cola.
// Costo: O(1).
void Enqueue(int x, Queue q){
    NodoQ* nodoNuevo = new NodoQ; 
    nodoNuevo->elem = x; 
    nodoNuevo->siguiente = NULL; 
    if (q->primero == NULL){
        q->primero = nodoNuevo; 
    }else{
        q->ultimo->siguiente =  nodoNuevo; 
    }
    q->ultimo = nodoNuevo; 
    q->cantidad++;
}
//3(2(1 q)) => 1  


// Quita el primer elemento de la cola.
// Costo: O(1).
void Dequeue(Queue q){
    if (q->primero != NULL){
        NodoQ* temp = q->primero; 
        q->primero = q->primero->siguiente; 
        delete temp; 
        q->cantidad--; 
    }

}

// Devuelve la cantidad de elementos de la cola.
// Costo: O(1).
int lengthQ(Queue q){
    return q->cantidad; 
}

// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
// Costo: O(1).
void MergeQ(Queue q1, Queue q2){
    if(q1->primero == NULL){
        delete q2; 
    }
    q1->ultimo->siguiente = q2->primero; 
    q1->ultimo = q2->ultimo; 
    q1->cantidad += q2->cantidad; 
    delete q2; 
}

// Libera la memoria ocupada por la lista.
// Costo: O(n).
void DestroyQ(Queue q){
    if (q->primero != NULL){
        NodoQ* temp = new NodoQ; 
        while(q->primero != NULL)   {
            temp =  q->primero; 
            q->primero = q->primero->siguiente; 
            delete temp; 
        }
        delete q; 
    }
    
}

int main(){
    Queue cola = emptyQ(); 
    Enqueue(1,cola);
    Enqueue(2,cola);
    Enqueue(3,cola);
    cout << firstQ(cola) <<endl; 
    Dequeue(cola);
    cout << firstQ(cola) <<endl; 

    Queue cola2 = emptyQ(); 
    Enqueue(4,cola2);
    Enqueue(5,cola2);
    Enqueue(6,cola2);
    MergeQ(cola,cola2); 

     Dequeue(cola);
      Dequeue(cola);
       Dequeue(cola);
        Dequeue(cola);
    cout << firstQ(cola) <<endl; 
    cout << lengthQ(cola) << endl; 

    Queue cola3 = emptyQ(); 
    Enqueue(7,cola2);
    Enqueue(8,cola2);
    Enqueue(9,cola2);
    Enqueue(10,cola2);

    MergeQ(cola,cola3); 
    cout <<"Deberia de tener 5 == " << lengthQ(cola) << endl; 

    DestroyQ(cola); 
    cout << lengthQ(cola) << endl; 
    return 0;
}