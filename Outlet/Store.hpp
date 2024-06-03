//
//  Store.h
//  Házi feladat (E0PKKH)
//
//  Created by Balint Dombovari on 2023. 05. 07..
//
#include <iostream>
#include <cstring>
#include "Product.h"
#include <fstream>
#include "memtrace.h"
#ifndef Store_h
#define Store_h


///** Heterogén Kollekciót megvalósító osztály **
/**
 Heterogén kollekciót megvalósító osztály, melyben a tömbök mérete template-en keresztül szabályozható. MAX a stock[] tömb méretét adja, míg max a list[] méretére vonatkozik, és mind a kettő tömb Product pointerekt tárol. Default értékek: MAX = 100, max = 20. Másoló konstruktora és operator= függvénye privát, mondván az alapértelmezett nem jó. Konstruktorában 0 értéket kap  a listdb, és a stockdb nevű változója, melyek azt jelölik, hogy az adott tömben éppen mennyi elem található aktuálisan. A stock tömb feltöltése a main-ben fog történni egy fájlból történő beolvasással a bevetelezes() függvény segítségével, ez lesz a raktárkészlet, míg a list tömb a bevásárló listát valósítja meg.
 */

template<size_t MAX = 100,size_t max = 20>
class Store{
    size_t stockdb;   ///Raktárban lévő termékek száma 
    size_t listdb;   ///Kosárban lévő termékek száma
    Product* stock[MAX];  ///Raktárkészlet - Heterogén kollekció
    Product* list[max];   ///Kosár - heterogén kollekció
    
    /// Privát másoló konstruktor és értékadó operátor.
    /// Az alapértelmezett változat nem jó, ezért ne legyen elérhető.
    Store(const Store& pelda);
    Store& operator=(const Store& pelda);
public:
    ///Konstruktor
    Store():stockdb(0), listdb(0){ }
    
    ///Adott termék elérhetőségének lekérdezése
    ///@param termek - keresett termék
    ///@param os - stream, amire kiírja a függvény az eredményt
    ///@return - keresés eredménye
    bool available(const Product& termek, std::ostream& os = std::cout) const{
        setlocale(LC_CTYPE, "HUN");
        bool elerheto = false; ///Keresés eredménye
        os<<std::endl<<"****  AVAILABLE  ****"<<std::endl<<std::endl;
        for(size_t i=0;i < stockdb;i++){
            
            ///Termék adatainak kiírása a kapott streamre, ha megtaláltuk a raktárban
            if(*stock[i]==termek){
                os<<*stock[i];
                ///Mennyiséget nem minden függvény írja ki, így ahol kell, ott getQ segítségével valósul mega  kiírása
                os<<"Mennyiség: " <<stock[i]->getQ()<<std::endl;
                elerheto = true;
                break;
            }
        }
        ///Ha nem találtuk meg, azt is kiírjuk
        if(elerheto == false){
            os<<"Az adott termék nem elérhető"<<std::endl;
        }
        os<<std::endl<<"****  AVAILABLE  ****"<<std::endl<<std::endl;
        return elerheto;
    }
    
    ///Kosárhoz adja a kiválasztott terméket
    ///@param termek - kiválasztott termék
    ///@param db - darabszám
    void pick(const Product& termek, int db, std::ostream& os= std::cout){
        ///1. Kosárban lévő hely ellenőrzése
        bool talalat = false;
        if(listdb+db<=max && db > 0){
            ///2. Kiválasztott termék megkeresése, és az elérhető mennyiség ellenőrzése
            for(size_t i=0;i < stockdb;i++){
                 if(*stock[i]==termek && stock[i]->getQ()>=db){
                    ///3.Annyiszor adjuk hozzá a kosárhoz, ahány darabot kért a vásárló
                    
                    for(int f=0;f<db;f++){
                        list[listdb] = stock[i];
                        stock[i]->decreaseQ(1);
                        listdb++;
                    }
                    talalat = true;
                    break;
                }
            }
            ///Tájékoztatást adunk a keresés eredményéről
            if(talalat==true){
                os<<std::endl<<"****  PICK  ****"<<std::endl<<std::endl;
                os<<"A kiválasztott termék sikeresen hozzáadva a kosárhoz"<<std::endl;
                os<<std::endl<<"****  PICK  ****"<<std::endl<<std::endl;
            }
            else{
                os<<std::endl<<"****  PICK  ****"<<std::endl<<std::endl;
                os<<"Az adott mennyiségű termék nem elérhető a raktárban"<<std::endl;
                os<<std::endl<<"****  PICK  ****"<<std::endl<<std::endl;
            }
        }
        ///Ha nem fér bele a rendelés a kosárba, akkor kivétel dobás
        else{
            throw "A megadott mennyiség helytelen / nem fér bele a kosárba";
        }
        
    }
    
