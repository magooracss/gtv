unit frm_conceptoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons;

type

  { TfrmConceptoAE }

  TfrmConceptoAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ds_concepto: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { private declarations }
  public
    procedure NuevoConcepto;
    procedure EditarConcepto;
  end; 

var
  frmConceptoAE: TfrmConceptoAE;

implementation
{$R *.lfm}
uses
  dmcaja
  ;

{ TfrmConceptoAE }

procedure TfrmConceptoAE.btnCancelarClick(Sender: TObject);
begin
  DM_CAJA.tugConceptos.Cancel;
  ModalResult:= mrCancel;
end;




procedure TfrmConceptoAE.NuevoConcepto;
begin
  DM_CAJA.tugConceptos.Insert;
end;

procedure TfrmConceptoAE.EditarConcepto;
begin
  DM_CAJA.tugConceptos.Edit;
end;

procedure TfrmConceptoAE.btnAceptarClick(Sender: TObject);
begin
  with DM_CAJA.tugConceptos do
  begin
    if State in [dsEdit, dsInsert] then
     Post;
  end;
  ModalResult:=  mrOK;
end;

end.

