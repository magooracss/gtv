unit dmpresupuestos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmConexion, dmgeneral, db;

const
   _TODOS_LOS_ESTADOS_ = -1;

type

  { TDM_Presupuestos }

  TDM_Presupuestos = class(TDataModule)
    qtugTiposCuotas: TZQuery;
    qtugEstadosCuota: TZQuery;
    qtugPresupuestosEstados: TZQuery;
    qtugEmpleados: TZQuery;
    tbCuotasPresupuesto: TRxMemoryData;
    tbCuotasPresupuestobVisible: TLongintField;
    tbCuotasPresupuestofPago: TDateTimeField;
    tbCuotasPresupuestofVencimiento: TDateTimeField;
    tbCuotasPresupuestoidCuotaPresupuesto: TStringField;
    tbCuotasPresupuestolxEstado: TStringField;
    tbCuotasPresupuestolxTipo: TStringField;
    tbCuotasPresupuestonMonto: TFloatField;
    tbCuotasPresupuestonNroCuota: TLongintField;
    tbCuotasPresupuestorefEstado: TLongintField;
    tbCuotasPresupuestorefPresupuesto: TStringField;
    tbCuotasPresupuestorefTipo: TLongintField;
    tbPresupuestosbAceptado: TLongintField;
    tbPresupuestosbVisible: TLongintField;
    tbPresupuestoscRecepciono: TStringField;
    tbPresupuestosDEL: TZQuery;
    tbCuotasPresupuestoDEL: TZQuery;
    tbPresupuestosfCambioEstado: TDateTimeField;
    tbPresupuestosfEmision: TDateTimeField;
    tbPresupuestosidPresupuesto: TStringField;
    tbPresupuestosINS: TZQuery;
    tbCuotasPresupuestoINS: TZQuery;
    tbPresupuestosnNtoCuota: TLongintField;
    tbPresupuestosnPresupuesto: TLongintField;
    tbPresupuestosrefCliente: TStringField;
    tbPresupuestosrefEmpleado: TLongintField;
    tbPresupuestosrefEstado: TLongintField;
    tbPresupuestosSEL: TZQuery;
    qLevantarCuotasPresupuesto: TZQuery;
    tbCuotasPresupuestoSEL: TZQuery;
    tbPresupuestostxMotivo: TStringField;
    tbPresupuestostxObservaciones: TStringField;
    tbPresupuestosUPD: TZQuery;
    tbPresupuestos: TRxMemoryData;
    qLevantarPresupuestos: TZQuery;
    tbCuotasPresupuestoUPD: TZQuery;
    procedure tbCuotasPresupuestoAfterInsert(DataSet: TDataSet);
    procedure tbPresupuestosAfterInsert(DataSet: TDataSet);
  private
    function cuotaTipo (refTipo: integer): string;
    function cuotaEstado (refEstado: integer): string;
    function getMontoTotal: double;
  public
    property MontoTotal: double read getMontoTotal;

    procedure LevantarPresupuestos (refCliente: GUID_ID; refEstado: integer);
    function idPresupuestoListadoActual: GUID_ID;
    function NroPresupuesto (refPresupuesto: GUID_ID): integer;

    procedure EliminarPresupuesto (refPresupuesto: GUID_ID);

    procedure PresupuestoNuevo (refCliente: GUID_ID);
    procedure PresupuestoEditar (refPresupuesto: GUID_ID);
    procedure ActualizarValores (refCliente: GUID_ID; refEmpleado, refEstado: integer);


    procedure AltaCuota (elNro, refTipo: integer; elVencimiento: TDateTime
                        ; elMonto: Double; refEstado: integer; fPago: TDateTime);
    procedure EditarCuota( refTipo: integer; elVencimiento: TDateTime
                        ; elMonto: Double; refEstado: integer; fPago: TDateTime);
    procedure EliminarCuota;
    procedure OrdenarCuotas;
    procedure RenumerarCuotas;



    procedure Grabar;
  end; 

var
  DM_Presupuestos: TDM_Presupuestos;

implementation
{$R *.lfm}
{ TDM_Presupuestos }

procedure TDM_Presupuestos.tbPresupuestosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('IDPRESUPUESTO').asString:= DM_General.CrearGUID;
    FieldByName('NPRESUPUESTO').asInteger:= -1;
    FieldByName('FEMISION').asDateTime:= Now;
    FieldByName('REFCLIENTE').asString:= GUIDNULO;
    FieldByName('REFEMPLEADO').asInteger:= 0;
    FieldByName('REFESTADO').asInteger:= 0;
    FieldByName('FCAMBIOESTADO').asDateTime:= Now;
    FieldByName('TXMOTIVO').asString:= '';
    FieldByName('TXOBSERVACIONES').asString:= '';
    FieldByName('BACEPTADO').asInteger:= 0;
    FieldByName('BVISIBLE').asInteger:= 1;
  end;
