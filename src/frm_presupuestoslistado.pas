unit frm_presupuestoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons
  ,dmgeneral;


type

  { TfrmPresupuestosListados }

  TfrmPresupuestosListados = class(TForm)
    btnFiltrar: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnSalir: TBitBtn;
    btnPresupNuevo: TBitBtn;
    btnPresupEliminar: TBitBtn;
    btnPresupModificar: TBitBtn;
    ckClientes: TCheckBox;
    ckEstados: TCheckBox;
    cbEstados: TComboBox;
    DS_Listado: TDatasource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnPresupEliminarClick(Sender: TObject);
    procedure btnPresupModificarClick(Sender: TObject);
    procedure btnPresupNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure cbEstadosChange(Sender: TObject);
    procedure ckClientesChange(Sender: TObject);
    procedure ckEstadosChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edClienteKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idEstado: integer;
    procedure Inicializar;

  public
    property idCliente: GUID_ID read _idCliente write _idCliente;
  end; 

var
  frmPresupuestosListados: TfrmPresupuestosListados;

implementation
{$R *.lfm}
uses
  frm_busquedaclientes
  ,dmclientes
  ,dmpresupuestos
  ,frm_presupuestoae
  ,dmbuscarcliente
  ;


{ TfrmPresupuestosListados }

procedure TfrmPresupuestosListados.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPresupuestosListados.cbEstadosChange(Sender: TObject);
begin
  _idEstado:= DM_General.obtenerIDIntComboBox(cbEstados);
end;

procedure TfrmPresupuestosListados.ckClientesChange(Sender: TObject);
begin
  if ckClientes.Checked then
  begin
   _idCliente:= GUIDNULO;
   edCliente.Text := EmptyStr;
   btnBuscarCliente.Enabled:= False;
  end
  else
  begin
    btnBuscarCliente.Enabled:= True;
  end;
end;

procedure TfrmPresupuestosListados.ckEstadosChange(Sender: TObject);
begin
  if ckEstados.Checked then
  begin
    cbEstados.Enabled:= False;
    _idEstado:= _TODOS_LOS_ESTADOS_;
  end
  else
  begin
    cbEstados.Enabled:= true;
    _idEstado:= DM_General.obtenerIDIntComboBox(cbEstados);

  end;

end;

procedure TfrmPresupuestosListados.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo (Column);
end;

procedure TfrmPresupuestosListados.edClienteKeyPress(Sender: TObject;
  var Key: char);
begin
  if Key = #13 then
  begin
    if ( DM_BuscarCliente.BuscarClientePorCodigo(TRIM(edCliente.Text)))then
     begin
      _idCliente:=  DM_BuscarCliente.DevolverIdCliente;
      edCliente.Text:= DM_Clientes.ClienteNombre (_idCliente);
      ckClientes.Checked:= false;
      DM_Presupuestos.LevantarPresupuestos (_idCliente, _idEstado);
     end
     else
       btnBuscarClienteClick(Sender);
  end;
end;

procedure TfrmPresupuestosListados.btnBuscarClienteClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      edCliente.Text:= DM_Clientes.ClienteNombre (pantBusqueda.idCliente);
      _idCliente:= pantBusqueda.idCliente;
      ckClientes.Checked:= false;
    end;

  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmPresupuestosListados.btnFiltrarClick(Sender: TObject);
begin
   DM_Presupuestos.LevantarPresupuestos (_idCliente, _idEstado);
end;

procedure TfrmPresupuestosListados.btnPresupEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el presupuesto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Presupuestos.EliminarPresupuesto (DM_Presupuestos.idPresupuestoListadoActual);
    DM_Presupuestos.LevantarPresupuestos (_idCliente, _idEstado);
  end;
end;

procedure TfrmPresupuestosListados.btnPresupModificarClick(Sender: TObject);
var
  pant: TfrmPresupuestoAE;
begin
  pant:= TfrmPresupuestoAE.Create(self);
  try
    pant.idCliente:= _idCliente;
    pant.idPresupuesto:= DM_Presupuestos.idPresupuestoListadoActual;
    DM_Presupuestos.PresupuestoEditar (DM_Presupuestos.idPresupuestoListadoActual);
    if pant.ShowModal = mrOK then
    begin
      DM_Presupuestos.LevantarPresupuestos (_idCliente, _idEstado);
    end;
  finally
  end;
end;

procedure TfrmPresupuestosListados.btnPresupNuevoClick(Sender: TObject);
var
  pant: TfrmPresupuestoAE;
begin
  pant:= TfrmPresupuestoAE.Create(self);
  try
    pant.idCliente:= _idCliente;
    DM_Presupuestos.PresupuestoNuevo(_idCliente);
    if pant.ShowModal = mrOK then
    begin
      DM_Presupuestos.LevantarPresupuestos (_idCliente, _idEstado);
    end;
  finally
  end;
end;

procedure TfrmPresupuestosListados.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPresupuestosListados.FormShow(Sender: TObject);
begin
   DM_Presupuestos.LevantarPresupuestos (_idCliente, _idEstado);
end;

procedure TfrmPresupuestosListados.Inicializar;
begin
  edCliente.Clear;
  ckClientes.Checked:= true;
  ckEstados.Checked:= true;
  _idEstado:= _TODOS_LOS_ESTADOS_;
  _idCliente:= EmptyStr;
  DM_General.CargarComboBox(cbEstados, 'Estado', 'idPresupuestoEstado', DM_Presupuestos.qtugPresupuestosEstados);
end;

end.

