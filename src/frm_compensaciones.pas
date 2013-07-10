unit frm_compensaciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons
  ,dmgeneral;

type

  { TfrmCompensaciones }

  TfrmCompensaciones = class(TForm)
    BitBtn1: TBitBtn;
    btnAnular: TBitBtn;
    btnSalir: TBitBtn;
    btnCompensar: TBitBtn;
    ds_compras: TDatasource;
    ds_compensaciones: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    edProveedor: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAnularClick(Sender: TObject);
    procedure btnCompensarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idProveedor: GUID_ID;
    procedure setcargarProveedor(AValue: GUID_ID);
  public
    property idProveedor: GUID_ID write setcargarProveedor;
  end;

var
  frmCompensaciones: TfrmCompensaciones;

implementation
{$R *.lfm}
uses
  dmcompensaciones
  , frm_proveedoreslistado
  , dmproveedores
  , dmcompras
  ;

{ TfrmCompensaciones }

procedure TfrmCompensaciones.BitBtn1Click(Sender: TObject);
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create(self);
  try
    if pant.ShowModal = mrOK then
     idProveedor:= pant.idProveedor;
     edProveedor.Text:= pant.RazonSocial;
  finally
    pant.Free;
  end;
end;

procedure TfrmCompensaciones.btnAnularClick(Sender: TObject);
begin

end;

procedure TfrmCompensaciones.btnCompensarClick(Sender: TObject);
begin
  DM_Compensaciones.CompensarCompra (
               ds_compensaciones.DataSet.FieldByName('idCompensacion').asString
              ,ds_compras.DataSet.FieldByName('idCompra').asString );
  idProveedor:= _idProveedor;
end;

procedure TfrmCompensaciones.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrClose;
end;

procedure TfrmCompensaciones.FormCreate(Sender: TObject);
begin
  _idProveedor:= GUIDNULO;
  edProveedor.Clear;
end;

procedure TfrmCompensaciones.FormShow(Sender: TObject);
begin
  if _idProveedor <> GUIDNULO then
  begin
   edProveedor.Text:= DM_Proveedores.ProveedorNombre(_idProveedor);
  end;

end;

procedure TfrmCompensaciones.setcargarProveedor(AValue: GUID_ID);
begin
  _idProveedor:= AValue;
  DM_Compensaciones.refProveedor:= _idProveedor;
  DM_Compensaciones.LevantarCompensaciones;
  DM_Compras.LevantarComprasProveedores(_idProveedor, COMPRAS_IMPAGAS);
  DM_Compras.AjustarCompensaciones;
end;

end.

