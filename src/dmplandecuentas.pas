unit dmplandecuentas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

CONST
  OPERACION_INGRESO = 'I';
  OPERACION_EGRESO = 'E';

type

  { TDM_PlanDeCuentas }

  TDM_PlanDeCuentas = class(TDataModule)
    qLevantarPlanDeCuentas: TZQuery;
    qFiltrarCodigo: TZQuery;
    qFiltrarCuenta: TZQuery;
    tugPlanDeCuentasSEL: TZQuery;
    tbPlanDeCuentas: TRxMemoryData;
    tbPlanDeCuentasbVisible: TLongintField;
    tbPlanDeCuentasCodigo: TStringField;
    tbPlanDeCuentasCuenta: TStringField;
    tbPlanDeCuentasidCuenta: TLongintField;
    tbPlanDeCuentasOperacion: TStringField;
    tbPlanDeCuentasPorcIVA: TFloatField;
    tugPlanDeCuentasINS: TZQuery;
    qCuentaPorCodigo: TZQuery;
    tugPlanDeCuentasUPD: TZQuery;
    tugPlanDeCuentasDEL: TZQuery;
    procedure tbPlanDeCuentasAfterInsert(DataSet: TDataSet);
  private
    function getCodigo: string;
    function getConcepto: string;
    function getIdCuenta: integer;
    { private declarations }
  public
    property Concepto: string read getConcepto;
    property idCuenta: integer read getIdCuenta;
    property Codigo: string read getCodigo;

    procedure CuentaPorID (refCuenta: integer);
    procedure LevantarPlanDeCuentas;
    procedure FiltrarConcepto (elConcepto: string);
    procedure FiltrarCodigo (elCodigo: string);

    procedure CancelarAE;
    procedure AsentarAE;
    procedure BorrarCuentaActual;
    procedure Nueva;
    procedure Modificar;
    function ExisteCodigoImputacion (elCodigo: string):boolean;

  end; 

var
  DM_PlanDeCuentas: TDM_PlanDeCuentas;

implementation

{$R *.lfm}

{ TDM_PlanDeCuentas }

procedure TDM_PlanDeCuentas.tbPlanDeCuentasAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCuenta').asInteger:= -1;
    FieldByName('Operacion').asString:= OPERACION_INGRESO;
    FieldByName('PorcIVA').asFloat:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

function TDM_PlanDeCuentas.getCodigo: string;
begin
  with tbPlanDeCuentas do
  begin
    if Active and (RecordCount > 0) then
      Result:= FieldByName('Codigo').asString
    else
      Result:= EmptyStr;
  end;
end;

function TDM_PlanDeCuentas.getConcepto: string;
begin
  with tbPlanDeCuentas do
  begin
    if Active and (RecordCount > 0) then
      Result:= FieldByName('Cuenta').asString
    else
      Result:= EmptyStr;
  end;
end;

function TDM_PlanDeCuentas.getIdCuenta: integer;
begin
  with tbPlanDeCuentas do
  begin
    if Active and (RecordCount > 0) then
      Result:= FieldByName('idCuenta').asInteger
    else
      Result:= 0;
  end;
end;

procedure TDM_PlanDeCuentas.CuentaPorID(refCuenta: integer);
begin
  DM_General.ReiniciarTabla(tbPlanDeCuentas);
  with tugPlanDeCuentasSEL do
  begin
    if active then close;
    ParamByName('idCuenta').asInteger:= refCuenta;
    Open;
    tbPlanDeCuentas.LoadFromDataSet(tugPlanDeCuentasSEL,0, lmAppend);
    close;
  end;
end;

procedure TDM_PlanDeCuentas.LevantarPlanDeCuentas;
begin
  with qLevantarPlanDeCuentas do
  begin
    if Active then close;
    Open;
    DM_General.ReiniciarTabla(tbPlanDeCuentas);
    tbPlanDeCuentas.LoadFromDataSet(qLevantarPlanDeCuentas, 0, lmAppend);
  end;
end;

procedure TDM_PlanDeCuentas.FiltrarConcepto(elConcepto: string);
begin
  with qFiltrarCuenta do
  begin
    if Active then close;
    ParamByName('laCuenta').asString:= elConcepto;
    Open;
    DM_General.ReiniciarTabla(tbPlanDeCuentas);
    tbPlanDeCuentas.LoadFromDataSet(qFiltrarCuenta, 0, lmAppend);
  end;
end;

procedure TDM_PlanDeCuentas.FiltrarCodigo(elCodigo: string);
begin
  with qFiltrarCodigo do
  begin
    if Active then close;
    ParamByName('elCodigo').asString:= elCodigo;
    Open;
    DM_General.ReiniciarTabla(tbPlanDeCuentas);
    tbPlanDeCuentas.LoadFromDataSet(qFiltrarCodigo, 0, lmAppend);
  end;
end;

procedure TDM_PlanDeCuentas.CancelarAE;
begin
  tbPlanDeCuentas.Cancel;
end;

procedure TDM_PlanDeCuentas.AsentarAE;
begin
  tbPlanDeCuentas.Post;
  DM_General.GrabarDatos(tugPlanDeCuentasSEL, tugPlanDeCuentasINS, tugPlanDeCuentasUPD, tbPlanDeCuentas, 'idCuenta');
end;

procedure TDM_PlanDeCuentas.BorrarCuentaActual;
begin
  if tbPlanDeCuentas.RecordCount > 0 then
  begin
    with tugPlanDeCuentasDEL do
    begin
      ParamByName('idCuenta').asInteger:= tbPlanDeCuentas.FieldByName('idCuenta').asInteger;
      ExecSQL;
      tbPlanDeCuentas.Delete;
    end;
  end;
end;

procedure TDM_PlanDeCuentas.Nueva;
begin
  tbPlanDeCuentas.Insert;
end;

procedure TDM_PlanDeCuentas.Modificar;
begin
  tbPlanDeCuentas.Edit;
end;

function TDM_PlanDeCuentas.ExisteCodigoImputacion(elCodigo: string): boolean;
var
  elIdCuenta: integer;
begin
  with qCuentaPorCodigo do
  begin
    if active then close;
    ParamByName('codigo').asString:= Trim(elCodigo);
    Open;
    if RecordCount > 0 then
      elIdCuenta:= FieldByName('idCuenta').asInteger
    else
      elIdCuenta:= -1;
  end;

  LevantarPlanDeCuentas;
  with tbPlanDeCuentas do
  begin
    First;
    Result:= Locate('idCuenta',elIdCuenta,[]);
  end;
end;

end.

