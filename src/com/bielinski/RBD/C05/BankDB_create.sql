-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-12-02 14:54:01.452

-- tables
-- Table: Adres
CREATE TABLE Adres
(
  id            integer NOT NULL,
  typ_adresu    varchar2(2) NOT NULL,
  kraj          varchar2(50) NOT NULL,
  wojewodztwo   varchar2(50) NOT NULL,
  miasto        varchar2(50) NOT NULL,
  kod_pocztowy  varchar2(10) NOT NULL,
  ulica         varchar2(100) NOT NULL,
  nr_domu       varchar2(10) NOT NULL,
  nr_mieszkania varchar2(10) NULL,
  CONSTRAINT Adres_pk PRIMARY KEY (id)
);

-- Table: Adres_dict
CREATE TABLE Adres_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Adres_dict_pk PRIMARY KEY (key)
);

-- Table: Bank_dict
CREATE TABLE Bank_dict
(
  key                  varchar2(2) NOT NULL,
  value                varchar2(50) NOT NULL,
  adres_siedziby_banku integer NOT NULL,
  CONSTRAINT Bank_dict_pk PRIMARY KEY (key)
);

-- Table: Dane_osobowe
CREATE TABLE Dane_osobowe
(
  id                    integer NOT NULL,
  imie                  varchar2(50) NOT NULL,
  drugie_imie           varchar2(50) NULL,
  nazwisko              varchar2(100) NOT NULL,
  nr_pesel              integer NULL,
  Adres_id              integer NOT NULL,
  imie_ojca             varchar2(50) NOT NULL,
  imie_matki            varchar2(50) NOT NULL,
  nazwisko_rodowe_matki varchar2(50) NOT NULL,
  data_urodzenia        date    NOT NULL,
  Obywatelstwo_key      varchar2(2) NOT NULL,
  Urzad_skarbowy_id     integer NOT NULL,
  Identyfikator_id      integer NOT NULL,
  Stan_cywilny_key      varchar2(2) NOT NULL,
  miejsce_urodzenia     varchar2(100) NOT NULL,
  CONSTRAINT Dane_osobowe_pk PRIMARY KEY (id)
);

-- Table: Dane_osobowe_email
CREATE TABLE Dane_osobowe_email
(
  id         integer NOT NULL,
  Email_id   integer NOT NULL,
  Osoba_id   integer NOT NULL,
  czy_glowny varchar2(1) NOT NULL,
  CONSTRAINT Dane_osobowe_email_pk PRIMARY KEY (id)
);

-- Table: Dane_osobowe_telefon
CREATE TABLE Dane_osobowe_telefon
(
  id         integer NOT NULL,
  Osoba_id   integer NOT NULL,
  Telefon_id integer NOT NULL,
  czy_glowny varchar2(1) NOT NULL,
  CONSTRAINT Dane_osobowe_telefon_pk PRIMARY KEY (id)
);

-- Table: Email
CREATE TABLE Email
(
  id    integer NOT NULL,
  adres varchar2(50) NOT NULL,
  CONSTRAINT Email_pk PRIMARY KEY (id)
);

-- Table: Identyfikator
CREATE TABLE Identyfikator
(
  id                integer NOT NULL,
  Identygikator_key varchar2(2) NOT NULL,
  nr                varchar2(50) NOT NULL,
  CONSTRAINT Identyfikator_pk PRIMARY KEY (id)
);

-- Table: Identyfikator_konta
CREATE TABLE Identyfikator_konta
(
  id       integer NOT NULL,
  nr_konta integer NOT NULL,
  Bank_key varchar2(2) NULL,
  Adres_id integer NULL,
  CONSTRAINT Identyfikator_konta_pk PRIMARY KEY (id)
);

-- Table: Identygikator_dict
CREATE TABLE Identygikator_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Identygikator_dict_pk PRIMARY KEY (key)
);

-- Table: Karta
CREATE TABLE Karta
(
  id                        integer   NOT NULL,
  nr_karty                  integer   NOT NULL,
  typ_karty_key             varchar2(2) NOT NULL,
  wlasciciel_karty_id       integer   NOT NULL,
  podpiety_rachunek_id      integer   NOT NULL,
  dzienny_limit_kwoty       float(10) NULL,
  limit_debetu              float(10) NOT NULL,
  czy_platnosci_mobilne     varchar2(1) NOT NULL,
  czy_platnosci_zblizeniowe varchar2(1) NOT NULL,
  data_waznosci             date      NOT NULL,
  CONSTRAINT Karta_pk PRIMARY KEY (id)
);

-- Table: Karta_dict
CREATE TABLE Karta_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Karta_dict_pk PRIMARY KEY (key)
);

-- Table: Kategoria_dict
CREATE TABLE Kategoria_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Kategoria_dict_pk PRIMARY KEY (key)
);

