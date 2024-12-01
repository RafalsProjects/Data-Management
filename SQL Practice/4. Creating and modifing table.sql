-- Tworzenie tabeli pracownik
create table Pracownik
(
    [Imie] [nvarchar] (20) not null,
    [Nazwisko] [nvarchar] (10) not null,
    [Plec] [nvarchar] (30),
    [Stanowisko] [nvarchar] (25),
    [Stawka za godzine] decimal(16,2) null
)
/*
Syntax
Nazwa_Kolumby Typ_danych Długość_ciagu_znawków Określenie_warunków
określenie warunku ma na celu określenie czy komórka może być null lub nie lub bez warunków

Typ_danych i pozostałe zmienne możemy znaleźć w dokumentacji SQL / MSSQL
Możemy też skopiować dane z Excela do tabeli bezpośredniu lub zaimportować dane z Excela
*/
select *
from pracownik

-- błąd typu danych przy wstawianiu 
insert Pracownik
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz', '10 zl')

-- wstawianie rekordu
insert Pracownik
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz', '10')

select *
from pracownik

-- Wstawienie wielu rekordów
insert pracownik
values
    ('Natalia', 'Niewiadomo', 'Żeńśka', 'Sekretarka', 20),
    ('Natalia', 'Brudas', 'Nijaka', 'Sekretarka', 20),
    ('Maciej', 'Brudas', 'Nijaka', 'Sekretarka', 20),
    ('Bob', 'Task', 'Żeńska', 'Manago', 50)

select *
from pracownik

-- usuwanie jednego rekordu 
delete from pracownik where Imie = 'Maciej'
select *
from pracownik

-- usuwanie wszystkiego 
delete from pracownik
select *
from pracownik

-- wszystkich wierszy przy pomocy truncate (obcinanie)
truncate table pracownik
select *
from pracownik

-- usuwanie tabeli
drop table pracownik

-- Różnica między DELETE, TRUNCATE i DROP
-- DELETE 
-- zostawia logi, wykonuje wyzwalacze
-- jest wolniejszy usuwa jeden wiersz po drugim,
-- można używać where
-- Można przywracać dane przy pomocy rollback (przed rollback potrzeba innej komendy)

-- TRUNCATE
-- truncate nie wykonuje wyzwalaczy nie zostawia logów
-- jest szybszę od delete
-- zachowuje strukture tabeli
-- nie można używać warunków ehere 
-- nie ma możliwości przywrócenia

-- DROP
-- usuwa całkowicie tabele z jej strukturą

--  Błąd nie wszystkie kolumny wprowadzaone
select *
from pracownik
insert Pracownik
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz')
-- rozwiązanie #1
insert Pracownik
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz', null)
-- rozwiązanie #2
insert pracownik
    (Imie, Nazwisko, Plec, Stanowisko)
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz')


-- Dodawanie kolumny timestamp 
/*
ALTER TABLE nazwa_tabeli
ADD nowa_kolumna typ_danych;
Dodaje nam pustą kolumny z powyższą specyfikacją

typ_danych znajdziemy w dokumetnacji

*/
select *
from pracownik

alter table pracownik 
add [Timestamp] DATETIME

select *
from pracownik

-- wstawianie rekordu z typem danych datą
insert Pracownik
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz', '10', '2024-11-30')

select *
from pracownik

-- Testowanie funkcji, testowanie rezultatów
select 2+2*2, 'wynik'
select len('wynik')
-- długość ciągu znaków wynik

select GETDATE()
-- bierząca dane

-- Dorzycanie rekordu z aktualną daną
select *
from pracownik

insert pracownik
values
    ('Antoni', 'Anonim', 'Męska', 'Stolarz', '10', GETDATE())

-- Usuwanie kolumny
select *
from pracownik

alter table pracownik drop column [Timestamp]

select *
from pracownik

-- Tworzenie przykładowej tabeli 'Pracownicy'
create table Pracownicy
(
    ID int primary key,
    Imie nvarchar(50),
    Nazwisko nvarchar(50),
    Wiek int,
    Wynagrodzenie decimal(10, 2)
);

