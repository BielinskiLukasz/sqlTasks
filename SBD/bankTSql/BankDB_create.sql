-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-05-18 11:04:35.482

-- tables
-- Table: Adres
CREATE TABLE Adres (
    IdAdres int  NOT NULL,
    Kraj varchar(50)  NOT NULL,
    Wojewodztwo varchar(50)  NOT NULL,
    Miasto varchar(50)  NOT NULL,
    KodPocztowy varchar(10)  NOT NULL,
    Ulica varchar(100)  NOT NULL,
    NrDomu varchar(10)  NOT NULL,
    NrMieszkania varchar(10)  NULL,
    CONSTRAINT Adres_pk PRIMARY KEY  (IdAdres)
);

-- Table: BankDict
CREATE TABLE BankDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    IdAdres int  NOT NULL,
    CONSTRAINT BankDict_pk PRIMARY KEY  ("Key")
);

-- Table: Email
CREATE TABLE Email (
    IdEmail int  NOT NULL,
    Adres varchar(50)  NOT NULL,
    CzyGlowny bit  NOT NULL,
    IdKlient int  NOT NULL,
    CONSTRAINT Email_pk PRIMARY KEY  (IdEmail)
);

-- Table: Identyfikator
CREATE TABLE Identyfikator (
    IdIdentyfikator int  NOT NULL,
    Nr varchar(50)  NOT NULL,
    IdentyfikatorDictKey varchar(3)  NOT NULL,
    CONSTRAINT Identyfikator_pk PRIMARY KEY  (IdIdentyfikator)
);

-- Table: IdentyfikatorDict
CREATE TABLE IdentyfikatorDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT IdentyfikatorDict_pk PRIMARY KEY  ("Key")
);

-- Table: IdentyfikatorKonta
CREATE TABLE IdentyfikatorKonta (
    IdIdentyfikatorKonta int  NOT NULL,
    NrKonta bigint  NOT NULL,
    BankDictKey varchar(3)  NOT NULL,
    IdAdres int  NULL,
    CONSTRAINT IdentyfikatorKonta_pk PRIMARY KEY  (IdIdentyfikatorKonta)
);

-- Table: Karta
CREATE TABLE Karta (
    IdKarta int  NOT NULL,
    NrKarty bigint  NOT NULL,
    DziennyLimitTransakcji float(10)  NULL,
    LimitDebetu float(10)  NOT NULL,
    CzyPlatnosciMobilne bit  NOT NULL,
    CzyPlatnosciZblizeniowe bit  NOT NULL,
    DataWaznosci date  NOT NULL,
    CzyDezaktywowana bit  NOT NULL,
    KartaDictK varchar(3)  NOT NULL,
    IdKlient_Rachunek int  NOT NULL,
    CONSTRAINT Karta_pk PRIMARY KEY  (IdKarta)
);

-- Table: KartaDict
CREATE TABLE KartaDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT KartaDict_pk PRIMARY KEY  ("Key")
);

-- Table: KategoriaDict
CREATE TABLE KategoriaDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT KategoriaDict_pk PRIMARY KEY  ("Key")
);

-- Table: Klient
CREATE TABLE Klient (
    IdKlient int  NOT NULL,
    Imie varchar(50)  NOT NULL,
    DrugieImie varchar(50)  NULL,
    Nazwisko varchar(100)  NOT NULL,
    NrPesel bigint  NULL,
    ImieOjca varchar(50)  NOT NULL,
    ImieMatki varchar(50)  NOT NULL,
    NazwiskoRodoweMatki varchar(50)  NOT NULL,
    DataUrodzenia date  NOT NULL,
    MiejsceUrodzenia varchar(100)  NOT NULL,
    DataOdejsciaKlienta date  NULL,
    RodoFlag bit  NOT NULL,
    ObywatelstwoDictKey varchar(3)  NOT NULL,
    StanCywilnyDictKey varchar(3)  NOT NULL,
    IdIdentyfikator int  NOT NULL,
    IdUrzadSkarbowy int  NOT NULL,
    IdAdresZamieszkania int  NOT NULL,
    IdAdresZameldowania int  NOT NULL,
    IdAdresKorespondencyjny int  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY  (IdKlient)
);

-- Table: Klient_Lokata
CREATE TABLE Klient_Lokata (
    IdKlient_Lokata int  NOT NULL,
    Kwota float(30)  NOT NULL,
    Okres int  NOT NULL,
    DataZalozenia date  NOT NULL,
    IdKlient int  NOT NULL,
    IdLokata int  NOT NULL,
    CONSTRAINT Klient_Lokata_pk PRIMARY KEY  (IdKlient_Lokata)
);

