unit dmfacturas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, rxmemds
  ,dmgeneral, db
  ;

const
  RESP_INSCRIPTO = 3;
  FACTURA_T = 4;
  FACTURA_A = 1;
  FACTURA_B = 2;
  FACTURA_C = 3;

  FACTURA_ESTADO_SIN_FACTURAR = 1;
  FACTURA_ESTADO_APROBADA = 4;
  FACTURA_ESTADO_ANULADA = 3;
  FACTURA_ESTADO_FACTURADA = 2;


  TD_LIBRE = 0; //Tipo de documento libre
  TD_REMITO = 1; //Tipo de documento remito
  TD_PRESUPUESTO = 2; //Tipo de documento presupuesto

  EP_NULO = -1; //Estado nulo
  EP_PARAFACTURAR = 0;//Estado prefacturacion: Para facturar: No esta prefacturado
  EP_PREFACTURADO = 1;//Estado Prefacturacion: Ya paso por la prefacturacion y tiene Nro
  EP_FACTURADO = 2;  //Estado Prefacturacion: Ya tiene asociada una factura legal

  CAE_NULO = '00000000000000';

type

  { TDM_Facturas }

  TDM_Facturas = class(TDataModule)
    CondFiscalID: TZQuery;
    CondFiscalIDBVISIBLE: TSmallintField;
    CondFiscalIDCOMPRENTREGA: TLongintField;
    CondFiscalIDCOMPRRECIBE: TLongintField;
    CondFiscalIDCONDICIONFISCAL: TStringField;
    CondFiscalIDIDCONDICIONFISCAL: TLongintField;
    FacturasDocumentosCodigoClientePresupuesto: TStringField;
    FacturasDocumentosCodigoClienteRemito: TStringField;
    FacturasDocumentosidClientePresupuesto: TStringField;
    FacturasDocumentosidClienteRemito: TStringField;
    FacturasDocumentoslxDetalle: TStringField;
    FacturasDocumentosNombreClientePresupuesto: TStringField;
    FacturasDocumentosNombreClienteRemito: TStringField;
    FacturasDocumentosNroPresupuesto: TLongintField;
    FacturasDocumentosPresupuestoCuota: TLongintField;
    FacturasDocumentosPresupuestoDetalles: TStringField;
    FacturasDocumentosPresupuestoFecha: TDateTimeField;
    FacturasDocumentosRemitoDetalles: TStringField;
    FacturasDocumentosRemitoFecha: TDateTimeField;
    FacturasDocumentosRemitoNro: TLongintField;
    qPresupuestosSinPF: TZQuery;
    qPresupuestosSinPFBACEPTADO: TSmallintField;
    qPresupuestosSinPFBVISIBLE: TLongintField;
    qPresupuestosSinPFBVISIBLE_1: TSmallintField;
    qPresupuestosSinPFCRECEPCIONO: TStringField;
    qPresupuestosSinPFFCAMBIOESTADO: TDateField;
    qPresupuestosSinPFFEMISION: TDateField;
    qPresupuestosSinPFFPAGO: TDateField;
    qPresupuestosSinPFFVENCIMIENTO: TDateField;
    qPresupuestosSinPFIDCUOTAPRESUPUESTO: TStringField;
    qPresupuestosSinPFIDPRESUPUESTO: TStringField;
    qPresupuestosSinPFNMONTO: TFloatField;
    qPresupuestosSinPFNNROCUOTA: TLongintField;
    qPresupuestosSinPFNPRESUPUESTO: TLongintField;
    qPresupuestosSinPFREFCLIENTE: TStringField;
    qPresupuestosSinPFREFEMPLEADO: TLongintField;
    qPresupuestosSinPFREFESTADO: TLongintField;
    qPresupuestosSinPFREFESTADO_1: TLongintField;
    qPresupuestosSinPFREFPRESUPUESTO: TStringField;
    qPresupuestosSinPFREFTIPO: TLongintField;
    qPresupuestosSinPFTXDOCUMENTO: TBlobField;
    qPresupuestosSinPFTXMOTIVO: TStringField;
    qPresupuestosSinPFTXOBSERVACIONES: TStringField;
    qRemitosSinPF: TZQuery;
    qRemitosSinPFBFACTURADO: TSmallintField;
    qRemitosSinPFBFACTURAR: TSmallintField;
    qRemitosSinPFBPRESENTADO: TSmallintField;
    qRemitosSinPFBSINCARGO: TSmallintField;
    qRemitosSinPFBVISIBLE: TSmallintField;
    qRemitosSinPFFFECHA: TDateField;
    qRemitosSinPFIDREMITO: TStringField;
    qRemitosSinPFNREMITO: TLongintField;
    qRemitosSinPFREFCLIENTE: TStringField;
    qRemitosSinPFREFFACTURA: TStringField;
    qRemitosSinPFREFMOTIVO: TLongintField;
    qRemitosSinPFREFORDENTRABAJO: TStringField;
    qRemitosSinPFTXDETALLES: TStringField;
    qTodosLosDocumentos: TZQuery;
    DocumentosPorFacturaDOCUMENTO_ID: TStringField;
    DocumentosPorFacturaFACTURA_ID: TStringField;
    DocumentosPorFacturaID: TStringField;
    DocumentosPorFacturaREFESTADO: TSmallintField;
    DocumentosPorFacturaTIPODOCUMENTO: TSmallintField;
    facturasDocSELDOCUMENTO_ID: TStringField;
    facturasDocSELFACTURA_ID: TStringField;
    facturasDocSELID: TStringField;
    facturasDocSELREFESTADO: TSmallintField;
    facturasDocSELTIPODOCUMENTO: TSmallintField;
    FacturasDocumentos: TRxMemoryData;
    FacturasItemsCantidad: TFloatField;
    facturasDocDEL: TZQuery;
    FacturasItemsDetalle: TStringField;
    FacturasItemsfactura_id: TStringField;
    FacturasItemsid: TStringField;
    FacturasItemsPorcentajeIVA: TFloatField;
    FacturasItemsPrecioTotal: TFloatField;
    FacturasItemsPrecioUnitario: TFloatField;
    FacturasCabecerabProducto: TLongintField;
    FacturasCabecerabServicio: TLongintField;
    FacturasCabeceraCAE: TStringField;
    FacturasCabeceracliente_id: TStringField;
    FacturasCabeceraestado_id: TLongintField;
    FacturasCabecerafechaFactura: TDateTimeField;
    FacturasCabecerafechaPrefactura: TDateTimeField;
    FacturasCabeceraid: TStringField;
    FacturasCabeceraimporteIVA: TFloatField;
    FacturasCabeceraimporteNeto: TFloatField;
    FacturasCabeceralxEstado: TStringField;
    FacturasCabeceranroFactura: TLongintField;
    FacturasCabeceranroPrefactura: TLongintField;
    FacturasCabeceranroPtoVenta: TLongintField;
    FacturasCabeceraPeriodoFin: TDateTimeField;
    FacturasCabeceraPeriodoIni: TDateTimeField;
    FacturasCabecerarefComprobante: TLongintField;
    FacturasCabecerarefFormaPago: TLongintField;
    FacturasCabeceravtoCAE: TDateTimeField;
    FacturasCabeceravtoPago: TDateTimeField;
    FacturasDocumentosdocumento_id: TStringField;
    FacturasDocumentosfactura_id: TStringField;
    FacturasDocumentosid: TStringField;
    FacturasDocumentoslxCliente: TStringField;
    FacturasDocumentoslxCodigo: TStringField;
    FacturasDocumentoslxDocumento: TStringField;
    FacturasDocumentoslxEstado: TStringField;
    FacturasDocumentoslxFecha: TDateTimeField;
    FacturasDocumentoslxNroDocumento: TLongintField;
    FacturasDocumentosrefEstado: TLongintField;
    FacturasDocumentostipoDocumento: TLongintField;
    facturasDocINS: TZQuery;
    facturasDocSEL: TZQuery;
    facturasItemsSELCANTIDAD: TFloatField;
    facturasItemsSELDETALLE: TStringField;
    facturasItemsSELFACTURA_ID: TStringField;
    facturasItemsSELID: TStringField;
    facturasItemsSELPORCENTAJEIVA: TFloatField;
    facturasItemsSELPRECIOTOTAL: TFloatField;
    facturasItemsSELPRECIOUNITARIO: TFloatField;
    facturasDocUPD: TZQuery;
    facturasSELBPRODUCTO: TSmallintField;
    facturasSELBSERVICIO: TSmallintField;
    facturasSELBVISIBLE: TSmallintField;
    facturasSELCAE: TStringField;
    facturasSELCLIENTE_ID: TStringField;
    facturasSELESTADO_ID: TSmallintField;
    facturasSELFECHAFACTURA: TDateField;
    facturasSELFECHAPREFACTURA: TDateField;
    facturasSELID: TStringField;
    facturasSELIMPORTEIVA: TFloatField;
    facturasSELIMPORTENETO: TFloatField;
    facturasSELNROFACTURA: TLongintField;
    facturasSELNROPREFACTURA: TLongintField;
    facturasSELPERIODOFIN: TDateField;
    facturasSELPERIODOINI: TDateField;
    facturasSELPTOVENTA: TLongintField;
    facturasSELREFFORMAPAGO: TLongintField;
    facturasSELREFTIPOCOMPROBANTE: TLongintField;
    facturasSELVTOCAE: TDateField;
    facturasSELVTOPAGO: TDateField;
    DocumentosPorFactura: TZQuery;
    ItemsPorFacturaCANTIDAD: TFloatField;
    ItemsPorFacturaDETALLE: TStringField;
    ItemsPorFacturaFACTURA_ID: TStringField;
    ItemsPorFacturaID: TStringField;
    ItemsPorFacturaPORCENTAJEIVA: TFloatField;
    ItemsPorFacturaPRECIOTOTAL: TFloatField;
    ItemsPorFacturaPRECIOUNITARIO: TFloatField;
    qLevantarAbonos: TZQuery;
    facturasItemsINS: TZQuery;
    facturasItemsSEL: TZQuery;
    ItemsPorFactura: TZQuery;
    qGrupoFacturacion: TZQuery;
    qGrupoFacturacionBVISIBLE: TSmallintField;
    qGrupoFacturacionDIAFACTURACION: TLongintField;
    qGrupoFacturacionGRUPOFACTURACION: TStringField;
    qGrupoFacturacionIDGRUPOFACTURACION: TLongintField;
    qLevantarRemitosAbono: TZQuery;
    qLevantarAbonosBVISIBLE: TSmallintField;
    qLevantarAbonosCCODIGO: TStringField;
    qLevantarAbonosCCUIT: TStringField;
    qLevantarAbonosCDOMICILIO: TStringField;
    qLevantarAbonosCENTRECALLE1: TStringField;
    qLevantarAbonosCENTRECALLE2: TStringField;
    qLevantarAbonosCMANZANA: TStringField;
    qLevantarAbonosCNOMBRE: TStringField;
    qLevantarAbonosCNROCASA: TStringField;
    qLevantarAbonosCPARCELA: TStringField;
    qLevantarAbonosCSECCION: TStringField;
    qLevantarAbonosFINICIO: TDateField;
    qLevantarAbonosHABILITACIONEXP: TStringField;
    qLevantarAbonosHABILITACIONFECHA: TDateField;
    qLevantarAbonosIDCLIENTE: TStringField;
    qLevantarAbonosNIVA: TFloatField;
    qLevantarAbonosNMONTOABONO: TFloatField;
    qLevantarAbonosREFABONO: TLongintField;
    qLevantarAbonosREFADMINISTRADOR: TStringField;
    qLevantarAbonosREFCONDICIONFISCAL: TLongintField;
    qLevantarAbonosREFCONSERVADOR: TStringField;
    qLevantarAbonosREFDESTINO: TLongintField;
    qLevantarAbonosREFGRUPOFACTURACION: TLongintField;
    qLevantarAbonosREFLOCALIDAD: TLongintField;
    qLevantarAbonosREFRESPTECNICO: TStringField;
    qLevantarAbonosUNIDADFUNCIONAL: TLongintField;
    qLevantarRemitosAbonoBFACTURADO: TSmallintField;
    qLevantarRemitosAbonoBFACTURAR: TSmallintField;
    qLevantarRemitosAbonoBPRESENTADO: TSmallintField;
    qLevantarRemitosAbonoBSINCARGO: TSmallintField;
    qLevantarRemitosAbonoBVISIBLE: TSmallintField;
    qLevantarRemitosAbonoFFECHA: TDateField;
    qLevantarRemitosAbonoIDREMITO: TStringField;
    qLevantarRemitosAbonoNREMITO: TLongintField;
    qLevantarRemitosAbonoREFCLIENTE: TStringField;
    qLevantarRemitosAbonoREFFACTURA: TStringField;
    qLevantarRemitosAbonoREFMOTIVO: TLongintField;
    qLevantarRemitosAbonoREFORDENTRABAJO: TStringField;
    qLevantarRemitosAbonoTXDETALLES: TStringField;
    qListaFacturasCLIENTE: TStringField;
    qListaFacturasESTADOFACTURA: TStringField;
    qListaFacturasFECHAFACTURA: TDateField;
    qListaFacturasID: TStringField;
    qListaFacturasLETRAFACTURA: TStringField;
    qListaFacturasNROFACTURA: TLongintField;
    qListaFacturasNROPTOVENTA: TLongintField;
    qListaFacturasTOTALFACTURA: TFloatField;
    facturasItemsUPD: TZQuery;
    qTodosLosDocumentosCODIGOCLIENTEPRESUPUESTO: TStringField;
    qTodosLosDocumentosCODIGOCLIENTEREMITO: TStringField;
    qTodosLosDocumentosDOCUMENTO_ID: TStringField;
    qTodosLosDocumentosFACTURA_ID: TStringField;
    qTodosLosDocumentosID: TStringField;
    qTodosLosDocumentosIDCLIENTEPRESUPUESTO: TStringField;
    qTodosLosDocumentosIDCLIENTEREMITO: TStringField;
    qTodosLosDocumentosNOMBRECLIENTEPRESUPUESTO: TStringField;
    qTodosLosDocumentosNOMBRECLIENTEREMITO: TStringField;
    qTodosLosDocumentosNROPRESUPUESTO: TLongintField;
    qTodosLosDocumentosPRESUPUESTOCUOTA: TLongintField;
    qTodosLosDocumentosPRESUPUESTODETALLES: TStringField;
    qTodosLosDocumentosPRESUPUESTOFECHA: TDateField;
    qTodosLosDocumentosPRESUPUESTOMONTO: TFloatField;
    qTodosLosDocumentosPRESUPUESTOVENCIMIENTO: TDateField;
    qTodosLosDocumentosREFESTADO: TSmallintField;
    qTodosLosDocumentosREMITODETALLES: TStringField;
    qTodosLosDocumentosREMITOFECHA: TDateField;
    qTodosLosDocumentosREMITONRO: TLongintField;
    qTodosLosDocumentosTIPODOCUMENTO: TSmallintField;
    ReciboFacturaSELFACTURA_ID: TStringField;
    ReciboFacturaSELID: TStringField;
    ReciboFacturaSELRECIBO_ID: TStringField;
    RecibosPorFacturaFACTURA_ID: TStringField;
    RecibosPorFacturaFECHA: TDateField;
    RecibosPorFacturaID: TStringField;
    RecibosPorFacturaNRORECIBO: TStringField;
    RecibosPorFacturaRECIBO_ID: TStringField;
    remitoFactura: TRxMemoryData;
    ReciboFacturaDel: TZQuery;
    facturaPorId: TZQuery;
    CondicionFiscalBVISIBLE: TSmallintField;
    CondicionFiscalGENERADOR: TStringField;
    CondicionFiscalID: TLongintField;
    CondicionFiscalLETRA: TStringField;
    facturaPorIdBVISIBLE: TSmallintField;
    facturaPorIdGENERADOR: TStringField;
    facturaPorIdID: TLongintField;
    facturaPorIdLETRA: TStringField;
    FacturasItems: TRxMemoryData;
    nroFactura: TZQuery;
    nroFacturaNRO: TLargeintField;
    qListaFacturas: TZQuery;
    FacturasCabecera: TRxMemoryData;
    RemitoFacturaDel: TZQuery;
    reciboFacturafactura_id: TStringField;
    reciboFacturaFecha: TDateField;
    reciboFacturaid: TStringField;
    RemitoFacturaINS: TZQuery;
    reciboFacturaNroRecibo: TStringField;
    reciboFacturarecibo_id: TStringField;
    RemitoFacturaSEL: TZQuery;
    RemitoFacturaSELFACTURA_ID: TStringField;
    RemitoFacturaSELID: TStringField;
    RemitoFacturaSELREMITO_ID: TStringField;
    RemitoFacturaUPD: TZQuery;
    facturasINS: TZQuery;
    ReciboFacturaINS: TZQuery;
    RemitosPorFactura: TZQuery;
    facturasSEL: TZQuery;
    CondicionFiscal: TZQuery;
    RecibosPorFactura: TZQuery;
    ReciboFacturaSEL: TZQuery;
    FacturasUPD: TZQuery;
    reciboFactura: TRxMemoryData;
    ReciboFacturaUPD: TZQuery;
    remitoFacturafactura_id: TStringField;
    remitoFacturafFecha: TDateTimeField;
    remitoFacturaid: TStringField;
    remitoFacturanRemito: TLongintField;
    remitoFacturaremito_id: TStringField;
    remitoFacturatxDetalles: TStringField;
    FacturasDEL: TZQuery;
    facturaItemsDEL: TZQuery;
    RemitosPorFacturaBFACTURADO: TSmallintField;
    RemitosPorFacturaBFACTURAR: TSmallintField;
    RemitosPorFacturaBPRESENTADO: TSmallintField;
    RemitosPorFacturaBSINCARGO: TSmallintField;
    RemitosPorFacturaBVISIBLE: TSmallintField;
    RemitosPorFacturaFACTURA_ID: TStringField;
    RemitosPorFacturaFFECHA: TDateField;
    RemitosPorFacturaID: TStringField;
    RemitosPorFacturaIDREMITO: TStringField;
    RemitosPorFacturaNREMITO: TLongintField;
    RemitosPorFacturaREFCLIENTE: TStringField;
    RemitosPorFacturaREFFACTURA: TStringField;
    RemitosPorFacturaREFMOTIVO: TLongintField;
    RemitosPorFacturaREFORDENTRABAJO: TStringField;
    RemitosPorFacturaREMITO_ID: TStringField;
    RemitosPorFacturaTXDETALLES: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure FacturasDocumentosAfterInsert(DataSet: TDataSet);
    procedure FacturasCabeceraAfterInsert(DataSet: TDataSet);
    procedure reciboFacturaAfterInsert(DataSet: TDataSet);
    procedure remitoFacturaAfterInsert(DataSet: TDataSet);
  private
    function getIdFacturaListado: GUID_ID;
    procedure setLetraFactura(AValue: integer);
    procedure MarcaRemitoFacturado (remito_id: GUID_ID; marca: integer);

    procedure AjustarTablaMemoria;

  public
    property idFacturaListado: GUID_ID read getIdFacturaListado;
    property LetraFactura: integer write setLetraFactura;

    procedure LevantarFacturas (tipo: integer);

    procedure CargarCliente (idCliente: GUID_ID);

    procedure NuevaFactura;
    procedure LevantarFacturaID (factura_id: GUID_ID);
    function idFacturaPorCondicionFiscal (idCondFiscal: integer): integer;

    procedure AsignarNroFactura (idTipoFactura: integer);

    procedure NuevoItem;
    procedure AgregarDatosItems (cantidad: Double; detalle: string; valorUnitario: Double);
    procedure EliminarItem;

    function TotalFacturado: Double;

    procedure GrabarFactura;
    procedure AnularFactura(factura_id: string);

    procedure ReciboVincular (recibo_id: GUID_ID);
    procedure ReciboQuitar;
    procedure GrabarReciboFactura;
    procedure LevantarRecibos (factura_id: GUID_ID);

    procedure RemitoVincular(remito_id: GUID_ID);
    procedure RemitoQuitar;
    procedure GrabarRemitoFactura;
    procedure LevantarRemitos(factura_id: GUID_ID);

    procedure prefacturarGrupo (gf_id: integer);
    function CambiarEstadoFactura (factura_id: GUID_ID): boolean;


    (****************   PREFACTURACION   *******************************)
    procedure LevantarDocumentos (documento, estado: integer; idCliente: GUID_ID);
    procedure levantarDocumentosSinPrefacturar;
    procedure GrabarDocumentos;

  end;

