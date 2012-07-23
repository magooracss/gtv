unit frm_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  XMLPropStorage, Menus, ActnList, DBGrids
  ,dmgeneral;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    appListados: TAction;
    cajaOPListado: TAction;
    cajaCompraNueva: TAction;
    cajaPlanDeCuentas: TAction;
    cajaComprasListado: TAction;
    cajaCheques: TAction;
    appEditarReporte: TAction;
    cajaProveedores: TAction;
    cajaTugConceptos: TAction;
    cajaMovimientos: TAction;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    RemitosPantGralCliente: TAction;
    RemitoPantGral: TAction;
    ReclPantGralCliente: TAction;
    ReclPantGral: TAction;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem8: TMenuItem;
    OTPantGralCliente: TAction;
    OTPantGral: TAction;
    presPantGralCliente: TAction;
    MenuItem7: TMenuItem;
    presPantGral: TAction;
    cliModificar: TAction;
    ds_Clientes: TDatasource;
    DBGrid1: TDBGrid;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem9: TMenuItem;
    popGrillaPrincipal: TPopupMenu;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tugEquipos: TAction;
    cliBorrar: TAction;
    cliBusYModificar: TAction;
    cliNuevo: TAction;
    appSalir: TAction;
    ActionList1: TActionList;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuPpal: TMainMenu;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    XMLPropiedades: TXMLPropStorage;
    procedure appEditarReporteExecute(Sender: TObject);
    procedure appListadosExecute(Sender: TObject);
    procedure appSalirExecute(Sender: TObject);
    procedure cajaChequesExecute(Sender: TObject);
    procedure cajaCompraNuevaExecute(Sender: TObject);
    procedure cajaComprasListadoExecute(Sender: TObject);
    procedure cajaMovimientosExecute(Sender: TObject);
    procedure cajaOPListadoExecute(Sender: TObject);
    procedure cajaPlanDeCuentasExecute(Sender: TObject);
    procedure cajaProveedoresExecute(Sender: TObject);
    procedure cajaTugConceptosExecute(Sender: TObject);
    procedure cliBorrarExecute(Sender: TObject);
    procedure cliBusYModificarExecute(Sender: TObject);
    procedure cliModificarExecute(Sender: TObject);
    procedure cliNuevoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OTPantGralClienteExecute(Sender: TObject);
    procedure OTPantGralExecute(Sender: TObject);
    procedure presPantGralClienteExecute(Sender: TObject);
    procedure presPantGralExecute(Sender: TObject);
    procedure ReclPantGralExecute(Sender: TObject);
    procedure RemitoPantGralExecute(Sender: TObject);
  private
    procedure Inicializar;
    procedure PantallaModificarCliente(idCliente: GUID_ID);
    procedure PantallaPresupuestos (idCliente: GUID_ID);
    procedure PantallaOrdenTrabajo (idCliente: GUID_ID);
    procedure PantallaReclamos (idCliente: GUID_ID);
    procedure PantallaRemitos (idCliente: GUID_ID);

    procedure PantallaListados;
  public
    { public declarations }
  end; 

var
  frmPrincipal: TfrmPrincipal;

implementation
{$R *.lfm}

uses
   versioninfo
  ,frm_clienteam
  ,dmclientes
  ,frm_busquedaclientes
  ,frm_presupuestoslistado
  ,frm_ordenestrabajolistado
  ,frm_reclamoslistado
  ,frm_remitoslistado
  ,frm_cajalistado
  ,frm_tugconceptoslistado
  ,frm_proveedoreslistado
  ,frm_listadocheques
  ,frm_compraslistado
  ,frm_plandecuentaslistado
  ,frm_comprasae
  ,frm_ordenespagolistado
  , Process
  ;

{ TfrmPrincipal }
procedure TfrmPrincipal.Inicializar;
Var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  st.Panels[0].Text:= 'v:' + NroVersion;
  st.Panels[1].Text:= FormatDateTime('dd/mm/yyyy', now)+ '        ';

  DM_Clientes.ListaClientes;
end;


procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPrincipal.appSalirExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.appEditarReporteExecute(Sender: TObject);
begin
  DM_General.EditarReporte;
end;

procedure TfrmPrincipal.appListadosExecute(Sender: TObject);
begin
  PantallaListados;
end;


(*******************************************************************************
*****  MANEJO DE CLIENTES
*******************************************************************************)
procedure TfrmPrincipal.cliNuevoExecute(Sender: TObject);
var
  pant: Tfrm_ClientesAM;
begin
  pant:= Tfrm_ClientesAM.Create (self);
  try
    pant.operacion:= nuevo;
    pant.ShowModal;
    DM_Clientes.ListaClientes;
  finally
    pant.free;
  end;
end;

procedure TfrmPrincipal.PantallaModificarCliente(idCliente: GUID_ID);
var
  pant: Tfrm_ClientesAM;
begin
  pant:= Tfrm_ClientesAM.Create (self);
  try
    pant.operacion:= modificar;
    pant.cliente:= idCliente;
    pant.ShowModal;
    DM_Clientes.ListaClientes;
  finally
    pant.free;
  end;
end;


