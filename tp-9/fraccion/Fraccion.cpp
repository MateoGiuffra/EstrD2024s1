#include <iostream> 
#include "Fraccion.h"

using namespace std; 


Fraccion consFraccion(int numerador, int denominador){
// Propósito: construye una fraccion
// Precondición: el denominador no es cero
    Fraccion f; 
    f.numerador = numerador;
    f.denominador = denominador;
    return f;
}

int numerador(Fraccion f){
// Propósito: devuelve el numerador
    return f.numerador;
}

int denominador(Fraccion f){
// Propósito: devuelve el denominador
    return f.denominador; 
}

float division(Fraccion f){
// Propósito: devuelve el resultado de hacer la división
    return f.numerador / f.denominador;
}


Fraccion multF(Fraccion f1, Fraccion f2){
// Propósito: devuelve una fracción que resulta de multiplicar las fracciones
// (sin simplificar)
    Fraccion f;
    f.numerador = f1.numerador * f2.numerador;
    f.denominador = f1.denominador * f2.denominador;
    return f;
}

int minimoDivisorComun(int n, int m){
    int i = 2;
    while(n % i != 0 || m  % i != 0){         
        i++;
    }
    return i;
}


Fraccion simplificada(Fraccion p){                       
// Propósito: devuelve una fracción que resulta de simplificar la dada por parámetro
        Fraccion f; 
        int m =  p.numerador; 
        int n =  p.denominador;
        int d = minimoDivisorComun(m,n);
                            // si se puede seguir dividiendo a los dos
        while (n != 1 && (n % d == 0 && m % d == 0)){
            int d = minimoDivisorComun(m,n);
            m = m/d;
            n = n/d;
        }
        f.numerador   = m;
        f.denominador = n; 
        
        return f;     
}


int mcmDe(int n, int m){
    int i = 2;
    while (not ((i % n == 0) && (i % m == 0))  ){
        i++;
    } 
    return i;
}

Fraccion sumF(Fraccion f1, Fraccion f2){
// Propósito: devuelve la primera componente

    Fraccion f; 
    if (f1.denominador == f2.denominador){
        f.numerador   = f1.numerador + f2.numerador; 
        f.denominador = f1.denominador; 
        return f; 
    }
    int mcm = mcmDe(f1.denominador, f2.denominador);
    f.denominador = mcm;
    f.numerador   = ((mcm/f1.denominador) * f1.numerador) + ((mcm/f2.denominador) * f2.numerador) ;
    return f;  
}



int main(){
    Fraccion f1 = consFraccion(9,150);
    Fraccion f2 = consFraccion(15,2);
    Fraccion f  = simplificada(f1);
    cout << "El numerador es: " << numerador(f) << "  y el denominador es: " << denominador(f) <<endl;  
    cout << " " << numerador(f) << endl;
    cout << " -- " << endl; 
    cout << " " << denominador(f) << endl;
}
