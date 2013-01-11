unit dmgrupocuentas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, rxmemds, ZDataset
  , dmgeneral;

const
  _LST_COMPRAS      = 1;
  _LST_ORDENES_PAGO = 2;
  _LST_EGRESOS_VARIOS = 3;
  _LST_EGRESOS_TODOS = 4;


type

  { TDM_GrupoCuentas }

  TDM_GrupoCuentas = class(TDataModule)
    qSubdiarioCompras: TZQuery;
    qSubdiarioComprasCOMPROBANTE: TStringField;
    qSubdiarioComprasCUIT: TStringField;
    qSubdiarioComprasFECHA: TDateField;
    qSubdiarioComprasIDCOMPRA: TStringField;
    qSubdiarioComprasIMPNOGRAVADO: TFloatField;
    qSubdiarioComprasIMPORTETOTAL: TFloatField;
    qSubdiarioComprasIVA: TFloatField;
    qSubdiarioComprasPERCEPCAPITAL: TFloatField;
    qSubdiarioComprasPERCEPIVA: TFloatField;
    qSubdiarioComprasPERCEPPROVINCIA: TFloatField;
    qSubdiarioComprasRAZONSOCIAL: TStringField;
    qSubdiarioPagos: TZQuery;
    qSubdiarioPagosCOMPROBANTE: TStringField;
    qSubdiarioPagosCUIT: TStringField;
    qSubdiarioPagosFECHA: TDateField;
    qSubdiarioPagosIMPORTETOTAL: TFloatField;
    qSubdiarioPagosRAZONSOCIAL: TStringField;
    qTotalesCompra: TZQuery;
    qFiltrado: TZQuery;
    qTotalesCompraIVA: TFloatField;
    qTotalesCompraMONTOTOTAL: TFloatField;
    tbResultados: TRxMemoryData;
    tbSubdiarioCompras: TRxMemoryData;
    tbResultadoscCuit: TStringField;
    tbResultadoscNombreFantasia: TStringField;
    tbResultadosCodigoCuenta: TStringField;
    tbResultadoscRazonSocial: TStringField;
    tbResultadosEgreso: TFloatField;
    tbResultadosFactura_OP: TStringField;
    tbResultadosFecha: TDateField;
    tbResultadosIngreso: TFloatField;
    tbResultadosNombreCuenta: TStringField;
    tbSubdiarioPagos: TRxMemoryData;
    tbSubdiarioComprasComprobante: TStringField;
    tbSubdiarioComprasComprobante1: TStringField;
    tbSubdiarioComprasCuit: TStringField;
    tbSubdiarioComprasCuit1: TStringField;
    tbSubdiarioComprasFecha: TDateField;
    tbSubdiarioComprasFecha1: TDateField;
    tbSubdiarioComprasidCompra: TStringField;
    tbSubdiarioComprasidCompra1: TStringField;
    tbSubdiarioComprasImpNoGravado: TFloatField;
    tbSubdiarioComprasImporteTotal: TFloatField;
    tbSubdiarioComprasImporteTotal1: TFloatField;
    tbSubdiarioComprasiva: TFloatField;
    tbSubdiarioComprasPercepCapital: TFloatField;
    tbSubdiarioComprasPercepIVA: TFloatField;
    tbSubdiarioComprasPercepProvincia: TFloatField;
    tbSubdiarioComprasRazonSocial: TStringField;
    tbSubdiarioComprasRazonSocial1: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbResultadosAfterInsert(DataSet: TDataSet);
    procedure tbSubdiarioComprasAfterInsert(DataSet: TDataSet);
  private
    _bCuentasTodas: boolean;
    _bEmpresasTodas: boolean;
    _fechaFin:   TDate;
    _fechaIni:   TDate;
    _refCuenta:  integer;
    _refEmpresa: GUID_ID;

    _totalIngresos: double;
    _totalEgresos:  double;

    procedure prepararSQLCompras;
    procedure FiltrarCompras;

    procedure prepararSQLOrdenesPago;
    procedure FiltrarOrdenesPago;

    procedure prepararSQLEgresosVariosPaso1;
    procedure prepararSQLEgresosVariosPaso2;
    procedure FiltrarEgresosVarios;

    procedure FiltrarEgresosTodos;

    procedure CalcularTotales;
    procedure CalcularMontosSubTotalesCompras;


  public
    property fechaIni: TDate Read _fechaIni Write _fechaIni;
    property fechaFin: TDate Read _fechaFin Write _fechaFin;
    property refEmpresa: GUID_ID Read _refEmpresa Write _refEmpresa;
    property bEmpresasTodas: boolean Read _bEmpresasTodas Write _bEmpresasTodas;
    property refCuenta: integer Read _refCuenta Write _refCuenta;
    property bCuentasTodas: boolean Read _bCuentasTodas Write _bCuentasTodas;

    property TotalEgresos: double Read _totalEgresos;
    property TotalIngresos: double Read _totalIngresos;

    procedure Filtrar(refTipoListado: integer);

    procedure filtrarSubdiarioCompras(fIni, fFin: TDate);
    procedure filtrarSubdiarioPagos(fIni, fFin: TDate);
  end;