var
  DM_Facturas: TDM_Facturas;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  , dmremitos
  , dmclientes
  , dateutils
  ;

{ TDM_Facturas }

procedure TDM_Facturas.DataModuleCreate(Sender: TObject);
begin
  FacturasDocumentos.Open;
end;

procedure TDM_Facturas.FacturasDocumentosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
    FieldByName('factura_id').asString:= GUIDNULO;
    FieldByName('tipodocumento').asInteger:= TD_LIBRE;
    FieldByName('documento_id').AsString:= GUIDNULO;
    FieldByName('refEstado').AsInteger:= EP_PARAFACTURAR;
  end;
end;



procedure TDM_Facturas.FacturasCabeceraAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').AsString:= DM_General.CrearGUID;
    FieldByName('cliente_id').asString:= GUIDNULO;
    FieldByName('fechaPrefactura').AsDateTime:= Now;
    FieldByName('nroPreFactura').asInteger:= -1;
    FieldByName('refTipoComprobante').asInteger:= 0;
    FieldByName('PtoVenta').asInteger:= 0;
    FieldByName('nroFactura').asInteger:= -1;
    FieldByName('fechaFactura').AsDateTime:= Now;
    FieldByName('bProducto').AsInteger:= 0;
    FieldByName('bServicio').AsInteger:= 0;
    FieldByName('periodoIni').AsDateTime:= Now;
    FieldByName('periodoFin').AsDateTime:= Now;
    FieldByName('refFormaPago').asInteger:= 0;
    FieldByName('vtoPago').AsDateTime:= Now;
    FieldByName('CAE').asString:= CAE_NULO;
    FieldByName('vtoCAE').AsDateTime:= Now;
    FieldByName('ImporteNeto').asFloat:= 0;
    FieldByName('ImporteIVA').asFloat:= 0;
    FieldByName('estado_id').AsInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
    FieldByName('lxEstado').asString:= EmptyStr;
    FieldByName('lxCodigo').asString:= EmptyStr;
    FieldByName('lxNroDocumento').asString:= EmptyStr;
    FieldByName('lxFecha').AsDateTime:= now;
    FieldByName('lxCliente').asString:= EmptyStr;
  end;
