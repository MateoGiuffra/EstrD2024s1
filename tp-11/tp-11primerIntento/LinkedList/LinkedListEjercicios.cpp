#include<iostream>
#include "LinkedList.h"
using namespace std;


// Ejercicio 2
// Definir las siguientes funciones utilizando la interfaz de LinkedList, indicando costos:
// bool isEmpty(LinkedList xs)
// Indica si la lista está vacía.

// int head(LinkedList xs)
// Devuelve el primer elemento.

// void Cons(int x, LinkedList xs)
// Agrega un elemento al principio de la lista.

// void Tail(LinkedList xs)
// Quita el primer elemento.

// int length(LinkedList xs)
// Devuelve la cantidad de elementos.

// void Snoc(int x, LinkedList xs)
// Agrega un elemento al final de la lista.

// ListIterator getIterator(LinkedList xs)
// Apunta el recorrido al primer elemento.

// int current(ListIterator ixs)
// Devuelve el elemento actual en el recorrido.

// void SetCurrent(int x, ListIterator ixs)
// Reemplaza el elemento actual por otro elemento.

// void Next(ListIterator ixs)
// Pasa al siguiente elemento.

// bool atEnd(ListIterator ixs)
// Indica si el recorrido ha terminado.

// void DisposeIterator(ListIterator ixs)
// Libera la memoria ocupada por el iterador.

// void DestroyL(LinkedList xs)
// Libera la memoria ocupada por la lista.


int sumatoria(LinkedList xs){
//Devuelve la suma de todos los elementos.
    int suma = 0; 
    ListIterator ixs =  getIterator(xs);
    while( !atEnd(ixs)){
        suma += current(ixs);
        Next(ixs);
    }
    DisposeIterator(ixs);
    return suma; 
}

void Sucesores(LinkedList xs){
//Incrementa en uno todos los elementos.

    int longitud = length(xs);
    for(int i = 0; i<longitud; i++){
         int guardar = head(xs)+ 1;
         Tail(xs); 
         Cons(guardar,xs);
    }
}


bool pertenece(int x, LinkedList xs){
//Indica si el elemento pertenece a la lista.
    ListIterator ixs =  getIterator(xs);

    while(!atEnd(ixs) && x != current(ixs)){
        Next(ixs);
    }
    return !atEnd(ixs);
    DisposeIterator(ixs);
}

int apariciones(int x, LinkedList xs){
//Indica la cantidad de elementos iguales a x.
    ListIterator ixs =  getIterator(xs);
    int apariciones = 0; 
    while(!atEnd(ixs)){
        if (x == current(ixs)){
            apariciones++;
        }
        Next(ixs);
    }
    DisposeIterator(ixs);
    return apariciones; 
}
int minimo(LinkedList xs){
//Devuelve el elemento más chico de la lista.
    ListIterator ixs =  getIterator(xs);
    int min = current(ixs); 
    while(!atEnd(ixs)){
        min = min < current(ixs) ? min : current(ixs);
        Next(ixs);
    }
    DisposeIterator(ixs);
    return min; 

}

LinkedList copy(LinkedList xs){
//Dada una lista genera otra con los mismos elementos, en el mismo orden.
//Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
    ListIterator ixs =  getIterator(xs);
    LinkedList nuevaLista = nil(); 
    while(!atEnd(ixs)){
        Snoc(current(ixs),nuevaLista);
        Next(ixs);
    }
    DisposeIterator(ixs);
    return nuevaLista; 
}

void Append(LinkedList xs, LinkedList ys){
// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
// Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
    ListIterator ixs =  getIterator(ys);
    while(!atEnd(ixs)){
        Snoc(current(ixs),xs);
        Next(ixs);
    }
    DisposeIterator(ixs);
}

int main(){
    
    // lista con cons
    LinkedList xs = nil();
    Cons(10,xs);
    Cons(100,xs); 
    Cons(1000,xs); 
    Cons(10000,xs); 
    cout<<head(xs)<<endl; // da 10000 

    cout<<"La sumatoria de xs es: " << sumatoria(xs)<<endl; 
 
    //booleanos 
    cout<<"Existe 100 en xs? Respuesta: 1 == " << pertenece(100,xs) <<endl;
    cout<<"Existe 99 en xs? Respuesta: 0 == " << pertenece(99,xs) <<endl;
 
    //minimo
    cout<< "El minimo de xs es 10 == " << minimo(xs) <<endl; 

    //apariciones
    cout<< "Las apariciones de 10 son una: " << apariciones(10,xs) << endl;
    cout<<"Pero de 100000 son 0 porque no existe: " << apariciones(100000,xs) << endl; 

    //copia 
    LinkedList ys = copy(xs);
    cout<<"La sumatoria de ys es igual a la de xs " << sumatoria(ys)<<  " == " << sumatoria(xs) << endl; 

    //append 
     Append(xs,ys);
    cout << "La sumatoria del append entre xs e ys deberia de ser igual a la suma de sus sumatorias por separado, osea " 
    << sumatoria(ys) + sumatoria(ys) << " == " << sumatoria(xs) <<endl;  
                //uso ys ya que es igual a xs porque en el Append se modifica xs. 

    //sucesores 
    Sucesores(xs);
    cout<<"La sumatoria despues de hacer Sucesores sobre xs luego del Append con ys(su copia) seria: " << sumatoria(xs)<<endl; 

}