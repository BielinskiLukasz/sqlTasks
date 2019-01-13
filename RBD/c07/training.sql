--1
SELECT *
FROM Student s
WHERE s.imie LIKE 'A%' OR s.imie LIKE '%Z';

--2
SELECT DISTINCT Ocena
FROM Ocena o
JOIN Student s ON s.nr_indeksu = o.nr_indeksu
WHERE s.rok = 2
ORDER BY o.ocena;

--3
SELECT AVG(o.ocena)
FROM ocena o
JOIN przedmiot p ON p.skrot = o.skrot
WHERE o.skrot = 'RBD' OR
    p.nazwa = 'Tomaszew v2'
GROUP BY o.skrot;

--4
SELECT MAX(o.ocena), p.nazwa
FROM Ocena o
JOIN Przedmiot p ON p.skrot = o.skrot
WHERE o.skrot != 'RBD'
GROUP BY p.nazwa
HAVING AVG(o.ocena) >= 3.0;

--5
SELECT s.imie, s.nazwisko
FROM Student s
WHERE s.nr_indeksu = 1 + (SELECT s.nr_indeksu
    FROM Student s
    WHERE s.imie = 'SMITH' AND s.nazwisko = 'CLERK');

--6
SELECT s.nr_indeksu, s.imie, s.nazwisko
FROM Student s
WHERE (
    SELECT AVG(o.ocena)
    FROM Ocena o
    WHERE o.nr_indeksu = s.nr_indeksu
) = (
    SELECT MAX(AVG(o.ocena))
    FROM Student s
    JOIN Ocena o ON s.nr_indeksu = o.nr_indeksu
    GROUP BY s.nr_indeksu
);

--7
INSERT INTO Student (
SELECT nr_indeksu, imie, nazwisko, 1
  FROM Osoba
  WHERE data_urodzenia >= TO_DATE('2000-01-01'));

--8
DELETE
FROM Ocena o
WHERE o.nr_indeksu IN (
    DELETE
    FROM Student s
    WHERE (
        SELECT AVG(o.ocena)
        FROM Ocena o
        WHERE o.nr_indeksu = s.nr_indeksu
    ) = 2
);

DELETE
FROM Student s
WHERE (
    SELECT AVG(o.ocena)
    FROM Ocena o
    WHERE o.nr_indeksu = s.nr_indeksu
) = 2;

--9
SELECT DISTINCT p.nazwa
FROM Przedmiot p
JOIN Ocena o ON o.skrot = p.skrot
JOIN Student s ON s.nr_indeksu = o.nr_indeksu;

--10
SELECT p.nazwa
FROM Przedmiot p
JOIN Ocena o ON o.skrot = p.skrot
WHERE EXTRACT(year FROM o.data) = 2012
MINUS
SELECT p.nazwa
FROM Przedmiot p
JOIN Ocena o ON o.skrot = p.skrot
WHERE EXTRACT(year FROM o.data) = 2013;