end;

procedure TDM_Facturas.reciboFacturaAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
//    FieldByName('factura_id').asString:= Facturasid.AsString;
    FieldByName('recibo_id').asString:= GUIDNULO;
  end;
end;

procedure TDM_Facturas.remitoFacturaAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
//    FieldByName('factura_id').asString:= Facturasid.AsString;
    FieldByName('remito_id').asString:= GUIDNULO;
  end;
end;

function TDM_Facturas.getIdFacturaListado: GUID_ID;
begin
  if ((qListaFacturas.Active) and (qListaFacturas.RecordCount > 0)) then
    Result:= qListaFacturasID.AsString
  else
    Result:= GUIDNULO;
end;

procedure TDM_Facturas.setLetraFactura(AValue: integer);
begin
  with FacturasCabecera do
  begin
    Edit;
//    FacturastipoFactura_id.AsInteger:= AValue;
    Post;
  end;
end;
procedure TDM_Facturas.LevantarFacturas(tipo: integer);
var
  sel,fr, cola, where: string;
begin
 sel:= ' SELECT  F.id '
      + ', F.Fecha as FechaFactura '
      + ' , F.NroPtoVenta as NroPtoVenta '
      + ' , F.NroFactura as NroFactura '
      + ' , C.cNombre as Cliente '
      + ' ,tF.letra as LetraFactura '
      + ' ,tFE.Estado as EstadoFactura '
      + ' , SUM (FI.Monto) as TotalFactura ';
 fr:= ' FROM Facturas F '
      + ' LEFT JOIN tugFacturas tF ON tF.id = F.TipoFactura_id '
      + ' LEFT JOIN tugFacturasEstados tFE ON tFE.idFacturaEstado = F.estado_id '
      + ' LEFT JOIN tbClientes as C ON C.idCliente = F.clienteEmpresa_id '
      + ' INNER JOIN FacturaItems FI ON FI.factura_id = F.id ';
 cola:= ' GROUP BY F.id, tF.letra, tFE.Estado, C.cNombre, F.Fecha, F.NroPtoVenta, F.NroFactura '
     + ' ORDER BY F.NroPtoVenta, F.NroFactura ';

 where:= 'WHERE (F.estado_id = '+ IntToStr(tipo) +' )';
  with qListaFacturas do
  begin
    if active then close;
    sql.Clear;
    sql.add(sel);
    sql.add(fr);
    if tipo > 0 then
      sql.Add(where);
    sql.Add(cola);
    Open;
  end;
