// 1. Registros
// Ejercicio 1
// Definir el tipo de dato Persona, como un puntero a un registro con el nombre y la edad de la
// persona. Realizar las siguientes funciones:
#include <iostream> 
#include <string>
using namespace std;

struct PersonaV2St { // aca se pone el st o sea el puntero 
    int edad; 
    string nombre; 
};

typedef PersonaV2St* PersonaV2; 

// aca el tipo no puntero. 
PersonaV2 consPersona(string nombre, int edad);
// Devuelve el nombre de una persona
string nombre(PersonaV2 p);
// Devuelve el nombre de una persona
int edad(PersonaV2 p);
// Devuelve la edad de una persona
void crecer(PersonaV2 p);
// Aumenta en uno la edad de la persona.
void cambioDeNombre(string nombre, PersonaV2 p);
// Modifica el nombre una persona.
bool esMayorQueLaOtra(PersonaV2 p1, PersonaV2 p2);
// Dadas dos personas indica si la primera es mayor que la segunda.
PersonaV2 laQueEsMayor(PersonaV2 p1, PersonaV2 p2);
// Dadas dos personas devuelve a la persona que sea mayor.
