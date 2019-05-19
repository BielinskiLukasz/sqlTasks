-- Dodawanie/edycja klienta
-- Zadaniem wyzwalacza jest sprawdzenie danych klienta przy ich wprowadzaniu:
-- -> sprawdzi, czy dany pesel nie jest już zarejestrowany w systemie BŁĄD
-- -> sprawdzi, czy dany identyfikator nie jest już używany w systemie BŁAD
-- -> poinformuje, czy któryś z telefonów jest już używany w systemie BŁĄD
-- -> poinformuje, czy któryś z adresów email jest już używany w systemie BŁAD

CREATE TRIGGER clientData
    ON Klient
    FOR Insert, Update
    AS
BEGIN
    DECLARE
        @idKlient        INT,
        @nrPesel         BIGINT,
        @identyfikatorNr VARCHAR(50)
    SELECT @idKlient = IdKlient FROM inserted
    SELECT @nrPesel = NrPesel FROM inserted
    SELECT @identyfikatorNr = Nr
    FROM inserted
             JOIN Identyfikator ON inserted.IdIdentyfikator = Identyfikator.IdIdentyfikator

    DECLARE otherClients CURSOR FOR SELECT IdKlient, NrPesel, Nr
                                    FROM Klient
                                             JOIN Identyfikator
                                                  ON Klient.IdIdentyfikator = Identyfikator.IdIdentyfikator
                                    WHERE IdKlient != @idKlient;
    DECLARE
        @idKlientCheck        INT,
        @nrPeselCheck         BIGINT,
        @identyfikatorNrCheck VARCHAR(50)
    OPEN otherClients
    FETCH NEXT FROM otherClients INTO @idKlientCheck, @nrPeselCheck, @identyfikatorNrCheck;
    WHILE @@Fetch_status = 0
    BEGIN
        IF @nrPesel = @nrPeselCheck
            BEGIN
                ROLLBACK
                RAISERROR ('Istnieje już klient o takim numerze pesel',1,2)
            END
        ELSE
            IF @identyfikatorNr = @identyfikatorNrCheck
                BEGIN
                    ROLLBACK
                    RAISERROR ('Istnieje już klient o takim numerze dokumentu',1,2)
                END
        FETCH NEXT FROM otherClients INTO @idKlientCheck, @nrPeselCheck, @identyfikatorNrCheck;
    END;
    CLOSE otherClients;
    DEALLOCATE otherClients;
END;

CREATE TRIGGER phoneNumbersData
    ON Telefon
    FOR Insert, Update
    AS
BEGIN
    DECLARE
        @numerTelefonu VARCHAR(20)
    SELECT @numerTelefonu = Numer FROM inserted

    DECLARE phonesNumber CURSOR FOR SELECT Numer
                                    FROM Telefon
    DECLARE
        @phoneNumber VARCHAR(20)
    OPEN phonesNumber
    FETCH NEXT FROM phonesNumber INTO @phoneNumber;
    WHILE @@Fetch_status = 0
    BEGIN
        IF @phoneNumber = @numerTelefonu
            BEGIN
                ROLLBACK
                RAISERROR ('Istnieje już wpis z takim numerem telefonu',1,2)
            END
        FETCH NEXT FROM phonesNumber INTO @phoneNumber;
    END;
    CLOSE phonesNumber;
    DEALLOCATE phonesNumber;
END;

CREATE TRIGGER emailsData
    ON Email
    FOR Insert, Update
    AS
BEGIN
    DECLARE
        @adresEmail VARCHAR(50)
    SELECT @adresEmail = Adres FROM inserted

    DECLARE emails CURSOR FOR SELECT Adres
                              FROM Email
    DECLARE
        @email VARCHAR(50)
    OPEN emails
    FETCH NEXT FROM emails INTO @email;
    WHILE @@Fetch_status = 0
    BEGIN
        IF @email = @adresEmail
            BEGIN
                ROLLBACK
                RAISERROR ('Istnieje już wpis z takim adresem email',1,2)
            END
        FETCH NEXT FROM emails INTO @email;
    END;
    CLOSE emails;
    DEALLOCATE emails;
END;

-- zdublowany pesel
INSERT INTO Klient
VALUES (12, 'Łukasz', 'Paweł', 'Nowak', 92111907850, 'Tomasz', 'Ewa', 'Filipska', CONVERT(DATETIME, '1992-11-19'),
        'Moskwa', NULL, 1, 'USA', 'WOL', 11, 2, 9, 9, 9);

-- zdublowany dowód
INSERT INTO Klient
VALUES (13, 'Łukasz', 'Paweł', 'Nowak', 92111907851, 'Tomasz', 'Ewa', 'Filipska', CONVERT(DATETIME, '1992-11-19'),
        'Moskwa', NULL, 1, 'USA', 'WOL', 11, 2, 9, 9, 9);

-- zdublowany telefon
INSERT INTO Telefon
VALUES (16, '984231065', 0, 4);

-- zdublowany email
INSERT INTO Email
VALUES (15, 'koszary@com.pl', 0, 5);


-- Zmiana operacji
-- Zgodnie z projektem BD operacja jest przypisana do relacji rachunek_operacja, a więc dana operacja może dotyczyć
-- zarówno jednego rachunku (przelew do/z banku) jak i dwóch rachunków (przelew między rachunkami w danym banku).
-- Zadaniem wyzwalacza jest aktualizacja stanu konta/kont dla dodawanych/aktualizowanych/usuwanych operacji.




-- Finanse banku
-- Tworzona jest tabela zawierająca informacje o funduszach zgromadzonych na rachunkach i lokatach. Do rachunków i lokat
-- doczepiany jest wyzwalacz dbający o to, aby kwota była zawsze aktualna.