end;

procedure TDM_Facturas.CargarCliente(idCliente: GUID_ID);
begin
  with FacturasCabecera do
  begin
    Edit;
//    FacturasclienteEmpresa_id.AsString:= idCliente;
    Post;
  end;
end;

procedure TDM_Facturas.NuevaFactura;
begin
  DM_General.ReiniciarTabla(FacturasCabecera);
  DM_General.ReiniciarTabla(FacturasItems);
  DM_General.ReiniciarTabla(reciboFactura);
  DM_General.ReiniciarTabla(remitoFactura);
  FacturasCabecera.Insert;
end;

procedure TDM_Facturas.LevantarFacturaID(factura_id: GUID_ID);
begin
  DM_General.ReiniciarTabla(FacturasCabecera);
  DM_General.ReiniciarTabla(FacturasItems);

  with facturasSEL do
  begin
    if active then close;
    ParamByName('id').asString:= factura_id;
    Open;
    FacturasCabecera.LoadFromDataSet(facturasSEL,0, lmAppend);
    Close;
  end;

  with ItemsPorFactura  do
  begin
    if active then close;
    ParamByName('factura_id').asString:= factura_id;
    Open;
    FacturasItems.LoadFromDataSet(ItemsPorFactura,0, lmAppend);
    Close;
  end;

  LevantarRecibos(factura_id);
  LevantarRemitos(factura_id);
