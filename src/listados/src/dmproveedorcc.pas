unit dmproveedorcc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZMConnection
  ,dmgeneral, db, BufDataset, memds, ZDataset;

type

  { TDM_ProveedorCC }

  TDM_ProveedorCC = class(TDataModule)
    qComprasFECHA: TDateField;
    qComprasNROFACTURA: TLongintField;
    qComprasNROPTOVENTA: TLongintField;
    qComprasNTOTAL: TFloatField;
    qPagos: TZQuery;
    qProveedores: TZQuery;
    qPagosFFECHA: TDateField;
    qPagosNUMEROORDENPAGO: TLongintField;
    qPagosTOTAL: TFloatField;
    qProveedoresBVISIBLE: TSmallintField;
    qProveedoresCCONTACTO: TStringField;
    qProveedoresCCORREOS: TStringField;
    qProveedoresCCUIT: TStringField;
    qProveedoresCDOMICILIO: TStringField;
    qProveedoresCINGRESOSBRUTOS: TStringField;
    qProveedoresCNOMBREFANTASIA: TStringField;
    qProveedoresCRAZONSOCIAL: TStringField;
    qProveedoresCTELEFONOS: TStringField;
    qProveedoresCWEB: TStringField;
    qProveedoresIDPROVEEDOR: TStringField;
    qProveedoresREFCONDICIONFISCAL: TLongintField;
    qProveedoresREFCONDICIONPAGO: TLongintField;
    qProveedoresREFCONDICIONPAGOTIEMPO: TLongintField;
    qProveedoresREFIMPUTACION: TLongintField;
    qProveedoresREFLOCALIDAD: TLongintField;
    qProveedoresTXNOTAS: TStringField;
    qTotalCompras: TZQuery;
    qTotalComprasAFecha: TZQuery;
    qTotalComprasAFechaTOTAL: TFloatField;
    qTotalComprasTOTAL: TFloatField;
    qTotalPagos: TZQuery;
    qCompras: TZQuery;
    qTotalPagosAfecha: TZQuery;
    qTotalPagosAfechaPAGADO: TFloatField;
    qTotalPagosPAGADO: TFloatField;
    tbResultados: TRxMemoryData;
    tbSaldosProveedores: TRxMemoryData;
    tbResultadosComprobante: TStringField;
    tbResultadosFecha: TDateField;
    tbResultadosMonto: TFloatField;
    tbResultadosPagado: TFloatField;
    tbResultadosSaldo: TFloatField;
    tbSaldosProveedorescCUIT: TStringField;
    tbSaldosProveedorescNombreFantasia: TStringField;
    tbSaldosProveedorescRazonSocial: TStringField;
    tbSaldosProveedoresidProveedor: TStringField;
    tbSaldosProveedoresSaldo: TFloatField;
    procedure tbResultadosAfterInsert(DataSet: TDataSet);
  private
    _fechaFin: TDate;
    _fechaIni: TDate;
    _idProveedor: GUID_ID;
    _saldoTotal: Double;
    function getSaldoProveedor: double;
    procedure AgregarSaldoAnterior;

    procedure CargarCompras;
    procedure CargarPagos;
    procedure CalcularSaldos;

    function ComponerFactura (ptoVenta, nro: integer): string;
  public
    property fechaIni: TDate write _fechaIni;
    property fechaFin: TDate write _fechaFin;
    property idProveedor: GUID_ID write _idProveedor;

    property SaldoTotal: Double read _saldoTotal;

    property SaldoProveedor:double read getSaldoProveedor;
    function SaldoAFecha (fecha: TDate): double;
    procedure FiltrarPagos;

    procedure ListadoSaldos (fecha: TDate);
  end;

var
  DM_ProveedorCC: TDM_ProveedorCC;

implementation
{$R *.lfm}
uses
    dateutils
  , strutils
  ;

{ TDM_ProveedorCC }

procedure TDM_ProveedorCC.tbResultadosAfterInsert(DataSet: TDataSet);
begin
 (*
  tbResultadosMonto.AsFloat:= 0;
  tbResultadosPagado.AsFloat:= 0;
  tbResultadosSaldo.asFloat:= 0;
  *)
end;

function TDM_ProveedorCC.getSaldoProveedor: double;
var
  compras, pagos: double;
begin
  DM_General.ReiniciarTabla(tbResultados);
  with qTotalCompras do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= _idProveedor;
    Open;
    if RecordCount > 0 then
       compras:= FieldByName('Total').asFloat
    else
        compras:= 0;
    close;
  end;

  with qTotalPagos do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= _idProveedor;
    Open;
    if RecordCount > 0 then
       pagos:= FieldByName('Pagado').asFloat
    else
        pagos:= 0;
    close;
  end;

  Result:= pagos - compras;
end;

function TDM_ProveedorCC.SaldoAFecha(fecha: TDate): double;
var
  compras, pagos: double;
