unit frm_administradoressel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids
  ,dmgeneral
  ;

type

  { TfrmAdministradoresSel }

  TfrmAdministradoresSel = class(TForm)
    BitBtn1: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ds_grilla: TDatasource;
    DBGrid1: TDBGrid;
    edNombreAdministrador: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edNombreAdministradorKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    _idAdministrador: GUID_ID;

    procedure Buscar;
  public
    property idAdministrador: GUID_ID read _idAdministrador;
  end; 

var
  frmAdministradoresSel: TfrmAdministradoresSel;

implementation
{$R *.lfm}

uses
  dmclientes
  ;


{ TfrmAdministradoresSel }

procedure TfrmAdministradoresSel.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmAdministradoresSel.edNombreAdministradorKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
   Buscar;
end;

procedure TfrmAdministradoresSel.FormShow(Sender: TObject);
begin
  _idAdministrador:= GUIDNULO;
  edNombreAdministrador.Clear;
  edNombreAdministrador.SetFocus;
end;

procedure TfrmAdministradoresSel.Buscar;
begin
   DM_Clientes.BuscarAdministradoresPorNombre (TRIM(edNombreAdministrador.Text));
end;

procedure TfrmAdministradoresSel.btnAceptarClick(Sender: TObject);
begin
  if NOT ds_grilla.DataSet.EOF then
  begin
    _idAdministrador:= ds_grilla.DataSet.FieldByName('idAdministrador').asString;
    ModalResult:= mrOK;
  end
  else
    ShowMessage('No seleccionó ningun Administrador!!!');

end;

procedure TfrmAdministradoresSel.BitBtn1Click(Sender: TObject);
begin
  Buscar;
end;

end.

