

#include <iostream>
#include <cstring>
#include "Product.h"
#include "Store.hpp"
#include "Cloth.h"
#include "Shoe.h"
#include "Accessory.h"
#include <fstream>
#include "gtest_lite.h"
#include "memtrace.h"
/**
 * **PROGRAM LEÍRÁSA**
 *A program egy ruházati boltot reprezentál.
 *A vásárló a program segítségével lekérdezheti, hogy milyen termékek vannak a boltban, melyekből bevásárló listát készíthet, végül vásárolhat is.
 * Vásárlás előtt a főprogramban feltöltődik az árukészlet (dinamikus adattárolás), majd (heterogén kollekció formájában) a bevásárló listán gyűlnek össze a vásárló által kiválasztott termékek, végül a termékek megvásárlásával a raktár készlete is változik (dinamikusan foglalt terület felszabadítása).
 * Ha vásárló meggondolja magát, akkor a bevásárló lista törlődik.
 * Program nyelve magyar
 */
///** TESZT **
/**
 * **TESZT LEÍRÁSA**
 *  Két féle típusú teszt érhető el a programhoz.
 *  1. Egy gépi teszt melynek célja, hogy "megmozgassa" az osztályok függvényeit, és ellenőrizze helyes működésüket
 *  2. Egy interaktív teszt, melyet bárki kipróbálhat.
 *  A teszt egy online vásárlást szimulál.
 *  ** !!! Mivel ehhez a teszthez emberre van szükség, mondván a felhasználó utasításokkal látja el a programot,
 *  így a JPortára feltöltött verzióban ez  a teszt nem elérhető!!! **
 *
 */
///Használati útmutató
void hasznalat(){
    setlocale(LC_CTYPE, "HUN");
    
    std::cout<<"1.gomb: Adott termék elérhetőségének lekérdezése."<<std::endl;
    std::cout<<"2.gomb: Adott termék hozzáadása a kosárhoz."<<std::endl;
    std::cout<<"3.gomb: Check-out."<<std::endl;
    std::cout<<"4.gomb: Vásárlás megerősítése/elutasítása."<<std::endl;
    std::cout<<"5.gomb: Az árukészlet lekérdezése a helyes működés ellenőrzéséhez"<<std::endl;
    std::cout<<"9.gomb: Programleállítása."<<std::endl;
}

