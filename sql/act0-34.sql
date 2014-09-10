DROP TABLE Facturas;
DROP TABLE FacturaItems;

CREATE TABLE FacturasCabecera
(  id		"guid"		NOT NULL Primary key
 , cliente_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , fechaPrefactura	date
 , nroPreFactura	integer	default -1
 , refTipoComprobante	integer default 0
 , ptoVenta	integer	default 0
 , nroFactura integer default 0
 , fechaFactura	date
 , bProducto smallint default 0
 , bServicio smallint default 0
 , periodoIni date
 , periodoFin date
 , refFormaPago integer default 0
 , vtoPago date
 , CAE varchar(14) default '00000000000000'
 , vtoCAE date 
 , ImporteNeto float default 0
 , ImporteIVA float default 0
 , estado_id	smallint default 0
 , bVisible	smallint default 1
);


CREATE TABLE FacturasItems
(  id	"guid"		NOT NULL Primary key
 , factura_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , cantidad	float	default 0
 , detalle varchar(2000)
 , precioUnitario	float	default 0
 , precioTotal	float	default 0
 , porcentajeIVA float default 0
);


CREATE TABLE FacturasDocumentos
(  id	"guid"		NOT NULL Primary key
 , factura_id	"guid"  default '{00000000-0000-0000-0000-000000000000}' 
 , tipoDocumento	smallint	default 0
 , documento_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , refEstado	smallint	default 0
 );

CREATE TABLE FacturasCnxAFIP
(
  id	"guid"		NOT NULL Primary key
 , factura_id	"guid"  default '{00000000-0000-0000-0000-000000000000}'
 , fecha	date
 , Observaciones	varchar(1000)
 , Resultado	varchar(1)
 , codigoError	varchar(6)
 , mensajeError	varchar(1000)
 , orden	timestamp default CURRENT_TIMESTAMP
);

CREATE INDEX iDocumentoID ON FacturasDocumentos (documento_id);
CREATE INDEX idPresupuesto ON tbPresupuestos (idPresupuesto);
CREATE INDEX idCuotaPresupuesto ON tbCuotasPresupuesto (idCuotaPresupuesto);
--CREATE INDEX iIDCuotaFecha ON tbCuotasPresupuesto (idCuotaPresupuesto,fVencimiento);
--CREATE INDEX iIDCuotaPresupuestoFecha ON tbCuotasPresupuesto (idCuotaPresupuesto,refPresupuesto, fVencimiento);
--CREATE INDEX iIDCuotaPresVencEstadoNro ON tbCuotasPresupuesto (idCuotaPresupuesto,refPresupuesto, fVencimiento, refEstado, nNrocuota);
--CREATE INDEX iIDCuotaPresVencEstado ON tbCuotasPresupuesto (idCuotaPresupuesto,refPresupuesto, fVencimiento, refEstado);

