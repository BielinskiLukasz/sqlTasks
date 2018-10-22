-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-10-22 19:51:43.488

-- tables
-- Table: Instrument
CREATE TABLE Instrument (
    id integer  NOT NULL,
    CONSTRAINT Instrument_pk PRIMARY KEY (id)
) ;

-- Table: Kompozytor
CREATE TABLE Kompozytor (
    id integer  NOT NULL,
    CONSTRAINT Kompozytor_pk PRIMARY KEY (id)
) ;

-- Table: Obsada
CREATE TABLE Obsada (
    id integer  NOT NULL,
    Utwor_id integer  NOT NULL,
    Instrument_id integer  NOT NULL,
    ilosc integer  NOT NULL,
    CONSTRAINT Obsada_pk PRIMARY KEY (id)
) ;

-- Table: Repertuar
CREATE TABLE Repertuar (
    id integer  NOT NULL,
    data date  NOT NULL,
    CONSTRAINT Repertuar_pk PRIMARY KEY (id)
) ;

-- Table: Repertuar_Utwor
CREATE TABLE Repertuar_Utwor (
    id integer  NOT NULL,
    Repertuar_id integer  NOT NULL,
    Utwor_id integer  NOT NULL,
    CONSTRAINT Repertuar_Utwor_pk PRIMARY KEY (id)
) ;

-- Table: Repertuar_Wykonawca
CREATE TABLE Repertuar_Wykonawca (
    id integer  NOT NULL,
    Repertuar_id integer  NOT NULL,
    Wykonawca_id integer  NOT NULL,
    CONSTRAINT Repertuar_Wykonawca_pk PRIMARY KEY (id)
) ;

-- Table: Utwor
CREATE TABLE Utwor (
    id integer  NOT NULL,
    Kompozytor_id integer  NOT NULL,
    CONSTRAINT Utwor_pk PRIMARY KEY (id)
) ;

-- Table: Wykonawca
CREATE TABLE Wykonawca (
    id integer  NOT NULL,
    Instrument_id integer  NOT NULL,
    CONSTRAINT Wykonawca_pk PRIMARY KEY (id)
) ;

-- Table: Wykonawca_Utwor
CREATE TABLE Wykonawca_Utwor (
    id integer  NOT NULL,
    Wykonawca_id integer  NOT NULL,
    Utwor_id integer  NOT NULL,
    CONSTRAINT Wykonawca_Utwor_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Obsada_Instrument (table: Obsada)
ALTER TABLE Obsada ADD CONSTRAINT Obsada_Instrument
    FOREIGN KEY (Instrument_id)
    REFERENCES Instrument (id);

-- Reference: Obsada_Utwor (table: Obsada)
ALTER TABLE Obsada ADD CONSTRAINT Obsada_Utwor
    FOREIGN KEY (Utwor_id)
    REFERENCES Utwor (id);

-- Reference: Repertuar_Utwor_Repertuar (table: Repertuar_Utwor)
ALTER TABLE Repertuar_Utwor ADD CONSTRAINT Repertuar_Utwor_Repertuar
    FOREIGN KEY (Repertuar_id)
    REFERENCES Repertuar (id);

-- Reference: Repertuar_Utwor_Utwor (table: Repertuar_Utwor)
ALTER TABLE Repertuar_Utwor ADD CONSTRAINT Repertuar_Utwor_Utwor
    FOREIGN KEY (Utwor_id)
    REFERENCES Utwor (id);

-- Reference: Repertuar_Wykonawca_Repertuar (table: Repertuar_Wykonawca)
ALTER TABLE Repertuar_Wykonawca ADD CONSTRAINT Repertuar_Wykonawca_Repertuar
    FOREIGN KEY (Repertuar_id)
    REFERENCES Repertuar (id);

-- Reference: Repertuar_Wykonawca_Wykonawca (table: Repertuar_Wykonawca)
ALTER TABLE Repertuar_Wykonawca ADD CONSTRAINT Repertuar_Wykonawca_Wykonawca
    FOREIGN KEY (Wykonawca_id)
    REFERENCES Wykonawca (id);

-- Reference: Utwor_Kompozytor (table: Utwor)
ALTER TABLE Utwor ADD CONSTRAINT Utwor_Kompozytor
    FOREIGN KEY (Kompozytor_id)
    REFERENCES Kompozytor (id);

-- Reference: Wykonawca_Instrument (table: Wykonawca)
ALTER TABLE Wykonawca ADD CONSTRAINT Wykonawca_Instrument
    FOREIGN KEY (Instrument_id)
    REFERENCES Instrument (id);

-- Reference: Wykonawca_Utwor_Utwor (table: Wykonawca_Utwor)
ALTER TABLE Wykonawca_Utwor ADD CONSTRAINT Wykonawca_Utwor_Utwor
    FOREIGN KEY (Utwor_id)
    REFERENCES Utwor (id);

-- Reference: Wykonawca_Utwor_Wykonawca (table: Wykonawca_Utwor)
ALTER TABLE Wykonawca_Utwor ADD CONSTRAINT Wykonawca_Utwor_Wykonawca
    FOREIGN KEY (Wykonawca_id)
    REFERENCES Wykonawca (id);

-- End of file.

