// Ejercicio 2
// Modelaremos los tipos de datos P okemon, como un T ipoDeP okemon (agua, fuego o planta,
// sinónimo de string) y un porcentaje de energía (que inicia en 100); y Entrenador, como un
// nombre, una cantidad de pokémon y un array de pokémon. Así, la representación es la siguiente:
#ifndef POKEMONV2_H
#define POKEMONV2_H

#include <iostream> 
#include <string>
using namespace std;

typedef string TipoDePokemon;

struct PokeSt {
    TipoDePokemon tipo;
    int vida;
};

typedef PokeSt* Pokemon;

struct EntrenadorSt {
    string nombre;
    Pokemon* pokemon;
    int cantPokemon;
};

typedef EntrenadorSt* Entrenador;

// Declaraciones de funciones para Pokémon
Pokemon consPokemon(TipoDePokemon tipo);
TipoDePokemon tipoDePokemon(Pokemon p);
int energia(Pokemon p);
void perderEnergia(int energia, Pokemon p);
bool superaA(Pokemon p1, Pokemon p2);

// Declaraciones de funciones para Entrenador
Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon);
string nombreDeEntrenador(Entrenador e);
int cantidadDePokemon(Entrenador e);
int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e);
Pokemon pokemonNro(int i, Entrenador e);
bool leGanaATodos(Entrenador e1, Entrenador e2);

#endif // POKEMONV2_H
