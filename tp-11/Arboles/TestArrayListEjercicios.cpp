int main() {
    //SetUp
    ArrayList array = newArrayList();
    add(10, array);
    add(100, array);
    add(1000, array);

    //Exercise 
    cout << "Sumatoria: " << sumatoria(array) << endl;  // deberia de dar 1110 
    cout << "Minimo: " << minimo(array) << endl;        // deberia de dar 10 

    ArrayList array2 = newArrayList();
    add(5, array2);
    add(15, array2);

    ArrayList combinado = append(array, array2); 
    cout << "Sumatoria del combinado: " << sumatoria(combinado) << endl; // deberia de dar la suma de 1110 + 5 + 15 = 1130 

    sucesores(array);
    cout << "Sumatoria despues de sucesores: " << sumatoria(array) << endl; //deberia de dar 11 + 101+ 1001 = 1112
    return 0;
}
