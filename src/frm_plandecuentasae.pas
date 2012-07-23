unit frm_plandecuentasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, StdCtrls, Buttons
  ,dmgeneral;

type

  { TfrmPlanDeCuentasAE }

  TfrmPlanDeCuentasAE = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ds_PlanCuentas: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _operacion: TOperacion;
    { private declarations }
  public
   property operacion: TOperacion write _operacion;
  end; 

var
  frmPlanDeCuentasAE: TfrmPlanDeCuentasAE;

implementation
{$R *.lfm}
uses
  dmplandecuentas
  ;

{ TfrmPlanDeCuentasAE }

procedure TfrmPlanDeCuentasAE.BitBtn2Click(Sender: TObject);
begin
  DM_PlanDeCuentas.CancelarAE;
  ModalResult:= mrCancel;
end;

procedure TfrmPlanDeCuentasAE.FormShow(Sender: TObject);
begin
  case _operacion of
    nuevo: DM_PlanDeCuentas.Nueva;
    modificar: DM_PlanDeCuentas.Modificar;
  end;
end;

procedure TfrmPlanDeCuentasAE.BitBtn1Click(Sender: TObject);
begin
  DM_PlanDeCuentas.AsentarAE;
  ModalResult:= mrOK;
end;

end.

