SET TERM ^ ;

CREATE TRIGGER NumeroOrdenPago FOR TBORDENESPAGO
BEFORE UPDATE POSITION 0
AS
BEGIN 
    If (New.NumeroOrdenPago = -1) then
   New.NumeroOrdenPago = GEN_ID(GenNumeroOrdenPago,1);
END

SET TERM ; ^