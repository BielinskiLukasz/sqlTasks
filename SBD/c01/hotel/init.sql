-- tables
-- Table: Gosc
INSERT INTO Gosc VALUES (1, 'Ferdynand', 'Kiepski', 15.15);
INSERT INTO Gosc VALUES (2, 'Olaf', 'Kowalski', 8.15);
INSERT INTO Gosc VALUES (3, 'Adam', 'Nowak', 30.0);

-- Table: KategoriaDict
INSERT INTO KategoriaDict VALUES ('PK', 'Pokoj');
INSERT INTO KategoriaDict VALUES ('AP', 'Apartament');


-- Table: Pokoj
INSERT INTO Pokoj VALUES (1, 'PK', 1);
INSERT INTO Pokoj VALUES (2, 'PK', 2);
INSERT INTO Pokoj VALUES (3, 'PK', 2);
INSERT INTO Pokoj VALUES (4, 'PK', 1);
INSERT INTO Pokoj VALUES (5, 'AP', 3);
INSERT INTO Pokoj VALUES (6, 'AP', 2);

-- Table: RezerwacjaPrzydzielona
INSERT INTO RezerwacjaPrzydzielona VALUES (1, 'PK', 2, 1, TO_DATE('2018-01-01', 'YYYY-MM-DD'), TO_DATE('2018-01-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (2, 'PK', 2, 3, TO_DATE('2018-02-01', 'YYYY-MM-DD'), TO_DATE('2018-02-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (3, 'PK', 3, 2, TO_DATE('2018-01-02', 'YYYY-MM-DD'), TO_DATE('2018-02-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (4, 'AP', 2, 1, TO_DATE('2018-03-01', 'YYYY-MM-DD'), TO_DATE('2018-03-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (5, 'PK', 4, 2, TO_DATE('2019-01-03', 'YYYY-MM-DD'), TO_DATE('2019-03-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (6, 'AP', 2, 3, TO_DATE('2018-04-01', 'YYYY-MM-DD'), TO_DATE('2018-04-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (7, 'AP', 2, 2, TO_DATE('2018-01-04', 'YYYY-MM-DD'), TO_DATE('2018-01-12', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (8, 'PK', 3, 3, TO_DATE('2018-05-01', 'YYYY-MM-DD'), TO_DATE('2018-10-02', 'YYYY-MM-DD'));
INSERT INTO RezerwacjaPrzydzielona VALUES (9, 'PK', 2, 2, TO_DATE('2018-01-06', 'YYYY-MM-DD'), TO_DATE('2018-02-02', 'YYYY-MM-DD'));

-- Table: RezerwacjaZamowiona
INSERT INTO RezerwacjaZamowiona VALUES (1, 1, TO_DATE('2018-01-01', 'YYYY-MM-DD'), TO_DATE('2018-01-02', 'YYYY-MM-DD'), 1);
INSERT INTO RezerwacjaZamowiona VALUES (2, 2, TO_DATE('2018-02-01', 'YYYY-MM-DD'), TO_DATE('2018-02-02', 'YYYY-MM-DD'), 2);
INSERT INTO RezerwacjaZamowiona VALUES (3, 3, TO_DATE('2018-01-02', 'YYYY-MM-DD'), TO_DATE('2018-02-02', 'YYYY-MM-DD'), 3);
INSERT INTO RezerwacjaZamowiona VALUES (4, 2, TO_DATE('2018-03-01', 'YYYY-MM-DD'), TO_DATE('2018-03-02', 'YYYY-MM-DD'), 4);
INSERT INTO RezerwacjaZamowiona VALUES (5, 1, TO_DATE('2018-01-03', 'YYYY-MM-DD'), TO_DATE('2018-03-02', 'YYYY-MM-DD'), 5);
INSERT INTO RezerwacjaZamowiona VALUES (6, 2, TO_DATE('2018-04-01', 'YYYY-MM-DD'), TO_DATE('2018-04-02', 'YYYY-MM-DD'), 6);
INSERT INTO RezerwacjaZamowiona VALUES (7, 3, TO_DATE('2017-01-04', 'YYYY-MM-DD'), TO_DATE('2017-01-12', 'YYYY-MM-DD'), 5);
INSERT INTO RezerwacjaZamowiona VALUES (8, 2, TO_DATE('2018-05-01', 'YYYY-MM-DD'), TO_DATE('2018-10-02', 'YYYY-MM-DD'), 4);
INSERT INTO RezerwacjaZamowiona VALUES (9, 1, TO_DATE('2018-01-06', 'YYYY-MM-DD'), TO_DATE('2018-02-02', 'YYYY-MM-DD'), 5);

-- End of file.

