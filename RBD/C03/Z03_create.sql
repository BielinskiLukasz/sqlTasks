-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-05 19:34:46.427

-- tables
-- Table: Druzyna
CREATE TABLE Druzyna (
    Id integer  NOT NULL,
    CONSTRAINT Druzyna_pk PRIMARY KEY (Id)
) ;

-- Table: Kartka
CREATE TABLE Kartka (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Kartka_pk PRIMARY KEY (Id)
) ;

-- Table: KartkaWMeczu
CREATE TABLE KartkaWMeczu (
    Id integer  NOT NULL,
    SkladNaMecz_Id integer  NOT NULL,
    Minuta integer  NOT NULL,
    Kartka_Id integer  NOT NULL,
    CONSTRAINT KartkaWMeczu_pk PRIMARY KEY (Id)
) ;

-- Table: Mecz
CREATE TABLE Mecz (
    Id integer  NOT NULL,
    Druzyna_Id integer  NOT NULL,
    Druzyna_2_Id integer  NOT NULL,
    CONSTRAINT Mecz_pk PRIMARY KEY (Id)
) ;

-- Table: Pilkarz
CREATE TABLE Pilkarz (
    Id integer  NOT NULL,
    Druzyna_Id integer  NOT NULL,
    CONSTRAINT Pilkarz_pk PRIMARY KEY (Id)
) ;

-- Table: Strona
CREATE TABLE Strona (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Strona_pk PRIMARY KEY (Id)
) ;

-- Table: WystepWMeczu
CREATE TABLE WystepWMeczu (
    Id integer  NOT NULL,
    Pilkarz_Id integer  NOT NULL,
    Mecz_Id integer  NOT NULL,
    Strona_Id integer  NOT NULL,
    Nr varchar2(20)  NOT NULL,
    Pozycja varchar2(20)  NOT NULL,
    MinutaRozpoczecia integer  NOT NULL,
    MinutaZejscia integer  NOT NULL,
    CONSTRAINT WystepWMeczu_pk PRIMARY KEY (Id)
) ;

-- foreign keys
-- Reference: KartkaWMeczu_Kartka (table: KartkaWMeczu)
ALTER TABLE KartkaWMeczu ADD CONSTRAINT KartkaWMeczu_Kartka
    FOREIGN KEY (Kartka_Id)
    REFERENCES Kartka (Id);

-- Reference: Kartki_SkladNaMecz (table: KartkaWMeczu)
ALTER TABLE KartkaWMeczu ADD CONSTRAINT Kartki_SkladNaMecz
    FOREIGN KEY (SkladNaMecz_Id)
    REFERENCES WystepWMeczu (Id);

-- Reference: Mecz_Druzyna (table: Mecz)
ALTER TABLE Mecz ADD CONSTRAINT Mecz_Druzyna
    FOREIGN KEY (Druzyna_Id)
    REFERENCES Druzyna (Id);

-- Reference: Mecz_Druzyna_2 (table: Mecz)
ALTER TABLE Mecz ADD CONSTRAINT Mecz_Druzyna_2
    FOREIGN KEY (Druzyna_2_Id)
    REFERENCES Druzyna (Id);

-- Reference: Pilkarz_Druzyna (table: Pilkarz)
ALTER TABLE Pilkarz ADD CONSTRAINT Pilkarz_Druzyna
    FOREIGN KEY (Druzyna_Id)
    REFERENCES Druzyna (Id);

-- Reference: WystepWMeczu_Mecz (table: WystepWMeczu)
ALTER TABLE WystepWMeczu ADD CONSTRAINT WystepWMeczu_Mecz
    FOREIGN KEY (Mecz_Id)
    REFERENCES Mecz (Id);

-- Reference: WystepWMeczu_Pilkarz (table: WystepWMeczu)
ALTER TABLE WystepWMeczu ADD CONSTRAINT WystepWMeczu_Pilkarz
    FOREIGN KEY (Pilkarz_Id)
    REFERENCES Pilkarz (Id);

-- Reference: WystepWMeczu_Strona (table: WystepWMeczu)
ALTER TABLE WystepWMeczu ADD CONSTRAINT WystepWMeczu_Strona
    FOREIGN KEY (Strona_Id)
    REFERENCES Strona (Id);

-- End of file.

