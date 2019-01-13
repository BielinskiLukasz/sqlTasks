-- SQL - funkcje grupujące

-- 1.	Oblicz średni zarobek w firmie.
SELECT AVG(e.sal)
FROM emp e;

-- 2.	Znajdź minimalne zarobki na stanowisku CLERK.
SELECT MIN(e.sal)
FROM emp e
WHERE e.job = 'CLERK';

-- 3.	Znajdź ilu pracowników zatrudniono w departamencie 20.
SELECT COUNT(*)
FROM emp e
WHERE e.deptno = 20;

-- 4.	Oblicz średnie zarobki na każdym ze stanowisk pracy.
SELECT e.job, AVG(e.sal)
FROM emp e
GROUP BY e.job;

-- 5.	Oblicz średnie zarobki na każdym ze stanowisk pracy z wyjątkiem stanowiska MANAGER.
SELECT e.job, AVG(e.sal)
FROM emp e
WHERE e.job != 'MANAGER'
GROUP BY e.job;

-- 6.	Oblicz średnie zarobki na każdym ze stanowisk pracy w każdym departamencie.
SELECT e.job, e.deptno, AVG(e.sal)
FROM emp e
WHERE e.job != 'MANAGER'
GROUP BY e.job, e.deptno;

-- 7.	Dla każdego stanowiska oblicz maksymalne zarobki.
SELECT e.job, MAX(e.sal)
FROM emp e
GROUP BY e.job;

-- 8.	Wybierz średnie zarobki tylko tych departamentów, które zatrudniają więcej niż trzech pracowników.
SELECT e.deptno, AVG(e.sal)
FROM emp e
GROUP BY e.deptno
HAVING COUNT(*) > 3;

-- 9.	Wybierz tylko te stanowiska, na których średni zarobek wynosi 3000 lub więcej.
SELECT e.job, AVG(e.sal)
FROM emp e
GROUP BY e.job
HAVING AVG(e.sal) > 3000;

-- 10.	Znajdź średnie miesięczne pensje oraz średnie roczne zarobki dla każdego stanowiska, pamiętaj o prowizji.
SELECT e.job, AVG(e.sal), AVG(12 * e.sal + NVL(e.comm, 0))
FROM emp e
GROUP BY e.job;

-- 11.	Znajdź różnicę miedzy najwyższą i najniższa pensją.
SELECT MAX(e.sal) - MIN(e.sal)
FROM emp e;

-- 12.	Znajdź departamenty zatrudniające powyżej trzech pracowników.
SELECT e.deptno
FROM emp e
GROUP BY e.deptno
HAVING COUNT(*) > 3;

-- 13.	Sprawdź, czy wszystkie numery pracowników są rzeczywiście wzajemnie różne.
SELECT e.empno
FROM emp e
GROUP BY e.empno
HAVING COUNT(*) > 1;

-- 14.	Podaj najniższe pensje  wypłacane podwładnym swoich kierowników. Wyeliminuj grupy o minimalnych zarobkach
--      niższych niż 1000. Uporządkuj według pensji.
SELECT e.mgr, MIN(e.sal)
FROM emp e
WHERE e.mgr IS NOT NULL
GROUP BY e.mgr
HAVING MIN(e.sal) >= 1000
ORDER BY MIN(e.sal);

-- 15.	Wypisz ilu pracowników ma dział mający siedzibę w DALLAS.
SELECT COUNT(*)
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE d.loc = 'DALLAS';

-- 16.	Podaj maksymalne zarobki dla każdej klasy zarobkowej.
SELECT s.grade, MAX(e.sal)
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade;

-- 17.	Sprawdź, które wartości zarobków powtarzają się.
SELECT e.sal
FROM emp e
GROUP BY e.sal
HAVING COUNT(*) > 1;

-- 18.	Podaj średni zarobek pracowników z drugiej klasy zarobkowej.
SELECT s.grade, AVG(e.sal)
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 2
GROUP BY s.grade;

-- 19.	Sprawdź ilu podwładnych ma każdy kierownik.
SELECT e.mgr, COUNT(*)
FROM emp e
WHERE e.mgr IS NOT NULL
GROUP BY e.mgr;

-- 20.	Podaj sumę, którą zarabiają razem wszyscy pracownicy z pierwszej klasy zarobkowej.
SELECT s.grade, SUM(e.sal)
FROM emp e
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 1
GROUP BY s.grade;