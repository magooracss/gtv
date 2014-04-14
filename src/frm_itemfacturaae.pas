unit frm_itemfacturaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons;

type

  { TfrmItemFacturaAE }

  TfrmItemFacturaAE = class(TForm)
    btnAceptar: TBitBtn;
    ds_facturaItem: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
  private
    procedure CalcularTotal;
  public
    { public declarations }
  end;

var
  frmItemFacturaAE: TfrmItemFacturaAE;

implementation
{$R *.lfm}
uses
  dmfacturas
  ;

{ TfrmItemFacturaAE }

procedure TfrmItemFacturaAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmItemFacturaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmItemFacturaAE.DBEdit1Change(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TfrmItemFacturaAE.DBEdit3Change(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TfrmItemFacturaAE.DBEdit3Exit(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TfrmItemFacturaAE.CalcularTotal;
begin
  with DM_Facturas do
  begin
//    FacturaItems.Edit;
    FacturaItemsMonto.asFloat:= FacturaItemsCantidad.asFloat * FacturaItemsPrecioUnitario.asFloat;
//    FacturaItems.Post;
  end;
end;

end.