end;

function TDM_Presupuestos.cuotaTipo(refTipo: integer): string;
begin
  with qtugTiposCuotas do
  begin
    if active then close;
    open;
    if Locate('idTipoCuota', refTipo, []) then
      Result:= FieldByName('TipoCuota').asString
    else
      Result:= ' ';
  end;
end;

function TDM_Presupuestos.cuotaEstado(refEstado: integer): string;
begin
  with qtugEstadosCuota do
  begin
    if active then close;
    open;
    if Locate('idEstadoCuota', refEstado, []) then
      Result:= FieldByName('EstadoCuota').asString
    else
      Result:= ' ';
  end;
end;

function TDM_Presupuestos.getMontoTotal: double;
var
  monto: double;
begin
  monto:= 0;
  with tbCuotasPresupuesto do
  begin
    First;
    While Not EOF do
    begin
      monto:= monto + FieldByName('nMonto').asFloat;
      Next;
    end;
  end;
  Result:= monto;
end;

procedure TDM_Presupuestos.tbCuotasPresupuestoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCuotaPresupuesto').AsString:= DM_General.CrearGUID;
    FieldByName('refPresupuesto').AsString:= tbPresupuestos.FieldByName('idPresupuesto').asString;
    FieldByName('nNroCuota').asInteger:= 0;
    FieldByName('refTipo').AsInteger:= 0;
    FieldByName('fVencimiento').asDateTime:= now;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('refEstado').asInteger:= 0;
    FieldByName('lxTipo').asString:= EmptyStr;
    FieldByName('lxEstado').asString:= EmptyStr;
    FieldByName('bVisible').AsInteger:= 1;

  end;
end;

procedure TDM_Presupuestos.LevantarPresupuestos(refCliente: GUID_ID;
  refEstado: integer);
