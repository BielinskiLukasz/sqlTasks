-- 1. Utwórz wyzwalacz, który nie pozwoli usunąć rekordu z tabeli EMP.
CREATE TRIGGER wyzw
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


-- 3. Utwórz wyzwalacz, który przy wstawianiu lub modyfikowaniu danych w tabeli EMP sprawdzi czy nowe zarobki
-- (wstawiane lub modyfikowane) są większe niż 1000. W przeciwnym przypadku wyzwalacz powinien zgłosić błąd i nie
-- dopuścić do wstawienia rekordu.
-- Uwaga: Ten sam efekt można uzyskać łatwiej przy pomocy więzów spójności typu CHECK. Użyjmy wyzwalacza w celach
-- treningowych.


-- 4. Utwórz tabelę budzet:
-- CREATE TABLE budzet (wartosc INT NOT NULL)


-- 5. W tabeli tej będzie przechowywana łączna wartość wynagrodzenia wszystkich pracowników. Tabela będzie zawsze
-- zawierała jeden wiersz. Należy najpierw obliczyć początkową wartość zarobków:
-- INSERT INTO budzet (wartosc)
-- SELECT SUM(sal) FROM emp


-- 6. Utwórz wyzwalacz, który będzie pilnował, aby wartość w tabeli budzet była zawsze aktualna, a więc przy wszystkich
-- operacjach aktualizujących tabelę EMP (INSERT, UPDATE, DELETE), wyzwalacz będzie aktualizował wpis w tabeli budżet.


-- 7. Napisz wyzwalacz, który nie pozwoli modyfikować nazw działów w tabeli DEPT. Powinno być jednak możliwe wstawianie
-- nowych działów.


