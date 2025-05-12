/*Empleado por departamento
nombre --
titulo --HumanResources.Employee -> JobTitle
departamento --Empleado por departamento -> D
Department->Name
fecha de inicio --EmployeeDepartmentHistory -> StartDate
*/
/*
Empleado por departamento
nombre -- Person.Person.FirstName , Person.Person.LastName
titulo -- HumanResources.Employee.JobTitle
departamento -- HumanResources.Department.Name
fecha de inicio -- HumanResources.EmployeeDepartmentHistory.StartDate
*/

SELECT concat(p.FirstName,' ',p.LastName) as nombre,e.JobTitle as "titulo de puesto",d.Name as departamento,edh.StartDate as fecha_inicio
FROM HumanResources.Employee e 
INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh ON 
	e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department d ON d.DepartmentID = edh.DepartmentID
WHERE edh.StartDate >= '2009-01-01' and edh.StartDate < '2010-01-01'
and d.DepartmentID = 10
order by d.Name asc;

SELECT d.Name as departamento,count(e.BusinessEntityID) as cantidad_empleados
FROM HumanResources.Employee e 
INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh ON 
	e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department d ON d.DepartmentID = edh.DepartmentID
WHERE edh.StartDate >= '2009-01-01' and edh.StartDate < '2010-01-01'
GROUP BY d.Name
HAVING count(e.BusinessEntityID) <= 3
order by d.Name asc;



select * from HumanResources.Department d where d.Name = 'Finance'
