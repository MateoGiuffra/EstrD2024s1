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
    NodeStr* c = xs->firts; 
    current->next = NULL; 
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
