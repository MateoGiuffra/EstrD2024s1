#include "tree.h"
#include <iostream>
#include <cstddef>
using namespace std; 
// struct NodeT {
//     int elem;
//     NodeT* left;
//     NodeT* right;
// };

// typedef NodeT* Tree;

Tree emptyT() {
    return NULL; 
}

Tree nodeT(int elem, Tree left, Tree right) {
    Tree t = new NodeT;
    t->elem = elem; t->left = left; t->right = right; 
    return t;  
}

bool isEmptyT(Tree t) {
    return (t == NULL); 
}

int rootT(Tree t) {
    return t->elem; 
}

Tree left(Tree t) {
    return t->left; 
}

Tree right(Tree t) {
    return t->right; 
}

// int main() {
//     Tree t = nodeT(1, nodeT(2, emptyT(), emptyT()), nodeT(3, emptyT(), emptyT()));
    
//     if (!isEmptyT(t)) {
//         cout << "Raiz: " << rootT(t) << endl;
//         cout << "Izquierda: " << rootT(left(t)) << endl;
//         cout << "Derecha: " << rootT(right(t)) << endl;
//     }

//     return 0;
// }