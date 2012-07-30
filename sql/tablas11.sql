alter table tbCompras add refOrdenPago "guid" DEFAULT '{00000000-0000-0000-0000-000000000000}';

CREATE TABLE tbComprasFormasDePago
(
	idCompraFormaDePago			"guid"		NOT NULL
	,refCompra					"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refFormaPago				int			DEFAULT 0
	,refCheque					"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refBanco					int			DEFAULT 0
	,nMonto						float		DEFAULT 0
	,bVisible					smallint	DEFAULT 1
);