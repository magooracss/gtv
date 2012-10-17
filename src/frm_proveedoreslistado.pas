unit frm_proveedoreslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, StdCtrls
  ,dmgeneral;

type

  { TfrmProveedoresListado }

  TfrmProveedoresListado = class(TForm)
    btnSalir: TBitBtn;
    btnNuevo: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    ds_ListaProveedores: TDatasource;
    DBGrid1: TDBGrid;
    edBusRazonSocial: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edBusRazonSocialKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    _idProveedor: GUID_ID;
    _RazonSocial: string;
    procedure Inicializar;
  public
    property idProveedor: GUID_ID read _idProveedor;
    property RazonSocial: string read _RazonSocial;
  end; 

var
  frmProveedoresListado: TfrmProveedoresListado;

implementation
{$R *.lfm}
uses
  dmproveedores
  ,frm_proveedoresae
  ;

{ TfrmProveedoresListado }

procedure TfrmProveedoresListado.btnSalirClick(Sender: TObject);
begin
  if DM_Proveedores.qListaProveedores.RecordCount > 0 then
  begin
    _idProveedor:= DM_Proveedores.qListaProveedores.FieldByName('idProveedor').asString;
    _RazonSocial:= DM_Proveedores.qListaProveedores.FieldByName('cRazonSocial').asString;
  end;
  ModalResult:= mrOK;
end;

procedure TfrmProveedoresListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmProveedoresListado.edBusRazonSocialKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
     DM_Proveedores.FiltrarRazonSocial(edBusRazonSocial.Text);
end;

procedure TfrmProveedoresListado.btnNuevoClick(Sender: TObject);
var
  pant: TfrmProveedorAE;
begin
  pant:= TfrmProveedorAE.Create (self);
  try
    DM_Proveedores.NuevoProveedor;
    if pant.ShowModal = mrOK then
      DM_Proveedores.LevantarProveedores;
  finally
    pant.Free;
  end;
end;

procedure TfrmProveedoresListado.btnModificarClick(Sender: TObject);
var
  pant: TfrmProveedorAE;
begin
  pant:= TfrmProveedorAE.Create (self);
  try
    DM_Proveedores.EditarProveedorLista;
    if pant.ShowModal = mrOK then
      DM_Proveedores.LevantarProveedores;
  finally
    pant.Free;
  end;
end;

procedure TfrmProveedoresListado.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Proveedor seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Proveedores.EliminarProveedorLista;
    DM_Proveedores.LevantarProveedores;
  end;
end;

procedure TfrmProveedoresListado.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmProveedoresListado.Inicializar;
begin
  DM_Proveedores.LevantarProveedores;
end;

end.