///Input fájból történő beolvasás
///@param raktar - raktár, aminek az árukészletét feltöltjük
///@param file - input fájl neve
template<size_t MAX = 100,size_t max = 20>
void bevetelezes(Store<MAX, max>& raktar, std::string file){
    std::fstream be;
    be.open(file,std::ios::in);
    
    /// Fájlmegnyitás ellenőrzése
    if(be.is_open()){
        while(!be.eof()){
            
            ///Segédváltozók a beolvasáshoz
            char type ='\0'; /// Milyen típusú a következő beolvasott termék
            int ar, mennyiseg, learazas, meretI, meretX=0;
            char meretC = 'X'; ///X-ek beolvasása miatt ez a default pl.: XL méret esetén
            std::string nev;
                    be>> type;
                    /// **SWITCH OKA**
                    ///  Mivel nem lehet tudni, hogy milyen termék következik a fájlból,
                    ///  így szükség van esetek szétválasztására, hogy a következő termék egy ruhadarab, vagy esetleg egy cipő
                    switch (type) {
                        case 'C': ///Ruha a következő beolvasott elem
                            be>> nev;///Név
                            be>> ar;///Ár;
                            be>> mennyiseg;///Mennyiség
                            be>> learazas;///Leárazás
                            while(meretC=='X'){
                                meretX++; ///X-ek száma
                                be>> meretC; /// X-ek beolvasása
                                if(meretC>='a'&& meretC<='z'){
                                    meretC -= 'a'-'A';
                                }
                            }
                            meretX--; ///a while ciklus miatt eggyel több adódik hozzá az értékéhez
                            ///Nagybetű konverzió
                            
                            raktar.makeStock(new Cloth(ar,learazas,mennyiseg,nev,meretC,meretX));
                            break;
                        case 'S': ///Cipő a következő beolvasott elem
                            be>> nev;///Név
                            be>> ar;///Ár;
                            be>> mennyiseg;///Mennyiség
                            be>> learazas;///Leárazás
                            be>> meretI; ///méret int-ben
                            raktar.makeStock(new Shoe(ar,learazas,mennyiseg,nev,meretI));
                            break;
                        case 'A': ///Kiegészítő a következő beolvasott elem
                            be>> nev;///Név
                            be>> ar;///Ár;
                            be>> mennyiseg;///Mennyiség
                            be>> learazas;///Leárazás
                            raktar.makeStock( new Accessory(ar,learazas,mennyiseg,nev));
                            break;
                        default:
                            break;
                    }
            
        }
    }
    ///Ha nem sikerült az adott fájlt megnyitni, akkor kivételkezelés
    else{
        throw "A megadott intput fájl nem található!";
    }
    be.close();
}
int main() {
    setlocale(LC_CTYPE, "HUN");
    
    //MARK: TEST 1 Accessory-const
    std::cout<<"*** OSZTÁLYOK TESZTJE ***"<<std::endl;
    std::cout<<"TEST 1"<<std::endl;
    
    ///Default értékkel létrehozott Accessory példány
    const Accessory pelda1;
    ///getPrice
    TEST(getPrice, Accessory-const){
        EXPECT_EQ(999,pelda1.getPrice()) << "Hibás getPrice()" << std::endl;
        
    }END
    ///getSale
    TEST(getSale, Accessory-const){
        EXPECT_EQ(999,pelda1.getSale()) << "Hibás getSale()" << std::endl;
        
    }END
    ///getQ
    TEST(getQ, Accessory-const){
        EXPECT_EQ(-1,pelda1.getQ()) << "Hibás getQ()" << std::endl;
        
    }END
    ///getName
    TEST(getName, Accessory-const){
        EXPECT_TRUE(pelda1.getName()=="Accessory")<<"Hibás getName()"<<std::endl;
    }END
    
    
    //MARK: TEST 2 Shoe
    std::cout<<std::endl;
    std::cout<<"TEST 2"<<std::endl;
    
    /// Részben default értékkel létrehozott Shoe példány tesztje
    Shoe pelda2(11,12,13);
    ///getPrice
    TEST(getPrice, Shoe){
        EXPECT_EQ(11,pelda2.getPrice()) << "Hibás getPrice()" << std::endl;
        
    }END
    ///getSale
    TEST(getSale, Shoe){
        EXPECT_EQ(12,pelda2.getSale()) << "Hibás getSale()" << std::endl;
        
    }END
    ///getQ
    TEST(getQ, Shoe){
        EXPECT_EQ(13,pelda2.getQ()) << "Hibás getQ()" << std::endl;
        
    }END
    ///getName
    TEST(getName, Shoe){
        EXPECT_TRUE(pelda2.getName()=="Shoe")<<"Hibás getName()"<<std::endl;
    }END
    
    
    //MARK: TEST 3 Cloth
    std::cout<<std::endl;
    std::cout<<"TEST 3"<<std::endl;
    
    ///Nem default értékekkel létrehozott Cloth példány
    Cloth pelda3(10,10,10, "T-shirt", 'L');
    ///getPrice
    TEST(getPrice, Cloth){
        EXPECT_EQ(10,pelda3.getPrice()) << "Hibás getPrice()" << std::endl;
        
    }END
    ///getSale
    TEST(getSale, Cloth){
        EXPECT_EQ(10,pelda3.getSale()) << "Hibás getSale()" << std::endl;
        
    }END
    ///getQ
    TEST(getQ, Cloth){
        EXPECT_EQ(10,pelda3.getQ()) << "Hibás getQ()" << std::endl;
        
    }END
    ///getName
    TEST(getName, Cloth){
        EXPECT_TRUE(pelda3.getName()=="T-shirt")<<"Hibás getName()"<<std::endl;
    }END
    
    
    //MARK: TEST 4 printSize()
    /// Teszt 4
    /// A korábban létrehozott objetumokom a printSize függvény tesztje
    std::cout<<std::endl;
    std::cout<<"TEST 4"<<std::endl;
    std::cout<<"printSize() teszt-pelda1:"<<std::endl;
    std::cout<<"elvárt: ONE_SIZE"<<std::endl;
    std::cout<<"aktuális: ";
    pelda1.printSize();
    std::cout<<std::endl;
    std::cout<<"printSize() teszt-pelda2:"<<std::endl;
    std::cout<<"elvárt: 0"<<std::endl;
    std::cout<<"aktuális: ";
    pelda2.printSize();
    std::cout<<std::endl;
    std::cout<<"printSize() teszt-pelda3:"<<std::endl;
    std::cout<<"elvárt: L"<<std::endl;
    std::cout<<"aktuális: ";
    pelda3.printSize();
    std::cout<<std::endl;
    
    //MARK: TEST 5
    std::cout<<std::endl;
    std::cout<<"TEST 5"<<std::endl;
    
    ///Mutatókonverzió tesztje
    Product* p = &pelda3;  ///Cloth pelda3(10,10,10, "T-shirt", 'L')
    ///getPrice
    TEST(getPrice, Mutatokonverzio){
        EXPECT_EQ(10,p->getPrice()) << "Hibás getPrice()" << std::endl;
    }END
    ///getSale
    TEST(getSale, Mutatokonverzio){
        EXPECT_EQ(10,p->getSale()) << "Hibás getSale()" << std::endl;
        
    }END
    ///getQ
    TEST(getQ, Mutatokonverzio){
        EXPECT_EQ(10,p->getQ()) << "Hibás getQ()" << std::endl;
    }END
    ///getName
    TEST(getName, Mutatokonverzio){
        EXPECT_TRUE(p->getName()=="T-shirt") << "Hibás getName()"<<std::endl;
    }END
    ///printSize
    std::cout<<"Mutatókonverzió-printSize()"<<std::endl;
    std::cout<<"elvárt: L"<<std::endl;
    std::cout<<"aktuális: ";
    p->printSize();
    std::cout<<std::endl;
    
    
    
    //MARK: TEST Raktar
    std::cout<<std::endl;
    std::cout<<"*** RAKTÁR TESZT 1 ***"<<std::endl;
    std::fstream ki;
    ki.open("Receipt.txt", std::ios::out);
    
         Store<300,50> WareHouse1;  ///raktár példány
        
        ///Store osztály függvényeinek tesztelése
        
        ///Konstruktor teszt
        
        TEST(getListDB-init, Store){
            EXPECT_EQ(size_t(0), WareHouse1.getListDB())<<"Hibás getListDB()"<<std::endl;
        }END
        TEST(getStockDB-init, Store){
            EXPECT_EQ(size_t(0), WareHouse1.getStockDB())<<"Hibás getStockDB()"<<std::endl;
        }END
    
        TEST(getStockMax, Store){
           EXPECT_EQ(size_t(300), WareHouse1.getStockMax())<<"Hibás getStockMax()"<<std::endl;
         }END
        TEST(getListkMax, Store){
           EXPECT_EQ(size_t(50), WareHouse1.getListMax())<<"Hibás getListMax()"<<std::endl;
         }END
        
        TEST(makeStock-available, Store){
            
            ///makeStock-available teszt
            
            WareHouse1.makeStock(new Cloth(10,10,10, "T-shirt", 'L'));
            WareHouse1.makeStock(new Shoe(10,20,30, "Air-Max", 40));
            WareHouse1.makeStock(new Accessory(10,20,30, "Bag"));
            EXPECT_EQ(size_t(3), WareHouse1.getStockDB())<<"Hibás getStockDB()"<<std::endl;
            EXPECT_TRUE(WareHouse1.available(pelda3)) <<"Hibás makeStock())"<<std::endl;
            EXPECT_FALSE(WareHouse1.available(pelda2)) <<"Hibás makeStock())"<<std::endl;
            
            
        }END
        TEST(pick, Store){
            
            ///pick teszt elérhető, és nem elérhető termékkel
            
            WareHouse1.pick(pelda3,2);
            EXPECT_EQ(size_t(2), WareHouse1.getListDB())<<"Hibás getListDB()"<<std::endl;
            WareHouse1.pick(pelda1,2);
            EXPECT_EQ(size_t(2), WareHouse1.getListDB())<<"Hibás getListDB()"<<std::endl;
            
        }END
        
        
        ///Fájlból olvasás
        
        TEST(Read-txt, Store){
            try{
                bevetelezes(WareHouse1, "Shipment.txt");
                
            }
            catch(const char* p){
                std::cout<<p<<std::endl;
            }
            EXPECT_EQ(size_t(14), WareHouse1.getStockDB())<<"Hibás beolvasás"<<std::endl;
        }END
        
        ///Vásárlás vége
         WareHouse1.endShopping(true, ki);
        ///Raktárkészlet ellenőrzése
         WareHouse1.printStock();
        ///Tesztraktár feltöltése majd kivétel generálás makeStock() pick()
        Store<> TesztRaktar1;
        TEST(Kivételkezelés, Store){
        
        Cloth tesztpelda(10,10,20, "Teszt",'S');
            for(int i = 0; i<100;i++){
                TesztRaktar1.makeStock(new Cloth(10,10,20, "Teszt",'S'));
            }
        for(int i = 0; i<20;i++){
            TesztRaktar1.pick(tesztpelda, 1);
        }
        /// Tele van a kosár
        EXPECT_ANY_THROW(TesztRaktar1.pick(tesztpelda, 1));
            ///Tele van a raktár
            EXPECT_ANY_THROW(TesztRaktar1.makeStock(new Shoe()));
            /// irreális  mennyiséget kérünk
            EXPECT_ANY_THROW(TesztRaktar1.pick(tesztpelda, -1));
        }ENDM
        
    
    
    
    ///MARK: Felhasználói teszt
    ///MARK: JPortára feltöltött verzió esetén nem elérhető, mert felhasználói utasításokra van szükség
    ///MARK: A felhasználói teszt ugyanazokat a függvényeket használja mint amelyeket korábbi tesztek
    /// **SWITCH OKA**
    ///  Mivel nem lehet tudni, hogy milyen termék következik a felhasználótól,
    ///  így szükség van esetek szétválasztására, hogy a következő termék egy ruhadarab, vagy esetleg egy cipő.
    
    std::cout<<"*** Felhasználói teszt ***"<<std::endl<<std::endl;
    std::cout<<std::endl;
    std::cout<<"*** RAKTÁR TESZT 2 ***"<<std::endl<<std::endl;
    std::cout<<"Köszöntöm Önt a CPP.Outletben!"<<std::endl;
    std::cout<<"Használati útmutató a következő a vásárláshoz: "<<std::endl;
    hasznalat();
    
    try{
        ///1.: A raktár feltöltése árukészlettel
        Store<200, 50> WareHouse2;
        TEST(Read-txt, Store){
            bevetelezes(WareHouse2, "Shipment.txt");
            EXPECT_EQ(size_t(11), WareHouse2.getStockDB())<<"Hibás getStockDB()"<<std::endl;
        }END
        
        
        char utasitas = '\0';
        while(1){
            hasznalat();
            std::cout<<"Adja meg a következő utasítást számát! "<<std::endl;
            std::cin>>utasitas;
            switch(utasitas){
                case '9':
                    ///case -1  :Program leállítása
                    break;
                case '1':
                    ///case 1: Store::available()
                    
                {
                    const Product *valasztas; ///ezt kapja meg a függvény, dinamikusan ideiglenesen létrehozott példány
                    
                    ///Segédváltozók a beolvasáshoz
                    char type ='\0'; // Milyen típusú a következő termék
                    int ar, learazas, meretI, meretX = 0;
                    char meretC='X'; ///X-ek beolvasása miatt ez a default pl.: XL méret esetén
                    std::string nev;
                    
                    
                    std::cout<<"Adja meg a kiválasztott termék típusát (Ruha: C, Cipő: S, Kiegészítő: A)!: ";
                    std::cin>>type;
                    //Nagybetű konverzió
                    if(type>='a'&& type<='z'){
                        type -= 'a'-'A';
                    }
                    switch(type){
                        case 'C': ///Ruhadarab
                            std::cout<<"Adja meg a kiválasztott termék nevét!: ";
                            std::cin>> nev;///Név
                            std::cout<<"Adja meg a kiválasztott termék árát!: ";
                            std::cin>> ar;///Ár;
                            std::cout<<"Adja meg a kiválasztott termékre vonatkozó kedvezményt!: ";
                            std::cin>> learazas;///Leárazás
                            std::cout<<"Adja meg a ruha méretét!: ";
                            while(meretC=='X'){
                                meretX++;  ///X-ek száma
                                std::cin>> meretC; /// X-ek beolvasása
                                if(meretC>='a'&& meretC<='z'){
                                    meretC -= 'a'-'A';
                                }
                            }
                            meretX--; ///a while ciklus miatt eggyel több adódik hozzá az értékéhez
                            ///Nagybetű konverzió
                            
                            valasztas = new Cloth(ar,learazas,1,nev,meretC,meretX);
                            WareHouse2.available(*valasztas);
                            delete valasztas;
                            break;
                        case 'S':
                            std::cout<<"Adja meg a kiválasztott termék nevét!: ";
                            std::cin>> nev;///Név
                            std::cout<<"Adja meg a kiválasztott termék árát!: ";
                            std::cin>> ar;///Ár;
                            std::cout<<"Adja meg a kiválasztott termékre vonatkozó kedvezményt!: ";
                            std::cin>> learazas;///Leárazás
                            std::cout<<"Adja meg a cipő méretét!: ";
                            std::cin>> meretI; /// méret int-ben
                            valasztas = new Shoe(ar,learazas,1,nev,meretI);
                            WareHouse2.available(*valasztas);
                            delete valasztas;
                            break;
                        case 'A':
                            std::cout<<"Adja meg a kiválasztott termék nevét!: ";
                            std::cin>> nev;///Név
                            std::cout<<"Adja meg a kiválasztott termék árát!: ";
                            std::cin>> ar;///Ár;
                            std::cout<<"Adja meg a kiválasztott termékre vonatkozó kedvezményt!: ";
                            std::cin>> learazas;///Leárazás
                            valasztas = new Accessory(ar,learazas,1,nev);
                            WareHouse2.available(*valasztas);
                            delete valasztas;
                            break;
                        default:
                            std::cout<<"Érvénytelen termék típus!"<<std::endl;
                    }
                    break;
                }
                case '2':
                    ///case2: Store::pick()
                {
                    const Product *valasztas; ///ezt kapja meg a függvény, dinamikusan ideiglenesen létrehozott példány
                    ///Segédváltozók a beolvasáshoz
                    char type ='\0'; // Milyen típusú a következő termék
                    int ar, mennyiseg, learazas, meretI, meretX=0 ;
                    char meretC='X';
                    std::string nev;
                    
                    
                    std::cout<<"Adja meg a kiválasztott termék típusát (Ruha: C, Cipő: S, Kiegészítő: A)!: ";
                    std::cin>>type;
                    if(type>='a'&& type<='z'){
                        type -= 'a'-'A';
                    }
                    switch(type){
                        case 'C': ///Ruhadarab
                            std::cout<<"Adja meg a kiválasztott termék nevét!: ";
                            std::cin>> nev;///Név
                            std::cout<<"Adja meg a kiválasztott termék árát!: ";
                            std::cin>> ar;///Ár;
                            std::cout<<"Adja meg a kívánt mennyiséget!: ";
                            std::cin>> mennyiseg;///Mennyiség
                            std::cout<<"Adja meg a kiválasztott termékre vonatkozó kedvezményt!: ";
                            std::cin>> learazas;///Leárazás
                            std::cout<<"Adja meg a ruha méretét!: ";
                            while(meretC=='X'){
                                meretX++;  ///X-ek száma
                                std::cin>> meretC; /// X-ek beolvasása
                                if(meretC>='a'&& meretC<='z'){
                                    meretC -= 'a'-'A';
                                }
                            }
                            meretX--; ///a while ciklus miatt eggyel több adódik hozzá az értékéhez
                            ///Nagybetű konverzió
                            
                            valasztas = new Cloth(ar,learazas,1,nev,meretC,meretX);
                            WareHouse2.pick(*valasztas, mennyiseg);
                            delete valasztas;
                            break;
                        case 'S':
                            std::cout<<"Adja meg a kiválasztott termék nevét!: ";
                            std::cin>> nev;///Név
                            std::cout<<"Adja meg a kiválasztott termék árát!: ";
                            std::cin>> ar;///Ár;
                            std::cout<<"Adja meg a kívánt mennyiséget!: ";
                            std::cin>> mennyiseg;///Mennyiség
                            std::cout<<"Adja meg a kiválasztott termékre vonatkozó kedvezményt!: ";
                            std::cin>> learazas;///Leárazás
                            std::cout<<"Adja meg a cipő méretét!: ";
                            std::cin>> meretI; /// méret int-ben
                            valasztas = new Shoe(ar,learazas,1,nev,meretI);
                            WareHouse2.pick(*valasztas, mennyiseg);
                            delete valasztas;
                            break;
                        case 'A':
                            std::cout<<"Adja meg a kiválasztott termék nevét!: ";
                            std::cin>> nev;///Név
                            std::cout<<"Adja meg a kiválasztott termék árát!: ";
                            std::cin>> ar;///Ár;
                            std::cout<<"Adja meg a kívánt mennyiséget!: ";
                            std::cin>> mennyiseg;///Mennyiség
                            std::cout<<"Adja meg a kiválasztott termékre vonatkozó kedvezményt!: ";
                            std::cin>> learazas;///Leárazás
                            valasztas = new Accessory(ar,learazas,1,nev);
                            WareHouse2.pick(*valasztas, mennyiseg);
                            delete valasztas;
                            break;
                        default:
                            std::cout<<"Érvénytelen termék típus!"<<std::endl;
                    }
                    
                    
                    
                    
                    break;
                }
                    
                case '3':
                    ///case 3: Store::checkOut()
                    WareHouse2.checkOut();
                    break;
                case '4':
                    ///case 4: Store::endShopping()
                {
                    int dontes=0;
                    std::cout<<"Vásárlás befejezése: Megerősítés: 1, Elutasítás: 2"<<std::endl;
                    std::cin>>dontes;
                    switch(dontes){
                        case 1:
                            WareHouse2.endShopping(true, ki);
                            std::cout<<std::endl<<"Köszönjük a vásárlást!"<<std::endl<<std::endl;
                            break;
                        case 2:
                            WareHouse2.endShopping(false, ki);
                            std::cout<<std::endl<<"Vásárlás elutasítva"<<std::endl<<std::endl;
                            break;
                        default:
                            std::cout<<"Helytelen sorszámú utasítás!"<<std::endl;
                            
                    }
                    break;
                    
                }
                    ///case 5: Store::printStock()
                case '5':
                    WareHouse2.printStock();
                    break;
                default:
                    std::cout<<"Helytelen sorszámú utasítás!"<<std::endl;
                    
            }
            if(utasitas== '9'){
                break;
            }
        }
    }
        
         catch(const char* p){
         std::cout<<p<<std::endl;
         }
    ki.flush();
    ki.close();
     return 0;
    
}
