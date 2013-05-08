CREATE TABLE tbEgresosVarios
(
	idEgresoVario				"guid"		NOT NULL
	,nroEgreso					int			DEFAULT -1
	,fecha						date
	,titulo						varchar (2000)
	,bVisible					smallint	DEFAULT 1
);

CREATE GENERATOR GenNumeroEgresoVario;

SET GENERATOR GenNumeroEgresoVario TO 1;

SET TERM ^ ;

CREATE TRIGGER NumeroEgresoVario FOR tbEgresosVarios
BEFORE INSERT POSITION 0
AS
BEGIN 
    If (New.nroEgreso = -1) then
   New.nroEgreso = GEN_ID(GenNumeroEgresoVario,1);
END^


SET TERM ; ^



CREATE TABLE tbEgresosVariosItems
(
	idEgresoVarioItem			"guid"		NOT NULL
	,refEgresoVario				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refImputacion				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,leyenda					varchar(3000)
	,nMonto						float		DEFAULT 0
);

CREATE TABLE tbEVFormasPago
(
	idEVFormaPago				"guid"		NOT NULL
	,refEgresoVario				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refFormaPago				int 		DEFAULT 0
	,refCheque					"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refBanco					int			DEFAULT 0
	,nMonto						float		DEFAULT 0
);