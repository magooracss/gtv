CREATE TABLE tbClientes
(
   idCliente		"guid"			NOT NULL
  ,cCodigo			varchar(10)		DEFAULT '0'
  ,cNombre			varchar(300)	DEFAULT ' '
  ,fInicio			date
  ,refAbono			int				DEFAULT 0
  ,refRespTecnico	"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,refGrupoFacturacion int			DEFAULT 0
  ,refCondicionFiscal	int			DEFAULT	0
  ,cCUIT			varchar(20)		DEFAULT '0'
  ,nIVA				float			DEFAULT 0
  ,cDomicilio		varchar (1000)	DEFAULT '-'
  ,cEntreCalle1		varchar (1000)	DEFAULT '-'
  ,cEntreCalle2		varchar (1000)	DEFAULT '-'
  ,cNroCasa			varchar(20)		DEFAULT '-'
  ,cSeccion			varchar(20)		DEFAULT '0'
  ,cManzana			varchar(20)		DEFAULT '0'
  ,cParcela			varchar(20)		DEFAULT '0'
  ,refLocalidad		int				DEFAULT 0
  ,refDestino		int				DEFAULT 0
  ,UnidadFuncional	int				DEFAULT 0
  ,refAdministrador	"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,refConservador	"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,bVisible			smallint		DEFAULT 1
);

CREATE TABLE tbContactosCliente
(
	idContactoCliente	"guid"		NOT NULL
   ,refCliente			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	
   ,Denominacion		varchar (500)	DEFAULT '-'
   ,refTipoContacto		int			DEFAULT 0
   ,refTipoDocumento	int			DEFAULT 0
   ,cDocumento			varchar(30)	DEFAULT '-'
   ,cCargo				varchar(200) DEFAULT '-'
   ,bVisible			smallint	DEFAULT 1
);  

CREATE TABLE tbDomicilios
(
	idDomicilio			"guid"		NOT NULL
   ,refRelacion			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,Domicilio			varchar (300) DEFAULT '-'
   ,refLocalidad		int			DEFAULT 0
   ,bVisible			smallint	DEFAULT 1
);
  
CREATE TABLE tbContactos
(
	idContacto			"guid"		NOT NULL
   ,refRelacion			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
   ,Contacto			varchar(300) DEFAULT '-'
   ,refTipoContacto		int			DEFAULT 0
   ,bVisible			smallint	DEFAULT 1   
);

CREATE TABLE tbAdministradores
(
	idAdministrador		"guid"		NOT NULL
   ,cRazonSocial		varchar(500)	DEFAULT '-'
   ,CUIT				varchar(20)	DEFAULT '-'
   ,refTipoDocumento	int			DEFAULT 0
   ,cDocumento			varchar(30) DEFAULT '-'
   ,txNotas				varchar(3000) DEFAULT ''
   ,bVisible			smallint	DEFAULT 1   
);

CREATE TABLE tbConservadores
(
	idConservador		"guid"		NOT NULL
   ,cRazonSocial		varchar(500)	DEFAULT '-'
   ,cDomicilio			varchar(1000)	DEFAULT '-'
   ,cCodPostal			varchar(50)	DEFAULT '-'
   ,cTelefono			varchar(50) DEFAULT '-'
   ,NroPermiso			varchar(20)	DEFAULT '0'
   ,CUIT				varchar(20)	DEFAULT '-'	
   ,bVisible			smallint	DEFAULT 1
);

CREATE TABLE tbResponsablesTecnicos
(
	idResponsableTecnico "guid"		NOT NULL
   ,cNombre				varchar(500)	DEFAULT '-'
   ,cDomicilio			varchar(1000)	DEFAULT '-'
   ,cTelefono			varchar(50) 	DEFAULT '-'
   ,HabilitacionExp		varchar(50) 	DEFAULT '-'
   ,HabilitacionFecha	date
   ,CedulaIdentidad		varchar(30)		DEFAULT '-'
   ,refPolicia			integer			DEFAULT 0
   ,DNI					varchar(30)		DEFAULT '-'
   ,Matricula			varchar (30)	DEFAULT '-'
   ,bVisible			smallint	DEFAULT 1
);


CREATE TABLE tugPolicias
(
  idPolicia		     int 		DEFAULT -1
 ,Policia		     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugPolicias
(idPolicia, Policia, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE GENERATOR GenPolicia;
SET GENERATOR GenPolicia TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugPolicias FOR tugPolicias
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idPolicia = -1) then
   New.idPolicia = GEN_ID(GenPolicia,1);
END^

SET TERM ; ^


INSERT INTO tugAbonos 
(idAbono, Abono, Monto, bVisible)
VALUES
(0, 'Desconocido', 0, 1);


CREATE GENERATOR GenAbono;
SET GENERATOR GenAbono TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugAbonos FOR tugAbonos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idAbono = -1) then
   New.idAbono = GEN_ID(GenAbono,1);
