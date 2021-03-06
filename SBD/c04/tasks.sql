-- 1. Utwórz wyzwalacz, który nie pozwoli usunąć rekordu z tabeli EMP.

CREATE TRIGGER cannotDelete
    ON Emp
    FOR DELETE
    AS
BEGIN
    ROLLBACK
    RAISERROR ('Nie można usunąć pracownika',1,2)
END;

DELETE
FROM emp
WHERE job = 'SALESMAN';

-- 2. Utwórz wyzwalacz, który przy wstawianiu pracownika do tabeli EMP, wstawi prowizję równą 0, jeśli prowizja była
-- pusta.
-- Uwaga: Zadanie da się wykonać bez użycia wyzwalaczy przy pomocy DEFAULT. Użyjmy jednak wyzwalacza w celach
-- treningowych.

CREATE TRIGGER insertEmptyComm
    ON Emp
    FOR Insert
    AS
BEGIN
    DECLARE
        @comm DECIMAL(6, 2), @empno INT
    SELECT @comm = comm FROM inserted
    SELECT @empno = empno FROM inserted
    IF @comm IS NULL
        BEGIN
            UPDATE emp
            SET comm = 0
            WHERE empno = @empno
        END
END;

INSERT INTO emp
VALUES (9998, 'SMITH', 'CLERK', 7902, CONVERT(DATETIME, '17-DEC-1980'), 800, NULL, 20);

-- 3. Utwórz wyzwalacz, który przy wstawianiu lub modyfikowaniu danych w tabeli EMP sprawdzi czy nowe zarobki
-- (wstawiane lub modyfikowane) są większe niż 1000. W przeciwnym przypadku wyzwalacz powinien zgłosić błąd i nie
-- dopuścić do wstawienia rekordu.
-- Uwaga: Ten sam efekt można uzyskać łatwiej przy pomocy więzów spójności typu CHECK. Użyjmy wyzwalacza w celach
-- treningowych.

CREATE TRIGGER payTooLow
    ON Emp
    FOR Insert, Update
    AS
BEGIN
    DECLARE
        @sal DECIMAL(6, 2)
    SELECT @sal = sal FROM inserted
    IF @sal <= 1000
        BEGIN
            ROLLBACK
            RAISERROR ('Trzeba płacić pracownikowi więcej niż 1000',1,2)
        END
END;

INSERT INTO emp
VALUES (9997, 'SMITH', 'CLERK', 7902, CONVERT(DATETIME, '17-DEC-1980'), 1000, NULL, 20);

UPDATE emp
SET sal = 200
WHERE job = 'SALESMAN';

-- 4. Utwórz tabelę budzet:

CREATE TABLE budzet
(
    wartosc INT NOT NULL
)

-- 5. W tabeli tej będzie przechowywana łączna wartość wynagrodzenia wszystkich pracowników. Tabela będzie zawsze
-- zawierała jeden wiersz. Należy najpierw obliczyć początkową wartość zarobków:

INSERT INTO budzet (wartosc)
SELECT SUM(sal)
FROM emp;

-- 6. Utwórz wyzwalacz, który będzie pilnował, aby wartość w tabeli budzet była zawsze aktualna, a więc przy wszystkich
-- operacjach aktualizujących tabelę EMP (INSERT, UPDATE, DELETE), wyzwalacz będzie aktualizował wpis w tabeli budżet.

CREATE TRIGGER updateBudget
    ON Emp
    FOR Insert, Update, Delete
    AS
BEGIN
    DECLARE
        @zmniejsz INT, @zwieksz INT
    SELECT @zmniejsz = SUM(sal) FROM deleted
    SELECT @zwieksz = SUM(sal) FROM inserted
    UPDATE budzet SET wartosc = wartosc - ISNULL(@zmniejsz, 0) + ISNULL(@zwieksz, 0)
END;

INSERT INTO emp
VALUES (9996, 'SMITH', 'CLERK', 7902, CONVERT(DATETIME, '17-DEC-1980'), 800, NULL, 20);

