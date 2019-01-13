-- SQL – podzapytania

-- 1.	Znajdź pracowników z pensją równą minimalnemu zarobkowi w firmie.
SELECT *
FROM emp e
WHERE e.sal = (SELECT MIN(e.sal)
    FROM emp e);

-- 2.	Znajdź wszystkich pracowników zatrudnionych na tym samym stanowisku co BLAKE.
SELECT *
FROM emp e
WHERE e.job = (SELECT e.job
    FROM emp e
    WHERE e.ename = 'BLAKE');

-- 3.	Znajdź pracowników o pensjach z listy najniższych zarobków osiągalnych w departamentach.
SELECT *
FROM emp e
WHERE e.sal IN (SELECT MIN(e.sal)
    FROM emp e
    GROUP BY e.deptno);

-- 4.	Znajdź pracowników o najniższych zarobkach w ich departamentach.
SELECT *
FROM emp e
WHERE (e.deptno, e.sal) IN (SELECT e.deptno, MIN(e.sal)
    FROM emp e
    GROUP BY e.deptno);

-- 5.	Stosując operator ANY wybierz pracowników zarabiających powyżej najniższego zarobku z departamentu 30.
SELECT *
FROM emp e
WHERE e.sal > ANY (SELECT MIN(e.sal)
    FROM emp e
    WHERE e.deptno = 30);

-- 6.	Znajdź pracowników, których zarobki są wyższe od pensji każdego pracownika z departamentu 30.
SELECT *
FROM emp e
WHERE e.sal > ALL (SELECT e.sal
    FROM emp e
    WHERE e.deptno = 30);

-- 7.	Wybierz departamenty, których średnie zarobki przekraczają średni zarobek departamentu 30.
SELECT e.deptno
FROM emp e
GROUP BY e.deptno
HAVING AVG(e.sal) > (SELECT AVG(e.sal)
    FROM emp e
    WHERE e.deptno = 30);

-- 8.	Znajdź stanowisko, na którym są najwyższe średnie zarobki.
SELECT e.job
FROM emp e
GROUP BY e.job
HAVING AVG(e.sal) = (SELECT MAX(AVG(e.sal))
    FROM emp e
    GROUP BY e.job);

-- 9.	Znajdź pracowników, których zarobki przekraczają najwyższe pensje z departamentu SALES.
SELECT *
FROM emp e
WHERE e.sal > (SELECT MAX(e.sal)
    FROM emp e
    JOIN dept d ON e.deptno = d.deptno
    WHERE d.dname = 'SALES');

-- 10.	Znajdź pracowników, którzy zarabiają powyżej średniej w ich departamentach.
SELECT *
FROM emp e1
WHERE e1.sal > (SELECT AVG(e2.sal)
    FROM emp e2
    WHERE e2.deptno = e1.deptno);

-- 11.	Znajdź pracowników, którzy posiadają podwładnych za pomocą operatora EXISTS.
SELECT *
FROM emp e1
WHERE EXISTS (SELECT *
    FROM emp e2
    WHERE e2.mgr = e1.empno);

-- 12.	Znajdź pracowników, których departament nie występuje w tabeli DEPT.
SELECT *
FROM emp e
WHERE e.deptno NOT IN (SELECT d.deptno
    FROM dept d);

-- 13.	Wskaż dla każdego departamentu ostatnio zatrudnionych pracowników. Uporządkuj według dat zatrudnienia.
SELECT *
FROM emp e1
WHERE e1.hiredate = (SELECT MAX(e2.hiredate)
    FROM emp e2
    WHERE e2.deptno = e1.deptno)
ORDER BY e1.hiredate DESC;

-- 14.	Podaj ename, sal i deptno dla pracowników, których zarobki przekraczają średnią ich departamentów.
SELECT e1.ename, e1.sal, e1.deptno
FROM emp e1
WHERE e1.sal > (SELECT AVG(e2.sal)
    FROM emp e2
    WHERE e2.deptno = e1.deptno);

-- 15.	Stosując podzapytanie znajdź departamenty, w których nikt nie pracuje.
SELECT d.deptno
FROM dept d
WHERE NOT EXISTS (SELECT *
FROM emp e
WHERE e.deptno = d.deptno);

-- 16.	Napisz zapytanie zwracające procentowy udział liczby pracowników w każdym dziale.
SELECT 100 * COUNT(*) / (SELECT COUNT(*)
    FROM emp e)
FROM emp e
GROUP BY e.deptno;