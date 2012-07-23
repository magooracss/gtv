unit dmcaja;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral, db;

const
  _TIPO_MOVIMIENTO_EGRESO = 'E';
  _TIPO_MOVIMIENTO_INGRESO = 'I';

  _LISTA_PROVEEDORES = 'P';
  _LISTA_CLIENTES = 'C';

type

  { TDM_CAJA }

  TDM_CAJA = class(TDataModule)
    qLevantarCaja: TZQuery;
    qLevantarCajaFiltrado: TZQuery;
    qLevantarSaldo: TZQuery;
    qtugConceptoPorID: TZQuery;
    qTugformasPago: TZQuery;
    tbCajaConcepto: TStringField;
    tbCajaConceptos: TRxMemoryData;
    tbCaja: TRxMemoryData;
    tbCajaConceptosbVisible: TLongintField;
    tbCajaConceptosfFecha: TDateTimeField;
    tbCajaConceptosfModificacion: TDateTimeField;
    tbCajaConceptosidCajaConcepto: TStringField;
    tbCajaConceptosnMonto: TFloatField;
    tbCajaConceptosrefConcepto: TLongintField;
    tbCajaConceptosrefEmpresa: TStringField;
    tbCajaConceptosrefFormaPago: TLongintField;
    tbCajaConceptosrefListaEmpresa: TStringField;
    tbCajaConceptostxDetalle: TStringField;
    tbCajaConceptostxDetallePago: TStringField;
    tbCajaConceptoDEL: TZQuery;
    tbCajafFecha: TDateTimeField;
    tbCajaidCajaConcepto: TStringField;
    tbCajalxEmpresa: TStringField;
    tbCajalxTipo: TStringField;
    tbCajanMonto: TFloatField;
    tbCajaProveedor: TStringField;
    tbCajarefEmpresa: TStringField;
    tbCajarefListaEmpresa: TStringField;
    tbCajaTipo: TStringField;
    tbCajatxDetalle: TStringField;
    tbCajaConceptoINS: TZQuery;
    tbCajaConceptoSEL: TZQuery;
    tbCajaConceptoUPD: TZQuery;
    qTugConceptos: TZQuery;
    tugConceptos: TZTable;
    tugConceptosBVISIBLE: TSmallintField;
    tugConceptosCONCEPTO: TStringField;
    tugConceptosIDCONCEPTO: TLongintField;
    tugConceptosMONTODEFECTO: TFloatField;
    tugConceptosTIPO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbCajaConceptosAfterInsert(DataSet: TDataSet);
    procedure tugConceptosAfterInsert(DataSet: TDataSet);
  private
    _saldoMostrado: double;
    procedure AjustarVistaCaja;
  public
    property SaldoPeriodo: double read _saldoMostrado;
    function SaldoInicial (fActual: TdateTime): double;
    procedure LevantarCaja(fIni, fFin: TDateTime);
    procedure LevantarCajaFiltrada ( FechaIni, FechaFin: TDateTime
                                     ;FiltroEmpresa: integer
                                     ; refEmpresa: GUID_ID
                                     ; FiltroConcepto: integer
                                     ; refConcepto: integer );

    procedure TablaTugConceptos (estado: boolean);
    procedure BorrarTugConcepto;

    function MontoConcepto (refConcepto: integer): double;
    procedure CargarMontoConcepto (refConcepto: integer);

    procedure InsertarConceptoCaja;
    procedure GrabarConcepto;
    procedure AjustarDatosConcepto (refConcepto, refFormaPago: integer
                                   ;tipoLista: string
                                   ;refEmpresa: GUID_ID);
    procedure ModificarConceptoCaja;
    procedure EliminarConcepto;
  end; 

var
  DM_CAJA: TDM_CAJA;

implementation
{$R *.lfm}
uses
  dateutils
  ;

{ TDM_CAJA }

procedure TDM_CAJA.DataModuleCreate(Sender: TObject);
begin
  tbCaja.Open;
end;

