 CREATE TABLE tbReclamos
(
	idReclamo   		"guid"			NOT NULL
   ,refCliente			"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,nNro				int				DEFAULT -1
   ,fHora				time
   ,fFecha				date	
   ,cSolicitante	    varchar(500)    DEFAULT '-'
   ,refMedio            int				DEFAULT 0
   ,txDetalles          varchar(3000)
   ,refOrdenTrabajo     "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,fAtendido		    date
   ,refTecnicoAtendio   int			    DEFAULT 0
   ,txInformeTecnico    varchar(3000)
   ,txObservaciones     varchar(3000)
   ,bVisible			smallint		DEFAULT 1
  );

CREATE GENERATOR GenNroReclamo;
SET GENERATOR GenNroReclamo TO 0;

SET TERM ^ ;

CREATE TRIGGER NroReclamo FOR tbReclamos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nNro = -1) then
   New.nNro = GEN_ID(GenNroReclamo,1);
END^

SET TERM ; ^  
  
CREATE TABLE trReclamosEquipos
(
	idReclamosEquipos "guid"			NOT NULL
   ,refReclamo    	  "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,refEquipo		  "guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
);
