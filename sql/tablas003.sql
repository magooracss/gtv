CREATE TABLE tbPresupuestos
(
   idPresupuesto 	"guid"			NOT NULL
  ,nPresupuesto		int				DEFAULT -1
  ,fEmision			date
  ,refCliente		"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,refEmpleado		 int			DEFAULT 0
  ,refEstado		 int			DEFAULT 0
  ,fCambioEstado	 date
  ,txMotivo			 varchar (3000)
  ,txObservaciones	 varchar (3000)
  ,bAceptado		 smallint		DEFAULT 0
  ,txDocumento		 blob
  ,bVisible			 smallint		DEFAULT 1
);
 
CREATE GENERATOR GenNroPresupuesto;
SET GENERATOR GenNroPresupuesto TO 0;

SET TERM ^ ;

CREATE TRIGGER NroPresupuesto FOR tbPresupuestos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nPresupuesto = -1) then
   New.nPresupuesto = GEN_ID(GenNroPresupuesto,1);
END^

SET TERM ; ^

  
CREATE TABLE tbCuotasPresupuesto
(
	idCuotaPresupuesto	"guid"			NOT NULL
   ,refPresupuesto		"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,nNroCuota			int				DEFAULT -1
   ,refTipo				int				DEFAULT 0
   ,fVencimiento		date
   ,nMonto				float			DEFAULT 0
   ,refEstado			int				DEFAULT 0
   ,fPago				date   
   ,bVisible 			int 			DEFAULT 1
);

CREATE TABLE tugEmpleados
(
  idEmpleado	     int 		DEFAULT -1
 ,Empleado		     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugEmpleados
(idEmpleado, Empleado, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE GENERATOR GenEmpleado;
SET GENERATOR GenEmpleado TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugEmpleado FOR tugEmpleados
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idEmpleado = -1) then
   New.idEmpleado = GEN_ID(GenEmpleado,1);
END^

SET TERM ; ^


CREATE TABLE tugPresupuestosEstados
(
  idPresupuestoEstado  int 		DEFAULT -1
 ,Estado		     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugPresupuestosEstados
(idPresupuestoEstado, Estado, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE GENERATOR GenPresupuestoEstado;
SET GENERATOR GenPresupuestoEstado TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugPresupuestoEstado FOR tugPresupuestosEstados
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idPresupuestoEstado = -1) then
   New.idPresupuestoEstado = GEN_ID(GenPresupuestoEstado,1);
END^

SET TERM ; ^

CREATE TABLE tugTiposCuota
(
  idTipoCuota		 int 		DEFAULT -1
 ,TipoCuota		     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposCuota
(idTipoCuota, TipoCuota, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE GENERATOR GenTipoCuota;
SET GENERATOR GenTipoCuota TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugTiposCuota FOR tugTiposCuota
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoCuota = -1) then
   New.idTipoCuota = GEN_ID(GenTipoCuota,1);
END^

SET TERM ; ^

CREATE TABLE tugEstadosCuota
(
  idEstadoCuota		 int 		DEFAULT -1
 ,EstadoCuota	     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugEstadosCuota
(idEstadoCuota, EstadoCuota, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE GENERATOR GenEstadoCuota;
SET GENERATOR GenEstadoCuota TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugEstadosCuota FOR tugEstadosCuota
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idEstadoCuota = -1) then
   New.idEstadoCuota = GEN_ID(GenEstadoCuota,1);
END^

SET TERM ; ^

