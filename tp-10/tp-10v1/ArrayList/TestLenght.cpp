#include <iostream>
#include "ArrayList.h"
using namespace std;


int main(){
    
    ArrayList arrayTest = newArrayList();
    cout<< lengthAL(arrayTest) << endl; // deberia de dar 0  | True
    add(100,arrayTest);
    add(150,arrayTest);
    add(200,arrayTest);
    cout<< lengthAL(arrayTest) << endl; // deberia de dar 3  | True
    cout<< lengthAL(arrayTest) << endl; // deberia de dar 2  | True
}