begin
  with qLevantarPresupuestos do
  begin
    if active then close;

    SQL.Clear;
    SQL.Add(' SELECT P.idPresupuesto, P.nPresupuesto, P.fEmision, P.refCliente, P.refEstado ');
    SQL.Add(' , E.Estado');
    SQL.Add(' , CASE ');
    SQL.Add('      WHEN C.idCliente is null then CP.cRazonSocial');
    SQL.Add('   ELSE C.cNombre');
    SQL.Add('   end as cNombre');

    SQL.Add(' FROM tbPresupuestos P ');
    SQL.Add('       LEFT JOIN tbClientes C ON P.refCliente = C.idCliente ');
    SQL.Add('       LEFT JOIN tugPresupuestosEstados E ON E.idPresupuestoEstado = P.refEstado ');
    SQL.Add('       LEFT JOIN tbClientesPotenciales CP ON P.refCliente = CP.idClientePotencial');

    SQL.Add('WHERE (P.bVisible = 1) ');

    if refCliente <> GUIDNULO then
     SQL.Add(' AND (P.refCliente =  ''' + refCliente + ''')');

    if refEstado <> _TODOS_LOS_ESTADOS_ then
      SQL.Add(' AND (P.refEstado = ' + IntToStr(refEstado) + ')');

    Open;
    SortedFields := 'nPresupuesto';
  end;

end;

function TDM_Presupuestos.idPresupuestoListadoActual: GUID_ID;
begin
  if ((qLevantarPresupuestos.Active) and (NOT qLevantarPresupuestos.EOF)) then
    Result:= qLevantarPresupuestos.FieldByName('idPresupuesto').AsString
  else
    Result:= GUIDNULO;
end;

function TDM_Presupuestos.NroPresupuesto(refPresupuesto: GUID_ID): integer;
begin
  With tbPresupuestosSEL do
  begin
    if Active then close;
    ParamByName('idPresupuesto').asString:= refPresupuesto;
    open;

    if RecordCount > 0 then
      Result:= FieldByName('nPresupuesto').asInteger
    else
      Result:= 0;
  end;
end;

procedure TDM_Presupuestos.EliminarPresupuesto(refPresupuesto: GUID_ID);
begin
  with tbPresupuestosDEL do
  begin
    ParamByName('idPresupuesto').AsString:= refPresupuesto;
    ExecSQL;
  end;
end;

procedure TDM_Presupuestos.PresupuestoNuevo(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbPresupuestos);
  DM_General.ReiniciarTabla(tbCuotasPresupuesto);

  tbPresupuestos.Insert;
  tbPresupuestos.FieldByName('refCliente').asString:= refCliente ;
end;

procedure TDM_Presupuestos.PresupuestoEditar(refPresupuesto: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbPresupuestos);
  DM_General.ReiniciarTabla(tbCuotasPresupuesto);

  with tbPresupuestosSEL do
  begin
    if active then close;
    ParamByName('idPresupuesto').asString:= refPresupuesto;
    Open;
    tbPresupuestos.LoadFromDataSet(tbPresupuestosSEL,0,lmAppend);
    Close;
  end;

  with qLevantarCuotasPresupuesto do
  begin
    if active then close;
    ParamByName('idPresupuesto').asString:= refPresupuesto;
    Open;
    tbCuotasPresupuesto.LoadFromDataSet(qLevantarCuotasPresupuesto,0,lmAppend);
    Close;
  end;

   tbPresupuestos.Edit;
   tbCuotasPresupuesto.Edit;

end;

procedure TDM_Presupuestos.ActualizarValores(refCliente: GUID_ID; refEmpleado,
  refEstado: integer);
begin
  with tbPresupuestos do
  begin
    Edit;
    FieldByName('refcliente').asString:= refCliente;
    FieldByName('refEmpleado').asInteger:= refEmpleado;
    FieldByName('refEstado').asInteger:= refEstado;
    Post;
  end;
end;

procedure TDM_Presupuestos.AltaCuota(elNro, refTipo: integer;
  elVencimiento: TDateTime; elMonto: Double; refEstado: integer
  ;fPago: TDateTime);
begin
  with tbCuotasPresupuesto do
  begin
    Insert;
    FieldByName('nNroCuota').asInteger:= elNro;
    FieldByName('refTipo').asInteger:= refTipo;
    FieldByName('fVencimiento').AsDateTime:= elVencimiento;
    FieldByName('nMonto').AsFloat:= elMonto;
    FieldByName('refEstado').asInteger:= refEstado;
    FieldByName('fPago').AsDateTime:= fPago;
    FieldByName('lxTipo').asString:= CuotaTipo (refTipo);
    FieldByName('lxEstado').asString:= CuotaEstado (refEstado);
    Post;
  end;
end;

procedure TDM_Presupuestos.EditarCuota(refTipo: integer;
  elVencimiento: TDateTime; elMonto: Double; refEstado: integer;
  fPago: TDateTime);
begin
   with tbCuotasPresupuesto do
  begin
    Edit;
    FieldByName('refTipo').asInteger:= refTipo;
    FieldByName('fVencimiento').AsDateTime:= elVencimiento;
    FieldByName('nMonto').AsFloat:= elMonto;
    FieldByName('refEstado').asInteger:= refEstado;
    FieldByName('fPago').AsDateTime:= fPago;
    FieldByName('lxTipo').asString:= CuotaTipo (refTipo);
    FieldByName('lxEstado').asString:= CuotaEstado (refEstado);
    Post;
  end;
end;

procedure TDM_Presupuestos.EliminarCuota;
begin
  if (tbCuotasPresupuesto.Active) and (tbCuotasPresupuesto.RecordCount > 0) then
  begin
   with tbCuotasPresupuestoDEL do
   begin
     ParamByName('idCuotaPresupuesto').asString:= tbCuotasPresupuesto.FieldByName('idCuotaPresupuesto').asString;
     ExecSQL;
   end;
   tbCuotasPresupuesto.Delete;
  end;
end;

procedure TDM_Presupuestos.OrdenarCuotas;
begin
  if tbCuotasPresupuesto.RecordCount > 1 then
    tbCuotasPresupuesto.SortOnFields('fVencimiento; nNroCuota');
end;

procedure TDM_Presupuestos.RenumerarCuotas;
var
  nro: integer;
begin
  with tbCuotasPresupuesto do
  begin
    nro:= 1;
    SortOnFields('fVencimiento');
    First;
    While Not EOF do
    begin
      Edit;
      FieldByName('nNroCuota').asInteger:= nro;
      Inc (nro);
      Post;
      Next;
    end;
  end;
end;

procedure TDM_Presupuestos.Grabar;
begin
  DM_General.GrabarDatos(tbPresupuestosSEL,tbPresupuestosINS,tbPresupuestosUPD, tbPresupuestos, 'idPresupuesto');
  DM_General.GrabarDatos(tbCuotasPresupuestoSEL, tbCuotasPresupuestoINS, tbCuotasPresupuestoUPD
                         , tbCuotasPresupuesto, 'idCuotaPresupuesto');
end;

end.


