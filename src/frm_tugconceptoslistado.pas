unit frm_tugconceptoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons;

type

  { TfrmTugConceptosListado }

  TfrmTugConceptosListado = class(TForm)
    btnSalir: TBitBtn;
    btnNuevo: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    ds_tugConceptos: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idConcepto: integer;
    { private declarations }
  public
    property idConcepto: integer read _idConcepto;
  end; 

var
  frmTugConceptosListado: TfrmTugConceptosListado;

implementation
{$R *.lfm}
uses
   dmcaja
  ,frm_conceptoae;

{ TfrmTugConceptosListado }

procedure TfrmTugConceptosListado.FormShow(Sender: TObject);
begin
  DM_CAJA.TablaTugConceptos(true);
end;

procedure TfrmTugConceptosListado.btnSalirClick(Sender: TObject);
begin
  _idConcepto:= DM_CAJA.tugConceptos.FieldByName('idConcepto').asInteger;
  DM_CAJA.TablaTugConceptos(false);
  ModalResult:= mrOK;
end;

procedure TfrmTugConceptosListado.btnNuevoClick(Sender: TObject);
var
  pant: TfrmConceptoAE;
begin
  pant:= TfrmConceptoAE.Create(self);
  try
    pant.NuevoConcepto;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmTugConceptosListado.btnModificarClick(Sender: TObject);
var
  pant: TfrmConceptoAE;
begin
  pant:= TfrmConceptoAE.Create(self);
  try
    pant.EditarConcepto;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmTugConceptosListado.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el concepto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_CAJA.BorrartugConcepto;
  end;

end;

end.

