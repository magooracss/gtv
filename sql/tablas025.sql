INSERT INTO TCLISTADOS 
(IDLISTADO, NOMBRELISTADO, REFGRUPO, REFFORMULARIO, RUTAREPORTE, BVISIBLE)
VALUES
(12,'Cuenta corriente',3,3,'provcc.lrf',1);

ALTER TABLE tbContactosCliente add refFormaContacto integer DEFAULT 0;
ALTER TABLE tbContactosCliente add cContacto varchar(3000);

CREATE TABLE tbPropietarios
(
	idPropietarioCliente "guid" DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, refCliente "guid"	DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, denominacion varchar(500)
	, cuit varchar(15)
	, domLegal varchar(500)
	, refLocalidadLegal integer DEFAULT 0
	, domFacturacion varchar(500)
	, refLocalidadFact integer DEFAULT 0
	, notas varchar(3000)
	, bVisible smallint DEFAULT 1
);

