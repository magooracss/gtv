unit dmegresosvarios; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, LR_DBSet, LR_Class, ZDataset
  ,dmgeneral
  ;

type

  { TDM_EgresosVarios }

  TDM_EgresosVarios = class(TDataModule)
    elReporte: TfrReport;
    frEgresosVariosItems: TfrDBDataSet;
    frFormasPago: TfrDBDataSet;
    frEgresosVarios: TfrDBDataSet;
    qCalcularMontoPago: TZQuery;
    qLevantarFormasPago: TZQuery;
    qLevantarEgresos: TZQuery;
    qCalcularMonto: TZQuery;
    qPlanCuenta: TZQuery;
    qtbCheques: TZQuery;
    tbEgresosVarios: TRxMemoryData;
    tbEgresosVariosbVisible: TLongintField;
    tbEgresosVariosfecha: TDateField;
    tbEgresosVariosidEgresoVario: TStringField;
    tbEgresosVariosItems: TRxMemoryData;
    tbEgresosVariosItemsidEgresoVarioItem: TStringField;
    tbEgresosVariosItemsLeyenda: TStringField;
    tbEgresosVariosItemslxCodigo: TStringField;
    tbEgresosVariosItemslxCuenta: TStringField;
    tbEgresosVariosItemsnMonto: TFloatField;
    tbEgresosVariosItemsrefEgresoVario: TStringField;
    tbEgresosVariosItemsrefImputacion: TLongintField;
    tbEgresosVarioslxMonto: TFloatField;
    tbEgresosVariosnroEgreso: TLongintField;
    tbEgresosVariostitulo: TStringField;
    tbEVFormasPago: TRxMemoryData;
    tbEVFormasPagoidEVFormaPago: TStringField;
    tbEVFormasPagolxBanco: TStringField;
    tbEVFormasPagolxCheque: TStringField;
    tbEVFormasPagolxFechaCheque: TStringField;
    tbEVFormasPagolxFormaPago: TStringField;
    tbEVFormasPagonMonto: TFloatField;
    tbEVFormasPagorefBanco: TLongintField;
    tbEVFormasPagorefCheque: TStringField;
    tbEVFormasPagorefEgresoVario: TStringField;
    tbEVFormasPagorefFormaPago: TLongintField;
    tbEVIDEL: TZQuery;
    tbEVDEL: TZQuery;
    tbEVFPDEL: TZQuery;
    tbEVIINS: TZQuery;
    tbEVFPINS: TZQuery;
    tbEVINS: TZQuery;
    tbEVISEL: TZQuery;
    tbEVFPSEL: TZQuery;
    tbEVFPUPD: TZQuery;
    qLevantarItems: TZQuery;
    tbEVSEL: TZQuery;
    tbEVIUPD: TZQuery;
    tbEVUPD: TZQuery;
    procedure tbEgresosVariosAfterInsert(DataSet: TDataSet);
    procedure tbEgresosVariosItemsAfterInsert(DataSet: TDataSet);
    procedure tbEVFormasPagoAfterInsert(DataSet: TDataSet);
  private
    function getIdEgreso: GUID_ID;
    function getIdEgresoSeleccionado: GUID_ID;
    function getImputacion: integer;
    function getMontoItems: double;
    function getMontoPagos: double;
    function MontoEgreso (refEgreso: GUID_ID): double;

    function ObtenerNroCheque (refCheque: string): string;
    function ObtenerfVtoCheque(refCheque: string): string;
  public
    property idEgreso: GUID_ID read getIdEgreso;
    property idEgresoSeleccionado: GUID_ID read getIdEgresoSeleccionado;
    property Imputacion: integer read getImputacion;
    property MontoItems: double read getMontoItems;
    property MontoPagos: double read getMontoPagos;

    procedure NuevoEgresoVario;
    procedure NuevoEgresoVarioItem;
    procedure CargarImputacion(refCuenta: integer; txConcepto:string);
    procedure RecalcularMontos;

    procedure LevantarEgresos;
    procedure LevantarEgreso (refEgreso: GUID_ID);

    procedure EliminarEgreso;
    procedure EliminarItem;
    procedure EliminarFormaPago;

    procedure Codigo;

    procedure Grabar;

    function CargarValor (refFormaPago: integer; refCheque: GUID_ID; refBanco: integer
                         ; Monto: double; Banco, NroCheque: string): GUID_ID;

  end; 

