unit frm_egresoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, DbCtrls
  ,dmgeneral
  ;

type

  { TfrmEgresoAE }

  TfrmEgresoAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ds_Item: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    edCuenta: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    btnCuenta: TSpeedButton;
    lbCuenta: TStaticText;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCuentaClick(Sender: TObject);
    procedure edCuentaExit(Sender: TObject);
    procedure edCuentaKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idEgreso: GUID_ID;

    procedure NuevoEgreso;
    procedure LevantarEgreso (refEgreso: GUID_ID);
    procedure ActualizarImputacion;

  public
    property idEgreso: GUID_ID read _idEgreso write _idEgreso;
  end; 

var
  frmEgresoAE: TfrmEgresoAE;

implementation
{$R *.lfm}
uses
  dmegresosvarios
  ,dmplandecuentas
  ,frm_plandecuentaslistado
  ;

{ TfrmEgresoAE }

procedure TfrmEgresoAE.FormCreate(Sender: TObject);
begin
  _idEgreso:= GUIDNULO;
end;

procedure TfrmEgresoAE.FormShow(Sender: TObject);
begin
  if _idEgreso = GUIDNULO then
     NuevoEgreso
  else
    LevantarEgreso (_idEgreso);
end;


procedure TfrmEgresoAE.ActualizarImputacion;
begin
  if DM_PlanDeCuentas.ExisteCodigoImputacion(TRIM(edCuenta.Text)) then
  begin
    lbCuenta.Caption := DM_PlanDeCuentas.Concepto;
    DM_EgresosVarios.CargarImputacion(DM_PlanDeCuentas.idCuenta, DM_PlanDeCuentas.Concepto);
  end
  else
  begin
    ShowMessage('El código ' + TRIM(edCuenta.Text) + ' no existe');
    edCuenta.Clear;
//    edCuenta.SetFocus;
  end;
end;


procedure TfrmEgresoAE.btnCuentaClick(Sender: TObject);
var
  pant: TfrmPlanDeCuentasListado;
begin
  pant := TfrmPlanDeCuentasListado.Create(self);
  try
    if pant.ShowModal = mrOk then
    begin
      edCuenta.Text := pant.CodigoSeleccionado;
      ActualizarImputacion;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmEgresoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmEgresoAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmEgresoAE.edCuentaExit(Sender: TObject);
begin
  ActualizarImputacion;
end;

procedure TfrmEgresoAE.edCuentaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
     ActualizarImputacion;
     DBEdit1.SetFocus;
  end;
end;

procedure TfrmEgresoAE.NuevoEgreso;
begin
  DM_EgresosVarios.NuevoEgresoVarioItem;
end;

procedure TfrmEgresoAE.LevantarEgreso(refEgreso: GUID_ID);
begin
  DM_PlanDeCuentas.CuentaPorID(DM_EgresosVarios.imputacion);
  edCuenta.Text:= DM_PlanDeCuentas.Codigo;
  ActualizarImputacion;
end;

end.

