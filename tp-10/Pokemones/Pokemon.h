// Ejercicio 2
// Modelaremos los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta,
// sinónimo de string) y un porcentaje de energía (que inicia en 100); y Entrenador, como un
// nombre, una cantidad de pokémon y un array de pokémon. Así, la representación es la siguiente:
#include<iostream>
#include <string>
using namespace std;

typedef string TipoDePokemon;

struct PokeSt {
    TipoDePokemon tipo;
    int vida;
};

typedef PokeSt* Pokemon;


Pokemon consPokemon(TipoDePokemon tipo);
// Dado un tipo devuelve un pokémon con 100 % de energía.
TipoDePokemon tipoDePokemon(Pokemon p);
// Devuelve el tipo de un pokémon.
int energia(Pokemon p);
// Devuelve el porcentaje de energía.
void perderEnergia(int energia, Pokemon p);
// Le resta energía al pokémon.
bool superaA(Pokemon p1, Pokemon p2);
