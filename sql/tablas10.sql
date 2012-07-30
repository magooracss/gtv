CREATE TABLE tugPlanDeCuentas
(
	idCuenta				int 		DEFAULT -1
	,codigo					varchar (10)
	,cuenta					varchar (50)
	,operacion			varchar (1)
	,PorcIVA				float		DEFAULT 0
 ,bVisible           	smallint	DEFAULT 1
);

INSERT INTO tugPlanDeCuentas
(idCuenta, Codigo, Cuenta, Operacion, PorcIVA, bVisible)
VALUES
(0, '0000000000','Desconocido', 'E',0 ,1);

CREATE GENERATOR GenPlanDeCuentas;

SET GENERATOR GenPlanDeCuentas TO 1;

SET TERM ^ ;

CREATE TRIGGER idPlanDeCuentas FOR tugPlanDeCuentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idCuenta = -1) then
   New.idCuenta = GEN_ID(GenPlanDeCuentas,1);
END^

SET TERM ; ^

CREATE TABLE tbCompras
(
	idCompra						"guid" NOT NULL
	,fecha							date
	,refProveedor				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refTipoComprobante int	DEFAULT 0
	,NroComprobante			varchar(30)
	,nTotal							float		DEFAULT 0
	,PercepCapital			float		DEFAULT 0
	,PercepProvincia		float		DEFAULT 0
	,bPagada						float		DEFAULT 0
	,bVisible						smallint	DEFAULT 1
);

CREATE TABLE tbComprasItems
(
	idCompraItem			"guid" NOT NULL
	,refCompra				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,nCantidad				float	DEFAULT 0
	,Concepto					varchar(3000)
	,refImputacion		int		DEFAULT 0
	,nMontoUnitario		float	DEFAULT 0
	,nPorcentajeIVA		float	DEFAULT 0
	,nMontoIVA				float	DEFAULT 0
	,nMontoTotal			float	DEFAULT 0
);

CREATE TABLE tugTiposComprobantes
(
	idTipoComprobante				int 		DEFAULT -1
	,TipoComprobante				varchar (10)
  ,bVisible           	smallint	DEFAULT 1
);

INSERT INTO tugTiposComprobantes
(idTipoComprobante, TipoComprobante, bVisible)
VALUES
(0, 'Ignorado', 0);

CREATE GENERATOR GenTiposComprobantes;

SET GENERATOR GenTiposComprobantes TO 1;

SET TERM ^ ;

CREATE TRIGGER idTiposComprobantes FOR tugTiposComprobantes
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoComprobante = -1) then
   New.idTipoComprobante = GEN_ID(GenTiposComprobantes,1);
END^

SET TERM ; ^


INSERT INTO tugPlanDeCuentas
(idCuenta, Codigo, Cuenta, Operacion, bVisible)
SELECT
  idConcepto
  ,SUBSTRING(concepto FROM 1 FOR 4)
  ,SUBSTRING(concepto FROM 6 FOR 50)
  ,tipo
  ,bVisible
FROM tugConceptos  

SET GENERATOR GenPlanDeCuentas TO 120;
alter table tugTiposComprobantes alter tipoComprobante type varchar(100);

alter table tugFormasPago add Agrupamiento int default 1; -- 1:Efectivo 2:Banco 3:Cheque

CREATE TABLE tbOrdenesPago
(
	idOrdenPago		

);

CREATE TABLE tbOrdenesPago
(
	idOrdenPago					"guid"		NOT NULL
	,NumeroOrdenPago		int				DEFAULT -1
	,refProveedor				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,fFecha							date
	,txObservaciones		blob
	,nTotalAPagar				float			DEFAULT 0
	,bVisible						smallint	DEFAULT 1
);

CREATE TABLE tbOPComprobantes
(
	idOPComprobante			"guid"		NOT NULL
	,refOrdenPago				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refCompra					"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
);

CREATE TABLE tbOPFormasDePago
(
	idOPFormaDePago			"guid"		NOT NULL
	,refOrdenPago				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refFormaPago				int				DEFAULT 0
	,refCheque					"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refBanco						int				DEFAULT 0
	,nMonto							float			DEFAULT 0
	,bVisible						smallint	DEFAULT 1
);


				CREATE GENERATOR GenNumeroOrdenPago;

SET GENERATOR GenNumeroOrdenPago TO 1;

SET TERM ^ ;

CREATE TRIGGER NroOrdenPago FOR tbOrdenesPago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.NumeroOrdenPago = -1) then
   New.NumeroOrdenPago = GEN_ID(GenNumeroOrdenPago,1);
END^

SET TERM ; ^