end;

function TDM_Facturas.idFacturaPorCondicionFiscal(idCondFiscal: integer
  ): integer;
begin
  with CondFiscalID do
  begin
    if active then close;
    ParamByName('id').asInteger:= idCondFiscal;
    Open;
    Result:= CondFiscalIDCOMPRENTREGA.AsInteger;
    close;
  end;
end;

procedure TDM_Facturas.AsignarNroFactura(idTipoFactura: integer);
var
  generador: string;
  nroFact: integer;
  PtoVenta: Integer;
begin
  PtoVenta:= StrToIntDef( LeerDato(SECCION_FACTURACION, PUNTO_VENTA), 0);


  with facturaPorId do
  begin
    if active then close;
    ParamByName('id').asInteger:= idTipoFactura;
    Open;
    generador:= 'GEN_FACT_' + facturaPorIdLETRA.asString;
    //facturaPorIdGENERADOR.AsString;
    close;
  end;

  with nroFactura do
  begin
    if active then close;
    sql.Clear;
    sql.Add('SELECT GEN_ID('+ generador +',1) as Nro FROM RDB$DATABASE');
    Open;
    nroFact:= nroFacturaNRO.AsInteger;
  end;

  with FacturasCabecera do
  begin
    Edit;
//    FacturastipoFactura_id.AsInteger:= FACTURA_T;
//    FacturasnroPtoVenta.asInteger:= PtoVenta;
//    FacturasnroFactura.asInteger:= nroFact;
    Post;
  end;
