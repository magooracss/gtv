CREATE TABLE tugChequesEstados
(
  idChequeEstado	int 		DEFAULT -1
 ,ChequeEstado		varchar (50)	DEFAULT '-'
 ,bVisible           	smallint	DEFAULT 1
);

INSERT INTO tugChequesEstados
(idChequeEstado, ChequeEstado, bVisible)
VALUES
(0, 'Desconocido' ,1);

CREATE GENERATOR GenChequesEstado;

SET GENERATOR GenChequesEstado TO 1;

SET TERM ^ ;

CREATE TRIGGER idtugChequesEstados FOR tugChequesEstados
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idChequeEstado = -1) then
   New.idChequeEstado = GEN_ID(GenChequesEstado,1);
END^

SET TERM ; ^


CREATE TABLE tbCheques
( 
  idCheque		"guid"	NOT NULL
 ,nroCheque		varchar(50)
 ,fCobro		date
 ,fVencimiento		date
 ,refBanco		int	DEFAULT 0
 ,refEstado		int	DEFAULT 0
 ,refRecibidoDe		"guid"	DEFAULT '{00000000-0000-0000-0000-000000000000}'
 ,fRecibido		date
 ,txNotas		varchar(3000)
 ,fEntrega		date
 ,refEntregadoA       	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'   
 ,nMonto		float	DEFAULT 0
 ,bVisible		smallint DEFAULT 1
 
);


CREATE TABLE tugBancos
(
  idBanco			int 		DEFAULT -1
 ,Banco				varchar (50)	DEFAULT '-'
 ,bVisible         	smallint	DEFAULT 1
);

INSERT INTO tugBancos
(idBanco, Banco, bVisible)
VALUES
(0, 'Desconocido' ,1);

CREATE GENERATOR GenBancos;

SET GENERATOR GenBancos TO 1;

SET TERM ^ ;

CREATE TRIGGER idtugBancos FOR tugBancos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idBanco = -1) then
   New.idBanco = GEN_ID(GenBancos,1);
END^

SET TERM ; ^

