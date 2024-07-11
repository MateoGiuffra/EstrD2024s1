#include <cassert>
#include "LinkedListV3.h"
#include <cstddef> 
#include <iostream>
using namespace std; 

int sumatoria(LinkedList xs) {
    // Devuelve la suma de todos los elementos.
    if (isEmpty(xs)) return 0; 
    int sum = 0;
    ListIterator ixs = getIterator(xs); 
    while (!atEnd(ixs)){
        sum += current(ixs); 
        Next(ixs);
    }
    DisposeIterator(ixs);
    return sum; 
}

void Sucesores(LinkedList xs) {
    // Incrementa en uno todos los elementos.

    ListIterator ixs = getIterator(xs); 
    while (!atEnd(ixs)){
        SetCurrent((current(ixs)+1), ixs); 
        Next(ixs);
    }
    DisposeIterator(ixs);
}

bool pertenece(int x, LinkedList xs) {
        ListIterator ixs = getIterator(xs); 
    while (!atEnd(ixs) && current(ixs) != x){ 
        Next(ixs);
    }
    return !atEnd(ixs); 
    DisposeIterator(ixs);
}

int apariciones(int x, LinkedList xs) {
    int sum = 0;
    ListIterator ixs = getIterator(xs); 
    while (!atEnd(ixs)){
        sum += current(ixs) == x ? 1 : 0; 
        Next(ixs);
    }
    DisposeIterator(ixs);
    return sum; 
}

int minimo(LinkedList xs) {
    // Devuelve el elemento más chico de la lista.
    if(isEmpty(xs)) throw runtime_error("Empty xs");
    ListIterator ixs = getIterator(xs); 
    int min = current(ixs);
    Next(ixs);
    while (!atEnd(ixs)){
        min = current(ixs) > min ? min : current(ixs); 
        Next(ixs);
    }
    DisposeIterator(ixs);
    return min;
}

LinkedList copy(LinkedList xs) {
    // Dada una lista genera otra con los mismos elementos, en el mismo orden.
    // Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
    LinkedList ns = nil(); 
    if (isEmpty(xs)) return ns; 
    ListIterator ixs = getIterator(xs);
    while(!atEnd(ixs)){
        Snoc(current(ixs), ns);
        Next(ixs);
    }
    DisposeIterator(ixs); 
    return ns; 

}

void Append(LinkedList xs, LinkedList ys) {
    // Agrega todos los elementos de la segunda lista al final de los de la primera.
    // La segunda lista se destruye.
    // Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
    ListIterator ixs = getIterator(xs);
    while(!atEnd(ixs)){
        Next(ixs);
    }
    ListIterator iys = getIterator(ys);
    while(!atEnd(iys)){
        Snoc(current(iys),xs);
        Next(iys);
    }
    DisposeIterator(ixs);
    DisposeIterator(iys);
    DestroyL(ys); 
}

int main(){
    LinkedList list = nil();

    // Agregar elementos a la lista
    Cons(1, list);
    Cons(2, list);
    Snoc(3, list);
    cout << sumatoria(list) <<endl; // 6
    Sucesores(list);
    cout << sumatoria(list) <<endl; // 9 
    cout << pertenece(2,list) <<endl; // da uno 
    cout << apariciones(2,list) <<endl; // da uno
    cout << minimo(list) << endl;  // da 2
    LinkedList listCopy = copy(list);
    cout << sumatoria(listCopy) <<endl; // da 9 ya que es su copia 
    
    Append(list, listCopy);
    cout << sumatoria(list) <<endl; // 18
    return 0; 
}