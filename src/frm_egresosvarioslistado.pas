unit frm_egresosvarioslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmgeneral
  ;

type

  { TfrmEgresosVariosListado }

  TfrmEgresosVariosListado = class(TForm)
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnNuevo: TBitBtn;
    btnSalir: TBitBtn;
    DS_EgresosVarios: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    function getIdEgresoSeleccionado: GUID_ID;
    procedure PantallaEgresoVario (refEgreso: GUID_ID);

  public
    property idEgresoSeleccionado: GUID_ID read getIdEgresoSeleccionado;

  end; 

var
  frmEgresosVariosListado: TfrmEgresosVariosListado;

implementation
{$R *.lfm}
uses
  dmegresosvarios
  ,frm_egresosvariosae
  ;

{ TfrmEgresosVariosListado }

procedure TfrmEgresosVariosListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmEgresosVariosListado.FormShow(Sender: TObject);
begin
  DM_EgresosVarios.LevantarEgresos;
end;

function TfrmEgresosVariosListado.getIdEgresoSeleccionado: GUID_ID;
begin
  Result:= DM_EgresosVarios.idEgresoSeleccionado;
end;

procedure TfrmEgresosVariosListado.PantallaEgresoVario(refEgreso: GUID_ID);
var
  pant: TfrmEgresoVarioAE;
begin
  pant:= TfrmEgresoVarioAE.Create (self);
  try
    pant.idEgresoVario := refEgreso;
    if pant.ShowModal = mrOK then
    begin
      DM_EgresosVarios.LevantarEgresos;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmEgresosVariosListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmEgresosVariosListado.btnNuevoClick(Sender: TObject);
begin
  PantallaEgresoVario(GUIDNULO);
end;

procedure TfrmEgresosVariosListado.btnModificarClick(Sender: TObject);
begin
  PantallaEgresoVario(DM_EgresosVarios.idEgreso);
end;

procedure TfrmEgresosVariosListado.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino el valor seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_EgresosVarios.EliminarEgreso;
    DM_EgresosVarios.LevantarEgresos;
  end;
end;

end.

