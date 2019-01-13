-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 18:47:44.799

-- tables
-- Table: Klucz
CREATE TABLE Klucz (
    id integer  NOT NULL,
    Sala_id integer  NOT NULL,
    CONSTRAINT Klucz_pk PRIMARY KEY (id)
) ;

-- Table: Prowadzacy
CREATE TABLE Prowadzacy (
    id integer  NOT NULL,
    imie varchar2(50)  NOT NULL,
    nazwisko varchar2(100)  NOT NULL,
    CONSTRAINT Prowadzacy_pk PRIMARY KEY (id)
) ;

-- Table: Sala
CREATE TABLE Sala (
    id integer  NOT NULL,
    symbol varchar2(10)  NOT NULL,
    CONSTRAINT Sala_pk PRIMARY KEY (id)
) ;

-- Table: Wypozyczenia
CREATE TABLE Wypozyczenia (
    id integer  NOT NULL,
    Prowadzacy_id integer  NOT NULL,
    Klucz_id integer  NOT NULL,
    poczatek_wypozyczenia timestamp  NOT NULL,
    koniec_wyporzyczenia timestamp  NULL,
    CONSTRAINT Wypozyczenia_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Klucz_Sala (table: Klucz)
ALTER TABLE Klucz ADD CONSTRAINT Klucz_Sala
    FOREIGN KEY (Sala_id)
    REFERENCES Sala (id);

-- Reference: Wyporzyczenia_Prowadzacy (table: Wypozyczenia)
ALTER TABLE Wypozyczenia ADD CONSTRAINT Wyporzyczenia_Prowadzacy
    FOREIGN KEY (Prowadzacy_id)
    REFERENCES Prowadzacy (id);

-- Reference: Wypozyczenia_Klucz (table: Wypozyczenia)
ALTER TABLE Wypozyczenia ADD CONSTRAINT Wypozyczenia_Klucz
    FOREIGN KEY (Klucz_id)
    REFERENCES Klucz (id);

-- End of file.

