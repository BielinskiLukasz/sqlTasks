-- Created by LB
-- Last modification date: 2019-01-19 18:34:00.000

-- 1. Wypisanie wszytskich klientów wraz z ich rachunkami
SELECT k.Imie, k.Nazwisko, r.NrRachunku "NR RACHUNKU", to_char(round(r.stanKonta, 2), 'FM9999990.00') "STAN KONTA"
FROM klient k
LEFT JOIN klient_rachunek kr ON kr.IdKlient = k.IdKlient 
JOIN rachunek r ON r.IdRachunek = kr.IdRachunek
ORDER BY r.StanKonta DESC;

-- 2. Wypisanie wszystkich rachunków z ilością klientów obsługujących dany rachunek
SELECT r.NrRachunku "NUMER RACHUNKU", COUNT(*) "ILOŚĆ KLIENTÓW", to_char(round(r.StanKonta, 2), 'FM9999990.00') "STAN KONTA"
FROM klient k
LEFT JOIN klient_rachunek kr ON kr.IdKlient = k.IdKlient 
JOIN rachunek r ON r.IdRachunek = kr.IdRachunek
GROUP BY r.NrRachunku, r.StanKonta;

-- 3. Sprawdzenie ile dany klient posiada funduszy na rachunkach
SELECT Klient.Imie, Klient.Nazwisko, SUM(Rachunek.StanKonta) "STAN KONTA"
FROM Rachunek, Klient, Klient_Rachunek
WHERE Klient.IdKlient = Klient_Rachunek.IdKlient AND
    Rachunek.IdRachunek = Klient_Rachunek.IdRachunek
GROUP BY Klient.Imie, Klient.Nazwisko
ORDER BY SUM(Rachunek.StanKonta) DESC

-- 4. Sprawdzenie ile funduszy ulokowane jest na rachunkach (podział na typy rachunków), a ile na lokatach (podział na typy lokat)
SELECT 'Lokata_' || kl.IdLokata "PRODUKT", SUM(kl.Kwota) "FUNDUSZE"
FROM Klient_Lokata kl
GROUP BY kl.IdLokata
UNION
SELECT rd.Value "Produkt", SUM(r.StanKonta) "Fundusze"
FROM Rachunek r
JOIN RachunekDict rd ON rd.Key = r.RachunekDictKey
GROUP BY rd.Value;

-- 5. Znajdź klienta z największą ilością funduszy
SELECT k.Imie, k.Nazwisko
FROM Klient k
WHERE (
(
    SELECT SUM(NVL(r.StanKonta, 0)) "FUNDUSZE"
    FROM Klient k2
    FULL JOIN Klient_Rachunek kr ON kr.IdKlient = k2.IdKlient 
    FULL JOIN Rachunek r ON r.IdRachunek = kr.IdRachunek
    WHERE k2.Imie = k.Imie
        AND k2.Nazwisko = k.Nazwisko)
    +
    (SELECT SUM(NVL(kl.Kwota, 0)) "FUNDUSZE"
    FROM Klient k3
    FULL JOIN Klient_Lokata kl ON kl.IdKlient = k3.IdKlient
    WHERE k3.Imie = k.Imie
        AND k3.Nazwisko = k.Nazwisko
)
) = (
    SELECT MAX((
        SELECT SUM(NVL(r.StanKonta, 0)) "FUNDUSZE"
        FROM Klient k2
        FULL JOIN Klient_Rachunek kr ON kr.IdKlient = k2.IdKlient 
        FULL JOIN Rachunek r ON r.IdRachunek = kr.IdRachunek
        WHERE k2.Imie = k.Imie
            AND k2.Nazwisko = k.Nazwisko)
        +
        (SELECT SUM(NVL(kl.Kwota, 0)) "FUNDUSZE"
        FROM Klient k3
        FULL JOIN Klient_Lokata kl ON kl.IdKlient = k3.IdKlient
        WHERE k3.Imie = k.Imie
            AND k3.Nazwisko = k.Nazwisko
    )) "FUNDUSZE"
    FROM Klient k
);

-- 6. Sprawdź ilu klientów pochodzi z danego miasta (po adresie zameldowania)
SELECT a.Miasto, COUNT(*) "ILOSC KLIENTOW"
FROM Klient k
JOIN Adres a ON a.IdAdres = k.IdAdresZameldowania
GROUP BY a.Miasto
ORDER BY COUNT(*) DESC;

