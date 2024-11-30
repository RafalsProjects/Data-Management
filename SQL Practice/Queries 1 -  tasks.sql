-- 1. Proszę podać imię i nazwisko pracownika i jego szefa, w efekcie chce miec 2 kolumny - szef i pracownik

select p.FirstName + ' ' + p.LastName as Pracownik,
sz.FirstName + ' ' + sz.LastName as Szef
from [dbo].[Employees] as p
left join [dbo].[Employees] as sz on p.ReportsTo = sz.EmployeeID

-- 2. Dla każdego pracownika - imię i nazwisko - i pierwsza data po orderdate
select e.FirstName, e.LastName, MIN(o.orderdate) as [PierwszeZamowienie]
from [dbo].[Orders] o
join Employees  e on o.EmployeeID=e.EmployeeID
group by e.FirstName, e.LastName

-- 3. Dla każdego pracownika - imię i nazwisko - i pierwsza data po orderdate + orderid

select a.* , STRING_AGG(OrderID, ', ')  from (
select e.FirstName, e.LastName, MIN(o.orderdate) as [PierwszeZamowienie]
from [dbo].[Orders] o
join Employees  e on o.EmployeeID=e.EmployeeID
group by e.FirstName, e.LastName 
) as a
join  Orders o on a.PierwszeZamowienie = o.OrderDate
group by FirstName, LastName, [PierwszeZamowienie]


-- 4. W którym roku było najwięcej zamówień, po order date - liczba

select YEAR(orderdate) 'Rok zamowienia' , COUNT(*) [Liczba zamowien] from [dbo].[Orders]
group by YEAR(orderdate)

-- 5. W którym roku miesiącu było najwięcej zamówień wysłanych, po ship date - liczba

select 
YEAR(ShippedDate) 'Rok zamowienia' ,
month(ShippedDate) 'Miesiac zamowienia' ,
COUNT(*) [Liczba zamowien] 
from [dbo].[Orders]
group by YEAR(ShippedDate), month(ShippedDate)
order by 3 desc

-- 6. Lista zamówień, po przecinku dla każdego pracownika

select EmployeeID, STRING_AGG( orderid, '/') from Orders
group by EmployeeID

-- 7. Pierwsze i ostatnie zamówienie


select * from  [dbo].[Orders]
where OrderID = (select MIN(orderid) from [dbo].[Orders])

union 

select * from  [dbo].[Orders]
where OrderID = (select max(orderid) from [dbo].[Orders])

-- 8. Wszystkie zamówienia złożone 19 Maja 1997

select * from [dbo].[Orders]
where OrderDate = '19970519'


-- 9. Raport pokazujący liczbę pracowników i klientów z poszczególnych miast

select m.City, isnull(Pracownik,0) as [Liczba Pracownikow], Klient as [Liczba klientow] from (
select City from [dbo].[Employees]
union 
select City  from [dbo].[Customers]
) as m
left join (
	select City, COUNT(*) Pracownik  from [dbo].[Employees]
	group by City
) p on p.City=m.City
left join (
	select City, COUNT(*) Klient  from [dbo].[Customers]
	group by City
) k on k.City=m.City

-- 10. Który klient nie złożył zamówienia

select * from [dbo].[Customers]
where CustomerID not in (
select distinct CustomerID from [dbo].[Orders] -- lista klientow ktorzy zlozyli zamowienie
)

select c.* from [dbo].[Customers] c
left join [Orders] o on c.CustomerID=o.CustomerID
where o.CustomerID is null

-- 11. Zestawienie pokazujące order id i imie i nazwisko pracownika dla zamowien wyslanych po terminie

select OrderID, firstname, lastname from Orders o
join Employees e on e.EmployeeID=o.EmployeeID
where o.ShippedDate > o.RequiredDate

-- 12. Sredni czas wysylki zamowienia

select avg(CONVERT( float, shippeddate-orderdate))
from Orders
where ShippedDate is not null

-- 13. Sredni czas wysylki zamowienia, jezeli jest opoznione

select avg(CONVERT( float, shippeddate-orderdate))
from Orders
where ShippedDate is not null and ShippedDate > RequiredDate

-- 14. Laczny przychod w 1997

select SUM(unitprice * quantity) from [dbo].[Order Details] od
join Orders o on o.OrderID=od.OrderID
where YEAR(OrderDate)= 1997

-- 15. Ktory klient - nazwa - ile lacznie zaplacil

-- 16. Zamowienia ktore zostaly wyslane w innym roku niz zamowione

-- 17. Ktory klient z UK zapalcil ponad 1000

-- 18. 10 najlepiej sprzedajacych sie produktow

-- 19. Ile produktow zostalo wycofanych

-- 20. Napisz zapytanie wykorzystujace select, join, from, where, group by, having i order, ktore zwraca wiersze i powiedz co robi