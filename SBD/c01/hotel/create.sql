-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-03-04 17:48:37.775

-- tables
-- Table: Gosc
CREATE TABLE Gosc (
    IdGosc integer  NOT NULL,
    Imie varchar2(30)  NOT NULL,
    Nazwisko varchar2(50)  NOT NULL,
    Rabat number(2,2)  NOT NULL,
    CONSTRAINT Gosc_pk PRIMARY KEY (IdGosc)
) ;

-- Table: KategoriaDict
CREATE TABLE KategoriaDict (
    Key varchar2(2)  NOT NULL,
    Value varchar2(20)  NOT NULL,
    CONSTRAINT KategoriaDict_pk PRIMARY KEY (Key)
) ;

-- Table: Pokoj
CREATE TABLE Pokoj (
    IdPokoj integer  NOT NULL,
    KategoriaDict_Key varchar2(2)  NOT NULL,
    IloscMiejsc integer  NOT NULL,
    CONSTRAINT Pokoj_pk PRIMARY KEY (IdPokoj)
) ;

-- Table: RezerwacjaPrzydzielona
CREATE TABLE RezerwacjaPrzydzielona (
    IdRezerwacjaPrzydzielona integer  NOT NULL,
    KategoriaDict_Key varchar2(2)  NOT NULL,
    IloscPokoi integer  NOT NULL,
    Gosc_IdGosc integer  NOT NULL,
    Data_start date  NOT NULL,
    Data_koniec date  NOT NULL,
    CONSTRAINT RezerwacjaPrzydzielona_pk PRIMARY KEY (IdRezerwacjaPrzydzielona)
) ;

-- Table: RezerwacjaZamowiona
CREATE TABLE RezerwacjaZamowiona (
    IdRezerwacjaZamowiona integer  NOT NULL,
    Gosc_IdGosc integer  NOT NULL,
    Data_start date  NOT NULL,
    Data_koniec date  NOT NULL,
    Pokoj_IdPokoj integer  NOT NULL,
    CONSTRAINT RezerwacjaZamowiona_pk PRIMARY KEY (IdRezerwacjaZamowiona)
) ;

-- foreign keys
-- Reference: Pokoj_KategoriaDict (table: Pokoj)
ALTER TABLE Pokoj ADD CONSTRAINT Pokoj_KategoriaDict
    FOREIGN KEY (KategoriaDict_Key)
    REFERENCES KategoriaDict (Key);

-- Reference: Przydzielona_KategoriaDict (table: RezerwacjaPrzydzielona)
ALTER TABLE RezerwacjaPrzydzielona ADD CONSTRAINT Przydzielona_KategoriaDict
    FOREIGN KEY (KategoriaDict_Key)
    REFERENCES KategoriaDict (Key);

-- Reference: RezerwacjaPrzydzielona_Gosc (table: RezerwacjaPrzydzielona)
ALTER TABLE RezerwacjaPrzydzielona ADD CONSTRAINT RezerwacjaPrzydzielona_Gosc
    FOREIGN KEY (Gosc_IdGosc)
    REFERENCES Gosc (IdGosc);

-- Reference: RezerwacjaZamowiona_Gosc (table: RezerwacjaZamowiona)
ALTER TABLE RezerwacjaZamowiona ADD CONSTRAINT RezerwacjaZamowiona_Gosc
    FOREIGN KEY (Gosc_IdGosc)
    REFERENCES Gosc (IdGosc);

-- Reference: RezerwacjaZamowiona_Pokoj (table: RezerwacjaZamowiona)
ALTER TABLE RezerwacjaZamowiona ADD CONSTRAINT RezerwacjaZamowiona_Pokoj
    FOREIGN KEY (Pokoj_IdPokoj)
    REFERENCES Pokoj (IdPokoj);

-- End of file.

