-- Tworzenie nowej bazy danych
CREATE DATABASE RestaurantDB;

-- Użycie nowo utworzonej bazy danych
USE RestaurantDB;

-- Tworzenie tabeli przechowującej informacje o klientach
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny z automatycznym generowaniem wartości
    FirstName VARCHAR(30) NOT NULL, -- Imię klienta, do 30 znaków
    LastName VARCHAR(30) NOT NULL, -- Nazwisko klienta, do 30 znaków
    Email VARCHAR(255) UNIQUE NOT NULL, -- Adres e-mail klienta, maks. 255 znaków, musi być unikalny
    PhoneNumber VARCHAR(15) NOT NULL CHECK (PhoneNumber LIKE '[0-9]%'), -- Numer telefonu, sprawdzany pod kątem tylko cyfr
    JoinDate DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE) -- Data dołączenia klienta, domyślnie dzisiejsza
);

-- Tworzenie tabeli przechowującej informacje o pracownikach
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny z automatycznym generowaniem wartości
    FirstName VARCHAR(30) NOT NULL, -- Imię pracownika
    LastName VARCHAR(30) NOT NULL, -- Nazwisko pracownika
    Position VARCHAR(20) NOT NULL, -- Stanowisko (np. kelner, kucharz), do 20 znaków
    HireDate DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE), -- Data zatrudnienia, domyślnie dzisiejsza
    Salary DECIMAL(10, 2) NOT NULL -- Wynagrodzenie z dokładnością do 2 miejsc po przecinku
);

CREATE TABLE Dishes (
    DishID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny, unikalny identyfikator dania
    DishName VARCHAR(50) NOT NULL, -- Nazwa dania, do 50 znaków
    Price DECIMAL(8, 2) NOT NULL, -- Cena dania z dokładnością do groszy
    Category VARCHAR(20) NOT NULL, -- Kategoria dania (np. pizza, deser), do 20 znaków
    QuantityAvailable INT NOT NULL DEFAULT 0 -- Liczba dostępnych sztuk (0 - brak dostępnych)
);

-- Tworzenie tabeli przechowującej zamówienia klientów
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny dla zamówień
    CustomerID INT NOT NULL, -- Klucz obcy, wskazuje klienta
    EmployeeID INT NOT NULL, -- Klucz obcy, wskazuje pracownika, który obsługiwał zamówienie
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(), -- Data i godzina złożenia zamówienia
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Relacja do tabeli Customers
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) -- Relacja do tabeli Employees
);

-- Tworzenie tabeli przechowującej szczegóły zamówień
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny dla szczegółów zamówienia
    OrderID INT NOT NULL, -- Klucz obcy, wskazuje zamówienie
    DishID INT NOT NULL, -- Klucz obcy, wskazuje danie
    Quantity INT NOT NULL, -- Ilość zamówionego dania
    UnitPrice DECIMAL(8, 2) NOT NULL, -- Cena jednostkowa dania w momencie zamówienia
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), -- Relacja do tabeli Orders
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID) -- Relacja do tabeli Dishes
);

-- Tworzenie tabeli przechowującej informacje o dostawcach
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny dla dostawców
    SupplierName VARCHAR(50) NOT NULL, -- Nazwa dostawcy, do 50 znaków
    ContactEmail VARCHAR(255), -- Adres e-mail dostawcy, maks. 255 znaków
    ContactPhone VARCHAR(15) NOT NULL -- Numer telefonu dostawcy
);

-- Tworzenie tabeli przechowującej informacje o składnikach
CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny dla składników
    IngredientName VARCHAR(50) NOT NULL, -- Nazwa składnika, do 50 znaków
    SupplierID INT NOT NULL, -- Klucz obcy, wskazuje dostawcę składnika
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) -- Relacja do tabeli Suppliers
);

-- Tworzenie tabeli przechowującej informacje o stanie magazynowym
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1), -- Klucz główny dla stanu magazynowego
    IngredientID INT NOT NULL, -- Klucz obcy, wskazuje składnik w magazynie
    QuantityInStock DECIMAL(10, 2) NOT NULL, -- Ilość składnika w magazynie z dokładnością do dwóch miejsc po przecinku
    LastUpdated DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE), -- Data ostatniej aktualizacji stanu magazynowego
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID) -- Relacja do tabeli Ingredients
);