procedure TDM_CAJA.tbCajaConceptosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCajaConcepto').asString:= DM_General.CrearGUID;
    FieldByName('fFecha').AsDateTime:= Now;
    FieldByName('refConcepto').asInteger:= 0;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('refFormaPago').asInteger:= 0;
    FieldByName('txDetallePago').asString:= EmptyStr;
    FieldByName('txDetalle').asString:= EmptyStr;
    FieldByName('refEmpresa').asString:= GUIDNULO;
    FieldByName('refListaEmpresa').asString:= _LISTA_PROVEEDORES;
    FieldByName('fModificacion').asDateTime:= Now;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_CAJA.tugConceptosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idConcepto').asInteger:= -1;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_CAJA.AjustarVistaCaja;
var
  saldoActual: double;
begin
  saldoActual:= 0;
  with tbCaja do
  begin
    First;
    While Not EOF do
    begin
      Edit;
      if FieldByName('Tipo').asString = _TIPO_MOVIMIENTO_INGRESO then
        FieldByName('lxTipo').asString:= 'INGRESO'
      else
        FieldByName('lxTipo').asString:= 'EGRESO';
      if FieldByName('refListaEmpresa').asString = _LISTA_CLIENTES then
        FieldByName('lxEmpresa').AsString:= 'xx'
      else
        FieldByName('lxEmpresa').AsString:= TRIM(FieldByName('Proveedor').asString);
      Post;
      if FieldByName('Tipo').asString = _TIPO_MOVIMIENTO_INGRESO then
        saldoActual:= saldoActual + FieldByName('nMonto').asFloat
      else
        saldoActual:= saldoActual - FieldByName('nMonto').asFloat;
      Next;
    end;
    _SaldoMostrado:= saldoActual;
  end;
end;

function TDM_CAJA.SaldoInicial(fActual: TdateTime): double;
var
  fechaFinal: TDateTime;
  saldo: double;
begin
  fechaFinal:=IncDay(fActual, -1);
  saldo:= 0;
  DM_General.IntervaloFechasConsulta(fActual,fechaFinal);
  with qLevantarSaldo do
  begin
    if active then close;
    ParamByName('FechaIni').AsDateTime:= fechaFinal;
    Open;
    First;
    While Not EOF do
    begin
      if FieldByName('Tipo').asString = _TIPO_MOVIMIENTO_INGRESO then
        saldo:= saldo + FieldByName('nMonto').asFloat
      else
        saldo:= saldo - FieldByName('nMonto').asFloat;
      Next;
    end;
    Result:= saldo;
  end;
end;

procedure TDM_CAJA.LevantarCaja(fIni, fFin: TDateTime);
begin
  DM_General.ReiniciarTabla(tbCaja);
  DM_General.IntervaloFechasConsulta(fIni, fFin);

  with qLevantarCaja do
  begin
    if Active then close;
    ParamByName('fechaIni').asDateTime:= fIni;
    ParamByName('fechaFin').asDateTime:= fFin;
    Open;
    tbCaja.LoadFromDataSet(qLevantarCaja, 0, lmAppend);
    close;
  end;
  AjustarVistaCaja;
end;

procedure TDM_CAJA.LevantarCajaFiltrada(FechaIni, FechaFin: TDateTime;
  FiltroEmpresa: integer; refEmpresa: GUID_ID; FiltroConcepto: integer;
  refConcepto: integer);
