-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:30:59.95

-- tables
-- Table: Adres
CREATE TABLE Adres (
    Id integer  NOT NULL,
    Kraj varchar2(50)  NOT NULL,
    KodPocztowy varchar2(10)  NOT NULL,
    Miasto varchar2(50)  NOT NULL,
    Ulica varchar2(150)  NOT NULL,
    NrDomu varchar2(10)  NOT NULL,
    NrMieszkania varchar2(10)  NOT NULL,
    TypAdresu_Id integer  NOT NULL,
    CONSTRAINT Adres_pk PRIMARY KEY (Id)
) ;

-- Table: Kandydat
CREATE TABLE Kandydat (
    Osoba_Id integer  NOT NULL,
    Status_Id integer  NOT NULL,
    CONSTRAINT Kandydat_pk PRIMARY KEY (Osoba_Id)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    Id integer  NOT NULL,
    Imie varchar2(50)  NOT NULL,
    Nazwisko varchar2(50)  NOT NULL,
    Adres_Id integer  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (Id)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    Osoba_Id integer  NOT NULL,
    Stanowisko_Id integer  NOT NULL,
    Wynagrodzenie float(8)  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (Osoba_Id)
) ;

-- Table: Stanowisko
CREATE TABLE Stanowisko (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Stanowisko_pk PRIMARY KEY (Id)
) ;

-- Table: Status
CREATE TABLE Status (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Status_pk PRIMARY KEY (Id)
) ;

-- Table: Student
CREATE TABLE Student (
    Osoba_Id integer  NOT NULL,
    WynikEgzamunuWstepnego integer  NOT NULL,
    CONSTRAINT Student_pk PRIMARY KEY (Osoba_Id)
) ;

-- Table: TypAdresu
CREATE TABLE TypAdresu (
    Id integer  NOT NULL,
    Typ varchar2(50)  NOT NULL,
    CONSTRAINT TypAdresu_pk PRIMARY KEY (Id)
) ;

-- foreign keys
-- Reference: Adres_TypAdresu (table: Adres)
ALTER TABLE Adres ADD CONSTRAINT Adres_TypAdresu
    FOREIGN KEY (TypAdresu_Id)
    REFERENCES TypAdresu (Id);

-- Reference: Kandydat_Osoba (table: Kandydat)
ALTER TABLE Kandydat ADD CONSTRAINT Kandydat_Osoba
    FOREIGN KEY (Osoba_Id)
    REFERENCES Osoba (Id);

-- Reference: Kandydat_Status (table: Kandydat)
ALTER TABLE Kandydat ADD CONSTRAINT Kandydat_Status
    FOREIGN KEY (Status_Id)
    REFERENCES Status (Id);

-- Reference: Osoba_Adres (table: Osoba)
ALTER TABLE Osoba ADD CONSTRAINT Osoba_Adres
    FOREIGN KEY (Adres_Id)
    REFERENCES Adres (Id);

-- Reference: Pracownik_Osoba (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Osoba
    FOREIGN KEY (Osoba_Id)
    REFERENCES Osoba (Id);

-- Reference: Pracownik_Stanowisko (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Stanowisko
    FOREIGN KEY (Stanowisko_Id)
    REFERENCES Stanowisko (Id);

-- Reference: Student_Osoba (table: Student)
ALTER TABLE Student ADD CONSTRAINT Student_Osoba
    FOREIGN KEY (Osoba_Id)
    REFERENCES Osoba (Id);

-- End of file.

