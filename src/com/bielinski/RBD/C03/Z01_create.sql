-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:26:10.483

-- tables
-- Table: Jezyk
CREATE TABLE Jezyk (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Jezyk_pk PRIMARY KEY (Id)
) ;

-- Table: Kontynent
CREATE TABLE Kontynent (
    Id integer  NOT NULL,
    Nazwa varchar2(20)  NOT NULL,
    CONSTRAINT Kontynent_pk PRIMARY KEY (Id)
) ;

-- Table: Miasto
CREATE TABLE Miasto (
    Id integer  NOT NULL,
    Nazwa varchar2(100)  NOT NULL,
    Panstwo_Id integer  NOT NULL,
    CONSTRAINT Miasto_pk PRIMARY KEY (Id)
) ;

-- Table: Morze
CREATE TABLE Morze (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Morze_pk PRIMARY KEY (Id)
) ;

-- Table: Panstwo
CREATE TABLE Panstwo (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Panstwo_pk PRIMARY KEY (Id)
) ;

-- Table: Panstwo_Jezyk
CREATE TABLE Panstwo_Jezyk (
    Panstwo_Id integer  NOT NULL,
    Jezyk_Id integer  NOT NULL,
    CONSTRAINT Panstwo_Jezyk_pk PRIMARY KEY (Panstwo_Id,Jezyk_Id)
) ;

-- Table: Panstwo_Kontynent
CREATE TABLE Panstwo_Kontynent (
    Panstwo_Id integer  NOT NULL,
    Kontynent_Id integer  NOT NULL,
    CONSTRAINT Panstwo_Kontynent_pk PRIMARY KEY (Panstwo_Id,Kontynent_Id)
) ;

-- Table: Panstwo_Morze
CREATE TABLE Panstwo_Morze (
    Panstwo_Id integer  NOT NULL,
    Morze_Id integer  NOT NULL,
    DlugoscGranicyMorskiej integer  NOT NULL,
    CONSTRAINT Panstwo_Morze_pk PRIMARY KEY (Panstwo_Id,Morze_Id)
) ;

-- foreign keys
-- Reference: Miasto_Panstwo (table: Miasto)
ALTER TABLE Miasto ADD CONSTRAINT Miasto_Panstwo
    FOREIGN KEY (Panstwo_Id)
    REFERENCES Panstwo (Id);

-- Reference: Panstwo_Jezyk_Jezyk (table: Panstwo_Jezyk)
ALTER TABLE Panstwo_Jezyk ADD CONSTRAINT Panstwo_Jezyk_Jezyk
    FOREIGN KEY (Jezyk_Id)
    REFERENCES Jezyk (Id);

-- Reference: Panstwo_Jezyk_Panstwo (table: Panstwo_Jezyk)
ALTER TABLE Panstwo_Jezyk ADD CONSTRAINT Panstwo_Jezyk_Panstwo
    FOREIGN KEY (Panstwo_Id)
    REFERENCES Panstwo (Id);

-- Reference: Panstwo_Kontynent_Kontynent (table: Panstwo_Kontynent)
ALTER TABLE Panstwo_Kontynent ADD CONSTRAINT Panstwo_Kontynent_Kontynent
    FOREIGN KEY (Kontynent_Id)
    REFERENCES Kontynent (Id);

-- Reference: Panstwo_Kontynent_Panstwo (table: Panstwo_Kontynent)
ALTER TABLE Panstwo_Kontynent ADD CONSTRAINT Panstwo_Kontynent_Panstwo
    FOREIGN KEY (Panstwo_Id)
    REFERENCES Panstwo (Id);

-- Reference: Panstwo_Morze_Morze (table: Panstwo_Morze)
ALTER TABLE Panstwo_Morze ADD CONSTRAINT Panstwo_Morze_Morze
    FOREIGN KEY (Morze_Id)
    REFERENCES Morze (Id);

-- Reference: Panstwo_Morze_Panstwo (table: Panstwo_Morze)
ALTER TABLE Panstwo_Morze ADD CONSTRAINT Panstwo_Morze_Panstwo
    FOREIGN KEY (Panstwo_Id)
    REFERENCES Panstwo (Id);

-- End of file.

