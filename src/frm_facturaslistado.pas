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
    btnAceptar: TBitBtn;
    btnAnular: TBitBtn;
    btnModificar: TBitBtn;
    btnNuevo: TBitBtn;
    ds_listadoFacturas: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAnularClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
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
  ;

{ TfrmListadoFacturas }

procedure TfrmListadoFacturas.btnNuevoClick(Sender: TObject);
begin
  pantallaFactura(GUIDNULO);
end;

procedure TfrmListadoFacturas.FormShow(Sender: TObject);
begin
  DM_Facturas.LevantarFacturas;
end;

procedure TfrmListadoFacturas.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoFacturas.btnAnularClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Anulo la factura seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Facturas.AnularFactura(DM_Facturas.idFacturaListado);
    DM_Facturas.LevantarFacturas;
  end;
end;

procedure TfrmListadoFacturas.btnModificarClick(Sender: TObject);
begin
  pantallaFactura (DM_Facturas.idFacturaListado);
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

