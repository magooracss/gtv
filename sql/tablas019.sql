drop table tbComprasPagos;
CREATE TABLE tbComprasPagos
(
	idCompraPago		"guid"		NOT NULL
	,refCompra		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,nMonto		float DEFAULT 0
	,refOP		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	
);

insert into tbComprasPagos
(idCompraPago, refCompra, nMonto, refOP)
SELECT idCompra, idCompra, nTotal, refOrdenPago
FROM tbCompras
WHERE    (refOrdenPago <> '{00000000-0000-0000-0000-000000000000}')
     and (refProveedor <> '{FB91929B-BF9B-4600-BA3A-7A023939D202}')
	 and (refProveedor <> '{8C9D3671-5D4B-4BE7-898C-9BA18D7B6681}')
	 

alter table tbOrdenesPago add nPagado float default 0;

update tbOrdenesPago
set nPagado = nTotalAPagar ;

update tbOrdenesPago
set nTotalAPagar = 0;

update tbCompras
set bPagada = 1
where    (refOrdenPago <> '{00000000-0000-0000-0000-000000000000}')
     and (refProveedor <> '{FB91929B-BF9B-4600-BA3A-7A023939D202}')
	 and (refProveedor <> '{8C9D3671-5D4B-4BE7-898C-9BA18D7B6681}')
	 	