-- Table: Klient
CREATE TABLE Klient
(
  id                    integer NOT NULL,
  Dane_osobowe_id       integer NOT NULL,
  data_odejscia_klienta date NULL,
  Logowanie_id          integer NOT NULL,
  rodo_Flag             varchar2(1) NOT NULL,
  Zgoda_marketingowe_id integer NOT NULL,
  CONSTRAINT Klient_pk PRIMARY KEY (id)
);

-- Table: Klient_Lokata
CREATE TABLE Klient_Lokata
(
  id             integer   NOT NULL,
  Klient_id      integer   NOT NULL,
  Lokata_id      integer   NOT NULL,
  kwota          float(30) NOT NULL,
  okres          integer   NOT NULL,
  data_zalozenia date      NOT NULL,
  CONSTRAINT Klient_Lokata_pk PRIMARY KEY (id)
);

-- Table: Klient_Rachunek
CREATE TABLE Klient_Rachunek
(
  id          integer NOT NULL,
  Klient_id   integer NOT NULL,
  Rachunek_id integer NOT NULL,
  CONSTRAINT Klient_Rachunek_pk PRIMARY KEY (id)
);

-- Table: Logowanie
CREATE TABLE Logowanie
(
  id    integer NOT NULL,
  login integer NOT NULL,
  haslo varchar2(50) NOT NULL,
  CONSTRAINT Logowanie_pk PRIMARY KEY (id)
);

-- Table: Lokata
CREATE TABLE Lokata
(
  id                   integer   NOT NULL,
  oprocentowanie       float(10) NOT NULL,
  kwota_min            float(10) NOT NULL,
  kwota_max            float(10) NOT NULL,
  okres_min            integer   NOT NULL,
  okres_max            integer   NOT NULL,
  poczatek_dostepnosci date      NOT NULL,
  koniec_dostepnosci   date      NOT NULL,
  CONSTRAINT Lokata_pk PRIMARY KEY (id)
);

-- Table: Obywatelstwo_dict
CREATE TABLE Obywatelstwo_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Obywatelstwo_dict_pk PRIMARY KEY (key)
);

-- Table: Operacja
CREATE TABLE Operacja
(
  id                   integer   NOT NULL,
  dzienny_nr_operacji  integer   NOT NULL,
  typ_operacji_key     varchar2(2) NOT NULL,
  nadawca_id           integer   NOT NULL,
  odbiorcaa_id         integer   NOT NULL,
  kwota                float(30) NOT NULL,
  opis                 varchar2(500) NOT NULL,
  Kategoria_key        varchar2(2) NOT NULL,
  Klient_id            integer   NOT NULL,
  rodzaj_platnosci_key varchar2(2) NOT NULL,
  czas_zlecenia        timestamp NOT NULL,
  data_zaksiegowania   date      NOT NULL,
  CONSTRAINT Operacja_pk PRIMARY KEY (id)
);

-- Table: Operacja_dict
CREATE TABLE Operacja_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Operacja_dict_pk PRIMARY KEY (key)
);

-- Table: Platnosc_dict
CREATE TABLE Platnosc_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Platnosc_dict_pk PRIMARY KEY (key)
);

-- Table: Rachunek
CREATE TABLE Rachunek
(
  id                       integer   NOT NULL,
  nr_rachunku              integer   NOT NULL,
  rodzaj_rachunku_key      varchar2(2) NOT NULL,
  stan_konta               float(30) NOT NULL,
  oprocentowanie           float     NOT NULL,
  data_zamkniecia_rachunku date NULL,
  CONSTRAINT Rachunek_pk PRIMARY KEY (id)
);

-- Table: Rachunek_Operacja
CREATE TABLE Rachunek_Operacja
(
  id          integer NOT NULL,
  Operacja_id integer NOT NULL,
  Rachunek_id integer NOT NULL,
  CONSTRAINT Rachunek_Operacja_pk PRIMARY KEY (id)
);

-- Table: Rachunek_dict
CREATE TABLE Rachunek_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Rachunek_dict_pk PRIMARY KEY (key)
);

-- Table: Stan_cywilny_dict
CREATE TABLE Stan_cywilny_dict
(
  key   varchar2(2) NOT NULL,
  value varchar2(50) NOT NULL,
  CONSTRAINT Stan_cywilny_dict_pk PRIMARY KEY (key)
);

-- Table: Telefon
CREATE TABLE Telefon
(
  id    integer NOT NULL,
  numer varchar2(20) NOT NULL,
  CONSTRAINT Telefon_pk PRIMARY KEY (id)
);

-- Table: Urzad_skarbowy
CREATE TABLE Urzad_skarbowy
(
  id       integer NOT NULL,
  nazwa    varchar2(50) NOT NULL,
  Adres_id integer NOT NULL,
  CONSTRAINT Urzad_skarbowy_pk PRIMARY KEY (id)
);

