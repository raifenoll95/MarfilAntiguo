--Publicado en azure

drop table Campa�as

create table Campa�as (

	empresa varchar(4) not null,
	id int IDENTITY(1,1) not null,
	fkseries varchar(3) not null,
	identificadorsegmento nvarchar(12),
	referencia varchar(15),
	fechadocumento datetime,
	asunto varchar(100),
	fechaultimoseguimiento datetime,
	fechaproximoseguimiento datetime,
	fketapa varchar(10),
	prioridad int,
	fkmodocontacto varchar(3),
	fkoperario varchar(15),
	fkcomercial varchar(15),
	fkagente varchar(15),
	notas varchar(max),
	coste int,
	cerrado bit,
	fechacierre datetime,
	fkreaccion varchar(3),
	
	primary key(empresa,id)
);


create table Campa�asTercero (
	empresa varchar(4) not null,
	fkcampa�as int not null,
	id int not null,
	codtercero varchar(15),
	descripciontercero nvarchar(120),
	poblacion nvarchar(100),
	fkprovincia nvarchar(100),
	fkpais nvarchar(100),
	email nvarchar(120),
	telefono nvarchar(15),

	primary key(empresa,fkcampa�as,id),
	foreign key(empresa, fkcampa�as) references Campa�as(empresa,id)

	);
