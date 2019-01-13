-- SQL – proste zapytania

-- 1.	Wybierz numery departamentów, nazwiska pracowników oraz numery pracownicze ich szefów z tabeli EMP.
SELECT e.deptno, e.ename, e.empno, e.mgr
FROM emp e;

-- 2.	Wybierz wszystkie kolumny z tabeli EMP.
SELECT *
FROM emp;

-- 3.	Wylicz roczną pensję podstawową dla każdego pracownika.
SELECT e.ename, e.sal
FROM emp e;

-- 4.	Wylicz roczną pensję podstawową dla każdego pracownika gdyby każdemu dać podwyżkę o 250.
SELECT e.ename, e.sal + 250 AS salary
FROM emp e;

-- 5.	Wybrane wyrażenie SAL*12 zaetykietuj nagłówkiem ROCZNA.
SELECT e.ename, e.sal * 12 AS year
FROM emp e;

-- 6.	Wybrane wyrażenie SAL*12 zaetykietuj nagłówkiem R PENSJA.
SELECT e.ename, e.sal * 12 AS "year salary"
FROM emp e;

-- 7.	Połącz EMPNO i nazwisko, opatrz je nagłówkiem EMPLOYEE.
SELECT e.empno || ' ' || e.ename AS "employee"
FROM emp e;

-- 8.	Utwórz zapytanie zwracające wynik w postaci np. „Kowalski pracuje w dziale 20”.
SELECT e.ename || ' pracuje w dziale ' || e.deptno AS "info"
FROM emp e;

-- 9.	Wylicz roczną pensję całkowitą dla każdego pracownika (z uwzględnieniem prowizji).
SELECT e.ename, e.sal * 12 + NVL(e.comm, 0) AS "year salary"
FROM emp e;

-- 10.	Wyświetl wszystkie numery departamentów występujące w tabeli EMP.
SELECT e.deptno
FROM emp e;

-- 11.	Wyświetl wszystkie różne numery departamentów występujące w tabeli EMP.
SELECT DISTINCT e.deptno
FROM emp e;

-- 12.	Wybierz wszystkie wzajemnie różne kombinacje wartości DEPTNO i JOB.
SELECT DISTINCT e.job, e.deptno
FROM emp e;

-- 13.	Posortuj wszystkie dane tabeli EMP według ENAME.
SELECT *
FROM emp e
ORDER BY e.ename;

-- 14.	Posortuj malejąco wszystkie dane tabeli EMP według daty ich zatrudnienia począwszy od ostatnio zatrudnionych.
SELECT *
FROM emp e
ORDER BY e.hiredate DESC;

-- 15.	Posortuj dane tabeli EMP według wzrastających wartości kolumn DEPTNO oraz malejących wartości kolumny SAL
--      (bez wypisywania kolumny SAL).
SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.comm, e.deptno
FROM emp e
ORDER BY e.deptno, e.sal DESC;

-- 16.	Wybierz nazwiska, numery, stanowiska pracy i numery departamentów wszystkich pracowników zatrudnionych
--      na stanowisku CLERK.
SELECT e.ename, e.empno, e.job, e.deptno
FROM emp e
WHERE e.job = 'CLERK'

-- 17.	Wybierz  wszystkie nazwy i numery departamentów większe od nr 20.
SELECT d.dname, d.deptno
FROM dept d
WHERE d.deptno > 20

-- 18.	Wybierz pracowników, których prowizja przekracza miesięczną pensję.
SELECT e.empno, e.ename
FROM emp e
WHERE e.comm > e.sal

-- 19.	Wybierz dane tych pracowników, których zarobki mieszczą się pomiędzy 1000 a 2000.
SELECT e.empno, e.ename, e.sal
FROM emp e
WHERE e.sal BETWEEN 1000 AND 2000

-- 20.	Wybierz dane pracowników, których bezpośrednimi szefami  są 7902,7566 lub 7788.
SELECT e.empno, e.ename, e.sal, e.mgr
FROM emp e
WHERE e.mgr IN (7902, 7566, 7788);

-- 21.	Wybierz dane tych pracowników, których nazwiska zaczynają się na S.
SELECT e.empno, e.ename, e.sal, e.mgr
FROM emp e
WHERE e.ename LIKE 'S%'

-- 22.	Wybierz dane tych pracowników, których nazwiska są czteroliterowe.
SELECT e.empno, e.ename, e.sal, e.mgr
FROM emp e
WHERE e.ename LIKE '____'

