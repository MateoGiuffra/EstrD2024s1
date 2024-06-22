#include "ArrayListV2.h"
#include <iostream>
#include <cstddef>
using namespace std; 

// struct ArrayListSt {
// int cantidad; // cantidad de elementos
// int* elementos; // array de elementos
// int capacidad; // tamaño del array
// };

ArrayList newArrayList(){
//Definir la siguiente interfaz de este tipo de listas:
// Crea una lista con 0 elementos.
// Nota: empezar el array list con capacidad 16.
    ArrayList a = new ArrayListSt; 
    a->capacidad = 16; a->cantidad = 0; 
    a->elementos = new int[capacidad];
    return a; 
}

ArrayList newArrayListWith(int capacidad){
// Crea una lista con 0 elementos y una capacidad dada por parámetro.
    ArrayList a = new ArrayListSt; 
    a->capacidad = capacidad; a->cantidad = 0; 
    a->elementos = new int[capacidad];
    return a; 
}

int lengthAL(ArrayList xs){
// Devuelve la cantidad de elementos existentes.
    return xs->cantidad; 
}
int get(int i, ArrayList xs){
// Devuelve el iesimo elemento de la lista.
    return xs->elementos[i];
}
void set(int i, int x, ArrayList xs){
// Reemplaza el iesimo elemento por otro dado.
    if(x > xs->cantidad-1){
        xs->cantidad++; 
    }//                                                                                                (porque el indice arranca en 0)
    xs->elementos[i] = x; //consultar que pasa si hay 3 elementos y se quiere agregar en la posicion 4 o 3 por ejemplo, se puede? se suma? 
}

void resize(int capacidad, ArrayList xs){
// Decrementa o aumenta la capacidad del array.
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.
    xs->capacidad = capacidad; 
    if(capacidad < xs->cantidad){
        elementosNuevo = new int[capacidad];
        for(int i = 0; i < capacidad;i++){
            elementosNuevo =  xs->elementos[i];
        }
        xs->elementos = elementosNuevo; 
    }
}

void add(int x, ArrayList xs){

}
// Agrega un elemento al final de la lista.
void remove(ArrayList xs){

}
// Borra el último elemento de la lista 
