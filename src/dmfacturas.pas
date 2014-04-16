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

type

  { TDM_Facturas }

  TDM_Facturas = class(TDataModule)
    CondFiscalID: TZQuery;
    CondFiscalIDBVISIBLE: TSmallintField;
    CondFiscalIDCOMPRENTREGA: TLongintField;
    CondFiscalIDCOMPRRECIBE: TLongintField;
    CondFiscalIDCONDICIONFISCAL: TStringField;
    CondFiscalIDIDCONDICIONFISCAL: TLongintField;
    FacturaItemsCantidad: TFloatField;
    ReciboFacturaDel: TZQuery;
    FacturaItemsDetalle: TStringField;
    FacturaItemsfactura_id: TStringField;
    FacturaItemsid: TStringField;
    FacturaItemsMonto: TFloatField;
    FacturaItemsPrecioUnitario: TFloatField;
    facturaPorId: TZQuery;
    CondicionFiscalBVISIBLE: TSmallintField;
    CondicionFiscalGENERADOR: TStringField;
    CondicionFiscalID: TLongintField;
    CondicionFiscalLETRA: TStringField;
    facturaPorIdBVISIBLE: TSmallintField;
    facturaPorIdGENERADOR: TStringField;
    facturaPorIdID: TLongintField;
    facturaPorIdLETRA: TStringField;
    FacturaItems: TRxMemoryData;
    FacturasCondicionVenta_id: TLongintField;
    FacturasObservaciones: TStringField;
    FacturastipoFactura_id: TLongintField;
    nroFactura: TZQuery;
    FacturasclienteEmpresa_id: TStringField;
    Facturasestado_id: TLongintField;
    FacturasfAnulacion: TDateTimeField;
    FacturasFecha: TDateTimeField;
    Facturasid: TStringField;
    FacturaslxEstado: TStringField;
    FacturasnroFactura: TLongintField;
    FacturasnroPtoVenta: TLongintField;
    nroFacturaNRO: TLargeintField;
    qListaRecibos: TZQuery;
    qListaRecibosBVISIBLE: TSmallintField;
    qListaRecibosBVISIBLE_1: TSmallintField;
    qListaRecibosCCODIGO: TStringField;
    qListaRecibosCCUIT: TStringField;
    qListaRecibosCDOMICILIO: TStringField;
    qListaRecibosCENTRECALLE1: TStringField;
    qListaRecibosCENTRECALLE2: TStringField;
    qListaRecibosCLIENTEEMPRESA_ID: TStringField;
    qListaRecibosCMANZANA: TStringField;
    qListaRecibosCNOMBRE: TStringField;
    qListaRecibosCNROCASA: TStringField;
    qListaRecibosCPARCELA: TStringField;
    qListaRecibosCSECCION: TStringField;
    qListaRecibosDETALLE: TStringField;
    qListaRecibosESTADO: TStringField;
    qListaRecibosESTADO_ID: TLongintField;
    qListaRecibosFANULACION: TDateField;
    qListaRecibosFECHA: TDateField;
    qListaRecibosFINICIO: TDateField;
    qListaRecibosHABILITACIONEXP: TStringField;
    qListaRecibosHABILITACIONFECHA: TDateField;
    qListaRecibosID: TStringField;
    qListaRecibosIDCLIENTE: TStringField;
    qListaRecibosIDRECIBOESTADO: TLongintField;
    qListaRecibosNIVA: TFloatField;
    qListaRecibosNMONTOABONO: TFloatField;
    qListaRecibosNROPTOVENTA: TLongintField;
    qListaRecibosNRORECIBO: TLongintField;
    qListaRecibosREFABONO: TLongintField;
    qListaRecibosREFADMINISTRADOR: TStringField;
    qListaRecibosREFCONDICIONFISCAL: TLongintField;
    qListaRecibosREFCONSERVADOR: TStringField;
    qListaRecibosREFDESTINO: TLongintField;
    qListaRecibosREFGRUPOFACTURACION: TLongintField;
    qListaRecibosREFLOCALIDAD: TLongintField;
    qListaRecibosREFRESPTECNICO: TStringField;
    qListaRecibosUNIDADFUNCIONAL: TLongintField;
    Facturas: TRxMemoryData;
    reciboFacturafactura_id: TStringField;
    reciboFacturaFecha: TDateField;
    reciboFacturaid: TStringField;
    reciboFacturaNroRecibo: TStringField;
    reciboFacturarecibo_id: TStringField;
    RecibosINS: TZQuery;
    ReciboFacturaINS: TZQuery;
    RecibosSEL: TZQuery;
    CondicionFiscal: TZQuery;
    RecibosPorFactura: TZQuery;
    ReciboFacturaSEL: TZQuery;
    RecibosSELCLIENTEEMPRESA_ID: TStringField;
    RecibosSELDETALLE: TStringField;
    RecibosSELESTADO_ID: TLongintField;
    RecibosSELFANULACION: TDateField;
    RecibosSELFECHA: TDateField;
    RecibosSELID: TStringField;
    RecibosSELLXESTADO: TStringField;
    RecibosSELNROPTOVENTA: TLongintField;
    RecibosSELNRORECIBO: TLongintField;
    RecibosUPD: TZQuery;
    reciboFactura: TRxMemoryData;
    ReciboFacturaUPD: TZQuery;
    tbReclamosDEL: TZQuery;
    facturaItemsDEL: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure FacturaItemsAfterInsert(DataSet: TDataSet);
    procedure FacturasAfterInsert(DataSet: TDataSet);
    procedure reciboFacturaAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarFacturas;

    procedure CargarCliente (idCliente: GUID_ID);

    procedure NuevaFactura;
    function idFacturaPorCondicionFiscal (idCondFiscal: integer): integer;

    procedure AsignarNroFactura (idTipoFactura: integer);

    procedure NuevoItem;
    procedure EliminarItem;

    function TotalFacturado: Double;

    procedure ReciboVincular (recibo_id: GUID_ID);
    procedure ReciboQuitar;
    procedure GrabarReciboFactura;
    procedure LevantarRecibos (factura_id: GUID_ID);

  end;