begin
  with qTotalComprasAFecha do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= _idProveedor;
    ParamByName('fechaIni').AsDate:= fecha;
    Open;
    if RecordCount > 0 then
       compras:= FieldByName('Total').asFloat
    else
        compras:= 0;
    close;
  end;

  with qTotalPagosAfecha do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= _idProveedor;
    ParamByName('fechaIni').AsDate:= fecha;
    Open;
    if RecordCount > 0 then
       pagos:= FieldByName('Pagado').asFloat
    else
        pagos:= 0;
    close;
  end;

  Result:= pagos - compras;
end;

procedure TDM_ProveedorCC.AgregarSaldoAnterior;
var
  fechaAnterior: TDate;
begin
  fechaAnterior:= IncDay(_fechaIni, -1);;
  with tbResultados do
  begin
    Insert;
    FieldByName('Fecha').AsDateTime:= fechaAnterior;
    FieldByName('Comprobante').AsString:= 'Saldo al '+ DateToStr(fechaAnterior);
    FieldByName('Saldo').asFloat:= SaldoAFecha (fechaAnterior);
    Post;
  end;
end;

procedure TDM_ProveedorCC.CargarCompras;
begin
  with qCompras do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= _idProveedor;
    ParamByName('fechaIni').AsDate:= _fechaIni;
    ParamByName('fechaFin').asDate:= _fechaFin;
    Open;
    First;
    While Not EOF do
    begin
      tbResultados.Insert;
      tbResultadosFecha.AsDateTime:= qCompras.FieldByName('Fecha').AsDateTime;
      tbResultadosComprobante.asString:= ComponerFactura(qCompras.FieldByName('NroPtoVenta').AsInteger
                                                        ,qCompras.FieldByName('NroFactura').AsInteger
                                                        );
      tbResultadosMonto.AsFloat:= qCompras.FieldByName('nTotal').AsFloat;
      Next;
    end;
  end;
end;

procedure TDM_ProveedorCC.CargarPagos;
begin
  with qPagos do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= _idProveedor;
    ParamByName('fechaIni').AsDate:= _fechaIni;
    ParamByName('fechaFin').asDate:= _fechaFin;
    Open;
    First;
    While Not EOF do
    begin
      tbResultados.Insert;
      tbResultadosFecha.AsDateTime:= FieldByName('fFecha').AsDateTime;
      tbResultadosComprobante.asString:= 'Orden de Pago: ' + IntToStr (FieldByName('NumeroOrdenPago').asInteger);
      tbResultadosPagado.AsFloat:= FieldByName('Total').AsFloat;
      Next;
    end;
  end;

end;

procedure TDM_ProveedorCC.CalcularSaldos;
var
  saldoAnt: double;
begin
 with tbResultados do
 begin

   First;
   saldoAnt:= tbResultadosSaldo.AsFloat;
   While Not EOF do
   begin
     Edit;
     tbResultadosSaldo.AsFloat:= saldoAnt - tbResultadosMonto.asFloat + tbResultadosPagado.AsFloat;
     Post;
     saldoAnt:= tbResultadosSaldo.AsFloat;
     Next;
   end;
 end;
end;

function TDM_ProveedorCC.ComponerFactura(ptoVenta, nro: integer): string;
begin
 Result:= AddChar('0',IntToStr(ptoVenta),4)
               + ' - '
               + AddChar('0',IntToStr(nro),8);
end;

procedure TDM_ProveedorCC.FiltrarPagos;
begin
 tbResultados.DisableControls;

 DM_General.ReiniciarTabla(tbResultados);

 AgregarSaldoAnterior;
 CargarCompras;
 CargarPagos;
 tbResultados.First;
 tbResultados.SortOnFields('Fecha');
 CalcularSaldos;

 tbResultados.EnableControls;
end;

procedure TDM_ProveedorCC.ListadoSaldos(fecha: TDate);
begin
 DM_General.ReiniciarTabla(tbSaldosProveedores);
 tbSaldosProveedores.DisableControls;
  with qProveedores do
  begin
    if active then close;
    Open;
    tbSaldosProveedores.LoadFromDataSet(qProveedores, 0,lmAppend);
    close;
  end;

 _saldoTotal:= 0;

 with tbSaldosProveedores do
 begin
   First;
   While NOT EOF do
   begin
     _idProveedor:= tbSaldosProveedoresidProveedor.AsString;

     Edit;
     FieldByName('Saldo').asFloat:= SaldoAFecha(fecha);
     Post;

     Next;
   end;

   First;
   While NOT EOF do
   begin
     if ((tbSaldosProveedoresSaldo.AsFloat <= 0.01)
          AND
         (tbSaldosProveedoresSaldo.AsFloat >= -0.01)
         ) then
     begin
       Delete;
       First;
       _saldoTotal:= 0;
     end
     else
      _saldoTotal:= _saldoTotal + tbSaldosProveedoresSaldo.AsFloat;

     Next;
   end;
 end;

 tbSaldosProveedores.EnableControls;
end;

end.

