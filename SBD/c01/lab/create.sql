-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-03-04 19:27:06.816

-- tables
-- Table: Pierwiastek
CREATE TABLE Pierwiastek (
    IdPierwiastek integer  NOT NULL,
    Nazwa varchar2(30)  NOT NULL,
    Symbol varchar2(3)  NOT NULL,
    Opis varchar2(500)  NOT NULL,
    Ilosc number(7,2)  NOT NULL,
    CONSTRAINT Pierwiastek_pk PRIMARY KEY (IdPierwiastek)
) ;

-- Table: Reakcja
CREATE TABLE Reakcja (
    IdReakcja integer  NOT NULL,
    Nazwa varchar2(200)  NOT NULL,
    Data date  NOT NULL,
    CONSTRAINT Reakcja_pk PRIMARY KEY (IdReakcja)
) ;

-- Table: Reakcja_Pierwiastek
CREATE TABLE Reakcja_Pierwiastek (
    IdReakcjaPierwiastek integer  NOT NULL,
    Ilosc number(7,2)  NOT NULL,
    Pierwiastek_IdPierwiastek integer  NOT NULL,
    Reakcja_IdReakcja integer  NOT NULL,
    SkladnikDict_Key varchar2(2)  NOT NULL,
    CONSTRAINT Reakcja_Pierwiastek_pk PRIMARY KEY (IdReakcjaPierwiastek)
) ;

-- Table: Reakcja_ZwiazekChemiczny
CREATE TABLE Reakcja_ZwiazekChemiczny (
    IdReakcjaZwiazekChemiczny integer  NOT NULL,
    Ilosc number(7,2)  NOT NULL,
    Zwiazek_IdZwiazekChemiczny integer  NOT NULL,
    Reakcja_IdReakcja integer  NOT NULL,
    SkladnikDict_Key varchar2(2)  NOT NULL,
    CONSTRAINT Reakcja_ZwiazekChemiczny_pk PRIMARY KEY (IdReakcjaZwiazekChemiczny)
) ;

-- Table: SkladnikDict
CREATE TABLE SkladnikDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(20)  NOT NULL,
    CONSTRAINT SkladnikDict_pk PRIMARY KEY (Key)
) ;

-- Table: ZwiazekChemiczny
CREATE TABLE ZwiazekChemiczny (
    IdZwiazekChemiczny integer  NOT NULL,
    Nazwa varchar2(200)  NOT NULL,
    Symbol varchar2(20)  NOT NULL,
    Opis varchar2(500)  NOT NULL,
    Ilosc number(7,2)  NOT NULL,
    CONSTRAINT ZwiazekChemiczny_pk PRIMARY KEY (IdZwiazekChemiczny)
) ;

-- foreign keys
-- Reference: Pierwiastek_Reakcja (table: Reakcja_Pierwiastek)
ALTER TABLE Reakcja_Pierwiastek ADD CONSTRAINT Pierwiastek_Reakcja
    FOREIGN KEY (Reakcja_IdReakcja)
    REFERENCES Reakcja (IdReakcja);

-- Reference: Pierwiastek_SkladnikDict (table: Reakcja_Pierwiastek)
ALTER TABLE Reakcja_Pierwiastek ADD CONSTRAINT Pierwiastek_SkladnikDict
    FOREIGN KEY (SkladnikDict_Key)
    REFERENCES SkladnikDict (Key);

-- Reference: Reakcja_Pierwiastek (table: Reakcja_Pierwiastek)
ALTER TABLE Reakcja_Pierwiastek ADD CONSTRAINT Reakcja_Pierwiastek
    FOREIGN KEY (Pierwiastek_IdPierwiastek)
    REFERENCES Pierwiastek (IdPierwiastek);

-- Reference: Reakcja_ZwiazekChemiczny (table: Reakcja_ZwiazekChemiczny)
ALTER TABLE Reakcja_ZwiazekChemiczny ADD CONSTRAINT Reakcja_ZwiazekChemiczny
    FOREIGN KEY (Zwiazek_IdZwiazekChemiczny)
    REFERENCES ZwiazekChemiczny (IdZwiazekChemiczny);

-- Reference: ZwiazekChemiczny_Reakcja (table: Reakcja_ZwiazekChemiczny)
ALTER TABLE Reakcja_ZwiazekChemiczny ADD CONSTRAINT ZwiazekChemiczny_Reakcja
    FOREIGN KEY (Reakcja_IdReakcja)
    REFERENCES Reakcja (IdReakcja);

-- Reference: ZwiazekChemiczny_SkladnikDict (table: Reakcja_ZwiazekChemiczny)
ALTER TABLE Reakcja_ZwiazekChemiczny ADD CONSTRAINT ZwiazekChemiczny_SkladnikDict
    FOREIGN KEY (SkladnikDict_Key)
    REFERENCES SkladnikDict (Key);

-- End of file.

