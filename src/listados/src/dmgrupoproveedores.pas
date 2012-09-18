unit dmgrupoproveedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;
const
  _LST_COMP_SALDOS = 1;

type

  { TDM_GrupoProveedores }

  TDM_GrupoProveedores = class(TDataModule)
    qPendientes: TZQuery;
    qFiltrado: TZQuery;
    qComSaldo: TZQuery;
    tbComposicionSaldoFactura: TStringField;
    tbComposicionSaldoFactura1: TStringField;
    tbComposicionSaldoFechaFactura: TDateField;
    tbComposicionSaldoFechaFactura1: TDateField;
    tbComposicionSaldofechaOP: TDateField;
    tbComposicionSaldofechaOP1: TDateField;
    tbComposicionSaldoidCompra: TStringField;
    tbComposicionSaldoidCompra1: TStringField;
    tbComposicionSaldoMontoPagado: TFloatField;
    tbComposicionSaldoMontoPagado1: TFloatField;
    tbComposicionSaldonumeroOrdenPago: TLongintField;
    tbComposicionSaldonumeroOrdenPago1: TLongintField;
    tbComposicionSaldoProveedor: TStringField;
    tbComposicionSaldoProveedor1: TStringField;
    tbComposicionSaldoSaldo: TFloatField;
    tbComposicionSaldoSaldo1: TFloatField;
    tbComposicionSaldoTotalFactura: TFloatField;
    tbComposicionSaldoTotalFactura1: TFloatField;
    tbResultados: TRxMemoryData;
    tbComposicionSaldo: TRxMemoryData;
    tbResultadoscCuit: TStringField;
    tbResultadosFechaCompra: TDateField;
    tbResultadosFechaOP: TDateField;
    tbResultadosFormaPago: TStringField;
    tbResultadosMontoFactura: TFloatField;
    tbResultadosMontoPagado: TFloatField;
    tbResultadosNombreFantasia: TStringField;
    tbResultadosNroFactura: TLongintField;
    tbResultadosNroOP: TLongintField;
    tbResultadosNroPtoVenta: TLongintField;
    tbResultadosPercepCapital: TFloatField;
    tbResultadosPercepIVA: TFloatField;
    tbResultadosPercepProvincia: TFloatField;
    tbResultadosRazonSocial: TStringField;
    procedure tbComposicionSaldoAfterInsert(DataSet: TDataSet);
  private
    procedure CalcularSaldos;
  public
    procedure Filtrar;
    procedure ComposicionSaldo (refProveedor: GUID_ID);

    procedure Pendientes;
  end; 

var
  DM_GrupoProveedores: TDM_GrupoProveedores;

implementation

{$R *.lfm}

{ TDM_GrupoProveedores }

procedure TDM_GrupoProveedores.tbComposicionSaldoAfterInsert(DataSet: TDataSet);
begin
  with  DataSet do
  begin
    FieldByName('Saldo').asFloat:= 0;
    FieldByName('MontoPagado').asFloat:= 0;
    FieldByName('TotalFactura').asFloat:= 0;
  end;
end;

procedure TDM_GrupoProveedores.CalcularSaldos;
var
  refCompra: GUID_ID;
  elSaldo: Double;
begin
  with tbComposicionSaldo do
  begin
    DisableControls;
    First;
    elSaldo:= 0;
    refCompra:= GUIDNULO;
    While Not EOF do
    begin
      if (refCompra <> FieldByName('idCompra').asString) then
      begin
        refCompra:= FieldByName('idCompra').asString;
        elSaldo:= elSaldo - FieldByName('TotalFactura').asFloat;
      end;
      elSaldo:= elSaldo + FieldByName('MontoPagado').asFloat;
      Edit;
      FieldByName('Saldo').asFloat:= elSaldo;
      Post;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_GrupoProveedores.Filtrar;
begin
  DM_General.ReiniciarTabla(tbResultados);
  with qFiltrado do
  begin
    if Active then close;

    open;
    tbResultados.LoadFromDataSet(qFiltrado, 0, lmAppend);
  end;
end;

procedure TDM_GrupoProveedores.ComposicionSaldo(refProveedor: GUID_ID);
begin
  with qComSaldo do
  begin
    DM_General.ReiniciarTabla(tbComposicionSaldo);
    if active then close;
    ParamByName('refProveedor').asString:= refProveedor;
    Open;
    tbComposicionSaldo.LoadFromDataSet(qComSaldo, 0, lmAppend);
    Close;
  end;
  CalcularSaldos;
end;

procedure TDM_GrupoProveedores.Pendientes;
var
  proveedor
  ,refCompra: string;
  saldo: double;
begin
  DM_General.ReiniciarTabla(tbComposicionSaldo);
  with qPendientes do
  begin
    if active then close;
    Open;
    tbComposicionSaldo.LoadFromDataSet(qPendientes, 0, lmAppend);
    Close;
  end;

  with tbComposicionSaldo do
  begin
    DisableControls;
    First;
    proveedor:= 'xx--xx';
    While Not Eof do
    begin

      if (proveedor <> FieldByName('proveedor').asString) then
      begin
        saldo:= 0;
        refCompra:= GUIDNULO;
        proveedor:= FieldByName('proveedor').asString;
      end;

      if (refCompra <> FieldByName('idCompra').asString) then
      begin
        saldo:= saldo - FieldByName('TotalFactura').asFloat;
        refCompra:= FieldByName('idCompra').asString;
      end;

      saldo:= saldo + FieldByName('MontoPagado').asFloat;
      Edit;
      FieldByName('Saldo').asFloat:= saldo;
      Post;

      Next;
    end;
    EnableControls;
  end;
end;

end.

