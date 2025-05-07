create database clase;

use clase;

drop table libro;

create table libro(
	id bigint identity
	,nombre varchar(1)
	,isbn text
	,constraint pk_libro
	primary key nonclustered (id)
);

drop table autor;

create table autor(
	id bigint identity primary key
	,nombre varchar(1)
	,apellido text
);

clase.dbo.autor

--use master;

drop table libro;

select * from clase.dbo.libro;

alter table libro add descripcion text null;

alter table libro add autor_id bigint null;

alter table clase.dbo.autor alter column nombre text null;

alter table libro add constraint fk_autor_libro foreign key (autor_id) references autor(id);

select * from clase.dbo.autor;

insert into clase.dbo.autor(nombre,apellido) values ('Miguel de','Cervantes');
insert into clase.dbo.autor(nombre,apellido) values ('William','Shakespeare');
insert into clase.dbo.autor(nombre,apellido) values ('Franz','Kafka');

update clase.dbo.autor
set nombre = 'Miguel'
,apellido = 'de Cervantes'
where id = 7;

--delete clase.dbo.autor --where id = 4;

select * from clase.dbo.libro

insert into clase.dbo.libro(nombre,autor_id) values ('Don Quijote de la Mancha',8);
insert into clase.dbo.libro(nombre,autor_id) values ('Hamlet',8);

insert into clase.dbo.libro(nombre,autor_id) values ('La metamorfosis',9);

insert into clase.dbo.libro(nombre,autor_id) values ('Libro desconocido',9);

select * from clase.dbo.libro

update clase.dbo.libro
set id = 2
where id = 6;

insert into clase.dbo.libro(autor_id,nombre)
select id,'La metamorfosis' from clase.dbo.autor where nombre like '%Franz%';

alter table clase.dbo.libro alter column nombre varchar(150) null;

select * from clase.dbo.autor

select * from clase.dbo.libro

update clase.dbo.libro 
set autor_id = 7
where id = 3;

select l.id,a.id,concat(l.nombre,' (',a.nombre , ' ', a.apellido,')') 
FROM clase.dbo.libro l
inner join clase.dbo.autor a on l.autor_id = a.id;
