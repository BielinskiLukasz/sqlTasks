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
