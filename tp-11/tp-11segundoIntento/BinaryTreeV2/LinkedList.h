struct NodoL;
struct LinkedListSt;
typedef LinkedListSt* LinkedList; // INV.REP.: el puntero NO es NULL
struct IteratorSt; 

typedef IteratorSt* ListIterator; // INV.REP.: el puntero NO es NULL

// Definir la siguiente interfaz de este tipo de listas, indicando el costo obtenido (intentar que sea
// lo más eficiente posible):

LinkedList nilL();
// Crea una lista vacía.;
bool isEmptyL(LinkedList xs);
// Indica si la lista está vacía.;
int headL(LinkedList xs);
// Devuelve el primer elemento.;
void ConsL(int x, LinkedList xs);
// Agrega un elemento al principio de la lista.;
void TailL(LinkedList xs);
// Quita el primer elemento.;  
// Devuelve la cantidad de elementos.;
void SnocL(int x, LinkedList xs);
// Agrega un elemento al final de la lista.;
ListIterator getIteratorL(LinkedList xs);
// Apunta el recorrido al primer elemento.;
int currentL(ListIterator ixs);
// Devuelve el elemento actual en el recorrido.;
void SetCurrentL(int x, ListIterator ixs);
// Reemplaza el elemento actual por otro elemento.;
void NextL(ListIterator ixs);
// Pasa al siguiente elemento.;
bool atEndL(ListIterator ixs);
// Indica si el recorrido ha terminado.;
void DisposeIteratorL(ListIterator ixs);
// Libera la memoria ocupada por el iterador.;
void DestroyLL(LinkedList xs);
// Libera la memoria ocupada por la lista.;