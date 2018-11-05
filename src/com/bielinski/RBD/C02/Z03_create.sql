-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:19:30.33

-- tables
-- Table: Agent
CREATE TABLE Agent (
    id integer  NOT NULL,
    imie varchar2(50)  NOT NULL,
    nazwisko varchar2(100)  NOT NULL,
    stopien varchar2(50)  NOT NULL,
    CONSTRAINT Agent_pk PRIMARY KEY (id)
) ;

-- Table: Akcja
CREATE TABLE Akcja (
    id integer  NOT NULL,
    kryptonim varchar2(50)  NOT NULL,
    cel varchar2(50)  NOT NULL,
    teren varchar2(50)  NOT NULL,
    data_start date  NOT NULL,
    data_stop date  NOT NULL,
    CONSTRAINT Akcja_pk PRIMARY KEY (id)
) ;

-- Table: Akcja_Agent
CREATE TABLE Akcja_Agent (
    id integer  NOT NULL,
    Akcja_id integer  NOT NULL,
    Agent_id integer  NOT NULL,
    pseudonim varchar2(50)  NOT NULL,
    CONSTRAINT Akcja_Agent_pk PRIMARY KEY (id)
) ;

-- Table: Notatka
CREATE TABLE Notatka (
    id integer  NOT NULL,
    data date  NOT NULL,
    Akcja_Agent_id integer  NOT NULL,
    CONSTRAINT Notatka_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Akcja_Agent_Agent (table: Akcja_Agent)
ALTER TABLE Akcja_Agent ADD CONSTRAINT Akcja_Agent_Agent
    FOREIGN KEY (Agent_id)
    REFERENCES Agent (id);

-- Reference: Akcja_Agent_Akcja (table: Akcja_Agent)
ALTER TABLE Akcja_Agent ADD CONSTRAINT Akcja_Agent_Akcja
    FOREIGN KEY (Akcja_id)
    REFERENCES Akcja (id);

-- Reference: Notatka_Akcja_Agent (table: Notatka)
ALTER TABLE Notatka ADD CONSTRAINT Notatka_Akcja_Agent
    FOREIGN KEY (Akcja_Agent_id)
    REFERENCES Akcja_Agent (id);

-- End of file.

