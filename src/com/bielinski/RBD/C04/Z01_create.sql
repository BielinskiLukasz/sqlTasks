-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:53:40.379

-- tables
-- Table: LiniaAutobusowa
CREATE TABLE LiniaAutobusowa (
    Id integer  NOT NULL,
    CONSTRAINT LiniaAutobusowa_pk PRIMARY KEY (Id)
) ;

-- Table: Odjazd
CREATE TABLE Odjazd (
    Id integer  NOT NULL,
    LiniaAutobusowa_Id integer  NOT NULL,
    Przystanek_Id integer  NOT NULL,
    CONSTRAINT Odjazd_pk PRIMARY KEY (Id)
) ;

-- Table: Przystanek
CREATE TABLE Przystanek (
    Id integer  NOT NULL,
    Nazwa varchar2(100)  NOT NULL,
    CONSTRAINT Przystanek_pk PRIMARY KEY (Id)
) ;

-- foreign keys
-- Reference: Odjazd_LiniaAutobusowa (table: Odjazd)
ALTER TABLE Odjazd ADD CONSTRAINT Odjazd_LiniaAutobusowa
    FOREIGN KEY (LiniaAutobusowa_Id)
    REFERENCES LiniaAutobusowa (Id);

-- Reference: Odjazd_Przystanek (table: Odjazd)
ALTER TABLE Odjazd ADD CONSTRAINT Odjazd_Przystanek
    FOREIGN KEY (Przystanek_Id)
    REFERENCES Przystanek (Id);

-- End of file.

