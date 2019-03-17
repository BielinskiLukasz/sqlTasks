-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-03-17 13:17:03.723

-- tables
-- Table: Klient
CREATE TABLE Klient (
    IdKlient integer  NOT NULL,
    IdOsoba integer  NOT NULL,
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
    IdOsoba integer  NOT NULL,
    CONSTRAINT Weterynarz_pk PRIMARY KEY (IdWeterynarz)
) ;

-- Table: Wizyta
CREATE TABLE Wizyta (
    IdWizyta integer  NOT NULL,
    Data date  NOT NULL,
    IdWeterynarz integer  NOT NULL,
    IdZwierze integer  NOT NULL,
    CONSTRAINT Wizyta_pk PRIMARY KEY (IdWizyta)
) ;

-- Table: Wizyta_Usluga
CREATE TABLE Wizyta_Usluga (
    IdWizyta integer  NOT NULL,
    IdUsluga integer  NOT NULL,
    Ilosc integer  NOT NULL,
    CONSTRAINT Wizyta_Usluga_pk PRIMARY KEY (IdWizyta,IdUsluga)
) ;

-- Table: Zwierze
CREATE TABLE Zwierze (
    IdZwierze integer  NOT NULL,
    Imie varchar2(20)  NULL,
    IdKlient integer  NOT NULL,
    CONSTRAINT Zwierze_pk PRIMARY KEY (IdZwierze)
) ;

-- foreign keys
-- Reference: Klient_Osoba (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Osoba
    FOREIGN KEY (IdOsoba)
    REFERENCES Osoba (IdOsoba);

-- Reference: Weterynarz_Osoba (table: Weterynarz)
ALTER TABLE Weterynarz ADD CONSTRAINT Weterynarz_Osoba
    FOREIGN KEY (IdOsoba)
    REFERENCES Osoba (IdOsoba);

-- Reference: Wizyta_Usluga_Usluga (table: Wizyta_Usluga)
ALTER TABLE Wizyta_Usluga ADD CONSTRAINT Wizyta_Usluga_Usluga
    FOREIGN KEY (IdUsluga)
    REFERENCES Usluga (IdUsluga);

-- Reference: Wizyta_Usluga_Wizyta (table: Wizyta_Usluga)
ALTER TABLE Wizyta_Usluga ADD CONSTRAINT Wizyta_Usluga_Wizyta
    FOREIGN KEY (IdWizyta)
    REFERENCES Wizyta (IdWizyta);

-- Reference: Wizyta_Weterynarz (table: Wizyta)
ALTER TABLE Wizyta ADD CONSTRAINT Wizyta_Weterynarz
    FOREIGN KEY (IdWeterynarz)
    REFERENCES Weterynarz (IdWeterynarz);

-- Reference: Wizyta_Zwierze (table: Wizyta)
ALTER TABLE Wizyta ADD CONSTRAINT Wizyta_Zwierze
    FOREIGN KEY (IdZwierze)
    REFERENCES Zwierze (IdZwierze);

-- Reference: Zwierze_Klient (table: Zwierze)
ALTER TABLE Zwierze ADD CONSTRAINT Zwierze_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- End of file.

