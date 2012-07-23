unit frm_conservadorae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons
  ,dmgeneral;

type

  { TfrmConservadorAE }

  TfrmConservadorAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DS_Conservador: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _Operacion: TOperacion;
    { private declarations }
  public
    property Operacion: TOperacion write _Operacion;
  end; 

var
  frmConservadorAE: TfrmConservadorAE;

implementation
{$R *.lfm}
uses
  dmclientes
  ;

{ TfrmConservadorAE }

procedure TfrmConservadorAE.FormShow(Sender: TObject);
begin
  case _Operacion of
    nuevo:
      DM_Clientes.tbConservadores.Insert;
    modificar:
      DM_Clientes.tbConservadores.Edit;
  end;
end;

procedure TfrmConservadorAE.btnAceptarClick(Sender: TObject);
begin
  DM_Clientes.GrabarConservadores;
  ModalResult:= mrOK;
end;

procedure TfrmConservadorAE.btnCancelarClick(Sender: TObject);
begin
  DM_Clientes.tbConservadores.Cancel;
  ModalResult:= mrCancel;
end;

end.

