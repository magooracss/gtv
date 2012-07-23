unit frm_plandecuentaslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, StdCtrls
  ,dmgeneral, dmplandecuentas;

type

  { TfrmPlanDeCuentasListado }

  TfrmPlanDeCuentasListado = class(TForm)
    btnQuitarFiltros: TBitBtn;
    btnNueva: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    btnAceptar: TBitBtn;
    DS_PlanDeCuentas: TDatasource;
    DBGrid1: TDBGrid;
    edCodigo: TEdit;
    edConcepto: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevaClick(Sender: TObject);
    procedure btnQuitarFiltrosClick(Sender: TObject);
    procedure edCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edConceptoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    function getCodigoSeleccionado: String;
    procedure pantPlanDeCuentas(operacion: TOperacion);
  public
     property CodigoSeleccionado: String read getCodigoSeleccionado;
  end; 

var
  frmPlanDeCuentasListado: TfrmPlanDeCuentasListado;

implementation
{$R *.lfm}
uses
  frm_plandecuentasae
  ;

{ TfrmPlanDeCuentasListado }

procedure TfrmPlanDeCuentasListado.edCodigoKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  Begin
   DM_PlanDeCuentas.FiltrarCodigo (edCodigo.Text);
   edConcepto.Clear;
  end;
end;

procedure TfrmPlanDeCuentasListado.btnQuitarFiltrosClick(Sender: TObject);
begin
  DM_PlanDeCuentas.LevantarPlanDeCuentas;
end;

procedure TfrmPlanDeCuentasListado.edConceptoKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  Begin
   DM_PlanDeCuentas.FiltrarConcepto (edConcepto.Text);
   edCodigo.Clear;
  end;
end;

procedure TfrmPlanDeCuentasListado.FormShow(Sender: TObject);
begin
  DM_PlanDeCuentas.LevantarPlanDeCuentas;
end;

function TfrmPlanDeCuentasListado.getCodigoSeleccionado: String;
begin
  Result:= DM_PlanDeCuentas.Codigo;
end;

procedure TfrmPlanDeCuentasListado.pantPlanDeCuentas(operacion: TOperacion);
var
  pant: TfrmPlanDeCuentasAE;
begin
  pant:= TfrmPlanDeCuentasAE.Create (Self);
  try
    pant.operacion:= operacion;
    if Pant.ShowModal = mrOK then
      DM_PlanDeCuentas.LevantarPlanDeCuentas;
  finally
    pant.Free;
  end;
end;

procedure TfrmPlanDeCuentasListado.btnNuevaClick(Sender: TObject);
begin
  pantPlanDeCuentas(nuevo);
end;

procedure TfrmPlanDeCuentasListado.btnModificarClick(Sender: TObject);
begin
  pantPlanDeCuentas(modificar);
end;

procedure TfrmPlanDeCuentasListado.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', '¿Borro la cuenta seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_PlanDeCuentas.BorrarCuentaActual;
    DM_PlanDeCuentas.LevantarPlanDeCuentas;
  end;
end;

procedure TfrmPlanDeCuentasListado.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

