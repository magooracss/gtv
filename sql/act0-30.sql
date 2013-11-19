ALTER TABLE tbCheques ADD nroInterno int DEFAULT -1;

UPDATE tbCheques set nroInterno = -1 WHERE nroInterno is null;

CREATE GENERATOR GenChequeNroInterno;

SET GENERATOR GenChequeNroInterno TO 0;

SET TERM ^ ;

CREATE TRIGGER chequeNroInterno FOR tbCheques
BEFORE INSERT OR UPDATE POSITION 0
AS 
BEGIN 
    If (New.nroInterno = -1) then
           New.nroInterno = GEN_ID(GenChequeNroInterno,1);
END^

SET TERM ; ^