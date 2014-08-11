INSERT INTO tugFacturasEstados 
(idFacturaEstado, Estado, bVisible)
VALUES
(4,'Aprobada',1);

CREATE TABLE EmpresasAFacturar 
(
   id		"guid"		NOT NULL
 , tipo_id	integer	DEFAULT 0
 , ref_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , razonSocial	varchar(500)
 , cuit	varchar(20)
 , condicionFiscal_id	integer default 0
 , domicilio	varchar(500)
 , localidad_id	integer	default 0
 , cliente_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , bVisible	smallint	default 1
 );
 
---ACOMODO LOS DATOS DE CLIENTES QUE DABAN UN ERROR AL ACTUALIZAR 
UPDATE tbClientes
SET HabilitacionFecha = '01/01/1900'
WHERE HabilitacionFecha is null;

UPDATE tbClientes
SET nMontoAbono = 0
WHERE nMontoAbono is null;

UPDATE tbClientes
SET HabilitacionExp = ''
WHERE HabilitacionExp is null;

---ACOMODO LOS DATOS DE FACTURACION

--- Los edificios sin administrador
INSERT INTO EmpresasAFacturar
(id, tipo_id, ref_id, razonSocial, cuit, condicionFiscal_id
   , domicilio, localidad_id, cliente_id, bVisible)
SELECT C.idCliente, 2, C.idCliente, C.cNombre, C.cCUIT, c.refCondicionFiscal
     , C.cDomicilio, C.refLocalidad, C.idCliente, 1  
FROM tbClientes C
   INNER JOIN tbAdministradores A ON C.refAdministrador = A.idAdministrador
WHERE (C.bVisible = 1)
      and ( (A.cRazonSocial is null)
	         or
            (A.cRazonSocial = '')
          );  			

--- Los edificios con administrador
INSERT INTO EmpresasAFacturar
(id, tipo_id, ref_id, razonSocial, cuit, condicionFiscal_id
   , domicilio, localidad_id, cliente_id, bVisible)
SELECT A.idAdministrador, 1, A.idAdministrador, C.cNombre, C.cCUIT, c.refCondicionFiscal
     , C.cDomicilio, C.refLocalidad, C.idCliente, 1  
FROM tbClientes C
   INNER JOIN tbAdministradores A ON C.refAdministrador = A.idAdministrador
WHERE (C.bVisible = 1)
      and ( A.cRazonSocial <> ''); 	


ALTER TABLE Facturas add ImpNeto float default 0;
ALTER TABLE Facturas add ImpIVA float default 0;
ALTER TABLE Facturas add ImpImpuestos float default 0; 	  

ALTER TABLE tbClientes add bActivo smallint default 1;
UPDATE tbClientes SET bActivo = 1;