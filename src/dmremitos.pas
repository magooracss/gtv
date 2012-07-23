unit dmremitos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  , db, StdCtrls;

type

  { TDM_Remitos }

  TDM_Remitos = class(TDataModule)
    qLevantarRemitoEquipos: TZQuery;
    qAsignarReclamo: TZQuery;
    qBorrarAsignacionReclamo: TZQuery;
    qLevantarRemitoTecnicos: TZQuery;
    qLevantarRemitoReclamo: TZQuery;
    qListaRemitos: TZQuery;
    qtugMotivosRemito: TZQuery;
    tbRemitos: TRxMemoryData;
    tbRemitosDEL: TZQuery;
    tbRemitosINS: TZQuery;
    tbRemitosSEL: TZQuery;
    tbRemitosUPD: TZQuery;
    trRemitoEquipos: TRxMemoryData;
    trRemitoTecnicos: TRxMemoryData;
    trRemitoEquiposDEL: TZQuery;
    trRemitoTecnicosDEL: TZQuery;
    trRemitoEquiposINS: TZQuery;
    trRemitoTecnicosINS: TZQuery;
    trRemitoEquiposSEL: TZQuery;
    trRemitoTecnicosSEL: TZQuery;
    trRemitoEquiposUPD: TZQuery;
    trRemitoTecnicosUPD: TZQuery;
    procedure tbRemitosAfterInsert(DataSet: TDataSet);
    procedure trRemitoEquiposAfterInsert(DataSet: TDataSet);
    procedure trRemitoTecnicosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    function idOrdenTrabajo: GUID_ID;
    function idReclamo: GUID_ID;
    procedure AsignarCliente (refCliente: GUID_ID);

    function idRemitoListado: GUID_ID;
    procedure LevantarRemitoCliente (refCliente: GUID_ID; SinCargo, facturados, presentados: boolean);
    procedure LevantarEquipos;

    procedure RemitoEliminar (refRemito: GUID_ID);
    procedure RemitoEditar (refRemito: GUID_ID);
    procedure RemitoNuevo (refCliente: GUID_ID);

    procedure VolcarCombos (var cbMotivos: TComboBox);
    procedure Grabar;

    procedure vincularEquipo (refEquipo: GUID_ID);
    procedure DesvincularEquipoActual;

    procedure AsignarOrdenTrabajo (refOrdenTrabajo: GUID_ID);
    procedure DesvincularOrdenTrabajo;

    procedure DesvincularTecnico;
    procedure VincularTecnico (refTecnico: integer; ApyNomTecnico: string);

    procedure AsignarReclamo (refReclamo: GUID_ID);
    procedure DesvincularReclamo (refReclamo: GUID_ID);

    procedure BuscarPorNroRemito (nRemito: integer);
  end; 

var
  DM_Remitos: TDM_Remitos;

implementation
{$R *.lfm}
uses
   dateutils
   ,dmEquipos
   ;

{ TDM_Remitos }

procedure TDM_Remitos.tbRemitosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idRemito').asString:= DM_General.CrearGUID;
    FieldByName('refCliente').asString:= GUIDNULO;
    FieldByName('nRemito').asInteger:= -1;
    FieldByName('fFecha').asDateTime:= DateOf(Now);
    FieldByName('refOrdenTrabajo').asString:= GUIDNULO;
    FieldByName('refMotivo').AsInteger:= 0;
    FieldByName('txDetalles').asString:= ' ';
    FieldByName('refFactura').asString:= GUIDNULO;
    FieldByName('bFacturar').asInteger:= 0;
    FieldByName('bFacturado').asInteger:= 0;
    FieldByName('bPresentado').asInteger:= 0;
    FieldByName('bSinCargo').asInteger:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;



procedure TDM_Remitos.trRemitoEquiposAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idRemitoEquipo').asString:= DM_General.CrearGUID;
    FieldByName('refRemito').AsString:= tbRemitos.FieldByName('idRemito').asString;
    FieldByName('refEquipo').AsString:= GUIDNULO;
  end;
end;

procedure TDM_Remitos.trRemitoTecnicosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idRemitoTecnico').asString:= DM_General.CrearGUID;
    FieldByName('refRemito').AsString:= tbRemitos.FieldByName('idRemito').asString;
    FieldByName('refTecnico').AsInteger:= 0;
  end;
end;

function TDM_Remitos.idOrdenTrabajo: GUID_ID;
begin
    if ((tbRemitos.Active) and (NOT tbRemitos.EOF)) then
      Result:= tbRemitos.FieldByName('refOrdenTrabajo').AsString
    else
      Result:= GUIDNULO;
