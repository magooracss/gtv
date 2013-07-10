INSERT INTO tcListadosGrupos
(idListadoGrupo, ListadoGrupo,bVisible)
VALUES
(2,'Contabilidad',1);

INSERT INTO tcListados
(idListado, NombreListado, refGrupo, refFormulario, RutaReporte, bVisible)
VALUES
(2,'Listado de Compras',2,1,'lstCompras.lrf',1);

SELECT  C.Fecha
       ,P.Codigo
	   ,P.Cuenta
	   ,Pr.cRazonSocial
	   ,Pr.cNombreFantasia
	   ,Pr.cCuit
	   ,CI.nMontoTotal as Monto
FROM tbCompras C
	 INNER JOIN tbComprasItems CI ON CI.refCompra = C.idCompra
	 LEFT JOIN tugPlanDeCuentas P ON P.idCuenta = CI.refImputacion
	 LEFT JOIN tbProveedores Pr ON Pr.idProveedor = C.refProveedor
WHERE     (C.fecha >= :fechaIni)
      and (C.fecha <= :fechaFin)