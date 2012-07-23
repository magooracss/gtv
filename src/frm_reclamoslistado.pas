unit frm_reclamoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DBGrids
  ,dmgeneral;

type

  { TfrmReclamosListado }

  TfrmReclamosListado = class(TForm)
    btnBuscarCliente: TBitBtn;
    btnFiltrar: TBitBtn;
    btnReclamoEliminar: TBitBtn;
    btnReclamoModificar: TBitBtn;
    btnOTNueva: TBitBtn;
    btnSalir: TBitBtn;
    ckClientes: TCheckBox;
    ckReclamosAtendidos: TCheckBox;
    DS_Grilla: TDatasource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnReclamoEliminarClick(Sender: TObject);
    procedure btnReclamoModificarClick(Sender: TObject);
    procedure btnOTNuevaClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ckClientesChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edClienteKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idReclamo: GUID_ID;
  public
    property idCliente: GUID_ID write _idCliente;
    property idReclamo: GUID_ID read _idReclamo;
  end; 

var
  frmReclamosListado: TfrmReclamosListado;

implementation
{$R *.lfm}
uses
  frm_reclamosam
  ,dmreclamos
  ,frm_busquedaclientes
  ,dmclientes
  ,dmbuscarcliente
  ;

{ TfrmReclamosListado }

procedure TfrmReclamosListado.btnOTNuevaClick(Sender: TObject);
var
  pant: TfrmReclamosAM;
begin
  pant:= TfrmReclamosAM.Create(self);
  try
    pant.idCliente:= _idCliente;
    dm_reclamos.ReclamoNuevo (_idCliente);
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmReclamosListado.btnBuscarClienteClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      ckClientes.Checked:= false;
      edCliente.Text:= DM_Clientes.ClienteNombre (pantBusqueda.idCliente);
      _idCliente:= pantBusqueda.idCliente;
    end;

  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmReclamosListado.btnFiltrarClick(Sender: TObject);
begin
  if ckClientes.Checked then
  begin
    dm_reclamos.LevantarReclamosCliente(GUIDNULO, ckReclamosAtendidos.Checked);
    edCliente.Clear;
  end
  else
  begin
    if _idCliente = GUIDNULO then
      ShowMessage('No hay un cliente seleccionado')
    else
      dm_reclamos.LevantarReclamosCliente(_idCliente, ckReclamosAtendidos.Checked);
  end;
end;

procedure TfrmReclamosListado.btnReclamoEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el reclamo eleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    dm_reclamos.ReclamoEliminar (dm_reclamos.idReclamoListado);
    dm_reclamos.LevantarReclamosCliente (_idCliente, ckReclamosAtendidos.Checked);
  end;

end;

procedure TfrmReclamosListado.btnReclamoModificarClick(Sender: TObject);
var
  pantalla: TfrmReclamosAM;
begin
  pantalla:= TfrmReclamosAM.Create (self);
  try
    dm_reclamos.ReclamoEditar (dm_reclamos.idReclamoListado);
    pantalla.idCliente:= DS_Grilla.DataSet.FieldByName('refCliente').asString;
    if pantalla.ShowModal = mrOK then
    begin
      btnFiltrarClick(sender);
    end;
  finally
    pantalla.free
  end;
end;

procedure TfrmReclamosListado.btnSalirClick(Sender: TObject);
begin
  _idReclamo:= dm_reclamos.idReclamoListado;
  ModalResult:= mrOK;
end;

procedure TfrmReclamosListado.ckClientesChange(Sender: TObject);
begin
   if ckClientes.Checked then
     _idCliente:= GUIDNULO;
end;

procedure TfrmReclamosListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmReclamosListado.edClienteKeyPress(Sender: TObject; var Key: char);
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

procedure TfrmReclamosListado.FormShow(Sender: TObject);
begin
  edCliente.Clear;
  ckClientes.Checked:= true;
  ckReclamosAtendidos.Checked:= false;
  dm_reclamos.LevantarReclamosCliente(GUIDNULO, false);
  edCliente.Clear;
end;

end.

