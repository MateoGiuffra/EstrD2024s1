#include <iostream>
#include "ArrayList.h"

using namespace std;

int sumatoria(ArrayList xs) {
    // Devuelve la suma de todos los elementos.
    int suma = 0;
    for (int i = 0; i < lengthAL(xs); i++) {
        suma += get(i, xs);
    }
    return suma;
}

void sucesores(ArrayList xs) {
    // Incrementa en uno todos los elementos.
    for (int i = 0; i < lengthAL(xs); i++) {
        set(i, get(i, xs) + 1, xs);
    }
}

bool pertenece(int x, ArrayList xs) {
    // Indica si el elemento pertenece a la lista.
    int i = 0;
    while (i < lengthAL(xs) && get(i, xs) != x) {
        i++;
    }
    return i != lengthAL(xs);
}

int apariciones(int x, ArrayList xs) {
    // Indica la cantidad de elementos iguales a x.
    int counter = 0;
    for (int i = 0; i < lengthAL(xs); i++) {
        if (get(i, xs) == x) {
            counter++;
        }
    }
    return counter;
}

ArrayList append(ArrayList xs, ArrayList ys) {
    // Crea una nueva lista a partir de la primera y la segunda (en ese orden)
    ArrayList nuevaArray = newArrayListWith(lengthAL(xs) + lengthAL(ys));
    for (int i = 0; i < lengthAL(xs); i++) {
        add(get(i, xs), nuevaArray);
    }
    for (int i = 0; i < lengthAL(ys); i++) {
        add(get(i, ys), nuevaArray);
    }
    return nuevaArray;
}

int minimo(ArrayList xs) {
    // Devuelve el elemento más chico de la lista
    int min = get(0, xs);
    for (int i = 1; i < lengthAL(xs); i++) {
        if (get(i, xs) < min) {
            min = get(i, xs);
        }
    }
    return min;
}

int main() {
    //SetUp
    ArrayList array = newArrayList();
    add(10, array);
    add(100, array);
    add(1000, array);

    //Exercise 
    cout << "Sumatoria: " << sumatoria(array) << endl;  // deberia de dar 1110 
    cout << "Minimo: " << minimo(array) << endl;        // deberia de dar 10 

    ArrayList array2 = newArrayList();
    add(5, array2);
    add(15, array2);

    ArrayList combinado = append(array, array2); 
    cout << "Sumatoria del combinado: " << sumatoria(combinado) << endl; // deberia de dar la suma de 1110 + 5 + 15 = 1130 

    sucesores(array);
    cout << "Sumatoria despues de sucesores: " << sumatoria(array) << endl; //deberia de dar 11 + 101+ 1001 = 1112
    return 0;
}
