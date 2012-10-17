unit frm_localidadae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons;

type

  { TfrmLocalidadAE }

  TfrmLocalidadAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DS_Localidades: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmLocalidadAE: TfrmLocalidadAE;

implementation

{$R *.lfm}

{ TfrmLocalidadAE }

procedure TfrmLocalidadAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmLocalidadAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

