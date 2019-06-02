-- Procedura lokaty
-- Dla każdej lokaty jeżeli data zakończenia lokaty (data rozpoczęcia + okres w miesiącach) jest mniejsza (wcześniejsza)
-- niż dzisiejsza data to usuwa daną lokatę i przesyła kwotę na jeden z rachunków klienta (domyślnie pierwszy)
-- zwiększając daną kwotę o odpowiednie odsetki (w skali roku)

CREATE PROCEDURE check_investments
AS
BEGIN
    DECLARE investment CURSOR FOR SELECT IdKlient_Lokata, Kwota, Oprocentowanie, Okres, IdKlient
                                  FROM Klient_Lokata
                                           JOIN Lokata ON Klient_Lokata.IdLokata = Lokata.IdLokata
                                  WHERE dateadd(MM, Okres, DataZalozenia) < GetDate();
    DECLARE
        @idKlientLokata int, @kwota float, @oprocentowanie real, @okres int, @idKlient int;
    OPEN investment
    FETCH NEXT FROM investment INTO @idKlientLokata, @kwota, @oprocentowanie, @okres, @idKlient;
    WHILE @@Fetch_status = 0
    BEGIN
        DECLARE
            @idRachunek int, @kwotaZLokaty float;
        SELECT @idRachunek = MIN(IdRachunek) FROM Klient_Rachunek WHERE IdKlient = @idKlient;
        SELECT @kwotaZLokaty = ROUND(@kwota + @kwota * @oprocentowanie / 100 / 12 * @okres, 2);
        UPDATE Rachunek SET StanKonta = StanKonta + @kwotaZLokaty WHERE IdRachunek = @idRachunek;
        DELETE FROM Klient_Lokata WHERE IDKlient_Lokata = @idKlientLokata
        FETCH NEXT FROM investment INTO @idKlientLokata, @kwota, @oprocentowanie, @okres, @idKlient;
    END;
    CLOSE investment;
    DEALLOCATE investment;
END;
GO

EXEC check_investments;

-- NOTES
-- Na dzień 18.05.2019 procedura operowała na 4 lokatach (1, 3, 5, 7) odnoszących się do klientów 1, 5, 9 oraz 10.
-- Klienci Ci mieli przelewani środki odpowiednio na konta 1, 5, 9, 10.
-- Zmiana stanu konta dla przedstawionych rachunków wygląda następująco:
-- 0 -> 1000.00 na 18 miesięcy z oprocentowaniem 0,7% -> 1010.5
-- 984516.54 -> 5000.00 na 12 miesięcy z oprocentowaniem 0,5% -> 984516.54
-- 5619.15 -> 20000.00 na 15 miesięcy z oprocentowaniem 1,0% -> 25869.15
-- 8964513.68 -> 100000.00 na 17 miesięcy z oprocentowaniem 0,6% -> 9065363.68


-- Procedura oprocentowania
-- Dla każdego rachunku sprawdzany jest stan konta. Dla kwoty ujemnej stosowane jest oprocentowanie zaległości podawane
-- jako parametr procedury. Dla kwoty dodatniej do stanu konta dodawane są odsetki. Procedura uruchamiana na koniec
-- każdego miesiąca.

CREATE PROCEDURE check_accounts @debtInterest float
AS
BEGIN
    DECLARE account CURSOR FOR SELECT IdRachunek, StanKonta, Oprocentowanie
                               FROM Rachunek
                               WHERE DataZamknieciaRachunku IS NULL
                                 AND StanKonta != 0;
    DECLARE
        @idRachunek int, @stanKonta float, @oprocentowanie real;
    OPEN account
    FETCH NEXT FROM account INTO @idRachunek, @stanKonta, @oprocentowanie;
    WHILE @@Fetch_status = 0
    BEGIN
        IF @stanKonta > 0
            BEGIN
                UPDATE Rachunek
                SET StanKonta = ROUND(StanKonta * (1 + @oprocentowanie / 100 / 12), 2)
                WHERE IdRachunek = @idRachunek;
            END
        ELSE
            BEGIN
                UPDATE Rachunek
                SET StanKonta = ROUND(StanKonta * (1 + @debtInterest / 100 / 12), 2)
                WHERE IdRachunek = @idRachunek;
            END
        FETCH NEXT FROM account INTO @idRachunek, @stanKonta, @oprocentowanie;
    END;
    CLOSE account;
    DEALLOCATE account;
END;
GO

EXEC check_accounts 100;


-- UNUSED BELOW

-- Procedura przelewu
-- Dla przelewu danej kwoty z wybranego rachunku na inny należy:
-- -> sprawdzić, czy na wybranym rachunku znajdują się wymagane środki (WYJĄTEK JEŻELI NIE)
-- -> stworzyć powiązanie rachunek_operacja
-- -> zdefiniować rodzaj operacji (czy przelew między własnymi rachunkami?)
-- -> wprowadzić wszelkie dane związane z operacją
-- -> dla adresu, kategorii i płatności wprowadzono aktualnie null (niezaimplementowane)
-- -> przyjęto rachunki zewnętrzne jako ING, a dany bank jako PKO
-- -> zmniejszyć ilość środków na pierwszym koncie
-- -> jeżeli drugie konto również w banku to zwiększyć ilość środków na drugim koncie
-- TODO konieczne wstawianie relacji rachunek_operacja dla przelewów w przypadku, gdy drugi rachunek jest również w
--  bazie banku (przelew przychodzący) <-- baza danych powinna być przebudowana pod ten przypadek...