-- Dodawanie przykładowych danych do tabeli Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber)
VALUES 
('John', 'Doe', 'john.doe@example.com', '555123456'),
('Jane', 'Smith', 'jane.smith@example.com', '555654321'),
('Alice', 'Johnson', 'alice.j@example.com', '555987654'),
('Bob', 'Brown', 'bob.b@example.com', '555876543'),
('Charlie', 'Taylor', 'charlie.t@example.com', '555765432');

-- Dodawanie przykładowych danych do tabeli Employees
INSERT INTO Employees (FirstName, LastName, Position, Salary)
VALUES 
('Emma', 'Williams', 'Waiter', 3250.00),
('Oliver', 'Jones', 'Chef', 2500.00),
('Sophia', 'Brown', 'Manager', 6000.00),
('Liam', 'Davis', 'Waiter', 3250.00),
('Mia', 'Garcia', 'Cleaner', 2250.00);

INSERT INTO Dishes (DishName, Price, Category, QuantityAvailable)
VALUES 
('Margherita Pizza', 12.99, 'Pizza', 10), -- 10 sztuk dostępnych
('Caesar Salad', 8.25, 'Salad', 5), -- 5 sztuk dostępnych
('Grilled Chicken', 15.00, 'Main Course', 0), -- Brak sztuk dostępnych
('Spaghetti Carbonara', 13.25, 'Pasta', 20), -- 20 sztuk dostępnych
('Chocolate Cake', 6.25, 'Dessert', 2); -- 2 sztuki dostępne


-- Dodawanie przykładowych danych do tabeli Suppliers
INSERT INTO Suppliers (SupplierName, ContactEmail, ContactPhone)
VALUES 
('Fresh Veggies Co.', 'contact@freshveggies.com', '123456789'),
('Meat Lovers Supply', 'info@meatlovers.com', '987654321'),
('Dairy Delight', 'support@dairydelight.com', '555555555'),
('Gourmet Spices', 'spices@gourmet.com', '444333222'),
('Seafood Suppliers', 'seafood@suppliers.com', '333222111');

-- Dodawanie przykładowych danych do tabeli Ingredients
INSERT INTO Ingredients (IngredientName, SupplierID)
VALUES 
('Tomato', 1),
('Chicken', 2),
('Cheese', 3),
('Salt', 4),
('Fish', 5);

-- Dodawanie przykładowych danych do tabeli Inventory
INSERT INTO Inventory (IngredientID, QuantityInStock)
VALUES 
(1, 500.00), 
(2, 200.00), 
(3, 300.00), 
(4, 100.00), 
(5, 50.00);

-- Dodawanie 50 rekordów do tabeli Orders
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
    VALUES 
    (
        (@i % 5) + 1, -- Cykl dla CustomerID (od 1 do 5)
        (@i % 5) + 1, -- Cykl dla EmployeeID (od 1 do 5)
        DATEADD(DAY, -@i, GETDATE()) -- Daty złożenia zamówień od dziś wstecz
    );
    SET @i = @i + 1;
END;

-- Dodawanie rekordów do tabeli OrderDetails dla każdego zamówienia
DECLARE @OrderID INT = 1;

WHILE @OrderID <= 50
BEGIN
    INSERT INTO OrderDetails (OrderID, DishID, Quantity, UnitPrice)
    VALUES 
    (
        @OrderID, -- Powiązanie z tabelą Orders
        (@OrderID % 5) + 1, -- Cykl dla DishID (od 1 do 5)
        CEILING(RAND() * 5), -- Losowa ilość od 1 do 5
        (RAND() * 20) + 5 -- Losowa cena od 5.00 do 25.00
    ),
    (
        @OrderID, -- Drugi rekord dla każdego zamówienia
        ((@OrderID + 1) % 5) + 1, -- Cykl dla DishID (od 1 do 5)
        CEILING(RAND() * 5), -- Losowa ilość od 1 do 5
        (RAND() * 20) + 5 -- Losowa cena od 5.00 do 25.00
    );
    SET @OrderID = @OrderID + 1;
END;

-- Poznanie bazy danych 
select top 10 * from Customers;
select top 10 * from Dishes;
select top 10 * from Employees;
select top 10 * from Ingredients;
select top 10 * from Inventory;
select * from Orders;
select * from OrderDetails;
select top 10 * from Suppliers;

