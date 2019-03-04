-- Wypisz wszystkich klientów hotelu w kolejności alfabetycznej (sortując po nazwisku i imieniu).
SELECT *
FROM Gosc g
ORDER BY g.nazwisko, g.imie;

-- Podaj bez powtórzeń wszystkie występujące w tabeli wartości rabatu posortowane malejąco.
SELECT DISTINCT g.Rabat
FROM Gosc g
ORDER BY g.Rabat DESC;

-- Wypisz wszystkie rezerwacje Ferdynanda Kiepskiego.
SELECT r.IdRezerwacjaZamowiona
FROM RezerwacjaZamowiona r JOIN Gosc g ON g.IdGosc = r.Gosc_IdGosc
WHERE g.Imie = 'Ferdynand' AND g.Nazwisko = 'Kiepski'
UNION
SELECT r2.IdRezerwacjaPrzydzielona
FROM RezerwacjaPrzydzielona r2 JOIN Gosc g ON g.IdGosc = r2.Gosc_IdGosc
WHERE g.Imie = 'Ferdynand' AND g.Nazwisko = 'Kiepski';

-- Wypisz gości wraz z liczbą dokonanych przez nich rezerwacji. Nie wypisuj informacji o gościach, którzy złożyli tylko jedną rezerwację.
SELECT g.Imie, g.Nazwisko, COUNT(*)
FROM RezerwacjaZamowiona r JOIN Gosc g ON g.IdGosc = r.Gosc_IdGosc
	JOIN RezerwacjaPrzydzielona r2 ON g.IdGosc = r2.Gosc_IdGosc
GROUP BY g.Imie, g.Nazwisko
HAVING count(*) > 1

-- Wypisz pokoje o największej liczbie miejsc.
SELECT p.IdPokoj
FROM Pokoj p
WHERE p.IloscMiejsc = (
	SELECT MAX(p2.IloscMiejsc)
	FROM Pokoj p2
);

-- Znajdź kategorię, w której liczba pokoi jest największa.
SELECT k.Value
FROM KategoriaDict k JOIN Pokoj p ON k.Key = p.KategoriaDict_Key
GROUP BY k.Value
HAVING COUNT(*) = (
	SELECT MAX(COUNT(*))
	FROM KategoriaDict k2 JOIN Pokoj p ON k2.Key = p.KategoriaDict_Key
	GROUP BY k2.key
);