end;

function TDM_Remitos.idReclamo: GUID_ID;
begin
  with qLevantarRemitoReclamo do
  begin
    if active then close;
    ParamByName('refRemito').AsString:= tbRemitos.FieldByName('idRemito').asString;
    Open;

    if (RecordCount > 0 ) then
      Result:= FieldByName('refReclamo').asString
    else
      Result:= GUIDNULO;
  end;
end;

procedure TDM_Remitos.AsignarCliente(refCliente: GUID_ID);
begin
  with tbRemitos do
  begin
    Edit;
    FieldByName('refCliente').AsString:= refCliente;
    Post;
  end;
end;

function TDM_Remitos.idRemitoListado: GUID_ID;
begin
  if ((qListaRemitos.Active ) AND (qListaRemitos.RecordCount > 0)) then
    Result := qListaRemitos.FieldByName('idRemito').asString
  else
    Result := GUIDNULO;
end;

procedure TDM_Remitos.LevantarRemitoCliente(refCliente: GUID_ID; SinCargo,
  facturados, presentados: boolean);
begin
  with qListaRemitos do
  begin
    if active then close;

    SQL.Clear;
    SQL.Add(' SELECT Re.idRemito, Re.refCliente, Re.nRemito, Re.fFecha, Re.bSinCargo, RE.bFacturado, RE.bPresentado,Re.bVisible');
    SQL.Add(' ,C.cNombre, C.cCodigo');
    SQL.Add(' FROM tbRemitos Re');
    SQL.Add('       LEFT JOIN tbClientes C ON Re.refCliente = C.idCliente ');
    SQL.Add('WHERE (Re.bVisible = 1) ');

    if refCliente <> GUIDNULO then
     SQL.Add(' AND (RE.refCliente =  ''' + refCliente + ''')');

    if SinCargo then
      SQL.Add(' AND (Re.bSinCargo = 1)')
    else
      SQL.Add(' AND (Re.bSinCargo <> 1)');

    if facturados then
      SQL.Add(' AND (Re.bFacturado = 1)')
    else
      SQL.Add(' AND (Re.bFacturado <> 1)');

    if presentados then
      SQL.Add(' AND (Re.bPresentado = 1)')
    else
      SQL.Add(' AND (Re.bPresentado <> 1)');

    Open;
  end;
end;

procedure TDM_Remitos.LevantarEquipos;
begin
  DM_General.ReiniciarTabla(trRemitoEquipos);
  with qLevantarRemitoEquipos do
  begin
    if Active then close;
    ParamByName('refRemito').asString:= tbRemitos.FieldByName('idRemito').asString;
    Open;
    trRemitoEquipos.LoadFromDataSet(qLevantarRemitoEquipos, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Remitos.RemitoEliminar(refRemito: GUID_ID);
begin
  with tbRemitosDEL do
  begin
    ParamByName('idRemito').asString:= refRemito;
    ExecSQL;
  end;
end;

procedure TDM_Remitos.RemitoEditar(refRemito: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbRemitos);
  DM_General.ReiniciarTabla(trRemitoEquipos);
  DM_General.ReiniciarTabla(trRemitoTecnicos);

  with tbRemitosSEL do
  begin
    if Active then close;
    ParamByName('idRemito').asString:= refRemito;
    Open;
    tbRemitos.LoadFromDataSet(tbRemitosSEL, 0, lmAppend);
    Close;
  end;

 with qLevantarRemitoEquipos do
 begin
   if Active then close;
   ParamByName('refRemito').asString:= refRemito;
   Open;
   trRemitoEquipos.LoadFromDataSet(qLevantarRemitoEquipos, 0, lmAppend);
   Close;
 end;

 with qLevantarRemitoTecnicos do
 begin
   if Active then close;
   ParamByName('refRemito').asString:= refRemito;
   Open;
   trRemitoTecnicos.LoadFromDataSet(qLevantarRemitoTecnicos, 0, lmAppend);
   Close;
 end;
end;

procedure TDM_Remitos.RemitoNuevo(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbRemitos);
  DM_General.ReiniciarTabla(trRemitoEquipos);
  DM_General.ReiniciarTabla(trRemitoTecnicos);

  tbRemitos.Insert;
  tbRemitos.FieldByName('refCliente').asString:= refCliente;
end;

procedure TDM_Remitos.VolcarCombos(var cbMotivos: TComboBox);
begin
  with tbRemitos do
  begin
    Edit;
    FieldByName('refMotivo').asInteger:= DM_General.obtenerIDIntComboBox(cbMotivos);
    Post;
  end;
end;

procedure TDM_Remitos.Grabar;
begin
  DM_General.GrabarDatos(tbRemitosSEL, tbRemitosINS, tbRemitosUPD, tbRemitos, 'idRemito');
  DM_General.GrabarDatos(trRemitoEquiposSEL, trRemitoEquiposINS, trRemitoEquiposUPD, trRemitoEquipos, 'idRemitoEquipo');
  DM_General.GrabarDatos(trRemitoTecnicosSEL, trRemitoTecnicosINS, trRemitoTecnicosUPD, trRemitoTecnicos, 'idRemitoTecnico');
end;

procedure TDM_Remitos.vincularEquipo(refEquipo: GUID_ID);
begin
  DM_Equipos.CargarDatosEquipo(refEquipo);

  with trRemitoEquipos do
  begin
    Insert;
    FieldByName('refEquipo').asString:= refEquipo;
    FieldByName('lxNombre').asString:= DM_Equipos.tbEquipos.FieldByName ('Nombre').asString;
    FieldByName('lxTipoEquipo').asString:= DM_Equipos.tbEquipos.FieldByName ('lxTipoEquipo').asString;
    FieldByName('lxNro').asInteger:= DM_Equipos.tbEquipos.FieldByName ('nNroEquipo').asInteger;
    Post;
  end;
end;

procedure TDM_Remitos.DesvincularEquipoActual;
begin
  with trRemitoEquiposDEL do
  begin
    ParamByName ('idRemitoEquipo').asString:= trRemitoEquipos.FieldByName('idRemitoEquipo').asString;
    ExecSQL;
    trRemitoEquipos.Delete;
  end;
end;

procedure TDM_Remitos.AsignarOrdenTrabajo(refOrdenTrabajo: GUID_ID);
begin
  with tbRemitos do
  begin
    Edit;
    FieldByName('refOrdenTrabajo').AsString:= refOrdenTrabajo;
    Post;
  end;
end;

procedure TDM_Remitos.DesvincularOrdenTrabajo;
begin
  with tbRemitos do
  begin
    Edit;
    FieldByName('refOrdenTrabajo').asString:= GUIDNULO;
    Post;
  end;
end;

procedure TDM_Remitos.DesvincularTecnico;
begin
  with trRemitoTecnicosDEL do
  begin
    ParamByName('idRemitoTecnico').AsString:= trRemitoTecnicos.FieldByName('idRemitoTecnico').asString;
    ExecSQL;
    trRemitoTecnicos.Delete;
  end;
end;

procedure TDM_Remitos.VincularTecnico(refTecnico: integer; ApyNomTecnico: string
  );
begin
  with trRemitoTecnicos do
  begin
    Insert;
    FieldByName('refTecnico').asInteger:= refTecnico;
    FieldByName('lxNombreTecnico').asString:= ApyNomTecnico;
    Post;
  end;
end;

procedure TDM_Remitos.AsignarReclamo(refReclamo: GUID_ID);
begin
  with qBorrarAsignacionReclamo do
  begin
    ParamByName ('refRemito').asString:= tbRemitos.FieldByName('idRemito').asString;
    ExecSQL;
  end;

  with qAsignarReclamo do
  begin
    ParamByName ('idReclamoRemito').asString:= DM_General.CrearGUID;
    ParamByName ('refReclamo').asString:= refReclamo;
    ParamByName ('refRemito').asString:= tbRemitos.FieldByName('idRemito').asString;
    ExecSQL;
  end;
end;

procedure TDM_Remitos.DesvincularReclamo(refReclamo: GUID_ID);
begin
  with qBorrarAsignacionReclamo do
  begin
    ParamByName ('refRemito').asString:= tbRemitos.FieldByName('idRemito').asString;
    ExecSQL;
  end;

end;

procedure TDM_Remitos.BuscarPorNroRemito(nRemito: integer);
begin
  with qListaRemitos do
  begin
    if active then close;

    SQL.Clear;
    SQL.Add(' SELECT Re.idRemito, Re.refCliente, Re.nRemito, Re.fFecha, Re.bSinCargo, RE.bFacturado, RE.bPresentado,Re.bVisible');
    SQL.Add(' ,C.cNombre');
    SQL.Add(' FROM tbRemitos Re');
    SQL.Add('       LEFT JOIN tbClientes C ON Re.refCliente = C.idCliente ');
    SQL.Add('WHERE (Re.bVisible = 1) ');
    SQL.Add(' AND (RE.nRemito =  ' + InttoStr(nRemito) + ')');

    Open;
  end;
end;


end.