end;

procedure TDM_Facturas.NuevoItem;
begin
  if NOT FacturasItems.Active then FacturasItems.Open;
  FacturasItems.Insert;
end;

procedure TDM_Facturas.AgregarDatosItems(cantidad: Double; detalle: string;
  valorUnitario: Double);
begin
  with FacturasItems do
  begin
//    FacturasItemsCantidad.AsFloat:= cantidad;
//    FacturasItemsDetalle.AsString:= detalle;
//    FacturasItemsPrecioUnitario.AsFloat:= valorUnitario;
//    FacturaItemsMonto.AsFloat:= valorUnitario * cantidad;
    Post;
  end;
end;

procedure TDM_Facturas.EliminarItem;
begin
   facturaItemsDEL.ParamByName('id').AsString:= FacturasItemsid.AsString;
   FacturaItemsDEL.ExecSQL;

   FacturasItems.Delete;
end;

function TDM_Facturas.TotalFacturado: Double;
var
  accum: Double;
begin
  with FacturasItems do
  begin
    DisableControls;
    First;
    accum:= 0;
    While Not Eof do
    begin
//      accum:= accum + FacturaItemsMonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;
  Result:= accum;
end;

procedure TDM_Facturas.GrabarFactura;
begin
  DM_General.GrabarDatos(facturasSEL, facturasINS, FacturasUPD, FacturasCabecera, 'id');
  DM_General.GrabarDatos(facturasItemsSEL, facturasItemsINS, facturasItemsUPD, FacturasItems, 'id');
end;

procedure TDM_Facturas.AnularFactura(factura_id: string);
begin
  with FacturasDEL do
  begin
    ParamByName('id').asString:= factura_id;
    ExecSQL;
  end;
end;

procedure TDM_Facturas.ReciboVincular(recibo_id: GUID_ID);
begin
  With reciboFactura do
  begin
    if not Active then
      Open;
    Insert;
    reciboFacturarecibo_id.asString:= recibo_id;
    Post;
    GrabarReciboFactura;
//8    LevantarRecibos(Facturasid.AsString);
  end;
end;

procedure TDM_Facturas.ReciboQuitar;
begin
  With ReciboFacturaDel do
  begin
    ParamByName('id').asString:= reciboFacturaid.AsString;
    ExecSQL;
  end;

  reciboFactura.Delete;

end;

procedure TDM_Facturas.GrabarReciboFactura;
begin
  DM_General.GrabarDatos(ReciboFacturaSEL, ReciboFacturaINS, ReciboFacturaUPD,reciboFactura, 'id');
end;

procedure TDM_Facturas.LevantarRecibos(factura_id: GUID_ID);
begin
   with RecibosPorFactura do
   begin
     DM_General.ReiniciarTabla(reciboFactura);
     if active then close;
     ParamByName('factura_id').asString:= factura_id;
     Open;
     reciboFactura.LoadFromDataSet(RecibosPorFactura, 0, lmAppend);
     close;
   end;
end;


procedure TDM_Facturas.MarcaRemitoFacturado(remito_id: GUID_ID; marca: integer);
begin
  DM_Remitos.RemitoEditar(remito_id);
  DM_Remitos.tbRemitos.Edit;
  DM_Remitos.tbRemitosbFacturado.AsInteger:= marca;
  DM_Remitos.tbRemitos.Post;
  DM_Remitos.Grabar;
end;



procedure TDM_Facturas.RemitoVincular(remito_id: GUID_ID);
begin
  With remitoFactura do
  begin
    if not Active then
      Open;
    Insert;
    remitoFacturaremito_id.asString:= remito_id;
    Post;
    MarcaRemitoFacturado(remito_id, 1);
    GrabarRemitoFactura;
//    LevantarRemitos (Facturasid.AsString);
  end;
end;

procedure TDM_Facturas.RemitoQuitar;
begin
  With RemitoFacturaDel do
  begin
    ParamByName('id').asString:= remitoFacturaid.AsString;
    ExecSQL;
  end;

  remitoFactura.Delete;

end;

procedure TDM_Facturas.GrabarRemitoFactura;
begin
  DM_General.GrabarDatos(RemitoFacturaSEL, RemitoFacturaINS, RemitoFacturaUPD,remitoFactura, 'id');
end;