-- Table: Klient_Rachunek
CREATE TABLE Klient_Rachunek (
    IdKlient_Rachunek int  NOT NULL,
    IdKlient int  NOT NULL,
    IdRachunek int  NOT NULL,
    CONSTRAINT Klient_Rachunek_pk PRIMARY KEY  (IdKlient_Rachunek)
);

-- Table: Lokata
CREATE TABLE Lokata (
    IdLokata int  NOT NULL,
    Oprocentowanie float(10)  NOT NULL,
    KwotaMin float(10)  NOT NULL,
    KwotaMax float(10)  NOT NULL,
    OkresMin int  NOT NULL,
    OkresMax int  NOT NULL,
    PoczatekDostepnosci date  NOT NULL,
    KoniecDostepnosci date  NOT NULL,
    CONSTRAINT Lokata_pk PRIMARY KEY  (IdLokata)
);

-- Table: ObywatelstwoDict
CREATE TABLE ObywatelstwoDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT ObywatelstwoDict_pk PRIMARY KEY  ("Key")
);

-- Table: Operacja
CREATE TABLE Operacja (
    IdOperacja int  NOT NULL,
    Kwota float(30)  NOT NULL,
    Opis varchar(500)  NOT NULL,
    DataZaksiegowania date  NOT NULL,
    IdIdentyfikatorKonta int  NULL,
    CONSTRAINT Operacja_pk PRIMARY KEY  (IdOperacja)
);

-- Table: OperacjaWychodzacaDane
CREATE TABLE OperacjaWychodzacaDane (
    IdOperacjaWychodzacaDane int  NOT NULL,
    CzasZlecenia datetime  NOT NULL,
    PlatnoscDictKey varchar(3)  NULL,
    CONSTRAINT OperacjaWychodzacaDane_pk PRIMARY KEY  (IdOperacjaWychodzacaDane)
);

-- Table: PlatnoscDict
CREATE TABLE PlatnoscDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT PlatnoscDict_pk PRIMARY KEY  ("Key")
);

-- Table: Rachunek
CREATE TABLE Rachunek (
    IdRachunek int  NOT NULL,
    NrRachunku bigint  NOT NULL,
    StanKonta float(30)  NOT NULL,
    Oprocentowanie float  NOT NULL,
    DataZamknieciaRachunku date  NULL,
    RachunekDictKey varchar(3)  NOT NULL,
    CONSTRAINT Rachunek_pk PRIMARY KEY  (IdRachunek)
);

-- Table: RachunekDict
CREATE TABLE RachunekDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT RachunekDict_pk PRIMARY KEY  ("Key")
);

-- Table: Rachunek_Operacja
CREATE TABLE Rachunek_Operacja (
    IdRachunek_Operacja int  NOT NULL,
    DziennyNrOperacji int  NOT NULL,
    IdRachunek int  NOT NULL,
    IdOperacja int  NOT NULL,
    RodzajOperacjiDictKey varchar(3)  NOT NULL,
    KategoriaDictKey varchar(3)  NULL,
    IdKlient int  NULL,
    IdOperacjaWychodzacaDane int  NULL,
    CONSTRAINT Rachunek_Operacja_pk PRIMARY KEY  (IdRachunek_Operacja)
);

-- Table: RodzajOperacjiDict
CREATE TABLE RodzajOperacjiDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT RodzajOperacjiDict_pk PRIMARY KEY  ("Key")
);

-- Table: StanCywilnyDict
CREATE TABLE StanCywilnyDict (
    "Key" varchar(3)  NOT NULL,
    Value varchar(50)  NOT NULL,
    CONSTRAINT StanCywilnyDict_pk PRIMARY KEY  ("Key")
);

-- Table: Telefon
CREATE TABLE Telefon (
    IdTelefon int  NOT NULL,
    Numer varchar(20)  NOT NULL,
    CzyGlowny varchar(1)  NOT NULL,
    IdKlient int  NOT NULL,
    CONSTRAINT Telefon_pk PRIMARY KEY  (IdTelefon)
);

-- Table: Urzad_skarbowy
CREATE TABLE Urzad_skarbowy (
    IdUrzadSkarbowy int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    IdAdres int  NOT NULL,
    CONSTRAINT Urzad_skarbowy_pk PRIMARY KEY  (IdUrzadSkarbowy)
);

