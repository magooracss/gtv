unit dmordenestrabajo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral, dmConexion, db;

type

  { TDM_OrdenesTrabajo }

  TDM_OrdenesTrabajo = class(TDataModule)
    qLevantarRemitosOT: TZQuery;
    qListaOrdenesTrabajo: TZQuery;
    tbOrdenesTrabajo: TRxMemoryData;
    trOTEquiposDEL: TZQuery;
    trOTRemitosDEL: TZQuery;
    trOTEquiposINS: TZQuery;
    trOTRemitosINS: TZQuery;
    trOTEquiposSEL: TZQuery;
    qLevantarEquiposOT: TZQuery;
    trOTRemitosSEL: TZQuery;
    trOTEquiposUPD: TZQuery;
    trOrdenesTrabajoEquipos: TRxMemoryData;
    tbOrdenesTrabajoDEL: TZQuery;
    tbOrdenesTrabajoINS: TZQuery;
    tbOrdenesTrabajoSEL: TZQuery;
    tbOrdenesTrabajoUPD: TZQuery;
    trOrdenesTrabajoRemitos: TRxMemoryData;
    trOTRemitosUPD: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbOrdenesTrabajoAfterInsert(DataSet: TDataSet);
    procedure trOrdenesTrabajoEquiposAfterInsert(DataSet: TDataSet);
    procedure trOrdenesTrabajoRemitosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarOTCliente (idCliente: GUID_ID; cumplidas: boolean);
    function idOrdenTrabajoListado: GUID_ID;
    function idOrdenTrabajo: GUID_ID;

    procedure OrdenTrabajoNueva (refCliente: GUID_ID);
    procedure OrdenTrabajoEditar (refOrdenTrabajo: GUID_ID);
    procedure OrdenTrabajoEliminar (refOrdenTrabajo: GUID_ID);
    procedure OrdenTrabajoCambiarCliente (refCliente: GUID_ID);

    procedure VincularEquipo (refEquipo: GUID_ID);
    procedure DesvincularEquipoActual;

    procedure VincularPresupuesto (refPresupuesto: GUID_ID);

    procedure LevantarRemitosOT;

    procedure Grabar;

    procedure AsignarRemito (refRemito: GUID_ID);
    procedure QuitarRemito;

    function ListaEquipos: string;
  end; 

var
  DM_OrdenesTrabajo: TDM_OrdenesTrabajo;

implementation
{$R *.lfm}
uses
   dmEquipos
   ,dmpresupuestos
   ;

{ TDM_OrdenesTrabajo }

procedure TDM_OrdenesTrabajo.tbOrdenesTrabajoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('IDORDENTRABAJO').asString:= DM_General.CrearGUID;
    FieldByName('REFCLIENTE').asString:= GUIDNULO;
    FieldByName('NNRO').asInteger:= -1;
    FieldByName('TXTAREAS').asString:= '';
    FieldByName('BCUMPLIDA').AsInteger:= 0;
    FieldByName('FCUMPLIDA').asDateTime:= 0;
    FieldByName('BANULADA').asInteger:= 0;
    FieldByName('FANULADA').asDateTime:= 0;
    FieldByName('DETALLEANULADA').asString:= '';
    FieldByName('BVISIBLE').asInteger:= 1;
    FieldByName('refPresupuesto').asString:= GUIDNULO;
    FieldByName('FALTA').asDateTime:= Now;
    FieldByName('lxNroPresupuesto').asInteger:= 0;
  end;
end;

