CREATE DOMAIN "guid"
  AS VARCHAR(38)
  CHARACTER SET ASCII
  DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL;


CREATE TABLE tbEquipos
(
   idEquipo		"guid"			NOT NULL
  ,refCliente	"guid"			DEFAULT '{00000000-0000-0000-0000-000000000000}'
  ,nombre		varchar(300)
  ,refTipo		int				DEFAULT 0
  ,TM_Traccion	int				DEFAULT 0
  ,TM_PropHidraulica int 		DEFAULT 0
  ,TM_Otras		varchar (500)	DEFAULT '-'
  ,CM_Ubicacion int				DEFAULT 0
  ,CM_Otras		varchar (500)	DEFAULT '-' 
  ,M_Marca		int				DEFAULT 0
  ,M_Velocidad	int				DEFAULT 0
  ,M_PotenciaHP	int				DEFAULT 0
  ,M_NroIdentificadores	varchar (150) DEFAULT '-'
  ,T_Tipo		int				DEFAULT 0
  ,T_AlternaControlada	varchar (150) DEFAULT '-'
  ,T_FrecVariable		varchar (150) DEFAULT '-'
  ,R_NroPisos	int				DEFAULT 1
  ,R_Paradas	int				DEFAULT 1
  ,R_Accesos	int				DEFAULT 1
  ,R_AccesosOpyAd	int			DEFAULT 0
  ,V_Unica		float			DEFAULT 0
  ,V_AltaBaja	float			DEFAULT 0
  ,TPCab_Tipo	int				DEFAULT 0
  ,TPCab_Otro	varchar (500) 	DEFAULT '-' 
  ,TPContr_Tipo	int				DEFAULT 0
  ,TPContr_Otro	varchar (500) 	DEFAULT '-' 
  ,P_Tipo		int				DEFAULT 0
  ,P_Otro		varchar (500) 	DEFAULT '-' 
  ,TMan_Tipo	int				DEFAULT 0
  ,TMan_Otra 	varchar (500) 	DEFAULT '-' 
  ,SA_Tipo		int				DEFAULT 0
  ,TC_Tipo		int				DEFAULT 0
  ,CT_Personas	int				DEFAULT 0
  ,CT_Kg		float			DEFAULT 0
  ,PC_Material	int				DEFAULT 0
  ,PC_Manual	smallint 		DEFAULT 0
  ,PC_ManualTipo int			DEFAULT 0
  ,PC_ManualOtra varchar(500) 	DEFAULT '-'
  ,PC_Automatica smallint 		DEFAULT 0
  ,PC_AutomaticaTipo int	 	DEFAULT 0
  ,PC_AutomaticaCorriente int 	DEFAULT 0 
  ,PC_AutomaticaOtra	varchar(500) DEFAULT '-'
  ,PR_Material	int				DEFAULT 0
  ,PR_Manual	smallint		DEFAULT 0
  ,PR_ManualTipo int			DEFAULT 0
  ,PR_ManualOtra varchar(500)   DEFAULT '-'
  ,PR_Automatica smallint		DEFAULT 0
  ,PR_AutomaticaTipoArrastre int DEFAULT 0
  ,PH_PistonCentral	smallint 	DEFAULT 0
  ,PH_PistonLateral	smallint 	DEFAULT 0
  ,PH_PistonEnterrado smallint 	DEFAULT 0
  ,PH_PistonTelescopico	smallint 	DEFAULT 0
  ,PH_Relacion2_1	smallint 	DEFAULT 0
  ,bVisible 	smallint		DEFAULT 1   
);


