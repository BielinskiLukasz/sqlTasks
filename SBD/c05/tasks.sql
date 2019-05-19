-- 1. Napisz prosty program w PL/SQL. Zadeklaruj zmienną i przypisz jej wartość będącą liczbą rekordów w tabeli EMP
-- (lub jakiejkolwiek innej). Wypisz uzyskany wynik używając instrukcji PRINT, w postaci napisu np. "W tabeli jest 10
-- osób".


-- 2. Sprawdź w bloku PL/SQL liczbę pracowników z tabeli EMP. Jeśli liczba jest mniejsza niż 16, wstaw pracownika
-- Kowalskiego i wypisz komunikat. W przeciwnym przypadku wypisz komunikat informujący o tym, że nie wstawiono danych.


-- 3. Napisz procedurę służącą do wstawiania działów do tabeli DEPT. Procedura na pobierać jako parametry: nr_działu,
-- nazwę i lokalizację. Należy sprawdzić, czy dział o takiej nazwie lub lokalizacji już istnieje. Jeżeli istnieje, to
-- nie wstawiamy nowego rekordu.
-- PL/SQL – Kursory


-- 4. Przy pomocy kursora przejrzyj wszystkich pracowników i zmodyfikuj wynagrodzenia tak, aby osoby zarabiające mniej
-- niż 1000 miały zwiększone wynagrodzenie o 10%, natomiast osoby zarabiające powyżej 1500 miały zmniejszone
-- wynagrodzenie o 10%. Wypisz na ekran każdą wprowadzoną zmianę.


-- 5. Przerób kod z zadania 1 na procedurę tak, aby wartości zarobków (1000 i 1500) nie były stałe, tylko były
-- parametrami procedury.


-- 6. W procedurze sprawdź średnią wartość zarobków z tabeli EMP z działu określonego parametrem procedury. Następnie
-- należy dać prowizję (comm) tym pracownikom tego działu, którzy zarabiają poniżej średniej. Prowizja powinna wynosić
-- 5% ich miesięcznego wynagrodzenia.

CREATE OR REPLACE PROCEDURE GIVE_COMM(deptno_in IN NUMBER)
    IS
    empno_data     NUMBER(4);
    actual_salary  NUMBER(7, 2);
    average_salary NUMBER(7, 2);
    CURSOR c1 IS
        SELECT EMPNO, SAL
        FROM EMP
        WHERE DEPTNO = deptno_in;

BEGIN
    SELECT AVG(SAL) INTO average_salary
    FROM EMP
    WHERE DEPTNO = deptno_in;

    OPEN c1;

    FETCH c1 INTO empno_data, actual_salary;

    WHILE c1%FOUND
        LOOP
            IF actual_salary < average_salary THEN
                UPDATE EMP
                SET COMM = actual_salary * 0.05
                WHERE EMPNO = empno_data;

                COMMIT;
            END IF;

            FETCH c1 INTO empno_data, actual_salary;
        END LOOP;

    CLOSE c1;

END GIVE_COMM;

BEGIN
    GIVE_COMM(10);
END;
