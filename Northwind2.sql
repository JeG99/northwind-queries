-- 1. Id del proveedor y numero de productos que provée.
SELECT distinct p.SupplierID, COUNT(*) Products
FROM Products p
GROUP BY p.SupplierID;

-- 2. Nombre del producto y nombre del proveedor para los proveedores localizados en una ciudad cuya segunda letra sea  "o"
--     (Utilizar función CHARINDEX) ejemplo:
--     SELECT CHARINDEX('SQL', 'SQL Server CHARINDEX') position;
SELECT ProductName, CompanyName
FROM ((SELECT s.SupplierID, s.CompanyName, CHARINDEX('o', s.City) Position FROM Suppliers s) sup INNER JOIN Products p ON (p.SupplierID = sup.SupplierID)) 
WHERE sup.Position = 2;

-- 3. Nombre del producto que se ha vendido mas veces (utilizar cantidad  no ingreso)
SELECT ventas.ProductName
FROM (SELECT Quantity, ProductName FROM ([Order Details] od INNER JOIN Products p ON (od.ProductID = p.ProductID))) as ventas
WHERE ventas.Quantity = (SELECT MAX(Quantity) FROM [Order Details]);

-- 4a. Nombre del cliente(company name) y el  INGRESO total de sus compras (ignorar descuento)  ordenado de mayor a menor ingreso
SELECT CompanyName, SUM(Quantity * UnitPrice) Ingreso
FROM Customers c INNER JOIN ( SELECT o.CustomerID, Quantity, UnitPrice FROM Orders o INNER JOIN [Order Details] od ON (o.OrderID = od.OrderID)) orden ON (c.CustomerID = orden.CustomerID)
GROUP BY CompanyName
ORDER BY Ingreso;

-- 4b. Nombre del cliente(company name) y el  INGRESO total de sus compras (aplicar  descuento)   ordenado de mayor a menor ingreso
SELECT CompanyName, SUM((Quantity * UnitPrice) * (1 - Discount)) IngresoConDescuento
FROM Customers c INNER JOIN ( SELECT o.CustomerID, Quantity, UnitPrice, Discount FROM Orders o INNER JOIN [Order Details] od ON (o.OrderID = od.OrderID)) orden ON (c.CustomerID = orden.CustomerID)
GROUP BY CompanyName
ORDER BY IngresoConDescuento;

-- 5. Nombre del producto y el  TOTAL de ventas de ese producto en el año 1997  (listar solo aquellos productos con un ingreso total  mayor o igual a 10,000)  (ignorar descuento)    
SELECT *
FROM (
	SELECT distinct ProductName, SUM(Quantity * UnitPrice) Sales
	FROM Orders o INNER JOIN [Order Details] od ON (o.OrderID = od.OrderID) INNER JOIN (SELECT ProductID, ProductName FROM Products) p ON (od.ProductID = p.ProductID) 
	WHERE YEAR(OrderDate) = 1997
	GROUP BY ProductName
	--HAVING SUM(Quantity * UnitPrice) > 10000
) products
WHERE Sales >= 10000