--Version GTV 0.29

alter table tbCheques add nroInterno integer default -1;


CREATE GENERATOR GenChequeNroInterno;

SET GENERATOR GenChequeNroInterno TO 0;

SET TERM ^ ;

CREATE TRIGGER ChequesNroInterno FOR tbCheques
BEFORE INSERT OR UPDATE POSITION 0
AS 
BEGIN 
    If (New.nroInterno = -1) then
   New.nroInterno = GEN_ID(GenChequeNroInterno,1);
END^

SET TERM ; ^

UPDATE tbCheques
SET NroInterno = -1;


