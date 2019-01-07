-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-01-07 20:28:28.533

-- tables
-- Table: Adres
CREATE TABLE Adres (
    IdAdres integer  NOT NULL,
    Kraj varchar2(50)  NOT NULL,
    Wojewodztwo varchar2(50)  NOT NULL,
    Miasto varchar2(50)  NOT NULL,
    KodPocztowy varchar2(10)  NOT NULL,
    Ulica varchar2(100)  NOT NULL,
    NrDomu varchar2(10)  NOT NULL,
    NrMieszkania varchar2(10)  NULL,
    AdresDictKey varchar2(2)  NOT NULL,
    CONSTRAINT Adres_pk PRIMARY KEY (IdAdres)
) ;

-- Table: AdresDict
CREATE TABLE AdresDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT AdresDict_pk PRIMARY KEY (Key)
) ;

-- Table: BankDict
CREATE TABLE BankDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    IdAdres integer  NOT NULL,
    CONSTRAINT BankDict_pk PRIMARY KEY (Key)
) ;

-- Table: Email
CREATE TABLE Email (
    IdEmail integer  NOT NULL,
    Adres varchar2(50)  NOT NULL,
    CzyGlowny varchar2(1)  NOT NULL,
    Klient_IdKlient integer  NOT NULL,
    CONSTRAINT Email_pk PRIMARY KEY (IdEmail)
) ;

-- Table: Identyfikator
CREATE TABLE Identyfikator (
    IdIdentyfikator integer  NOT NULL,
    Nr varchar2(50)  NOT NULL,
    IdentyfikatorDictKey varchar2(2)  NOT NULL,
    CONSTRAINT Identyfikator_pk PRIMARY KEY (IdIdentyfikator)
) ;

-- Table: IdentyfikatorDict
CREATE TABLE IdentyfikatorDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT IdentyfikatorDict_pk PRIMARY KEY (Key)
) ;

-- Table: IdentyfikatorKonta
CREATE TABLE IdentyfikatorKonta (
    IdIdentyfikatorKonta integer  NOT NULL,
    NrKonta integer  NOT NULL,
    BankDictKey varchar2(2)  NOT NULL,
    IdAdres integer  NULL,
    CONSTRAINT IdentyfikatorKonta_pk PRIMARY KEY (IdIdentyfikatorKonta)
) ;

-- Table: Karta
CREATE TABLE Karta (
    IdKarta integer  NOT NULL,
    NrKarty integer  NOT NULL,
    DziennyLimitTransakcji float(10)  NULL,
    LimitDebetu float(10)  NOT NULL,
    CzyPlatnosciMobilne varchar2(1)  NOT NULL,
    CzyPlatnosciZblizeniowe varchar2(1)  NOT NULL,
    DataWaznosci date  NOT NULL,
    CzyDezaktywowana varchar2(1)  NOT NULL,
    KartaDictKey varchar2(2)  NOT NULL,
    IdKlient integer  NOT NULL,
    IdRachunek integer  NOT NULL,
    CONSTRAINT Karta_pk PRIMARY KEY (IdKarta)
) ;

-- Table: KartaDict
CREATE TABLE KartaDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT KartaDict_pk PRIMARY KEY (Key)
) ;

-- Table: KategoriaDict
CREATE TABLE KategoriaDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT KategoriaDict_pk PRIMARY KEY (Key)
) ;

-- Table: Klient
CREATE TABLE Klient (
    IdKlient integer  NOT NULL,
    Imie varchar2(50)  NOT NULL,
    DrugieImie varchar2(50)  NULL,
    Nazwisko varchar2(100)  NOT NULL,
    NrPesel integer  NULL,
    ImieOjca varchar2(50)  NOT NULL,
    ImieMatki varchar2(50)  NOT NULL,
    NazwiskoRodoweMatki varchar2(50)  NOT NULL,
    DataUrodzenia date  NOT NULL,
    MiejsceUrodzenia varchar2(100)  NOT NULL,
    DataOdejsciaKlienta date  NULL,
    RodoFlag varchar2(1)  NOT NULL,
    ObywatelstwoDictKey varchar2(2)  NOT NULL,
    StanCywilnyDictKey varchar2(2)  NOT NULL,
    IdIdentyfikator integer  NOT NULL,
    IdUrzadSkarbowy integer  NOT NULL,
    IdAdres integer  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (IdKlient)
) ;

-- Table: Klient_Lokata
CREATE TABLE Klient_Lokata (
    IdKlient_Lokata integer  NOT NULL,
    Kwota float(30)  NOT NULL,
    Okres integer  NOT NULL,
    DataZalozenia date  NOT NULL,
    IdKlient integer  NOT NULL,
    IdLokata integer  NOT NULL,
    CONSTRAINT Klient_Lokata_pk PRIMARY KEY (IdKlient_Lokata)
) ;

