#include "LinkedList.h"
#include <iostream>
using namespace std;

int sumatoria(LinkedList xs){
// Devuelve la suma de todos los elementos.
    IteratorSt* i = getIterator(xs); 
    int sum = 0; 
    while(!atEnd(i)){
        sum = sum + current(i);
        Next(i);
    }
    DisposeIterator(i);
    return sum; 
}
void Sucesores(LinkedList xs){
// Incrementa en uno todos los elementos.
    ListIterator ixs = getIterator(xs); 
    while(!atEnd(ixs)){
        SetCurrent(current(ixs)+1,ixs);
        Next(ixs);
    }
    DisposeIterator(ixs);
}
bool pertenece(int x, LinkedList xs){
// Indica si el elemento pertenece a la lista.
    IteratorSt* i = getIterator(xs); 
        while(!atEnd(i) && current(i) != x){
        Next(i);
    }
    return !atEnd(i);
    DisposeIterator(i);
}
int apariciones(int x, LinkedList xs){
// Indica la cantidad de elementos iguales a x.
   IteratorSt* i = getIterator(xs); 
    int apariciones = 0; 
    while(!atEnd(i)){
        if (current(i) == x){
            apariciones ++;
        }
        Next(i);
    }
    DisposeIterator(i);
    return apariciones; 
}
int minimo(LinkedList xs){
// Devuelve el elemento más chico de la lista.
    IteratorSt* i = getIterator(xs); 
    int min = current(i); 
    while(!atEnd(i)){
        min = min < current(i) ? min : current(i); 
        Next(i);
    }
    DisposeIterator(i);
    return min; 
}
LinkedList copy(LinkedList xs){
// Dada una lista genera otra con los mismos elementos, en el mismo orden.
    IteratorSt* i = getIterator(xs); 
    LinkedList copia = nil(); 
    while(!atEnd(i)){
        Snoc(current(i),copia);
        Next(i);
    }
    DisposeIterator(i);
    return copia; 
}
// Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?

int main(){

    LinkedList l = nil();  
    Cons(3,l);
    Cons(2,l);
    Cons(1,l); // esto es igual a [3,2,1] == 3 : 2 : 1: [] 

    cout << sumatoria(l)<< endl; 
    Sucesores(l);
    cout << sumatoria(l)<< endl; 
    cout << pertenece(40,l) <<endl;
   
    Sucesores(l);
     LinkedList copia = copy(l); 
    cout << "El head de la copia de l es " <<head(copia) << " y head de l original es " << head(l) << endl; 
}