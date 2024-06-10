#include "Tree.h"
#include "ArrayList.h"
#include "ArrayListEjercicios.h"
#include <iostream>
#include <cstddef>
using namespace std; 

// Suma de todos los elementos del árbol
int sumarT(Tree t) {
    int suma = 0; 
    if (!isEmptyT(t)){
        suma += rootT(t) + sumarT(left(t)) + sumarT(right(t));   
    }
    return suma; 
}

// Tamaño del árbol (cantidad de elementos)
int sizeT(Tree t) {
    int suma = 0; 
    if (!isEmptyT(t)){
        suma += 1 + sizeT(left(t)) + sizeT(right(t));   
    }
    return suma; 
}

// Verifica si un elemento pertenece al árbol
bool perteneceT(int e, Tree t) {
    if (isEmptyT(t)){
        return false; 
    }else{
        return rootT(t) == e || perteneceT(e,left(t)) || perteneceT(e,right(t));
    }
}

// Cuenta las apariciones de un elemento en el árbol
int aparicionesT(int e, Tree t) {
    int apariciones = 0; 
    if (!isEmptyT(t)){
        if (e == rootT(t)){
            apariciones += 1 + aparicionesT(e,left(t)) + aparicionesT(e,right(t));
        }
    }
    return apariciones; 
}

// Altura del árbol
int heightT(Tree t) { 
    if (!isEmptyT(t)){
        return (1 + max(heightT(left(t)),heightT(right(t))));   
    } 
    return -1;
}

ArrayList toList(Tree t) {
    ArrayList list = newArrayList();
    if (!isEmptyT(t)){
        list = append(newArrayListWith(rootT(t)), append(toList(left(t)), toList(right(t))));
    }
    return list;
}

// Devuelve una lista con todos los elementos del árbol
// ArrayList toList(Tree t) {
//     ArrayList list = newArrayList();
//     if (!isEmptyT(t)){
//         add(rootT(t), append(toList(left(t)), toList(right(t))));
//     }
//     return list;
// }



// // Devuelve una lista con los elementos de las hojas del árbol
// ArrayListLeaves(Tree t) {
//     // Implementación pendiente
// }

// // Devuelve una lista con los nodos de nivel n
// ArrayList levelN(int n, Tree t) {
//     // Implementación pendiente
// }
//para que compile: g++ -o programa ArrayListEjercicios.cpp ArrayList.cpp TreeEjercicios.cpp Tree.cpp -std=c++11

int main(){
    Tree leftSubtree = nodeT(100, emptyT(), emptyT());
    Tree rightSubtree = nodeT(200, emptyT(), emptyT());
    Tree t = nodeT(10, leftSubtree, rightSubtree);
    
    cout << "Sum of elements: " << sumarT(t) << endl;
    cout << "Size of 3 elements tree is of : " << sizeT(t) << endl;
    cout << "10 belongs in Tree 1 : " << perteneceT(10,t) << endl;
    cout << "Appareances of 10 are 1: " << aparicionesT(10,t) << endl;
    cout << "Height of Tree is 1: " << heightT(t) << endl;
    ArrayList arrayt =  toList(t);
    cout << sumatoria(arrayt ) <<endl;

    return 0;
}