CREATE TABLE tugTiposManiobrasOtra
(
  idTipoManiobraOtra    int    DEFAULT -1
 , TipoManiobraOtra    varchar (300)
 , bVisible    smallint    DEFAULT 1
);

INSERT INTO tugTiposManiobrasOtra
(idTipoManiobraOtra, TipoManiobraOtra, bVisible)
VALUES
(0,'Desconocida', 1);


CREATE GENERATOR GenTipoManiobraOtra;

SET GENERATOR GenTipoManiobraOtra TO 0;

SET TERM ^ ;

CREATE TRIGGER idtugTipoManiobraOtra FOR tugTiposManiobrasOtra
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoManiobraOtra = -1) then
   New.idTipoManiobraOtra = GEN_ID(GenTipoManiobraOtra,1);
END^

SET TERM ; ^


CREATE TABLE tugCuartosMaquinasOtra
(
  idCuartoMaquinaOtra    int    DEFAULT -1
 , CuartoMaquinaOtra    varchar(300)
 , bVisible    smallint DEFAULT 1 
);

INSERT INTO tugCuartosMaquinasOtra
(idCuartoMaquinaOtra, CuartoMaquinaOtra, bVisible)
VALUES
(0, 'Desconocido', 1);

CREATE GENERATOR GenCuartoMaquinasOtra

SET GENERATOR GenCuartoMaquinasOtra TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugCuartoMaquinasOtra FOR tugCuartosMaquinasOtra
BEFORE INSERT POSITION 0
AS
BEGIN
    if (New.idCuartoMaquinaOtra = -1) then
       New.idCuartoMaquinaOtra = GEN_ID (GenCuartoMaquinasOtra,1);
END^

SET TERM ; ^ 

CREATE TABLE tugAlternaControlada
( idAlternaControlada    int   DEFAULT -1
 , alternaControlada    varchar(300)
 , bVisible    smallint DEFAULT 1
);

INSERT INTO tugAlternaControlada
(idAlternaControlada, alternaControlada, bVisible)
VALUES
(0, 'Desconocido', 1);

CREATE GENERATOR GenTugAlternaControlada;

SET GENERATOR GenTugAlternaControlada TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugAlternaControlada FOR tugAlternaControlada
BEFORE INSERT POSITION 0
AS
BEGIN
  if (New.idAlternaControlada = -1) then
    New.idAlternaControlada = GEN_ID (GenTugAlternaControlada, 1);
END;

SET TERM ; ^ 

CREATE TABLE tugFrecuenciasVariables
(
 idFrecuenciaVariable    int    DEFAULT -1
, FrecuenciaVariable    varchar(300)
, bVisible    smallint    DEFAULT 1
);

INSERT INTO tugFrecuenciasVariables
 (idFrecuenciaVariable, FrecuenciaVariable, bVisible)
VALUES
 (0, 'Desconocido', 1);

CREATE GENERATOR GenTugFrecuenciaVariable;

SET GENERATOR GenTugFrecuenciaVariable TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugFrecuenciaVariable FOR tugFrecuenciasVariables
BEFORE INSERT POSITION 0
AS
BEGIN
  if (New.idFrecuenciaVariable = -1) then
    New.idFrecuenciaVariable = GEN_ID(GenTugFrecuenciaVariable, 1);
END^ 
SET TERM ; ^ 

CREATE TABLE tugNroAccesoOpAdy
(
  idNroAccesoOpAdy    INT    DEFAULT -1
 , NroAccesoOpAdy    varchar(300)
 , bVisible    smallint    DEFAULT 1 
);

INSERT INTO tugNroAccesoOpAdy
 (idNroAccesoOpAdy, NroAccesoOpAdy, bVisible)
VALUES
 (0,'Desconocido', 1);

CREATE GENERATOR GenTugNroAccesoOpAdy;

SET GENERATOR GenTugNroAccesoOpAdy TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugNroAccesoOpAdy FOR tugNroAccesoOpAdy
BEFORE INSERT POSITION 0
AS
BEGIN
   if (New.idNroAccesoOpAdy = -1) then
     New.idNroAccesoOpAdy = GEN_ID (GenTugNroAccesoOpAdy, 1);
END^ 

SET TERM ; ^


CREATE TABLE tugCabParacaidasOtro
(
  idCabParacaidasOtro    INT    DEFAULT -1
 , cabParacaidasOtro    varchar(300)
 , bVisible    smallint    DEFAULT 1
);

INSERT INTO tugCabParacaidasOtro
(idCabParacaidasOtro, cabParacaidasOtro, bVisible )
VALUES
(0,'Desconocido', 1);

CREATE GENERATOR GenTugCabParOtro;

SET GENERATOR GenTugCabParOtro TO 0;

SET TERM ^ ;

CREATE TRIGGER idTugCabParacaidasOtro FOR tugCabParacaidasOtro
BEFORE INSERT POSITION 0
AS
BEGIN
    if (New.idCabParacaidasOtro = 1) then
       New.idCabPAracaidasOtro = GEN_ID (GenTugCabParOtro, 1);

END^
SET TERM ; ^

CREATE TABLE tugCabParacaidasContrapesoOtro 
(
  idCabParacaidasContrapesoOtro    INT  DEFAULT -1
 , CabParacaidasContrapesoOtro    varchar (300)
 , bVisible    smallint    DEFAULT 1
);

INSERT INTO tugCabParacaidasContrapesoOtro
(idCabParacaidasContrapesoOtro, cabParacaidasContrapesoOtro, bVisible)
VALUES
(0, 'Desconocido', 1);

CREATE GENERATOR GenTugCabParContrOtro;

SET GENERATOR GenTugCabParContrOtro;

SET TERM ^ ;

CREATE TRIGGER itTugCabParacContrapesoOtro FOR tugCabParacaidasContrapesoOtro
BEFORE INSERT POSITION 0
AS
BEGIN
     if (New.idCabParacaidasContrapesoOtro = 1) then
        New.idCabParacaidasContrapesoOtro = GEN_ID(GenTugCabParContrOtro, 1);
END^ 
SET TERM ; ^
<F5>
ALTER TABLE tbEquipos add fHabilitacion DATE ;
ALTER TABLE tbEquipos add expConservador varchar (50);
ALTER TABLE tbEquipos add expHabilitacion varchar (50);

ALTER TABLE tbEquipos drop TM_Otras;
ALTER TABLE tbEquipos drop CM_Otras;
ALTER TABLE tbEquipos drop T_alternaControlada;
ALTER TABLE tbEquipos drop T_frecVariable;
ALTER TABLE tbEquipos drop R_accesosOpyAd;
ALTER TABLE tbEquipos drop TPCab_Otro;
ALTER TABLE tbEquipos drop TPContr_Otro;

ALTER TABLE tbEquipos add refTmOtras int default 0;
ALTER TABLE tbEquipos add refCmOtras int default 0;
ALTER TABLE tbEquipos add refTAltControlada int default 0;
ALTER TABLE tbEquipos add refFrecVariable int default 0;
ALTER TABLE tbEquipos add refRAccOpAdy int default 0;
ALTER TABLE tbEquipos add refTPCabOtro int default 0;
ALTER TABLE tbEquipos add refTPContrOtro int default 0;