procedure TfrmPrincipal.cliBusYModificarExecute(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      PantallaModificarCliente(pantBusqueda.idCliente);
    end;
  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmPrincipal.cliModificarExecute(Sender: TObject);
begin
  PantallaModificarCliente(DM_Clientes.idClienteListadoGral);
end;

procedure TfrmPrincipal.cliBorrarExecute(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      if (MessageDlg ('ATENCION', 'Borro el Cliente seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
      begin
       DM_Clientes.BorrarCliente (pantBusqueda.idCliente);
       DM_Clientes.ListaClientes;
      end;
    end;
  finally
    pantBusqueda.Free;
  end;
end;

(*******************************************************************************
*****  MANEJO DE PRESUPUESTOS
*******************************************************************************)

procedure TfrmPrincipal.PantallaPresupuestos(idCliente: GUID_ID);
var
  pant: TfrmPresupuestosListados;
begin
  pant:= TfrmPresupuestosListados.Create(self);
  try
    pant.idCliente:= idCliente;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.presPantGralExecute(Sender: TObject);
begin
  PantallaPresupuestos(GUIDNULO);
end;

procedure TfrmPrincipal.presPantGralClienteExecute(Sender: TObject);
begin
 PantallaPresupuestos(DM_Clientes.idClienteListadoGral);
end;

(*******************************************************************************
*****  MANEJO DE ORDENES DE TRABAJO
*******************************************************************************)
procedure TfrmPrincipal.PantallaOrdenTrabajo(idCliente: GUID_ID);
 var
  pant: TfrmOrdenesTrabajoListado;
begin
  pant:= TfrmOrdenesTrabajoListado.Create(self);
  try
    pant.idCliente:= idCliente;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.OTPantGralClienteExecute(Sender: TObject);
begin
  PantallaOrdenTrabajo(DM_Clientes.idClienteListadoGral);
end;

procedure TfrmPrincipal.OTPantGralExecute(Sender: TObject);
begin
  PantallaOrdenTrabajo(GUIDNULO);
end;

(*******************************************************************************
*****  MANEJO DE RECLAMOS
*******************************************************************************)
procedure TfrmPrincipal.PantallaReclamos(idCliente: GUID_ID);
 var
  pant: TfrmReclamosListado;
begin
  pant:= TfrmReclamosListado.Create(self);
  try
    pant.idCliente:= idCliente;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;




procedure TfrmPrincipal.ReclPantGralExecute(Sender: TObject);
begin
  PantallaReclamos(GUIDNULO);
end;

(*******************************************************************************
*****  MANEJO DE REMITOS
*******************************************************************************)
procedure TfrmPrincipal.PantallaRemitos(idCliente: GUID_ID);
 var
  pant: TfrmRemitosListado;
begin
  pant:= TfrmRemitosListado.Create(self);
  try
    pant.idCliente:= idCliente;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.PantallaListados;
var
  archivo: string;
  AProcess: TProcess;
begin
  archivo:= ExtractFilePath(Application.ExeName) + '\' + 'selrpt.exe';
  if FileExists(archivo) then
  begin
   AProcess := TProcess.Create (nil);
   AProcess.CommandLine  :=  archivo;
   AProcess.Options  := AProcess.Options + [poWaitOnExit] ;
   AProcess.Execute;
   AProcess.Free;
  end
  else
   ShowMessage('No se encuentra el módulo de listados');
end;


procedure TfrmPrincipal.RemitoPantGralExecute(Sender: TObject);
begin
  PantallaRemitos(GUIDNULO);
end;


(*******************************************************************************
*****  CAJA
*******************************************************************************)

procedure TfrmPrincipal.cajaMovimientosExecute(Sender: TObject);
var
  pantalla: TfrmCajaListado;
begin
  pantalla:= TfrmCajaListado.Create(self);
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmPrincipal.cajaPlanDeCuentasExecute(Sender: TObject);
var
  pant: TfrmPlanDeCuentasListado;
begin
  pant:= TfrmPlanDeCuentasListado.Create (Self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.cajaProveedoresExecute(Sender: TObject);
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create (self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.cajaTugConceptosExecute(Sender: TObject);
var
  pant: TfrmTugConceptosListado;
begin
  pant:= TfrmTugConceptosListado.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.cajaChequesExecute(Sender: TObject);
var
  pant: TfrmListadoCheques;
begin
  pant:= TfrmListadoCheques.Create(self);
  try
    pant.ShowModal;
  finally
    pant.free;
  end;
end;

procedure TfrmPrincipal.cajaCompraNuevaExecute(Sender: TObject);
var
  pant: TfrmComprasAE;
begin
  pant:= TfrmComprasAE.Create(self);
  try
    pant.idCompra:= GUIDNULO;
    pant.ShowModal;
  finally
    pant.Free;
  end;

end;

procedure TfrmPrincipal.cajaComprasListadoExecute(Sender: TObject);
var
  pant: TfrmComprasListado;
begin
  pant:= TfrmComprasListado.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


procedure TfrmPrincipal.cajaOPListadoExecute(Sender: TObject);
var
  pant: TfrmOrdenesPagoListado;
begin
  pant:= TfrmOrdenesPagoListado.Create (self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;



end.