var
  DM_GrupoCuentas: TDM_GrupoCuentas;

implementation

{$R *.lfm}

{ TDM_GrupoCuentas }

procedure TDM_GrupoCuentas.tbResultadosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('Ingreso').AsFloat := 0;
    FieldByName('Egreso').AsFloat  := 0;
  end;
end;

procedure TDM_GrupoCuentas.tbSubdiarioComprasAfterInsert(DataSet: TDataSet);
begin
  tbSubdiarioComprasImpNoGravado.AsFloat := 0;
  tbSubdiarioComprasiva.AsFloat := 0;
  tbSubdiarioComprasPercepCapital.AsFloat := 0;
  tbSubdiarioComprasPercepProvincia.AsFloat := 0;
  tbSubdiarioComprasPercepIVA.AsFloat := 0;
  tbSubdiarioComprasImporteTotal.AsFloat := 0;
end;

procedure TDM_GrupoCuentas.DataModuleCreate(Sender: TObject);
begin
  _totalEgresos  := 0;
  _totalIngresos := 0;
end;


procedure TDM_GrupoCuentas.Filtrar(refTipoListado: integer);
begin
  DM_General.ReiniciarTabla(tbResultados);
  _totalEgresos  := 0;
  _totalIngresos := 0;
  case refTipoListado of
    _LST_COMPRAS: FiltrarCompras;
    _LST_ORDENES_PAGO: FiltrarOrdenesPago;
    _LST_EGRESOS_VARIOS: FiltrarEgresosVarios;
    _LST_EGRESOS_TODOS: FiltrarEgresosTodos;
  end;

  CalcularTotales;

end;

procedure TDM_GrupoCuentas.filtrarSubdiarioCompras(fIni, fFin: TDate);
begin
  DM_General.ReiniciarTabla(tbSubdiarioCompras);

  with qSubdiarioCompras do
  begin
    DisableControls;
    if active then
      Close;
    ParamByName('fIni').AsDate := fIni;
    ParamByName('fFin').AsDate := fFin;
    Open;
    tbSubdiarioCompras.LoadFromDataSet(qSubdiarioCompras, 0, lmAppend);
    EnableControls;
  end;
  CalcularMontosSubTotalesCompras;
end;


procedure TDM_GrupoCuentas.CalcularMontosSubTotalesCompras;
var
  montoTotal, iva: double;
begin
  with tbSubdiarioCompras do
  begin
    DisableControls;
    First;
    While Not EOF do
    begin
      if qTotalesCompra.Active then qTotalesCompra.Close;
      qTotalesCompra.ParamByName('refCompra').asString:= tbSubdiarioComprasidCompra.AsString;
      qTotalesCompra.Open;
      Edit;
      if qTotalesCompra.FieldByName('montoTotal').IsNull then
        montoTotal:= 0
      else
        montoTotal:= qTotalesCompra.FieldByName('montoTotal').asFloat;
      if qTotalesCompra.FieldByName('iva').IsNull then
        iva:= 0
      else
        iva:= qTotalesCompra.FieldByName('iva').asFloat;

      FieldByName('ImpNoGravado').asFloat:= montoTotal - IVA;
      FieldByName('iva').asFloat:= iva;
      Post;
      Next;
    end;
    EnableControls;
  end;
end;


