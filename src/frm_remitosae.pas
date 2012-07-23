unit frm_remitosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons, DBGrids, ExtCtrls, dbdateedit, dmgeneral
  ;

type

  { TfrmRemitosAE }

  TfrmRemitosAE = class(TForm)
    btnAgregarTecnico: TBitBtn;
    btnGrabarSalir: TBitBtn;
    btnAgregarEquipo: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnNuevaOT: TBitBtn;
    btnNuevoReclamo: TBitBtn;
    btnQuitarEquipo: TBitBtn;
    btnAsignarReclamo: TBitBtn;
    btnDesvincularReclamo: TBitBtn;
    btnQuitarTecnico: TBitBtn;
    btnQuitarEquipo2: TBitBtn;
    btnQuitarEquipo3: TBitBtn;
    btnVerOrdenTrabajo: TBitBtn;
    btnTugTecnicos: TSpeedButton;
    btnVerReclamo: TBitBtn;
    cbMotivo: TComboBox;
    DBEdit1: TDBEdit;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    DS_Remito: TDatasource;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    dbFechaAlta: TDBDateEdit;
    DBGrid1: TDBGrid;
    DS_RemitoEquipo: TDatasource;
    DS_RemitoTecnicos: TDatasource;
    edCliente: TEdit;
    edOrdenTrabajo: TEdit;
    edReclamo: TEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    procedure btnAgregarEquipoClick(Sender: TObject);
    procedure btnAgregarTecnicoClick(Sender: TObject);
    procedure btnAsignarReclamoClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnDesvincularReclamoClick(Sender: TObject);
    procedure btnGrabarSalirClick(Sender: TObject);
    procedure btnNuevaOTClick(Sender: TObject);
    procedure btnNuevoReclamoClick(Sender: TObject);
    procedure btnQuitarEquipo2Click(Sender: TObject);
    procedure btnQuitarEquipo3Click(Sender: TObject);
    procedure btnQuitarTecnicoClick(Sender: TObject);
    procedure btnVerOrdenTrabajoClick(Sender: TObject);
    procedure btnQuitarEquipoClick(Sender: TObject);
    procedure btnTugTecnicosClick(Sender: TObject);
    procedure btnVerReclamoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idOrdenTrabajo: GUID_ID;
    _idRemito: GUID_ID;

    procedure Inicializar;
    procedure LevantarOrdenTrabajo;
    procedure LevantarReclamo;
    procedure LevantarEquipos;
  public
    property idCliente: GUID_ID write _idCliente;
    property idRemito: GUID_ID read _idRemito;
    property idOrdenTrabajo: GUID_ID write _idOrdenTrabajo;

  end; 

var
  frmRemitosAE: TfrmRemitosAE;

implementation
{$R *.lfm}
uses
  dmremitos
 ,frm_ediciontugs
 ,dmediciontugs
 ,frm_equiposeleccion
 ,dmordenestrabajo
 ,dmclientes
 ,frm_busquedaclientes
 ,frm_ordentrabajoae
 ,frm_ordenestrabajolistado
 ,frm_listadopersonal
 ,frm_reclamosam
 ,frm_reclamoslistado
 ,dmreclamos
 ;

{ TfrmRemitosAE }

