unit frm_subdiariopagos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids, EditBtn;

type

  { TfrmSubdiarioDePagos }

  TfrmSubdiarioDePagos = class(TForm)
    btnExportarExcel: TBitBtn;
    btnFiltrar: TBitBtn;
    btnSalir: TBitBtn;
    DBGrid1: TDBGrid;
    ds_subdiarioPagos: TDatasource;
    edFFin: TDateEdit;
    edFIni: TDateEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    procedure Inicializar;
  public
    property rutaReporte: string write _rutaReporte;
    property tipoListado: integer write _tipoListado;
  end; 

var
  frmSubdiarioDePagos: TfrmSubdiarioDePagos;

implementation
{$R *.lfm}
uses
   dateutils
  ,dmgrupocuentas
  ,dmgeneral
  ,dmseleccionlistado
  ;

{ TfrmSubdiarioDePagos }

{ TfrmSubdiarioDePagos }

procedure TfrmSubdiarioDePagos.btnFiltrarClick(Sender: TObject);
begin
  DM_GrupoCuentas.filtrarSubdiarioPagos (edFIni.Date, edFFin.Date);
end;

procedure TfrmSubdiarioDePagos.btnExportarExcelClick(Sender: TObject);
begin
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_GrupoCuentas.tbSubdiarioCompras, SD.FileName, 'SubdiarioPagos');
end;

procedure TfrmSubdiarioDePagos.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmSubdiarioDePagos.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmSubdiarioDePagos.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmSubdiarioDePagos.Inicializar;
begin
  edFIni.Date:= StartOfTheMonth(Now);
  edFFin.Date:= EndOfTheMonth(Now);
end;

end.

