
#include <iostream>
#include <cstring>
#include "memtrace.h"

#ifndef Product_h
#define Product_h

///** Absztrakt alaposztály **
/**
 *Az öröklési hierarchia kialakításában vesz részt.
 *Az összes attribútuma privát, és számos get-er függvénnyel rendelkezik. (getPrice, getSale, getQ, getName, virtual getSizeI, virtual getSizeC)
 *Konstruktora 3 int-et, és egy stringet kap, és default értékei is vannak a paraméterlistáján, a destruktora pedig virtuális.
 *4 virtuális függvénnyel rendelkezik, melyekből a printSize tisztán virtuális.
 *decreaseQ függvénye egy setter jellegű függvény a quantity változó értékének módosítására.
 *operatorok közül az operator== - vel rendelkezik az osztály.
 */

class Product{
    
    int price;  ///ár
    int sale;  ///leértékelés %-ban értelmezve
    int quantity;  /// Összmennyiség az adott termékből a raktárban
    std::string name; ///Adott termék neve
public:
    ///Paraméteres Konstruktor (default is)
    ///@param ar - ár (int)
    ///@param learazas - leértékelés (int)
    ///@param Q - mennyiség (int)
    ///@param nev - név (string)
    Product(int ar=999,int learazas=999,int Q=-1, std::string nev="Product"): price(ar), sale(learazas), quantity(Q), name(nev){ }
    
    /// getter -> price
    /// @return  ár (int)
    int getPrice() const{ return price; }
    
    ///getter -> sale
    ///@return leértékelés (int)
    int getSale() const{ return sale; }
    
    ///getter -> quantity
    ///@return mennyiség (int)
    int getQ() const{ return quantity; }
    
    ///getter -> name
    ///@return név (int)
    std::string getName() const{ return name; }
    
    ///Mennyiség csökkentése
    ///Vásárlás esetén eggyel csökkenti az elérhető mennyiséget az adott termékből
    ///@param i - az adott menyiség, amivel csökkentünk
    void decreaseQ(int i){ quantity -= i; }
    
    ///Tisztán virtuális printSize()
    ///Az alaposztály felől is így elérhető
    ///Leszármazott osztályokban van definiálva
    ///@param os - stream, amire kiírjuk a méretet
    virtual void printSize(std::ostream& os = std::cout)const=0;
    
    ///Méret lekérdezése az alaposztály felől
    ///Int típus esetén
    ///@return méret intben
    virtual int getSizeI()const{ return 0; }
    
    ///Méret lekérdezése az alaposztály felől
    ///char típus esetén
    ///@return méret char
    virtual char getSizeC()const{ return '\0';}
    
    ///virtuális operator==
    ///Két termék tulajdonságait hasonlítja össze
    ///@param termek - a másik termék, amivel összehasonlítunk
    ///@return összehasonlítás eredménye (bool)
    virtual bool operator==(const Product& termek) const{
        ///Azonos két termék, ha megegyezik a nevük, áruk és a rájuk vonatkozó kedvezmény
        if(price == termek.price && sale == termek.sale  && name == termek.name){
            return true;
        }
        else{
            return false;
        }
    }
    
    ///virtuális destruktor
    virtual ~Product(){ }
};
/// Globális inserter
/// Product objektum kiírása egy ostream-re
/// @param os - bal oldali operandus (ostream)
/// @param termek - jobb oldali operandus (Product)
/// @return ostream&, hogy fűzhető legyen
std::ostream& operator<<(std::ostream& os, const Product& termek);

#endif /* Product_h */
