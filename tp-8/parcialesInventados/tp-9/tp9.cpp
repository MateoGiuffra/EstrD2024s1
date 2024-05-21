#include <iostream>

using namespace std;

// Ejercicio 2
// Indicar el propósito de los siguientes procedimientos o funciones, dando algunos ejemplos de uso
// junto con su resultado. Considerar el consumo de memoria de cada programa, y si puede mejorarse.

 // Precondición: c1 < c2
 // Proposito: Dado dos char, devuelve los numeros representantes de ese char hasta el segundo char.
 // Ejemplo: printFromTo('a','c') => 97,98,99, 
 //                                  97 es a ->  98 es b -> 99 es c.
 // Costo: Constante.

void printFromTo(char c1, char c2) {
for(int i = 0; c1 + i <= c2; i++) {
cout << c1 + i << ", ";
}
cout << endl;
}

// Precondición: n >= 0
// PROPOSITO: Describe el factorial del numero dado. 
// 
long int fc(long int n) {
long int x = 1;
while(n > 0) {
x = x * n;
n--;

cout << x << " "; 

}
return x;
}


// Precondición: n <= m
// Proposito: Suma n con su sucesor hasta que sea igual a m
int ft(int n, int m) {
if (n == m) {
return n;
}
return n + ft(n+1, m);
}


int main(){
    int n = 3;
    //int r = fc(n);
    cout << ft(2,6) << endl;
    //cout << r << endl;
    //cout << c1 << endl;
}


