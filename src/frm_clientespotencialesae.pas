unit frm_clientespotencialesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DbCtrls, StdCtrls
  ,dmclientespotenciales
  ;

type

  { TfrmClientesPotencialesAE }

  TfrmClientesPotencialesAE = class(TForm)
    btnGrabar: TBitBtn;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBMemo1: TDBMemo;
    DS_ClientePotencial: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    procedure btnGrabarClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmClientesPotencialesAE: TfrmClientesPotencialesAE;

implementation

{$R *.lfm}

{ TfrmClientesPotencialesAE }

procedure TfrmClientesPotencialesAE.btnGrabarClick(Sender: TObject);
begin
  DM_ClientesPotenciales.Grabar;
  ModalResult:= mrOK;
end;

end.

