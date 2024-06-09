#include "Queue.h"
#include <iostream>
#include <cstddef>
using namespace std;   
// struct NodoQ {
//     int elem; // valor del nodo
//     NodoQ* siguiente; // puntero al siguiente nodo
// };

// struct QueueSt {
//     int cantidad; // cantidad de elementos
//     NodoQ* primero; // puntero al primer nodo
//     NodoQ* ultimo; // puntero al último nodo
// };


// Crea una lista vacía.
// Costo: O(1).
Queue emptyQ() {
    Queue q = new QueueSt;  //probar QueueSt q = new Queue;
    q->cantidad = 0; q->primero = NULL; q->ultimo = NULL;
    return q;  
}

// Indica si la lista está vacía.
// Costo: O(1).
bool isEmptyQ(Queue q) {
    return q->cantidad == 0; 
}

// Devuelve el primer elemento.
// Costo: O(1).
int firstQ(Queue q) {
    if(!isEmptyQ(q)){
    return q->primero->elem; 
    }
    return 00000000;
 
}

// Agrega un elemento al final de la cola.
// Costo: O(1).
void Enqueue(int x, Queue q) {
    NodoQ* nodo = new NodoQ; 
    nodo->elem = x; nodo->siguiente = NULL; 

    if (isEmptyQ(q)){
        q->primero = nodo; 
        q->ultimo = nodo; 
    }else{
        q->ultimo->siguiente = nodo; 
        q->ultimo = nodo; 
    }
  
    q->cantidad++;
}

// Quita el primer elemento de la cola.
// Costo: O(1).
void Dequeue(Queue q) {

    if (q->primero == NULL){
        q->ultimo = NULL; 
    }
    NodoQ* nodo = q->primero; 
    q->primero = q->primero->siguiente;
    delete nodo;  
    q->cantidad--; 
 
}

// Devuelve la cantidad de elementos de la cola.
// Costo: O(1).
int lengthQ(Queue q) {
    return q->cantidad; 
}

// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
// Costo: O(1).
void MergeQ(Queue q1, Queue q2) {

    if(isEmptyQ(q1)){
        q1->primero = q2->primero;
        q1->ultimo = q2->ultimo;
    }else if (isEmptyQ(q2)){
        return; 
    }else{
        q1->ultimo->siguiente = q2->primero; 
        q1->ultimo = q2->ultimo;
    }
    q1->cantidad += q2->cantidad; 
    
    // asi se vacia o con Destroy? pasa que no seria de costo 1 
    q2->primero = nullptr;
    q2->ultimo = nullptr;
    q2->cantidad = 0;
}

// Libera la memoria ocupada por la lista.
// Costo: O(n).
void DestroyQ(Queue q) {
    while(!isEmptyQ(q)){
        delete firstQ(q);
        Dequeue;
    }
}


int main(){
    Queue q = emptyQ();
    Enqueue(10,q);
    Enqueue(20,q);
    Enqueue(30,q);
    cout <<lengthQ(q)<<endl; 
    cout<<firstQ(q)<<endl; 
    Dequeue(q);
    cout<<firstQ(q)<<endl; 
}