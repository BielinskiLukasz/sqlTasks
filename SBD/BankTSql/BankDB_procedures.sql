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


-- procedura aktualizująca stan konta o odsetki dla każdego rachunku
