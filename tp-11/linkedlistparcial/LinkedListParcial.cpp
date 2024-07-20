//struct LinkedListStr; 
//typedef LinkedListStr LinkedList; 
//LinkedList emptyLL(); void Snoc(LinkedList xs,int value); void DestroyLL(LinkedList xs); 
//O(1)                    O(1)                                O(N)

/*Se evaluan: 
    * Si los punteros no estan en cualquiera. 
    * Ver si hay delete en donde no tienen que estar. 
    * La diferencia entre heap y stack.
*/
int* ascendente(int values[], int size){
    if(size == 0) new int[0];
    LinkedList xs = emptyLL(); 
    int maxVisto = values[0]; 
    Snoc(xs,values[0]); 
    for(int i = 1; i<size ; i++){
        if(values[i]>maxVisto){
            Snoc(xs,values[i]);
            maxVisto = values[i];
        }
    }
    int* res = toArray(xs);
    DestroyLL(xs);
    return res; 
}

int[] toArray(LinkedList xs){
    int*res = new int[xs->size]; 
    NodeStr* c = xs->first; 
    for(int i = 0; i<xs->size; i++){
        res[i] = c->value; 
        c = c->next; 
    }
    return res; 
}

void reverse(LinkedList xs){
    if(xs->size > 1){
        NodeStr* current = xs->first; 
        NodeStr* next = current->next; 
        xs->last = current; 
        while(next != NULL){
            NodeStr* temp = next->next; 
            next->next = current; 
            current = next; 
            next = temp; 
        }
        xs->first = current;
    }
}

LinkedList from(int* values, int size){
    LinkedListStr* res = new LinkedList; 
    res->size = size; 
    if (size > 0 ) {
        NodeStr* p = new NodeStr; 
        res->first = p; 
        p->value = values[0];
        for(int i = 1; i<size; i++){
            NodeStr* n = new NodeStr; 
            c->value = values[i];
            p->next = c; 
            p = c; 
        }
        res->last =p; 
        p->next = NULL; 
    } else {
        res->first = res->last = NULL;
    }
    return res; 
}
// me parece que no los copie bien, estos que hice yo andan bien:

void reverse(LinkedList xs){
    if (xs->cantidad > 1){
        NodoL* ant = xs->primero; 
        NodoL* cur = ant->siguiente; 
        NodoL* next; 
        while (cur != NULL){
            next = cur->siguiente; 
            cur->siguiente =  ant; 
            ant = cur; 
            cur = next; 
        }
        xs->ultimo = xs->primero; 
        xs->primero = ant; 
    }
}

LinkedList from(int* values, int size){
    LinkedList xs = new LinkedListSt;
    xs->primero = NULL; xs->ultimo = NULL; xs->cantidad = 0; 
    if (size <= 0) return xs; 
    for (int i = 0; i<size; i++){
        NodoL* cur = new NodoL;
        cur->elem = values[i];
        cur->siguiente = NULL;
        if (i == 0) {
            xs->primero = cur;
        } else {
            xs->ultimo->siguiente = cur;
        }
        xs->ultimo = cur; 
        xs->cantidad++; 
    }
    return xs; 
}

int* toArray(LinkedList xs){
    if (xs->cantidad <= 0) return new int[0];
    int* res   = new int[xs->cantidad];
    NodoL* cur = xs->primero; 
    for (int i = 0; i<xs->cantidad; i++){
        res[i] = cur->elem; 
        cur = cur->siguiente; 
    }
    return res; 
}



void imprimir(LinkedList xs) {
    if (isEmpty(xs)) {
        cout << "[]" << endl;

    }
    
    ListIterator it = getIterator(xs);
    cout << "[";
    while (!atEnd(it)) {
        cout << current(it);
        Next(it);
        if (!atEnd(it)) {
            cout << ", ";
        }
    }
    cout << "]" << endl;
    DisposeIterator(it);
}
