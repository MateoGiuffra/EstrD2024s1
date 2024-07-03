#include <iostream>
#include "Persona.h"
#include <string>
using namespace std;

Persona consPersona(string nombre, int edad){
//Devuelve el nombre de una persona
    PersonaSt* p = new PersonaSt;
    p->nombre = nombre; p->edad = edad;
    return p;
}
string nombre(Persona p){
// Devuelve el nombre de una persona
    return p->nombre;
}

int edad(Persona p){
// Devuelve la edad de una persona
    return p->edad;
}
void crecer(Persona p){
// Aumenta en uno la edad de la persona.
    p->edad = p->edad + 1;
}
void cambioDeNombre(string nombre, Persona p){
// Modifica el nombre una persona.
    p->nombre = nombre;
}
bool esMayorQueLaOtra(Persona p1, Persona p2){
// Dadas dos personas indica si la primera es mayor que la segunda.
    return p1->edad > p2->edad;
}
Persona laQueEsMayor(Persona p1, Persona p2){
// Dadas dos personas devuelve a la persona que sea mayor
    if (p1->edad > p2->edad){
        return p1;
    }else{
        return p2;
    }
}

int main(){
    Persona personaDir = consPersona("Mateo",20); 
    cout << "La edad de la persona que se encuentra en 0x231f7821a90 es: " << edad(personaDir) <<endl; //tiene que dar 20
    cout << "El nombre de la persona que se encuentra en 0x231f7821a90 es: " << nombre(personaDir) <<endl; //tiene que dar "Mateo"
    cambioDeNombre("Mateo Gabriel", personaDir);
    cout <<  "La persona que se encuentra en 0x231f7821a90 cambia su nombre a: " << nombre(personaDir) <<endl; //tiene que dar "Mateo Gabriel"
    Persona personaDir2 = consPersona("Ache",22);
    cout<< esMayorQueLaOtra(personaDir2, personaDir) <<endl;   // tiene que dar 1
    crecer(personaDir); 
    crecer(personaDir); 
    crecer(personaDir); 
    crecer(personaDir); 
    cout << "La persona que se encuentra en 0x231f7821a90 crecio 3 veces y ahora es mayor a la otra: " << esMayorQueLaOtra(personaDir2, personaDir) <<endl;  // tiene que dar 0 
    cout << laQueEsMayor(personaDir2, personaDir)<<endl;     // tiene que dar  0x231f7821a90
}