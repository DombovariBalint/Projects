//
//  Accessory.h
//  Házi feladat (E0PKKH)
//
//  Created by Balint Dombovari on 2023. 05. 07..
//
#include <iostream>
#include <cstring>
#include "Product.h"
#include "memtrace.h"

#ifndef Accessory_h
#define Accessory_h
///**  Kiegészítők osztálya  **
/**
 *Mindegyik leszármazott osztálynak van egy size változója, melynek típusa osztályonként eltér. Jelen esetben static string típusú, mondván minden kiegészítő mérete ONE SIZE.
 *Az összes osztály rendelkezik egy printSize függvénnyel, mely kiírja az adott objektum size változóját a paraméterlistán kapott stream-re.
 *Accessory osztály konstruktora 3 int-et, és egy string-et kap, és  meghívja az alaposztály konstruktorát.
 *Operator== fv.-e is van az osztálynak.
 */
class Accessory: public Product{
    static std::string size; ///méret, minden objektum ONE_SIZE méretű-> static
public:
    ///Paraméteres Konstruktor (default is)
    ///@param ar - ár (int)
    ///@param learazas - leértékelés (int)
    ///@param Q - mennyiség (int)
    ///@param nev - név (string)
    Accessory(int ar=999,int learazas=999,int Q=-1, std::string nev="Accessory"): Product(ar,learazas,Q,nev){ }
    
    ///Méret kiírása
    ///@param os - stream, amire írunk
    void printSize(std::ostream& os = std::cout)const{ os<<size; }
    

    ///Destruktor -> jó a default is
};
///size változó inicializálása
std::string Accessory::size= "ONE_SIZE";
#endif /* Accessory_h */
