unit frm_proveedorcuentacorriente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, Buttons, EditBtn, dmgeneral, db;

type

  { TfrmProveedorCuentaCorriente }

  TfrmProveedorCuentaCorriente = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnExportarExcel: TBitBtn;
    btnSalir: TBitBtn;
    ds_CC: TDatasource;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    DBGrid1: TDBGrid;
    edProveedor: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edSaldo: TLabeledEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure edProveedorKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    _idProveedor: GUID_ID;

    procedure BuscarProveedor;
    procedure LevantarSaldo;
  public
     property rutaReporte: string write _rutaReporte;
     property tipoListado: integer write _tipoListado;
  end; 

var
  frmProveedorCuentaCorriente: TfrmProveedorCuentaCorriente;

implementation
{$R *.lfm}
uses
  frm_proveedoreslistado
  ,dateutils
  ,dmproveedorcc
  ,dmseleccionlistado
  ;

{ TfrmProveedorCuentaCorriente }

procedure TfrmProveedorCuentaCorriente.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;



procedure TfrmProveedorCuentaCorriente.BitBtn1Click(Sender: TObject);
begin
  BuscarProveedor;
end;

procedure TfrmProveedorCuentaCorriente.BitBtn2Click(Sender: TObject);
begin

  DM_ProveedorCC.idProveedor:= _idProveedor;
  DM_ProveedorCC.fechaIni:= edFechaIni.Date;
  DM_ProveedorCC.fechaFin:= edFechaFin.Date;

  DM_ProveedorCC.FiltrarPagos;
end;

procedure TfrmProveedorCuentaCorriente.btnExportarExcelClick(Sender: TObject);
var
  nombreHoja: string;
begin
  nombreHoja:= 'CC ' + Copy(TRIM(edProveedor.Text),1, 20); //Esto es por la limitación en el nombre de la hoja
  if SD.Execute then
    DM_SeleccionListado.ExportarXLS(DM_ProveedorCC.tbResultados, SD.FileName, nombreHoja);
end;

procedure TfrmProveedorCuentaCorriente.edProveedorKeyPress(Sender: TObject;
  var Key: char);
begin
  BuscarProveedor;
end;

procedure TfrmProveedorCuentaCorriente.FormCreate(Sender: TObject);
begin
  edProveedor.Clear;
  edSaldo.Clear;
  edFechaIni.Date:= StartOfTheMonth(Now);
  edFechaFin.Date:= EndOfTheMonth(Now);
end;

procedure TfrmProveedorCuentaCorriente.BuscarProveedor;
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      _idProveedor:= pant.idProveedor;
      edProveedor.Text:= pant.RazonSocial;
      LevantarSaldo;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmProveedorCuentaCorriente.LevantarSaldo;
var
  saldo: double;
begin

  DM_ProveedorCC.idProveedor:= _idProveedor;
  DM_ProveedorCC.fechaIni:= edFechaIni.Date;
  DM_ProveedorCC.fechaFin:= edFechaFin.Date;


  saldo:= DM_ProveedorCC.SaldoProveedor;
  if (saldo >= 0) then
     edSaldo.Font.Color:= clBlack
  else
     edSaldo.Font.Color:= clRed;
  edSaldo.Text:= FormatFloat('$ ##########0.00',saldo );

end;

end.

