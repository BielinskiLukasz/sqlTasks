-- Zmiana operacji
-- Zgodnie z projektem BD operacja jest przypisana do relacji rachunek_operacja, a więc dana operacja może dotyczyć
-- zarówno jednego rachunku (przelew do/z banku) jak i dwóch rachunków (przelew między rachunkami w danym banku).
-- Zadaniem wyzwalacza jest aktualizacja stanu konta/kont dla dodawanych/aktualizowanych/usuwanych operacji.

CREATE OR REPLACE TRIGGER updateAccount
    BEFORE UPDATE OF Kwota
    ON Operacja
    FOR EACH ROW
DECLARE
    modIdAccount NUMBER;
BEGIN
    SELECT IdRachunek
    INTO modIdAccount
    FROM Rachunek_Operacja ro
    WHERE ro.IdOperacja = :NEW.IdOperacja;

    UPDATE Rachunek
    SET StanKonta = StanKonta + NVL(:NEW.Kwota, 0) - NVL(:OLD.Kwota, 0)
    WHERE IdRachunek = modIdAccount;
END updateAccount;

CREATE OR REPLACE TRIGGER updateAccount2
    BEFORE INSERT OR DELETE OR UPDATE OF IdRachunek
    ON Rachunek_Operacja
    FOR EACH ROW
DECLARE
    oldFounds NUMBER;
    newFounds NUMBER;
BEGIN
    IF DELETING OR UPDATING THEN
        SELECT Kwota
        INTO oldFounds
        FROM Operacja
        WHERE IdOperacja = :OLD.IdOperacja;

        UPDATE Rachunek SET StanKonta = StanKonta - oldFounds WHERE IdRachunek = :OLD.IdRachunek;
    END IF;
    IF INSERTING OR UPDATING THEN
        SELECT Kwota
        INTO newFounds
        FROM Operacja
        WHERE IdOperacja = :NEW.IdOperacja;

        UPDATE Rachunek SET StanKonta = StanKonta + newFounds WHERE IdRachunek = :NEW.IdRachunek;
    END IF;
END updateAccount2;

-- Finanse banku
-- Tworzona jest tabela zawierająca informacje o funduszach zgromadzonych na rachunkach i lokatach. Do rachunków i lokat
-- doczepiany jest wyzwalacz dbający o to, aby kwota była zawsze aktualna.

CREATE TABLE finances
(
    valueOf FLOAT NOT NULL
)

BEGIN
    DECLARE
        sum1 FLOAT;
        sum2 FLOAT;
    SELECT SUM(StanKonta) INTO sum1 FROM Rachunek;
    SELECT SUM(Kwota) INTO sum2 FROM Klient_Lokata;
    INSERT INTO finances VALUES (sum1 + sum2);
END;

CREATE OR REPLACE TRIGGER updateFinancesFromAccounts
    BEFORE INSERT OR DELETE OR UPDATE OF StanKonta
    ON Rachunek
    FOR EACH ROW
BEGIN
    UPDATE finances SET valueOf = valueOf + NVL(:NEW.StanKonta, 0) - NVL(:OLD.StanKonta, 0);
END updateFinancesFromAccounts;

CREATE OR REPLACE TRIGGER updateFinancesFromInvestments
    BEFORE INSERT OR DELETE OR UPDATE OF Kwota
    ON Klient_Lokata
    FOR EACH ROW
BEGIN
    UPDATE finances SET valueOf = valueOf + NVL(:NEW.Kwota, 0) - NVL(:OLD.Kwota, 0);
END updateFinancesFromInvestments;

-- TESTS
SELECT value
FROM finances;

INSERT INTO Klient_Lokata
VALUES (9, 1000000.00, 25, CONVERT(DATETIME, '2017-12-30'), 2, 4);

SELECT value
FROM finances;


UPDATE Rachunek
SET StanKonta = 0
WHERE IdRachunek = 3;

SELECT value
FROM finances;

DELETE
FROM Klient_Lokata
WHERE IdKlient_Lokata = 9;

SELECT value
FROM finances;
