
/*
Some query's don't work with mySQL Workbench!
*/

-- Dla bazy danych zawierającej poniższe tabele:
--   EMP {empno(PK), ename, deptno(FK), mgr(FK), sal, comm, hiredate, job}
--   DEPT {deptno(PK), dname, loc}
--   SALGRADE {grade, losal, hisal}

-- 1. Wypisz nazwiska, numery pracowników, stanowiska pracy, płacę i numery departamentów wszystkich zatrudnionych
--    na stanowisku CLERK.
SELECT e.ename, e.empno, e.job, e.sal, e.deptno
FROM emp e
WHERE e.job = 'CLERK';

-- 2. Wybierz wszystkie nazwy i numery departamentów większe od 20.
SELECT d.dname, d.deptno
FROM dept d
WHERE d.deptno > 20;

-- 3. Wypisz numery i nazwiska pracowników, których prowizja przekracza miesięczną pensję.
SELECT e.empno, e.ename
FROM emp e
WHERE e.comm > e.sal;

-- 4. Wybierz wszystkie dane tych pracowników, których płaca mieści się w przedziale <1000, 2000>.
SELECT *
FROM emp e
WHERE e.sal BETWEEN 1000 AND 2000;

-- 5. Wybierz wszystkie dane tych pracowników, których bezpośrednimi szefami są pracownicy o numerach 7902, 7566
--    lub 7788.
SELECT *
FROM emp e
WHERE e.mgr IN (7902, 7566, 7788);

-- 6. Wybierz wszystkie dane tych pracowników, których nazwiska zaczynają się na literę S.
SELECT *
FROM emp e
WHERE e.ename LIKE 'S%';

-- 7. Wybierz wszystkie dane pracowników, których nazwiska są czteroliterowe, używając i nie używając funkcji
--    zwracającej długości napisu LENGHT (Oracle) i LEN (Ms SQL Server).
SELECT *
FROM emp e
WHERE e.ename LIKE '____';

-- 8. Wypisz numer, nazwisko i stanowisko tych pracowników, którzy nie posiadają szefa.
SELECT e.empno, e.ename, e.job
FROM emp e
WHERE e.mgr IS NULL;

-- 9. Wypisz numer, nazwisko i płacę tych pracowników, których zarobki są poza przedziałem <1000, 2000>.
SELECT e.empno, e.ename, e.sal
FROM emp e
WHERE e.sal NOT BETWEEN 1000 AND 2000;

-- 10. Wypisz numer, nazwisko i numer działu tych pracowników, których nazwiska nie zaczynają się na literę M.
SELECT e.empno, e.ename, e.deptno
FROM emp e
WHERE e.ename NOT LIKE 'M%';

-- 11. Wybierz nazwiska tych pracowników, którzy mają szefa.
SELECT e.ename
FROM emp e
WHERE e.mgr IS NOT NULL;

-- 12. Wypisz nazwisko, numer działu, płacę i stanowisko pracowników zatrudnionych na stanowisku CLERK, których zarobki
--     mieszczą się w przedziale <1000, 2000>.
SELECT e.empno, e.ename, e.deptno
FROM emp e
WHERE e.job = 'CLERK' AND e.sal BETWEEN 1000 AND 2000;

-- 13. Wypisz nazwisko, numer działu, płacę i stanowisko tych pracowników, którzy albo są zatrudnieni na stanowisku
--     CLERK, albo ich zarobki mieszczą się w przedziale <1000, 2000>.
SELECT e.empno, e.ename, e.deptno
FROM emp e
WHERE e.job = 'CLERK' OR e.sal BETWEEN 1000 AND 2000;

-- 14. Wypisz nazwisko, płacę i stanowisko wszystkich pracowników zatrudnionych na stanowisku MANAGER z pensją powyżej
--     (Sal) równą 1500 oraz wszystkich zatrudnionych na stanowisku SALESMAN.
SELECT e.ename, e.sal, e.job
FROM emp e
WHERE e.job = 'MANAGER' AND e.sal >= 1500 OR e.job = 'SALESMAN';

