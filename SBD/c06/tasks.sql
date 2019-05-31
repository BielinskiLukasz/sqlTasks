-- 1. (bez kursora) Utwórz tabelę Magazyn (IdPozycji, Nazwa, Ilosc) zawierającą ilości poszczególnych towarów w
-- magazynie i wstaw do niej kilka przykładowych rekordów.
-- W bloku PL/SQL sprawdź, którego artykułu jest najwięcej w magazynie i zmniejsz ilość tego artykułu o 5 (jeśli stan
-- jest większy lub równy 5, w przeciwnym wypadku zgłoś błąd).

CREATE TABLE Magazyn
(
    IdPozycji integer     NOT NULL,
    Nazwa     varchar(50) NOT NULL,
    Ilosc     float(10)   NOT NULL,
    CONSTRAINT Magazyn_pk PRIMARY KEY (IdPozycji)
);

INSERT INTO Magazyn
VALUES (1, 'Sample1', 10);
INSERT INTO Magazyn
VALUES (2, 'Sample2', 1);
INSERT INTO Magazyn
VALUES (3, 'Sample3', 9);
INSERT INTO Magazyn
VALUES (4, 'Sample4', 2);
INSERT INTO Magazyn
VALUES (5, 'Sample5', 8);
INSERT INTO Magazyn
VALUES (6, 'Sample6', 3);
INSERT INTO Magazyn
VALUES (7, 'Sample7', 7);
INSERT INTO Magazyn
VALUES (8, 'Sample8', 4);
INSERT INTO Magazyn
VALUES (9, 'Sample9', 6);
INSERT INTO Magazyn
VALUES (10, 'Sample10', 5);

COMMIT;

DECLARE
    maxIlosc INTEGER;
BEGIN
    SELECT MAX(Ilosc) INTO maxIlosc
    FROM Magazyn;
    IF maxIlosc < 5 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Za mało produktów w magazynie');
    ELSE
        UPDATE Magazyn
        SET Ilosc = maxIlosc - 5
        WHERE IdPozycji = (
            SELECT MIN(IdPozycji)
            FROM Magazyn
            WHERE Ilosc = maxIlosc
        );
    END IF;
END;

COMMIT;

-- 2. Przerób kod z zadania 1 na procedurę, której będziemy mogli podać wartość, o którą zmniejszamy stan (zamiast
-- wpisanego „na sztywno” 5).


-- 3. Utwórz wyzwalacz, który nie pozwoli usunąć rekordu z tabeli EMP.


-- 4. Utwórz wyzwalacz, który przy wstawianiu lub modyfikowaniu danych w tabeli EMP sprawdzi czy nowe zarobki
-- (wstawiane lub modyfikowane) są większe niż 1000. W przeciwnym przypadku wyzwalacz powinien zgłosić błąd i nie
-- dopuścić do wstawienia rekordu.
-- Uwaga: Ten sam efekt można uzyskać łatwiej przy pomocy więzów spójności typu CHECK. Użyjmy wyzwalacza w celach
-- treningowych.


-- 5. Utwórz tabelę budzet:
-- CREATE TABLE budzet (wartosc INT NOT NULL)


-- 6. W tabeli tej będzie przechowywana łączna wartość wynagrodzenia wszystkich pracowników. Tabela będzie zawsze
-- zawierała jeden wiersz. Należy najpierw obliczyć początkową wartość zarobków:
-- INSERT INTO budzet (wartosc)
-- SELECT SUM(sal) FROM emp


-- 7. Utwórz wyzwalacz, który będzie pilnował, aby wartość w tabeli budzet była zawsze aktualna, a więc przy wszystkich
-- operacjach aktualizujących tabelę EMP (INSERT, UPDATE, DELETE), wyzwalacz będzie aktualizował wpis w tabeli budżet.


-- 8. Napisz jeden wyzwalacz, który:
-- ➢ Nie pozwoli usunąć pracownika, którego pensja jest większa od 0.
-- ➢ Nie pozwoli zmienić nazwiska pracownika.
-- ➢ Nie pozwoli wstawić pracownika, który już istnieje (sprawdzając po nazwisku).


-- 9. Napisz wyzwalacz, który:
-- ➢ Nie pozwoli zmniejszać pensji.
-- ➢ Nie pozwoli usuwać pracowników.
