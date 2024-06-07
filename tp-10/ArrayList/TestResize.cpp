#include <iostream>
#include "ArrayList.h"
using namespace std;

int main(){
    
    
    // SetUp
    ArrayList arrayTest = newArrayList();
    add(100,arrayTest);
    add(150,arrayTest);
    add(200,arrayTest);


    cout << "Se agregan los elementos 200, 250, 300 al ArrayList." <<endl;
    add(200,arrayTest);
    add(250,arrayTest);
    add(300,arrayTest);
    cout<< "por ende esto deberia de ser cierto 5 == " << lengthAL(arrayTest) <<endl; 
    cout << "La capacidad del arrayTest es de: " << arrayTest->capacidad << "." << endl;  
    cout << "Antes de un resize de 2, si yo pido el indice 1 me da: " << get(1,arrayTest) <<endl;
    resize(2,arrayTest); 
    cout << "Despues de un resize a 2, la capacidad es de: " << arrayTest->capacidad << "." << endl;
    cout << " Me deberia poder mostrar que hay en el indice 1: " << get(1,arrayTest) << " Pero no del indice 4: " << get(4,arrayTest) << endl; 

}