UPDATE emp
SET sal = 600
WHERE job = 'SALESMAN';

DELETE
FROM emp
WHERE empno = 9996;

-- 7. Napisz wyzwalacz, który nie pozwoli modyfikować nazw działów w tabeli DEPT. Powinno być jednak możliwe wstawianie
-- nowych działów.

CREATE TRIGGER saveDeptName
    ON Dept
    FOR Update
    AS
BEGIN
    DECLARE
        @dname VARCHAR(14)
    SELECT @dname = dname FROM inserted
    IF @dname IS NOT NULL
        BEGIN
            ROLLBACK
            RAISERROR ('Nie można zmieniać nazw działów',1,2)
        END
END;

INSERT INTO dept
VALUES (50, 'x', 'y');

UPDATE dept
SET dname = 'z'
WHERE dname = 'x';

-- 8. Napisz jeden wyzwalacz, który:
-- ➢ Nie pozwoli usunąć pracownika, którego pensja jest większa od 0.
-- ➢ Nie pozwoli zmienić nazwiska pracownika.
-- ➢ Nie pozwoli wstawić pracownika, który już istnieje (sprawdzając po nazwisku).

CREATE TRIGGER cannotSomeActions
    ON Emp
    FOR Insert, Update, Delete
    AS
BEGIN
    DECLARE
        @sal          DECIMAL(6, 2),
        @ename        VARCHAR(10),
        @deletedEname VARCHAR(10)
    SELECT @sal = sal FROM deleted
    SELECT @ename = ename FROM inserted
    SELECT @deletedEname = ename FROM deleted
    IF @deletedEname IS NULL AND @ename IN (
        SELECT ename
        FROM emp)
        BEGIN
            ROLLBACK
            RAISERROR ('Istnieje już pracownik o takim nazwisku',1,2)
        END
    ELSE
        IF @ename IS NOT NULL AND @deletedEname IS NOT NULL AND @ename != @deletedEname
            BEGIN
                ROLLBACK
                RAISERROR ('Nie można zmieniać nazwiska pracownika',1,2)
            END
        ELSE
            IF @sal > 0
                BEGIN
                    ROLLBACK
                    RAISERROR ('Nie można usunąć pracownika, którego pensja jest większa od 0',1,2)
                END
END;

INSERT INTO emp
VALUES (9995, 'SMITH', 'CLERK', 7902, CONVERT(DATETIME, '17-DEC-1980'), 800, NULL, 20);

UPDATE emp
SET ename = 'SMITH2'
WHERE job = 'CLERK';

DELETE
FROM emp
WHERE empno = 9996;

-- 9. Napisz wyzwalacz, który:
-- ➢ Nie pozwoli zmniejszać pensji.
-- ➢ Nie pozwoli usuwać pracowników.

CREATE TRIGGER cannotSomeOtherActions
    ON Emp
    FOR Update, Delete
    AS
BEGIN
    DECLARE
        @oldSal   DECIMAL(6, 2),
        @newSal   DECIMAL(6, 2),
        @oldCount INT,
        @newCount INT
    SELECT @oldSal = sal FROM deleted
    SELECT @newSal = sal FROM inserted
    SELECT @oldCount = COUNT(*) from deleted
    SELECT @newCount = COUNT(*) from inserted
    IF @oldCount > 0 AND @newCount = 0
        BEGIN
            ROLLBACK
            RAISERROR ('Nie można usuwać pracowników',1,2)
        END
    ELSE
        IF @oldSal > @newSal
            BEGIN
                ROLLBACK
                RAISERROR ('Nie można zmniejszać pensji',1,2)
            END
END;

INSERT INTO emp
VALUES (9995, 'SMITH', 'CLERK', 7902, CONVERT(DATETIME, '17-DEC-1980'), 800, NULL, 20);

UPDATE emp
SET sal = 799
WHERE ename = 'SMITH';

DELETE
FROM emp
WHERE empno = 9996;