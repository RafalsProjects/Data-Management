select *
from pracownicy
where pensja > 2000
order by staż desc;

insert into pracownicy (imie, nazwisko, pensja, staz) -- dodaje do tabeli pracownicy rekord (wiers) zawierający dane pojedynczego pracownika
values ('Jan', 'Kowalski', 5500, 1);

update pracownicy
set pensja = pensja * 1.1
where staż >2;

select * from dbo.employees -- Wybieramy dbo.employees
where City ='London' -- gdzie City = 'London'

select * from dbo.employees
where City = 'London' and HireDate between '1993-01-01' and '1993-12-31'

select * from dbo.employees
where City = 'London' and year(HireDate) = 1993

-- year() -- to funkcja year()

-- Chcemy poszukać osób, które nie podlegają nikomu. Czyli np. wartość NULL (to zależy od tabeli)
select * from dbo.employees 
where ReportsTo is NULL -- Null to nie wartosć pusta i musimy użyć "is"

-- Przeciwieństwo czyli osoby które komuś podlegają 
select * from dbo.employees
where ReportsTo is not NULL -- Null to nie wartosć pusta i musimy użyć "is"

-- Zobaczyć wszystkich którzy są z USA
select * from dbo.employees
where Country = 'USA'

select * from dbo.employees
where TitleOfCourtesy = 'Ms.'

select * from dbo.employees
where Country = 'USA' or TitleOfCourtesy = 'Ms.'

-- Kolejność wysyłania zapytań
select * from dbo.employees
where (Country ='USA' and ReportsTo is not null) or TitleOfCourtesy = 'Ms.')

select * from dbo.employees
where Country ='USA' and (ReportsTo is not null or TitleOfCourtesy = 'Ms.')

-- Dzień 2
-- Klienci którzy pochodzą z Mexico UK i Niemczech
select * from dbo.customers 
where Country = 'Mexico' or Country = 'UK' or Country = 'Germany' -- or jest wolne i nie jest to najkepszy sposób tworzenia zapytania

select * from dbo.customers 
where Country in ('Mexico', 'UK', 'Germany') -- jest to szybszy sposób rozwiązani problemu 

-- Klienci których firma zaczyna sie na literę A
select * from dbo.Customers
where CompanyName like 'A%'

-- przeciwieńśtwko
-- Klienci których firma zaczyna sie na literę A
select * from dbo.Customers
where CompanyName not like 'A%'

-- Klienci których firma zawiera literę A
select * from dbo.Customers
where CompanyName like '%a%' -- mała czy duża litera nie ma znaczenia

-- Przeciwieństwo
select * from dbo.Customers
where CompanyName not like '%a%' -- mała czy duża litera nie ma znaczenia

-- Klienci których firma kończy się na literę A
select * from dbo.Customers
where CompanyName like '%a' -- mała czy duża litera nie ma znaczenia

-- Przeciwieństwo
select * from dbo.Customers
where CompanyName not like '%a' -- mała czy duża litera nie ma znaczenia

-- Konkretne dane o konkretnej długośći 
select * from dbo.Customers 
where len(PostalCode) = 4 -- wyświetla nam rekordy w których PostalCode ma długość 4 znaków

-- Wybieranie konkretnej tabeli i jej nazywanie (alias kolumny)
select EmployeeID, LastName, FirstName  from dbo.Employees

select EmployeeID, FirstName + ' ' + LastName as Full_name from dbo.Employees
select EmployeeID, FirstName + ' ' + LastName as 'Full name' from dbo.Employees
select EmployeeID, FirstName + ' ' + LastName Full_name from dbo.Employees
select EmployeeID, FirstName + ' ' + LastName 'Full name' from dbo.Employees

-- sortowanie
select  * from  dbo.Products
order by UnitPrice -- asc

select *from  dbo.Products
order by UnitPrice asc

select * from  dbo.Products
order by UnitPrice desc

-- Przedziały
select * from  dbo.Products
where UnitPrice > 10

select * from  dbo.Products
where UnitPrice < 10

select * from  dbo.Products
where UnitPrice = 10

select * from  dbo.Products
where UnitPrice >= 10

select * from  dbo.Products
where UnitPrice <= 10


-- sortowanie można użyć również z przedziałami
select * from  dbo.Products
where unitprice >= 10 order by UnitPrice desc 



-- Podzapytanie
select * from  dbo.Products
where Categoryid = 8 -- Seafood (8)

select *from dbo.Products
where CategoryID = (select CategoryID from dbo.Categories
where CategoryName = 'Seafood')

select *from dbo.Products
where CategoryID in (select CategoryID from dbo.Categories
where CategoryName in ('Seafood', 'Beverages'))


-- Agregacje (funkcje agregujące)
-- count() - liczy wiersze (rekordy)
-- min()
-- max()
-- sum()
-- avg()


select * from Employees

select country, count(*) from Employees
group by country

select country, city, count(*) as 'Liczba rekordów'
from Employees
group by country, city 

-- tylko te kraje i miasta gdzie mam wiecej niż jednego pracownika
select country, city, count(*) as 'Liczba rekordów'
from Employees
group by country, city 
having COUNT(*) > 1 -- Having to takie whare tylko dla funkcji agregujących


-- sumowanie freight i posortowanie po roku
select * from dbo.orders

select year(OrderDate) Rok, sum(Freight) 'Przewóz' from dbo.Orders
group by year(OrderDate)
order by 2 desc -- 1, 2, 3... itd. oznacz po której kolumnie sortujemy

-- inne opcje
select year(OrderDate) Rok, sum(Freight) 'Przewóz' from dbo.Orders
group by year(OrderDate)
order by sum(Freight) desc -- oznacza że sortujemy po kolumnie sum(Freight)

select year(OrderDate) Rok, sum(Freight) 'Przewóz' from dbo.Orders
group by year(OrderDate)
order by 'Przewóz' desc -- oznacza że sortujemy po kolumnie sum(Freight) 'Przewóz'

-- Ile klientów mam w Berilnie
select * from [dbo].[Customers]

select City, count(*) from [dbo].[Customers]
where City in ('Berlin')
group by City

-- Ile klientów jest z których miast w Niemczech
select * from [dbo].[Customers]

select City, count(*) from [dbo].[Customers]
where Country = 'Germany' 
group by City

-- Ile klientów jest z których miast w Francji
select * from [dbo].[Customers]

select City, count(*) from [dbo].[Customers]
where Country = 'France' 
group by City

-- Ile klientów jest z których miast w Francji gdzie więcej niż jeden klient danego miast
-- to jest też cała składan SQLowa więcej komend nie ma nie licząc joinów 
select City, count(*) 
from [dbo].[Customers]
where Country = 'France' 
group by City
having  count(*) > 1
order by 1 desc

-- liczenie i agregowanie

select *, UnitPrice*Quantity 'Kwota za zamówienie'  -- pokazuje wszystkie kolumny i rekordy dodatkowo dodaje kolumne zliczając kwotę za zamówienie
from dbo.[Order Details]

select sum(UnitPrice*Quantity) 'Łączna kwota za wszystkie zamówienia', -- Sumuje kowtę wszystkich zamówień
avg(UnitPrice*Quantity) 'Średnia kwota zamówienia', -- wylicza średnią ze wszystkich zamówień
min(UnitPrice*Quantity) 'Minimalna kwota zamównienie',
max(UnitPrice*Quantity) 'Maksymalna kwota zamówień'
from dbo.[Order Details]
