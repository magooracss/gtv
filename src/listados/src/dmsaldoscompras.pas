unit dmsaldoscompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_SaldosCompras }

  TDM_SaldosCompras = class(TDataModule)
    qComprasImpagas: TZQuery;
    qComprasImpagasCOMPROBANTE: TStringField;
    qComprasImpagasFECHA: TDateField;
    qComprasImpagasIDCOMPRA: TStringField;
    qComprasImpagasIMPCOMPROBANTE: TFloatField;
    qComprasImpagasIMPPAGADO: TFloatField;
    qComprasImpagasPROVEEDOR: TStringField;
    qComprasImpagasSALDO: TFloatField;
    qComprasPagadas: TZQuery;
    qComprasPagadasTOTAL: TFloatField;
    tbResultados: TRxMemoryData;
    tbResultadosComprobante: TStringField;
    tbResultadosFecha: TDateField;
    tbResultadosidCompra: TStringField;
    tbResultadosImpComprobante: TFloatField;
    tbResultadosImpPagado: TFloatField;
    tbResultadosProveedor: TStringField;
    tbResultadosSaldo: TFloatField;
  private
    procedure prepararSQL(refProveedor: GUID_ID);
    procedure CargarSaldos;
  public
    procedure Filtrar (refProveedor: GUID_ID);
  end; 

var
  DM_SaldosCompras: TDM_SaldosCompras;

implementation

{$R *.lfm}

{ TDM_SaldosCompras }

procedure TDM_SaldosCompras.prepararSQL(refProveedor: GUID_ID);
begin
  with qComprasImpagas do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add ('SELECT C.idCompra, P.cRazonSocial as Proveedor, C.Fecha, C.nTotal as ImpComprobante, 0 as Saldo, 0 as ImpPagado');
    SQL.Add ('       , (tTC.TipoComprobante || ''  '' || C.nroPtoVenta|| ''-'' || C.nroFactura) as Comprobante' );
    SQL.Add ('FROM tbCompras C');
    SQL.Add ('  LEFT JOIN tbProveedores P ON P.idProveedor = C.refProveedor');
    SQL.Add ('  LEFT JOIN tugTiposComprobantes tTC ON tTC.idTipoComprobante = C.refTipoComprobante');
    SQL.Add ('WHERE (C.bPagada = 0) and (C.bVisible = 1)');
    if (refProveedor <> GUIDNULO) then
    SQL.Add ('       AND  (C.refProveedor = '''+ refProveedor + ''')');
    SQL.Add ('ORDER BY P.cRazonSocial, C.Fecha');
  end;
end;

procedure TDM_SaldosCompras.CargarSaldos;
begin
  with tbResultados do
  begin
    DisableControls;
    First;
    While not EOF do
    begin
      qComprasPagadas.Close;
      qComprasPagadas.ParamByName('refCompra').asString:= FieldByName('idCompra').asString;
      qComprasPagadas.Open;
      if qComprasPagadas.RecordCount > 0 then
      begin
        Edit;
        FieldByName('ImpPagado').asFloat:= qComprasPagadas.FieldByName('Total').asFloat;
        FieldByName('Saldo').asFloat:= FieldByName('ImpComprobante').asFloat - FieldByName('impPagado').asFloat;
        Post;
      end;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_SaldosCompras.Filtrar(refProveedor: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbResultados);
  prepararSQL(refProveedor);
  qComprasImpagas.Open;
  tbResultados.LoadFromDataSet(qComprasImpagas, 0, lmAppend);
  qComprasImpagas.Close;
  CargarSaldos;
end;

end.

