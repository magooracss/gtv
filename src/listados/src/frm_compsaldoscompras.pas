unit frm_compsaldoscompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  EditBtn, Buttons, DBGrids, StdCtrls
  ,dmgeneral
  ;

type

  { TfrmCompSaldosCompras }

  TfrmCompSaldosCompras = class(TForm)
    btnBuscarProveedor: TBitBtn;
    btnExportarExcel: TBitBtn;
    btnListado: TBitBtn;
    btnSalir: TBitBtn;
    ckProveedores: TCheckBox;
    ds_resultados: TDatasource;
    DBGrid1: TDBGrid;
    edBuscarProveedor: TEdit;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ckProveedoresChange(Sender: TObject);
    procedure edBuscarProveedorKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;

    _idProveedor: GUID_ID;

    procedure BuscarProveedor;
  public
    property rutaReporte: string write _rutaReporte;
    property tipoListado: integer write _tipoListado;
  end; 

var
  frmCompSaldosCompras: TfrmCompSaldosCompras;

implementation
{$R *.lfm}
uses
  dmproveedores
  ,frm_proveedoreslistado
  ,dmsaldoscompras
  ,dmseleccionlistado
  ;

{ TfrmCompSaldosCompras }

procedure TfrmCompSaldosCompras.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCompSaldosCompras.ckProveedoresChange(Sender: TObject);
begin
  if ckProveedores.Checked then
  begin
    _idProveedor:= GUIDNULO;
    edBuscarProveedor.Clear;
  end;
end;

procedure TfrmCompSaldosCompras.btnBuscarProveedorClick(Sender: TObject);
begin
  BuscarProveedor;
end;

procedure TfrmCompSaldosCompras.btnExportarExcelClick(Sender: TObject);
begin
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_SaldosCompras.tbResultados, SD.FileName, 'Comp Saldo');
end;

procedure TfrmCompSaldosCompras.btnListadoClick(Sender: TObject);
begin
  DM_SaldosCompras.Filtrar(_idProveedor);
end;

procedure TfrmCompSaldosCompras.edBuscarProveedorKeyPress(Sender: TObject;
  var Key: char);
begin
  BuscarProveedor;
end;

procedure TfrmCompSaldosCompras.FormCreate(Sender: TObject);
begin
  _idProveedor:= GUIDNULO;
  edBuscarProveedor.Clear;
end;

procedure TfrmCompSaldosCompras.BuscarProveedor;
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      _idProveedor:= pant.idProveedor;
      edBuscarProveedor.Text:= pant.RazonSocial;
      ckProveedores.Checked:= false;
    end;
  finally
    pant.Free;
  end;
end;

end.

