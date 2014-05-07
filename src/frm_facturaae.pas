unit frm_facturaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids, dbdateedit, db
  ,dmgeneral
  ;

type

  { TfrmFacturaAE }

  TfrmFacturaAE = class(TForm)
    btnGrabar: TBitBtn;
    btnReciboVincular: TBitBtn;
    btnReciboQuitar: TBitBtn;
    btnVincularRemito: TBitBtn;
    btnQuitarRemito: TBitBtn;
    btnAgregarCobro: TBitBtn;
    btnClientesAgregar: TBitBtn;
    btnClientesBuscar: TBitBtn;
    btnQuitarCobro: TBitBtn;
    cbTipoFactura: TComboBox;
    ds_remitoFactura: TDatasource;
    ds_reciboFactura: TDatasource;
    ds_factura: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    ds_facturaItems: TDatasource;
    edCliente: TEdit;
    edTotalFactura: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
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
    procedure btnGrabarClick(Sender: TObject);
    procedure btnQuitarRemitoClick(Sender: TObject);
    procedure btnVincularRemitoClick(Sender: TObject);
    procedure btnReciboQuitarClick(Sender: TObject);
    procedure btnReciboVincularClick(Sender: TObject);
    procedure btnAgregarCobroClick(Sender: TObject);
    procedure btnClientesAgregarClick(Sender: TObject);
    procedure btnClientesBuscarClick(Sender: TObject);
    procedure btnQuitarCobroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    idFactura: GUID_ID;
    procedure LevantarCliente (id: GUID_ID; nombre: string );
    procedure Inicializar;
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
  ,frm_itemfacturaae
  ,frm_reciboslistado
  ,frm_remitoslistado
  ;

{ TfrmFacturaAE }
procedure TfrmFacturaAE.LevantarCliente(id: GUID_ID; nombre: string);
begin
  DM_Facturas.CargarCliente(id);
  edCliente.Text:= TRIM(nombre);
  DM_Clientes.ClienteEditar(id);

  if (MessageDlg ('ATENCION', 'Asigno un numero de factura legal?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    cbTipoFactura.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoFactura
             , DM_Facturas.idFacturaPorCondicionFiscal(DM_Clientes.tbClientesrefCondicionFiscal.AsInteger)
             );
    DM_Facturas.AsignarNroFactura (DM_Facturas.idFacturaPorCondicionFiscal(DM_Clientes.tbClientesrefCondicionFiscal.AsInteger))
  end
  else
  begin
    cbTipoFactura.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoFactura
             , FACTURA_T
             );

    DM_Facturas.AsignarNroFactura (FACTURA_T);
  end;

end;

procedure TfrmFacturaAE.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoFactura,'letra', 'id' ,DM_Facturas.CondicionFiscal);
end;

procedure TfrmFacturaAE.btnClientesBuscarClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      //DM_Facturas.CargarCliente(pantBusqueda.idCliente);
      //edCliente.Text:= TRIM(pantBusqueda.NombreCliente);
      LevantarCliente(pantBusqueda.idCliente, pantBusqueda.NombreCliente);
    end;
  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmFacturaAE.btnQuitarCobroClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Elimino el item seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Facturas.EliminarItem;
    edTotalFactura.Text:= FormatFloat('$#########0.00', DM_Facturas.totalFacturado);
  end;
end;

procedure TfrmFacturaAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if factura_id = GUIDNULO then
  begin
    DM_Facturas.NuevaFactura;
  end
  else
  begin
   DM_Facturas.LevantarFacturaID (factura_id);
   edCliente.Text:= DM_Clientes.ClienteNombre(DM_Facturas.FacturasclienteEmpresa_id.AsString);
   edTotalFactura.Text:= FormatFloat('$#########0.00', DM_Facturas.totalFacturado);
   cbTipoFactura.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoFactura, DM_Facturas.FacturastipoFactura_id.AsInteger);
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
      //DM_Facturas.CargarCliente(pant.cliente);
      //edCliente.Text:= TRIM(DM_Clientes.ClienteNombre(pant.cliente));
      LevantarCliente(pant.Cliente, TRIM(DM_Clientes.ClienteNombre(pant.cliente)));
    end;
  finally
    pant.free;
  end;
end;

procedure TfrmFacturaAE.btnAgregarCobroClick(Sender: TObject);
var
  pant: TfrmItemFacturaAE;
begin
  pant:= TfrmItemFacturaAE.Create(self);
  try
    DM_Facturas.NuevoItem;
    pant.ShowModal;
  finally
    pant.Free;
  end;

  edTotalFactura.Text:= FormatFloat('$#########0.00', DM_Facturas.totalFacturado);
end;

procedure TfrmFacturaAE.btnReciboVincularClick(Sender: TObject);
var
  pantSel: TfrmRecibosListado;
begin
  pantSel:= TfrmRecibosListado.Create(self);
  try
    if pantSel.ShowModal = mrOK then
    begin
      DM_Facturas.ReciboVincular(pantSel.reciboSeleccionado);
    end;
  finally
    pantSel.Free;
  end;
end;

procedure TfrmFacturaAE.btnReciboQuitarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Desvinculo el recibo seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Facturas.ReciboQuitar;
  end;
end;

procedure TfrmFacturaAE.btnVincularRemitoClick(Sender: TObject);
  var
    pantSel: TfrmRemitosListado;
  begin
    pantSel:= TfrmRemitosListado.Create(self);
    try
      if pantSel.ShowModal = mrOK then
      begin
        DM_Facturas.RemitoVincular(pantSel.idRemitoSeleccionado);
      end;
    finally
      pantSel.Free;
    end;
end;

procedure TfrmFacturaAE.btnQuitarRemitoClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Desvinculo el remito seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Facturas.RemitoQuitar;
  end;
end;

procedure TfrmFacturaAE.btnGrabarClick(Sender: TObject);
begin
  DM_Facturas.LetraFactura:= DM_General.obtenerIDIntComboBox(cbTipoFactura);
  DM_Facturas.GrabarFactura;
  ModalResult:= mrOK;
end;

end.