var
  DM_EgresosVarios: TDM_EgresosVarios;

implementation
{$R *.lfm}
uses
  dmplandecuentas
  ,dmordenesdepago
  ;

{ TDM_EgresosVarios }

procedure TDM_EgresosVarios.tbEgresosVariosAfterInsert(DataSet: TDataSet);
begin
  with dataSet do
  begin
    FieldByName('idEgresoVario').asString:= DM_General.CrearGUID;
    FieldByName('nroEgreso').asInteger:= -1;
    FieldByName('Fecha').AsDateTime:= now;
    FieldByName('Titulo').asString:= '';
    FieldByName('bVisible').asInteger:= 1;
    FieldByName('lxMonto').asFloat:= 0;
  end;
end;

procedure TDM_EgresosVarios.tbEgresosVariosItemsAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idEgresoVarioItem').asString:= DM_General.CrearGUID;
    FieldByName('refEgresoVario').asString:= tbEgresosVarios.FieldByName('idEgresoVario').asString;
    FieldByName('refImputacion').asInteger:= 0;
    FieldByName('leyenda').asString:= EmptyStr;
    FieldByName('nMonto').asFloat:= 0;
  end;
end;



procedure TDM_EgresosVarios.tbEVFormasPagoAfterInsert(DataSet: TDataSet);
begin
  with dataset do
  begin
    FieldByName('idEvFormaPago').asString:= DM_General.CrearGUID;
    FieldByName('refEgresoVario').AsString:= tbEgresosVarios.FieldByName('idEgresoVario').asString;
    FieldByName('refFormaPago').asInteger:= 0;
    FieldByName('refCheque').asString:= GUIDNULO;
    FieldByName('refBanco').asInteger:= 0;
    FieldByName('nMonto').asFloat:= 0;
  end;
end;

function TDM_EgresosVarios.ObtenerfVtoCheque(refCheque: string): string;
begin
  with qtbCheques do
  begin
    if active then close;
    ParamByName('idCheque').asString:= refCheque;
    Open;
    if RecordCount > 0 then
      Result:= DateToStr(FieldByName('fVencimiento').AsDateTime)
    else
      Result:= '***';
  end;
end;

function TDM_EgresosVarios.getIdEgreso: GUID_ID;
begin
  with tbEgresosVarios do
  begin
    if RecordCount > 0 then
       Result:= FieldByName('idEgresoVario').asString
    else
       Result:= GUIDNULO;
  end;
end;

procedure TDM_EgresosVarios.Grabar;
begin
  DM_General.GrabarDatos(tbEVSEL, tbEVINS, tbEVUPD, tbEgresosVarios, 'idEgresoVario');
  DM_General.GrabarDatos(tbEVISEL, tbEVIINS, tbEVIUPD, tbEgresosVariosItems, 'idEgresoVarioItem');
  DM_General.GrabarDatos(tbEVFPSEL, tbEVFPINS, tbEVFPUPD, tbEVFormasPago, 'idEvFormaPago');
end;

(*******************************************************************************
*** EGRESOS VARIOS
*******************************************************************************)
procedure TDM_EgresosVarios.RecalcularMontos;
var
  accum: Double;
begin
  with tbEgresosVariosItems do
  begin
    DisableControls;
    First;
    accum:= 0;
    While Not EOF do
    begin
      accum:= accum + FieldByName('nMonto').asFloat;
      Next;
    end;
    EnableControls;
  end;
  with tbEgresosVarios do
  begin
    Edit;
    FieldByName('lxMonto').asFloat:= accum;
    Post;
  end;
