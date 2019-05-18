-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-05-18 09:32:35.599

-- foreign keys
ALTER TABLE BankDict DROP CONSTRAINT BankDict_Adres;

ALTER TABLE Email DROP CONSTRAINT Email_Klient;

ALTER TABLE IdentyfikatorKonta DROP CONSTRAINT IdentyfikatorKonta_Adres;

ALTER TABLE IdentyfikatorKonta DROP CONSTRAINT IdentyfikatorKonta_BankDict;

ALTER TABLE Identyfikator DROP CONSTRAINT Identyfikator_Dict;

ALTER TABLE Karta DROP CONSTRAINT Karta_KartaDict;

ALTER TABLE Karta DROP CONSTRAINT Karta_Klient_Rachunek;

ALTER TABLE Rachunek_Operacja DROP CONSTRAINT KategoriaDict;

ALTER TABLE Klient DROP CONSTRAINT Klient_AdresKorespondencyjny;

ALTER TABLE Klient DROP CONSTRAINT Klient_AdresZameldowania;

ALTER TABLE Klient DROP CONSTRAINT Klient_AdresZamieszkania;

ALTER TABLE Klient DROP CONSTRAINT Klient_Identyfikator;

ALTER TABLE Klient_Lokata DROP CONSTRAINT Klient_Lokata_Klient;

ALTER TABLE Klient_Lokata DROP CONSTRAINT Klient_Lokata_Lokata;

ALTER TABLE Klient DROP CONSTRAINT Klient_ObywatelstwoDict;

ALTER TABLE Klient_Rachunek DROP CONSTRAINT Klient_Rachunek_Klient;

ALTER TABLE Klient_Rachunek DROP CONSTRAINT Klient_Rachunek_Rachunek;

ALTER TABLE Klient DROP CONSTRAINT Klient_StanCywilnyDict;

ALTER TABLE Klient DROP CONSTRAINT Klient_Urzad_skarbowy;

ALTER TABLE Rachunek_Operacja DROP CONSTRAINT OperacjaWychodzacaDane;

ALTER TABLE Operacja DROP CONSTRAINT Operacja_IdentyfikatorKonta;

ALTER TABLE OperacjaWychodzacaDane DROP CONSTRAINT PlatnoscDict;

ALTER TABLE Rachunek_Operacja DROP CONSTRAINT Rachunek_Operacja_Klient;

ALTER TABLE Rachunek_Operacja DROP CONSTRAINT Rachunek_Operacja_Operacja;

ALTER TABLE Rachunek_Operacja DROP CONSTRAINT Rachunek_Operacja_Rachunek;

ALTER TABLE Rachunek DROP CONSTRAINT Rachunek_RachunekDict;

ALTER TABLE Rachunek_Operacja DROP CONSTRAINT RodzajOperacjiDict;

ALTER TABLE Telefon DROP CONSTRAINT Telefon_Klient;

ALTER TABLE Urzad_skarbowy DROP CONSTRAINT Urzad_skarbowy_Adres;

-- tables
DROP TABLE Adres;

DROP TABLE BankDict;

DROP TABLE Email;

DROP TABLE Identyfikator;

DROP TABLE IdentyfikatorDict;

DROP TABLE IdentyfikatorKonta;

DROP TABLE Karta;

DROP TABLE KartaDict;

DROP TABLE KategoriaDict;

DROP TABLE Klient;

DROP TABLE Klient_Lokata;

DROP TABLE Klient_Rachunek;

DROP TABLE Lokata;

DROP TABLE ObywatelstwoDict;

DROP TABLE Operacja;

DROP TABLE OperacjaWychodzacaDane;

DROP TABLE PlatnoscDict;

DROP TABLE Rachunek;

DROP TABLE RachunekDict;

DROP TABLE Rachunek_Operacja;

DROP TABLE RodzajOperacjiDict;

DROP TABLE StanCywilnyDict;

DROP TABLE Telefon;

DROP TABLE Urzad_skarbowy;

-- End of file.

