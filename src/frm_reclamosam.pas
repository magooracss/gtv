unit frm_reclamosam;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids, dbdateedit, DBZVDateTimePicker
  ,dmgeneral;

type

  { TfrmReclamosAM }

  TfrmReclamosAM = class(TForm)
    BitBtn1: TBitBtn;
    btnAgregarEquipo: TBitBtn;
    btnAgregarTecnico: TBitBtn;
    btnAsignarRemito: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnDesvincularRemito: TBitBtn;
    btnNuevoRemito: TBitBtn;
    btnQuitarEquipo: TBitBtn;
    btnNuevaOT: TBitBtn;
    btnQuitarEquipo2: TBitBtn;
    btnQuitarEquipo3: TBitBtn;
    btnQuitarEquipo4: TBitBtn;
    btnQuitarTecnico: TBitBtn;
    btnTugMedios: TSpeedButton;
    btnTugTecnicos: TSpeedButton;
    btnVerRemito: TBitBtn;
    cbMedios: TComboBox;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBMemo1: TDBMemo;
    DBZVDateTimePicker1: TDBZVDateTimePicker;
    ds_trReclamosEquipos: TDatasource;
    ds_tbReclamos: TDatasource;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit3: TDBEdit;
    dbFechaAlta: TDBDateEdit;
    dbFechaAlta1: TDBDateEdit;
    DBGrid1: TDBGrid;
    DBMemo2: TDBMemo;
    ds_trReclamosTecnicos: TDatasource;
    ds_trReclamoRemito: TDatasource;
    edCliente: TEdit;
    edOrdenTrabajo: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAgregarEquipoClick(Sender: TObject);
    procedure btnAgregarTecnicoClick(Sender: TObject);
    procedure btnAsignarRemitoClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnDesvincularRemitoClick(Sender: TObject);
    procedure btnNuevaOTClick(Sender: TObject);
    procedure btnNuevoRemitoClick(Sender: TObject);
    procedure btnQuitarEquipo2Click(Sender: TObject);
    procedure btnQuitarEquipo3Click(Sender: TObject);
    procedure btnQuitarEquipo4Click(Sender: TObject);
    procedure btnQuitarEquipoClick(Sender: TObject);
    procedure btnQuitarTecnicoClick(Sender: TObject);
    procedure btnTugMediosClick(Sender: TObject);
    procedure btnTugTecnicosClick(Sender: TObject);
    procedure btnVerRemitoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idReclamo: GUID_ID;
    procedure LevantarOrdenTrabajo;
    procedure LevantarRemito;
  public
    property idCliente: GUID_ID write _idCliente;
    property idReclamo: GUID_ID read _idReclamo;
  end; 

var
  frmReclamosAM: TfrmReclamosAM;

implementation
{$R *.lfm}
uses
   dmreclamos
  ,frm_ediciontugs
  ,dmediciontugs
  ,dmclientes
  ,frm_busquedaclientes
  ,frm_equiposeleccion
  ,dmordenestrabajo
  ,frm_ordentrabajoae
  ,frm_ordenestrabajolistado
  ,frm_listadopersonal
  ,dmremitos
  ,frm_remitosae
  ,frm_remitoslistado
  ;

{ TfrmReclamosAM }



procedure TfrmReclamosAM.btnTugTecnicosClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGEMPLEADOS';
      titulo:= 'Técnicos';
      AgregarCampo('Empleado','Apellido y Nombres');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
//    DM_General.CargarComboBox(cbTecnicos, 'Empleado', 'idEmpleado', dm_reclamos.qtugTecnicos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmReclamosAM.btnVerRemitoClick(Sender: TObject);
var
  pantalla: TfrmRemitosAE;
begin
  pantalla:= TfrmRemitosAE.Create (self);
  try
    DM_Remitos.RemitoEditar(dm_reclamos.trReclamoRemito.FieldByName('refRemito').asString);
    if dm_reclamos.trReclamoRemito.FieldByName('refRemito').asString <> GUIDNULO then
    begin
      pantalla.idCliente:= _idCliente;
      if pantalla.ShowModal = mrOK then
      begin
//        DM_Remitos.AsignarReclamo (pantalla.idRemito);
//        LevantarRemito;
      end;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmReclamosAM.btnTugMediosClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGMEDIOSRECLAMO';
      titulo:= 'Medios para realizar un reclamo';
      AgregarCampo('MedioReclamo','Nombre del medio');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbMedios, 'MedioReclamo', 'idMedioReclamo', dm_reclamos.qtugMediosReclamo);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmReclamosAM.btnBuscarClienteClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      edCliente.Text:= DM_Clientes.ClienteNombre (pantBusqueda.idCliente);
      _idCliente:= pantBusqueda.idCliente;
      dm_reclamos.asignarCliente (_idCliente);
    end;

  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmReclamosAM.btnDesvincularRemitoClick(Sender: TObject);
begin
  with dm_reclamos, trReclamoRemitoDEL do
  begin
    ParamByName('idReclamoRemito').asString:= trReclamoRemito.FieldByName('idReclamoRemito').asString;
    ExecSQL;
    trReclamoRemito.Delete;
  end;
