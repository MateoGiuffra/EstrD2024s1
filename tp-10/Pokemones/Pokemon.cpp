#include <iostream>
#include "Pokemon.h"

Pokemon consPokemon(TipoDePokemon tipo){
// Dado un tipo devuelve un pokémon con 100 % de energía.
    PokeSt* pst = new PokeSt;
    pst->tipo = tipo; pst->vida = 100;
    return pst;
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
    return (p1->tipo == "Agua" && p2->tipo == "Fuego" ) || (p1->tipo == "Fuego" && p2->tipo == "Planta" ) || (p1->tipo == "Planta" && p2->tipo == "Agua");    
}


int main(){
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
}