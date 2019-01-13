-- SQL - Złączenia

-- 1.	Połącz dane z tabel EMP i DEPT przy pomocy warunku złączenia w WHERE.
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- 2.	Połącz dane z tabel EMP i DEPT przy pomocy INNER JOIN.
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

-- 3.	Wybierz nazwiska oraz nazwy departamentów  wszystkich pracowników w kolejności alfabetycznej.
SELECT e.ename, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno
ORDER BY e.ename, d.dname;

-- 4.	Wybierz nazwiska wszystkich pracowników wraz z numerami i nazwami departamentów w których są zatrudnieni.
SELECT e.ename, d.deptno, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

-- 5.	Dla pracowników o miesięcznej pensji  powyżej 1500 podaj ich nazwiska, miejsca usytuowania ich departamentów
--    oraz nazwy tych departamentów.
SELECT e.ename, e.sal, d.dname, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.sal > 1500 ;

-- 6.	Utwórz listę pracowników podając ich nazwisko, zawód, pensję i stopień zaszeregowania.
SELECT e.ename, e.job, e.sal, s.grade
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 7.	Wybierz informacje o pracownikach, których zarobki odpowiadają klasie zarobkowej 3.
SELECT e.ename, e.job, e.sal, s.grade
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 3;

-- 8.	Wybierz pracowników zatrudnionych w Dallas.
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.loc = 'DALLAS';

-- 9.	Wybierz nazwiska pracowników, nazwy działów i stopnie zaszeregowania.
SELECT e.ename, d.dname, s.grade
FROM emp e
JOIN dept d ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 10.	Wypisz dane wszystkich działów oraz ich pracowników tak, aby dane działu pojawiły się, nawet jeśli nie ma
--      w dziale żadnego pracownika.
SELECT *
FROM emp e
RIGHT JOIN dept d ON e.deptno = d.deptno;

-- 11.	Wypisz dane wszystkich działów oraz ich pracowników tak, aby dane pracownika pojawiły się, nawet jeśli
--      pracownik nie jest przypisany do działu.
SELECT *
FROM emp e
LEFT JOIN dept d ON e.deptno = d.deptno;

-- 12.	Wybierz pracowników (nazwisko, numer działu) z działu 30 i 20.Wypisz dział 20 bez nazwisk.
SELECT e.ename, d.deptno
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 30
UNION
SELECT null, d.deptno
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 20;

-- 13.	Wypisz stanowiska występujące w dziale 10 oraz 30.
SELECT DISTINCT e.job, d.deptno
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 30 OR d.deptno = 10;

-- 14.	Wypisz stanowiska występujące zarówno w dziale 10 jak i 30.
SELECT DISTINCT e.job
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 30
INTERSECT
SELECT DISTINCT e.job
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 10;

-- 15.	Wypisz stanowiska występujące w dziale 10 a nie występujące w dziale 30.
SELECT DISTINCT e.job
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 10
MINUS
SELECT DISTINCT e.job
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.deptno = 30;

-- 16.	Wybierz pracowników, którzy zarabiają mniej od swoich kierowników.
SELECT e.ename, e.sal
FROM emp e
JOIN emp m ON e.mgr = m.empno
WHERE e.sal < m.sal;

-- 17.	Dla każdego pracownika wypisz jego nazwisko oraz nazwisko jego szefa. Posortuj według nazwiska szefa.
SELECT e.ename employee, m.ename employer
FROM emp e
JOIN emp m ON e.mgr = m.empno
ORDER BY m.ename;
