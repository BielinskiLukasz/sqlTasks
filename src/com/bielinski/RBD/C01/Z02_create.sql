-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-10-22 19:24:51.217

-- tables
-- Table: Klient
CREATE TABLE Klient (
    Osoba_id integer  NOT NULL,
    Status_library_id integer  NOT NULL,
    Przedstawiciel_Osoba_id integer  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (Osoba_id)
) ;

-- Table: Kontakt
CREATE TABLE Kontakt (
    id integer  NOT NULL,
    data date  NOT NULL,
    opis char(1000)  NOT NULL,
    typ char(50)  NOT NULL,
    Typ_kontaktu_library_id integer  NOT NULL,
    Klient_Osoba_id integer  NOT NULL,
    Przedstawiciel_Osoba_id integer  NOT NULL,
    CONSTRAINT Kontakt_pk PRIMARY KEY (id)
) ;

-- Table: Oddzial
CREATE TABLE Oddzial (
    id integer  NOT NULL,
    nazwa char(50)  NOT NULL,
    CONSTRAINT Oddzial_pk PRIMARY KEY (id)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    id integer  NOT NULL,
    imie char(50)  NOT NULL,
    nazwisko char(100)  NOT NULL,
    ulica char(250)  NOT NULL,
    nr_domu integer  NOT NULL,
    nr_mieszkania integer  NULL,
    kod_pocztowy char(5)  NOT NULL,
    miejscowosc char(200)  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (id)
) ;

-- Table: Przedstawiciel
CREATE TABLE Przedstawiciel (
    Osoba_id integer  NOT NULL,
    Oddzial_id integer  NOT NULL,
    CONSTRAINT Przedstawiciel_pk PRIMARY KEY (Osoba_id)
) ;

-- Table: Status_library
CREATE TABLE Status_library (
    id integer  NOT NULL,
    typ char(50)  NOT NULL,
    CONSTRAINT Status_library_pk PRIMARY KEY (id)
) ;

-- Table: Typ_kontaktu_library
CREATE TABLE Typ_kontaktu_library (
    id integer  NOT NULL,
    typ char(100)  NOT NULL,
    CONSTRAINT Typ_kontaktu_library_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Klient_Osoba (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Osoba
    FOREIGN KEY (Osoba_id)
    REFERENCES Osoba (id);

-- Reference: Klient_Przedstawiciel (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Przedstawiciel
    FOREIGN KEY (Przedstawiciel_Osoba_id)
    REFERENCES Przedstawiciel (Osoba_id);

-- Reference: Klient_Status_library (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Status_library
    FOREIGN KEY (Status_library_id)
    REFERENCES Status_library (id);

-- Reference: Kontakt_Klient (table: Kontakt)
ALTER TABLE Kontakt ADD CONSTRAINT Kontakt_Klient
    FOREIGN KEY (Klient_Osoba_id)
    REFERENCES Klient (Osoba_id);

-- Reference: Kontakt_Przedstawiciel (table: Kontakt)
ALTER TABLE Kontakt ADD CONSTRAINT Kontakt_Przedstawiciel
    FOREIGN KEY (Przedstawiciel_Osoba_id)
    REFERENCES Przedstawiciel (Osoba_id);

-- Reference: Kontakt_Typ_kontaktu_library (table: Kontakt)
ALTER TABLE Kontakt ADD CONSTRAINT Kontakt_Typ_kontaktu_library
    FOREIGN KEY (Typ_kontaktu_library_id)
    REFERENCES Typ_kontaktu_library (id);

-- Reference: Przedstawiciel_Oddzial (table: Przedstawiciel)
ALTER TABLE Przedstawiciel ADD CONSTRAINT Przedstawiciel_Oddzial
    FOREIGN KEY (Oddzial_id)
    REFERENCES Oddzial (id);

-- Reference: Przedstawiciel_Osoba (table: Przedstawiciel)
ALTER TABLE Przedstawiciel ADD CONSTRAINT Przedstawiciel_Osoba
    FOREIGN KEY (Osoba_id)
    REFERENCES Osoba (id);

-- End of file.