end;

procedure TDM_EgresosVarios.Codigo;
begin

end;


function TDM_EgresosVarios.getIdEgresoSeleccionado: GUID_ID;
begin
  with tbEgresosVariosItems do
  begin
    if active and (RecordCount > 0) then
       Result:= FieldByName('idEgresoVarioItem').asString
    else
        Result:= GUIDNULO;
  end;
end;

procedure TDM_EgresosVarios.NuevoEgresoVario;
begin
  DM_General.ReiniciarTabla(tbEgresosVarios);
  DM_General.ReiniciarTabla(tbEgresosVariosItems);
  DM_General.ReiniciarTabla(tbEVFormasPago);

  tbEgresosVarios.Insert;
end;


procedure TDM_EgresosVarios.LevantarEgreso(refEgreso: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbEgresosVarios);
  DM_General.ReiniciarTabla(tbEgresosVariosItems);
  DM_General.ReiniciarTabla(tbEVFormasPago);

  with tbEVSEL do
  begin
    if active then close;
    ParamByName('idEgresoVario').asString:= refEgreso;
    Open;
    tbEgresosVarios.LoadFromDataSet(tbEVSEL, 0 , lmAppend);
    Close;
  end;

  with qLevantarItems do
  begin
    if active then close;
    ParamByName('refEgresoVario').asString:= refEgreso;
    Open;
    tbEgresosVariosItems.LoadFromDataSet (qLevantarItems, 0, lmAppend);
    Close;
  end;

  with qLevantarFormasPago do
  begin
    if active then close;
    ParamByName('refEgresoVario').asString:= refEgreso;
    Open;
    tbEVFormasPago.LoadFromDataSet (qLevantarFormasPago, 0, lmAppend);
    Close;
  end;

  with tbEVFormasPago do
  begin
    if RecordCount > 0 then
       First;
    while Not Eof do
    begin
      Edit;
      FieldByName('lxBanco').asString:= DM_OrdenesDePago.ObtenerBanco (FieldByName('refBanco').asInteger);
      FieldByName('lxFormaPago').AsString:= DM_OrdenesDePago.ObtenerFormaPago (FieldByName('refFormaPago').asInteger);
      FieldByName('lxCheque').asString:= ObtenerNroCheque(FieldByName('refCheque').AsString);
      FieldByName('lxFechaCheque').asString:= ObtenerfVtoCheque(FieldByName('refCheque').AsString);
      Post;
      Next;
    end;
  end;
  RecalcularMontos;
end;

procedure TDM_EgresosVarios.EliminarEgreso;
begin
  with tbEVDEL do
  begin
    ParamByName('idEgresoVario').asString:= tbEgresosVarios.FieldByName('idEgresoVario').asString;
    ExecSQL;
  end;
end;


(*******************************************************************************
***  EGRESOS VARIOS ITEMS
*******************************************************************************)

procedure TDM_EgresosVarios.NuevoEgresoVarioItem;
begin
  with tbEgresosVariosItems do
  begin
    if RecordCount > 0 then
       Last;
    Insert;
  end;
end;

function TDM_EgresosVarios.getImputacion: integer;
begin
  with tbEgresosVariosItems do
  begin
    if RecordCount > 0 then
       Result:= FieldByName('refImputacion').AsInteger
    else
        Result:= 0;
  end;
end;

function TDM_EgresosVarios.getMontoItems: double;
begin
  Result:= MontoEgreso(tbEgresosVarios.FieldByName('idEgresoVario').AsString);
end;

function TDM_EgresosVarios.getMontoPagos: double;
begin
  with qCalcularMontoPago do
  begin
    if active then close;
    ParamByName('refEgresoVario').asString:= tbEgresosVarios.FieldByName('idEgresoVario').AsString;
    Open;
    Result:= FieldByName('Total').asFloat;
    Close;
  end;
