-- 1. Napisz prosty program w Transact-SQL. Zadeklaruj zmienną i przypisz jej wartość będącą liczbą rekordów w tabeli
-- EMP (lub jakiejkolwiek innej). Wypisz uzyskany wynik używając instrukcji PRINT, w postaci napisu
-- np. "W tabeli jest 10 osób".

DECLARE
  @empCounter INT
SELECT @empCounter = COUNT(*)
FROM EMP
PRINT 'W tabeli jest ' + CONVERT(VARCHAR, @empCounter) + ' osób'

-- 2. Używając Transact-SQL, policz liczbę pracowników z tabeli EMP. Jeśli liczba jest mniejsza niż 16, wstaw
-- pracownika Kowalskiego i wypisz komunikat. W przeciwnym przypadku wypisz komunikat informujący o tym,
-- że nie wstawiono danych.

DECLARE
  @empCounter INT
SELECT @empCounter = COUNT(*)
FROM EMP
IF (@@ROWCOUNT < 16)
  BEGIN
    INSERT INTO EMP
    VALUES (9999, 'KOWALSKI', 'SALESMAN', 7698,
            CONVERT(DATETIME, '22-FEB-1981'), 1250, 500, 30);
    PRINT 'Dodano Kowalskiego';
  END
ELSE
  PRINT 'Nie wstawiono danych';

-- 3. Napisz procedurę zwracającą pracowników, którzy zarabiają więcej niż wartość wskazana poprzez parametr procedury.

CREATE PROCEDURE select_rich @min_salary int
AS
BEGIN
  SELECT * FROM EMP WHERE SAL > @min_salary
END


EXEC select_rich 2000;

-- 4. Napisz procedurę służącą do wstawiania działów do tabeli DEPT. Procedura na pobierać jako parametry: nr_działu,
-- nazwę i lokalizację. Należy sprawdzić, czy dział o takiej nazwie lub lokalizacji już istnieje. Jeżeli istnieje,
-- to nie wstawiamy nowego rekordu.

CREATE PROCEDURE add_dept @dept_no int,
                          @d_name varchar(14),
                          @loc varchar(13)
AS
BEGIN
  IF NOT EXISTS(SELECT * FROM DEPT WHERE DEPTNO = @dept_no OR LOC = @loc)
    INSERT INTO DEPT
    VALUES (@dept_no, @d_name, @loc);
END

EXEC add_dept 12, 'test', 'wawa';

SELECT *
FROM DEPT;

-- 5. Napisz procedurę umożliwiającą użytkownikowi wprowadzanie nowych pracowników do tabeli EMP. Jako parametry
-- będziemy podawać nazwisko i nr działu zatrudnianego pracownika. Procedura powinna wprowadzając nowy rekord sprawdzić,
-- czy wprowadzany dział istnieje (jeżeli nie, to należy zgłosić błąd) oraz obliczyć mu pensję równą minimalnemu
-- zarobkowi w tym dziale. EMPNO nowego pracownika powinno zostać wyliczone jako najwyższa istniejąca wartość
-- w tabeli + 1.

CREATE PROCEDURE add_emp @e_name varchar(10),
                         @dept_no int
AS
BEGIN
  IF EXISTS(SELECT 'x' FROM DEPT WHERE DEPTNO = @dept_no)
    BEGIN
      DECLARE
        @emp_no INT
        SELECT @emp_no = MAX(EMPNO)
        FROM EMP
      DECLARE
        @min_sal INT
        SELECT @min_sal = MIN(SAL)
        FROM EMP
        WHERE DEPTNO = @dept_no;
      INSERT INTO EMP
      VALUES (@emp_no + 1, @e_name, null, null, null, @min_sal, null, @dept_no);
    END
  ELSE
PRINT 'invalid dept_no'
END

EXEC add_emp 'Działa', 10
EXEC add_emp 'Niepoprawne deptno', 11