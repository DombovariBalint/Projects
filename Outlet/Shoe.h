//
//  Shoe.h
//  Házi feladat (E0PKKH)
//
//  Created by Balint Dombovari on 2023. 05. 07..
//
#include <iostream>
#include <cstring>
#include "Product.h"
#include "memtrace.h"

#ifndef Shoe_h
#define Shoe_h
///** Cipők osztálya **
/**
 *Mindegyik leszármazott osztálynak van egy size változója, melynek típusa osztályonként eltér. Jelen esetben int típusú.
 *Az összes osztály rendelkezik egy printSize függvénnyel, mely kiírja az adott objektum size változóját a paraméterlistán kapott stream-re.
 *Shoe osztály konstruktora 3 int-et , 1 double-t és egy string-et kap, meghívja az alaposztály konstruktorát.
 *Csak a getSizeI függvény van felül definiálva ebben az osztályban.
 *Operator== fv.-e is rendelkezik.
 */
class Shoe: public Product{
    double size; ///méret, fél méretek is lehetnek
public:
    ///Paraméteres Konstruktor (default is)
    ///@param ar - ár (int)
    ///@param learazas - leértékelés (int)
    ///@param Q - mennyiség (int)
    ///@param nev - név (string)
    ///@param meret - méret (double)
    Shoe(int ar=999,int learazas=999,int Q=-1, std::string nev="Shoe", double meret=0.0):
    Product(ar,learazas,Q,nev), size(meret){ }
    
    ///Méret kiírása
    ///@param os - stream, amire írunk
    void printSize(std::ostream& os = std::cout)const{ os<<size; }
    
    ///Méret elérése
    ///@return méret (int)
    int getSizeI()const{
        return size;
    }
    ///Két cipő összehasonlítása
    ///@param cipo - másik cipő, amivel összehasonlítunk
    ///@return az összehasonlítása eredménye (bool)
    bool operator==(const Product& cipo) const{
        ///Azonos két termék, ha megegyezik a nevük, áruk, méretük és a rájuk vonatkozó kedvezmény
        if(this->Product::operator==(cipo) && this->size==cipo.getSizeI()){
            return true;
        }
        else{
            return false;
        }
    }
    ///Destruktor -> jó a default is
};

#endif /* Shoe_h */
