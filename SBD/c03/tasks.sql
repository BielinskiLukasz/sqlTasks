-- 1. Przy pomocy kursora przejrzyj wszystkich pracowników i zmodyfikuj wynagrodzenia tak, aby osoby zarabiające mniej
-- niż 1000 miały zwiększone wynagrodzenie o 10%, natomiast osoby zarabiające powyżej 1500 miały zmniejszone
-- wynagrodzenie o 10%. Wypisz na ekran każdą wprowadzoną zmianę.

DECLARE change_salary CURSOR FOR SELECT ename, empno, sal
                                 FROM emp
                                 WHERE sal > 1500
                                    OR sal < 1000;
DECLARE
  @ename Varchar(15), @empno Int, @sal Money;
OPEN change_salary
FETCH NEXT FROM change_salary INTO @ename, @empno, @sal;
WHILE @@Fetch_status = 0
BEGIN
  IF @sal > 1500
    BEGIN
      SET @sal = @sal * 0.9;
      UPDATE emp SET sal = @sal WHERE empno = @empno;
      PRINT @ename + ' zarabia po obniżce '
        + Cast(@sal As Varchar);
    END;
  ELSE
    BEGIN
      SET @sal = @sal * 1.1;
      UPDATE emp SET sal = @sal WHERE empno = @empno;
      PRINT @ename + ' zarabia po podwyżce '
        + Cast(@sal As Varchar);
    END;
  FETCH NEXT FROM change_salary INTO @ename, @empno, @sal;
END;
CLOSE change_salary;
DEALLOCATE change_salary;

-- 2. Przerób kod z zadania 1 na procedurę tak, aby wartości zarobków (1000 i 1500) nie były stałe, tylko były
-- parametrami procedury.

CREATE PROCEDURE change_specific_salary @salary_to_rise int, @salary_to_cut int
AS
BEGIN
  DECLARE change_salary CURSOR FOR SELECT ename, empno, sal
                                   FROM emp
                                   WHERE sal > @salary_to_cut
                                      OR sal < @salary_to_rise;
  DECLARE
    @ename Varchar(15), @empno Int, @sal Money;
  OPEN change_salary
  FETCH NEXT FROM change_salary INTO @ename, @empno, @sal;
  WHILE @@Fetch_status = 0
  BEGIN
    IF @sal > @salary_to_cut
      BEGIN
        SET @sal = @sal * 0.9;
        UPDATE emp SET sal = @sal WHERE empno = @empno;
        PRINT @ename + ' zarabia po obniżce '
          + Cast(@sal As Varchar);
      END;
    ELSE
      BEGIN
        SET @sal = @sal * 1.1;
        UPDATE emp SET sal = @sal WHERE empno = @empno;
        PRINT @ename + ' zarabia po podwyżce '
          + Cast(@sal As Varchar);
      END;
    FETCH NEXT FROM change_salary INTO @ename, @empno, @sal;
  END;
  CLOSE change_salary;
  DEALLOCATE change_salary;
END;
GO

EXEC change_specific_salary 1100, 1400;

-- 3. W procedurze sprawdź średnią wartość zarobków z tabeli EMP z działu określonego parametrem procedury. Następnie
-- należy dać prowizję (comm) tym pracownikom tego działu, którzy zarabiają poniżej średniej. Prowizja powinna wynosić
-- 5% ich miesięcznego wynagrodzenia.

CREATE PROCEDURE give_common @dept_no int
AS
BEGIN
  DECLARE change_salary CURSOR FOR SELECT ename, empno, sal, comm
                                   FROM emp
                                   WHERE deptno = @dept_no;
  DECLARE
    @average_sal Int;
  SELECT @average_sal = AVG(sal) FROM emp WHERE deptno = @dept_no;

  DECLARE
    @ename Varchar(15), @empno Int, @sal Money, @comm Money;
  OPEN change_salary
  FETCH NEXT FROM change_salary INTO @ename, @empno, @sal, @comm;
  WHILE @@Fetch_status = 0
  BEGIN
    IF @sal < @average_sal
      BEGIN
        SET @comm = @sal * 0.05;
        UPDATE emp SET comm = @comm WHERE empno = @empno;
        PRINT @ename + ' dostał premię '
          + Cast(@comm As Varchar);
      END;
    FETCH NEXT FROM change_salary INTO @ename, @empno, @sal, @comm;
  END;
  CLOSE change_salary;
  DEALLOCATE change_salary;
END;
GO

EXEC give_common 10;

-- Zad4
-- (bez kursora) Utwórz tabelę Magazyn (IdPozycji, Nazwa, Ilosc) zawierającą ilości poszczególnych towarów w magazynie 
-- i wstaw do niej kilka przykładowych rekordów. W bloku Transact-SQL sprawdź, którego artykułu jest najwięcej w 
-- magazynie i zmniejsz ilość tego artykułu o 5 (jeśli stan jest większy lub równy 5, w przeciwnym wypadku zgłoś błąd).

CREATE TABLE Magazyn
(
    IdPozycji integer     NOT NULL,
    Nazwa     varchar(50) NOT NULL,
    Ilosc     float(10)   NOT NULL,
    CONSTRAINT Magazyn_pk PRIMARY KEY (IdPozycji)
);

INSERT INTO Magazyn
VALUES (1, 'Sample1', 10);
INSERT INTO Magazyn
VALUES (2, 'Sample2', 1);
INSERT INTO Magazyn
VALUES (3, 'Sample3', 9);
INSERT INTO Magazyn
VALUES (4, 'Sample4', 2);
INSERT INTO Magazyn
VALUES (5, 'Sample5', 8);
INSERT INTO Magazyn
VALUES (6, 'Sample6', 3);
INSERT INTO Magazyn
VALUES (7, 'Sample7', 7);
INSERT INTO Magazyn
VALUES (8, 'Sample8', 4);
INSERT INTO Magazyn
VALUES (9, 'Sample9', 6);
INSERT INTO Magazyn
VALUES (10, 'Sample10', 5);

BEGIN
    DECLARE
        @maxIlosc Int
    SELECT @maxIlosc = MAX(Ilosc)
    FROM Magazyn

    IF @maxIlosc < 5
        BEGIN
            RAISERROR ('Za mało produktów w magazynie', 1, 10)
        END
    ELSE
        BEGIN
            UPDATE Magazyn
            SET Ilosc = @maxIlosc - 5
            WHERE IdPozycji = (
                SELECT MIN(IdPozycji)
                FROM Magazyn
                WHERE Ilosc = @maxIlosc
            )
        END
END;

-- Zad5
-- Przerób kod z zadania 4 na procedurę, której będziemy mogli podać wartość, o którą zmniejszamy stan
-- (zamiast wpisanego „na sztywno” 5).

CREATE PROCEDURE stash_max_prod @how_many int
AS
BEGIN
    DECLARE
        @maxIlosc Int
    SELECT @maxIlosc = MAX(Ilosc)
    FROM Magazyn

    IF @maxIlosc < @how_many
        BEGIN
            RAISERROR ('Za mało produktów w magazynie', 1, 10)
        END
    ELSE
        BEGIN
            UPDATE Magazyn
            SET Ilosc = @maxIlosc - @how_many
            WHERE IdPozycji = (
                SELECT MIN(IdPozycji)
                FROM Magazyn
                WHERE Ilosc = @maxIlosc
            )
        END
END;
GO

EXEC stash_max_prod 7
