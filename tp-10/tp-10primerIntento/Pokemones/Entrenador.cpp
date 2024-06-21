#include <iostream>
#include "Entrenador.h"
#include "Pokemon.h"

Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon) {
    // Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve un entrenador.
    Entrenador e = new EntrenadorSt;
    e->nombre = nombre;
    e->cantPokemon = cantidad;
    e->pokemon = new Pokemon[cantidad];
    for (int i = 0; i < cantidad; i++) {
        e->pokemon[i] = pokemon[i];
    }
    return e;
}

string nombreDeEntrenador(Entrenador e) {
    // Devuelve el nombre del entrenador.
    return e->nombre;
}

int cantidadDePokemon(Entrenador e) {
    // Devuelve la cantidad de pokémon que posee el entrenador.
    return e->cantPokemon;
}

int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e) {
    // Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.
    int contador = 0;
    for (int i = 0; i < e->cantPokemon; i++) {
        if (tipo == tipoDePokemon(e->pokemon[i])) {
            contador++;
        }
    }
    return contador;
}

Pokemon pokemonNro(int i, Entrenador e) {
    // Devuelve el pokémon número i de los pokémon del entrenador.
    // Precondición: existen al menos i − 1 pokémon.
    return e->pokemon[i];
}

bool esteLeGanaATodos(Pokemon pokemon, Entrenador e) {
    int c = 0;
    int i = 0;
    while (i < e->cantPokemon ) {
        if (superaA(pokemon, e->pokemon[i])){
            c++;
        }
        i++;
    }
    return i == c; 
}

bool leGanaATodos(Entrenador e1, Entrenador e2) {
    // Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero posee al menos un pokémon que le gane.
    for (int i = 0; i < e2->cantPokemon; i++) {
        if (esteLeGanaATodos(e1->pokemon[i],e2)){
            return true;
        }
    }
    return false;
}


int main() {

    //seccion Pokemon test
    Pokemon charmander = consPokemon("Fuego");
    Pokemon poliwag = consPokemon("Agua");
    cout << "¿Este pokemon de tipo: " << tipoDePokemon(charmander) << " es mas fuerte que el pokemon de tipo " << tipoDePokemon(poliwag) <<
     "? Respuesta: "  << superaA(poliwag, charmander) <<endl; // true por ende 1.
    cout << "¿Este pokemon de tipo: " << tipoDePokemon(charmander) << " es mas fuerte que el pokemon de tipo " << tipoDePokemon(poliwag) <<
     "? Respuesta: "  << superaA(charmander, poliwag) <<endl; // falso por ende 0.
    cout << "La energia del Charmander es de " << energia(charmander) << ", pero luego de un intercambio con otro Pokemon, recibio tres golpes de 10 de damage, por ende ahora " << endl; 
    perderEnergia(10, charmander);
    perderEnergia(10, charmander);
    perderEnergia(10, charmander);
    cout << "La energia del Charmander es de "<<energia(charmander) << endl; // ahora deberia de tener 70

    //seccion Entrenador test
    // SetUp:               
                                                //Indices
    Pokemon Charmander = consPokemon("Fuego");  // 0
    Pokemon Cloyster   = consPokemon("Agua");   // 1
    Pokemon Bulbasaur  = consPokemon("Planta"); // 2
    Pokemon pokemons[] = {Charmander, Charmander, Charmander, Charmander, Charmander, Cloyster, Bulbasaur};
    Entrenador ash = consEntrenador("Ash", 7, pokemons);
    cout << tipoDePokemon(pokemonNro(1,ash))<<endl; // deberia de ser Agua ya que el Pokemon en la indice 1 es Cloyster de tipo Agua. 

    
    Pokemon soloUnPokemon[] = {Charmander};

    Pokemon soloPlanta[]    = {Bulbasaur,Bulbasaur,Bulbasaur};
    Entrenador e1 = consEntrenador("Entrenador 1",1, soloUnPokemon);
    Entrenador e2 = consEntrenador("Entrenador 2",3, soloPlanta);
    
    // Este tiene que dar 1, ya que Fuego le gana a Planta, lo importante es demostrar que a le gana a TODOS los pokemones del entrenador dado.
    cout << "Este pokemon de tipo " << tipoDePokemon(Charmander) << " tiene al menos un pokemon que le pueda ganar a todos los pokemones de " <<
    nombreDeEntrenador(e2) << "? " << "Respuesta: " << esteLeGanaATodos(Charmander,e2 )<< endl; 
    // Aca tiene que dar 1 porque es la misma situacion que arriba solo que uso el entrenador en vez de solo el pokemon. 
    cout << "Este entrenador " << nombreDeEntrenador(e1) << " tiene al menos un pokemon que le pueda ganar a todos los pokemones de " <<
    nombreDeEntrenador(e2) << "? " << "Respuesta: " << (leGanaATodos(e1,e2 ))<< endl;
    
    cout << "La cantidad de pokemones de tipo Fuego que posee Ash es de: " << cantidadDePokemonDe("Fuego",ash) << endl; 

}
