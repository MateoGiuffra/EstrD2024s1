#include <iostream>
#include "ArrayList.h"
using namespace std;

// struct ArrayListSt {
// int cantidad; // cantidad de elementos
// int* elementos; // array de elementos
// int capacidad; // tamaño del array
// }
// typedef ArrayListSt* ArrayList;
//Definir la siguiente interfaz de este tipo de listas:

ArrayList newArrayList(){
// Crea una lista con 0 elementos.
// Nota: empezar el array list con capacidad 16.
    ArrayListSt* al = new ArrayListSt();
    al->capacidad = 16; al->cantidad = 0; 
    int* alist = new int[al->capacidad]; 
    al->elementos = alist; 
    return al;
}
ArrayList newArrayListWith(int capacidad){
// Crea una lista con 0 elementos y una capacidad dada por parámetro.
    ArrayList al = newArrayList();
    al->capacidad = capacidad; 
    return al; 
}
int lengthAL(ArrayList xs){
// Devuelve la cantidad de elementos existentes.
    return xs->cantidad; 
}
int get(int i, ArrayList xs){
// Devuelve el _ elemento de la lista.
    if  (i>=0 && i < xs->cantidad){
        return xs->elementos[i];
    }
    cout << "Indice invalido."<<endl;
    //exit(1); 
}
void set(int i, int x, ArrayList xs){
// Reemplaza el _ elemento por otro dado.
    if (i > 0 && i < xs->capacidad){
        xs->elementos[i] = x; 
    }
}
void resize(int capacidad, ArrayList xs){
// Decrementa o aumenta la capacidad del array.
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.
        int* resizeList = new int[capacidad]; 
        if(xs->capacidad <= capacidad){
            //incrementar 
            for (int i =0; i < xs->cantidad; i++){
                resizeList[i] = xs->elementos[i];
            }//la cantidad queda igual
        }else{
            //decrementar 
            int cantidadNueva = xs->cantidad < capacidad ? xs->cantidad : capacidad;  //el minimo entre la capacidad y la cantidad de elementos. 
            for (int i =0; i < cantidadNueva; i++){
                resizeList[i] = xs->elementos[i];
            }
            xs->cantidad  = cantidadNueva;
        }
        xs->capacidad = capacidad;      // cargas nueva capacidad
        xs->elementos = resizeList;     // cargas la lista hasta la capacidad disponible
        delete[] xs->elementos;

}


void add(int x, ArrayList xs){
// Agrega un elemento al final de la lista.
    if (xs->capacidad == xs->cantidad){
        resize(xs->capacidad*2,xs);
    }else{
        xs->elementos[xs->cantidad] = x;
        xs->cantidad++;
    }
}


void remove(ArrayList xs){
// Borra el último elemento de la lista
    if (xs->cantidad > 0){
        xs->cantidad --; 
        for (int i = xs->cantidad +1; i < xs->capacidad; i++){
          xs->elementos[i-1] = xs->elementos[i]; 
        }
    }else{
        cout <<"La lista esta vacia"<<endl;
    }
    
}


int main(){
    ArrayList arrayTest = newArrayList();
    cout<< lengthAL(arrayTest) << endl; // deberia de dar 0  | True
    add(100,arrayTest);
    add(150,arrayTest);
    add(200,arrayTest);
    cout<< lengthAL(arrayTest) << endl; // deberia de dar 3  | True
    cout<< lengthAL(arrayTest) << endl; // deberia de dar 2  | True
    
    cout << "El indice 0 vale:" <<get(0,arrayTest) <<endl;    // deberia de dar 100
    cout << "El indice 1 vale:" <<get(1,arrayTest) <<endl;    // deberia de dar 150
    cout << "El indice 2 vale:" <<get(2,arrayTest) <<endl;    // deberia de dar 200
    // cout << "El indice 3 vale:" <<get(3,arrayTest) <<endl;    // no deberia de dar nada, porque solo se agregaron 3 elementos. 
    remove(arrayTest);
    cout << "Despues de borrar el ultimo elemento del ArrayList quedaria:" <<endl; 
    cout << "El indice 0 vale:" <<get(0,arrayTest) <<endl;    // deberia de dar 100
    cout << "El indice 1 vale:" <<get(1,arrayTest) <<endl;    // deberia de dar 150
    cout << "El indice 2 vale:" <<get(2,arrayTest) <<endl;    // no deberia de dar nada, porque se borro el ultimo elemento. 
    //cout << "El indice 3 vale:" <<get(3,arrayTest) <<endl;    // no deberia de dar nada, porque solo hay 2. 

    cout << "Se agregan los elementos 200, 250, 300 al ArrayList." <<endl;
    add(200,arrayTest);
    add(250,arrayTest);
    add(300,arrayTest);
    cout<< "por ende esto deberia de ser cierto 5 == " << lengthAL(arrayTest) <<endl; 
    cout << "La capacidad del arrayTest es de: " << arrayTest->capacidad << "." << endl;  
    resize(2,arrayTest); 
    cout << "Despues de un resize a 2, la capacidad es de: " << arrayTest->capacidad << "." << endl;
    cout << "Y no deberia de mostrarme que hay en el indice 4: " << get(4,arrayTest) << " Pero si del 1: " << get(1,arrayTest) <<endl; 

    

}