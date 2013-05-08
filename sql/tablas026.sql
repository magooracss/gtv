CREATE TABLE tbCompensaciones
(
 idCompensacion    "guid"	 NOT NULL
, refOPOrigen    "guid"	 DEFAULT '{00000000-0000-0000-0000-000000000000}'
, monto    float DEFAULT 0
, refCompra    "guid"	 DEFAULT '{00000000-0000-0000-0000-000000000000}'
, fCompensacion   date
);

INSERT INTO tbCompensaciones
(idCompensacion, refOPOrigen, monto)
SELECT idOrdenPago, idOrdenPago, (nPagado - nTotalAPagar) 
FROM tbOrdenesPago
WHERE ((nPagado - nTotalAPagar) > 1)
      and (nTotalAPagar > 0)    ;


