unit frm_ordentrabajoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons, DBGrids, dbdateedit
  ,dmgeneral;

type

  { TfrmOrdenTrabajoAE }

  TfrmOrdenTrabajoAE = class(TForm)
    BitBtn1: TBitBtn;
    btnImprimir: TBitBtn;
    btnAgregarRemito: TBitBtn;
    btnQuitarRemito: TBitBtn;
    btnVerRemito: TBitBtn;
    btnVincularPresupuesto: TBitBtn;
    btnAgregarEquipo: TBitBtn;
    btnQuitarEquipo: TBitBtn;
    btnBuscarCliente: TBitBtn;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBEdit2: TDBEdit;
    dbFechaAlta: TDBDateEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DS_OrdenTrabajo: TDatasource;
    DBEdit1: TDBEdit;
    DS_OTEquipos: TDatasource;
    DS_OTRemitos: TDatasource;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAgregarRemitoClick(Sender: TObject);
    procedure btnAgregarEquipoClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnQuitarEquipoClick(Sender: TObject);
    procedure btnQuitarRemitoClick(Sender: TObject);
    procedure btnVerRemitoClick(Sender: TObject);
    procedure btnVincularPresupuestoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idOrdenTrabajo: GUID_ID;
  public
    property idCliente: GUID_ID write _idCliente;
    property idOrdenTrabajo: GUID_ID read _idOrdenTrabajo;
  end; 

var
  frmOrdenTrabajoAE: TfrmOrdenTrabajoAE;

implementation
 {$R *.lfm}
 uses
   frm_busquedaclientes
  ,dmclientes
  ,frm_equiposeleccion
  ,dmordenestrabajo
  ,frm_presupuestoseleccion
  ,frm_remitoslistado
   ,dmremitos
   ,frm_remitosae
  ;

{ TfrmOrdenTrabajoAE }

procedure TfrmOrdenTrabajoAE.BitBtn1Click(Sender: TObject);
begin
  _idOrdenTrabajo:= DM_OrdenesTrabajo.idOrdenTrabajo;
  DM_OrdenesTrabajo.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmOrdenTrabajoAE.btnAgregarRemitoClick(Sender: TObject);
 var
  pant: TfrmRemitosListado;
begin
  pant:= TfrmRemitosListado.Create(self);
  try
    pant.idCliente:= _idCliente;
    pant.idOrdenTrabajo:= DM_OrdenesTrabajo.idOrdenTrabajo;
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenesTrabajo.AsignarRemito (pant.idRemitoSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmOrdenTrabajoAE.btnAgregarEquipoClick(Sender: TObject);
var
  pant: TfrmEquipoSeleccion;
begin
  pant:= TfrmEquipoSeleccion.Create (self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenesTrabajo.VincularEquipo (pant.idEquipo);
    end;
  finally
  end;
end;

procedure TfrmOrdenTrabajoAE.btnBuscarClienteClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      edCliente.Text:= DM_Clientes.ClienteNombre (pantBusqueda.idCliente);
      _idCliente:= pantBusqueda.idCliente;
      DM_OrdenesTrabajo.OrdenTrabajoCambiarCliente(_idCliente);
    end;

  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmOrdenTrabajoAE.btnImprimirClick(Sender: TObject);
var
  losAscensores: string;
begin
  DM_General.LevantarReporte(_PRN_ORDENTRABAJO_, DM_OrdenesTrabajo.tbOrdenesTrabajo);
  losAscensores:= DM_OrdenesTrabajo.listaEquipos;
  DM_General.AgregarVariableReporte ('EQUIPOS', losAscensores);
  DM_General.AgregarVariableReporte('CLIENTE', edCliente.Text);
  DM_General.EjecutarReporte;
end;

procedure TfrmOrdenTrabajoAE.btnQuitarEquipoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Elimino el equipo seleccionado de la Orden de Trabajo?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   DM_OrdenesTrabajo.DesvincularEquipoActual;
end;

procedure TfrmOrdenTrabajoAE.btnQuitarRemitoClick(Sender: TObject);
begin
  DM_OrdenesTrabajo.QuitarRemito;
end;

procedure TfrmOrdenTrabajoAE.btnVerRemitoClick(Sender: TObject);
var
  pantalla: TfrmRemitosAE;
begin
  pantalla:= TfrmRemitosAE.Create (self);
  try
    DM_Remitos.RemitoEditar(DS_OTRemitos.DataSet.FieldByName('refRemito').asString);
    if DS_OTRemitos.DataSet.FieldByName('refRemito').asString <> GUIDNULO then
    begin
      pantalla.idCliente:= _idCliente;
      if pantalla.ShowModal = mrOK then
      begin
      end;
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmOrdenTrabajoAE.btnVincularPresupuestoClick(Sender: TObject);
var
  pant: TFrmPresupuestoSeleccion;
begin
  pant:= TFrmPresupuestoSeleccion.Create (self);
  try
    pant.idCliente:= _idCliente;
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenesTrabajo.VincularPresupuesto(pant.idPresupuesto);
 //     edPresupuesto.Text:= IntToStr(DM_Presupuestos.NroPresupuesto(pant.idPresupuesto));
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmOrdenTrabajoAE.FormShow(Sender: TObject);
begin
  edCliente.Text:= DM_Clientes.ClienteNombre(_idCliente);
end;

end.

