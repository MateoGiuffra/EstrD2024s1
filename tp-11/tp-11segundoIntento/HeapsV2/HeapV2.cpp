#include <limits.h>
#include "HeapV2.h"
#include <iostream>
using namespace std; 
struct BinHeapHeaderSt{
    int* elementos; 
    int maxSize; 
    int currentSize; 
}; 
typedef BinHeapHeaderSt* BinHeap; 

BinHeap emptyHeap(){
    BinHeap h = new BinHeapHeaderSt; 
    h->currentSize = 0; h->maxSize = 16;
    h->elementos = new int[h->maxSize]; 
    h->elementos[0] = INT_MIN;
    return h;  
}

int  findMin(BinHeap h){
    if(h->currentSize == 0){
    throw runtime_error("La heap esta vacia");
    }    
    return h->elementos[1]; 
}
bool isEmptyH(BinHeap h){
    return h->currentSize == 0; 
}
void aumentarEspacio(BinHeap h){
    h->maxSize =  h->maxSize *2; 
    int* newElems = new int[h->maxSize];
    for (int i = 1; i<h->currentSize; i++){
        newElems[i] = h->elementos[i];
    }
    delete h->elementos;
    h->elementos = newElems; 
}

void insertH(int x, BinHeap h){
    if (h->maxSize == h->currentSize) aumentarEspacio(h); 
    h->currentSize++; 
    int pos = h->currentSize;  
    while(x < h->elementos[pos/2]){
            h->elementos[pos] = h->elementos[pos/2];
            pos /= 2; 
    }
    h->elementos[pos] = x; 

}




// BinHeap crearHeap(int* elems, int cant){
//     BinHeapHeaderSt* h = new BinHeapHeaderSt;
//     h->maxSize = cant*2;
//     h->currentSize = cant; 
//     h->elementos = new int[cant];
//     for (int i = 1; i<h->currentSize; i++){
//         h->elementos[i] = elems[i-1];
//     }
//     int pos = h->currentSize;  


//     for (int indice = 1; indice < h->currentSize; indice++){
//         int nuevo = h->elementos[indice];
//            while(nuevo < h->elementos[pos/2]){
//             nuevo = h->elementos[indice];
//             h->elementos[pos] = h->elementos[pos/2];
//             pos /= 2; 
            
//     }
//     h->elementos[pos] = nuevo; 
//     }
 
//     return h;
// }

BinHeap crearHeap(int* elems, int cant){
    BinHeapHeaderSt* h = new BinHeapHeaderSt;
    h->maxSize = cant*2;
    h->currentSize = cant; 
    h->elementos = new int[cant];
    int pos = h->currentSize;  
    for (int i = 1; i<h->currentSize; i++){
        h->elementos[i] = elems[i-1];
        int nuevo = elems[i-1];
            while(nuevo < h->elementos[pos/2]){
                h->elementos[pos] = h->elementos[pos/2];
                pos /= 2; 
                nuevo = elems[i-1];
            }
        h->elementos[pos] = nuevo; 
    }
    

 
    return h;
}


void deleteMin(BinHeap h) {
    if (h->currentSize == 0) return;

    int last = h->elementos[h->currentSize--];
    int pos = 1;
    int child;

    while (pos * 2 <= h->currentSize) {
        child = pos * 2;
        // Si el hijo derecho existe y es menor que el hijo izquierdo
        if (child != h->currentSize && h->elementos[child + 1] < h->elementos[child]) {
            child++;
        }
        // Si el último elemento es menor que el hijo más pequeño, estamos hechos
        if (last <= h->elementos[child]) {
            break;
        }
        // Mover el hijo hacia arriba
        h->elementos[pos] = h->elementos[child];
        pos = child;
    }
    h->elementos[pos] = last;
}




int main(){
    BinHeap h = emptyHeap(); 
    insertH(10,h);
    insertH(3,h);
    insertH(8,h);    
    insertH(11,h);
    insertH(15,h);

    cout << findMin(h) <<endl; 
    deleteMin(h);
    cout << findMin(h) <<endl; 

    // BinHeap h2 = emptyHeap();
    int* arrayDeNumeros = new int[5]{3, 8, 11, 10, 15};
    BinHeap h3 = crearHeap(arrayDeNumeros,5);
    cout << findMin(h3) <<endl; 
    deleteMin(h3);
    cout << findMin(h3) <<endl; 
    // cout << findMin(h2) <<endl; 
}