end;



procedure TDM_EgresosVarios.CargarImputacion(refCuenta: integer;
  txConcepto: string);
begin
  with tbEgresosVariosItems do
  begin
    Edit;
    FieldByName('refImputacion').asInteger:= refCuenta;
    DM_PlanDeCuentas.CuentaPorID(refCuenta);
    FieldByName('lxCuenta').asString:= DM_PlanDeCuentas.Concepto;
    FieldByName('lxCodigo').asString:= DM_PlanDeCuentas.Codigo;
    Post;
  end;
end;

procedure TDM_EgresosVarios.eliminarItem;
begin
  with tbEVIDEL do
  begin
    ParamByName('idEgresoVarioItem').AsString:= tbEgresosVariosItems.FieldByName('idEgresoVArioITem').asString;
    ExecSQL;
  end;
  tbEgresosVariosItems.Delete;
end;


function TDM_EgresosVarios.MontoEgreso(refEgreso: GUID_ID): double;
var
  accum: double;
begin
  with qCalcularMonto do
  begin
    if active then close;
    ParamByName('refEgresoVario').asString:= refEgreso;
    open;
    accum:= 0;
    While Not EOF do
    begin
      accum:= FieldByName('Total').asFloat;
      Next;
    end;
    Result:= accum;
  end;
end;

function TDM_EgresosVarios.ObtenerNroCheque(refCheque: string): string;
begin
  with qtbCheques do
  begin
    if active then close;
    ParamByName('idCheque').asString:= refCheque;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('NroCheque').AsString
    else
      Result:= '***';
  end;
end;


procedure TDM_EgresosVarios.LevantarEgresos;
begin
  tbEgresosVarios.DisableControls;
  DM_General.ReiniciarTabla(tbEgresosVarios);
  with qLevantarEgresos do
  begin
    if active then close;
    Open;
    tbEgresosVarios.LoadFromDataSet(qLevantarEgresos, 0, lmAppend);
  end;
  with tbEgresosVarios do
  begin
    if RecordCount > 0 then
       First;
    while Not eof do
    begin
      Edit;
      FieldByName('lxMonto').asFloat:= MontoEgreso(FieldByName('idEgresoVario').asString);
      Post;
      Next;
    end;
  end;
  tbEgresosVarios.EnableControls;
end;

(*******************************************************************************
***  FORMAS DE PAGO
*******************************************************************************)
function TDM_EgresosVarios.CargarValor(refFormaPago: integer;
  refCheque: GUID_ID; refBanco: integer; Monto: double; Banco, NroCheque: string
  ): GUID_ID;
var
  elID: GUID_ID;
begin
  elID:= DM_General.CrearGUID;
  with tbEVFormasPago do
  begin
    Insert;
    FieldByName('idEVFormaPago').asString:= elID;
    FieldByName('refEgresoVario').AsString:= tbEgresosVarios.FieldByName('idEgresoVario').asString;
    FieldByName('refFormaPago').asInteger:= refFormaPago;
    FieldByName('refCheque').asString:= refCheque;
    FieldByName('refBanco').asInteger:= refBanco;
    FieldByName('nMonto').asFloat:= Monto;
    FieldByName('lxBanco').asString:= DM_OrdenesDePago.ObtenerBanco (refBanco);
    FieldByName('lxFormaPago').AsString:= DM_OrdenesDePago.ObtenerFormaPago (refFormaPago);
    FieldByName('lxCheque').asString:= NroCheque;
    FieldByName('lxFechaCheque').asString:= ObtenerfVtoCheque(refCheque);
    Post;
  end;
  Result:= elID;
end;

procedure TDM_EgresosVarios.EliminarFormaPago;
begin
  with tbEVFPDEL do
  begin
    ParamByName('idEVFormaPago').asString:= tbEVFormasPago.FieldByName('idEVFormaPago').asString;
    ExecSQL;
    tbEVFormasPago.Delete;
  end;
end;


end.

