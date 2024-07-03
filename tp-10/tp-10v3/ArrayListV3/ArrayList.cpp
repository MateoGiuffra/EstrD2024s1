#include "ArrayList.h" 
#include <iostream>
#include <stdexcept>
using namespace std; 

// ================================================================================================================================================================================================
// IMPLEMENTACION              IMPLEMENTACION              IMPLEMENTACION              IMPLEMENTACION              IMPLEMENTACION 
// ================================================================================================================================================================================================

struct ArrayListSt {
/*INV.REP: 
    * cantidad de ser la cantidad de elementos que posee la estructura.
    * cantidad no debe ser mayor a capacidad. 
    * cantidad y capacidad no pueden ser negativos. 
*/
int cantidad; // cantidad de elementos
int* elementos; // array de elementos
int capacidad; // tamaño del array
};



ArrayList newArrayList(){
// Crea una lista con 0 elementos.
// Nota: empezar el array list con capacidad 16.
    ArrayList xs = new ArrayListSt; 
    xs->cantidad = 0; 
    xs->capacidad = 16; 
    xs->elementos = new int[xs->capacidad];
    return xs; 
}
ArrayList newArrayListWith(int capacidad){
// Crea una lista con 0 elementos y una capacidad dada por parámetro.
// PRECONDICION: La capacidad no puede ser menor a 0. 
    ArrayList xs = new ArrayListSt; 
    xs->cantidad = 0; 
    xs->capacidad = capacidad; 
    xs->elementos = new int[0 < capacidad ? capacidad : 0];
    return xs;  
}
int lengthAL(ArrayList xs){
// Devuelve la cantidad de elementos existentes.
    return xs->cantidad; 
}
int get(int i, ArrayList xs){
// Devuelve el iésimo elemento de la lista.
    if (i < 0 || i > xs->cantidad) throw runtime_error("Numero fuera de rango"); 
    return xs->elementos[i]; 
}
void set(int i, int x, ArrayList xs){
// Reemplaza el iésimo elemento por otro dado.
    if (i < 0 || i > xs->cantidad + 1) throw runtime_error("Numero fuera de rango"); 
    xs->elementos[i] = x; 
}
void resize(int capacidad, ArrayList xs){
// Decrementa o aumenta la capacidad del array.
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.
    if(capacidad >= xs->cantidad){
        xs->capacidad = capacidad; return; 
    }
    xs->capacidad = capacidad;
    int* elemsN = new int[xs->capacidad];
    int i = 0;
    while (i<capacidad){
        elemsN[i] = xs->elementos[i]; 
        i++;
    }
    delete[] xs->elementos; 
    xs->elementos = elemsN; 
    xs->cantidad = i; 
} 
void add(int x, ArrayList xs){
// Agrega un elemento al final de la lista.
    if (xs->cantidad == xs->capacidad) xs->capacidad = xs->capacidad*2; 
    xs->elementos[xs->cantidad] = x; 
    xs->cantidad++;
 
}
void remove(ArrayList xs){
// Borra el último elemento de la lista.
    if (xs->cantidad == 0) return; 
    xs->cantidad--; 
    for (int i = xs->cantidad; i<xs->capacidad; i++){
        xs->elementos[i] = xs->elementos[i+1]; 
    }
}

void imprimirArray(ArrayList xs){
    if(xs->cantidad == 0){
    cout << "[]" <<endl; 
    }else{
    cout << "[";
    int i = 0; 
    while(i<xs->cantidad){
        if (i + 1 == xs->cantidad){
            cout << get(i,xs) << "]" <<endl;
        }else{
           cout << get(i,xs) << ", "; 
        }
        i++; 
        }
    } 
}

int main(){
    ArrayList xs = newArrayListWith(4);
    add(10,xs);
    add(20,xs);
    add(30,xs);
    cout << get(0,xs) <<endl; 
    cout << get(1,xs) <<endl; 
    cout << get(2,xs) <<endl; 
    cout << "Este array posee 3 elementos: " << endl; 
    imprimirArray(xs);

    remove(xs); //borre el 30
    cout << "Se removio el ultimo elemento, entonces el array queda: " << endl; 
    imprimirArray(xs);


    remove(xs); //borre el 20
    cout << "Se removio el ultimo elemento, entonces el array queda: " << endl; 
    imprimirArray(xs);

    
    remove(xs); //borre el 10
    cout << "Se removio el ultimo elemento, entonces el array queda: " << endl; 
    imprimirArray(xs);
        
    
    remove(xs); //borre una lista 
    cout << "Se removio el ultimo elemento, entonces el array queda: " << endl; 
    imprimirArray(xs);

    add(10,xs);
    add(20,xs);
    add(30,xs);
    add(40,xs);
    add(50,xs);
    add(60,xs);
    cout << "Se agregaronr 6 elementos al array, cuya capacidad era de 4, entonces ahora:  " << endl; 
    cout << "  * Su cantidad es " << xs->cantidad<<endl; 
    cout << "  * Su capacidad es " << xs->capacidad <<" ya que se duplico debido a que se agregaron mas elementos que su capacidad(4)." << endl; 
    cout << "El primer elemento seria: " << get(0,xs) <<endl; 
    cout << "El ultimo elemento seria el de la posicion 5: "<<  get(5,xs) << endl; 
    
    resize(3,xs);
    cout << "Despues de un resize, limitando la capacidad a 3, se pregunta de nuevo su:" <<endl; 
    cout << "  * Capacidad: "<< xs->capacidad <<endl;
    cout << "  * Cantidad:  " << xs->cantidad<<endl; 
    // get(6,xs); //resultado: terminate called after throwing an instance of 'std::runtime_error' what():  Numero fuera de rango
    cout << "El elemento en la posicion 0 seguiria siendo el mismo: " << get(0,xs) <<endl; 

    return 0; 
} 