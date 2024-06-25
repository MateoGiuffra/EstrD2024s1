// Dictionary.cpp
#include "Dictionary.h"
#include <iostream>
#include <cstring>
using namespace std; 
/*
    INV REP Dictionary
        * Size es la cantidad de keys o de values en sus arrays. 
        * Keys y Values tienen la misma cantidad de elementos. 
        * Las keys son univocas y cada key esta asociada a un valor.
        * Cada valor esta asociado a un key.  
        * Size no puede ser mayor a maxSize. 
        * DictionaryStruct, keys y values no son punteros a NULL;
*/

// Por ejemplo:
Dictionary createDictionary(int maxSize) {
// Función para crear un diccionario con una capacidad máxima especificada
// Precondición: maxSize > 0
// Propósito: Crear un diccionario vacío con capacidad para maxSize elementos
// Eficiencia: O(1)
    Dictionary d = new DictionaryStruct;
    d->maxSize = maxSize;
    d->size = 0;
    d->keys = new char*[maxSize];
    d->values = new int[maxSize];
    return d;
}


void destroyDictionary(Dictionary d){
// Función para destruir el diccionario y liberar la memoria asignada
// Precondición: dict no es NULL
// Propósito: Liberar la memoria utilizada por el diccionario
// Eficiencia: O(n)

    for (int i = 0;  i<d->size; i++){
        delete[] d->keys[i]; 
    }
    delete[] d->values; 
    delete[] d->keys;
    delete d;  
}
void aumentarEspacio(Dictionary d){
    //Proposito: Aumenta el espacio del diccionario dado por 2.
    d->maxSize = d->maxSize*2;
    char** newKeys = new char*[d->maxSize];
    int* newValues = new int[d->maxSize];
    for (int i = 0; i < d->size; i++){
        newKeys[i] = new char[strlen(d->keys[i])+1]; // +1 por el caracter nulo al final del array de char
        strcpy (newKeys[i],d->keys[i]);
        newValues[i] = d->values[i];
    }  
    for (int ii = 0;  ii<d->size; ii++){
        delete[] d->keys[ii]; 
    }
    delete[] d->values; 
    delete[] d->keys; 
    d->values = newValues; 
    d->keys = newKeys; 

}
// Función para agregar una clave y su valor asociado al diccionario
// Precondición: dict no es NULL, key no es NULL, dict no está lleno
// Propósito: Insertar un nuevo par clave-valor en el diccionario
// Eficiencia: O(n) en el peor caso (si se verifica la existencia de la clave)
void add(Dictionary dict, const char* key, int value){
    if(dict->maxSize == dict->size) aumentarEspacio(dict); 
    int i = 0; 
    while(i < dict->size && strcmp (key,dict->keys[i]) != 0 ){
        i++; 
    }//si no existe significa que i es igual a la cantidad
    if (i == dict->size){
        dict->keys[i] = new char[strlen(key) + 1];
        strcpy(dict->keys[i], key);
        dict->values[i] = value;  
        dict->size++; 
    }
}

int get(Dictionary dict, const char* key){
// Función para obtener el valor asociado a una clave específica
// Precondición: dict no es NULL, key no es NULL
// Propósito: Devolver el valor asociado a la clave dada
// Eficiencia: O(n) en el peor caso
    int i = 0; 
    while(i < dict->size && strcmp (key,dict->keys[i]) != 0 ){
        i++; 
    }
    if (i != dict->size){
        return dict->values[i];
    }else{
    throw runtime_error("No se encuentra en el diccionario"); 
    }
}

// Función para verificar si una clave existe en el diccionario
// Precondición: dict no es NULL, key no es NULL
// Propósito: Comprobar si la clave está presente en el diccionario
// Eficiencia: O(n) en el peor caso
bool contains(Dictionary dict, const char* key){
    int i = 0; 
    while(i < dict->size && strcmp (key,dict->keys[i]) != 0 ){
        i++; 
    }
    return i != dict->size; 
}

// Función para eliminar una clave y su valor asociado del diccionario
// Precondición: dict no es NULL, key no es NULL
// Propósito: Remover el par clave-valor del diccionario
// Eficiencia: O(n) en el peor caso
void removeKey(Dictionary dict, const char* key){
    int i =0; 
    while(i < dict->size && strcmp (key,dict->keys[i]) != 0 ){
        i++; 
    }
    if (i == dict->size) return;
    delete[] dict->keys[i]; 
    dict->size--;   
    for (int j = i; j < dict->size; j++){
        dict->keys[j] = dict->keys[j+1] ;
        dict->values[j] = dict->values[j+1];
    }
}

int main(){
    Dictionary d = createDictionary(16);

    add(d,"Clave que esta asociada a 100", 100); 
    add(d,"Clave que esta asociada a 200", 200);
    cout <<  get(d,"Clave que esta asociada a 200") << endl;
    cout <<  contains(d,"Clave que esta asociada a 200") << endl;
    cout <<  contains(d,"Clave que esta asociada a 300") << endl;
    return 0;
}
