#include <iostream>
#include "ArrayList.h"
using namespace std;


int main(){

    // SetUp
    ArrayList arrayTest = newArrayList();
    add(100,arrayTest);
    add(150,arrayTest);
    add(200,arrayTest);

    remove(arrayTest);
    cout << "Despues de borrar el ultimo elemento del ArrayList quedaria:" <<endl; 
    cout << "El indice 0 vale:" <<get(0,arrayTest) <<endl;    // deberia de dar 100
    cout << "El indice 1 vale:" <<get(1,arrayTest) <<endl;    // deberia de dar 150
    cout << "El indice 2 vale:" <<get(2,arrayTest) <<endl;    // no deberia de dar nada, porque se borro el ultimo elemento. 
    cout << "El indice 3 vale:" <<get(3,arrayTest) <<endl;    // no deberia de ejecutarse 
}