end;

procedure TfrmReclamosAM.btnQuitarEquipoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Elimino el equipo seleccionado del Reclamo?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   dm_reclamos.DesvincularEquipoActual;
end;

procedure TfrmReclamosAM.btnQuitarTecnicoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Quito del reclamo al técnico seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
 begin
   dm_reclamos.DesvincularTecnico;
 end;
end;


procedure TfrmReclamosAM.btnAgregarEquipoClick(Sender: TObject);
var
  pant: TfrmEquipoSeleccion;
begin
  pant:= TfrmEquipoSeleccion.Create (self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      dm_reclamos.VincularEquipo (pant.idEquipo);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmReclamosAM.btnAgregarTecnicoClick(Sender: TObject);
var
  pant: TfrmListadoPersonal;
begin
  pant:= TfrmListadoPersonal.Create(self);
  try
    if pant.ShowModal = mrOK then
      dm_reclamos.VincularTecnico(pant.idEmpleado, pant.NombreEmpleado);
  finally
    pant.Free;
  end;
end;

procedure TfrmReclamosAM.btnAsignarRemitoClick(Sender: TObject);
 var
  pant: TfrmRemitosListado;
begin
  pant:= TfrmRemitosListado.Create(self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      dm_reclamos.AsignarRemito (pant.idRemitoSeleccionado);
      LevantarRemito;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmReclamosAM.BitBtn1Click(Sender: TObject);
begin
  _idReclamo:= dm_reclamos.tbReclamos.FieldByName ('idReclamo').asString;
  dm_reclamos.cargarCombos (cbMedios);
  dm_reclamos.Grabar;

  ModalResult:= mrOK;
end;

procedure TfrmReclamosAM.FormShow(Sender: TObject);
begin
//  DM_General.CargarComboBox(cbTecnicos, 'Empleado', 'idEmpleado', dm_reclamos.qtugTecnicos);
  DM_General.CargarComboBox(cbMedios, 'MedioReclamo', 'idMedioReclamo', dm_reclamos.qtugMediosReclamo);
  edOrdenTrabajo.Text:= '00000';
  edCliente.Text:= DM_Clientes.ClienteNombre(_idCliente);
  dm_reclamos.PosicionarCombos (cbMedios);
  LevantarOrdenTrabajo;
  LevantarRemito;
end;

procedure TfrmReclamosAM.LevantarOrdenTrabajo;
var
  refOrdenTrabajo: GUID_ID;
begin
  refOrdenTrabajo:= dm_reclamos.idOrdenTrabajo;

  if refOrdenTrabajo <> GUIDNULO then
  begin
    DM_OrdenesTrabajo.OrdenTrabajoEditar(dm_reclamos.idOrdenTrabajo);
    edOrdenTrabajo.Text:= IntToStr(DM_OrdenesTrabajo.tbOrdenesTrabajo.FieldByName('nNro').asInteger);
  end
  else
    edOrdenTrabajo.Text:= '0000000000';
end;

procedure TfrmReclamosAM.LevantarRemito;
begin
  dm_reclamos.levantarRemitos;
end;


procedure TfrmReclamosAM.btnNuevaOTClick(Sender: TObject);
var
  pantalla: TfrmOrdenTrabajoAE;
begin
  pantalla:= TfrmOrdenTrabajoAE.Create (self);
  try
    DM_OrdenesTrabajo.OrdenTrabajoNueva (_idCliente);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      dm_reclamos.AsignarOrdenTrabajo (pantalla.idOrdenTrabajo);
      LevantarOrdenTrabajo;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmReclamosAM.btnNuevoRemitoClick(Sender: TObject);
var
  pantalla: TfrmRemitosAE;
begin
  pantalla:= TfrmRemitosAE.Create (self);
  try
    DM_Remitos.RemitoNuevo (_idCliente);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      dm_reclamos.AsignarRemito (pantalla.idRemito);
      LevantarRemito;
    end;
  finally
    pantalla.free;
  end;
end;

procedure TfrmReclamosAM.btnQuitarEquipo2Click(Sender: TObject);
 var
  pant: TfrmOrdenesTrabajoListado;
begin
  pant:= TfrmOrdenesTrabajoListado.Create(self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      dm_reclamos.AsignarOrdenTrabajo (pant.idOrdenTrabajoSeleccionada);
      LevantarOrdenTrabajo;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmReclamosAM.btnQuitarEquipo3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Desvinculo la orden de trabajo del Reclamo? (La OT no será borrada)', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
   dm_reclamos.DesvincularOrdenTrabajo;
   LevantarOrdenTrabajo;
  end;
end;

procedure TfrmReclamosAM.btnQuitarEquipo4Click(Sender: TObject);
var
  pantalla: TfrmOrdenTrabajoAE;
begin
  pantalla:= TfrmOrdenTrabajoAE.Create (self);
  try
    DM_OrdenesTrabajo.OrdenTrabajoEditar (dm_reclamos.idOrdenTrabajo);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      dm_reclamos.AsignarOrdenTrabajo (pantalla.idOrdenTrabajo);
      LevantarOrdenTrabajo;
    end;
  finally
    pantalla.free
  end;
end;

end.

