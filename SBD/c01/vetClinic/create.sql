-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-03-03 17:21:01.732

-- tables
-- Table: Klient
CREATE TABLE Klient (
    IdKlient integer  NOT NULL,
    Osoba_IdOsoba integer  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (IdKlient)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    IdOsoba integer  NOT NULL,
    Imie varchar2(20)  NOT NULL,
    Nazwisko varchar2(30)  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (IdOsoba)
) ;

-- Table: Usluga
CREATE TABLE Usluga (
    IdUsluga integer  NOT NULL,
    Nazwa varchar2(20)  NOT NULL,
    Opis varchar2(200)  NOT NULL,
    CONSTRAINT Usluga_pk PRIMARY KEY (IdUsluga)
) ;

-- Table: Weterynarz
CREATE TABLE Weterynarz (
    IdWeterynarz integer  NOT NULL,
    Osoba_IdOsoba integer  NOT NULL,
    CONSTRAINT Weterynarz_pk PRIMARY KEY (IdWeterynarz)
) ;

-- Table: Wizyta
CREATE TABLE Wizyta (
    IdWizyta integer  NOT NULL,
    Data date  NOT NULL,
    Weterynarz_IdWeterynarz integer  NOT NULL,
    Zwierze_IdZwierze integer  NOT NULL,
    CONSTRAINT Wizyta_pk PRIMARY KEY (IdWizyta)
) ;

-- Table: Wizyta_Usluga
CREATE TABLE Wizyta_Usluga (
    IdWizyta_Usluga integer  NOT NULL,
    Ilosc integer  NOT NULL,
    Wizyta_IdWizyta integer  NOT NULL,
    Usluga_IdUsluga integer  NOT NULL,
    CONSTRAINT Wizyta_Usluga_pk PRIMARY KEY (IdWizyta_Usluga)
) ;

-- Table: Zwierze
CREATE TABLE Zwierze (
    IdZwierze integer  NOT NULL,
    Imie varchar2(20)  NOT NULL,
    Klient_IdKlient integer  NOT NULL,
    CONSTRAINT Zwierze_pk PRIMARY KEY (IdZwierze)
) ;

-- foreign keys
-- Reference: Klient_Osoba (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Osoba
    FOREIGN KEY (Osoba_IdOsoba)
    REFERENCES Osoba (IdOsoba);

-- Reference: Weterynarz_Osoba (table: Weterynarz)
ALTER TABLE Weterynarz ADD CONSTRAINT Weterynarz_Osoba
    FOREIGN KEY (Osoba_IdOsoba)
    REFERENCES Osoba (IdOsoba);

-- Reference: Wizyta_Usluga_Usluga (table: Wizyta_Usluga)
ALTER TABLE Wizyta_Usluga ADD CONSTRAINT Wizyta_Usluga_Usluga
    FOREIGN KEY (Usluga_IdUsluga)
    REFERENCES Usluga (IdUsluga);

-- Reference: Wizyta_Usluga_Wizyta (table: Wizyta_Usluga)
ALTER TABLE Wizyta_Usluga ADD CONSTRAINT Wizyta_Usluga_Wizyta
    FOREIGN KEY (Wizyta_IdWizyta)
    REFERENCES Wizyta (IdWizyta);

-- Reference: Wizyta_Weterynarz (table: Wizyta)
ALTER TABLE Wizyta ADD CONSTRAINT Wizyta_Weterynarz
    FOREIGN KEY (Weterynarz_IdWeterynarz)
    REFERENCES Weterynarz (IdWeterynarz);

-- Reference: Wizyta_Zwierze (table: Wizyta)
ALTER TABLE Wizyta ADD CONSTRAINT Wizyta_Zwierze
    FOREIGN KEY (Zwierze_IdZwierze)
    REFERENCES Zwierze (IdZwierze);

-- Reference: Zwierze_Klient (table: Zwierze)
ALTER TABLE Zwierze ADD CONSTRAINT Zwierze_Klient
    FOREIGN KEY (Klient_IdKlient)
    REFERENCES Klient (IdKlient);

-- End of file.

