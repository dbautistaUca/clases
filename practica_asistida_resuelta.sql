--crear base de datos practica_asistida
create database practica_asistida;

--cambiar de contexto a la base de practica_asistida
use practica_asistida;

--creación de tabla de empleados_por_region
create table empleados_por_region(
	id bigint identity primary key,
	nombre_region varchar(150),
	codigo_internacional varchar(4),
	cantidad_empleados_region int
);

--creación de tabla de empleados_offshore
create table empleados_offshore(
	id bigint identity primary key,
	BusinessEntityID bigint,
	titulo_de_posicion varchar(150),
	nombre_empleado varchar(150),
	numero_telefonico varchar(150),
	codigo_pais varchar(3)
);

--consulta para obtener los empleados por región
select cr.Name,cr.CountryRegionCode,count(e.BusinessEntityID)
from AdventureWorks.HumanResources.Employee e 
inner join AdventureWorks.Person.BusinessEntityAddress bea on e.BusinessEntityID = bea.BusinessEntityID
inner join AdventureWorks.Person.Address a on bea.AddressID = a.AddressID
inner join AdventureWorks.Person.StateProvince sp on a.StateProvinceID = sp.StateProvinceID
inner join AdventureWorks.Person.CountryRegion cr on sp.CountryRegionCode = cr.CountryRegionCode
group by cr.Name,cr.CountryRegionCode;

--insertar los registros de empleados por region en empleados_por_region basado en la consulta anterior
insert into empleados_por_region (nombre_region,codigo_internacional,cantidad_empleados_region) 
select cr.Name,cr.CountryRegionCode,count(e.BusinessEntityID)
from AdventureWorks.HumanResources.Employee e 
inner join AdventureWorks.Person.BusinessEntityAddress bea on e.BusinessEntityID = bea.BusinessEntityID
inner join AdventureWorks.Person.Address a on bea.AddressID = a.AddressID
inner join AdventureWorks.Person.StateProvince sp on a.StateProvinceID = sp.StateProvinceID
inner join AdventureWorks.Person.CountryRegion cr on sp.CountryRegionCode = cr.CountryRegionCode
group by cr.Name,cr.CountryRegionCode;

--verificando que lo que insertamos esta en la tabla
select * from empleados_por_region epr 

--consulta para obtener los empleados externos de estados unidos (offshore)
select e.BusinessEntityID,e.JobTitle,concat(p.FirstName,'-',p.LastName) as nombre_empleado,pp.PhoneNumber,cr.CountryRegionCode
from AdventureWorks.HumanResources.Employee e 
inner join AdventureWorks.Person.Person p on e.BusinessEntityID = p.BusinessEntityID
inner join AdventureWorks.Person.PersonPhone pp on p.BusinessEntityID = pp.BusinessEntityID
inner join AdventureWorks.Person.BusinessEntityAddress bea on e.BusinessEntityID = bea.BusinessEntityID
inner join AdventureWorks.Person.Address a on bea.AddressID = a.AddressID
inner join AdventureWorks.Person.StateProvince sp on a.StateProvinceID = sp.StateProvinceID
inner join AdventureWorks.Person.CountryRegion cr on sp.CountryRegionCode = cr.CountryRegionCode
where cr.CountryRegionCode <> 'US'
;

--insertar registros de consulta anterior a empleados_offshore
insert into empleados_offshore(BusinessEntityID,titulo_de_posicion,nombre_empleado,numero_telefonico,codigo_pais)
select e.BusinessEntityID,e.JobTitle,concat(p.FirstName,'-',p.LastName) as nombre_empleado,pp.PhoneNumber,cr.CountryRegionCode
from AdventureWorks.HumanResources.Employee e 
inner join AdventureWorks.Person.Person p on e.BusinessEntityID = p.BusinessEntityID
inner join AdventureWorks.Person.PersonPhone pp on p.BusinessEntityID = pp.BusinessEntityID
inner join AdventureWorks.Person.BusinessEntityAddress bea on e.BusinessEntityID = bea.BusinessEntityID
inner join AdventureWorks.Person.Address a on bea.AddressID = a.AddressID
inner join AdventureWorks.Person.StateProvince sp on a.StateProvinceID = sp.StateProvinceID
inner join AdventureWorks.Person.CountryRegion cr on sp.CountryRegionCode = cr.CountryRegionCode
where cr.CountryRegionCode <> 'US'
;

--verificar que hemos insertado los registros
select * from empleados_offshore;

--modificar la tabla de empleados offshore y agregar la columna de posible_disminucion
alter table empleados_offshore add posible_disminucion bit null;

--actualizar el campo de posible disminucion a los empleados provenientes de australia
--primero correr un select para identificar los registros a modificar
select * from empleados_offshore where codigo_pais = 'AU';

--identificando los registros que queremos editar, ejecutar el update
update empleados_offshore
set posible_disminucion = 1 
where codigo_pais = 'AU';

--verificamos que el registro que editamos tiene el bit 
select * from empleados_offshore;

--obtener el porcentaje que significan los empleados australianos sobre el total de empleados de la empresa
--para esta operacion vamos a ver el 100% de empleados de la empresa
select sum(cantidad_empleados_region)
from empleados_por_region epr; --290 empleados en total

--posteriormente vamos a dividir la población de región entre el total para ver el porcentaje por región
select ( cast(  cantidad_empleados_region as float ) / 290.0 ) * 100
from empleados_por_region epr
where codigo_internacional = 'AU'; --resulta ser el 0.34 % de la población total

--eliminar los registros de los empleados_offshore que hayan sido marcados como posible disminución
--identificamos el grupo que queremos eliminar
select * from empleados_offshore where posible_disminucion = 1;

--identificado el grupo aplicamos el delete
delete from empleados_offshore where posible_disminucion = 1;

--verificar que ya no se encuentra el grupo en la tabla
select * from empleados_offshore;
