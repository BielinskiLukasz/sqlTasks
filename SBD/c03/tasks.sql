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
  IF @sal < 1000
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
                                   WHERE sal > 1500
                                      OR sal < 1000;
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
      IF @sal < @salary_to_rise
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