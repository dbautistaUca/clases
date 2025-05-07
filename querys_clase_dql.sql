--COLUMNAS
SELECT BusinessEntityID,FirstName,LastName FROM Person.Person p

SELECT *  FROM Person.Person p

SELECT BusinessEntityID,FirstName,LastName,* FROM Person.Person p

SELECT OrderQty * -1, OrderQty,ABS(OrderQty * -1) FROM Sales.SalesOrderDetail sod 

SELECT  datename( month , ModifiedDate ), ModifiedDate FROM Sales.SalesOrderDetail sod 

SELECT distinct datename( month , ModifiedDate ) FROM Sales.SalesOrderDetail sod 

--CONDICIONES

SELECT * FROM Sales.SalesOrderHeader soh where TotalDue <= 50.0 and month(OrderDate ) = 6

SELECT * FROM Sales.SalesOrderHeader soh where TotalDue <= 50.0 and not ( month(OrderDate ) = 6 )

--ORDENAMIENTO 

SELECT BusinessEntityID,FirstName,LastName FROM Person.Person p    

SELECT BusinessEntityID,FirstName,LastName FROM Person.Person p order by LastName desc

--JOINS

SELECT p.Name ,sod.* FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
where p.ProductID = 738
order by sod.SalesOrderID asc;