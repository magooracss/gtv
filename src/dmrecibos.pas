unit dmrecibos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, rxmemds, db
  ,dmgeneral
  ;

const
  ESTAD0_SIN_FACTURAR = 1;

type

  { TDM_Recibos }

  TDM_Recibos = class(TDataModule)
    qItemsReciboBANCO_ID: TLongintField;
    qItemsReciboCHEQUE_ID: TStringField;
    qItemsReciboCUENTA_ID: TLongintField;
    qItemsReciboFORMACOBRO: TStringField;
    qItemsReciboFORMACOBRO_ID: TLongintField;
    qItemsReciboID: TStringField;
    qItemsReciboMONTO: TFloatField;
    qItemsReciboRECIBO_ID: TStringField;
    qListaRecibos: TZQuery;
    qItemsRecibo: TZQuery;
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
    ReciboItemsbanco_id: TLongintField;
    ReciboItemscheque_id: TStringField;
    ReciboItemscuenta_id: TLongintField;
    ReciboItemsformaCobro: TStringField;
    ReciboItemsformaCobro_id: TLongintField;
    ReciboItemsid: TStringField;
    ReciboItemsmonto: TFloatField;
    ReciboItemsrecibo_id: TStringField;
    ReciboItemsSELBANCO_ID: TLongintField;
    ReciboItemsSELCHEQUE_ID: TStringField;
    ReciboItemsSELCUENTA_ID: TLongintField;
    ReciboItemsSELFORMACOBRO: TStringField;
    ReciboItemsSELFORMACOBRO_ID: TLongintField;
    ReciboItemsSELID: TStringField;
    ReciboItemsSELMONTO: TFloatField;
    ReciboItemsSELRECIBO_ID: TStringField;
    Recibos: TRxMemoryData;
    ReciboItems: TRxMemoryData;
    RecibosclienteEmpresa_id: TStringField;
    RecibosDetalle: TStringField;
    Recibosestado_id: TLongintField;
    RecibosfAnulacion: TDateTimeField;
    RecibosFecha: TDateTimeField;
    Recibosid: TStringField;
    ReciboItemsINS: TZQuery;
    ReciboslxEstado: TStringField;
    RecibosnroPtoVenta: TLongintField;
    RecibosnroRecibo: TLongintField;
    ReciboItemsSEL: TZQuery;
    ReciboItemsUPD: TZQuery;
    tbReclamosDEL: TZQuery;
    RecibosINS: TZQuery;
    RecibosSEL: TZQuery;
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
    ReciboItemsDEL: TZQuery;
    procedure ReciboItemsAfterInsert(DataSet: TDataSet);
    procedure RecibosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarRecibos;
    function ListadoRecibosSel: GUID_ID;

    procedure CargarCliente (idCliente: GUID_ID);

    procedure NuevoRecibo;
    procedure LevantarReciboID (idRecibo: GUID_ID);

    procedure RecargarItems (idRecibo: GUID_ID);

    procedure Grabar;

  end;

var
  DM_Recibos: TDM_Recibos;

implementation

{$R *.lfm}

{ TDM_Recibos }

procedure TDM_Recibos.RecibosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
    FieldByName('fecha').AsDateTime:= Now;
    FieldByName('nroPtoVenta').asInteger:= 1;
    FieldByName('nroRecibo').asInteger:= -1;
    FieldByName('clienteEmpresa_id').asString:= GUIDNULO;
    FieldByName('detalle').asString:= EmptyStr;
    FieldByName('fAnulacion').AsDateTime:= Now;
    FieldByName('estado_id').asInteger:= ESTAD0_SIN_FACTURAR;
  end;
end;

procedure TDM_Recibos.ReciboItemsAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('id').asString:= DM_General.CrearGUID;
    FieldByName('formaCobro_id').asInteger:= 0;
    FieldByName('banco_id').asInteger:= 0;
    FieldByName('cheque_id').AsString:= GUIDNULO;
    FieldByName('formaCobro').AsString:= EmptyStr;
    FieldByName('monto').AsFloat:= 0;
    FieldByName('recibo_id').AsString:= Recibosid.AsString;
    FieldByName('cuenta_id').asInteger:= 0;
  end;
end;

procedure TDM_Recibos.LevantarRecibos;
begin
  if qListaRecibos.Active then qListaRecibos.Close;
  qListaRecibos.Open;
end;

function TDM_Recibos.ListadoRecibosSel: GUID_ID;
begin
  with qListaRecibos do
  begin
    if Active and (RecordCount > 0) then
       Result:= qListaRecibosID.AsString
    else
       Result:= GUIDNULO;
  end;
end;

procedure TDM_Recibos.CargarCliente(idCliente: GUID_ID);
begin
  with Recibos do
  begin
    Edit;
    RecibosclienteEmpresa_id.AsString:= idCliente;
    Post;
  end;
end;

procedure TDM_Recibos.NuevoRecibo;
begin
  DM_General.ReiniciarTabla(Recibos);
  Recibos.Insert;
end;

procedure TDM_Recibos.LevantarReciboID(idRecibo: GUID_ID);
begin
  DM_General.ReiniciarTabla(Recibos);
  with RecibosSEL do
  begin
    if active then close;
    ParamByName('id').asString:= idRecibo;
    Open;
    Recibos.LoadFromDataSet(RecibosSEL, 0, lmAppend);
    close;
  end;

  RecargarItems (idRecibo);
end;

procedure TDM_Recibos.RecargarItems(idRecibo: GUID_ID);
begin
  DM_General.ReiniciarTabla(ReciboItems);
  with qItemsRecibo do
  begin
    if active then close;
    ParamByName('recibo_id').asString:= idRecibo;
    Open;
    ReciboItems.LoadFromDataSet(qItemsRecibo, 0, lmAppend);
    close;
  end;
end;

procedure TDM_Recibos.Grabar;
begin
  DM_General.GrabarDatos(RecibosSEL,RecibosINS, RecibosUPD, Recibos, 'id');
end;

end.

