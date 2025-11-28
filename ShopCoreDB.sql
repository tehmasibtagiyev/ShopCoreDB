
USE ShopCoreDB

CREATE TABLE OrderProducts
(
orderID INT FOREIGN KEY REFERENCES Orders(Id),
productID INT FOREIGN KEY REFERENCES Products(Id)
)

CREATE TABLE Stu
(
Id INT PRIMARY KEY,
[Name] NVARCHAR(20),
[Subject] NVARCHAR(25),
Mark INT
)

-- ========================

SELECT * FROM Payments
DROP TABLE Payments 
DELETE FROM Payments
TRUNCATE TABLE Payments
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Payments
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Payments 
FOREIGN KEY (paymentID) REFERENCES Payments(Id)
INSERT INTO Payments VALUES
('With Credit Card'),
('With Personal Card'),
('With ATM')

-- ========================

SELECT * FROM Baskets
--Added data

-- ========================

SELECT * FROM Categories
INSERT INTO Categories VALUES
('Computers', 'Computer is a programmable electronic'),
('Phones', 'Phone is a telecommunications device'),
('Clothes', 'Clothes description explains what an item'),
('Kitchenware', 'Kitchenware refers to the tools')

-- ========================
SELECT * FROM Customers
ALTER TABLE Customers ALTER COLUMN [Password] NVARCHAR(20) -- failed
ALTER TABLE Customers DROP CONSTRAINT FK_Customers_Baskets
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers
ALTER TABLE Customers DROP CONSTRAINT Check_Password
ALTER TABLE Customers ALTER COLUMN [Password] CHAR(8) -- changed
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (customerID) REFERENCES Customers(Id)
ALTER TABLE Customers ADD CONSTRAINT FK_Customers_Baskets
FOREIGN KEY (basketID) REFERENCES Baskets(ID)
ALTER TABLE Orders DROP COLUMN Amount
UPDATE Customers SET Customers.[Password] = NULL
TRUNCATE TABLE Customers

INSERT INTO Customers ([Name], Email, [Password], basketID) VALUES
('Tehmasib', 'tahmasibmt8@gmail.com','tagiyev', 8), 
('Nofel', 'nofelbagi20@gmail.com', 'bagirov2', 5),
('Emil', 'e.abbasov3645@gmail.com', 'abbsv36', 3),
('Emil', 'zeynalzade@gmail.com', 'emil518', 1),
('Xeyal', 'tagiyevxeyal@gmai.com', 'tagizade', 10),
('Taleh', 'qtaleh30@gmail.com', 'taleh45', 7),
('Elvin', 'elvn@gmail.com', 'elvin456', 2),
('Cavidan', 'cvdnhasnli5@gmail.com', 'hesenli5', 4),
('Aynure', 'tagiyeva@gmail.com', 'tagiyeva', 9),
('Tehmine', 'thmn4tagi8@gmail.com', 'thmine9a', 6)

-- ========================
SELECT * FROM Products
INSERT INTO Products VALUES
('ASUS ZENBook', 3289, 'A line of premium, thin, and light laptops', 1),
('Trousers', 56, 'Could refer to two very different things', 3),
('Refrigerator', 8129, 'A refrigerator is an appliance that cools food', 4),
('Iphone 16 Pro', 2960, 'Features a larger 6.3-inch Super Retina XDR display', 2),
('Samsung S24 FE', 4420, 'Snap it, circle it, tap it – discover why it', 2),
('T-Shirt', 190.5, 'Lightweight, typically cotton-knit pullover', 3),
('Washing machine', 7930, 'Appliance that automatically cleans clothes using water',4),
('Acer I7', 2366, 'Taiwanese multinational company that manufactures', 1)

-- ========================
SELECT * FROM Orders
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Payments
ALTER TABLE OrderProducts DROP CONSTRAINT FK__OrderProd__order__76969D2E
TRUNCATE TABLE Orders
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (customerID) REFERENCES Customers(Id)
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Payments
FOREIGN KEY (paymentID) REFERENCES Payments(Id)
ALTER TABLE OrderProducts ADD CONSTRAINT FK__OrderProd__order__76969D2E
FOREIGN KEY (orderID) REFERENCES Orders(Id)

