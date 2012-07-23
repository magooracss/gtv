unit frm_resptecnicoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  ExtCtrls, Buttons
  ,dmgeneral;

type

  { TfrmResponsablesTecnicosListado }

  TfrmResponsablesTecnicosListado = class(TForm)
    btnRespTecnicoEliminar: TBitBtn;
    btnRespTecnicoModificar: TBitBtn;
    btnRespTecnicoNuevo: TBitBtn;
    btnSalir: TBitBtn;
    DS_ResponsablesTecnicos: TDatasource;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    procedure btnRespTecnicoEliminarClick(Sender: TObject);
    procedure btnRespTecnicoModificarClick(Sender: TObject);
    procedure btnRespTecnicoNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmResponsablesTecnicosListado: TfrmResponsablesTecnicosListado;

implementation
{$R *.lfm}
uses
  frm_resptecnicoae
  ,dmclientes
  ;

{ TfrmResponsablesTecnicosListado }

procedure TfrmResponsablesTecnicosListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmResponsablesTecnicosListado.FormShow(Sender: TObject);
begin
  DM_Clientes.LevantarResponstablesTecnicos;
end;

procedure TfrmResponsablesTecnicosListado.btnRespTecnicoNuevoClick(
  Sender: TObject);
var
  pant: TfrmResponsableTecnicoAE;
begin
  pant:= TfrmResponsableTecnicoAE.Create(self);
  try
    pant.operacion:= nuevo;
    if pant.ShowModal = mrOK then
     DM_Clientes.LevantarResponstablesTecnicos;
  finally
    pant.Free;
  end;

end;

procedure TfrmResponsablesTecnicosListado.btnRespTecnicoModificarClick(
  Sender: TObject);
var
  pant: TfrmResponsableTecnicoAE;
begin
  pant:= TfrmResponsableTecnicoAE.Create(self);
  try
    pant.operacion:= modificar;
    if pant.ShowModal = mrOK then
     DM_Clientes.LevantarResponstablesTecnicos;
  finally
    pant.Free;
  end;
end;

procedure TfrmResponsablesTecnicosListado.btnRespTecnicoEliminarClick(
  Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Responsable Tecnico seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Clientes.eliminarResponstableTecnico;
  end;
end;

end.

