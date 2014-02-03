unit frm_facturaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids, dbdateedit
  ,dmgeneral
  ;

type

  { TfrmFacturaAE }

  TfrmFacturaAE = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    btnAgregarCobro: TBitBtn;
    btnClientesAgregar: TBitBtn;
    btnClientesBuscar: TBitBtn;
    btnQuitarCobro: TBitBtn;
    cbTipoFactura: TComboBox;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Splitter1: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure btnClientesAgregarClick(Sender: TObject);
    procedure btnClientesBuscarClick(Sender: TObject);
  private
    idFactura: GUID_ID;
    { private declarations }
  public
    property factura_id: GUID_ID read idFactura write idFactura;
  end;

var
  frmFacturaAE: TfrmFacturaAE;

implementation
{$R *.lfm}
uses
   frm_busquedaclientes
  ,frm_clienteam
  ,dmclientes
  ,dmfacturas
  ;

{ TfrmFacturaAE }

procedure TfrmFacturaAE.btnClientesBuscarClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      DM_Facturas.CargarCliente(pantBusqueda.idCliente);
      edCliente.Text:= TRIM(pantBusqueda.NombreCliente);
    end;
  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmFacturaAE.btnClientesAgregarClick(Sender: TObject);
var
  pant: Tfrm_ClientesAM;
begin
  pant:= Tfrm_ClientesAM.Create (self);
  try
    pant.operacion:= nuevo;
    if pant.ShowModal = mrOK then
    begin
      DM_Facturas.CargarCliente(pant.cliente);
      edCliente.Text:= TRIM(DM_Clientes.ClienteNombre(pant.cliente));
    end;
  finally
    pant.free;
  end;
end;

end.

