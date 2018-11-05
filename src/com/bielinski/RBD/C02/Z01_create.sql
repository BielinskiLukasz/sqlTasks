-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:15:01.202

-- tables
-- Table: Piwo
CREATE TABLE Piwo (
    id integer  NOT NULL,
    nazwa varchar2(100)  NOT NULL,
    CONSTRAINT Piwo_pk PRIMARY KEY (id)
) ;

-- Table: Piwo_Pub
CREATE TABLE Piwo_Pub (
    id integer  NOT NULL,
    Pub_id integer  NOT NULL,
    Piwo_id integer  NOT NULL,
    cena float(10)  NOT NULL,
    CONSTRAINT Piwo_Pub_pk PRIMARY KEY (id)
) ;

-- Table: Piwo_Wizyta
CREATE TABLE Piwo_Wizyta (
    id integer  NOT NULL,
    Piwo_Pub_id integer  NOT NULL,
    Wizyta_id integer  NOT NULL,
    ilosc integer  NOT NULL,
    CONSTRAINT Piwo_Wizyta_pk PRIMARY KEY (id)
) ;

-- Table: Piwosz
CREATE TABLE Piwosz (
    id integer  NOT NULL,
    CONSTRAINT Piwosz_pk PRIMARY KEY (id)
) ;

-- Table: Pub
CREATE TABLE Pub (
    id integer  NOT NULL,
    nazwa varchar2(100)  NOT NULL,
    ulica varchar2(100)  NOT NULL,
    nr_budynku integer  NOT NULL,
    nr_lokalu integer  NULL,
    kod_pocztowy varchar2(6)  NOT NULL,
    miasto varchar2(100)  NOT NULL,
    CONSTRAINT Pub_pk PRIMARY KEY (id)
) ;

-- Table: Ulubione_piwo
CREATE TABLE Ulubione_piwo (
    id integer  NOT NULL,
    Piwosz_id integer  NOT NULL,
    Piwo_id integer  NOT NULL,
    CONSTRAINT Ulubione_piwo_pk PRIMARY KEY (id)
) ;

-- Table: Wizyta
CREATE TABLE Wizyta (
    id integer  NOT NULL,
    Piwosz_id integer  NOT NULL,
    Pub_id integer  NOT NULL,
    CONSTRAINT Wizyta_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Piwa_w_pubie_Piwo (table: Piwo_Pub)
ALTER TABLE Piwo_Pub ADD CONSTRAINT Piwa_w_pubie_Piwo
    FOREIGN KEY (Piwo_id)
    REFERENCES Piwo (id);

-- Reference: Piwa_w_pubie_Pub (table: Piwo_Pub)
ALTER TABLE Piwo_Pub ADD CONSTRAINT Piwa_w_pubie_Pub
    FOREIGN KEY (Pub_id)
    REFERENCES Pub (id);

-- Reference: Piwo_Wizyta_Piwo_Pub (table: Piwo_Wizyta)
ALTER TABLE Piwo_Wizyta ADD CONSTRAINT Piwo_Wizyta_Piwo_Pub
    FOREIGN KEY (Piwo_Pub_id)
    REFERENCES Piwo_Pub (id);

-- Reference: Piwo_Wizyta_Wizyta (table: Piwo_Wizyta)
ALTER TABLE Piwo_Wizyta ADD CONSTRAINT Piwo_Wizyta_Wizyta
    FOREIGN KEY (Wizyta_id)
    REFERENCES Wizyta (id);

-- Reference: Ulubione_piwa_Piwo (table: Ulubione_piwo)
ALTER TABLE Ulubione_piwo ADD CONSTRAINT Ulubione_piwa_Piwo
    FOREIGN KEY (Piwo_id)
    REFERENCES Piwo (id);

-- Reference: Ulubione_piwa_Piwosz (table: Ulubione_piwo)
ALTER TABLE Ulubione_piwo ADD CONSTRAINT Ulubione_piwa_Piwosz
    FOREIGN KEY (Piwosz_id)
    REFERENCES Piwosz (id);

-- Reference: Wizyty_w_pubie_Piwosz (table: Wizyta)
ALTER TABLE Wizyta ADD CONSTRAINT Wizyty_w_pubie_Piwosz
    FOREIGN KEY (Piwosz_id)
    REFERENCES Piwosz (id);

-- Reference: Wizyty_w_pubie_Pub (table: Wizyta)
ALTER TABLE Wizyta ADD CONSTRAINT Wizyty_w_pubie_Pub
    FOREIGN KEY (Pub_id)
    REFERENCES Pub (id);

-- End of file.

