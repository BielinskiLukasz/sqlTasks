-- SQL - DML, DDL, modyfikacja danych

-- 1.	Utwórz tabelę „miasto” posiadającą klucz główny (np. id_miasto) oraz kolumnę „nazwa”.


-- 2.	Utwórz tabelę „osoba” posiadającą kolumny: id_osoby, nazwisko, data_urodzenia, adres oraz id_miasto, które jest
--    kluczem obcym z tabeli miasto.


-- 3.	Dodaj kolumnę „zawod” do tabeli osoba.


-- 4.	Wstaw kilka przykładowych miast.


-- 5.	Wstaw kilka osób do tabeli „osoba”. Sprawdź czy da się wstawić id_miasta nie istniejące w tabeli „miasto”?


-- 6.	Wstawi do tabeli osoba wszystkich pracowników z tabeli emp. Dla brakujących pól (data_urodzenia, id_miasta,
--    adres) można przyjąć stałą wartość lub NULL.


-- 7.	Zmień dowolnie datę urodzenia oraz adres wybranej osobie.


-- 8.	Usuń wszystkie osoby, których nazwisko zaczyna się na literę P.


-- 9.	Do tabeli „osoba” dodaj kolumnę „PESEL” z opcją UNIQUE. Sprawdź wstawiając kilka rekordów, czy unikalność
--    numerów PESEL będzie rzeczywiście sprawdzana.


-- 10.	Do tabeli „osoba” dodaj więzy typu CHECK, które będą pilnowały, aby data urodzenia była większa niż
--      1 styczna 1900. Sprawdź czy da się wstawić osobę urodzoną przed 1900 rokiem.


-- 11.	Usuń utworzone przed siebie tabele.
