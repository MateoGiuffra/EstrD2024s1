
// Dada la siguiente representación de listas, llamada ArrayList:

struct ArrayListSt {
int cantidad; // cantidad de elementos
int* elementos; // array de elementos
int capacidad; // tamaño del array
};
typedef ArrayListSt* ArrayList;
//Definir la siguiente interfaz de este tipo de listas:
ArrayList newArrayList();
// Crea una lista con 0 elementos.;
// Nota: empezar el array list con capacidad 16.;
ArrayList newArrayListWith(int capacidad);
// Crea una lista con 0 elementos y una capacidad dada por parámetro.;
int lengthAL(ArrayList xs);
// Devuelve la cantidad de elementos existentes.;
int get(int i, ArrayList xs);
// Devuelve el iesimo elemento de la lista.;
void set(int i, int x, ArrayList xs);
// Reemplaza el iesimo elemento por otro dado.;
void resize(int capacidad, ArrayList xs);
// Decrementa o aumenta la capacidad del array.;
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.;
void add(int x, ArrayList xs);
// Agrega un elemento al final de la lista.;
void remove(ArrayList xs);
// Borra el último elemento de la lista 
