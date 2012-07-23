unit dmreclamos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  , db, StdCtrls;

type

  { Tdm_reclamos }

  Tdm_reclamos = class(TDataModule)
    qAsignarRemito: TZQuery;
    qBorrarAsignacionReclamo: TZQuery;
    qLevantarReclamosEquipos: TZQuery;
    qLevantarReclamosEquipos1: TZQuery;
    qLevantarReclamoTecnicos: TZQuery;
    qLevantarReclamoRemito: TZQuery;
    qListaReclamos: TZQuery;
    qtugTecnicos: TZQuery;
    qtugMediosReclamo: TZQuery;
    tbReclamos: TRxMemoryData;
    tbReclamosbAtendido: TLongintField;
    tbReclamosbVisible: TLongintField;
    tbReclamoscSolicitante: TStringField;
    tbReclamosfAtendido: TDateTimeField;
    tbReclamosfFecha: TDateTimeField;
    tbReclamosfHora1: TDateTimeField;
    tbReclamosidReclamo: TStringField;
    tbReclamosnNro: TLongintField;
    tbReclamosrefCliente: TStringField;
    tbReclamosrefMedio: TLongintField;
    tbReclamosrefOrdenTrabajo: TStringField;
    tbReclamosrefTecnicoAtendio: TLongintField;
    tbReclamostxDetalles: TStringField;
    tbReclamostxInformeTecnico: TStringField;
    tbReclamostxObservaciones: TStringField;
    trReclamoRemitoidReclamoRemito: TStringField;
    trReclamoRemitonRemito: TLongintField;
    trReclamoRemitorefReclamo: TStringField;
    trReclamoRemitorefRemito: TStringField;
    trReclamosEquipos: TRxMemoryData;
    trReclamoRemito: TRxMemoryData;
    trReclamosEquiposDEL: TZQuery;
    tbReclamosDEL: TZQuery;
    trReclamoRemitoDEL: TZQuery;
    trReclamosEquiposINS: TZQuery;
    tbReclamosINS: TZQuery;
    trReclamoRemitoINS: TZQuery;
    trReclamosEquiposSEL: TZQuery;
    tbReclamosSEL: TZQuery;
    trReclamoRemitoSEL: TZQuery;
    trReclamosEquiposUPD: TZQuery;
    tbReclamosUPD: TZQuery;
    trReclamoRemitoUPD: TZQuery;
    trReclamoTecnicos: TRxMemoryData;
    trReclamoTecnicosDEL: TZQuery;
    trReclamoTecnicosINS: TZQuery;
    trReclamoTecnicosSEL: TZQuery;
    trReclamoTecnicosUPD: TZQuery;
    procedure tbReclamosAfterInsert(DataSet: TDataSet);
    procedure trReclamosEquiposAfterInsert(DataSet: TDataSet);
    procedure trReclamoTecnicosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarReclamosCliente (idCliente: GUID_ID; atendidos: boolean);
    procedure ReclamoNuevo (refCliente: GUID_ID);
    procedure AsignarCliente (refCliente: GUID_ID);

    procedure AsignarOrdenTrabajo (refOrdenTrabajo: GUID_ID);
    procedure DesvincularOrdenTrabajo;

    procedure VincularEquipo (refEquipo: GUID_ID);
    procedure DesvincularEquipoActual;

    procedure Grabar;

    function idReclamoListado: GUID_ID;
    procedure ReclamoEditar (refReclamo: GUID_ID);

    procedure CargarCombos (var cbMedios: TComboBox);
    procedure PosicionarCombos (var cbMedios: TComboBox);

    procedure ReclamoEliminar (refReclamo: GUID_ID);
    function idOrdenTrabajo: GUID_ID;

    procedure DesvincularTecnico;
    procedure VincularTecnico(refTecnico: integer; ApyNomTecnico: string);

    procedure AsignarRemito (refRemito: GUID_ID);

    function idRemito: GUID_ID;
    procedure LevantarRemitos;
  end;

var
  dm_reclamos: Tdm_reclamos;

implementation
{$R *.lfm}
uses
  dateutils
  ,dmEquipos
  ;

{ Tdm_reclamos }

procedure Tdm_reclamos.tbReclamosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idReclamo').AsString:= DM_General.CrearGUID;
    FieldByName('refCliente').asString:= GUIDNULO;
    FieldByName('nNro').asInteger:= -1;
    FieldByName('fHora').asDateTime:= TimeOf(Now);
    FieldByName('fFecha').asDateTime:= DateOf(Now);
    FieldByName('cSolicitante').asString:= '';
    FieldByName('refMedio').asInteger:= 0;
    FieldByName('txDetalles').asString:= '';
    FieldByName('refOrdenTrabajo').asString:= GUIDNULO;
    FieldByName('fAtendido').AsDateTime:= Now;
    FieldByName('refTecnicoAtendio').asInteger:= 0;
    FieldByName('bAtendido').asInteger:= 0;
    FieldByName('txInformeTecnico').asString:= '';
    FieldByName('txObservaciones').asString:= '';
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure Tdm_reclamos.trReclamosEquiposAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idReclamoEquipo').AsString:= DM_General.CrearGUID;
    FieldByName('refReclamo').AsString:= tbReclamos.FieldByName('idReclamo').asString;
  end;