INSERT INTO Orders VALUES
('2025-11-10 21:39:28', 9, 3),
('2025-11-10 15:21:47', 1, 1),
('2025-11-07 10:20:56', 5, NULL),
('2025-11-19 11:18:36', 2, 3),
('2025-11-24 09:07:01', 8, 1),
('2025-11-03 12:15:05', 3, NULL),
('2025-11-16 17:46:22', 10, 2),
('2025-11-29 21:39:00', 4, 2),
('2025-10-08 14:32:40', 6, 1),
('2025-10-18 16:55:00', 7, Null) 

-- ===========================

ALTER TABLE OrderProducts DROP CONSTRAINT FK__OrderProd__order__76969D2E 
ALTER TABLE OrderProducts DROP CONSTRAINT FK__OrderProd__produ__778AC167
TRUNCATE TABLE OrderProducts
ALTER TABLE OrderProducts ADD CONSTRAINT FK__OrderProd__order__76969D2E
FOREIGN KEY (orderID) REFERENCES Orders(Id)
ALTER TABLE OrderProducts ADD CONSTRAINT FK__OrderProd__produ__778AC167
FOREIGN KEY (productID) REFERENCES Products(Id)

-- Let's start the calculations
-- Orders
SELECT * FROM Orders
SELECT * FROM Orders WHERE paymentID IS NULL
SELECT * FROM Orders WHERE paymentID IS NOT NULL
SELECT COUNT(*) FROM Orders WHERE paymentID IS NULL
SELECT COUNT(*) FROM Orders WHERE paymentID IS NOT NULL
SELECT c.Id, c.[Name], c.Email, c.[Password], o.[Date], o.Id, p.* FROM Orders o
JOIN Customers c
ON o.customerID = c.Id
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NULL 

SELECT c.Id, c.[Name], c.Email, c.[Password], o.[Date], o.Id, p.* FROM Orders o
JOIN Customers c
ON o.customerID = c.Id
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NOT NULL 

SELECT p.Id, p.[Name], p.Price, pay.PayType FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
JOIN Payments pay
ON pay.Id = o.paymentID
WHERE paymentID IS NOT NULL

SELECT COUNT(p.Id) FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NOT NULL

SELECT SUM(p.Price) / COUNT(p.Price) AS Average FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NOT NULL

SELECT AVG(p.Price) AS Average FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NOT NULL

SELECT SUM(p.Price)  FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NOT NULL

SELECT SUM(p.Price) - 
(SELECT SUM(p.Price) FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NULL) FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NOT NULL

SELECT SUM(p.Price) FROM Orders o
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE paymentID IS NULL

-- Customers
SELECT SUM(p.Price) FROM Customers c
JOIN Orders o
ON o.customerID = c.Id 
JOIN OrderProducts op
ON op.orderID = o.Id
JOIN Products p
ON p.Id = op.productID
WHERE c.[Name] = 'Xeyal'

-- Products
SELECT * FROM Products
SELECT MAX(Price) FROM Products
SELECT MIN(Price) FROM Products

SELECT * FROM Products 
WHERE Price >= ALL(SELECT p.Price FROM Products p)

SELECT * FROM Products p
WHERE p.Price > ANY(SELECT pp.Price FROM Products pp)

SELECT * FROM Products p WHERE
p.Price >= ALL(
SELECT pp.Price FROM Products pp)

SELECT * FROM Products p 
WHERE p.Price <= ALL
(SELECT pp.Price FROM Products pp
WHERE p.categoryID = pp.categoryID)

-- UNION, UNION ALL, INTERSECT and EXCEPT

SELECT Id FROM Products
UNION 
SELECT Id FROM Customers

SELECT [PayType] FROM Payments
UNION ALL 
SELECT Descriptioin FROM Categories

SELECT COUNT(*) FROM 
(
SELECT [Name] FROM Products
UNION ALL 
SELECT [Name] FROM Customers
)A

SELECT orderID FROM OrderProducts
INTERSECT
SELECT Id FROM Orders