-- Table: Zgoda_marketingowe
CREATE TABLE Zgoda_marketingowe
(
  id      integer NOT NULL,
  zgoda_1 varchar2(1) NOT NULL,
  zgoda_2 varchar2(1) NOT NULL,
  zgoda_3 varchar2(1) NOT NULL,
  CONSTRAINT Zgoda_marketingowe_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Adres_Adres_dict (table: Adres)
ALTER TABLE Adres
  ADD CONSTRAINT Adres_Adres_dict
    FOREIGN KEY (typ_adresu)
      REFERENCES Adres_dict (key);

-- Reference: Bank_dict_Adres (table: Bank_dict)
ALTER TABLE Bank_dict
  ADD CONSTRAINT Bank_dict_Adres
    FOREIGN KEY (adres_siedziby_banku)
      REFERENCES Adres (id);

-- Reference: Identyfikator__dict (table: Identyfikator)
ALTER TABLE Identyfikator
  ADD CONSTRAINT Identyfikator__dict
    FOREIGN KEY (Identygikator_key)
      REFERENCES Identygikator_dict (key);

-- Reference: Identyfikator_konta_Adres (table: Identyfikator_konta)
ALTER TABLE Identyfikator_konta
  ADD CONSTRAINT Identyfikator_konta_Adres
    FOREIGN KEY (Adres_id)
      REFERENCES Adres (id);

-- Reference: Identyfikator_konta_Bank_dict (table: Identyfikator_konta)
ALTER TABLE Identyfikator_konta
  ADD CONSTRAINT Identyfikator_konta_Bank_dict
    FOREIGN KEY (Bank_key)
      REFERENCES Bank_dict (key);

-- Reference: Karta_Karta_dict (table: Karta)
ALTER TABLE Karta
  ADD CONSTRAINT Karta_Karta_dict
    FOREIGN KEY (typ_karty_key)
      REFERENCES Karta_dict (key);

-- Reference: Karta_Klient (table: Karta)
ALTER TABLE Karta
  ADD CONSTRAINT Karta_Klient
    FOREIGN KEY (wlasciciel_karty_id)
      REFERENCES Klient (id);

-- Reference: Karta_Rachunek (table: Karta)
ALTER TABLE Karta
  ADD CONSTRAINT Karta_Rachunek
    FOREIGN KEY (podpiety_rachunek_id)
      REFERENCES Rachunek (id);

-- Reference: Klient_Adres (table: Dane_osobowe)
ALTER TABLE Dane_osobowe
  ADD CONSTRAINT Klient_Adres
    FOREIGN KEY (Adres_id)
      REFERENCES Adres (id);

-- Reference: Klient_Dane_osobowe (table: Klient)
ALTER TABLE Klient
  ADD CONSTRAINT Klient_Dane_osobowe
    FOREIGN KEY (Dane_osobowe_id)
      REFERENCES Dane_osobowe (id);

-- Reference: Klient_Logowanie (table: Klient)
ALTER TABLE Klient
  ADD CONSTRAINT Klient_Logowanie
    FOREIGN KEY (Logowanie_id)
      REFERENCES Logowanie (id);

-- Reference: Klient_Lokata_Klient (table: Klient_Lokata)
ALTER TABLE Klient_Lokata
  ADD CONSTRAINT Klient_Lokata_Klient
    FOREIGN KEY (Klient_id)
      REFERENCES Klient (id);

-- Reference: Klient_Lokata_Lokata (table: Klient_Lokata)
ALTER TABLE Klient_Lokata
  ADD CONSTRAINT Klient_Lokata_Lokata
    FOREIGN KEY (Lokata_id)
      REFERENCES Lokata (id);

-- Reference: Klient_Obywatelstwo_dict (table: Dane_osobowe)
ALTER TABLE Dane_osobowe
  ADD CONSTRAINT Klient_Obywatelstwo_dict
    FOREIGN KEY (Obywatelstwo_key)
      REFERENCES Obywatelstwo_dict (key);

-- Reference: Klient_Rachunek_Klient (table: Klient_Rachunek)
ALTER TABLE Klient_Rachunek
  ADD CONSTRAINT Klient_Rachunek_Klient
    FOREIGN KEY (Klient_id)
      REFERENCES Klient (id);

-- Reference: Klient_Rachunek_Rachunek (table: Klient_Rachunek)
ALTER TABLE Klient_Rachunek
  ADD CONSTRAINT Klient_Rachunek_Rachunek
    FOREIGN KEY (Rachunek_id)
      REFERENCES Rachunek (id);

-- Reference: Klient_Zgoda_marketingowe (table: Klient)
ALTER TABLE Klient
  ADD CONSTRAINT Klient_Zgoda_marketingowe
    FOREIGN KEY (Zgoda_marketingowe_id)
      REFERENCES Zgoda_marketingowe (id);

-- Reference: Operacja_Dane_nadawcy (table: Operacja)
ALTER TABLE Operacja
  ADD CONSTRAINT Operacja_Dane_nadawcy
    FOREIGN KEY (nadawca_id)
      REFERENCES Identyfikator_konta (id);

-- Reference: Operacja_Dane_odbiorcy (table: Operacja)
ALTER TABLE Operacja
  ADD CONSTRAINT Operacja_Dane_odbiorcy
    FOREIGN KEY (odbiorcaa_id)
      REFERENCES Identyfikator_konta (id);

-- Reference: Operacja_Kategoria_dict (table: Operacja)
ALTER TABLE Operacja
  ADD CONSTRAINT Operacja_Kategoria_dict
    FOREIGN KEY (Kategoria_key)
      REFERENCES Kategoria_dict (key);

-- Reference: Operacja_Klient (table: Operacja)
ALTER TABLE Operacja
  ADD CONSTRAINT Operacja_Klient
    FOREIGN KEY (Klient_id)
      REFERENCES Klient (id);

-- Reference: Operacja_Operacja_dict (table: Operacja)
ALTER TABLE Operacja
  ADD CONSTRAINT Operacja_Operacja_dict
    FOREIGN KEY (typ_operacji_key)
      REFERENCES Operacja_dict (key);

-- Reference: Operacja_Platnosc_dict (table: Operacja)
ALTER TABLE Operacja
  ADD CONSTRAINT Operacja_Platnosc_dict
    FOREIGN KEY (rodzaj_platnosci_key)
      REFERENCES Platnosc_dict (key);

-- Reference: Osoba_Identyfikator (table: Dane_osobowe)
ALTER TABLE Dane_osobowe
  ADD CONSTRAINT Osoba_Identyfikator
    FOREIGN KEY (Identyfikator_id)
      REFERENCES Identyfikator (id);

-- Reference: Osoba_Stan_cywilny_dict (table: Dane_osobowe)
ALTER TABLE Dane_osobowe
  ADD CONSTRAINT Osoba_Stan_cywilny_dict
    FOREIGN KEY (Stan_cywilny_key)
      REFERENCES Stan_cywilny_dict (key);

-- Reference: Osoba_Urzad_skarbowy (table: Dane_osobowe)
ALTER TABLE Dane_osobowe
  ADD CONSTRAINT Osoba_Urzad_skarbowy
    FOREIGN KEY (Urzad_skarbowy_id)
      REFERENCES Urzad_skarbowy (id);

-- Reference: Osoba_email_Email (table: Dane_osobowe_email)
ALTER TABLE Dane_osobowe_email
  ADD CONSTRAINT Osoba_email_Email
    FOREIGN KEY (Email_id)
      REFERENCES Email (id);

-- Reference: Osoba_email_Osoba (table: Dane_osobowe_email)
ALTER TABLE Dane_osobowe_email
  ADD CONSTRAINT Osoba_email_Osoba
    FOREIGN KEY (Osoba_id)
      REFERENCES Dane_osobowe (id);

-- Reference: Osoba_telefon_Osoba (table: Dane_osobowe_telefon)
ALTER TABLE Dane_osobowe_telefon
  ADD CONSTRAINT Osoba_telefon_Osoba
    FOREIGN KEY (Osoba_id)
      REFERENCES Dane_osobowe (id);

-- Reference: Osoba_telefon_Telefon (table: Dane_osobowe_telefon)
ALTER TABLE Dane_osobowe_telefon
  ADD CONSTRAINT Osoba_telefon_Telefon
    FOREIGN KEY (Telefon_id)
      REFERENCES Telefon (id);

-- Reference: Rachunek_Operacja_Operacja (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja
  ADD CONSTRAINT Rachunek_Operacja_Operacja
    FOREIGN KEY (Operacja_id)
      REFERENCES Operacja (id);

-- Reference: Rachunek_Operacja_Rachunek (table: Rachunek_Operacja)
ALTER TABLE Rachunek_Operacja
  ADD CONSTRAINT Rachunek_Operacja_Rachunek
    FOREIGN KEY (Rachunek_id)
      REFERENCES Rachunek (id);

-- Reference: Rachunek_Rachunek_dict (table: Rachunek)
ALTER TABLE Rachunek
  ADD CONSTRAINT Rachunek_Rachunek_dict
    FOREIGN KEY (rodzaj_rachunku_key)
      REFERENCES Rachunek_dict (key);

-- Reference: Urzad_skarbowy_Adres (table: Urzad_skarbowy)
ALTER TABLE Urzad_skarbowy
  ADD CONSTRAINT Urzad_skarbowy_Adres
    FOREIGN KEY (Adres_id)
      REFERENCES Adres (id);

-- End of file.