    ///Kosárban lévő termékek összegzése
    ///@param os - stream, amire kiírja függvény az összegzést
    void checkOut(std::ostream& os=std::cout) const{
        setlocale(LC_CTYPE, "HUN");
        double sum=0;    ///végösszeg: sum
        os<<std::endl<<std::endl<<"****  CHECKOUT  ****"<<std::endl<<std::endl;
        ///Kosárban lévő termékek adatainak kiírása a kapott streamre
        for(size_t i=0;i < listdb;i++){
            os<<i<<". termék: "<<std::endl;
            os<< *list[i];
            os<<std::endl;
            ///Végösszeg számítása
            if(list[i]->getSale()<100){
                sum+= (double)list[i]->getPrice()*((100.0-(double)list[i]->getSale())/100);
            }
            else{
                sum+= (double)list[i]->getPrice();
            }
        }
        ///Végösszeg kiírása
        os<<std::endl<<"Összesen: "<<sum<<" Ft"<<std::endl;
        os<<std::endl<<std::endl<<"****  CHECKOUT  ****"<<std::endl<<std::endl;
    }
    
    ///Új termék bevétele a raktárba
    ///A termékek dinamikusan vannak tárolva
    ///A pointer, amit kap a függvény, dinamikusan foglalt memóriaterületre mutat
    ///@param ujelem - új termék
    void makeStock(Product* ujelem){
        ///1. Raktárban lévő hely ellenőrzése
        if(stockdb<MAX){
            ///Új elem hozzáadása, ha van hely
            stock[stockdb] = ujelem;
            stockdb++;
        }
        ///Ha tele van a raktár, akkor kivétel dobás
        else{
            delete ujelem;
            throw "Tele van a raktár";
        }
    }
    
    ///Vásárlást befejező függvény
    ///A vásárlás összegzését a kapott fájlba írja ki
    ///@param buy - vásárlás megerősítése/elutasítása
    ///@param ki output fájl
    void endShopping(bool buy,std::ostream& ki = std::cout){
        setlocale(LC_CTYPE, "HUN");
            ///Vásárlás esetén a következők:
            if(buy == true){
                ///1. Kosárban lévő elemek kiírása
                checkOut(ki);
                ///2. Kosár kiürítése
                for(size_t i=0; i<listdb;i++){
                    list[i]=NULL;
                }
                listdb=0;
                
            }
            ///Vásárlás elutasítása esetén
            else{
                ///1. Kosár kiürítése
                for(size_t i=0; i<listdb;i++){
                    ///2. Termékek visszarakása
                    list[i]->decreaseQ(-1);
                    list[i]=NULL;
                }
                listdb=0;
                ///3. Tájékoztatás arról, hogy nem történt vásárlás
                ki<<"*** Vásárlás elutasítva ***"<<std::endl;
                
            }
        }
        
    
    
    ///Raktárkészlet kiírása
    ///Elsősorban a tesztelés/ellenőrzés segítése
    ///@param os - stream, amire kiírja a függvény a raktárkészletet
    void printStock(std::ostream& os = std::cout) const{
        os<<std::endl<<std::endl<<"****  STOCK  ****"<<std::endl<<std::endl;
        ///A raktáron végighaladva minden egyes termék kiírása a kapott streamre
        for(size_t i=0;i<stockdb;i++){
            os<<std::endl<<i<<". termék: "<<std::endl;
            os<<*stock[i];
            ///Mennyiséget nem minden függvény írja ki, így ahol kell, ott getQ segítségével valósul meg a kiírása
            os<<"Mennyiség: " <<stock[i]->getQ()<<std::endl;
            
        }
        os<<std::endl<<std::endl<<"****  STOCK  ****"<<std::endl<<std::endl;
    }
    
    ///getter - stockdb
    ///@return stockdb
    size_t getStockDB() const { return stockdb;}
    
    ///getter - listdb
    ///@return listdb
    size_t getListDB() const {return listdb; }
    
    ///A bevásárló lista maximális méretét adja vissza
    ///Szükség van rá, mert a bevásárló listák mérete raktáronként eltérhet
    ///@return max
    size_t getListMax() const { return max; }
    
    
    ///A raktárkapacitás  maximális értékét adja vissza
    ///Szükség van rá, mert a raktárak mérete eltérhet
    ///@return max
    size_t getStockMax() const { return MAX; }
    
    ///Destruktor
    ///Dinamikusan foglalt területet szabadítja fel
    ~Store(){
        for(size_t i= 0;i<stockdb;i++){
            delete stock[i];
        }
    }
    
    
    
    


};


#endif /* Store_h */
