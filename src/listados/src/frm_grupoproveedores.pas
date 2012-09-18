unit frm_grupoproveedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids
  ,dmgeneral;

type

  { TfrmGrupoProveedores }

  TfrmGrupoProveedores = class(TForm)
    btnBuscarEmpresa: TBitBtn;
    btnExportarExcel: TBitBtn;
    btnFiltrar: TBitBtn;
    btnSalir: TBitBtn;
    ds_proveedores: TDatasource;
    DBGrid1: TDBGrid;
    edEmpresa: TEdit;
    GroupBox2: TGroupBox;
    GroupBox5: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    _refEmpresa: GUID_ID;
  public
     property rutaReporte: string write _rutaReporte;
     property tipoListado: integer write _tipoListado;

  end; 

var
  frmGrupoProveedores: TfrmGrupoProveedores;

implementation
{$R *.lfm}
uses
  dmgrupoproveedores
  ,dmseleccionlistado
  ,frm_proveedoreslistado
  ;


{ TfrmGrupoProveedores }

procedure TfrmGrupoProveedores.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmGrupoProveedores.btnExportarExcelClick(Sender: TObject);
begin
 if SD.Execute then
   DM_SeleccionListado.ExportarXLS(DM_GrupoProveedores.tbComposicionSaldo, SD.FileName, 'Comp Saldo');

end;

procedure TfrmGrupoProveedores.btnBuscarEmpresaClick(Sender: TObject);
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
         edEmpresa.Text:= pant.RazonSocial;
         _refEmpresa:= pant.idProveedor;
    end
    else
    begin
        edEmpresa.Text:= EmptyStr;
        _refEmpresa:= GUIDNULO;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmGrupoProveedores.btnFiltrarClick(Sender: TObject);
begin
  if _refEmpresa <> GUIDNULO then
     DM_GrupoProveedores.ComposicionSaldo (_refEmpresa)
  else
     ShowMessage('Debe seleccionarse un proveedor para generar el listado');
end;

end.

