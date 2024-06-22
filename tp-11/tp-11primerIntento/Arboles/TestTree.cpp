int main() {
    Tree t = nodeT(1, nodeT(2, emptyT(), emptyT()), nodeT(3, emptyT(), emptyT()));
    
    if (!isEmptyT(t)) {
        cout << "Raiz: " << rootT(t) << endl;
        cout << "Izquierda: " << rootT(left(t)) << endl;
        cout << "Derecha: " << rootT(right(t)) << endl;
    }

    return 0;
}