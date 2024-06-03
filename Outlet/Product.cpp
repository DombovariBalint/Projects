//
//  Store.cpp
//  Házi feladat (E0PKKH)
//
//  Created by Balint Dombovari on 2023. 05. 12..
//

#include <iostream>
#include "Product.h"
#include <clocale>
#include "memtrace.h"


/// Név, ár, méret és leértékelés kiírása egy osstream-re
/// Mennyiséget nem minden függvény írja ki a Store osztályban, így ahol kell, ott getQ függvény segítségével valósul meg a  kiírása
/// @param os - bal oldali operandus (ostream)
/// @param termek - jobb oldali operandus (Product)
/// @return ostream&, hogy fűzhető legyen
std::ostream& operator<<(std::ostream& os, const Product& termek)
{
    setlocale(LC_CTYPE, "HUN");
    os<<"-Név: " <<termek.getName()<<std::endl;///Név
    os<<"-Ár: " <<termek.getPrice()<<std::endl;///Ár
    os<<"-Leárazás: " <<termek.getSale()<<"%"<<std::endl;///Leértékelés
    os<<"- Méret: ";
    termek.printSize(os);///Méret
    os<<std::endl;
    return os;
}
