-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:20:55.089

-- tables
-- Table: Adres
CREATE TABLE Adres (
    id integer  NOT NULL,
    ulica varchar2(50)  NOT NULL,
    nr_domu integer  NOT NULL,
    nr_mieszkania integer  NOT NULL,
    kod_pocztowy varchar2(10)  NOT NULL,
    miejscowosc varchar2(100)  NOT NULL,
    CONSTRAINT Adres_pk PRIMARY KEY (id)
) ;

-- Table: Autokar
CREATE TABLE Autokar (
    id integer  NOT NULL,
    standard varchar2(50)  NOT NULL,
    ilosc_miejsc integer  NOT NULL,
    CONSTRAINT Autokar_pk PRIMARY KEY (id)
) ;

-- Table: Autokar_Wyposazenie
CREATE TABLE Autokar_Wyposazenie (
    id integer  NOT NULL,
    Autokar_id integer  NOT NULL,
    Wyposazenie_id integer  NOT NULL,
    CONSTRAINT Autokar_Wyposazenie_pk PRIMARY KEY (id)
) ;

-- Table: Kierowca
CREATE TABLE Kierowca (
    Osoba_id integer  NOT NULL,
    CONSTRAINT Kierowca_pk PRIMARY KEY (Osoba_id)
) ;

-- Table: Klient_firma
CREATE TABLE Klient_firma (
    id integer  NOT NULL,
    Adres_id integer  NOT NULL,
    CONSTRAINT Klient_firma_pk PRIMARY KEY (id)
) ;

-- Table: Klient_indywidualny
CREATE TABLE Klient_indywidualny (
    Osoba_id integer  NOT NULL,
    CONSTRAINT Klient_indywidualny_pk PRIMARY KEY (Osoba_id)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    id integer  NOT NULL,
    imie varchar2(50)  NOT NULL,
    nazwisko varchar2(200)  NOT NULL,
    telefon varchar2(20)  NOT NULL,
    Adres_id integer  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (id)
) ;

-- Table: Rezerwacja
CREATE TABLE Rezerwacja (
    id integer  NOT NULL,
    Adres_id integer  NOT NULL,
    Klient_firma_id integer  NULL,
    Klient_indywidualny_Osoba_id integer  NULL,
    data_start date  NOT NULL,
    data_koniec date  NOT NULL,
    CONSTRAINT Rezerwacja_pk PRIMARY KEY (id)
) ;

-- Table: Rezerwacja_Autokar
CREATE TABLE Rezerwacja_Autokar (
    id integer  NOT NULL,
    Rezerwacja_id integer  NOT NULL,
    Autokar_id integer  NOT NULL,
    CONSTRAINT Rezerwacja_Autokar_pk PRIMARY KEY (id)
) ;

-- Table: Rezerwacja_Kierowca
CREATE TABLE Rezerwacja_Kierowca (
    id integer  NOT NULL,
    Rezerwacja_Autokar_id integer  NOT NULL,
    Kierowca_Osoba_id integer  NOT NULL,
    CONSTRAINT Rezerwacja_Kierowca_pk PRIMARY KEY (id)
) ;

-- Table: Wyposazenie
CREATE TABLE Wyposazenie (
    id integer  NOT NULL,
    nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Wyposazenie_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Autokar (table: Autokar_Wyposazenie)
ALTER TABLE Autokar_Wyposazenie ADD CONSTRAINT Autokar
    FOREIGN KEY (Autokar_id)
    REFERENCES Autokar (id);

-- Reference: Kierowca_Osoba (table: Kierowca)
ALTER TABLE Kierowca ADD CONSTRAINT Kierowca_Osoba
    FOREIGN KEY (Osoba_id)
    REFERENCES Osoba (id);

-- Reference: Klient_firma_Adres (table: Klient_firma)
ALTER TABLE Klient_firma ADD CONSTRAINT Klient_firma_Adres
    FOREIGN KEY (Adres_id)
    REFERENCES Adres (id);

-- Reference: Klient_indywidualny_Adres (table: Osoba)
ALTER TABLE Osoba ADD CONSTRAINT Klient_indywidualny_Adres
    FOREIGN KEY (Adres_id)
    REFERENCES Adres (id);

-- Reference: Klient_indywidualny_Osoba (table: Klient_indywidualny)
ALTER TABLE Klient_indywidualny ADD CONSTRAINT Klient_indywidualny_Osoba
    FOREIGN KEY (Osoba_id)
    REFERENCES Osoba (id);

-- Reference: Rezerwacja_Adres (table: Rezerwacja)
ALTER TABLE Rezerwacja ADD CONSTRAINT Rezerwacja_Adres
    FOREIGN KEY (Adres_id)
    REFERENCES Adres (id);

-- Reference: Rezerwacja_Autokar_Autokar (table: Rezerwacja_Autokar)
ALTER TABLE Rezerwacja_Autokar ADD CONSTRAINT Rezerwacja_Autokar_Autokar
    FOREIGN KEY (Autokar_id)
    REFERENCES Autokar (id);

-- Reference: Rezerwacja_Autokar_Rezerwacja (table: Rezerwacja_Autokar)
ALTER TABLE Rezerwacja_Autokar ADD CONSTRAINT Rezerwacja_Autokar_Rezerwacja
    FOREIGN KEY (Rezerwacja_id)
    REFERENCES Rezerwacja (id);

-- Reference: Rezerwacja_Kierowca_Autokar (table: Rezerwacja_Kierowca)
ALTER TABLE Rezerwacja_Kierowca ADD CONSTRAINT Rezerwacja_Kierowca_Autokar
    FOREIGN KEY (Rezerwacja_Autokar_id)
    REFERENCES Rezerwacja_Autokar (id);

-- Reference: Rezerwacja_Kierowca_Kierowca (table: Rezerwacja_Kierowca)
ALTER TABLE Rezerwacja_Kierowca ADD CONSTRAINT Rezerwacja_Kierowca_Kierowca
    FOREIGN KEY (Kierowca_Osoba_id)
    REFERENCES Kierowca (Osoba_id);

-- Reference: Rezerwacja_Klient_firma (table: Rezerwacja)
ALTER TABLE Rezerwacja ADD CONSTRAINT Rezerwacja_Klient_firma
    FOREIGN KEY (Klient_firma_id)
    REFERENCES Klient_firma (id);

-- Reference: Rezerwacja_Klient_indywidualny (table: Rezerwacja)
ALTER TABLE Rezerwacja ADD CONSTRAINT Rezerwacja_Klient_indywidualny
    FOREIGN KEY (Klient_indywidualny_Osoba_id)
    REFERENCES Klient_indywidualny (Osoba_id);

-- Reference: Wyposazenie (table: Autokar_Wyposazenie)
ALTER TABLE Autokar_Wyposazenie ADD CONSTRAINT Wyposazenie
    FOREIGN KEY (Wyposazenie_id)
    REFERENCES Wyposazenie (id);

-- End of file.