procedure TDM_Facturas.LevantarRemitos(factura_id: GUID_ID);
begin
    with RemitosPorFactura do
   begin
     DM_General.ReiniciarTabla(remitoFactura);
     if active then close;
     ParamByName('factura_id').asString:= factura_id;
     Open;
     remitoFactura.LoadFromDataSet(RemitosPorFactura, 0, lmAppend);
     close;
   end;
end;


////////////////////////////////////////////////////////////////////////////////
//// PREFACTURACION
////////////////////////////////////////////////////////////////////////////////

procedure TDM_Facturas.prefacturarGrupo(gf_id: integer);
var
  str_LEYENDA_ABONO: string;
begin

  str_LEYENDA_ABONO:= LeerDato(SECCION_FACTURACION, LEYENDA_ABONO);

  //Levanto los Abonos del Grupo gf_id
  with qLevantarAbonos do
  begin
    if active then close;
    ParamByName('gf').asInteger:= gf_id;
    Open;

    First;
    While Not qLevantarAbonos.EOF do
    begin
      //Por cada abono, le genero una factura con estado FAC_ESTADO_SIN_FACTURAR
      NuevaFactura;
      AsignarNroFactura(FACTURA_T);
      CargarCliente(qLevantarAbonosIDCLIENTE.asString);
      NuevoItem;
      AgregarDatosItems (1,str_LEYENDA_ABONO, qLevantarAbonosNMONTOABONO.AsFloat);

      //Busco los remitos sin cargo y sin factura y los vinculo
      if qLevantarRemitosAbono.Active then
        qLevantarRemitosAbono.Close;
      qLevantarRemitosAbono.ParamByName('refcliente').AsString:= qLevantarAbonosIDCLIENTE.AsString;
      qLevantarRemitosAbono.Open;
      while (NOT qLevantarRemitosAbono.EOF) do
      begin
        RemitoVincular(qLevantarRemitosAbonoIDREMITO.AsString);
        qLevantarRemitosAbono.Next;
      end;

      GrabarFactura;
      qLevantarAbonos.Next;
    end;
  end;
end;

function TDM_Facturas.CambiarEstadoFactura(factura_id: GUID_ID): boolean;
var
  estadoNuevo: integer;
begin
  Result:= false;
  estadoNuevo:= 0;
  LevantarFacturaID(factura_id);
//  if Facturasestado_id.AsInteger = 1 then
    estadoNuevo := 4;
//  if Facturasestado_id.AsInteger = 4 then
    estadoNuevo:= 1;
  if estadoNuevo > 0 then
  begin
    Result:= true;
//    FacturasCabecera.Edit;
//    Facturasestado_id.AsInteger:= estadoNuevo;
//    FacturasCabecera.Post;
//    GrabarFactura;
  end;
end;

(****
 ************   PREFACTURACION   ****************************
 ***)

procedure TDM_Facturas.AjustarTablaMemoria;
var
  clienteActual, campoCliente: GUID_ID;
begin
  with FacturasDocumentos do
  begin
    DisableControls;
    First;
    clienteActual:= GUIDNULO;
    campoCliente:= GUIDNULO;
    While Not EOF do
    begin
      Edit;
      case FacturasDocumentostipoDocumento.AsInteger of
        TD_LIBRE: FacturasDocumentoslxDocumento.asString:= 'SIN DOCUMENTO';
        TD_REMITO:
        begin
          FacturasDocumentoslxDocumento.asString:= 'REMITO';
          FacturasDocumentoslxNroDocumento.AsInteger:= FacturasDocumentosRemitoNro.AsInteger;
          FacturasDocumentoslxFecha.AsDateTime:= FacturasDocumentosRemitoFecha.AsDateTime;
          FacturasDocumentoslxDetalle.asString:= FacturasDocumentosRemitoDetalles.asString;
          campoCliente:= FacturasDocumentosidClienteRemito.AsString;
        end;
        TD_PRESUPUESTO:
        begin
          FacturasDocumentoslxDocumento.asString:= 'PRESUPUESTO';
          FacturasDocumentoslxNroDocumento.AsInteger:= FacturasDocumentosNroPresupuesto.AsInteger;
          FacturasDocumentoslxFecha.AsDateTime:= FacturasDocumentosPresupuestoFecha.AsDateTime;
          FacturasDocumentoslxDetalle.asString:= 'CUOTA NRO: '+ IntToStr(FacturasDocumentosPresupuestoCuota.AsInteger)
                                                 +#10#13#13 + FacturasDocumentosPresupuestoDetalles.asString;
          campoCliente:= FacturasDocumentosidClientePresupuesto.AsString;

        end;
      end;
      case FacturasDocumentosrefEstado.AsInteger of
       EP_NULO: FacturasDocumentoslxEstado.AsString:= '-';
       EP_PARAFACTURAR: FacturasDocumentoslxEstado.AsString:= 'PARA FACTURAR';
       EP_PREFACTURADO: FacturasDocumentoslxEstado.AsString:= 'PREFACTURADO';
       EP_FACTURADO: FacturasDocumentoslxEstado.AsString:= 'FACTURADO';
      end;

      if (clienteActual <> campoCliente) then
      begin
        clienteActual:= campoCliente;
        DM_Clientes.ClienteEditar(clienteActual);
      end;
      FacturasDocumentoslxCliente.AsString:= DM_Clientes.tbClientescNombre.AsString;
      FacturasDocumentoslxCodigo.AsString:= DM_Clientes.tbClientescCodigo.AsString;

      Post;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_Facturas.LevantarDocumentos(documento, estado: integer;
  idCliente: GUID_ID);
