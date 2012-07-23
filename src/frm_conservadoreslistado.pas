unit frm_conservadoreslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids
  ,dmgeneral;

type

  { TFrmConservadoresListado }

  TFrmConservadoresListado = class(TForm)
    btnConservadorEliminar: TBitBtn;
    btnConservadorModificar: TBitBtn;
    btnConservadorNuevo: TBitBtn;
    btnSalir: TBitBtn;
    DS_Conservadores: TDatasource;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    procedure btnConservadorNuevoClick(Sender: TObject);
    procedure btnConservadorModificarClick(Sender: TObject);
    procedure btnConservadorEliminarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LevantarConservadores;
  public
    { public declarations }
  end; 

var
  FrmConservadoresListado: TFrmConservadoresListado;

implementation
{$R *.lfm}
uses
  dmclientes
  ,frm_conservadorae
  ;

{ TFrmConservadoresListado }

procedure TFrmConservadoresListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TFrmConservadoresListado.FormShow(Sender: TObject);
begin
  LevantarConservadores;
end;

procedure TFrmConservadoresListado.LevantarConservadores;
begin
  DM_Clientes.levantarConservadores;
end;

procedure TFrmConservadoresListado.btnConservadorNuevoClick(Sender: TObject);
var
  pant: TfrmConservadorAE;
begin
  pant:= TfrmConservadorAE.Create(self);
  try
    pant.Operacion:= nuevo;
    pant.ShowModal;
    LevantarConservadores;
  finally
    pant.Free;
  end;
end;

procedure TFrmConservadoresListado.btnConservadorModificarClick(Sender: TObject);
var
  pant: TfrmConservadorAE;
begin
  pant:= TfrmConservadorAE.Create(self);
  try
    pant.Operacion:= modificar;
    pant.ShowModal;
    LevantarConservadores;
  finally
    pant.Free;
  end;
end;

procedure TFrmConservadoresListado.btnConservadorEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Conservador seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Clientes.eliminarConservadorActual;
  end;

end;

end.

