-- Versión previa: 20

CREATE TABLE Ingresos
(
      id		"guid"			NOT NULL
    , nroInterno int    default -1
    , fecha     date
    , nombre    varchar(500)
    , clienteEmpresa_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
    , estado    int     default 0
    , fAnulado  date
);
 
CREATE TABLE IngresoItems
(
      id		"guid"			NOT NULL
    , detalle   varchar(500)
    , monto     float   default 0  
    , cantidad  float   default 0
    , precioUnitario    float   default 0
);

CREATE GENERATOR GenNumeroIngreso;
SET GENERATOR GenNumeroIngreso TO 0;

SET TERM ^ ;

CREATE TRIGGER nroIngreso FOR Ingresos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nroInterno = -1) then
   New.nroInterno = GEN_ID(GenNumeroIngreso,1);
END^


SET TERM ; ^



CREATE TABLE Recibos
(
      id		"guid"			NOT NULL
    , fecha     date	  
	, nroPtoVenta	int default 0
    , nroRecibo		int default -1	
    , clienteEmpresa_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
    , detalle    varchar(3000)
    , fAnulacion  date
    , estado_id    int     default 0   
);
 
 
CREATE GENERATOR GenReciboNro;
SET GENERATOR GenReciboNro TO 0;

SET TERM ^ ;

CREATE TRIGGER ReciboNro FOR Recibos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nroRecibo = -1) then
   New.nroRecibo = GEN_ID(GenReciboNro,1);
END^

SET TERM ; ^
 
 
CREATE TABLE  ReciboItems
(
      id		"guid"			NOT NULL
	  , formaCobro_id	int	default 0
	  , banco_id	int default 0
	  , cheque_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
	  , formaCobro	varchar(200)
	  , monto	float default 0
	  , recibo_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
	  , cuenta_id	int default 0
);

CREATE TABLE tugRecibosEstados
(
  idReciboEstado     int 		DEFAULT -1
 ,Estado		     varchar (50) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugRecibosEstados
(idReciboEstado, Estado, bVisible)
VALUES
(0,'Desconocido', 1);

INSERT INTO tugRecibosEstados
(idReciboEstado, Estado, bVisible)
VALUES
(1,'Sin Facturar', 1);

INSERT INTO tugRecibosEstados
(idReciboEstado, Estado, bVisible)
VALUES
(2,'Facturado', 1);

INSERT INTO tugRecibosEstados
(idReciboEstado, Estado, bVisible)
VALUES
(3,'Anulado', 1);


CREATE GENERATOR GenReciboEstado;
SET GENERATOR GenReciboEstado TO 3;

SET TERM ^ ;

CREATE TRIGGER idtugReciboEstado FOR tugRecibosEstados
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idReciboEstado = -1) then
   New.idReciboEstado = GEN_ID(GenReciboEstado,1);
END^

SET TERM ; ^

CREATE TABLE Facturas
(
      id		"guid"			NOT NULL
    , fecha     date	  
	, nroPtoVenta	int default 0
    , nroFactura	int default -1	
	, tipoFactura_id int default 0
    , clienteEmpresa_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
	, condicionVenta_id  int default 0
    , Observaciones    varchar(3000)
    , fAnulacion  date
    , estado_id    int     default 0   
);

CREATE TABLE FacturaItems
(
      id		"guid"			NOT NULL
	, factura_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
	, cantidad  float default 0
	, detalle  varchar(1500)
	, precioUnitario float default 0
	, monto float default 0
);

CREATE TABLE tcNroTipoFactura
(
	  id	int
	, tipoFactura varchar (50)
	, nroPtoVenta	int default 0
    , nroFactura	int default -1	
);


CREATE TABLE tugFormasCobro
(
  idFormaCobro     int 		DEFAULT -1
, FormaCobro	   varchar (50) 
, bVisible         smallint 	DEFAULT 1
, Agrupamiento	   int		default 0
, refCuenta	   int		default 0 
);

INSERT INTO tugFormasCobro
(idFormaCobro, FormaCobro, bVisible, Agrupamiento, refCuenta)
VALUES
(0,'Desconocido', 0,0,0);

INSERT INTO tugFormasCobro
(idFormaCobro, FormaCobro, bVisible, Agrupamiento, refCuenta)
VALUES
(1,'Efectivo', 1,1,0);

INSERT INTO tugFormasCobro
(idFormaCobro, FormaCobro, bVisible, Agrupamiento, refCuenta)
VALUES
(2,'Transferencia', 1,2,0);

INSERT INTO tugFormasCobro
(idFormaCobro, FormaCobro, bVisible, Agrupamiento, refCuenta)
VALUES
(3,'Cheque', 1,3,0);


CREATE GENERATOR GenIdFormaCobro;
SET GENERATOR GenIdFormaCobro TO 4;

SET TERM ^ ;

CREATE TRIGGER idtugFormaCobro FOR tugFormasCobro
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idFormaCobro = -1) then
   New.idFormaCobro = GEN_ID(GenIdFormaCobro,1);
END^

SET TERM ; ^



UPDATE RDB$RELATION_FIELDS SET RDB$NULL_FLAG = 1
WHERE RDB$FIELD_NAME = 'idBanco' AND RDB$RELATION_NAME = 'tugBancos';

alter table tugBancos add primary key (idBanco);

CREATE TABLE tugFacturas
(
  id  integer default -1
 ,letra char(1)
 ,generador varchar (10)
 ,bVisible smallint default 1 
);

INSERT INTO tugFacturas
( id,letra, generador, bVisible)
VALUES
(1, 'A', 'GEN_FACT_A',1);

INSERT INTO tugFacturas
( id,letra, generador,bVisible)
VALUES
(2, 'B', 'GEN_FACT_B', 1);

INSERT INTO tugFacturas
( id,letra, generador,bVisible)
VALUES
(3, 'C', 'GEN_FACT_C', 1);

INSERT INTO tugFacturas
( id,letra, generador,bVisible)
VALUES
(4, 'T', 'GEN_FACT_T', 1);

CREATE GENERATOR GEN_FACT_A;
CREATE GENERATOR GEN_FACT_B;
CREATE GENERATOR GEN_FACT_C;
CREATE GENERATOR GEN_FACT_T;

SET GENERATOR GEN_FACT_A TO 0;
SET GENERATOR GEN_FACT_B TO 0;
SET GENERATOR GEN_FACT_C TO 0;
SET GENERATOR GEN_FACT_T TO 0;

CREATE TABLE RecibosFacturas
(
      id		"guid"			NOT NULL
    , recibo_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
    , factura_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
);	

CREATE TABLE RemitosFacturas
(
      id		"guid"			NOT NULL
    , remito_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
    , factura_id "guid"  default '{00000000-0000-0000-0000-000000000000}'
);	
	