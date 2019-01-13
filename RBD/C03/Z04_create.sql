-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:40:36.984

-- tables
-- Table: Adres
CREATE TABLE Adres (
    Id integer  NOT NULL,
    Kraj varchar2(50)  NOT NULL,
    KodPocztowy varchar2(10)  NOT NULL,
    Miasto varchar2(100)  NOT NULL,
    Ulica varchar2(200)  NOT NULL,
    NrDomu integer  NOT NULL,
    NrMieszkania integer  NOT NULL,
    Osoba_Id integer  NOT NULL,
    CONSTRAINT Adres_pk PRIMARY KEY (Id)
) ;

-- Table: Malzenstwo
CREATE TABLE Malzenstwo (
    Id integer  NOT NULL,
    Osoba_Id integer  NOT NULL,
    Osoba_2_Id integer  NOT NULL,
    DataZawarcia date  NOT NULL,
    DataZakonczenia date  NULL,
    CONSTRAINT Malzenstwo_pk PRIMARY KEY (Id)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    Id integer  NOT NULL,
    Imie varchar2(50)  NOT NULL,
    DrugieImie varchar2(50)  NOT NULL,
    Nazwisko varchar2(50)  NOT NULL,
    NazwiskoPanienskie varchar2(50)  NOT NULL,
    DataSmierci date  NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (Id)
) ;

-- Table: Rodzice_Dziecko
CREATE TABLE Rodzice_Dziecko (
    Id integer  NOT NULL,
    Rodzic1_Id integer  NOT NULL,
    Rodzic2_Id integer  NULL,
    Dziecko_Id integer  NOT NULL,
    CONSTRAINT Rodzice_Dziecko_pk PRIMARY KEY (Id)
) ;

-- foreign keys
-- Reference: Adres_Osoba (table: Adres)
ALTER TABLE Adres ADD CONSTRAINT Adres_Osoba
    FOREIGN KEY (Osoba_Id)
    REFERENCES Osoba (Id);

-- Reference: Malzenstwo_Osoba (table: Malzenstwo)
ALTER TABLE Malzenstwo ADD CONSTRAINT Malzenstwo_Osoba
    FOREIGN KEY (Osoba_Id)
    REFERENCES Osoba (Id);

-- Reference: Malzenstwo_Osoba_2 (table: Malzenstwo)
ALTER TABLE Malzenstwo ADD CONSTRAINT Malzenstwo_Osoba_2
    FOREIGN KEY (Osoba_2_Id)
    REFERENCES Osoba (Id);

-- Reference: Osoba_Dziecko (table: Rodzice_Dziecko)
ALTER TABLE Rodzice_Dziecko ADD CONSTRAINT Osoba_Dziecko
    FOREIGN KEY (Dziecko_Id)
    REFERENCES Osoba (Id);

-- Reference: Osoba_Rodzic1 (table: Rodzice_Dziecko)
ALTER TABLE Rodzice_Dziecko ADD CONSTRAINT Osoba_Rodzic1
    FOREIGN KEY (Rodzic1_Id)
    REFERENCES Osoba (Id);

-- Reference: Osoba_Rodzic2 (table: Rodzice_Dziecko)
ALTER TABLE Rodzice_Dziecko ADD CONSTRAINT Osoba_Rodzic2
    FOREIGN KEY (Rodzic2_Id)
    REFERENCES Osoba (Id);

-- End of file.

