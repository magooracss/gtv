unit frm_grupoprovpendientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  ExtCtrls, Buttons
  ,dmgeneral;

type

  { TfrmGrupoProveedoresPendientes }

  TfrmGrupoProveedoresPendientes = class(TForm)
    btnExportarExcel: TBitBtn;
    btnSalir: TBitBtn;
    DBGrid1: TDBGrid;
    ds_proveedores: TDatasource;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;

    procedure LevantarPendientes;
  public
     property rutaReporte: string write _rutaReporte;
     property tipoListado: integer write _tipoListado;
  end; 

var
  frmGrupoProveedoresPendientes: TfrmGrupoProveedoresPendientes;

implementation
{$R *.lfm}
uses
  dmgrupoproveedores
  ,dmseleccionlistado
  ;

{ TfrmGrupoProveedoresPendientes }

procedure TfrmGrupoProveedoresPendientes.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmGrupoProveedoresPendientes.FormShow(Sender: TObject);
begin
  LevantarPendientes;
end;

procedure TfrmGrupoProveedoresPendientes.LevantarPendientes;
begin
  DM_GrupoProveedores.Pendientes;
end;

procedure TfrmGrupoProveedoresPendientes.btnExportarExcelClick(Sender: TObject);
begin
   if SD.Execute then
      DM_SeleccionListado.ExportarXLS(DM_GrupoProveedores.tbComposicionSaldo, SD.FileName, 'Pendientes');
end;

end.

