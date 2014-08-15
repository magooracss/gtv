unit frm_prefacturacionae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, StdCtrls, Buttons, DBGrids, dmprefacturacion
  ;

type

  { TfrmPrefacturacionAE }

  TfrmPrefacturacionAE = class(TForm)
    btnNuevaPrefactura: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnAceptar: TBitBtn;
    ds_PrefacturasExistentes: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid1: TDBGrid;
    DBRadioGroup1: TDBRadioGroup;
    ds_prefacturacion: TDatasource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnNuevaPrefacturaClick(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
    procedure DBEdit5Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure CalcularTotal;
    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmPrefacturacionAE: TfrmPrefacturacionAE;

implementation

{$R *.lfm}

{ TfrmPrefacturacionAE }

procedure TfrmPrefacturacionAE.DBEdit3Change(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TfrmPrefacturacionAE.btnAceptarClick(Sender: TObject);
begin
 // DM_Prefacturacion.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmPrefacturacionAE.BitBtn2Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Modifica el número de prefactura por el seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Prefacturacion.AsignarNroPrefactura(DM_Prefacturacion.qPrefacturasExistentesNROPREFACTURA.AsInteger);
    DM_Prefacturacion.CambiarEstado(EP_PREFACTURADO);
    DM_Prefacturacion.LevantarPrefacturasCliente(DM_Prefacturacion.Prefacturacioncliente_id.AsString);
  end;
end;

procedure TfrmPrefacturacionAE.BitBtn3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Lo quito de la prefactura actual? (el estado volverá a ser PARA FACTURAR)', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Prefacturacion.QuitarNroPrefactura;
    DM_Prefacturacion.CambiarEstado(EP_PARAFACTURAR);
  end;
end;

procedure TfrmPrefacturacionAE.btnNuevaPrefacturaClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Asigno un nuevo número de prefactura?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Prefacturacion.AsignarNuevoNroPrefactura;
    DM_Prefacturacion.CambiarEstado(EP_PREFACTURADO);
  end;
end;

procedure TfrmPrefacturacionAE.DBEdit5Change(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TfrmPrefacturacionAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPrefacturacionAE.CalcularTotal;
begin
  with DM_Prefacturacion do
  begin
    if Prefacturacion.State in dsEditModes then
      Prefacturacion.Post;
    Prefacturacion.Edit;
    PrefacturacionPrecioTotal.asFloat:= PrefacturacionPrecioUnitario.AsFloat * Prefacturacioncantidad.AsFloat;
    Prefacturacion.Post;
  end;
end;

procedure TfrmPrefacturacionAE.Inicializar;
begin
  DM_Prefacturacion.LevantarPrefacturasCliente(DM_Prefacturacion.Prefacturacioncliente_id.AsString);
end;

end.

