CREATE TABLE Prefacturacion
(  id		"guid"		NOT NULL Primary key
 , cliente_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , fecha	date
 , documento_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , tipoDocumento	smallint	default 0
 , cantidad	float	default 0
 , detalle varchar(2000)
 , precioUnitario	float	default 0
 , precioTotal	float	default 0
 , refEstado	smallint	default 0
 , nroPreFactura	integer	default -1
 , bVisible	smallint default 1
);



CREATE GENERATOR GenPrefactura;
SET GENERATOR GenPrefactura TO 1;

SET TERM ^ ;

CREATE TRIGGER nroPrefactura FOR Prefacturacion
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nroPrefactura = -1) then
   New.nroPrefactura = GEN_ID(GenPrefactura,1);
END^

SET TERM ; ^

