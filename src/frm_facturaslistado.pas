unit frm_facturaslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmgeneral, db
  ;

type

  { TfrmListadoFacturas }

  TfrmListadoFacturas = class(TForm)
    btnFiltrarFacturas: TBitBtn;
    btnAceptar: TBitBtn;
    btnAnular: TBitBtn;
    btnGenerarFacturaAFIP: TBitBtn;
    btnGenerarFacturaAFIP1: TBitBtn;
    btnModificar: TBitBtn;
    btnNuevo: TBitBtn;
    ds_listadoFacturas: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    rgFacturasTipo: TRadioGroup;
    procedure btnGenerarFacturaAFIPClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAnularClick(Sender: TObject);
    procedure btnFiltrarFacturasClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure pantallaFactura (idFactura: GUID_ID);
  public
    { public declarations }
  end;

var
  frmListadoFacturas: TfrmListadoFacturas;

implementation
{$R *.lfm}
uses
  frm_facturaae
  ,dmfacturas
  ,dmfacturaelectronica
  ;

{ TfrmListadoFacturas }

procedure TfrmListadoFacturas.btnNuevoClick(Sender: TObject);
begin
  pantallaFactura(GUIDNULO);
  DM_Facturas.LevantarFacturas(0);
end;

procedure TfrmListadoFacturas.DBGrid1DblClick(Sender: TObject);
begin
  if NOT DM_Facturas.cambiarEstadoFactura (ds_listadoFacturas.DataSet.FieldByName('id').AsString ) then
    ShowMessage('Solamente se puede cambiar el estado de una factura SIN FACTURAR o APROBADA')
  else
    DM_Facturas.LevantarFacturas(rgFacturasTipo.ItemIndex);
end;

procedure TfrmListadoFacturas.FormShow(Sender: TObject);
begin
  DM_Facturas.LevantarFacturas(0);
end;

procedure TfrmListadoFacturas.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoFacturas.btnGenerarFacturaAFIPClick(Sender: TObject);
begin
  DM_Facturas.LevantarFacturaID(DM_Facturas.idFacturaListado);
  if DM_Facturas.Facturasestado_id.AsInteger = FACTURA_ESTADO_APROBADA then
    DM_FacturaElectronica.Facturar(DM_Facturas.idFacturaListado)
  else
    ShowMessage('Solo se puede enviar a la AFIP una factura aprobada');
end;

procedure TfrmListadoFacturas.btnAnularClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Anulo la factura seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Facturas.AnularFactura(DM_Facturas.idFacturaListado);
    DM_Facturas.LevantarFacturas(0);
  end;
end;

procedure TfrmListadoFacturas.btnFiltrarFacturasClick(Sender: TObject);
begin
  DM_Facturas.LevantarFacturas(rgFacturasTipo.ItemIndex);
end;

procedure TfrmListadoFacturas.btnModificarClick(Sender: TObject);
begin
  pantallaFactura (DM_Facturas.idFacturaListado);
  DM_Facturas.LevantarFacturas(0);
end;

procedure TfrmListadoFacturas.pantallaFactura(idFactura: GUID_ID);
var
  pant: TfrmFacturaAE;
begin
  pant:= TfrmFacturaAE.Create(self);
  try
    pant.factura_id:= idFactura;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

end.

