unit frm_subdiariocompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  EditBtn, StdCtrls, Buttons, DBGrids;

type

  { TfrmSubdiarioCompras }

  TfrmSubdiarioCompras = class(TForm)
    btnExportarExcel: TBitBtn;
    btnFiltrar: TBitBtn;
    btnListado: TBitBtn;
    btnSalir: TBitBtn;
    ds_SubdiarioCompras: TDatasource;
    DBGrid1: TDBGrid;
    edFIni: TDateEdit;
    edFFin: TDateEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
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
  , dmseleccionlistado;

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
  DM_GrupoCuentas.filtrarSubdiarioCompras(edFIni.Date, edFFin.Date);
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
