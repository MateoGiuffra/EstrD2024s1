// #include "PokemonV2.h"

// Pokemon consPokemon(TipoDePokemon tipo) {
//     Pokemon p = new PokeSt; 
//     p->tipo = tipo; 
//     p->vida = 100; 
//     return p; 
// }

// TipoDePokemon tipoDePokemon(Pokemon p) {
//     return p->tipo; 
// }

// int energia(Pokemon p) {
//     return p->vida; 
// }

// void perderEnergia(int energia, Pokemon p) {
//     p->vida -= energia; 
// }

// bool superaA(Pokemon p1, Pokemon p2) {
//     return (p1->tipo == "Agua" && p2->tipo == "Fuego") || 
//            (p1->tipo == "Fuego" && p2->tipo == "Planta") || 
//            (p1->tipo == "Planta" && p2->tipo == "Agua");
// }

// Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon) {
//     Entrenador e = new EntrenadorSt; 
//     e->nombre = nombre; 
//     e->cantPokemon = cantidad; 
//     e->pokemon = new Pokemon[cantidad]; 
//     for (int i = 0; i < cantidad; ++i) {
//         e->pokemon[i] = pokemon[i];
//     }
//     return e;
// }

// string nombreDeEntrenador(Entrenador e) {
//     return e->nombre; 
// }

// int cantidadDePokemon(Entrenador e) {
//     return e->cantPokemon; 
// }

// int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e) {
//     int cantidad = 0;
//     for (int i = 0; i < e->cantPokemon; ++i) {
//         if (e->pokemon[i]->tipo == tipo) {
//             cantidad++;
//         }
//     }
//     return cantidad; 
// }

// Pokemon pokemonNro(int i, Entrenador e) {
//     return e->pokemon[i]; 
// }

// bool leGanaATodos(Entrenador e1, Entrenador e2) {
//     for (int i = 0; i < e2->cantPokemon; ++i) {
//         bool encontrado = false;
//         for (int j = 0; j < e1->cantPokemon; ++j) {
//             if (superaA(e1->pokemon[j], e2->pokemon[i])) {
//                 encontrado = true;
//                 break;
//             }
//         }
//         if (!encontrado) return false;
//     }
//     return true;
// }


#include <iostream> 
#include <string>
#include "PokemonV2.h"
using namespace std;

Pokemon consPokemon(TipoDePokemon tipo){
// Dado un tipo devuelve un pokémon con 100 % de energía.
    Pokemon p = new PokeSt; 
    p->tipo = tipo; p->vida = 100; 
    return p; 
}
TipoDePokemon tipoDePokemon(Pokemon p){
// Devuelve el tipo de un pokémon.
    return p->tipo; 
}
int energia(Pokemon p){
// Devuelve el porcentaje de energía.
    return p->vida; 
}
void perderEnergia(int energia, Pokemon p){
// Le resta energía al pokémon.
    p->vida -= energia; 
}
bool superaA(Pokemon p1, Pokemon p2){
// Dados dos pokémon indica si el primero, en base al tipo, es superior al segundo. Agua supera
// a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
    return (p1->tipo == "Agua" && p2->tipo == "Fuego") || (p2->tipo == "Planta" && p1->tipo == "Fuego")  || (p2->tipo == "Agua" && p1->tipo == "Planta");
}

// Una vez hecho eso, implementar la siguiente interfaz de Entrenador:
Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon){
// Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve
// un entrenador.
    Entrenador e = new EntrenadorSt; 
    e->nombre = nombre; e->cantPokemon = cantidad; 
    e->pokemon = new Pokemon[cantidad];
    for (int i = 0; i < cantidad; i++){
        e->pokemon[i]= pokemon[i];
    }

    return e;
}
string nombreDeEntrenador(Entrenador e){
// Devuelve el nombre del entrenador.
    return e->nombre; 
}
int cantidadDePokemon(Entrenador e){
// Devuelve la cantidad de pokémon que posee el entrenador.
    return e->cantPokemon; 
}
int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e){
// Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.
    int cantidad = 0;
    for (int i = 0; i <= e->cantPokemon;i++ ){
        if(e->pokemon[i]->tipo == tipo){
            cantidad++;
        }
    }
    return cantidad; 
}
Pokemon pokemonNro(int i, Entrenador e){
// Devuelve el pokémon número i de los pokémon del entrenador.
// Precondición: existen al menos i −1 pokémon.
    return e->pokemon[i]; 
}
bool leGanaATodos(Entrenador e1, Entrenador e2){
// Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero
// posee al menos un pokémon que le gane.
    return true; 
}