-- 23.	Wybierz dane tych pracowników, którzy nie posiadają szefa.
SELECT e.empno, e.ename, e.sal, e.mgr
FROM emp e
WHERE e.mgr IS NULL

-- 24.	Wybierz dane tych pracowników, których zarobki są poza przedziałem <1000,2000>.
SELECT e.empno, e.ename, e.sal
FROM emp e
WHERE e.sal NOT BETWEEN 1000 AND 2000

-- 25.	Wybierz dane tych pracowników, których nazwiska nie zaczynają się na M.
SELECT e.empno, e.ename, e.sal, e.mgr
FROM emp e
WHERE e.ename NOT LIKE 'M%'

-- 26.	Wybierz dane tych pracowników, którzy mają szefa.
SELECT e.empno, e.ename, e.sal, e.mgr
FROM emp e
WHERE e.mgr IS NOT NULL

-- 27.	Wybierz dane tych pracowników zatrudnionych na stanowisku CLERK których zarobki SAL mieszczą się
--      w przedziale <1000.2000).
SELECT e.empno, e.ename, e.sal, e.job
FROM emp e
WHERE e.sal >= 1000 AND
  e.sal < 2000 AND
  e.job = 'CLERK'

-- 28.	Wybierz dane pracowników zatrudnionych na stanowisku CLERK albo takich, których zarobki SAL mieszczą się
--      w przedziale <1000.2000).
SELECT e.empno, e.ename, e.sal, e.job
FROM emp e
WHERE e.sal BETWEEN 1000 AND 2000
   OR e.job = 'CLERK'

-- 29.	Wybierz wszystkich pracowników zatrudnionych na stanowisku MANAGER z pensją powyżej 1500 oraz wszystkich
--      pracowników na stanowisku  SALESMAN, niezależnie od pensji.
SELECT e.empno, e.ename, e.sal, e.job
FROM emp e
WHERE (e.sal > 1500 AND e.job = 'MANAGER')
   OR (e.job = 'SALESMAN')

-- 30.	Wybierz wszystkich pracowników zatrudnionych na stanowisku MANAGER lub na stanowisku SALESMAN
--      lecz zarabiających powyżej 1500.
SELECT e.empno, e.ename, e.sal, e.job
FROM emp e
WHERE (e.sal > 1500 AND e.job = 'SALESMAN')
   OR (e.job = 'MANAGER')

-- 31.	Wybierz wszystkich pracowników zatrudnionych na stanowisku MANAGER ze wszystkich departamentów
--      wraz ze wszystkimi pracownikami zatrudnionymi na stanowisku CLERK w departamencie 10.
SELECT e.empno, e.ename, e.sal, e.job, e.deptno
FROM emp e
WHERE (e.deptno = 10 AND e.job = 'CLERK')
   OR (e.job = 'MANAGER')

-- 32.	Wybierz wszystkie dane z tabeli SALGRADE.
SELECT *
FROM salgrade;

-- 33.	Wybierz wszystkie dane z tabeli DEPT.
SELECT *
FROM dept;

-- 34.	Wybierz numery i nazwy departamentów sortując według numerów departamentów.
SELECT d.deptno, d.dname
FROM dept d
ORDER BY d.deptno;

-- 35.	Wybierz wszystkie wzajemnie różne stanowiska pracy.
SELECT DISTINCT e.job
FROM emp e;

-- 36.	Wybierz dane pracowników zatrudnionych w departamentach 10 i 20 we kolejności alfabetycznej ich nazwisk.
SELECT *
FROM emp e
WHERE e.deptno IN (10, 20)
ORDER BY e.ename;

-- 37.	Wybierz nazwiska pracowników, w których nazwisku występuje ciąg „TH” lub „LL”.
SELECT e.ename
FROM emp e
WHERE e.ename LIKE '%TH%'
   OR e.ename LIKE '%LL%';

-- 38.	Wybierz ENAME, DEPTNO i HIREDATE  tych pracowników, którzy zostali zatrudnieni w 1980 r.
SELECT e.ename, e.deptno, e.hiredate
FROM emp e
WHERE e.hiredate BETWEEN '1980-01-01' AND '1980-12-31';

-- 39.	Wybierz nazwiska, roczną pensję oraz prowizję tych wszystkich sprzedawców, których miesięczna pensja
--      przekracza prowizję. Wyniki posortuj według malejących zarobków, potem nazwisk.
SELECT e.ename, e.sal * 12 as "year salary", e.comm
FROM emp e
WHERE e.sal > e.comm
ORDER BY e.sal DESC, e.ename;
