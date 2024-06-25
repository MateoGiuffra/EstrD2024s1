#include "TreeV2.h"
#include "LinkedListTree.h"
#include "LinkedList.h"
#include <iostream>
using namespace std; 


void agregarSiNoEsNull(Tree t, TreeLinkedList xs){
    if(!isEmptyT(t)){
        Cons(t,xs);
    }
}

int sumarT(Tree t){
//Dado un árbol binario de enteros devuelve la suma entre sus elementos.
    int res = 0; 
    TreeLinkedList porProcesar = nil(); 
    agregarSiNoEsNull(t,porProcesar);
    Tree current;
    while (!isEmpty(porProcesar)){
        current = head(porProcesar);
        res += rootT(current);
        Tail(porProcesar); 
        agregarSiNoEsNull(left(current),porProcesar);
        agregarSiNoEsNull(right(current),porProcesar);
    }
    DestroyL(porProcesar);
    return res; 
}




int sizeT(Tree t){
//Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
    int size = 0; 
    TreeLinkedList porProcesar  = nil(); 
    agregarSiNoEsNull(t,porProcesar); 
    Tree current; 
    while(!isEmpty(porProcesar)){
        current = head(porProcesar); 
        Tail(porProcesar);
        size += 1; 
        agregarSiNoEsNull(left(current),porProcesar);
        agregarSiNoEsNull(right(current),porProcesar);
    }
    DestroyL(porProcesar);
    return size; 
}


bool perteneceT(int e, Tree t){
//Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
    if (isEmptyT(t)) return false; 
    TreeLinkedList porProcesar = nil(); 
    agregarSiNoEsNull(t,porProcesar); 
    Tree current = head(porProcesar);
    while(!isEmpty(porProcesar) && rootT(current) != e){
        current = head(porProcesar);
        Tail(porProcesar); 
        agregarSiNoEsNull(left(current),porProcesar);
        agregarSiNoEsNull(right(current),porProcesar);
    }
    return !isEmpty(porProcesar);
    DestroyL(porProcesar);
}
int aparicionesT(int e, Tree t){
//Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
        int apariciones = 0; 
    TreeLinkedList porProcesar  = nil(); 
    agregarSiNoEsNull(t,porProcesar); 
    Tree current; 
    while(!isEmpty(porProcesar)){
        current = head(porProcesar); 
        Tail(porProcesar);
        apariciones += e == rootT(current) ? 1 : 0; 
        agregarSiNoEsNull(left(current),porProcesar);
        agregarSiNoEsNull(right(current),porProcesar);
    }
    DestroyL(porProcesar);
    return apariciones; 
}

int heightT(Tree t){
//Dado un árbol devuelve su altura.
    if(isEmptyT(t)) return 0; 
    int alt = 0;
    alt = 1 + max (heightT(left(t)), heightT(right(t)));
    return alt; 
}

void agregarNodos(Tree t, LinkedList xs){
    TreeLinkedList porProcesar  = nil(); 
    agregarSiNoEsNull(t,porProcesar); 
    Tree current;
    while(!isEmpty(porProcesar)){
        current = head(porProcesar); 
        Tail(porProcesar);
        agregarSiNoEsNull(left(current),porProcesar);
        agregarSiNoEsNull(right(current),porProcesar);
        if(current != NULL){
            ConsL(rootT(current),xs);
        }
    }

}

LinkedList toList(Tree t){
//Dado un árbol devuelve una lista con todos sus elementos.
    LinkedList list = nilL();
    agregarNodos(t,list);
    return list;
}


void SnocLSiNoEsNull(Tree t, LinkedList xs){
    if(!isEmptyT(t)){
        SnocL(rootT(t),xs);
    }
}

void SnocSiNoEsNull(Tree t, LinkedList xs){
    if(!isEmptyT(t)){
        Snoc(t,xs);
    }
}

void levelNDe(int n, Tree t, LinkedList xs){
    if(isEmptyT(t) || n<0) return;
    if (n == 0){
         SnocLSiNoEsNull((t),xs);  
    }
    levelNDe(n-1,left(t),xs);
    levelNDe(n-1,right(t),xs);
}

LinkedList levelN(int n, Tree t){
//Dados un número n y un árbol devuelve una lista con los nodos de nivel n
    LinkedList xs = nilL();
    levelNDe(n,t,xs);
    return xs; 
}
void leavesDe(Tree t, LinkedList xs){
    if(isEmptyT(t)) return;
    if (isEmptyT(left(t)) && isEmptyT(right(t))){
         SnocLSiNoEsNull((t),xs);  
    }
    leavesDe(left(t),xs);
    leavesDe(right(t),xs);
}

LinkedList leaves(Tree t){
//Dado un árbol devuelve los elementos que se encuentran en sus hojas.
    LinkedList xs = nilL();
    leavesDe(t,xs);
    return xs; 
}

void imprimir(LinkedList xs){
// Devuelve la suma de todos los elementos.
    IteratorSt* i = getIterator(xs); 

    cout << "[" ;
    if(!atEnd(i)){
    while(!atEnd(i)){
        cout << (currentL(i)) ;
        NextIsEnd (i) ? cout << "" : cout << ", ";
        Next(i);
    }
    } 
    cout << "]" <<endl;
    DisposeIterator(i);

}





int main(){
    Tree t = nodeT (2, 
                (nodeT (4, emptyT(),emptyT())),
                (nodeT (6, emptyT(),emptyT())));
    
    cout << "sumarT: "<< sumarT(t)<<endl; 
    cout << "sizeT: " << sizeT(t) <<endl; 
    cout << "perteneceT: " << perteneceT(2,t) <<endl; 
    cout << "perteneceT: " << perteneceT(1,t) <<endl; 
    cout << "aparicionesT: " << aparicionesT(4,t) <<endl; 
    cout << "aparicionesT: " << aparicionesT(41,t) <<endl; 
    cout << "heightT: " << heightT(t) <<endl; 
    LinkedList list = toList(t); 
    cout << "imprimir de list es: ";
    imprimir(list);

    list = levelN(1,t);
    imprimir(list);
    list = levelN(0,t);
    imprimir(list);
    list = levelN(2,t);
    imprimir(list);
    list = levelN(3,t);
    imprimir(list);
    list = levelN(1,t);
    imprimir(list);
    list = leaves(t);
    cout << "leaves: "; 
    imprimir(list);
    Tree t2 = nodeT (2, 
                    (nodeT (4, emptyT(),emptyT())),
                    (nodeT (6, 
                        (nodeT (8, emptyT(),emptyT())),emptyT())));
    list = leaves(t2);
    cout << "leaves: "; 
    imprimir(list);
    return 0; 
}

// TreeLinkedList porProcesar = nil(); 
//         if(t != NULL){
//             Snoc(t,porProcesar);
//         }
//     Tree current; 
//     int count = n; 
//     while(!isEmpty(porProcesar) && count != 0){
//         count--; 
//         current = head(porProcesar); 
//         Tail(porProcesar);
//         current()
//         SnocLSiNoEsNull(left(current),xs);
//         SnocLSiNoEsNull(right(current),xs);
//         SnocSiNoEsNull(left(current),porProcesar);
//         SnocSiNoEsNull(right(current),porProcesar);
//     }