procedure TfrmRemitosAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmRemitosAE.btnTugTecnicosClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGMOTIVOSREMITO';
      titulo:= 'Motivos de realización del remito';
      AgregarCampo('MotivoRemito','Motivos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbMotivo, 'MotivoRemito', 'idMotivoRemito', DM_Remitos.qtugMotivosRemito);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmRemitosAE.btnVerReclamoClick(Sender: TObject);
var
  pantalla: TfrmReclamosAM;
begin
  pantalla:= TfrmReclamosAM.Create (self);
  try
    dm_reclamos.ReclamoEditar(DM_Remitos.idReclamo);
    if DM_Remitos.idReclamo <> GUIDNULO then
    begin
      pantalla.idCliente:= _idCliente;
      if pantalla.ShowModal = mrOK then
      begin
        DM_Remitos.AsignarReclamo (pantalla.idReclamo);
        LevantarReclamo;
      end;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmRemitosAE.FormCreate(Sender: TObject);
begin
  _idCliente:= GUIDNULO;
  _idOrdenTrabajo:= GUIDNULO;
  _idRemito:= GUIDNULO;
end;

procedure TfrmRemitosAE.btnGrabarSalirClick(Sender: TObject);
begin
   DM_Remitos.VolcarCombos(cbMotivo);
   _idRemito:= DM_Remitos.tbRemitos.FieldByName('idRemito').AsString;
   DM_Remitos.Grabar;
   ModalResult:= mrOK;
end;

procedure TfrmRemitosAE.btnNuevaOTClick(Sender: TObject);
var
  pantalla: TfrmOrdenTrabajoAE;
begin
  pantalla:= TfrmOrdenTrabajoAE.Create (self);
  try
    DM_OrdenesTrabajo.OrdenTrabajoNueva (_idCliente);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      DM_Remitos.AsignarOrdenTrabajo (pantalla.idOrdenTrabajo);
      LevantarOrdenTrabajo;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmRemitosAE.btnNuevoReclamoClick(Sender: TObject);
var
  pantalla: TfrmReclamosAM;
begin
  pantalla:= TfrmReclamosAM.Create (self);
  try
    dm_reclamos.ReclamoNuevo (_idCliente);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      DM_Remitos.AsignarReclamo (pantalla.idReclamo);
      LevantarReclamo;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmRemitosAE.btnQuitarEquipo2Click(Sender: TObject);
 var
  pant: TfrmOrdenesTrabajoListado;
begin
  pant:= TfrmOrdenesTrabajoListado.Create(self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      DM_Remitos.AsignarOrdenTrabajo (pant.idOrdenTrabajoSeleccionada);
      LevantarOrdenTrabajo;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmRemitosAE.btnQuitarEquipo3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Desvinculo la orden de trabajo del Remito? (La OT no será borrada)', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
   DM_Remitos.DesvincularOrdenTrabajo;
   LevantarOrdenTrabajo;
  end;
end;

procedure TfrmRemitosAE.btnQuitarTecnicoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Quito del remito al técnico seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
 begin
   DM_Remitos.DesvincularTecnico;
 end;
end;

procedure TfrmRemitosAE.btnVerOrdenTrabajoClick(Sender: TObject);
var
  pantalla: TfrmOrdenTrabajoAE;
begin
  pantalla:= TfrmOrdenTrabajoAE.Create (self);
  try
    DM_OrdenesTrabajo.OrdenTrabajoEditar (DM_Remitos.idOrdenTrabajo);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      DM_Remitos.AsignarOrdenTrabajo (pantalla.idOrdenTrabajo);
      LevantarOrdenTrabajo;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmRemitosAE.btnQuitarEquipoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Elimino el equipo seleccionado del Remito?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
 begin
   DM_Remitos.DesvincularEquipoActual;
 end;

end;

procedure TfrmRemitosAE.btnAgregarEquipoClick(Sender: TObject);
var
  pant: TfrmEquipoSeleccion;
begin
  pant:= TfrmEquipoSeleccion.Create (self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      DM_Remitos.VincularEquipo (pant.idEquipo);
    end;
  finally
    pant.free;
  end;
end;

procedure TfrmRemitosAE.btnAgregarTecnicoClick(Sender: TObject);
var
  pant: TfrmListadoPersonal;
begin
  pant:= TfrmListadoPersonal.Create(self);
  try
    if pant.ShowModal = mrOK then
      DM_Remitos.vincularTecnico(pant.idEmpleado, pant.NombreEmpleado);
  finally
    pant.Free;
  end;
end;

procedure TfrmRemitosAE.btnAsignarReclamoClick(Sender: TObject);
 var
  pant: TfrmReclamosListado;
begin
  pant:= TfrmReclamosListado.Create(self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      DM_Remitos.AsignarReclamo (pant.idReclamo);
      LevantarReclamo;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmRemitosAE.btnBuscarClienteClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      edCliente.Text:= DM_Clientes.ClienteNombre (pantBusqueda.idCliente);
      _idCliente:= pantBusqueda.idCliente;
      DM_Remitos.asignarCliente (_idCliente);
    end;

  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmRemitosAE.btnDesvincularReclamoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Desvinculo el reclamo del remito?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
 begin
   DM_Remitos.DesvincularReclamo(DM_Remitos.tbRemitos.FieldByName('idRemito').asString);
   LevantarReclamo;
 end;
end;

procedure TfrmRemitosAE.Inicializar;
begin
  DM_General.CargarComboBox(cbMotivo, 'MotivoRemito', 'idMotivoRemito', DM_Remitos.qtugMotivosRemito);
  edOrdenTrabajo.Text:= '00000';
  edCliente.Text:= DM_Clientes.ClienteNombre(_idCliente);
  if _idCliente <> GUIDNULO then
    DM_Remitos.asignarCliente (_idCliente);
  cbMotivo.ItemIndex:= DM_General.obtenerIdxCombo(cbMotivo, DM_Remitos.tbRemitos.FieldByName('refMotivo').asInteger);
  if _idOrdenTrabajo <> GUIDNULO then
    DM_Remitos.AsignarOrdenTrabajo(_idOrdenTrabajo);
  LevantarOrdenTrabajo;
  LevantarReclamo;
end;

procedure TfrmRemitosAE.LevantarOrdenTrabajo;
var
  refOrdenTrabajo: GUID_ID;
begin
  refOrdenTrabajo:= DM_Remitos.idOrdenTrabajo;

  if refOrdenTrabajo <> GUIDNULO then
  begin
    DM_OrdenesTrabajo.OrdenTrabajoEditar(DM_Remitos.idOrdenTrabajo);
    edOrdenTrabajo.Text:= IntToStr(DM_OrdenesTrabajo.tbOrdenesTrabajo.FieldByName('nNro').asInteger);
  end
  else
    edOrdenTrabajo.Text:= '0000000000';
end;

procedure TfrmRemitosAE.LevantarReclamo;
var
  refReclamo: GUID_ID;
begin
  refReclamo:= DM_Remitos.idReclamo;

  if refReclamo <> GUIDNULO then
  begin
    dm_reclamos.ReclamoEditar(DM_Remitos.idReclamo);
    edReclamo.Text:= IntToStr(dm_reclamos.tbReclamos.FieldByName('nNro').asInteger);
  end
  else
    edReclamo.Text:= '0000000000';
end;

procedure TfrmRemitosAE.LevantarEquipos;
begin
  DM_Remitos.LevantarEquipos;
end;

end.

