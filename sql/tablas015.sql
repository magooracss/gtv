alter table tbProveedores add cNombreFantasia varchar(3000);
alter table tbProveedores add refLocalidad int default 0;
alter table tbProveedores add cTelefonos varchar(2000);
alter table tbProveedores add cCorreos varchar(2000);
alter table tbProveedores add cWeb varchar(2000);
alter table tbProveedores add refImputacion int default 0;
alter table tbProveedores add cIngresosBrutos varchar(25);
alter table tbProveedores add refCondicionPago int default 0;
alter table tbProveedores add refCondicionPagoTiempo int default 0;
alter table tugLocalidades add refProvincia	int default 0;

create table tugProvincias 
(
	idProvincia		int default -1
	,Provincia		varchar (200)
	,bVisible		smallint default 1
);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(0, 'Desconocido',0);

CREATE GENERATOR GenTugProvincias;

SET GENERATOR GenTugProvincias TO 1;

SET TERM ^ ;

CREATE TRIGGER idTugProvincias FOR tugProvincias
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idProvincia = -1) then
   New.idProvincia = GEN_ID(GenTugProvincias,1);
END^

SET TERM ; ^

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Ciudad Autónoma de Buenos Aires',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Buenos Aires',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Catamarca',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Chaco',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Chubut',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Córdoba',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Corrientes',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Entre Ríos',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Formosa',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Jujuy',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'La Pampa',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'La Rioja',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Mendoza',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Misiones',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Neuquén',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Río Negro',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Salta',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'San Juan',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'San Luis',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Santa Cruz',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Santa Fe',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Santiago del Estero',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Tierra del Fuego, Antártida e Islas del Atlántico Sur',1);

INSERT INTO tugProvincias
(idProvincia, Provincia, bVisible)
VALUES
(-1, 'Tucumán',1);

create table tugCondicionesPago
(
	idCondicionPago		int default -1
	,CondicionPago		varchar (200)
	,bVisible		smallint default 1
);

INSERT INTO tugCondicionesPago
(idCondicionPago, CondicionPago, bVisible)
VALUES
(0, 'Desconocido',0);

CREATE GENERATOR GenTugCondicionPago;

SET GENERATOR GenTugCondicionPago TO 1;

SET TERM ^ ;

CREATE TRIGGER idTugCondicionPago FOR tugCondicionesPago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idCondicionPago = -1) then
   New.idCondicionPago = GEN_ID(GenTugCondicionPago,1);
END^

SET TERM ; ^

INSERT INTO tugCondicionesPago
(idCondicionPago, CondicionPago, bVisible)
VALUES
(-1, 'Contado',1);

INSERT INTO tugCondicionesPago
(idCondicionPago, CondicionPago, bVisible)
VALUES
(-1, 'Cuenta Corriente',1);

create table tugCondicionPagoTiempos
(
	idCondicionPagoTiempo		int default -1
	,CondicionPagoTiempo		varchar (200)
	,bVisible		smallint default 1
);

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(0, 'Desconocido',0);

CREATE GENERATOR GenTugCondicionPagoTiempo;

SET GENERATOR GenTugCondicionPagoTiempo TO 1;

SET TERM ^ ;

CREATE TRIGGER idTugCondicionPagoTiempo FOR tugCondicionPagoTiempos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idCondicionPagoTiempo = -1) then
   New.idCondicionPagoTiempo = GEN_ID(GenTugCondicionPagoTiempo,1);
END^

SET TERM ; ^

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(-1, '7 dias',1);

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(-1, '15 dias',1);

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(-1, '20 dias',1);

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(-1, '30 dias',1);

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(-1, '60 dias',1);

INSERT INTO tugCondicionPagoTiempos
(idCondicionPagoTiempo, CondicionPagoTiempo, bVisible)
VALUES
(-1, '90 dias',1);

