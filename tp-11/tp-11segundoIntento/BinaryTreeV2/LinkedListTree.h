#include "TreeV2.h"

struct NodoL;
struct LinkedListSt;
typedef LinkedListSt* TreeLinkedList; // INV.REP.: el puntero NO es NULL
struct IteratorSt; 

typedef IteratorSt* TreeListIterator; // INV.REP.: el puntero NO es NULL

// Definir la siguiente interfaz de este tipo de listas, indicando el costo obtenido (intentar que sea
// lo más eficiente posible):

TreeLinkedList nil();
// Crea una lista vacía.;
bool isEmpty(TreeLinkedList xs);
// Indica si la lista está vacía.;
Tree head(TreeLinkedList xs);
// Devuelve el primer elemento.;
void Cons(Tree x, TreeLinkedList xs);
// Agrega un elemento al principio de la lista.;
void Tail(TreeLinkedList xs);
// Quita el primer elemento.;
int length(TreeLinkedList xs);
// Devuelve la cantidad de elementos.;
void Snoc(Tree x, TreeLinkedList xs);
// Agrega un elemento al final de la lista.;
TreeListIterator getIterator(TreeLinkedList xs);
// Apunta el recorrido al primer elemento.;
Tree current(TreeListIterator ixs);
// Devuelve el elemento actual en el recorrido.;
void SetCurrent(Tree x, TreeListIterator ixs);
// Reemplaza el elemento actual por otro elemento.;
void Next(TreeListIterator ixs);
// Pasa al siguiente elemento.;
bool NextIsEnd(TreeListIterator ixs);
bool atEnd(TreeListIterator ixs);
// Indica si el recorrido ha terminado.;
void DisposeIterator(TreeListIterator ixs);
// Libera la memoria ocupada por el iterador.;
void DestroyL(TreeLinkedList xs);
// Libera la memoria ocupada por la lista.;