begin
   DM_General.ReiniciarTabla(tbCaja);
  DM_General.IntervaloFechasConsulta(fechaIni, fechaFin);

  with qLevantarCajaFiltrado do
  begin
    if Active then close;
    SQL.Clear;
    SQL.Add(' SELECT CC.idCajaConcepto, CC.fFecha, CC.nMonto, CC.refEmpresa, CC.refListaEmpresa, CC.txDetalle');
    SQL.Add('  ,C.Concepto, C.Tipo ');
    SQL.Add('  ,P.cRazonSocial as Proveedor');
    SQL.Add('  ,Cl.cNombre as Cliente');
    SQL.Add(' FROM tbCajaConceptos CC ');
    SQL.Add('    LEFT JOIN tugConceptos C ON  CC.refConcepto = C.idConcepto');
    SQL.Add('    LEFT JOIN tbProveedores P ON CC.refEmpresa = P.idProveedor');
    SQL.Add('    LEFT JOIN tbClientes Cl ON CC.refEmpresa = Cl.idCliente');
    SQL.Add(' WHERE (CC.fFecha >= ''' +FormatDateTime('mm/dd/yyyy',FechaIni)+ ''') and (CC.fFecha <= '''+FormatDateTime('mm/dd/yyyy',FechaFin)+''') and (CC.bVisible = 1) ');

    case FiltroEmpresa of
     1: SQL.Add(' and (CC.refEmpresa = '''+ refEmpresa+''')');
     2: SQL.Add(' and (CC.refEmpresa = '''+ refEmpresa+''')');
    end;

    case FiltroConcepto of
     1: SQL.Add(' and (CC.refConcepto= '+ IntToStr(refConcepto)+')');
     2: SQL.Add(' and (C.Tipo = ''I'')');
     3: SQL.Add(' and (C.Tipo = ''E'')');
    end;

    SQL.Add('ORDER BY CC.fFecha, C.Concepto');

    Open;
    tbCaja.LoadFromDataSet(qLevantarCajaFiltrado, 0, lmAppend);
    close;
  end;
  AjustarVistaCaja;
end;

procedure TDM_CAJA.TablaTugConceptos(estado: boolean);
begin
  tugConceptos.Active:= estado;
end;

procedure TDM_CAJA.BorrarTugConcepto;
begin
  with tugConceptos do
  begin
    if Not EOF then
    begin
      Edit;
      FieldByName('bVisible').asInteger:= 0;
      Post;
    end;
  end;
end;

function TDM_CAJA.MontoConcepto(refConcepto: integer): double;
begin
  with qtugConceptoPorID do
  begin
    if active then close;
    ParamByName('idConcepto').asInteger:= refConcepto;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('MontoDefecto').asFloat
    else
      Result:= 0;
  end;
end;

procedure TDM_CAJA.CargarMontoConcepto(refConcepto: integer);
begin
  with tbCajaConceptos do
  begin
    Edit;
    FieldByName('nMonto').asFloat:= MontoConcepto (refConcepto);
    Post;
  end;
end;

procedure TDM_CAJA.InsertarConceptoCaja;
begin
  DM_General.ReiniciarTabla(tbCajaConceptos);
  tbCajaConceptos.Insert;
end;

procedure TDM_CAJA.GrabarConcepto;
begin
  DM_General.GrabarDatos(tbCajaConceptoSEL, tbCajaConceptoINS, tbCajaConceptoUPD, tbCajaConceptos, 'idCajaConcepto');
end;

procedure TDM_CAJA.AjustarDatosConcepto(refConcepto, refFormaPago: integer;
  tipoLista: string; refEmpresa: GUID_ID);
begin
  with tbCajaConceptos do
  begin
    Edit;
    FieldByName ('refConcepto').asInteger:= refConcepto;
    FieldByName ('refFormaPago').asInteger:= refFormaPago;
    FieldByName ('refListaEmpresa').asString:= tipoLista;
    FieldByName ('refEmpresa').asString:= refEmpresa;
    Post;
  end;
end;

procedure TDM_CAJA.ModificarConceptoCaja;
begin
  DM_General.ReiniciarTabla(tbCajaConceptos);
  with tbCajaConceptoSEL do
  begin
    if Active then close;
    ParamByName('idCajaConcepto').asString:= tbCaja.FieldByName('idCajaConcepto').asString;
    Open;
    tbCajaConceptos.LoadFromDataSet(tbCajaConceptoSEL, 0, lmAppend);
  end;
end;

procedure TDM_CAJA.EliminarConcepto;
begin
  with tbCajaConceptoDEL do
  begin
    ParamByName('idCajaConcepto').asString:= tbCaja.FieldByName('idCajaConcepto').asString;
    ExecSQL;
  end;
end;

end.

