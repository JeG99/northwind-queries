USE Northwind

-- 1. Nombre del producto, nombre del proveedor y nombre de la categoria
-- ProductName, SupplierName, CategoryName
SELECT ProductName, CompanyName, CategoryName
FROM Products p INNER JOIN Suppliers s ON (p.SupplierID = s.SupplierID) 
				INNER JOIN Categories c ON (p.CategoryID = c.CategoryID);

-- 2. nombre del cliente, numero de la orden y fechade la orden  para los  clientes  que viven en NY
-- CompanyName, orderID, OrderDate for customers who live in NY
SELECT c.CompanyName, o.OrderID, o.OrderDate
FROM Customers c INNER JOIN Orders o ON (c.CustomerID = o.CustomerID)
WHERE c.City = 'NY' OR c.City = 'New York';
	
-- 3. nombre de los empleados, numero de orden que atienden, fecha orden, para empleados nacidos antes de 1990 y contratados despues de 2010
-- Employee firstname and lastname, orderID, orderDate, for employees born before 1990, and hired after 2010
SELECT e.FirstName, e.LastName, o.OrderID, o.OrderDate
FROM Employees e, Orders o 
WHERE e.EmployeeID = o.EmployeeID AND YEAR(e.BirthDate) < 1990 AND YEAR(e.HireDate) > 2010;

-- 4. Nombre del empleado y nombre de su supervisor
-- Name of employee and name of supervisor
SELECT e1.FirstName, e1.LastName, e2.FirstName, e2.LastName
FROM Employees e1 INNER JOIN Employees e2 ON (e1.ReportsTo = e2.EmployeeID);

-- 5. Ciudades donde viven al menos un empleados y un cliente
-- Cities with at least one employee and one client
SELECT DISTINCT City
FROM Customers
	INTERSECT
SELECT DISTINCT City
FROM Employees;

-- 6. Ciudades donde hay clientes pero no hay empleados
-- cities with clients and no employees
SELECT DISTINCT City
FROM Customers
	EXCEPT
SELECT DISTINCT City
FROM Employees;

-- 7. listar product id, product name, quantity, amount paid  (discount is a percentage)
-- productID, ProductName, quantity, amount paid
SELECT o.ProductID, p.ProductName, o.Quantity, (o.Quantity * p.UnitPrice)*(1 - o.Discount)
FROM Products p INNER JOIN [Order Details] o ON (p.ProductID = o.ProductID);

-- 8. nombres de los productos que no se han vendido 
-- product names that have not been sold
-- π ProductName (Products) - π ProductName (Products ⨝ (Orders ⨝ π OrderID, ProductID (OrderDetails)))
SELECT p.ProductName
FROM Products p
	EXCEPT
SELECT p.ProductName
FROM Products p INNER JOIN (Orders o INNER JOIN (SELECT OrderID, ProductID FROM [Order Details]) od ON (o.OrderID = od.OrderID)) ON (od.ProductID = p.ProductID)

















