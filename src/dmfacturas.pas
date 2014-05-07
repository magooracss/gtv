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
    facturaItemsINS: TZQuery;
    facturaItemsSEL: TZQuery;
    facturaItemsSELCANTIDAD: TFloatField;
    facturaItemsSELDETALLE: TStringField;
    facturaItemsSELFACTURA_ID: TStringField;
    facturaItemsSELID: TStringField;
    facturaItemsSELMONTO: TFloatField;
    facturaItemsSELPRECIOUNITARIO: TFloatField;
    facturasSELCLIENTEEMPRESA_ID: TStringField;
    facturasSELCONDICIONVENTA_ID: TLongintField;
    facturasSELESTADO_ID: TLongintField;
    facturasSELFANULACION: TDateField;
    facturasSELFECHA: TDateField;
    facturasSELID: TStringField;
    facturasSELNROFACTURA: TLongintField;
    facturasSELNROPTOVENTA: TLongintField;
    facturasSELOBSERVACIONES: TStringField;
    facturasSELTIPOFACTURA_ID: TLongintField;
    ItemsPorFactura: TZQuery;
    ItemsPorFacturaCANTIDAD: TFloatField;
    ItemsPorFacturaDETALLE: TStringField;
    ItemsPorFacturaFACTURA_ID: TStringField;
    ItemsPorFacturaID: TStringField;
    ItemsPorFacturaMONTO: TFloatField;
    ItemsPorFacturaPRECIOUNITARIO: TFloatField;
    qListaFacturasCLIENTE: TStringField;
    qListaFacturasESTADOFACTURA: TStringField;
    qListaFacturasFECHAFACTURA: TDateField;
    qListaFacturasID: TStringField;
    qListaFacturasLETRAFACTURA: TStringField;
    qListaFacturasNROFACTURA: TLongintField;
    qListaFacturasNROPTOVENTA: TLongintField;
    qListaFacturasTOTALFACTURA: TFloatField;
    facturaItemsUPD: TZQuery;
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
    qListaFacturas: TZQuery;
    Facturas: TRxMemoryData;
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
    procedure FacturaItemsAfterInsert(DataSet: TDataSet);
    procedure FacturasAfterInsert(DataSet: TDataSet);
    procedure reciboFacturaAfterInsert(DataSet: TDataSet);
    procedure remitoFacturaAfterInsert(DataSet: TDataSet);
  private
    function getIdFacturaListado: GUID_ID;
    procedure setLetraFactura(AValue: integer);
    { private declarations }
  public
    property idFacturaListado: GUID_ID read getIdFacturaListado;
    property LetraFactura: integer write setLetraFactura;
    procedure LevantarFacturas;

    procedure CargarCliente (idCliente: GUID_ID);

    procedure NuevaFactura;
    procedure LevantarFacturaID (factura_id: GUID_ID);
    function idFacturaPorCondicionFiscal (idCondFiscal: integer): integer;

    procedure AsignarNroFactura (idTipoFactura: integer);

    procedure NuevoItem;
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
    FieldByName('estado_id').asInteger:= 1;
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

procedure TDM_Facturas.remitoFacturaAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
    FieldByName('factura_id').asString:= Facturasid.AsString;
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
  with Facturas do
  begin
    Edit;
    FacturastipoFactura_id.AsInteger:= AValue;
    Post;
  end;
end;

procedure TDM_Facturas.LevantarFacturas;
begin
  with qListaFacturas do
  begin
    if active then close;
    Open;
  end;
end;

procedure TDM_Facturas.CargarCliente(idCliente: GUID_ID);
begin
  with Facturas do
  begin
    Edit;
    FacturasclienteEmpresa_id.AsString:= idCliente;
    Post;
  end;
end;

procedure TDM_Facturas.NuevaFactura;
begin
  DM_General.ReiniciarTabla(Facturas);
  Facturas.Insert;
end;

procedure TDM_Facturas.LevantarFacturaID(factura_id: GUID_ID);
begin
  DM_General.ReiniciarTabla(Facturas);
  DM_General.ReiniciarTabla(FacturaItems);

  with facturasSEL do
  begin
    if active then close;
    ParamByName('id').asString:= factura_id;
    Open;
    Facturas.LoadFromDataSet(facturasSEL,0, lmAppend);
    Close;
  end;

  with ItemsPorFactura  do
  begin
    if active then close;
    ParamByName('factura_id').asString:= factura_id;
    Open;
    FacturaItems.LoadFromDataSet(ItemsPorFactura,0, lmAppend);
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

procedure TDM_Facturas.GrabarFactura;
begin
  DM_General.GrabarDatos(facturasSEL, facturasINS, FacturasUPD, Facturas, 'id');
  DM_General.GrabarDatos(facturaItemsSEL, facturaItemsINS, facturaItemsUPD, FacturaItems, 'id');
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

procedure TDM_Facturas.RemitoVincular(remito_id: GUID_ID);
begin
  With remitoFactura do
  begin
    if not Active then
      Open;
    Insert;
    remitoFacturaremito_id.asString:= remito_id;
    Post;
    GrabarRemitoFactura;
    LevantarRemitos (Facturasid.AsString);
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

end.

