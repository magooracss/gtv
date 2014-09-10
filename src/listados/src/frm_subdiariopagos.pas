unit frm_subdiariopagos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids, EditBtn, StdCtrls;

type

  { TfrmSubdiarioDePagos }

  TfrmSubdiarioDePagos = class(TForm)
    btnBuscar: TBitBtn;
    btnListado: TBitBtn;
    btnExportarExcel: TBitBtn;
    btnFiltrar: TBitBtn;
    btnSalir: TBitBtn;
    ckTodosLosProveedores: TCheckBox;
    DBGrid1: TDBGrid;
    ds_subdiarioPagos: TDatasource;
    edFFin: TDateEdit;
    edFIni: TDateEdit;
    edProveedor: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    _idProveedor: string;
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
   ,frm_proveedoreslistado

  ;

{ TfrmSubdiarioDePagos }

procedure TfrmSubdiarioDePagos.btnFiltrarClick(Sender: TObject);
begin
  if ckTodosLosProveedores.Checked then
    _idProveedor:= GUIDNULO;
  DM_GrupoCuentas.filtrarSubdiarioPagos (edFIni.Date, edFFin.Date, _idProveedor);
end;

procedure TfrmSubdiarioDePagos.btnExportarExcelClick(Sender: TObject);
begin
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_GrupoCuentas.tbSubdiarioPagos, SD.FileName, 'SubdiarioPagos');
end;

procedure TfrmSubdiarioDePagos.btnListadoClick(Sender: TObject);
begin
  DM_General.LevantarReporte(_rutaReporte,ds_subdiarioPagos.DataSet);
  DM_General.AgregarVariableReporte('Periodo', DateToStr(edFIni.Date) + ' - ' + DateToStr(edFFin.Date));
  DM_General.EjecutarReporte;
end;

procedure TfrmSubdiarioDePagos.btnBuscarClick(Sender: TObject);
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
      ckTodosLosProveedores.Checked:= false;
    end;
  finally
    pant.Free;
  end;
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
   _idProveedor:= GUIDNULO;
end;

end.