CREATE PROCEDURE transfer @amount float, @fromAccount bigint, @toAccount bigint, @idClient int
AS
BEGIN
    IF @idClient NOT IN (SELECT IdKlient
                         FROM Klient_Rachunek
                                  JOIN Rachunek ON Klient_Rachunek.IdRachunek = Rachunek.IdRachunek
                         WHERE NrRachunku = @fromAccount)
        RAISERROR ('Brak uprawnień',1,2)
    ELSE
        IF (SELECT StanKonta FROM Rachunek WHERE NrRachunku = @fromAccount) < @amount
            RAISERROR ('Brak środków',1,2)
        ELSE
            BEGIN
                DECLARE
                    @idRachunek int
                SELECT @idRachunek = IdRachunek FROM Rachunek WHERE NrRachunku = @fromAccount;
                -- czy drugi rachunek również w naszym banku
                DECLARE
                    @isSecondAccountInOurDB          bit,
                    @isOtherAccountBelongToOneClient bit,
                    @idOperacja                      int,
                    @idRachunek_Operacja             int,
                    @dziennyNrOperacji               int,
                    @idIdentyfikatorKonta            int
                SELECT @isSecondAccountInOurDB = COUNT(*) FROM Rachunek WHERE NrRachunku = @fromAccount
                SELECT @isOtherAccountBelongToOneClient = COUNT(*) - 1
                FROM Klient_Rachunek
                         JOIN Rachunek ON Klient_Rachunek.IdRachunek = Rachunek.IdRachunek
                WHERE IdKlient = @idClient
                  AND (NrRachunku = @fromAccount OR NrRachunku = @toAccount)
                -- operacja
                SELECT @idOperacja = 1 + MAX(IdOperacja) FROM Operacja
                SELECT @idIdentyfikatorKonta = 1 + MAX(IdIdentyfikatorKonta) FROM IdentyfikatorKonta
                IF (@isSecondAccountInOurDB = 0)
                    -- identyfikatorKonta dla rachunków zewnętrznych
                    INSERT INTO IdentyfikatorKonta VALUES (@idIdentyfikatorKonta, @toAccount, 'ING', null);
                ELSE
                    INSERT INTO IdentyfikatorKonta VALUES (@idIdentyfikatorKonta, @toAccount, 'PKO', null);
                INSERT INTO Operacja
                VALUES (@idOperacja, @amount, 'comment', CONVERT(DATETIME, sysdatetime()),
                        @idIdentyfikatorKonta);
                -- rachunek_operacja
                SELECT @idRachunek_Operacja = 1 + MAX(IdRachunek_Operacja) FROM Rachunek_Operacja
                SELECT @dziennyNrOperacji =
                       1 + ISNULL(MAX(DziennyNrOperacji) -- założenie zerowania rekordów dziennyNrOperacji o północy
                                  FROM Rachunek_Operacja
                                  JOIN Operacja ON Rachunek_Operacja.IdOperacja = Operacja.IdOperacja
                                  WHERE IdRachunek = @fromAccount, 0)
                IF (@isOtherAccountBelongToOneClient = 0)
                    -- operacjaWychodzącaDane dla przelewów wychodzących
                    BEGIN
                        DECLARE
                            @idOperacjaWychodzacaDane int
                        SELECT @idOperacjaWychodzacaDane = 1 + MAX(IdOperacjaWychodzacaDane) FROM OperacjaWychodzacaDane
                        INSERT INTO OperacjaWychodzacaDane
                        VALUES (@idOperacjaWychodzacaDane, CONVERT(DATETIME, sysdatetime()), null);
                        INSERT INTO Rachunek_Operacja
                        VALUES (@idRachunek_Operacja, @dziennyNrOperacji, @idRachunek, @idOperacja, 'WYC', null,
                                @idClient, @idOperacjaWychodzacaDane);
                    END
                ELSE
                    -- dla przelewów między własnymi rachunkami
                    BEGIN
                        INSERT INTO Rachunek_Operacja
                        VALUES (@idRachunek_Operacja, @dziennyNrOperacji, @idRachunek, @idOperacja, 'PMR', null,
                                @idClient, null);
                    END
                -- aktualizacja stanu konta
                UPDATE Rachunek
                SET StanKonta = StanKonta - @amount
                WHERE IdRachunek = @idRachunek
                IF (@isSecondAccountInOurDB = 1)
                    BEGIN
                        UPDATE Rachunek
                        SET StanKonta = StanKonta + @amount
                        WHERE IdRachunek =
                              (SELECT IdRachunek FROM Rachunek WHERE NrRachunku = @toAccount)
                    END
            END
END;
GO

-- brak uprawnień klienta do operacji na wybranym koncie
EXEC transfer 2000, 1234567890123456, 1218851198152165, 10;
-- brak środków
EXEC transfer 2000, 1234567890123456, 1218851198152165, 1;
-- przelew między rachunkami
EXEC transfer 50, 1218851198152165, 1234567890123456, 1;
-- przelew wychodzący w obrębie banku
EXEC transfer 100, 1218851198152165, 9416549564654659, 2;
-- przelew poza bank
EXEC transfer 200, 1218851198152165, 0000000000000000, 2;