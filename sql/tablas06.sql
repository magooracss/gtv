CREATE TABLE tbCajaConceptos
(
   idCajaConcepto   "guid"
  ,fFecha			date
  ,refConcepto		int    DEFAULT 0
  ,nMonto			float  DEFAULT 0
  ,refFormaPago		int	   DEFAULT 0
  ,txDetallePago	varchar(500)
  ,txDetalle		varchar(3000)
  ,refEmpresa		"guid" DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,refListaEmpresa  char(1) DEFAULT 'P'
  ,fModificacion    date
  ,bVisible			smallint  DEFAULT 1  
);


CREATE TABLE tugConceptos
(
  idConcepto     int 		DEFAULT -1
 ,Concepto	     varchar (1000) DEFAULT '-'
 ,Tipo			 char(1)	DEFAULT 'E'
 ,MontoDefecto   float      DEFAULT 0
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugConceptos
(idConcepto, Concepto, tipo, MontoDefecto, bVisible)
VALUES
(0, 'Desconocido', 'E', 0, 1);

CREATE GENERATOR GenConcepto;

SET GENERATOR GenConcepto TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugConceptos FOR tugConceptos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idConcepto = -1) then
   New.idConcepto = GEN_ID(GenConcepto,1);
END^

SET TERM ; ^


CREATE TABLE tugFormasPago
(
  idFormaPago     int 		DEFAULT -1
 ,FormaPago	     varchar (1000) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugFormasPago
(idFormaPago, FormaPago, bVisible)
VALUES
(0, 'Desconocida', 1);

INSERT INTO tugFormasPago
(idFormaPago, FormaPago, bVisible)
VALUES
(1, 'Efectivo', 1);


CREATE GENERATOR GenFormaPago;

SET GENERATOR GenFormaPago TO 1;

SET TERM ^ ;

CREATE TRIGGER idtugFormaPago FOR tugFormasPago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idFormaPago = -1) then
   New.idFormaPago = GEN_ID(GenFormaPago,1);
END^

SET TERM ; ^

CREATE TABLE tbProveedores
(
  idProveedor     "guid" 
 ,cRazonSocial    varchar(1500)
 ,cCUIT           varchar (25)
 ,refCondicionFiscal  int  default 0
 ,cContacto        varchar(2000)
 ,cDomicilio	   varchar(3000)
 ,txNotas          varchar(3000)
 ,bVisible         smallint   DEFAULT 1 
);
