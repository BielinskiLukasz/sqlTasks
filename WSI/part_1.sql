
/*
Some query's don't work with mySQL Workbench!
*/

-- Dla bazy danych zawierającej poniższe tabele:
--   EMP {empno(PK), ename, deptno(FK), mgr(FK), sal, comm, hiredate, job}
--   DEPT {deptno(PK), dname, loc}
--   SALGRADE {grade, losal, hisal}

-- 1. Wybierz numery departamentów, nazwiska pracowników oraz numery pracownicze ich szefów z tabeli EMP.
SELECT e.deptno, e.empno, e.mgr
FROM emp e;

-- 2. Wypisz wszystkie dane z wszystkich kolumn tabeli EMP.
SELECT *
FROM emp;

-- 3. Wylicz wartość rocznej pensji podstawowej (12 płac miesięcznych) dla każdego pracownika, bez uwzględniania
--    prowizji.
SELECT e.ename, e.sal*12
FROM emp e;

-- 4. Oblicz, ile będą wynosiły roczne dochody każdego pracownika, bez uwzględniania prowizji, jeśli założymy, że każdy
--    dostanie podwyżkę o 250 miesięcznie.
SELECT e.ename, (e.sal+250)*12
FROM emp e;

-- 5. Wyrażenie sal * 12 z poprzedniego zadania zaetykietuj nagłówkiem Roczna.
SELECT e.ename, e.sal*12 AS year
FROM emp e;

-- 6. Wyrażenie sal * 12 zaetykietuj nagłówkiem Placa Roczna.
SELECT e.ename, e.sal*12 AS 'year salary'
FROM emp e;

-- 7. Wypisz w jednej kolumnie wynikowej połączony numer pracownika i jego nazwisko. Kolumnę wynikową zaetykietuj
--    nagłówkiem Zatrudniony.
SELECT e.empno||' '||e.ename AS employee
FROM emp e;

-- 8. Literał: Utwórz zapytanie zwracające w jednej kolumnie połączony tekst Pracownik numer i nazwisko pracownika,
--    tekst pracuje w dziale nr i numer działu. Kolumnę wynikową nazwij Informacje o pracownikach.
SELECT e.empno||' '||e.ename||' pracuje w dziale '||e.deptno
FROM emp e;

-- 9. Oblicz roczne dochody każdego pracownika, z uwzględnieniem prowizji comm.
SELECT e.ename, e.sal*12+NVL(e.comm,0) AS 'year salary'
FROM emp e;

-- 10. Wypisz wszystkie numery departamentów występujące w tabeli EMP.
SELECT e.deptno
FROM emp e;

-- 11. Wypisz wszystkie wzajemnie różne, (czyli bez powtórzeń) numery departamentów występujące w tabeli EMP.
SELECT DISTINCT e.deptno
FROM emp e;

-- 12. Wybierz wszystkie wzajemnie różne kombinacje wartości Deptno i Job.
SELECT DISTINCT e.deptno, e.job
FROM emp e;

-- 13. Posortuj rosnąco wszystkie dane tabeli EMP według wartości w kolumnie Ename.
SELECT *
FROM emp e
ORDER BY e.ename;

-- 14. Posortuj malejąco wszystkie dane tabeli EMP według daty zatrudnienia (kolumna Hiredate) począwszy od ostatnio
--     zatrudnionych.
SELECT *
FROM emp e
ORDER BY e.hiredate DESC;

-- 15. Posortuj dane z tabeli EMP według wzrastającej wartości kolumny Deptno, oraz malejących wartości kolumny Sal.
SELECT *
FROM emp e
ORDER BY e.deptno, e.sal DESC;
