// Ejercicio 2
// Modelaremos los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta,
// sinónimo de string) y un porcentaje de energía (que inicia en 100); y Entrenador, como un
// nombre, una cantidad de pokémon y un array de pokémon. Así, la representación es la siguiente:
#ifndef POKEMON_H
#define POKEMON_H

#include <string>

using namespace std;

typedef std::string TipoDePokemon;

struct PokeSt {
    TipoDePokemon tipo;
    int vida;
};

typedef PokeSt* Pokemon;

Pokemon consPokemon(TipoDePokemon tipo);
TipoDePokemon tipoDePokemon(Pokemon p);
int energia(Pokemon p);
void perderEnergia(int energia, Pokemon p);
bool superaA(Pokemon p1, Pokemon p2);

#endif // POKEMON_H
