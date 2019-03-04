-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-03-04 17:48:37.775

-- foreign keys
ALTER TABLE Pokoj
    DROP CONSTRAINT Pokoj_KategoriaDict;

ALTER TABLE RezerwacjaPrzydzielona
    DROP CONSTRAINT Przydzielona_KategoriaDict;

ALTER TABLE RezerwacjaPrzydzielona
    DROP CONSTRAINT RezerwacjaPrzydzielona_Gosc;

ALTER TABLE RezerwacjaZamowiona
    DROP CONSTRAINT RezerwacjaZamowiona_Gosc;

ALTER TABLE RezerwacjaZamowiona
    DROP CONSTRAINT RezerwacjaZamowiona_Pokoj;

-- tables
DROP TABLE Gosc;

DROP TABLE KategoriaDict;

DROP TABLE Pokoj;

DROP TABLE RezerwacjaPrzydzielona;

DROP TABLE RezerwacjaZamowiona;

-- End of file.

