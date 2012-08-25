unit frm_remitoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids
  ,dmgeneral;

type

  { TfrmRemitosListado }

  TfrmRemitosListado = class(TForm)
    btnBuscarCliente: TBitBtn;
    btnFiltrar: TBitBtn;
    btnOTEliminar: TBitBtn;
    btnOTModificar: TBitBtn;
    btnOTNueva: TBitBtn;
    btnSalir: TBitBtn;
    ckClientes: TCheckBox;
    ckRemitosPresentados: TCheckBox;
    ckRemitosSinCargo: TCheckBox;
    ckRemitosFacturados: TCheckBox;
    ds_ListaRemitos: TDatasource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    edNroRemito: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnOTEliminarClick(Sender: TObject);
    procedure btnOTModificarClick(Sender: TObject);
    procedure btnOTNuevaClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ckClientesChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edClienteKeyPress(Sender: TObject; var Key: char);
    procedure edNroRemitoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idOrdenTrabajo: GUID_ID;
    _idRemitoSeleccionado: GUID_ID;

  public
    property idCliente: GUID_ID write _idCliente;
    property idRemitoSeleccionado: GUID_ID read _idRemitoSeleccionado;
    property idOrdenTrabajo: GUID_ID write _idOrdenTrabajo;
  end; 

var
  frmRemitosListado: TfrmRemitosListado;

implementation
{$R *.lfm}
uses
  frm_busquedaclientes
 ,dmclientes
 ,dmremitos
 ,frm_remitosae
 ,dmbuscarcliente
;

{ TfrmRemitosListado }

procedure TfrmRemitosListado.btnSalirClick(Sender: TObject);
begin
  _idRemitoSeleccionado:= DM_Remitos.idRemitoListado;
  ModalResult:= mrOK;
end;

procedure TfrmRemitosListado.btnBuscarClienteClick(Sender: TObject);
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
      btnFiltrarClick(self);
    end;

  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmRemitosListado.btnFiltrarClick(Sender: TObject);
begin
   if ckClientes.Checked then
    DM_Remitos.LevantarRemitoCliente(GUIDNULO
                                    , ckRemitosSinCargo.Checked
                                    , ckRemitosFacturados.Checked
                                    , ckRemitosPresentados.Checked)
  else
    DM_Remitos.LevantarRemitoCliente(_idCliente
                                    , ckRemitosSinCargo.Checked
                                    , ckRemitosFacturados.Checked
                                    , ckRemitosPresentados.Checked);
end;

procedure TfrmRemitosListado.btnOTEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Remito seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Remitos.RemitoEliminar (DM_Remitos.idRemitoListado);
    DM_Remitos.LevantarRemitoCliente(_idCliente
                                    , ckRemitosSinCargo.Checked
                                    , ckRemitosFacturados.Checked
                                    , ckRemitosPresentados.Checked);
  end;
end;

procedure TfrmRemitosListado.btnOTModificarClick(Sender: TObject);
var
  pantalla: TfrmRemitosAE;
begin
  pantalla:= TfrmRemitosAE.Create (self);
  try
    DM_Remitos.RemitoEditar (DM_Remitos.idRemitoListado);
    pantalla.idCliente:= ds_ListaRemitos.DataSet.FieldByName('refCliente').asString;
    if pantalla.ShowModal = mrOK then
    begin
      btnFiltrarClick(sender);
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmRemitosListado.btnOTNuevaClick(Sender: TObject);
var
  pantalla: TfrmRemitosAE;
begin
  pantalla:= TfrmRemitosAE.Create (self);
  try
    DM_Remitos.RemitoNuevo (_idCliente);
    pantalla.idCliente:= _idCliente;
    pantalla.idOrdenTrabajo:= _idOrdenTrabajo;
    if pantalla.ShowModal = mrOK then
    begin
      btnFiltrarClick(sender);
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmRemitosListado.ckClientesChange(Sender: TObject);
begin
  if ckClientes.Checked then
    DM_Remitos.LevantarRemitoCliente(GUIDNULO
                                    , ckRemitosSinCargo.Checked
                                    , ckRemitosFacturados.Checked
                                    , ckRemitosPresentados.Checked);
end;

procedure TfrmRemitosListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmRemitosListado.edClienteKeyPress(Sender: TObject; var Key: char);
begin
   if Key = #13 then
  begin
    if ( DM_BuscarCliente.BuscarClientePorNombre(TRIM(edCliente.Text)))then
     begin
      _idCliente:=  DM_BuscarCliente.DevolverIdCliente;
      edCliente.Text:= DM_Clientes.ClienteNombre (_idCliente);
      ckClientes.Checked:= false;
      btnFiltrarClick(self);
     end
     else
       btnBuscarClienteClick(Sender);
  end;
end;

procedure TfrmRemitosListado.edNroRemitoKeyPress(Sender: TObject; var Key: char
  );
var
  nroRemito: integer;
begin
  if key = #13 then
  begin
    nroRemito:= StrToIntDef(TRIM(edNroRemito.Text), 0);
    edNroRemito.Text:= InttoStr(nroRemito);
    DM_Remitos.BuscarPorNroRemito (nroRemito);
  end;
end;

procedure TfrmRemitosListado.FormCreate(Sender: TObject);
begin
  _idCliente:= GUIDNULO;
  _idRemitoSeleccionado:= GUIDNULO;
  _idOrdenTrabajo:= GUIDNULO;
end;

procedure TfrmRemitosListado.FormShow(Sender: TObject);
begin
  ckClientes.Checked:= (_idCliente = GUIDNULO);
  DM_Remitos.LevantarRemitoCliente(_idCliente
                                  , False
                                  , False
                                  , False);
  ckRemitosSinCargo.Checked:= false;
  ckRemitosFacturados.Checked:= false;
  ckRemitosPresentados.Checked:= false;
  edCliente.Text:= DM_Clientes.ClienteNombre(_idCliente);
end;

end.