-- 15. Wypisz nazwisko, płacę i stanowisko wszystkich pracowników zatrudnionych na stanowisku MANAGER lub na stanowisku
--     SALESMAN, których pensje (Sal) są wyższe od 1500.
SELECT e.ename, e.sal, e.job
FROM emp e
WHERE e.job = 'MANAGER' OR e.job = 'SALESMAN' AND e.sal >= 1500;

-- 16. Wypisz nazwisko, stanowisko i numer departamentu wszystkich pracowników zatrudnionych na stanowisku MANAGER ze
--     wszystkich departamentów wraz ze wszystkimi pracownikami zatrudnionymi na stanowisku CLERK w departamencie 10.
SELECT e.ename, e.job, e.deptno
FROM emp e
WHERE e.job = 'MANAGER' OR (e.job = 'CLERK' AND e.deptno = 10);

-- 17. Wypisz wszystkie dane z tabeli SALGRADE.
SELECT *
FROM salgrade;

-- 18. Wypisz wszystkie dane z tabeli DEPT.
SELECT *
FROM dept;

-- 19. Wypisz wszystkie dane tych pracowników, których roczne dochody (z uwzględnieniem prowizji) są mniejsze od 12000
--     lub większe od 24000/
SELECT *
FROM emp e
WHERE e.sal+NVL(e.comm,0) NOT BETWEEN 12000 AND 24000;

-- 20. Wypisz numery pracownicze, stanowiska i numery departamentów wszystkich pracowników. Wynik posortuj rosnąco
--     według numerów departamentów i stanowisk.
SELECT e.empno, e.job, e.deptno
FROM emp e
ORDER BY e.empno, e.job;

-- 21. Wypisz wszystkie wzajemnie różne, (czyli bez powtórzeń) nazwy stanowisk pracy.
SELECT DISTINCT e.job
FROM emp e;

-- 22. Wypisz wszystkie dane pracowników zatrudnionych w departamentach 10 i 20 w kolejności alfabetycznej ich nazwisk.
SELECT *
FROM emp e
WHERE e.deptno IN (10, 20)
ORDER BY e.ename;

-- 23. Wypisz wszystkie nazwiska i stanowiska pracy wszystkich pracowników z departamentu 20 zatrudnionych
--     na stanowisku CLERK.
SELECT e.ename, e.job
FROM emp e
WHERE e.deptno = 20 AND e.job = 'CLERK';

-- 24. Wybierz nazwiska tych pracowników, w których nazwisku występuje ciąg liter „TH” lub „LL”.
SELECT e.ename
FROM emp e
WHERE e.ename LIKE '%TH%' OR e.ename LIKE '%LL%';

-- 25. Wypisz nazwisko, stanowisko i pensję pracowników, którzy posiadają szefa.
SELECT e.ename, e.job, e.sal
FROM emp e
WHERE e.mgr IS NOT NULL;

-- 26. Wypisz nazwiska i całoroczne dochody (z uwzględnieniem jednorazowej rocznej prowizji COMM) wszystkich
--     pracowników.
SELECT e.ename, e.sal*12+e.comm AS 'year sallary'
FROM emp e
WHERE e.comm IS NOT NULL
UNION
SELECT e.ename, e.sal*12 AS 'year sallary'
FROM emp e
WHERE e.comm IS NULL;

-- 27. Wypisz nazwisko, numer departamentu i datę zatrudnienia tych pracowników, którzy zostali zatrudnieni w 1982 r.
SELECT e.ename, e.deptno, e.hiredate
FROM emp e
WHERE e.hiredate BETWEEN '1982-01-01' AND '1982-12-31';

-- 28. Wypisz nazwiska, roczną pensję oraz prowizję tych wszystkich SALESMAN’ów, których miesięczna pensja przekracza
--     prowizję. Wyniki posortuj według malejących zarobków, potem nazwisk (rosnąco).
SELECT e.ename, e.sal, e.comm
FROM emp e
WHERE e.job = 'SALESMAN' AND e.sal > e.comm
ORDER BY e.sal DESC, e.ename;
