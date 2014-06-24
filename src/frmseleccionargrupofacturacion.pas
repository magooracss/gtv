unit frmseleccionargrupofacturacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TfrmSeleccionGrupoFacturacion }

  TfrmSeleccionGrupoFacturacion = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbGrupoFacturacion: TComboBox;
    Label1: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function getGrupoFacturacion: Integer;
    procedure Inicializar;
  public
    property GrupoSeleccionado: Integer read getGrupoFacturacion;
  end;

var
  frmSeleccionGrupoFacturacion: TfrmSeleccionGrupoFacturacion;

implementation
{$R *.lfm}
uses
   dmgeneral
  ,dmfacturas
  ;

{ TfrmSeleccionGrupoFacturacion }

procedure TfrmSeleccionGrupoFacturacion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmSeleccionGrupoFacturacion.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmSeleccionGrupoFacturacion.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmSeleccionGrupoFacturacion.getGrupoFacturacion: Integer;
begin
  Result:= DM_General.obtenerIDIntComboBox(cbGrupoFacturacion);
end;

procedure TfrmSeleccionGrupoFacturacion.Inicializar;
begin
  DM_General.CargarComboBox(cbGrupoFacturacion, 'GrupoFacturacion', 'idGrupoFacturacion', DM_Facturas.qGrupoFacturacion);
end;

end.