procedure TDM_OrdenesTrabajo.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM_OrdenesTrabajo.trOrdenesTrabajoEquiposAfterInsert(
  DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('IDORDENTRABAJOEQUIPO').asString:= DM_General.CrearGUID;
    FieldByName('REFORDENTRABAJO').asString:= tbOrdenesTrabajo.FieldByName('idOrdenTrabajo').asString;
    FieldByName('REFEQUIPO').asString:= GUIDNULO;
  end;
end;

procedure TDM_OrdenesTrabajo.trOrdenesTrabajoRemitosAfterInsert(
  DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('IDORDENTRABAJOREMITO').asString:= DM_General.CrearGUID;
    FieldByName('REFORDENTRABAJO').asString:= tbOrdenesTrabajo.FieldByName('idOrdenTrabajo').asString;
    FieldByName('REFREMITO').asString:= GUIDNULO;
  end;
end;

procedure TDM_OrdenesTrabajo.LevantarOTCliente(idCliente: GUID_ID;
  cumplidas: boolean);
begin
  with qListaOrdenesTrabajo do
  begin
    if active then close;

    SQL.Clear;
    SQL.Add(' SELECT OT.idOrdenTrabajo, OT.refCliente, OT.nNro, OT.txTareas, OT.bCumplida, OT.fCumplida, OT.bAnulada, OT.fAnulada, OT.fAlta');
    SQL.Add(' ,C.cNombre, C.cCodigo');
    SQL.Add(' FROM tbOrdenesTrabajo OT');
    SQL.Add('       LEFT JOIN tbClientes C ON OT.refCliente = C.idCliente ');
    SQL.Add('WHERE (OT.bVisible = 1) ');

    if idCliente <> GUIDNULO then
     SQL.Add(' AND (OT.refCliente =  ''' + idCliente + ''')');

    if cumplidas then
      SQL.Add(' AND (OT.bCumplida = 1)')
    else
      SQL.Add(' AND (OT.bCumplida <> 1)');

    Open;
  end;
end;

function TDM_OrdenesTrabajo.idOrdenTrabajoListado: GUID_ID;
begin
  if ((qListaOrdenesTrabajo.Active ) AND (qListaOrdenesTrabajo.RecordCount > 0)) then
    Result := qListaOrdenesTrabajo.FieldByName('idOrdenTrabajo').asString
  else
    Result := GUIDNULO;
end;

function TDM_OrdenesTrabajo.idOrdenTrabajo: GUID_ID;
begin
  Result:= tbOrdenesTrabajo.FieldByName('idOrdenTrabajo').AsString;
end;

procedure TDM_OrdenesTrabajo.OrdenTrabajoNueva(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbOrdenesTrabajo);
  DM_General.ReiniciarTabla(trOrdenesTrabajoEquipos);
  DM_General.ReiniciarTabla(trOrdenesTrabajoRemitos);

  tbOrdenesTrabajo.Insert;
  tbOrdenesTrabajo.FieldByName('refCliente').asString:= refCliente;
end;

procedure TDM_OrdenesTrabajo.OrdenTrabajoEditar(refOrdenTrabajo: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbOrdenesTrabajo);
  DM_General.ReiniciarTabla(trOrdenesTrabajoEquipos);
  DM_General.ReiniciarTabla(trOrdenesTrabajoRemitos);

  with tbOrdenesTrabajoSEL do
  begin
    if Active then close;
    ParamByName('idOrdenTrabajo').asString:= refOrdenTrabajo;
    Open;
    tbOrdenesTrabajo.LoadFromDataSet(tbOrdenesTrabajoSEL, 0, lmAppend);
    Close;
  end;

 with qLevantarEquiposOT do
 begin
   if Active then close;
   ParamByName('refOrdenTrabajo').asString:= refOrdenTrabajo;
   Open;
   trOrdenesTrabajoEquipos.LoadFromDataSet(qLevantarEquiposOT, 0, lmAppend);
   Close;
 end;

 with qLevantarRemitosOT do
 begin
   if Active then close;
   ParamByName('refOrdenTrabajo').asString:= refOrdenTrabajo;
   Open;
   trOrdenesTrabajoRemitos.LoadFromDataSet(qLevantarRemitosOT, 0, lmAppend);
   Close;
 end;
end;

procedure TDM_OrdenesTrabajo.OrdenTrabajoEliminar(refOrdenTrabajo: GUID_ID);
begin
  with tbOrdenesTrabajoDEL do
  begin
    ParamByName('idOrdenTrabajo').AsString:= refOrdenTrabajo;
    ExecSQL;
  end;
end;

procedure TDM_OrdenesTrabajo.OrdenTrabajoCambiarCliente(refCliente: GUID_ID);
begin
  with tbOrdenesTrabajo do
  begin
    Edit;
    FieldByName('refCliente').asString:= refCliente;
    Post;
  end;
end;

procedure TDM_OrdenesTrabajo.VincularEquipo(refEquipo: GUID_ID);
begin
  DM_Equipos.CargarDatosEquipo(refEquipo);

  with trOrdenesTrabajoEquipos do
  begin
    Insert;
    FieldByName('refEquipo').asString:= refEquipo;
    FieldByName('lxNombre').asString:= DM_Equipos.tbEquipos.FieldByName ('Nombre').asString;
    FieldByName('lxTipoEquipo').asString:= DM_Equipos.tbEquipos.FieldByName ('lxTipoEquipo').asString;;
    Post;
  end;
end;

procedure TDM_OrdenesTrabajo.DesvincularEquipoActual;
begin
  with trOTEquiposDEL do
  begin
    ParamByName ('IDORDENTRABAJOEQUIPO').asString:= trOrdenesTrabajoEquipos.FieldByName('idOrdenTrabajoEquipo').asString;
    ExecSQL;
    trOrdenesTrabajoEquipos.Delete;
  end;
end;

procedure TDM_OrdenesTrabajo.VincularPresupuesto(refPresupuesto: GUID_ID);
begin
   with tbOrdenesTrabajo do
   begin
     Edit;
     FieldByName('refPresupuesto').asString:= refPresupuesto;
     FieldByName('lxNroPresupuesto').asInteger:= DM_Presupuestos.NroPresupuesto(refPresupuesto);
     Post;
   end;
end;

procedure TDM_OrdenesTrabajo.LevantarRemitosOT;
begin
  DM_General.ReiniciarTabla(trOrdenesTrabajoRemitos);
  with qLevantarRemitosOT do
  begin
    if Active then close;
    ParamByName('refOrdenTrabajo').asString:= tbOrdenesTrabajo.FieldByName('idOrdenTrabajo').asString;
    Open;
    trOrdenesTrabajoRemitos.LoadFromDataSet(qLevantarRemitosOT, 0, lmAppend);
  end;
end;

procedure TDM_OrdenesTrabajo.Grabar;
begin
  DM_General.GrabarDatos(tbOrdenesTrabajoSEL, tbOrdenesTrabajoINS, tbOrdenesTrabajoUPD, tbOrdenesTrabajo, 'idOrdenTrabajo');
  DM_General.GrabarDatos(trOTEquiposSEL, trOTEquiposINS, trOTEquiposUPD, trOrdenesTrabajoEquipos, 'idOrdenTrabajoEquipo');
  DM_General.GrabarDatos(trOTRemitosSEL, trOTRemitosINS, trOTRemitosUPD, trOrdenesTrabajoRemitos, 'idOrdenTrabajoRemito');
end;

procedure TDM_OrdenesTrabajo.AsignarRemito(refRemito: GUID_ID);
begin
  with trOrdenesTrabajoRemitos do
  begin
    Insert;
    FieldByName('refRemito').asString:= refRemito;
    Post;
  end;
  DM_General.GrabarDatos(trOTRemitosSEL, trOTRemitosINS, trOTRemitosUPD, trOrdenesTrabajoRemitos, 'idOrdenTrabajoRemito');

  DM_General.ReiniciarTabla(trOrdenesTrabajoRemitos);
 with qLevantarRemitosOT do
 begin
   if Active then close;
   ParamByName('refOrdenTrabajo').asString:= tbOrdenesTrabajo.FieldByName('idOrdenTrabajo').asString;
   Open;
   trOrdenesTrabajoRemitos.LoadFromDataSet(qLevantarRemitosOT, 0, lmAppend);
   Close;
 end;
end;

procedure TDM_OrdenesTrabajo.QuitarRemito;
begin
  with trOTRemitosDEL do
  begin
    ParamByName('idOrdenTrabajoRemito').asString:= trOrdenesTrabajoRemitos.FieldByName('idOrdenTrabajoRemito').asString;
    ExecSQL;
    trOrdenesTrabajoRemitos.Delete;
  end;
end;

function TDM_OrdenesTrabajo.ListaEquipos: string;
var
  tempo: string;
begin
  tempo:= EmptyStr;
  with trOrdenesTrabajoEquipos do
  begin
    First;
    While not EOF do
    begin
      tempo:= tempo + '[ ' +TRIM(FieldByName('lxNombre').asString) + ' (' + TRIM(FieldByName('lxTipoEquipo').asString) + ')] ';
      Next;
    end;
  end;
  Result:= tempo;
end;

end.