var
  DM_Facturas: TDM_Facturas;

implementation

{$R *.lfm}

{ TDM_Facturas }

procedure TDM_Facturas.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM_Facturas.FacturaItemsAfterInsert(DataSet: TDataSet);
begin
  With DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
    FieldByName('cantidad').AsFloat:= 1;
    FieldByName('Detalle').AsString:= EmptyStr;
    FieldByName('PrecioUnitario').AsFloat:=0;
    FieldByName('Monto').AsFloat:=0;
    FieldByName('Factura_id').AsString:= Facturasid.asString;
  end;
end;

procedure TDM_Facturas.FacturasAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').AsString:= DM_General.CrearGUID;
    FieldByName('Fecha').AsDateTime:= Now;
    FieldByName('nroPtoVenta').asInteger:= 0;
    FieldByName('nroFactura').asInteger:= 0;
    FieldByName('tipoFactura_id').AsInteger:=0;
    FieldByName('clienteEmpresa_id').asString:= GUIDNULO;
    FieldByName('CondicionVenta_id').AsInteger:=0;
    FieldByName('Observaciones').asString:= EmptyStr;
    FieldByName('fAnulacion').AsDateTime:= 0;
    FieldByName('estado_id').asInteger:= 0;
    FieldByName('lxEstado').asString:= EmptyStr;
  end;
end;

procedure TDM_Facturas.reciboFacturaAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
    FieldByName('factura_id').asString:= Facturasid.AsString;
    FieldByName('recibo_id').asString:= GUIDNULO;
  end;
end;

procedure TDM_Facturas.LevantarFacturas;
begin

end;

procedure TDM_Facturas.CargarCliente(idCliente: GUID_ID);
begin

end;

procedure TDM_Facturas.NuevaFactura;
begin
  DM_General.ReiniciarTabla(Facturas);
  Facturas.Insert;
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
begin
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

  with Facturas do
  begin
    Edit;
    FacturasnroPtoVenta.asInteger:= 1;
    FacturasnroFactura.asInteger:= nroFact;
    Post;
  end;
end;

procedure TDM_Facturas.NuevoItem;
begin
  if NOT FacturaItems.Active then FacturaItems.Open;
  FacturaItems.Insert;
end;

procedure TDM_Facturas.EliminarItem;
begin
   facturaItemsDEL.ParamByName('id').AsString:= FacturaItemsid.AsString;
   FacturaItemsDEL.ExecSQL;

   FacturaItems.Delete;
end;

function TDM_Facturas.TotalFacturado: Double;
var
  accum: Double;
begin
  with FacturaItems do
  begin
    DisableControls;
    First;
    accum:= 0;
    While Not Eof do
    begin
      accum:= accum + FacturaItemsMonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;
  Result:= accum;
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
    LevantarRecibos(Facturasid.AsString);
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

end.