-- Table: Klient_Rachunek
CREATE TABLE Klient_Rachunek (
    IdKlient_Rachunek integer  NOT NULL,
    IdKlient integer  NOT NULL,
    IdRachunek integer  NOT NULL,
    CONSTRAINT Klient_Rachunek_pk PRIMARY KEY (IdKlient_Rachunek)
) ;

-- Table: Lokata
CREATE TABLE Lokata (
    IdLokata integer  NOT NULL,
    Oprocentowanie float(10)  NOT NULL,
    KwotaMin float(10)  NOT NULL,
    KwotaMax float(10)  NOT NULL,
    OkresMin integer  NOT NULL,
    OkresMax integer  NOT NULL,
    PoczatekDostepnosci date  NOT NULL,
    KoniecDostepnosci date  NOT NULL,
    CONSTRAINT Lokata_pk PRIMARY KEY (IdLokata)
) ;

-- Table: ObywatelstwoDict
CREATE TABLE ObywatelstwoDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT ObywatelstwoDict_pk PRIMARY KEY (Key)
) ;

-- Table: Operacja
CREATE TABLE Operacja (
    IdOperacja integer  NOT NULL,
    DziennyNrOperacji integer  NOT NULL,
    Kwota float(30)  NOT NULL,
    Opis varchar2(500)  NOT NULL,
    CzasZlecenia timestamp  NOT NULL,
    DataZaksiegowania date  NOT NULL,
    RodzajOperacjiDictKey varchar2(2)  NOT NULL,
    OperacjaDictKey varchar2(2)  NOT NULL,
    KategoriaDictKey varchar2(2)  NOT NULL,
    PlatnoscDictKey varchar2(2)  NOT NULL,
    IdRachunek integer  NOT NULL,
    IdIdentyfikatorKonta integer  NOT NULL,
    IdKlient integer  NOT NULL,
    CONSTRAINT Operacja_pk PRIMARY KEY (IdOperacja)
) ;

-- Table: OperacjaDict
CREATE TABLE OperacjaDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT OperacjaDict_pk PRIMARY KEY (Key)
) ;

-- Table: PlatnoscDict
CREATE TABLE PlatnoscDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT PlatnoscDict_pk PRIMARY KEY (Key)
) ;

-- Table: Rachunek
CREATE TABLE Rachunek (
    IdRachunek integer  NOT NULL,
    NrRachunku integer  NOT NULL,
    StanKonta float(30)  NOT NULL,
    Oprocentowanie float  NOT NULL,
    DataZamknieciaRachunku date  NULL,
    RachunekDictKey varchar2(2)  NOT NULL,
    CONSTRAINT Rachunek_pk PRIMARY KEY (IdRachunek)
) ;

-- Table: RachunekDict
CREATE TABLE RachunekDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT RachunekDict_pk PRIMARY KEY (Key)
) ;

-- Table: Rachunek_Operacja
CREATE TABLE Rachunek_Operacja (
    IdRachunek_Operacja integer  NOT NULL,
    IdRachunek integer  NOT NULL,
    IdOperacja integer  NOT NULL,
    CONSTRAINT Rachunek_Operacja_pk PRIMARY KEY (IdRachunek_Operacja)
) ;

-- Table: RodzajOperacjiDict
CREATE TABLE RodzajOperacjiDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT RodzajOperacjiDict_pk PRIMARY KEY (Key)
) ;

-- Table: StanCywilnyDict
CREATE TABLE StanCywilnyDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(50)  NOT NULL,
    CONSTRAINT StanCywilnyDict_pk PRIMARY KEY (Key)
) ;

-- Table: Telefon
CREATE TABLE Telefon (
    IdTelefon integer  NOT NULL,
    Numer varchar2(20)  NOT NULL,
    CzyGlowny varchar2(1)  NOT NULL,
    Klient_IdKlient integer  NOT NULL,
    CONSTRAINT Telefon_pk PRIMARY KEY (IdTelefon)
) ;

-- Table: Urzad_skarbowy
CREATE TABLE Urzad_skarbowy (
    IdUrzadSkarbowy integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    IdAdres integer  NOT NULL,
    CONSTRAINT Urzad_skarbowy_pk PRIMARY KEY (IdUrzadSkarbowy)
) ;

-- foreign keys
-- Reference: Adres_Dict (table: Adres)
ALTER TABLE Adres ADD CONSTRAINT Adres_Dict
    FOREIGN KEY (AdresDictKey)
    REFERENCES AdresDict (Key);

