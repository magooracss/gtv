unit frm_ingresoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons;

type

  { TfrmIngresosListado }

  TfrmIngresosListado = class(TForm)
    btnSalir: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure btnSalirClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmIngresosListado: TfrmIngresosListado;

implementation

{$R *.lfm}

{ TfrmIngresosListado }

procedure TfrmIngresosListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

