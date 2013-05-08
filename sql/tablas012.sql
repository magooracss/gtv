CREATE TABLE tbComprasPagos
(
	idCompraPago				"guid"		NOT NULL
	,refCompra					"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refOPFormaDePago			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,nMonto						float		DEFAULT 0
);