-- Reference: BankDict_Adres (table: BankDict)
ALTER TABLE BankDict ADD CONSTRAINT BankDict_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- Reference: Email_Klient (table: Email)
ALTER TABLE Email ADD CONSTRAINT Email_Klient
    FOREIGN KEY (Klient_IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: IdentyfikatorKonta_Adres (table: IdentyfikatorKonta)
ALTER TABLE IdentyfikatorKonta ADD CONSTRAINT IdentyfikatorKonta_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- Reference: IdentyfikatorKonta_BankDict (table: IdentyfikatorKonta)
ALTER TABLE IdentyfikatorKonta ADD CONSTRAINT IdentyfikatorKonta_BankDict
    FOREIGN KEY (BankDictKey)
    REFERENCES BankDict (Key);

-- Reference: Identyfikator_Dict (table: Identyfikator)
ALTER TABLE Identyfikator ADD CONSTRAINT Identyfikator_Dict
    FOREIGN KEY (IdentyfikatorDictKey)
    REFERENCES IdentyfikatorDict (Key);

-- Reference: Karta_KartaDict (table: Karta)
ALTER TABLE Karta ADD CONSTRAINT Karta_KartaDict
    FOREIGN KEY (KartaDictKey)
    REFERENCES KartaDict (Key);

-- Reference: Karta_Klient (table: Karta)
ALTER TABLE Karta ADD CONSTRAINT Karta_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Karta_Rachunek (table: Karta)
ALTER TABLE Karta ADD CONSTRAINT Karta_Rachunek
    FOREIGN KEY (IdRachunek)
    REFERENCES Rachunek (IdRachunek);

-- Reference: Klient_Adres (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- Reference: Klient_Identyfikator (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Identyfikator
    FOREIGN KEY (IdIdentyfikator)
    REFERENCES Identyfikator (IdIdentyfikator);

-- Reference: Klient_Lokata_Klient (table: Klient_Lokata)
ALTER TABLE Klient_Lokata ADD CONSTRAINT Klient_Lokata_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Klient_Lokata_Lokata (table: Klient_Lokata)
ALTER TABLE Klient_Lokata ADD CONSTRAINT Klient_Lokata_Lokata
    FOREIGN KEY (IdLokata)
    REFERENCES Lokata (IdLokata);

-- Reference: Klient_ObywatelstwoDict (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_ObywatelstwoDict
    FOREIGN KEY (ObywatelstwoDictKey)
    REFERENCES ObywatelstwoDict (Key);

-- Reference: Klient_Rachunek_Klient (table: Klient_Rachunek)
ALTER TABLE Klient_Rachunek ADD CONSTRAINT Klient_Rachunek_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Klient_Rachunek_Rachunek (table: Klient_Rachunek)
ALTER TABLE Klient_Rachunek ADD CONSTRAINT Klient_Rachunek_Rachunek
    FOREIGN KEY (IdRachunek)
    REFERENCES Rachunek (IdRachunek);

-- Reference: Klient_StanCywilnyDict (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_StanCywilnyDict
    FOREIGN KEY (StanCywilnyDictKey)
    REFERENCES StanCywilnyDict (Key);

-- Reference: Klient_Urzad_skarbowy (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Urzad_skarbowy
    FOREIGN KEY (IdUrzadSkarbowy)
    REFERENCES Urzad_skarbowy (IdUrzadSkarbowy);

-- Reference: Operacja_IdentyfikatorKonta (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_IdentyfikatorKonta
    FOREIGN KEY (IdIdentyfikatorKonta)
    REFERENCES IdentyfikatorKonta (IdIdentyfikatorKonta);

-- Reference: Operacja_KategoriaDict (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_KategoriaDict
    FOREIGN KEY (KategoriaDictKey)
    REFERENCES KategoriaDict (Key);

-- Reference: Operacja_Klient (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Operacja_OperacjaDict (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_OperacjaDict
    FOREIGN KEY (OperacjaDictKey)
    REFERENCES OperacjaDict (Key);

-- Reference: Operacja_PlatnoscDict (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_PlatnoscDict
    FOREIGN KEY (PlatnoscDictKey)
    REFERENCES PlatnoscDict (Key);

-- Reference: Operacja_Rachunek (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_Rachunek
    FOREIGN KEY (IdRachunek)
    REFERENCES Rachunek (IdRachunek);

-- Reference: Operacja_RodzajOperacjiDict (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_RodzajOperacjiDict
    FOREIGN KEY (RodzajOperacjiDictKey)
    REFERENCES RodzajOperacjiDict (Key);

-- Reference: Rachunek_Operacja_Operacja (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja ADD CONSTRAINT Rachunek_Operacja_Operacja
    FOREIGN KEY (IdOperacja)
    REFERENCES Operacja (IdOperacja);

-- Reference: Rachunek_Operacja_Rachunek (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja ADD CONSTRAINT Rachunek_Operacja_Rachunek
    FOREIGN KEY (IdRachunek)
    REFERENCES Rachunek (IdRachunek);

-- Reference: Rachunek_RachunekDict (table: Rachunek)
ALTER TABLE Rachunek ADD CONSTRAINT Rachunek_RachunekDict
    FOREIGN KEY (RachunekDictKey)
    REFERENCES RachunekDict (Key);

-- Reference: Telefon_Klient (table: Telefon)
ALTER TABLE Telefon ADD CONSTRAINT Telefon_Klient
    FOREIGN KEY (Klient_IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Urzad_skarbowy_Adres (table: Urzad_skarbowy)
ALTER TABLE Urzad_skarbowy ADD CONSTRAINT Urzad_skarbowy_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- End of file.