procedure TDM_GrupoCuentas.CalcularTotales;
begin
  with tbResultados do
  begin
    DisableControls;
    if not EOF then
      First;
    while not EOF do
    begin
      _totalEgresos  := _totalEgresos + FieldByName('Egreso').AsFloat;
      _totalIngresos := _totalIngresos + FieldByName('Ingreso').AsFloat;
      Next;
    end;
    EnableControls;
  end;
end;


 (*******************************************************************************)
 (***                    LISTADO COMPRAS                                      ***)
 (*******************************************************************************)

procedure TDM_GrupoCuentas.prepararSQLCompras;
begin
  with qFiltrado do
  begin
    if active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT  C.Fecha, P.Codigo as CodigoCuenta, P.Cuenta as NombreCuenta');
    SQL.Add(' ,Pr.cRazonSocial, Pr.cNombreFantasia, Pr.cCuit, CI.nMontoTotal as Ingreso, (C.nroPtoVenta || ''-''|| C.nroFactura) as Factura_OP');
    SQL.Add('FROM tbCompras C');
    SQL.Add('    INNER JOIN tbComprasItems CI ON CI.refCompra = C.idCompra');
    SQL.Add('    LEFT JOIN tugPlanDeCuentas P ON P.idCuenta = CI.refImputacion');
    SQL.Add('    INNER JOIN tbProveedores Pr ON Pr.idProveedor = C.refProveedor');
  end;
end;