-- 1. Dodawanie nowej kolumny 'DataUrodzenia' typu DATE
select *
from Pracownicy

alter table Pracownicy
add DataUrodzenia DATE;

select *
from Pracownicy


-- 2. Usuwanie istniejącej kolumny 'Wiek'
select *
from Pracownicy

alter table Pracownicy
drop column Wiek;

select *
from Pracownicy


-- 3. Modyfikacja typu danych kolumny 'Wynagrodzenie' na DECIMAL(15, 2)
select *
from Pracownicy

alter table Pracownicy
alter column Wynagrodzenie DECIMAL(15, 2);

select *
from Pracownicy


-- 4. Zmiana nazwy kolumny 'Imie' na 'PierwszeImie'
-- Uwaga: W SQL Server używamy procedury systemowej sp_rename
exec sp_rename 'Pracownicy.Imie', 'PierwszeImie', 'COLUMN';

-- 5. Dodanie ograniczenia UNIQUE na kolumnę 'Email'
alter table Pracownicy
add constraint UQ_Email unique (Email);

-- 6. Usunięcie ograniczenia UNIQUE o nazwie 'UQ_Email'
alter table Pracownicy
drop constraint UQ_Email;


-- Tworzenie tabeli 'Pracownicy'
create table Pracownicy
(
    Imie nvarchar(50),
    -- Kolumna dla imienia pracownika
    Nazwisko nvarchar(50),
    -- Kolumna dla nazwiska pracownika
    Wiek int,
    -- Kolumna dla wieku pracownika
    Plec nvarchar(10),
    -- Kolumna dla płci pracownika
    Stanowisko nvarchar(50),
    -- Kolumna dla stanowiska pracownika
    Stawka_za_godzine decimal(10, 2)
    -- Kolumna dla stawki godzinowej
);

-- Wstawianie danych do tabeli 'Pracownicy'
insert into Pracownicy
    (Imie, Nazwisko, Wiek, Plec, Stanowisko, Stawka_za_godzine)
values
    ('Antoni', 'Anonim', 26, 'Męska', 'Stolarz', 10.00),
    ('Natalia', 'Niewiadoma', 31, 'Żeńska', 'Sekretarka', 20.00),
    ('Alina', 'Enigma', 41, 'Żeńska', 'Sekretarka', 20.00);


-- Sprawdzenie danych w tabeli
select *
from Pracownicy;

-- Aktualizacja dla wszystkich pracowników / ustawienie wartości 
update Pracownicy
set wiek = wiek + 1

select *
from Pracownicy;

update Pracownicy
set wiek = wiek - 9

select *
from Pracownicy;


-- Zwięszkenie stawki
update Pracownicy
set stawka_za_godzine = stawka_za_godzine * 2

update Pracownicy
set stawka_za_godzine
= stawka_za_godzine * 2
where Stawka_za_godzine = 40

update Pracownicy
set stawka_za_godzine
= stawka_za_godzine * 4
where Stanowisko = 'Stolarz'

-- Transakcja
/* 
Transackja umożliwia przetestowania 
niektórych operacji, które są odwracalne

begin tran -- rozpoczęcie transakcji

rollback -- przywraca nam bazę do stanu sprzed rozpoczęcia transackji

commit -- zatwierdza nam zmiany w środki transakcji

Po użyciu commit nie możemy przywrócić bazy dancyh do poprzedniego stanu

*/
select *
from Pracownicy

begin tran

update Pracownicy
set Stawka_za_godzine=Stawka_za_godzine*2

select *
from Pracownicy

rollback
-- przywraca nam bazę do stanu sprzed rozpoczęcia transackji

commit
-- zatwierdza nam zmiany w środki transakcji

select *
from Pracownicy

-- constrains 
/* 
to warunku, ograniczenia w wprowadzaniu danych
- primary keys
- unique
- ilość znaków
- check
- typ danych 
- itp.
*/