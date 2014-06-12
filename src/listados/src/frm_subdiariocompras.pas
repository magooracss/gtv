unit frm_subdiariocompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  EditBtn, StdCtrls, Buttons, DBGrids;

type

  { TfrmSubdiarioCompras }

  TfrmSubdiarioCompras = class(TForm)
    btnBuscar: TBitBtn;
    btnExportarExcel: TBitBtn;
    btnFiltrar: TBitBtn;
    btnListado: TBitBtn;
    btnSalir: TBitBtn;
    ckProveedores: TCheckBox;
    ds_SubdiarioCompras: TDatasource;
    DBGrid1: TDBGrid;
    edFIni: TDateEdit;
    edFFin: TDateEdit;
    edProveedor: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    _idProveedor: string;
    procedure Inicializar;
  public
    property rutaReporte: string Write _rutaReporte;
    property tipoListado: integer Write _tipoListado;
  end;

var
  frmSubdiarioCompras: TfrmSubdiarioCompras;

implementation

{$R *.lfm}
uses
  dateutils
  , dmgrupocuentas
  , dmgeneral
  , dmseleccionlistado
  , frm_proveedoreslistado;

{ TfrmSubdiarioCompras }

procedure TfrmSubdiarioCompras.btnSalirClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmSubdiarioCompras.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmSubdiarioCompras.btnFiltrarClick(Sender: TObject);
begin
  if ckProveedores.Checked then
  begin
    _idProveedor:= GUIDNULO;
    edProveedor.Clear;
  end;
  DM_GrupoCuentas.filtrarSubdiarioCompras(edFIni.Date, edFFin.Date, _idProveedor);
end;

procedure TfrmSubdiarioCompras.btnListadoClick(Sender: TObject);
begin
  DM_General.LevantarReporte(_rutaReporte, ds_SubdiarioCompras.DataSet);
  DM_General.AgregarVariableReporte('Periodo', DateToStr(edFIni.Date) + ' - ' + DateToStr(edFFin.Date));
  DM_General.EjecutarReporte;
end;

procedure TfrmSubdiarioCompras.btnExportarExcelClick(Sender: TObject);
begin
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_GrupoCuentas.tbSubdiarioCompras,
      SD.FileName, 'SubdiarioCompras');
end;

procedure TfrmSubdiarioCompras.btnBuscarClick(Sender: TObject);
var
  pant: TfrmProveedoresListado;
begin
  _idProveedor:= GUIDNULO;
  pant:= TfrmProveedoresListado.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      _idProveedor:= pant.idProveedor;
      edProveedor.Text:= pant.RazonSocial;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmSubdiarioCompras.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmSubdiarioCompras.Inicializar;
begin
  edFIni.Date := StartOfTheMonth(Now);
  edFFin.Date := EndOfTheMonth(Now);
end;

end.

