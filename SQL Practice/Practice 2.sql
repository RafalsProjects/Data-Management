--SELECT * from Orders 
--WHERE OrderDate = '1997-05-19'

-- 15. Ktory klient - nazwa - ile lacznie zaplacil
select sum(UnitPrice*Quantity) as aggregated_value, 
CompanyName 
from [Order Details] 
left join Orders on [Order Details].OrderID = [Orders].OrderID
left join Customers on [Orders].CustomerID = [Customers].CustomerID
group by CompanyName;

-- 16. Zamowienia ktore zostaly wyslane w innym roku niz zamowione
SELECT OrderID, OrderDate, ShippedDate from [Orders]
WHERE (year(OrderDate) != YEAR(ShippedDate));

-- 17. Ktory klient z UK zapalcil ponad 1000
select CompanyName, Orders.OrderID, Quantity*UnitPrice as order_value from Customers
left join Orders on [Customers].CustomerID = [Orders].CustomerID
left join [Order Details] on [Orders].OrderID = [Order Details].OrderID
WHERE Country = 'UK' and (Quantity*UnitPrice) > 1000;

-- 18. 10 najlepiej sprzedajacych sie produktow
select [Products].ProductID, ProductName, sum(Quantity*[Products].UnitPrice) as Value_of_order, sum(Quantity) as sum_quantity 
from Products
left join [Order Details] on [Products].ProductID = [Order Details].[ProductID]
group by [Products].ProductID, ProductName
order by sum(Quantity*[Products].UnitPrice) desc;

select [Products].ProductID, ProductName, sum(Quantity*[Products].UnitPrice) as Value_of_order, sum(Quantity) as sum_quantity 
from Products
left join [Order Details] on [Products].ProductID = [Order Details].[ProductID]
group by [Products].ProductID, ProductName
order by sum(Quantity) desc;

-- 19. Ile produktow zostalo wycofanych

SELECT ProductID 
FROM [Order Details] 
WHERE ProductID NOT IN (SELECT ProductID FROM [Products])
group by productId;

-- 20. Napisz zapytanie wykorzystujace select, join, from, where, group by, having i order, ktore zwraca wiersze i powiedz co robi
select top(2) * from Customers
select top(2) * from [Orders]
select top(2) * from [Order Details]

SELECT top(2) * from Products

SELECT Customers.CompanyName, AVG(Quantity * UnitPrice) AS Avg_Value_Order
-- Wybieramy kolumny CompanyName i liczymy średnią wartość zamówienie
FROM Customers
-- z tabeli / bazy Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
-- łączymy tabele / baze Customer z Orders po kolumnie CustomerID
LEFT JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
-- łączymy tabele / baze Customer, Orders z baza tabelą Order Details po kolumnie OrderID 
GROUP BY Customers.CompanyName
-- grupuj po CompanyName (czyli dla każdej firmy średnią)
HAVING AVG(Quantity * UnitPrice) > 1000
-- mających średnią zamówienia powyżej 1000
ORDER BY Avg_Value_Order desc;
-- sortując od największego do najmniejszego 

