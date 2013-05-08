CREATE TABLE tugImputaciones
(
  idImputacion		int 		DEFAULT -1
 ,Concepto		varchar (1000)	DEFAULT '-'
 ,Tipo			char(1)		DEFAULT 'E'
 ,MontoDefecto  	float		DEFAULT 0
 ,Codigo		varchar(20)	DEFAULT '0' 
 ,bVisible           	smallint	DEFAULT 1
);

INSERT INTO tugImputaciones
(idImputacion, Concepto, tipo, MontoDefecto, Codigo, bVisible)
VALUES
(0, 'Desconocido', 'E', 0, 0 ,1);

CREATE GENERATOR GenImputacion;

SET GENERATOR GenImputacion TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugImputacion FOR tugImputaciones
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idImputacion = -1) then
   New.idImputacion = GEN_ID(GenImputacion,1);
END^

SET TERM ; ^


CREATE TABLE tbCompras
( 
  idCompra		"guid"	NOT NULL
 ,Fecha			date
 ,refImputacion 	int
 ,nMonto		float	DEFAULT 0
 ,nIVA			float	DEFAULT 0
 ,nPercepCapital	float	DEFAULT 0
 ,nPercepProvincia	float	DEFAULT 0
 ,txDetalle		varchar(3000)
 ,refCliente		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,refProvedor       	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'   
);

CREATE TABLE tbPagos
(
  idPago		"guid"	NOT NULL
 ,refFormaPago		int	DEFAULT 0
 ,fecha			date
 ,Monto			float	DEFAULT 0
 ,refCheque		"guid" 	DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,refComprobante	"guid" 	DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,refOrdenPago		"guid" 	DEFAULT '{00000000-0000-0000-0000-000000000000}'
);

CREATE TABLE tbOrdenesPago
(
  idOrdenPago		"guid"	NOT NULL
 ,refProveedor		"guid" 	DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,Numero		int	DEFAULT -1
 ,Fecha			date	DEFAULT
);

CREATE GENERATOR GenNroOrdenPago;

SET GENERATOR GenNroOrdenPago TO 0;

SET TERM ^ ;

CREATE TRIGGER NroOrdenPago FOR tbOrdenesPago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.Numero = -1) then
   New.Numero = GEN_ID(GenNroOrdenPago,1);
END^

SET TERM ; ^

CREATE TABLE tbComprobantesCabecera
(
  idComprobanteCabecera	"guid"	NOT NULL
 ,fecha			date
 ,refCompra		"guid" 	DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,NumeroSerie		int	DEFAULT 0
 ,Numero		int	DEFAULT 0
 ,refEstado		int	DEFAULT 0
 ,Monto			float	DEFAULT 0
 ,IVA			float	DEFAULT 0
 ,bVisible		smallint DEFAULT 1
);

CREATE TABLE tbComprobantesDetalle
(
  idComprobanteDetalle	"guid"	NOT NULL
 ,refComprobanteCabecera "guid" 	DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,nCantidad		float	DEFAULT 0
 ,Detalle		varchar (3000)
 ,Monto			float	DEFAULT 0
 ,IVA			float 	DEFAULT 0
 ,bVisible		int	DEFAULT 1
);

CREATE TABLE TbCheques
(

);

