
/*
Some query's don't work with mySQL Workbench!
*/

-- Dla bazy danych zawierającej poniższe tabele:
--   EMP {empno(PK), ename, deptno(FK), mgr(FK), sal, comm, hiredate, job}
--   DEPT {deptno(PK), dname, loc}
--   SALGRADE {grade, losal, hisal}

-- 1. Znajdź nazwisko, płacę i numer departamentu pracowników, którzy zarabiają najwięcej w swoich departamentach.

-- 2. Znajdź nazwisko, płacę i numer departamentu pracowników, którzy zarabiają powyżej średniej w ich departamentach.

-- 3. Znajdź nazwisko, płacę i stanowisko pracowników o najniższych zarobkach wśród pracowników na poszczególnych
--    stanowiskach.

-- 4. Znajdź za pomocą predykatu EXISTS nazwiska pracowników, którzy posiadają podwładnych.

-- 5. Znajdź nazwiska pracowników, których departament nie występuje w tabeli DEPT.

-- 6. Stosując podzapytanie, znajdź nazwy i lokalizację departamentów, które nie zatrudniają żadnych pracowników.

-- 7. Znajdź nazwiska, płace i stanowiska pracowników zarabiających maksymalną pensję na ich stanowiskach pracy.
--    Wynikowe rekordy uporządkuj według malejących zarobków.

-- 8. Znajdź nazwiska, płace i grupy zarobkowe pracowników zarabiających minimalną pensję w ich grupach zarobkowych.
--    Wynikowe rekordy uporządkuj według malejących grup zarobkowych.

-- 9. Wskaż dla każdego departamentu (podaj nazwę i lokalizację) nazwiska i daty zatrudnienia pracowników ostatnio
--    zatrudnionych. Wynikowe rekordy uporządkuj malejąco według dat zatrudnienia.

-- 10. Podaj nazwisko, pensję i nazwę departamentu pracowników, których płaca przekracza średnią ich grup zarobkowych.

-- 11. Stosując podzapytanie znajdź nazwiska pracowników przypisanych do nieistniejących departamentów.

-- 12. Wskaż nazwiska i płacę trzech najlepiej zarabiających pracowników w firmie. Podaj ich nazwiska i pensje.

-- 13. Wskaż nazwiska i płacę pracowników, których płace należą do trzech najwyższych płac w firmie. Podaj ich
--     nazwiska i pensje.

-- 14. Wypisz nazwisko, płacę, numer departamentu i średnią zarobków w departamencie (w jednym wyniku!)
--     dla pracowników, których zarobki przekraczają średnią ich departamentów (rozwiązanie nie wymaga użycia
--     korelacji).

-- 15. Napisz zapytanie generujące listę nazwisk pracowników i ich dat zatrudnienia, z gwiazdką (*) w wierszu ostatnio
--     zatrudnionego. Kolumnę z gwiazdką zatytułuj MAXDATE.
