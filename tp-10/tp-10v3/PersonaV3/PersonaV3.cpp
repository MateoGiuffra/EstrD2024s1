#include "PersonaV3.h"
#include <iostream>
#include <string>

// Definición de la estructura
struct PersonaSt {
    int edad; 
    std::string nombre; 
};

// Implementación de las funciones

Persona consPersona(std::string nombre, int edad) {
    Persona p = new PersonaSt; 
    p->edad = edad;  // Ajustar para usar el valor de edad proporcionado
    p->nombre = nombre; 
    return p; 
}

std::string nombre(Persona p) {
    return p->nombre; 
}

int edad(Persona p) {
    return p->edad; 
}

void crecer(Persona p) {
    p->edad++; 
}

void cambioDeNombre(std::string nombre, Persona p) {
    p->nombre = nombre; 
}

bool esMayorQueLaOtra(Persona p1, Persona p2) {
    return p1->edad > p2->edad; 
}

Persona laQueEsMayor(Persona p1, Persona p2) {
    return p1->edad > p2->edad ? p1 : p2;  
}

int main() {
    // Ejemplo de uso
    Persona p1 = consPersona("Alice", 25);
    Persona p2 = consPersona("Bob", 30);

    std::cout << nombre(p1) << " tiene " << edad(p1) << " años." << std::endl;
    std::cout << nombre(p2) << " tiene " << edad(p2) << " años." << std::endl;

    crecer(p1);
    std::cout << nombre(p1) << " ahora tiene " << edad(p1) << " años." << std::endl;

    if (esMayorQueLaOtra(p2, p1)) {
        std::cout << nombre(p2) << " es mayor que " << nombre(p1) << "." << std::endl;
    }

    Persona mayor = laQueEsMayor(p1, p2);
    std::cout << nombre(mayor) << " es la persona mayor." << std::endl;

    // Liberar memoria
    delete p1;
    delete p2;

    return 0; 
}