end;

procedure Tdm_reclamos.trReclamoTecnicosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idReclamoTecnico').asString:= DM_General.CrearGUID;
    FieldByName('refReclamo').AsString:= tbReclamos.FieldByName('idReclamo').asString;
    FieldByName('refTecnico').AsInteger:= 0;
  end;
end;

procedure Tdm_reclamos.LevantarReclamosCliente(idCliente: GUID_ID;
  atendidos: boolean);
begin
  with qListaReclamos do
  begin
    if active then close;

    SQL.Clear;
    SQL.Add(' SELECT Re.idReclamo, Re.refCliente, Re.nNro, Re.fFecha, Re.bAtendido, Re.bVisible');
    SQL.Add(' ,C.cNombre, C.cCodigo, R.nRemito');
    SQL.Add(' FROM tbReclamos Re');
    SQL.Add('       LEFT JOIN tbClientes C ON Re.refCliente = C.idCliente ');
    SQL.Add('       LEFT JOIN trReclamoRemito RR ON Re.idReclamo = RR.refReclamo ');
    SQL.Add('       LEFT JOIN tbRemitos R ON R.idRemito = RR.refRemito ');

    SQL.Add('WHERE (Re.bVisible = 1) ');

    if idCliente <> GUIDNULO then
     SQL.Add(' AND (RE.refCliente =  ''' + idCliente + ''')');

    if atendidos then
      SQL.Add(' AND (Re.bAtendido = 1)')
    else
      SQL.Add(' AND (Re.bAtendido <> 1)');

    Open;
  end;
end;

procedure Tdm_reclamos.ReclamoNuevo(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbReclamos);
  DM_General.ReiniciarTabla(trReclamosEquipos);
  DM_General.ReiniciarTabla(trReclamoTecnicos);
  tbReclamos.Insert;
  AsignarCliente(refCliente);
end;

procedure Tdm_reclamos.AsignarCliente(refCliente: GUID_ID);
begin
  with tbReclamos do
  begin
    Edit;
    FieldByName('refCliente').AsString:= refCliente;
    Post;
  end;
end;

procedure Tdm_reclamos.AsignarOrdenTrabajo(refOrdenTrabajo: GUID_ID);
begin
  with tbReclamos do
  begin
    Edit;
    FieldByName('refOrdenTrabajo').AsString:= refOrdenTrabajo;
    Post;
  end;
end;

procedure Tdm_reclamos.DesvincularOrdenTrabajo;
begin
  with tbReclamos do
  begin
    Edit;
    FieldByName('refOrdenTrabajo').asString:= GUIDNULO;
    Post;
  end;
end;

procedure Tdm_reclamos.VincularEquipo(refEquipo: GUID_ID);
begin
  DM_Equipos.CargarDatosEquipo(refEquipo);

  with trReclamosEquipos do
  begin
    Insert;
    FieldByName('refEquipo').asString:= refEquipo;
    FieldByName('lxNombre').asString:= DM_Equipos.tbEquipos.FieldByName ('Nombre').asString;
    FieldByName('lxTipoEquipo').asString:= DM_Equipos.tbEquipos.FieldByName ('lxTipoEquipo').asString;
    FieldByName('lxNro').asInteger:= DM_Equipos.tbEquipos.FieldByName ('nNroEquipo').asInteger;
    Post;
  end;
end;

procedure Tdm_reclamos.DesvincularEquipoActual;
begin
  with trReclamosEquiposDEL do
  begin
    ParamByName ('idReclamoEquipo').asString:= trReclamosEquipos.FieldByName('idReclamoEquipo').asString;
    ExecSQL;
    trReclamosEquipos.Delete;
  end;
end;

procedure Tdm_reclamos.Grabar;
begin
  DM_General.GrabarDatos(tbReclamosSEL, tbReclamosINS, tbReclamosUPD, tbReclamos, 'idReclamo');
  DM_General.GrabarDatos(trReclamosEquiposSEL, trReclamosEquiposINS, trReclamosEquiposUPD, trReclamosEquipos, 'idReclamoEquipo');
  DM_General.GrabarDatos(trReclamoTecnicosSEL, trReclamoTecnicosINS, trReclamoTecnicosUPD, trReclamoTecnicos, 'idReclamoTecnico');

  //No puede ser que sigan quedando residuos del reclamo en los memos
  DM_General.ReiniciarTabla(tbReclamos);
  DM_General.ReiniciarTabla(trReclamosEquipos);
  DM_General.ReiniciarTabla(trReclamoTecnicos);
end;

function Tdm_reclamos.idReclamoListado: GUID_ID;
begin
  if ((qListaReclamos.Active ) AND (qListaReclamos.RecordCount > 0)) then
    Result := qListaReclamos.FieldByName('idReclamo').asString
  else
    Result := GUIDNULO;
end;

procedure Tdm_reclamos.ReclamoEditar(refReclamo: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbReclamos);
  DM_General.ReiniciarTabla(trReclamosEquipos);
  DM_General.ReiniciarTabla(trReclamoTecnicos);

  with tbReclamosSEL do
  begin
    if active then close;
    ParamByName('idReclamo').asString:= refReclamo;
    Open;
    tbReclamos.LoadFromDataSet(tbReclamosSEL, 0, lmAppend);
  end;

  with qLevantarReclamosEquipos do
  begin
    if Active then close;
    ParamByName('refReclamo').asString:= refReclamo;
    Open;
    trReclamosEquipos.LoadFromDataSet(qLevantarReclamosEquipos, 0, lmAppend);
    Close;
  end;

  with qLevantarReclamoTecnicos do
  begin
    if Active then close;
    ParamByName('refReclamo').asString:= refReclamo;
    Open;
    trReclamoTecnicos.LoadFromDataSet(qLevantarReclamoTecnicos, 0, lmAppend);
    Close;
  end;
end;

procedure Tdm_reclamos.CargarCombos(var cbMedios: TComboBox);
begin
  with tbReclamos do
  begin
    Edit;
    FieldByName('refMedio').AsInteger:= DM_General.obtenerIDIntComboBox(cbMedios);
    Post;
  end;
end;

procedure Tdm_reclamos.PosicionarCombos(var cbMedios: TComboBox);
begin
  cbMedios.ItemIndex:= DM_General.obtenerIdxCombo(cbMedios, tbReclamos.FieldByName('refMedio').AsInteger);
end;

procedure Tdm_reclamos.ReclamoEliminar(refReclamo: GUID_ID);
begin
  with tbReclamosDEL do
  begin
    ParamByName('idReclamo').asString:= refReclamo;
    ExecSQL;
  end;
end;

function Tdm_reclamos.idOrdenTrabajo: GUID_ID;
begin
  with dm_reclamos do
  begin
    if ((tbReclamos.Active) and (NOT tbReclamos.EOF)) then
      Result:= tbReclamos.FieldByName('refOrdenTrabajo').AsString
    else
      Result:= GUIDNULO;
  end;
end;

procedure Tdm_reclamos.DesvincularTecnico;
begin
  with trReclamoTecnicosDEL do
  begin
    ParamByName('idReclamoTecnico').AsString:= trReclamoTecnicos.FieldByName('idReclamoTecnico').asString;
    ExecSQL;
    trReclamoTecnicos.Delete;
  end;
end;

procedure Tdm_reclamos.VincularTecnico(refTecnico: integer;
  ApyNomTecnico: string);
begin
  with trReclamoTecnicos do
  begin
    Insert;
    FieldByName('refTecnico').asInteger:= refTecnico;
    FieldByName('lxNombreTecnico').asString:= ApyNomTecnico;
    Post;
  end;
end;

procedure Tdm_reclamos.AsignarRemito(refRemito: GUID_ID);
begin
  with trReclamoRemitoINS do
  begin
    ParamByName('idReclamoRemito').asString:= DM_General.CrearGUID;
    ParamByName('refReclamo').AsString:= tbReclamos.FieldByName('idReclamo').asString;
    ParamByName('refRemito').asString:= refRemito;
    ExecSQL;
  end;
end;

function Tdm_reclamos.idRemito: GUID_ID;
begin
  with qLevantarReclamoRemito do
  begin
    if active then close;
    ParamByName('refReclamo').AsString:= tbReclamos.FieldByName('idReclamo').asString;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('refRemito').asString
    else
      Result:= GUIDNULO;
  end;
end;

procedure Tdm_reclamos.LevantarRemitos;
begin
  DM_General.ReiniciarTabla(trReclamoRemito);
  with qLevantarReclamoRemito do
  begin
    if active then close;
    ParamByName('refReclamo').asString:= tbReclamos.FieldByName('idReclamo').asString;
    Open;

    trReclamoRemito.LoadFromDataSet(qLevantarReclamoRemito, 0, lmAppend);
  end;
end;


end.