SELECT Descriptioin FROM Categories
EXCEPT
SELECT [Name] FROM Products

SELECT orderID FROM OrderProducts
EXCEPT
SELECT Id FROM Payments

-- CASE
SELECT * FROM Orders
SELECT * FROM Payments
SELECT o.Id, o.[Date], paymentID ,
CASE
   WHEN p.PayType LIKE '%ATM%' THEN 'The orders payed with ATM'
   WHEN p.PayType LIKE '%Personal%' THEN 'The orders payed with Personal Card'
   WHEN p.PayType LIKE '%Credit%' THEN 'The orders payed with Credit Card'
   ELSE 'The orders payed cash'
END AS 'Paying Types'
FROM Orders o 
FULL JOIN Payments p
ON p.Id = o.paymentID 
ORDER BY o.customerID 

-- TOP 
SELECT TOP 3 * FROM Orders
ORDER BY [Date] DESC

SELECT COUNT(*) FROM Orders

SELECT TOP 5 PERCENT * FROM Orders
ORDER BY Id 

-- ============================
-- INNER JOIIN 
SELECT * FROM Products p
JOIN Categories c
ON c.Id = p.Id

SELECT * FROM Products p
LEFT JOIN Categories c
ON p.Id = c.Id

SELECT * FROM Categories c
LEFT JOIN Products p
ON p.Id = c.Id

SELECT * FROM Categories c
RIGHT JOIN Products p
ON p.Id = c.Id

SELECT * FROM Products p
RIGHT JOIN Categories c
ON c.Id = p.Id

SELECT * FROM Products p
FULL JOIN Categories c
ON c.Id = p.Id

SELECT * FROM Categories c
FULL JOIN Products p
ON p.Id = c.Id

-- WITH RELATION
SELECT * FROM Products p
RIGHT  JOIN Categories c
ON p.categoryID = c.Id

UPDATE Categories 
SET Categories.[Name] = p.[Name]
FROM Categories c
JOIN Products p
ON c.Id = p.categoryID
WHERE c.Id IN(2,3,4)

UPDATE Categories SET [Name] = 'Phones' 
WHERE [Name] LIKE '%16%'

UPDATE Categories SET [Name] = 'Clothes' 
WHERE [Name] LIKE '%Sh%'

UPDATE Categories SET [Name] = 'Kitchenware'
WHERE [Name] LIKE '[R,a,b]%'

SELECT * FROM Categories

SELECT [Name] FROM Products
WHERE Id > 4 AND Price < 5000

DELETE Categories FROM Categories c
JOIN Products p
ON p.Id = c.Id
WHERE c.Id = 6
SELECT * FROM Categories

SELECT TOP(5) Id, [Name] FROM Products
ORDER BY Id DESC

SELECT DISTINCT categoryID, [Name]  FROM Products
SELECT SUM(DISTINCT categoryID) FROM Products

--==============================
-- GROUP BY, HAVING, ORDER BY
SELECT * FROM Products
SELECT [Name], SUM(Price) FROM Products
GROUP BY [Name]

SELECT * FROM OrderProducts
SELECT  productID, COUNT(*) Total_Count FROM OrderProducts
GROUP BY  productID

SELECT * FROM Stu
SELECT [Subject], MAX(Mark) FROM Stu
GROUP BY [Subject]

SELECT [Name], SUM(Mark) FROM Stu
GROUP BY [Name]
HAVING [Name] = 'PQR'

SELECT [Name], SUM(Mark) FROM Stu
GROUP BY [Name]
HAVING SUM(Mark) > 150

SELECT SUM(Mark) FROM Stu HAVING SUM(Mark) > 88

SELECT * FROM Products
ORDER BY 3

SELECT * FROM Orders
SELECT ASCII(Price) FROM Products
SELECT UNICODE([Name]) FROM Products
SELECT CHARINDEX('a', [Name]) FROM Products
SELECT CONCAT([Name],'--',[Password]) FROM Customers
SELECT CONCAT_WS('--',[Name],[Password]) FROM Customers
SELECT LEFT(Price, 3) FROM Products
SELECT LEFT_SHIFT(4, 3)
SELECT Id * 2 FROM Products

