-- foreign keys
-- Reference: BankDict_Adres (table: BankDict)
ALTER TABLE BankDict ADD CONSTRAINT BankDict_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- Reference: Email_Klient (table: Email)
ALTER TABLE Email ADD CONSTRAINT Email_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: IdentyfikatorKonta_Adres (table: IdentyfikatorKonta)
ALTER TABLE IdentyfikatorKonta ADD CONSTRAINT IdentyfikatorKonta_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- Reference: IdentyfikatorKonta_BankDict (table: IdentyfikatorKonta)
ALTER TABLE IdentyfikatorKonta ADD CONSTRAINT IdentyfikatorKonta_BankDict
    FOREIGN KEY (BankDictKey)
    REFERENCES BankDict ("Key");

-- Reference: Identyfikator_Dict (table: Identyfikator)
ALTER TABLE Identyfikator ADD CONSTRAINT Identyfikator_Dict
    FOREIGN KEY (IdentyfikatorDictKey)
    REFERENCES IdentyfikatorDict ("Key");

-- Reference: Karta_KartaDict (table: Karta)
ALTER TABLE Karta ADD CONSTRAINT Karta_KartaDict
    FOREIGN KEY (KartaDictK)
    REFERENCES KartaDict ("Key");

-- Reference: Karta_Klient_Rachunek (table: Karta)
ALTER TABLE Karta ADD CONSTRAINT Karta_Klient_Rachunek
    FOREIGN KEY (IdKlient_Rachunek)
    REFERENCES Klient_Rachunek (IdKlient_Rachunek);

-- Reference: KategoriaDict_Rachunek_Operacja (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja ADD CONSTRAINT KategoriaDict_Rachunek_Operacja
    FOREIGN KEY (KategoriaDictKey)
    REFERENCES KategoriaDict ("Key");

-- Reference: Klient_AdresKorespondencyjny (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_AdresKorespondencyjny
    FOREIGN KEY (IdAdresKorespondencyjny)
    REFERENCES Adres (IdAdres);

-- Reference: Klient_AdresZameldowania (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_AdresZameldowania
    FOREIGN KEY (IdAdresZameldowania)
    REFERENCES Adres (IdAdres);

-- Reference: Klient_AdresZamieszkania (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_AdresZamieszkania
    FOREIGN KEY (IdAdresZamieszkania)
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
    REFERENCES ObywatelstwoDict ("Key");

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
    REFERENCES StanCywilnyDict ("Key");

-- Reference: Klient_Urzad_skarbowy (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Urzad_skarbowy
    FOREIGN KEY (IdUrzadSkarbowy)
    REFERENCES Urzad_skarbowy (IdUrzadSkarbowy);

-- Reference: OperacjaWychodzacaDane_Rachunek_Operacja (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja ADD CONSTRAINT OperacjaWychodzacaDane_Rachunek_Operacja
    FOREIGN KEY (IdOperacjaWychodzacaDane)
    REFERENCES OperacjaWychodzacaDane (IdOperacjaWychodzacaDane);

-- Reference: Operacja_IdentyfikatorKonta (table: Operacja)
ALTER TABLE Operacja ADD CONSTRAINT Operacja_IdentyfikatorKonta
    FOREIGN KEY (IdIdentyfikatorKonta)
    REFERENCES IdentyfikatorKonta (IdIdentyfikatorKonta);

-- Reference: PlatnoscDict_OperacjaWychodzacaDane (table: OperacjaWychodzacaDane)
ALTER TABLE OperacjaWychodzacaDane ADD CONSTRAINT PlatnoscDict_OperacjaWychodzacaDane
    FOREIGN KEY (PlatnoscDictKey)
    REFERENCES PlatnoscDict ("Key");

-- Reference: Rachunek_Operacja_Klient (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja ADD CONSTRAINT Rachunek_Operacja_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

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
    REFERENCES RachunekDict ("Key");

-- Reference: RodzajOperacjiDict_Rachunek_Operacja (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja ADD CONSTRAINT RodzajOperacjiDict_Rachunek_Operacja
    FOREIGN KEY (RodzajOperacjiDictKey)
    REFERENCES RodzajOperacjiDict ("Key");

-- Reference: Telefon_Klient (table: Telefon)
ALTER TABLE Telefon ADD CONSTRAINT Telefon_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Urzad_skarbowy_Adres (table: Urzad_skarbowy)
ALTER TABLE Urzad_skarbowy ADD CONSTRAINT Urzad_skarbowy_Adres
    FOREIGN KEY (IdAdres)
    REFERENCES Adres (IdAdres);

-- End of file.

