#ifndef PERSONAV3_H
#define PERSONAV3_H

#include <string>

// Declaración adelantada de la estructura
struct PersonaSt; 
typedef PersonaSt* Persona; 

// Prototipos de funciones
Persona consPersona(std::string nombre, int edad); 
std::string nombre(Persona p); 
int edad(Persona p);
void crecer(Persona p);
void cambioDeNombre(std::string nombre, Persona p);
bool esMayorQueLaOtra(Persona p1, Persona p2);
Persona laQueEsMayor(Persona p1, Persona p2);

#endif // PERSONAV3_H
