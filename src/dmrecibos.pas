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
    Recibos: TRxMemoryData;
    RecibosclienteEmpresa_id: TStringField;
    RecibosDetalle: TStringField;
    Recibosestado_id: TLongintField;
    RecibosfAnulacion: TDateTimeField;
    RecibosFecha: TDateTimeField;
    Recibosid: TStringField;
    ReciboslxEstado: TStringField;
    RecibosnroPtoVenta: TLongintField;
    RecibosnroRecibo: TLongintField;
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
    procedure RecibosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarRecibos;

    procedure CargarCliente (idCliente: GUID_ID);

    procedure NuevoRecibo;
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

procedure TDM_Recibos.LevantarRecibos;
begin
  if qListaRecibos.Active then qListaRecibos.Close;
  qListaRecibos.Open;
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

end.

