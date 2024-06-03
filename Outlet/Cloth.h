//
//  Cloth.h
//  Házi feladat (E0PKKH)
//
//  Created by Balint Dombovari on 2023. 05. 07..
//
#include <iostream>
#include <cstring>
#include "Product.h"
#include "memtrace.h"

#ifndef Cloth_h
#define Cloth_h
///** Ruhák osztálya **
/**
 *Mindegyik leszármazott osztálynak van egy size változója, melynek típusa osztályonként eltér. Jelen esetben char típusú.
 *Az összes osztály rendelkezik egy printSize függvénnyel, mely kiírja az adott objektum size változóját a paraméterlistán kapott stream-re.
 *Cloth osztály konstruktora 4 int-et, 1 char-t és egy string-et kap, és  meghívja az alaposztály konstruktorát.
 *A getSizeC  és getSizeI függvények  is felü vannak definiálva.
 *Operator== fv.-e is van az osztálynak.
 */
class Cloth: public Product{
    char size; ///méret: S,M,L
    int X;    ///XL, XS méret esetén az
public:
    ///Paraméteres Konstruktor (default is)
    ///@param ar - ár (int)
    ///@param learazas - leértékelés (int)
    ///@param Q - mennyiség (int)
    ///@param nev - név (string)
    ///@param meret - méret
    Cloth(int ar=999,int learazas=999,int Q=-1, std::string nev="Cloth", char meret='S', int x=0):
    Product(ar,learazas,Q,nev), size(meret), X(x){ }
    
    ///Méret kiírása
    ///@param os - stream, amire írunk 
    void printSize(std::ostream& os = std::cout)const{
        for(int i=0;i<X;i++){
            os<<"X";
        }
        os<<size;
        
    }
    ///X-ek száma a méretben
    ///@return X-ek száma a méretben (int)
    int getSizeI()const{
        return X;
    }
    ///Méret elérése
    ///@return méret (char)
    char getSizeC()const{
        return size;
    }
    ///Két ruhadarab összehasonlítása
    ///@param ruha - másik ruha, amivel összehasonlítunk
    ///@return összehasonlítás eredménye (bool)
    bool operator==(const Product& ruha)const{
        ///Azonos két termék, ha megegyezik a nevük, áruk, méretük és a rájuk vonatkozó kedvezmény
        if(this->Product::operator==(ruha) && this->size==ruha.getSizeC() && this->X == ruha.getSizeI()){
            return true;
        }
        else{
            return false;
        }
    }
    ///Destruktor -> jó a default is
};

#endif /* Cloth_h */
