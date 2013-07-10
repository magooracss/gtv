unit frm_saldocompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids, EditBtn, StdCtrls;

type

  { TfrmSaldoCompras }

  TfrmSaldoCompras = class(TForm)
    btnExportarExcel: TBitBtn;
    btnFiltrar: TBitBtn;
    btnListado: TBitBtn;
    btnSalir: TBitBtn;
    DS_SaldoProveedores: TDatasource;
    edFecha: TDateEdit;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    edSaldoTotal: TStaticText;
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    { private declarations }
  public
     property rutaReporte: string write _rutaReporte;
     property tipoListado: integer write _tipoListado;
  end;

var
  frmSaldoCompras: TfrmSaldoCompras;

implementation
{$R *.lfm}
uses
  dmproveedorcc
  ,dmgeneral
  ,dmseleccionlistado
  ;

{ TfrmSaldoCompras }

procedure TfrmSaldoCompras.FormShow(Sender: TObject);
begin
  edFecha.Date:=Now;
end;

procedure TfrmSaldoCompras.btnFiltrarClick(Sender: TObject);
begin
  DM_ProveedorCC.ListadoSaldos(edFecha.Date);
  edSaldoTotal.Caption:= FormatFloat('$ #########0.00', DM_ProveedorCC.SaldoTotal);
end;

procedure TfrmSaldoCompras.btnListadoClick(Sender: TObject);
begin
  DM_General.LevantarReporte(_rutaReporte, DS_SaldoProveedores.DataSet);
  DM_General.AgregarVariableReporte('Titulo', 'Saldo de compras al ' + DateToStr(edFecha.Date));
  DM_General.AgregarVariableReporte('SaldoTotal', FormatFloat('$ #########0.00', DM_ProveedorCC.SaldoTotal));

  DM_General.EjecutarReporte;
end;

procedure TfrmSaldoCompras.btnExportarExcelClick(Sender: TObject);
var
  nombreHoja: string;
begin
  nombreHoja:= 'Saldo al ' + DateToStr(edFecha.Date);
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_ProveedorCC.tbSaldosProveedores, SD.FileName, nombreHoja);
end;

procedure TfrmSaldoCompras.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmSaldoCompras.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;


end.

