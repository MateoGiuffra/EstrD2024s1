#include <iostream> 
#include <string>
#include "PersonaV2.h"
using namespace std;

PersonaV2 consPersona(string nombre, int edad){
// Devuelve el nombre de una persona
    PersonaV2 p = new PersonaV2St; //va la tipo  y despues new y el puntero (tipoSt)
    p->edad = edad; p->nombre = nombre; 
    return p;      
}

string nombre(PersonaV2 p){
// Devuelve el nombre de una persona
    return p->nombre; 
}
int edad(PersonaV2 p){
// Devuelve la edad de una persona
    return p->edad; 
}
void crecer(PersonaV2 p){
// Aumenta en uno la edad de la persona.
    p->edad++; 
}

void cambioDeNombre(string nombre, PersonaV2 p){
// Modifica el nombre una persona.
    p->nombre = nombre; 
}
bool esMayorQueLaOtra(PersonaV2 p1, PersonaV2 p2){
// Dadas dos personas indica si la primera es mayor que la segunda.
    return p1->edad > p2->edad; 
}

PersonaV2 laQueEsMayor(PersonaV2 p1, PersonaV2 p2){
// Dadas dos personas devuelve a la persona que sea mayor.
    if (p1->edad > p2->edad){
        return p1; 
    }
    return p2; 
}