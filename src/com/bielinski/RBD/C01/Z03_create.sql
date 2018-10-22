-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-10-22 19:25:23.129

-- tables
-- Table: Klient_firma
CREATE TABLE Klient_firma (
    id integer  NOT NULL,
    CONSTRAINT Klient_firma_pk PRIMARY KEY (id)
) ;

-- Table: Konferencja
CREATE TABLE Konferencja (
    id integer  NOT NULL,
    temat char(250)  NOT NULL,
    data date  NULL,
    Klient_firma_id integer  NOT NULL,
    CONSTRAINT Konferencja_pk PRIMARY KEY (id)
) ;

-- Table: Odczyt
CREATE TABLE Odczyt (
    id integer  NOT NULL,
    temat char(250)  NOT NULL,
    Pracownik_osoba_id integer  NOT NULL,
    Konferencja_id integer  NOT NULL,
    CONSTRAINT Odczyt_pk PRIMARY KEY (id)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    osoba_id integer  NOT NULL,
    Klient_firma_id integer  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (osoba_id)
) ;

-- Table: osoba
CREATE TABLE osoba (
    id integer  NOT NULL,
    CONSTRAINT osoba_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Konferencja_Klient_firma (table: Konferencja)
ALTER TABLE Konferencja ADD CONSTRAINT Konferencja_Klient_firma
    FOREIGN KEY (Klient_firma_id)
    REFERENCES Klient_firma (id);

-- Reference: Odczyt_Konferencja (table: Odczyt)
ALTER TABLE Odczyt ADD CONSTRAINT Odczyt_Konferencja
    FOREIGN KEY (Konferencja_id)
    REFERENCES Konferencja (id);

-- Reference: Odczyt_Pracownik (table: Odczyt)
ALTER TABLE Odczyt ADD CONSTRAINT Odczyt_Pracownik
    FOREIGN KEY (Pracownik_osoba_id)
    REFERENCES Pracownik (osoba_id);

-- Reference: Pracownik_Klient_firma (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Klient_firma
    FOREIGN KEY (Klient_firma_id)
    REFERENCES Klient_firma (id);

-- Reference: Pracownik_osoba (table: osoba)
ALTER TABLE osoba ADD CONSTRAINT Pracownik_osoba
    FOREIGN KEY (id)
    REFERENCES Pracownik (osoba_id);

-- End of file.

