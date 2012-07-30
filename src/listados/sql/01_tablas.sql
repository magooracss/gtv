CREATE TABLE tcListados
(
   idListado		int	NOT NULL DEFAULT -1
  ,NombreListado	varchar (500)
  ,refGrupo			int		DEFAULT 0
  ,refFormulario	int		DEFAULT 0
  ,RutaReporte		varchar (500)
  ,bVisible			smallint	DEFAULT 1
);

CREATE TABLE tcListadosGrupos
(
	idListadoGrupo	int	NOT NULL DEFAULT -1
	,ListadoGrupo	varchar(100)
	,bVisible		smallint	DEFAULT 1
);

INSERT INTO tcListadosGrupos
(idListadoGrupo, ListadoGrupo,bVisible)
VALUES
(1,'Remitos',1);

INSERT INTO tcListados
(idListado, NombreListado, refGrupo, refFormulario, RutaReporte, bVisible)
VALUES
(1,'Remitos pendientes de presentación',1,1,'remipresenta.lrf',1);

CREATE INDEX IDX_TR_REMITOS ON TRRemitoEquipos (refRemito);