END^

SET TERM ; ^

CREATE TABLE tugDestinosCliente
(
  idDestinoCliente   int 		DEFAULT -1
 ,Destino		     varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugDestinosCliente
(idDestinoCliente, Destino, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE GENERATOR GenDestinoCliente;
SET GENERATOR GenDestinoCliente TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugDestinosCliente FOR tugDestinosCliente
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idDestinoCliente = -1) then
   New.idDestinoCliente = GEN_ID(GenDestinoCliente,1);
END^

SET TERM ; ^

CREATE TABLE tugGruposFacturacion
(
  idGrupoFacturacion int 		DEFAULT -1
 ,GrupoFacturacion   varchar (300) DEFAULT '-'
 ,DiaFacturacion	 int
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugGruposFacturacion
(idGrupoFacturacion, GrupoFacturacion, DiaFacturacion, bVisible)
VALUES
(0, 'Desconocido', 0,1);


CREATE GENERATOR GenGrupoFacturacion;
SET GENERATOR GenGrupoFacturacion TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugGrupoFacturacion FOR tugGruposFacturacion
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idGrupoFacturacion = -1) then
   New.idGrupoFacturacion = GEN_ID(GenGrupoFacturacion,1);
END^

SET TERM ; ^

CREATE TABLE tugCondicionesFiscales
(
  idCondicionFiscal	 int 		DEFAULT -1
 ,CondicionFiscal	 varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugCondicionesFiscales
(idCondicionFiscal, CondicionFiscal, bVisible)
VALUES
(0, 'Desconocido',1);


CREATE GENERATOR GenCondicionFiscal;
SET GENERATOR GenCondicionFiscal TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugCondicionesFiscales FOR tugCondicionesFiscales
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idCondicionFiscal = -1) then
   New.idCondicionFiscal = GEN_ID(GenCondicionFiscal,1);
END^

SET TERM ; ^

CREATE TABLE tugTiposContactoCliente
(
  idTipoContactoCliente int 		DEFAULT -1
 ,TipoContactoCliente   varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposContactoCliente
(idTipoContactoCliente, TipoContactoCliente, bVisible)
VALUES
(0, 'Desconocido',1);


CREATE GENERATOR GenTipoContactoCliente;
SET GENERATOR GenTipoContactoCliente TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposContactoCliente FOR tugTiposContactoCliente
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoContactoCliente = -1) then
   New.idTipoContactoCliente = GEN_ID(GenTipoContactoCliente,1);
END^

SET TERM ; ^


CREATE TABLE tugLocalidades
(
  idLocalidad		 int 		DEFAULT -1
 ,Localidad			 varchar (300) DEFAULT '-'
 ,cPostal			 varchar (50)  DEFAULT '0'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugLocalidades
(idLocalidad, Localidad, cPostal, bVisible)
VALUES
(0, 'Desconocido','0' ,1);


CREATE GENERATOR GenLocalidad;
SET GENERATOR GenLocalidad TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugLocalides FOR tugLocalidades
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idLocalidad = -1) then
   New.idLocalidad = GEN_ID(GenLocalidad,1);
END^

SET TERM ; ^


CREATE TABLE tugTiposContacto
(
  idTipoContacto	 int 		DEFAULT -1
 ,TipoContacto		 varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposContacto
(idTipoContacto, TipoContacto, bVisible)
VALUES
(0, 'Desconocido',1);


CREATE GENERATOR GenTipoContacto;
SET GENERATOR GenTipoContacto TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposContacto FOR tugTiposContacto
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoContacto = -1) then
   New.idTipoContacto = GEN_ID(GenTipoContacto,1);
END^

SET TERM ; ^


CREATE TABLE tugTiposDocumento
(
  idTipoDocumento	 int 		DEFAULT -1
 ,TipoDocumento		 varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposDocumento
(idTipoDocumento, TipoDocumento, bVisible)
VALUES
(0, 'Desconocido',1);


CREATE GENERATOR GenTipoDocumento;
SET GENERATOR GenTipoDocumento TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposDocumento FOR tugTiposDocumento
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoDocumento = -1) then
   New.idTipoDocumento = GEN_ID(GenTipoDocumento,1);
END^

SET TERM ; ^
