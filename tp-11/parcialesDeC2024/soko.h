#include <iostream>
using namespace std;

/*
La idea es diseñar el juego Soko en C.
Se evaluan justificacion de eficiencia, formas de hacer los ejercicios, las invariantes y no dejar memory leaks. 
Las invariantes a sacar son de: CeldaStr, SokoStr, Soko. 
*/

enum Contenido { VACIO, PARED, CAJA };
typedef int Dir;
enum {
    N = 0,  // Norte
    E = 1,  // Este
    S = 2,  // Sur
    O = 3   // Oeste
};

struct CeldaStr {
    Contenido contenido;
    CeldaStr** vs;  // 0: norte, 1: este, 2: sur, 3: oeste
};

struct SokoStr {
    Celda p;  // personaje
    Celda s;  // salida
};

typedef CeldaStr* Celda;
typedef SokoStr*  Soko;

struct Coord {
    int x;
    int y;
};


//implementar
void mover(Dir dir, Soko sk); 
// PROPOSITO: mueve el personaje a la dir dada.
// OBSERVACIONES: No se puede mover si hay una pared o se termino el tablero hacia esa direccion. 
// si hay una caja, tenes que ver enfrente la caja, y si esta vacio podes moverte poniendo la caja en esa celda vacia.  
bool escapo(Soko sk); // PROPOSITO: indica si el personaje esta en la salida. 
Coord posicionPersonaje(Soko sk); // PROPOSITO: La diferencia entre el personaje y la esquina SurOeste. (imagina que en SurOeste esta la coord (0,0))

//como usuario: 
bool esGanadora(LinkedList mvs, Soko sk); // indica si la linkedlist de movimientos te lleva a la salida. 

//la interfaz de linkedlist es la misma que en las practicas, todas de costo constante menos DestroyL que es O(n).
//la linkedlist es de tipo Dir 

//invariantes que encontre: 
/*
    INV REP de CeldaStr siendo => contenido vs 
    * vs debe tener de tamaño 4. 
    * En vs no pueden haber punteros a celdas repetidos ni tampoco autoreferenciarse. 
    * Lo que aparece hacia el norte de una celda, tiene que estar en el indice 0 en la lista de vs, lo que hay en el Este en el indice 1, 
      lo que hay en el Sur en el 2 y  lo que hay en el Oeste en el 3. 
    * Si una celda A tiene en su lista de vecinos a una celda B, entonces A tiene que estar en la lista de vecinos de B pero en su dir opuesta. 
    * Las celdas de vs cumplen las invariantes. 
*/





