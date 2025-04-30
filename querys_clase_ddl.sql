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

--use master;

drop table libro;

select * from clase.dbo.libro;

alter table libro add descripcion text null;

alter table libro add autor_id bigint null;

alter table libro add constraint fk_autor_libro foreign key (autor_id) references autor(id);
