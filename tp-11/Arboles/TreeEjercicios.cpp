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

ArrayList toList(Tree t){
    
    ArrayList array = newArrayList(); 
    if (!isEmptyT(t)){
        add(rootT(t),array);
        array = append(array,(append(toList(left(t)), (toList(right(t)))))); 
    }
    return array; 

}

// Devuelve una lista con los elementos de las hojas del árbol
// ArrayList leaves(Tree t) {
//     ArrayList hojas = newArrayList(); 
//     if(!isEmptyT(t)){
//         if (isEmptyT(left(t)) && isEmptyT(right(t))  ){
//             add(rootT(t),hojas); 
//             hojas =  append(hojas,(append(leaves(left(t)),leaves(right(t)))));
//         }
//     }
//     return hojas;
// }

// // Devuelve una lista con los nodos de nivel n
// ArrayList levelN(int n, Tree t) {
//     // Implementación pendiente
// }

int main() {
    Tree leftSubtree = nodeT(100, emptyT(), emptyT());
    Tree rightSubtree = nodeT(200, emptyT(), emptyT());
    Tree t = nodeT(10, leftSubtree, rightSubtree);
    
    cout << "Sum of elements: " << sumarT(t) << endl;
    cout << "Size of tree: " << sizeT(t) << endl;
    cout << "10 belongs in Tree: " << perteneceT(10, t) << endl;
    cout << "Appearances of 10: " << aparicionesT(10, t) << endl;
    cout << "Height of Tree: " << heightT(t) << endl;

    ArrayList arrayt = toList(t);
    cout << "Sum of elements in list: " << sumatoria(arrayt) << endl;

    return 0;
}