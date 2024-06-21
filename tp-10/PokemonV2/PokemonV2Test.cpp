#include <iostream> 
#include <string>
#include "PokemonV2.h"
using namespace std;

int main(){
    Pokemon charmander = consPokemon("Fuego"); 
    Pokemon bulbasaur  = consPokemon("Planta"); 
    Pokemon wartortle  = consPokemon("Agua");
    Pokemon pokemones[] = {charmander,bulbasaur,wartortle}; 
    Entrenador e1 = consEntrenador("Ash",3, pokemones);
    cout <<e1<<endl;
    return 0;
}