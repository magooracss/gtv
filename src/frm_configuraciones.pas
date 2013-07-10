unit frm_configuraciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, CheckLst, StdCtrls, DBGrids
  ;

type

  { TfrmConfiguracion }

  TfrmConfiguracion = class(TForm)
    btnGrabar: TBitBtn;
    ckBancosPropios: TCheckListBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    tabCheques: TTabSheet;
    procedure btnGrabarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure InicializarBancos;
    function EsBancoPropio(idBanco: integer): boolean; // No funciona el locate
    procedure GrabarBancosPropios;

    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmConfiguracion: TfrmConfiguracion;

implementation
{$R *.lfm}
uses
   SD_Configuracion
  ,dmcheques
  ;

{ TfrmConfiguracion }

procedure TfrmConfiguracion.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmConfiguracion.btnGrabarClick(Sender: TObject);
begin
  GrabarBancosPropios;
  ModalResult:= mrOK;
end;

procedure TfrmConfiguracion.InicializarBancos;
var
  i: integer;
begin
  with DM_Cheques, qTugBancos do
  begin
    if Active then close;
    Open;
    First;
    For i:= 0 to RecordCount -1 do
    begin
      ckBancosPropios.Items.Add(qTugBancosBANCO.AsString);
      ckBancosPropios.Checked[i]:= EsBancoPropio(qTugBancosIDBANCO.AsInteger);
      Next;
    end;
  end;
end;

function TfrmConfiguracion.EsBancoPropio(idBanco: integer): boolean;
begin
  with DM_Cheques, qTugBancosPropios do
  begin
    if Active then close;
    Open;
    Result:= False;
    while (Not EOF) and (NOT Result) do
    begin
      Result:= (qTugBancosPropiosIDBANCO.AsInteger = idBanco);
      Next;
    end;
  end;
end;

procedure TfrmConfiguracion.GrabarBancosPropios;
var
  i: integer;
begin
  with DM_Cheques do
  begin
    qBorrarBancosPropio.ExecSQL;

    for i:= 0 to ckBancosPropios.Items.Count - 1 do
      if ckBancosPropios.Checked[i] then
      begin
        if qTugBancos.Locate('Banco', ckBancosPropios.Items[i], []) then
        begin
           qInsertarBancoPropio.ParamByName('idBanco').asInteger:= qTugBancosIDBANCO.AsInteger;
           qInsertarBancoPropio.ExecSQL;
        end;
      end;

  end;

end;


procedure TfrmConfiguracion.Inicializar;
begin
   InicializarBancos;
end;

end.

