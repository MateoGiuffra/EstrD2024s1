#include "LinkedList.h"
#include <iostream>
using namespace std;
 
int main(){ 
    LinkedList l = nil();  
    Cons(3,l);
    Cons(2,l);
    Cons(1,l); // esto es igual a [3,2,1] 

    cout<<"La long de l es: " << length(l)<<endl; 
    cout<<"El primer elem de l es: " <<head(l)<<endl;
    Tail(l);
    cout<<"La long de l es: " <<length(l)<<endl;
    cout<<"El primer elem de l  es: " << head(l)<<endl; 
    DestroyL(l);
    cout<<"El primer elem de l  es: " << head(l)<<endl; 
    return 0; 
}