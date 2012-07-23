unit frm_ordenestrabajolistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons
  ,dmgeneral
  ;

type

  { TfrmOrdenesTrabajoListado }

  TfrmOrdenesTrabajoListado = class(TForm)
    btnBuscarCliente: TBitBtn;
    btnFiltrar: TBitBtn;
    btnOTEliminar: TBitBtn;
    btnOTModificar: TBitBtn;
    btnOTNueva: TBitBtn;
    btnSalir: TBitBtn;
    ckOTCumplidas: TCheckBox;
    ckClientes: TCheckBox;
    DS_OrdenesTrabajo: TDatasource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    Label1: TLabel;
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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idOrdenTrabajoSeleccionada: GUID_ID;
  public
    property idCliente: GUID_ID write _idCliente;
    property idOrdenTrabajoSeleccionada: GUID_ID read _idOrdenTrabajoSeleccionada;
  end; 

var
  frmOrdenesTrabajoListado: TfrmOrdenesTrabajoListado;

implementation
{$R *.lfm}
uses
  frm_busquedaclientes
  ,dmclientes
  ,dmordenestrabajo
  ,frm_ordentrabajoae
  ,dmbuscarcliente
  ;

{ TfrmOrdenesTrabajoListado }

procedure TfrmOrdenesTrabajoListado.btnSalirClick(Sender: TObject);
begin
  _idOrdenTrabajoSeleccionada:= DM_OrdenesTrabajo.idOrdenTrabajoListado;
  ModalResult:= mrOK;
end;

procedure TfrmOrdenesTrabajoListado.ckClientesChange(Sender: TObject);
begin
  if ckClientes.Checked then
   DM_OrdenesTrabajo.LevantarOTCliente(GUIDNULO, ckOTCumplidas.Checked);
end;

procedure TfrmOrdenesTrabajoListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmOrdenesTrabajoListado.edClienteKeyPress(Sender: TObject;
  var Key: char);
begin
  if Key = #13 then
  begin
    if ( DM_BuscarCliente.BuscarClientePorCodigo(TRIM(edCliente.Text)))then
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

procedure TfrmOrdenesTrabajoListado.FormCreate(Sender: TObject);
begin
  _idCliente:= GUIDNULO;
  _idOrdenTrabajoSeleccionada:= GUIDNULO;
end;

procedure TfrmOrdenesTrabajoListado.FormShow(Sender: TObject);
begin
  DM_OrdenesTrabajo.LevantarOTCliente (_idCliente, ckOTCumplidas.Checked);
  edCliente.Text:= DM_Clientes.ClienteNombre(_idCliente);
end;

procedure TfrmOrdenesTrabajoListado.Panel3Click(Sender: TObject);
begin

end;


procedure TfrmOrdenesTrabajoListado.btnBuscarClienteClick(Sender: TObject);
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

procedure TfrmOrdenesTrabajoListado.btnFiltrarClick(Sender: TObject);
begin
  if ckClientes.Checked then
  begin
    DM_OrdenesTrabajo.LevantarOTCliente(GUIDNULO, ckOTCumplidas.Checked);
    edCliente.Clear;
  end
  else
    DM_OrdenesTrabajo.LevantarOTCliente(_idCliente, ckOTCumplidas.Checked)
end;

procedure TfrmOrdenesTrabajoListado.btnOTEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro la orden de trabajo seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_OrdenesTrabajo.OrdenTrabajoEliminar (DM_OrdenesTrabajo.idOrdenTrabajoListado);
    DM_OrdenesTrabajo.LevantarOTCliente (_idCliente, ckOTCumplidas.Checked);
  end;
end;

procedure TfrmOrdenesTrabajoListado.btnOTModificarClick(Sender: TObject);
var
  pantalla: TfrmOrdenTrabajoAE;
begin
  pantalla:= TfrmOrdenTrabajoAE.Create (self);
  try
    DM_OrdenesTrabajo.OrdenTrabajoEditar (DM_OrdenesTrabajo.idOrdenTrabajoListado);
    pantalla.idCliente:= DS_OrdenesTrabajo.DataSet.FieldByName('refCliente').asString;
    if pantalla.ShowModal = mrOK then
    begin
      btnFiltrarClick(sender);
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmOrdenesTrabajoListado.btnOTNuevaClick(Sender: TObject);
var
  pantalla: TfrmOrdenTrabajoAE;
begin
  pantalla:= TfrmOrdenTrabajoAE.Create (self);
  try
   if (MessageDlg ('ATENCION', 'La orden de trabajo la cargo a nombre de '+ TRIM(edCliente.Text) + '?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
     _idCliente:= DS_OrdenesTrabajo.DataSet.FieldByName('refCliente').asString
   else
     _idCliente:= GUIDNULO;

    DM_OrdenesTrabajo.OrdenTrabajoNueva (_idCliente);
    pantalla.idCliente:= _idCliente;
    if pantalla.ShowModal = mrOK then
    begin
      btnFiltrarClick(sender);
    end;
  finally
    pantalla.free
  end;
end;

end.