CREATE TABLE tugTiposEquipos
(
  idTipoEquipo	     int 		DEFAULT -1
 ,Equipo		     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposEquipos 
(idTipoEquipo, Equipo, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenTipoEquipo;
SET GENERATOR GenTipoEquipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTipoEquipo FOR tugTiposEquipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoEquipo = -1) then
   New.idTipoEquipo = GEN_ID(GenTipoEquipo,1);
END^


SET TERM ; ^

CREATE TABLE tugTiposMaquinasTraccion
(
  idTipoMaqTraccion  int 		DEFAULT -1
 ,Traccion		     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposMaquinasTraccion
(idTipoMaqTraccion, Traccion, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenTipoMaqTraccion;
SET GENERATOR GenTipoMaqTraccion TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposMaquinasTraccion FOR tugTiposMaquinasTraccion
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoMaqTraccion = -1) then
   New.idTipoMaqTraccion = GEN_ID(GenTipoMaqTraccion,1);
END^


SET TERM ; ^

CREATE TABLE tugTiposMaqPropHidraulica
(
  idTipoMaqPropHidraulica   int 		DEFAULT -1
 ,PropulsionHidraulica     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposMaqPropHidraulica
(idTipoMaqPropHidraulica, PropulsionHidraulica, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenTipoMaqPropHidraulica;
SET GENERATOR GenTipoMaqPropHidraulica TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTipoMaqPropHidraulica FOR tugTiposMaqPropHidraulica
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoMaqPropHidraulica = -1) then
   New.idTipoMaqPropHidraulica = GEN_ID(GenTipoMaqPropHidraulica,1);
END^


SET TERM ; ^

CREATE TABLE tugCuartoMaqUbicacion
(
  idCuartoMaqUbicacion  int 		DEFAULT -1
 ,Ubicacion		     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugCuartoMaqUbicacion
(idCuartoMaqUbicacion, Ubicacion, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenCuartoMaqUbicacion
SET GENERATOR GenCuartoMaqUbicacion TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugCuartoMaqUbicacion FOR tugCuartoMaqUbicacion
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idCuartoMaqUbicacion = -1) then
   New.idCuartoMaqUbicacion = GEN_ID(GenCuartoMaqUbicacion,1);
END^

SET TERM ; ^


CREATE TABLE tugMotoresMarcas
(
  idMotorMarca		 int 		DEFAULT -1
 ,Marca			     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugMotoresMarcas
(idMotorMarca, Marca, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenMotorMarca
SET GENERATOR GenMotorMarca TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugMotoresMarcas FOR tugMotoresMarcas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idMotorMarca = -1) then
   New.idMotorMarca = GEN_ID(GenMotorMarca,1);
END^

SET TERM ; ^

CREATE TABLE tugTensionesTipo
(
  idTensionTipo		 int 		DEFAULT -1
 ,TensionTipo	     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTensionesTipo
(idTensionTipo, TensionTipo, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenTensionTipo;
SET GENERATOR GenTensionTipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTensionesTipo FOR tugTensionesTipo
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTensionTipo = -1) then
   New.idTensionTipo = GEN_ID(GenTensionTipo,1);
END^

SET TERM ; ^

CREATE TABLE tugTiposParacaidas
(
  idTipoParacaidas   int 		DEFAULT -1
 ,TipoParacaidas     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposParacaidas
(idTipoParacaidas, TipoParacaidas, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenTipoParacaidas
SET GENERATOR GenTipoParacaidas TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposParaidas FOR tugTiposParacaidas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoParacaidas = -1) then
   New.idTipoParacaidas = GEN_ID(GenTipoParacaidas,1);
END^

SET TERM ; ^

CREATE TABLE tugTiposParagolpes
(
  idTipoParagolpe	 int 		DEFAULT -1
 ,TipoParagolpe	     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposParagolpes
(idTipoParagolpe, TipoParagolpe, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenTipoParagolpe
SET GENERATOR GenTipoParagolpe TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTipoParagolpe FOR tugTiposParagolpes
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoParagolpe = -1) then
   New.idTipoParagolpe = GEN_ID(GenTipoParagolpe,1);
END^

SET TERM ; ^

CREATE TABLE tugTiposManiobrasTipos
(
  idTipoManiobraTipo int 		DEFAULT -1
 ,TipoManiobra	     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposManiobrasTipos
(idTipoManiobraTipo, TipoManiobra, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenTipoManiobraTipo;
SET GENERATOR GenTipoManiobraTipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposManiobrasTipos FOR tugTiposManiobrasTipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoManiobraTipo = -1) then
   New.idTipoManiobraTipo = GEN_ID(GenTipoManiobraTipo,1);
END^

SET TERM ; ^

CREATE TABLE tugSelectivaAcumulativaTipos
(
  idSelectivaAcumulativaTipo int 		DEFAULT -1
 ,SelectivaAcumulativa	     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugSelectivaAcumulativaTipos
(idSelectivaAcumulativaTipo, SelectivaAcumulativa, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenSelectivaAcumulativaTipo;
SET GENERATOR GenSelectivaAcumulativaTipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugSelectivaAcumulativaTipo FOR tugSelectivaAcumulativaTipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idSelectivaAcumulativaTipo = -1) then
   New.idSelectivaAcumulativaTipo = GEN_ID(GenSelectivaAcumulativaTipo,1);
END^

SET TERM ; ^

CREATE TABLE tugTiposControlTipos
(
  idTipoControlTipo	 int 		DEFAULT -1
 ,TipoControl	     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposControlTipos
(idTipoControlTipo, TipoControl, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenTipoControlTipo;
SET GENERATOR GenTipoControlTipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTiposControlTipos FOR tugTiposControlTipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoControlTipo = -1) then
   New.idTipoControlTipo = GEN_ID(GenTipoControlTipo,1);
END^

SET TERM ; ^

CREATE TABLE tugMateriales
(
  idMaterial		 int 		DEFAULT -1
 ,Material		     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugMateriales
(idMaterial, Material, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenMateriales;
SET GENERATOR GenMateriales TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugMateriales FOR tugMateriales
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idMaterial = -1) then
   New.idMaterial = GEN_ID(GenMateriales,1);
END^

SET TERM ; ^

CREATE TABLE tugPuertasManualesTipos
(
  idPuertaManualTipo int 		DEFAULT -1
 ,TipoPuertaManual   varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugPuertasManualesTipos
(idPuertaManualTipo, TipoPuertaManual, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenPuertaManualTipo;
SET GENERATOR GenPuertaManualTipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugPuertasManualesTipos FOR tugPuertasManualesTipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idPuertaManualTipo = -1) then
   New.idPuertaManualTipo = GEN_ID(GenPuertaManualTipo,1);
END^

SET TERM ; ^

CREATE TABLE tugPuertasAutomaticasTipos
(
  idPuertaAutomaticaTipo int 		DEFAULT -1
 ,PuertaAutomaticaTipo      varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugPuertasAutomaticasTipos
(idPuertaAutomaticaTipo, PuertaAutomaticaTipo, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenPuertaAutomaticaTipo;
SET GENERATOR GenPuertaAutomaticaTipo TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugPuertaAutomaticaTipo FOR tugPuertasAutomaticasTipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idPuertaAutomaticaTipo = -1) then
   New.idPuertaAutomaticaTipo = GEN_ID(GenPuertaAutomaticaTipo,1);
END^

SET TERM ; ^

CREATE TABLE tugPuertasAutomaticasCorriente
(
  idPuertaAutomaticaCorriente int 		DEFAULT -1
 ,PuertaAutomaticaCorriente	     varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugPuertasAutomaticasCorriente
(idPuertaAutomaticaCorriente, PuertaAutomaticaCorriente, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenPuertaAutomaticaCorriente;
SET GENERATOR GenPuertaAutomaticaCorriente TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugPuertaAutomaticaCorriente FOR tugPuertasAutomaticasCorriente
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idPuertaAutomaticaCorriente = -1) then
   New.idPuertaAutomaticaCorriente = GEN_ID(GenPuertaAutomaticaCorriente,1);
END^

SET TERM ; ^

CREATE TABLE tugPuertasAutomaticasArrastre
(
  idPuertaAutomaticaArrastre int 		DEFAULT -1
 ,PuertaAutomaticaArrastre   varchar (300) 
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugPuertasAutomaticasArrastre
(idPuertaAutomaticaArrastre, PuertaAutomaticaArrastre, bVisible)
VALUES
(0,'Desconocido', 1);


CREATE GENERATOR GenPuertaAutomaticaArrastre;
SET GENERATOR GenPuertaAutomaticaArrastre TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugPuertasAutomaticasArrastre FOR tugTiposManiobrasTipos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoManiobraTipo = -1) then
   New.idTipoManiobraTipo = GEN_ID(GenTipoManiobraTipo,1);
END^

SET TERM ; ^

