-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 20:02:58.315

-- tables
-- Table: OdcinekSpecjalny
CREATE TABLE OdcinekSpecjalny (
    Id integer  NOT NULL,
    CONSTRAINT OdcinekSpecjalny_pk PRIMARY KEY (Id)
) ;

-- Table: Rajd
CREATE TABLE Rajd (
    Id integer  NOT NULL,
    CONSTRAINT Rajd_pk PRIMARY KEY (Id)
) ;

-- Table: Rajd_OdcinekSpecjalny
CREATE TABLE Rajd_OdcinekSpecjalny (
    Id integer  NOT NULL,
    Rajd_Id integer  NOT NULL,
    OdcinekSpecjalny_Id integer  NOT NULL,
    CONSTRAINT Rajd_OdcinekSpecjalny_pk PRIMARY KEY (Id)
) ;

-- Table: Rajd_Zaloga
CREATE TABLE Rajd_Zaloga (
    Id integer  NOT NULL,
    Rajd_Id integer  NOT NULL,
    Zaloga_Id integer  NOT NULL,
    WynikRajdu integer  NOT NULL,
    CONSTRAINT Rajd_Zaloga_pk PRIMARY KEY (Id)
) ;

-- Table: Wyniki
CREATE TABLE Wyniki (
    Id integer  NOT NULL,
    Rajd_Zaloga_Id integer  NOT NULL,
    Rajd_OdcinekSpecjalny_Id integer  NOT NULL,
    WynikOdcinka integer  NOT NULL,
    CONSTRAINT Wyniki_pk PRIMARY KEY (Id)
) ;

-- Table: Zaloga
CREATE TABLE Zaloga (
    Id integer  NOT NULL,
    Kierowca_Id integer  NOT NULL,
    Pilot_Id integer  NOT NULL,
    CONSTRAINT Zaloga_pk PRIMARY KEY (Id)
) ;

-- Table: Zawodnik
CREATE TABLE Zawodnik (
    Id integer  NOT NULL,
    CONSTRAINT Zawodnik_pk PRIMARY KEY (Id)
) ;

-- foreign keys
-- Reference: Rajd_OdcinekSpecjalny_Odcinek (table: Rajd_OdcinekSpecjalny)
ALTER TABLE Rajd_OdcinekSpecjalny ADD CONSTRAINT Rajd_OdcinekSpecjalny_Odcinek
    FOREIGN KEY (OdcinekSpecjalny_Id)
    REFERENCES OdcinekSpecjalny (Id);

-- Reference: Rajd_OdcinekSpecjalny_Rajd (table: Rajd_OdcinekSpecjalny)
ALTER TABLE Rajd_OdcinekSpecjalny ADD CONSTRAINT Rajd_OdcinekSpecjalny_Rajd
    FOREIGN KEY (Rajd_Id)
    REFERENCES Rajd (Id);

-- Reference: Rajd_Zaloga_Rajd (table: Rajd_Zaloga)
ALTER TABLE Rajd_Zaloga ADD CONSTRAINT Rajd_Zaloga_Rajd
    FOREIGN KEY (Rajd_Id)
    REFERENCES Rajd (Id);

-- Reference: Rajd_Zaloga_Zaloga (table: Rajd_Zaloga)
ALTER TABLE Rajd_Zaloga ADD CONSTRAINT Rajd_Zaloga_Zaloga
    FOREIGN KEY (Zaloga_Id)
    REFERENCES Zaloga (Id);

-- Reference: Sklad_Kierowca (table: Zaloga)
ALTER TABLE Zaloga ADD CONSTRAINT Sklad_Kierowca
    FOREIGN KEY (Kierowca_Id)
    REFERENCES Zawodnik (Id);

-- Reference: Sklad_Pilot (table: Zaloga)
ALTER TABLE Zaloga ADD CONSTRAINT Sklad_Pilot
    FOREIGN KEY (Pilot_Id)
    REFERENCES Zawodnik (Id);

-- Reference: Wyniki_Rajd_OdcinekSpecjalny (table: Wyniki)
ALTER TABLE Wyniki ADD CONSTRAINT Wyniki_Rajd_OdcinekSpecjalny
    FOREIGN KEY (Rajd_OdcinekSpecjalny_Id)
    REFERENCES Rajd_OdcinekSpecjalny (Id);

-- Reference: Wyniki_Rajd_Zaloga (table: Wyniki)
ALTER TABLE Wyniki ADD CONSTRAINT Wyniki_Rajd_Zaloga
    FOREIGN KEY (Rajd_Zaloga_Id)
    REFERENCES Rajd_Zaloga (Id);

-- End of file.