-- 7. Wybierz klientów, którzy podali różne adresy zamieszkania, zameldowania oraz korespondencyjny
SELECT k.Imie, k.Nazwisko
FROM Klient k
WHERE k.IdAdresZamieszkania != k.IdAdresZameldowania
    OR k.IdAdresZamieszkania != k.IdAdresKorespondencyjny;

-- 8. Sprawdź ile operacji jest wykonywanych na danym rachunku
SELECT r.NrRachunku, COUNT(*) "ILOSC OPERACJI"
FROM Rachunek r
JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
GROUP BY r.NrRachunku
ORDER BY COUNT(*) DESC;

-- 9. Sprawdź ile operacji jest wykonywanych na danym rachunku z podziałem na operacje przychodzące, wychodzące i między rachunkami
SELECT r.NrRachunku "NR RACHUNKU", (
    SELECT COUNT(*)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew wychodzący'
) "WYCHODZACE", (
    SELECT COUNT(*)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew przychodzący'
) "PRZYCHODZACE", (
    SELECT COUNT(*)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew między rachunkami'
        AND ro.IdOperacjaWychodzacaDane IS NOT NULL
) "MIEDZY RACHUNKAMI WYCHODZACE", (
    SELECT COUNT(*)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew między rachunkami'
        AND ro.IdOperacjaWychodzacaDane IS NULL
) "MIEDZY RACHUNKAMI PRZYCHODZACE"
FROM Rachunek r;

-- 10. Wylicz bilans danego konta
SELECT r.NrRachunku "NR RACHUNKU", (- (
    SELECT NVL(SUM(NVL(o.Kwota, 0)), 0)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew wychodzący'
) + (
    SELECT NVL(SUM(NVL(o.Kwota, 0)), 0)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew przychodzący'
) - (
    SELECT NVL(SUM(NVL(o.Kwota, 0)), 0)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew między rachunkami'
        AND ro.IdOperacjaWychodzacaDane IS NOT NULL
) + (
    SELECT NVL(SUM(NVL(o.Kwota, 0)), 0)
    FROM Rachunek r2
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN RodzajOperacjiDict rodz ON rodz.Key = ro.RodzajOperacjiDictKey
    JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
    WHERE r2.NrRachunku = r.NrRachunku
        AND rodz.Value = 'Przelew między rachunkami'
        AND ro.IdOperacjaWychodzacaDane IS NULL
)) "BILANS"
FROM Rachunek r;

-- 11. Przypisz operacje do danego klienta (z podaniem rodzaju i kwoty operacji)
SELECT k.Imie, k.Nazwisko, o.DataZaksiegowania "DATA ZAKSIEGOWANIA", rod.Value "RODZAJ OPERACJI", o.Kwota
FROM Klient k
JOIN Klient_Rachunek kr ON kr.IdKlient = k.IdKlient
JOIN Rachunek r ON r.IdRachunek = kr.IdRachunek
JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
JOIN RodzajOperacjiDict rod ON rod.Key = ro.RodzajOperacjiDictKey
ORDER BY k.Nazwisko, k.Imie, o.DataZaksiegowania;

-- 12. Sprawdź, który klient wydał najwięcej
SELECT k.Imie, k.Nazwisko, SUM(o.Kwota)
FROM Klient k
JOIN Klient_Rachunek kr ON kr.IdKlient = k.IdKlient
JOIN Rachunek r ON r.IdRachunek = kr.IdRachunek
JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
JOIN RodzajOperacjiDict rod ON rod.Key = ro.RodzajOperacjiDictKey
WHERE rod.Value = 'Przelew wychodzący'
GROUP BY k.Imie, k.Nazwisko, rod.Value
HAVING SUM(o.Kwota) = (
    SELECT MAX(SUM(o.Kwota))
    FROM Klient k
    JOIN Klient_Rachunek kr ON kr.IdKlient = k.IdKlient
    JOIN Rachunek r ON r.IdRachunek = kr.IdRachunek
    JOIN Rachunek_Operacja ro ON ro.IdRachunek = r.IdRachunek
    JOIN Operacja o ON o.IdOperacja = ro.IdOperacja
    JOIN RodzajOperacjiDict rod ON rod.Key = ro.RodzajOperacjiDictKey
    WHERE rod.Value = 'Przelew wychodzący'
    GROUP BY k.Imie, k.Nazwisko, rod.Value
);


-- End of file.

