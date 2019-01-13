-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:46:44.223

-- tables
-- Table: Alkohol
CREATE TABLE Alkohol (
    Napoj_Id integer  NOT NULL,
    Procenty float(5)  NOT NULL,
    CONSTRAINT Alkohol_pk PRIMARY KEY (Napoj_Id)
) ;

-- Table: Koktajl
CREATE TABLE Koktajl (
    Napoj_Id integer  NOT NULL,
    OpisPrzygotowania varchar2(500)  NOT NULL,
    CONSTRAINT Koktajl_pk PRIMARY KEY (Napoj_Id)
) ;

-- Table: Koktajl_Napoj
CREATE TABLE Koktajl_Napoj (
    Koktajl_Napoj_Id integer  NOT NULL,
    Napoj_Id integer  NOT NULL,
    ilosc integer  NOT NULL,
    CONSTRAINT Koktajl_Napoj_pk PRIMARY KEY (Koktajl_Napoj_Id)
) ;

-- Table: Napoj
CREATE TABLE Napoj (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Napoj_pk PRIMARY KEY (Id)
) ;

-- Table: Sok
CREATE TABLE Sok (
    Napoj_Id integer  NOT NULL,
    Owoc varchar2(50)  NOT NULL,
    CONSTRAINT Sok_pk PRIMARY KEY (Napoj_Id)
) ;

-- foreign keys
-- Reference: Alkohol_Napoj (table: Alkohol)
ALTER TABLE Alkohol ADD CONSTRAINT Alkohol_Napoj
    FOREIGN KEY (Napoj_Id)
    REFERENCES Napoj (Id);

-- Reference: Koktajl_Napoj (table: Koktajl)
ALTER TABLE Koktajl ADD CONSTRAINT Koktajl_Napoj
    FOREIGN KEY (Napoj_Id)
    REFERENCES Napoj (Id);

-- Reference: Koktajl_Napoj_Koktajl (table: Koktajl_Napoj)
ALTER TABLE Koktajl_Napoj ADD CONSTRAINT Koktajl_Napoj_Koktajl
    FOREIGN KEY (Koktajl_Napoj_Id)
    REFERENCES Koktajl (Napoj_Id);

-- Reference: Koktajl_Napoj_Napoj (table: Koktajl_Napoj)
ALTER TABLE Koktajl_Napoj ADD CONSTRAINT Koktajl_Napoj_Napoj
    FOREIGN KEY (Napoj_Id)
    REFERENCES Napoj (Id);

-- Reference: Sok_Napoj (table: Sok)
ALTER TABLE Sok ADD CONSTRAINT Sok_Napoj
    FOREIGN KEY (Napoj_Id)
    REFERENCES Napoj (Id);

-- End of file.

