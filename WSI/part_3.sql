
/*
Some query's don't work with mySQL Workbench!
*/

-- Dla bazy danych zawierającej poniższe tabele:
--   EMP {empno(PK), ename, deptno(FK), mgr(FK), sal, comm, hiredate, job}
--   DEPT {deptno(PK), dname, loc}
--   SALGRADE {grade, losal, hisal}

-- 1. Wypisz wszystkie dane z tabel EMP i DEPT, nie realizując ich złączenia.

-- 2. Wypisz wszystkie dane z połączonych tabel EMP i DEPT.

-- 3. Wypisz nazwiska wszystkich pracowników, wraz z numerami, nazwami i lokalizacjami departamentów, w których są oni
--    zatrudnieni. Zwracane rekordy posortuj w kolejności alfabetycznej nazwisk.

-- 4. Dla pracowników o miesięcznej pensji powyżej 1500 wypisz ich nazwiska, miejsca usytuowania ich departamentów,
--    oraz nazwy tych departamentów.

-- 5. Utwórz listę pracowników podając ich nazwisko, zawód, pensję i stopień zaszeregowania (grupę zarobkową Grade).
--    Wynik posortuj według grupy zaszeregowania malejąco i nazwiska rosnąco.

-- 6. Wypisz informacje o pracownikach (nazwisko, płaca, stanowisko), których zarobki odpowiadają 3 grupie zarobkowej.

-- 7. Wypisz nazwiska i stanowiska pracowników zatrudnionych w DALLAS.

-- 8. Wybierz pracowników z działu 30 i 40 (nazwisko, numer działu, nazwę działu, i jego lokalizację). Wypisz również
--    dane działu, 40 w którym brak jest zatrudnionych pracowników.

-- 9. Wypisz nazwisko, nazwę i lokalizacje działu wszystkich pracowników. Uwzględnij także tych pracowników, którzy
--    nie są przypisani do żadnego działu.

-- 10. Wypisz nazwiska wszystkich pracowników oraz nazwy wszystkich działów. W wyniku mają pojawić się nazwiska
--     pracowników nieprzypisanych do żadnych działów, a także nazwy działów, w których nie są zatrudnieni pracownicy.

-- 11. Wypisz nazwiska pracowników, którzy zarabiają mniej od swoich kierowników.

-- 12. Do rozwiązania zadania 11 dołącz nazwiska szefów, oraz płace szefów i ich podwładnych.

-- 13. Wykorzystując operację na zbiorach wyników, wypisz nazwy wszystkich stanowisk, które występujące w dziale 10
--     lub w dziale 30.

-- 14. Wykorzystując operację na zbiorach wyników, wypisz stanowiska występujące zarówno w dziale 10, jak i w dziale 30.

-- 15. Wykorzystując operację na zbiorach wyników, wypisz stanowiska występujące w dziale 10, a niewystępujące
--     w dziale 30.
