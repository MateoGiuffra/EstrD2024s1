#include <iostream>

using namespace std;

// Ejercicio 2
// Indicar el // Proposito de los siguientes procedimientos o funciones, dando algunos ejemplos de uso
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
// unsigned long long int es para que soporte numeros grandes. 
unsigned long long int fc(unsigned long long int n) {
unsigned long long int x = 1;
while(n > 0) {
x = x * n;
n--;

cout << x << " "; 

}
return x;
}


// Precondición: n <= m
// Proposito: Suma n con su sucesor hasta que sea igual a m. 
// ft(1,5) => 15 # ya que se hace
// 1 + 2 + 3 + 4 + 5 => 15 # suma el n actual con su sucesor y para en 5(m).   
int ft(int n, int m) {
if (n == m) {
return n;

}
return n + ft(n+1, m);
}


// Dar dos implementaciones para las siguientes funciones, una iterativa y otra recursiva, y utilizando
// la menor cantidad posible de variables. Recordar definir subtareas en caso de que sea estrictamente
// necesario.

// ITERATIVA:
void printN(int n, string s){
// Proposito: imprime n veces un string s.
    int i;
    for (i = 0; i == n; i++){
        cout << s << "" ""; 
    }
}

void cuentaRegresiva(int n){
    // Proposito: imprime los números desde n hasta 0, separados por saltos de línea.
    int i;
    for (i = n; i >= 0; i--){
        cout << i << endl; 
        
    }
}


void desdeCeroHastaN(int n){
// Proposito: imprime los números de 0 hasta n, separados por saltos de línea.
    int i;
    for (i = 0; i <= n; i++){
        cout << i << " "; 
    }
}




int mult(int n, int m){
// Proposito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
// Precondicion: Los numeros deben ser positivos. 
    
    int i;
    if (m == 0 || n == 0){// si alguno es 0 entonces da 0 
        return 0;
    }
    
    int c = 0;
    for (i = 0; i < m; i++){// si no, sumo n a si mismo hasta que i sea igual a m. 
    c +=n;
    }
    
    return c;
}
void primerosN(int n, string s){
// Proposito: imprime los primeros n char del string s, separados por un salto de línea.
// Precondición: el string tiene al menos n char.
    int i;
    for (i = 0 ;i <  n; i++){
        cout << s[i] << " "; 
    }
}

bool pertenece(char c, string s){
// Proposito: indica si un char c aparece en el string s.
    int i = 0;
    while (i != s.length() && !(s[i] == c)){
            i++;
    } 
    return (i != s.length());
}

int apariciones(char c, string s){
// Proposito: devuelve la cantidad de apariciones de un char c en el string s.
    int appearances = 0;
    int i;
    for (i = 0; i < s.length();i++){
        if ((s[i] == c)){
            appearances ++;
        } 

    }
    return appearances;
}




// RECURSIVA:
void printNR(int n, string s){
    // Proposito imprime n veces un string s.
    if (n <= 0) {
        return;
    }
    cout << s << endl;
    printNR ((n-1),s);
}



void cuentaRegresivaR(int n){
// Proposito imprime los números desde n hasta 0, separados por saltos de línea.
    if (n < 0){
        return;
    }
    cout << n << endl;
    cuentaRegresivaR(n-1);
}

void desdeCeroHastaNR(int n){
// Proposito imprime los números de 0 hasta n, separados por saltos de línea.
    int r = 0;
    if (r == n){
        return; 
    }
    cout << n << " ";
    desdeCeroHastaNR(n-1);
}
int multR(int n, int m){
//Proposito realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
    if (m == 0){
        return 0;
    }
    if (m == 1){
        return n;
    }
    return n + multR (n, m-1);
} 


void primerosNR(int n, string s){
// Proposito imprime los primeros n char del string s, separados por un salto de línea.
// Precondición: el string tiene al menos n char.
    if (n <= 0){
        return; 
    }
    cout << char (s[n]) << " " ; 
    primerosNR((n-1),s);
}


// bool pertenece(char c, string s){
// // Proposito indica si un char c aparece en el string s.
//     if (s.length()>= 0){
//         return false;
//     }
//     return c == s[0] || pertenece(c, s); 

// }

// int apariciones(char c, string s)
// // Proposito devuelve la cantidad de apariciones de un char c en el string s.


int ftt(int n, int m){


    int r = 0;
    for (int i=0;i<= m; i++){
        r += i;
    }
    return r; 
}


int main(){
    
    string s ="Hola";
    int n = 10;
    cout << ftt(1,5) << endl;
}

