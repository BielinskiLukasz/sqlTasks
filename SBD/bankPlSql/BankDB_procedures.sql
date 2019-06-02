-- Procedura lokaty
-- Dla każdej lokaty jeżeli data zakończenia lokaty (data rozpoczęcia + okres w miesiącach) jest mniejsza (wcześniejsza)
-- niż dzisiejsza data to usuwa daną lokatę i przesyła kwotę na jeden z rachunków klienta (domyślnie pierwszy)
-- zwiększając daną kwotę o odpowiednie odsetki (w skali roku)

CREATE OR REPLACE PROCEDURE check_investments
    IS
    cIdKlientLokata INTEGER;
    cOkres          INTEGER;
    cIdKlient       INTEGER;
    lIdRachunek     INTEGER;
    cKwota          NUMBER;
    cOprocentowanie NUMBER;
    kwotaZLokaty    NUMBER;
    CURSOR c1 IS
        SELECT kl.IdKlient_Lokata, kl.Kwota, l.Oprocentowanie, kl.Okres, kl.IdKlient
        FROM KLIENT_LOKATA kl
                 JOIN LOKATA l ON kl.IdKlient_Lokata = l.IdLokata
        WHERE ADD_MONTHS(DataZalozenia, kl.Okres) < CURRENT_DATE;

BEGIN
    OPEN c1;

    FETCH c1 INTO cIdKlientLokata, cKwota, cOprocentowanie, cOkres, cIdKlient;

    WHILE c1%FOUND
        LOOP
            SELECT MIN(IdRachunek) INTO lIdRachunek FROM Klient_Rachunek WHERE IdKlient = cIdKlient;
            kwotaZLokaty := ROUND(cKwota + cKwota * cOprocentowanie / 100 / 12 * cOkres, 2);
            UPDATE Rachunek SET StanKonta = StanKonta + kwotaZLokaty WHERE IdRachunek = lIdRachunek;
            DELETE FROM Klient_Lokata WHERE IdKlient_Lokata = cIdKlientLokata;

            FETCH c1 INTO cIdKlientLokata, cKwota, cOprocentowanie, cOkres, cIdKlient;
        END LOOP;

    COMMIT;

    CLOSE c1;

END check_investments;

BEGIN
    check_investments();
END;


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

CREATE OR REPLACE PROCEDURE check_accounts(debtInterest NUMBER)
    IS
    cIdRachunek     INTEGER;
    cStanKonta      NUMBER;
    cOprocentowanie NUMBER;
    CURSOR c1 IS
        SELECT IdRachunek, StanKonta, Oprocentowanie
        FROM Rachunek
        WHERE DataZamknieciaRachunku IS NULL
          AND StanKonta != 0;

BEGIN
    OPEN c1;

    FETCH c1 INTO cIdRachunek, cStanKonta, cOprocentowanie;

    WHILE c1%FOUND
        LOOP
            IF cStanKonta > 0 THEN
                UPDATE Rachunek
                SET StanKonta = ROUND(StanKonta * (1 + cOprocentowanie / 100 / 12), 2)
                WHERE IdRachunek = cIdRachunek;
            ELSE
                UPDATE Rachunek
                SET StanKonta = ROUND(StanKonta * (1 + debtInterest / 100 / 12), 2)
                WHERE IdRachunek = cIdRachunek;
            END IF;

            FETCH c1 INTO cIdRachunek, cStanKonta, cOprocentowanie;
        END LOOP;

    COMMIT;

    CLOSE c1;

END check_accounts;

BEGIN
    check_accounts(1200);
END;
