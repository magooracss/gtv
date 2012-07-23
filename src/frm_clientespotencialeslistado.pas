unit frm_clientespotencialeslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmgeneral;

type

  { TfrmClientesPotencialesListado }

  TfrmClientesPotencialesListado = class(TForm)
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnNuevo: TBitBtn;
    btnSalir: TBitBtn;
    DS_Listado: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    { private declarations }
  public
    property idCliente: GUID_ID read _idCliente;
  end; 

var
  frmClientesPotencialesListado: TfrmClientesPotencialesListado;

implementation
{$R *.lfm}
uses
  dmclientespotenciales
  ,frm_clientespotencialesae
  ;

{ TfrmClientesPotencialesListado }

procedure TfrmClientesPotencialesListado.FormShow(Sender: TObject);
begin
  DM_ClientesPotenciales.ListadoClientes;
end;

procedure TfrmClientesPotencialesListado.btnSalirClick(Sender: TObject);
begin
  _idCliente:= DM_ClientesPotenciales.ClienteSeleccionadoListado;
  ModalResult:= mrOK;
end;

procedure TfrmClientesPotencialesListado.btnNuevoClick(Sender: TObject);
var
  pantalla: TfrmClientesPotencialesAE;
begin
  pantalla:= TfrmClientesPotencialesAE.Create(self);
  try
    DM_ClientesPotenciales.NuevoCliente;
    pantalla.ShowModal;
    DM_ClientesPotenciales.ListadoClientes;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmClientesPotencialesListado.btnModificarClick(Sender: TObject);
var
  pantalla: TfrmClientesPotencialesAE;
begin
  pantalla:= TfrmClientesPotencialesAE.Create(self);
  try
    DM_ClientesPotenciales.EditarCliente (DS_Listado.DataSet.FieldByName('idClientePotencial').asString);
    pantalla.ShowModal;
    DM_ClientesPotenciales.ListadoClientes;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmClientesPotencialesListado.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el cliente seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_ClientesPotenciales.EliminarClientePotencial (DM_ClientesPotenciales.ClientePotencialSeleccionado);
    DM_ClientesPotenciales.ListadoClientes;
  end;
end;

end.