procedure TDM_GrupoCuentas.FiltrarCompras;
begin
  prepararSQLCompras;
  with qFiltrado do
  begin
    SQL.Add('WHERE (C.bVisible = 1)');
    SQL.Add('      and (C.fecha >= ''' + FormatDateTime('mm/dd/yyyy', fechaIni) + ''')');

    SQL.Add('      and (C.fecha <= ''' + FormatDateTime('mm/dd/yyyy', fechaFin) + ''')');

    if not bEmpresasTodas then
      SQL.Add('      and (C.refProveedor = ''' + refEmpresa + ''')');

    if not bCuentasTodas then
      SQL.Add('      and (CI.refImputacion = ' + IntToStr(refCuenta) + ')');

    Open;
  end;
  DM_General.ReiniciarTabla(tbResultados);
  tbResultados.LoadFromDataSet(qFiltrado, 0, lmAppend);
end;


 (*******************************************************************************)
 (***                   LISTADO ORDENES DE PAGO                               ***)
 (*******************************************************************************)

procedure TDM_GrupoCuentas.prepararSQLOrdenesPago;
begin
  with qFiltrado do
  begin
    if active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT  OP.fFecha as Fecha, P.Codigo as CodigoCuenta, P.Cuenta as NombreCuenta');
    SQL.Add(' ,Pr.cRazonSocial, Pr.cNombreFantasia, Pr.cCuit, OPF.nMonto as Egreso, OP.numeroOrdenPago as Factura_OP');
    SQL.Add('FROM tbOrdenesPago OP');
    SQL.Add('    INNER JOIN tbOPFormasDePago OPF ON  OPF.refOrdenPago = OP.idOrdenPago');
    SQL.Add('    LEFT JOIN tugFormasPago FP ON FP.idFormaPago = OPF.refFormaPago');
    SQL.Add('    LEFT JOIN tugPlanDeCuentas P ON P.idCuenta = FP.refCuenta');
    SQL.Add('    INNER JOIN tbProveedores Pr ON Pr.idProveedor = OP.refProveedor');
  end;
end;

procedure TDM_GrupoCuentas.FiltrarOrdenesPago;
begin
  prepararSQLOrdenesPago;
  with qFiltrado do
  begin
    SQL.Add('WHERE (OP.bVisible = 1)');
    SQL.Add('      and (OP.fFecha >= ''' +
      FormatDateTime('mm/dd/yyyy', fechaIni) + ''')');

    SQL.Add('      and (OP.fFecha <= ''' +
      FormatDateTime('mm/dd/yyyy', fechaFin) + ''')');

    if not bEmpresasTodas then
      SQL.Add('      and (OP.refProveedor = ''' + refEmpresa + ''')');

    if not bCuentasTodas then
      SQL.Add('      and (FP.refImputacion = ' + IntToStr(refCuenta) + ')');

    Open;
  end;
  tbResultados.LoadFromDataSet(qFiltrado, 0, lmAppend);
end;


 (*******************************************************************************)
 (***                   LISTADO DE EGRESOS VARIOS                             ***)
 (*******************************************************************************)

procedure TDM_GrupoCuentas.prepararSQLEgresosVariosPaso1;
begin
  with qFiltrado do
  begin
    if active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT  EV.Fecha, P.Codigo as CodigoCuenta, P.Cuenta as NombreCuenta');
    SQL.Add(' ,'' '' as cRazonSocial, EVI.Leyenda as cNombreFantasia, '' '' cCuit, EVI.nMonto as Ingreso, 0.0 as Egreso');
    SQL.Add('FROM tbEgresosVarios EV');
    SQL.Add('    INNER JOIN tbEgresosVariosItems EVI ON EVI.refEgresoVario = EV.idEgresoVario');
    SQL.Add('    LEFT JOIN tugPlanDeCuentas P ON P.idCuenta = EVI.refImputacion');
  end;
end;


procedure TDM_GrupoCuentas.prepararSQLEgresosVariosPaso2;
begin
  with qFiltrado do
  begin
    if active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT  EV.Fecha, P.Codigo as CodigoCuenta, P.Cuenta as NombreCuenta');
    SQL.Add(' ,'' '' as cRazonSocial, EV.Titulo as cNombreFantasia, '' '' cCuit, 0 as Ingreso, EVFP.nMonto as Egreso');
    SQL.Add('FROM tbEgresosVarios EV');
    SQL.Add('    INNER JOIN tbEVFormasPago EVFP ON EVFP.refEgresoVario = EV.idEgresoVario');
    SQL.Add('    INNER JOIN tugFormasPago FP ON EVFP.refFormaPago = FP.idFormaPago');
    SQL.Add('    LEFT JOIN tugPlanDeCuentas P ON P.idCuenta = FP.refCuenta');
  end;
end;


procedure TDM_GrupoCuentas.FiltrarEgresosVarios;
begin
  prepararSQLEgresosVariosPaso1;
  with qFiltrado do
  begin
    SQL.Add('WHERE (EV.bVisible = 1)');
    SQL.Add('      and (EV.Fecha >= ''' + FormatDateTime('mm/dd/yyyy', fechaIni) + ''')');

    SQL.Add('      and (EV.Fecha <= ''' + FormatDateTime('mm/dd/yyyy', fechaFin) + ''')');

    if not bCuentasTodas then
      SQL.Add('      and (EVI.refImputacion = ' + IntToStr(refCuenta) + ')');

    Open;
  end;
  tbResultados.LoadFromDataSet(qFiltrado, 0, lmAppend);

  prepararSQLEgresosVariosPaso2;
  with qFiltrado do
  begin
    SQL.Add('WHERE (EV.bVisible = 1)');
    SQL.Add('      and (EV.Fecha >= ''' + FormatDateTime('mm/dd/yyyy', fechaIni) + ''')');

    SQL.Add('      and (EV.Fecha <= ''' + FormatDateTime('mm/dd/yyyy', fechaFin) + ''')');

    if not bCuentasTodas then
      SQL.Add('      and (FP.refCuenta = ' + IntToStr(refCuenta) + ')');

    Open;
  end;
  tbResultados.LoadFromDataSet(qFiltrado, 0, lmAppend);
  tbResultados.SortOnFields('Fecha');
end;

 (*******************************************************************************)
 (***                   LISTADO DE TODOS LOS EGRESOS                          ***)
 (*******************************************************************************)

procedure TDM_GrupoCuentas.FiltrarEgresosTodos;
begin
  FiltrarCompras;
  if _bEmpresasTodas then
    FiltrarEgresosVarios;
  FiltrarOrdenesPago;
  tbResultados.SortOnFields('Fecha');
end;


 (*******************************************************************************)
 (*******************************************************************************)

procedure TDM_GrupoCuentas.filtrarSubdiarioPagos(fIni, fFin: TDate);
begin
  tbSubdiarioPagos.DisableControls;
  with qSubdiarioPagos do
  begin
    if active then close;
    ParamByName('fIni').asDate:= fIni;
    ParamByName('fFin').asDate:= fFin;
    Open;
    tbSubdiarioPagos.LoadFromDataSet(qSubdiarioPagos, 0, lmAppend);
  end;
  tbSubdiarioPagos.EnableControls;
end;

end.

