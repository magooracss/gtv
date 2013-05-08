ALTER TABLE tbCompras ADD  nroPtoVenta int DEFAULT 0;
ALTER TABLE tbCompras ADD  nroFactura int DEFAULT 0;
ALTER TABLE tbCompras DROP nroComprobante;
ALTER TABLE tbCompras ADD PercepIVA float DEFAULT 0;