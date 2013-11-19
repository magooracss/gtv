unit frm_listadocheques;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, EditBtn;

type

  { TfrmListadoCheques }

  TfrmListadoCheques = class(TForm)
    btnExportarExcel: TBitBtn;
    btnListado: TBitBtn;
    btnSalir: TBitBtn;
    dsCheques: TDatasource;
    DBGrid1: TDBGrid;
    edFFin: TDateEdit;
    edFIni: TDateEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
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
  frmListadoCheques: TfrmListadoCheques;

implementation
{$R *.lfm}
uses
  dmseleccionlistado
  ,dmlistadocheques
 ;

{ TfrmListadoCheques }

procedure TfrmListadoCheques.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoCheques.FormShow(Sender: TObject);
begin
  edFIni.Date:= Now - 30;
  edFFin.Date:= Now;
end;

procedure TfrmListadoCheques.btnExportarExcelClick(Sender: TObject);
begin
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_ListadoCheques.tbResultados, SD.FileName, 'Listado de cheques');
end;

procedure TfrmListadoCheques.btnListadoClick(Sender: TObject);
begin
  DM_ListadoCheques.LevantarChequesOP(edFIni.Date, edFFin.Date);
end;

end.

