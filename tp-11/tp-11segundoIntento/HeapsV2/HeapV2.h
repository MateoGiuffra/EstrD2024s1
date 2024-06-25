struct BinHeapHeaderSt; 
typedef BinHeapHeaderSt* BinHeap; 

BinHeap emptyHeap(); 
void insertH(int x, BinHeap h);
void deleteMin(BinHeap h);
int  findMin(BinHeap h);
bool isEmptyH(BinHeap h);
void aumentarEspacio(BinHeap h);
BinHeap crearHeap(int* elems, int cant); 