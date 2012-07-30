 CREATE TABLE tbRemitos
(
	idRemito	   		"guid"			NOT NULL
   ,refCliente			"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,nRemito				int				DEFAULT -1
   ,fFecha		        date
   ,refOrdenTrabajo    "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,refMotivo			int				DEFAULT 0
   ,txDetalles			varchar(3000)
   ,refFactura          "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,bFacturar           smallint        DEFAULT 0
   ,bFacturado          smallint        DEFAULT 0
   ,bPresentado         smallint	    DEFAULT 0
   ,bVisible            smallint        DEFAULT 1
);
  
CREATE TABLE trRemitoEquipos
(
   idRemitoEquipo      "guid"			NOT NULL
  ,refRemito           "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,refEquipo		   "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
);

CREATE GENERATOR GenNroRemito;
SET GENERATOR GenNroRemito TO 0;

SET TERM ^ ;

CREATE TRIGGER NroRemito FOR tbRemitos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nRemito = -1) then
   New.nRemito = GEN_ID(GenNroRemito,1);
END^

SET TERM ; ^    


CREATE TABLE tugMotivosRemito
(
  idMotivoRemito     int 		DEFAULT -1
 ,MotivoRemito	     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugMotivosRemito
(idMotivoRemito, MotivoRemito, bVisible)
VALUES
(0, 'Desconocido', 1);

CREATE GENERATOR GenMotivoRemito;
SET GENERATOR GenMotivoRemito TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugMotivoRemito FOR tugMotivoRemito
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idMotivoRemito = -1) then
   New.idMotivoRemito = GEN_ID(GenMotivoRemtio,1);
END^

SET TERM ; ^
