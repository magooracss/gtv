unit frm_facturaslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmgeneral
  ;

type

  { TfrmListadoFacturas }

  TfrmListadoFacturas = class(TForm)
    btnAceptar: TBitBtn;
    btnAnular: TBitBtn;
    btnModificar: TBitBtn;
    btnNuevo: TBitBtn;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
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
  ;

{ TfrmListadoFacturas }

procedure TfrmListadoFacturas.btnNuevoClick(Sender: TObject);
begin
  pantallaFactura(GUIDNULO);
end;

procedure TfrmListadoFacturas.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
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