var
  consulta: string;
begin
  consulta:= ' SELECT P.ID, P.FACTURA_ID, P.DOCUMENTO_ID, P.TIPODOCUMENTO, P.REFESTADO '
	    + ' , CPR.nNroCuota as PresupuestoCuota '
            + ' , CPR.nMonto as PresupuestoMonto '
            + ' , CPR.fVencimiento as PresupuestoVencimiento '
            + ' , R.nRemito as RemitoNro '
            + ' , R.fFecha as RemitoFecha '
            + ' , R.txDetalles as RemitoDetalles '
            + ' , R.refCliente as idClienteRemito '
            + ' , PR.nPresupuesto as NroPresupuesto '
            + ' , PR.refCliente as idClientePresupuesto '
            + ' , CPR.fVencimiento as PresupuestoFecha '
            + ' , PR.txMotivo as PresupuestoDetalles '
            + ' FROM '
            + '     FacturasDocumentos P '
            + '             LEFT JOIN tbCuotasPresupuesto CPR ON CPR.idCuotaPresupuesto = P.DOCUMENTO_ID '
            + '             LEFT JOIN tbRemitos R ON R.idRemito = P.DOCUMENTO_ID '
            + '             LEFT JOIN tbPresupuestos PR ON CPR.refPresupuesto = PR.idPresupuesto '
            ;

  consulta:= consulta + ' WHERE ((R.bVisible = 1) OR (CPR.bVisible = 1)) ';

  if (documento <> TD_LIBRE) then
    consulta:= consulta + ' AND (P.TipoDocumento ='+ intToStr(documento)+') ';

  if (estado <> EP_NULO) then
    consulta:= consulta + ' AND (P.refEstado = ' + intToStr(estado) + ') ' ;

  if (idCliente <> GUIDNULO) then
    consulta:= consulta + ' AND ((R.refCliente = ''' + idCliente + ''') OR (PR.refCliente = ''' + idCliente + ''') )';

  with qTodosLosDocumentos do
  begin
    DM_General.ReiniciarTabla(FacturasDocumentos);
    if active then close;
    SQL.Clear;
    SQL.Add(consulta);
    Open;
    FacturasDocumentos.LoadFromDataSet(qTodosLosDocumentos, 0, lmAppend);
    close;
  end;

  AjustarTablaMemoria;
  FacturasDocumentos.SortOnFields('lxCodigo;lxFecha');
  FacturasDocumentos.First;

end;

procedure TDM_Facturas.levantarDocumentosSinPrefacturar;
const
   _CONF_CORTEMES = 20;
var
  y,m,d: word;
begin
  //Levanto los remitos que no estan cargados en la tabla de Prefacturacion
  with qRemitosSinPF do
  begin
     if Active then Close;
     Open;
     while NOT EOF do
     begin
       FacturasDocumentos.Insert;
       FacturasDocumentosidClienteRemito.AsString:= qRemitosSinPFREFCLIENTE.AsString;
       FacturasDocumentoslxFecha.AsDateTime:= qRemitosSinPFFFECHA.AsDateTime;
       FacturasDocumentosdocumento_id.AsString:= qRemitosSinPFIDREMITO.AsString;
       FacturasDocumentostipoDocumento.AsInteger:= TD_REMITO;
       FacturasDocumentoslxNroDocumento.AsInteger:= qRemitosSinPFNREMITO.AsInteger;
       FacturasDocumentoslxDetalle.AsString:= qRemitosSinPFTXDETALLES.AsString;
       FacturasDocumentos.Post;
       Next;
     end;
  end;

  //Levanto las cuotas impagas de los presupuestos
  with qPresupuestosSinPF do
  begin
    if Active then Close;

       // Aplico un corte de mes para saber si calculo el vencimiento a partir de el mes corriente o del siguiente
    DecodeDate(Now, y, m, d);

    if (d >= _CONF_CORTEMES) then
      IncAMonth(y, m, d, 1);

    ParamByName('Vencimiento').AsDate:= EndOfAMonth(y, m);
    Open;

    while NOT EOF do
    begin
      FacturasDocumentos.Insert;
      FacturasDocumentosidClientePresupuesto.AsString:= qPresupuestosSinPFREFCLIENTE.AsString;
      FacturasDocumentoslxFecha.AsDateTime:= qPresupuestosSinPFFVENCIMIENTO.AsDateTime;
      FacturasDocumentosdocumento_id.AsString:= qPresupuestosSinPFIDCUOTAPRESUPUESTO.AsString;
      FacturasDocumentostipoDocumento.AsInteger:= TD_PRESUPUESTO;
      FacturasDocumentoslxNroDocumento.AsInteger:= qPresupuestosSinPFNPRESUPUESTO.AsInteger;
      FacturasDocumentoslxDetalle.AsString:= 'CUOTA: ' + IntToStr(qPresupuestosSinPFNNROCUOTA.AsInteger) + ' ' + FormatFloat('$ #######0.00', qPresupuestosSinPFNMONTO.AsFloat);
      FacturasDocumentos.Post;
      Next;
    end;
  end;

 AjustarTablaMemoria;
 FacturasDocumentos.SortOnFields('lxCodigo;lxfecha');
 FacturasDocumentos.First;
end;

procedure TDM_Facturas.GrabarDocumentos;
begin
  DM_General.GrabarDatos(facturasDocSEL, facturasDocINS, facturasDocUPD, FacturasDocumentos, 'id');
end;



end.

