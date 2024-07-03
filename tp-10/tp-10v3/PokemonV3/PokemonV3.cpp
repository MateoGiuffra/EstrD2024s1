#include <string> 
#include "PokemonV3.h"
#include <iostream>
using namespace std; 


struct PokeSt {
TipoDePokemon tipo;
int vida;
}; 

struct EntrenadorSt {
string nombre;
Pokemon* pokemon;
int cantPokemon;
};

// ================================================================================================================================================
// POKEMON                  POKEMON                  POKEMON                  POKEMON                  POKEMON 
// ================================================================================================================================================
// Dicho esto, implementar la siguiente interfaz de P okemon:

Pokemon consPokemon(TipoDePokemon tipo){
// Dado un tipo Devuelve un pokémon con 100 % de energía.;
    Pokemon p = new PokeSt; 
    p->tipo = tipo; p->vida = 100; 
    return p; 
}
TipoDePokemon tipoDePokemon(Pokemon p){
// Devuelve el tipo de un pokémon.;
    return p->tipo; 
}
int energia(Pokemon p){
//Devuelve el porcentaje de energía.;
    return p->vida; 
}
void perderEnergia(int energia, Pokemon p){
// Le resta energía al pokémon.;
    if (p->vida - energia >= 0){
        p->vida = p->vida - energia; 
    }else{
        p->vida = 0; 
    }
}
bool superaA(Pokemon p1, Pokemon p2){
// Dados dos pokémon indica si el primero, en base al tipo, es superior al segundo. Agua supera;
// a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.;
    return (p1->tipo == "AGUA" &&  p2->tipo == "FUEGO")   || 
           (p1->tipo == "FUEGO" && p2-> tipo == "PLANTA") || 
            p1->tipo == "PLANTA" && p2->tipo == "AGUA"; 
}


// ================================================================================================================================================
// ENTRENADOR                  ENTRENADOR                  ENTRENADOR                  ENTRENADOR                  ENTRENADOR 
// ================================================================================================================================================
// Una vez hecho eso, implementar la siguiente interfaz de Entrenador:;


Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon){
//Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve un entrenador.
    Entrenador e = new EntrenadorSt; 
    e->cantPokemon = cantidad; 
    e->nombre = nombre;
    e->pokemon = new Pokemon[cantidad];
    for (int i = 0; i<cantidad; i++){
        e->pokemon[i] = pokemon[i]; 
    }
    return e; 
}
string nombreDeEntrenador(Entrenador e){
//Devuelve el nombre del entrenador.;
    return e->nombre; 
}
int cantidadDePokemon(Entrenador e){
//Devuelve la cantidad de pokémon que posee el entrenador.;
    return e->cantPokemon; 
}

int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e){
//Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.;
    if (e->cantPokemon == 0) return 0; 
    int cant = 0; 
    for (int i = 0; i<e->cantPokemon; i++){
        cant += tipo == e->pokemon[i]->tipo ? 1 : 0; 
    }
    return cant; 
}

Pokemon pokemonNro(int i, Entrenador e){
//Devuelve el pokémon número i de los pokémon del entrenador.;
// Precondición: existen al menos i−1 pokémon.;
    if  (i < 0 || i > e->cantPokemon) throw runtime_error("El numero esta fuera de rango");  
    return e->pokemon[i]; 
}
bool leGanaATodos(Entrenador e1, Entrenador e2){
// Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero;
// posee al menos un pokémon que le gane.;
    return true; 
}

int main() {
    // Ejemplo de uso
    Pokemon p1 = consPokemon("AGUA");
    Pokemon p2 = consPokemon("FUEGO");
    Pokemon p3 = consPokemon("PLANTA");

    Pokemon pokemons1[] = {p1, p2};
    Pokemon pokemons2[] = {p3};

    Entrenador e1 = consEntrenador("Ash", 2, pokemons1);
    Entrenador e2 = consEntrenador("Gary", 1, pokemons2);

    cout << nombreDeEntrenador(e1) << " tiene " << cantidadDePokemon(e1) << " pokemon." << endl;
    cout << nombreDeEntrenador(e2) << " tiene " << cantidadDePokemon(e2) << " pokemon." << endl;

    if (leGanaATodos(e1, e2)) {
        cout << nombreDeEntrenador(e1) << " le gana a todos los pokemon de " << nombreDeEntrenador(e2) << "." << endl;
    } else {
        cout << nombreDeEntrenador(e1) << " no le gana a todos los pokemon de " << nombreDeEntrenador(e2) << "." << endl;
    }

    // Liberar memoria
    delete p1;
    delete p2;
    delete p3;
    delete[] e1->pokemon;
    delete e1;
    delete[] e2->pokemon;
    delete e2;

    return 0;
}
