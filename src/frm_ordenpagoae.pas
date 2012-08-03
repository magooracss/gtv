unit frm_ordenpagoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, Buttons, StdCtrls, DBGrids, dbdateedit
  ,dmgeneral;

type

  { TfrmOrdenDePagoAE }

  TfrmOrdenDePagoAE = class(TForm)
    btnPagarComprobante: TBitBtn;
    BitBtn2: TBitBtn;
    btnBuscarProveedor: TBitBtn;
    btnAgregarComprobante: TBitBtn;
    btQuitarComprobante: TBitBtn;
    btnValoresNuevo: TBitBtn;
    btnQuitarValor: TBitBtn;
    btnSalir: TBitBtn;
    btnGrabar: TBitBtn;
    btnImprimir: TBitBtn;
    DBEdit3: TDBEdit;
    DS_OrdenesDePago: TDatasource;
    DS_OPComprobantes: TDatasource;
    DS_OPFormasDePago: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    edSumaValores: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Splitter1: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure btnGrabarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnPagarComprobanteClick(Sender: TObject);
    procedure btnQuitarValorClick(Sender: TObject);
    procedure btnValoresNuevoClick(Sender: TObject);
    procedure btQuitarComprobanteClick(Sender: TObject);
    procedure btnAgregarComprobanteClick(Sender: TObject);
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DS_OPComprobantesDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private
    _idOrdenPago: GUID_ID;
    function ValidarTotales: boolean;
  public
    property idOrdenPago: GUID_ID read _idOrdenPago write _idOrdenPago;
  end; 

var
  frmOrdenDePagoAE: TfrmOrdenDePagoAE;

implementation
{$R *.lfm}
uses
   dmordenesdepago
  ,frm_proveedoreslistado
  ,frm_compraslistado
  ,frm_pagocomprobantes
  ,dmcompras
  ,frm_cargavalores
  ,SD_Configuracion
  , LR_Class
  ;

{ TfrmOrdenDePagoAE }

procedure TfrmOrdenDePagoAE.FormShow(Sender: TObject);
begin
  if _idOrdenPago = GUIDNULO then
  begin
    DM_OrdenesDePago.Nueva;
  end
  else
  begin
    DM_OrdenesDePago.LevantarOP (_idOrdenPago);
    edSumaValores.Text:= FormatFloat('$ ############0.00', DM_OrdenesDePago.CalcularValores);
  end;
end;

function TfrmOrdenDePagoAE.ValidarTotales: boolean;
var
  totalOP, sumaCompras: double;
begin
  totalOP:= 0;
  sumaCompras:= 0;
  totalOP:= DM_OrdenesDePago.tbOrdenesPago.FieldByName ('nTotalAPagar').asFloat;
  sumaCompras:= DM_Compras.SumaComprasOP(DM_OrdenesDePago.tbOrdenesPago.FieldByName ('idOrdenPago').AsString);
  Result:= (totalOP = SumaCompras);
end;

procedure TfrmOrdenDePagoAE.btnBuscarProveedorClick(Sender: TObject);
var
 pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenesDePago.VincularProveedor (pant.idProveedor);
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmOrdenDePagoAE.btnAgregarComprobanteClick(Sender: TObject);
var
  pant: TfrmComprasListado;
begin
  pant:= TfrmComprasListado.Create (Self);
  try
    if pant.BuscarProveedorImpago(DM_OrdenesDePago.idProveedor) then
    begin
      if pant.ShowModal = mrOK then
      begin
        DM_OrdenesDePago.VincularCompra (pant.CompraSeleccionada);
      end;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmOrdenDePagoAE.btQuitarComprobanteClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino el comprobante seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_OrdenesDePago.EliminarComprobante (DS_OPComprobantes.DataSet.FieldByName('idCompra').asString);
    DM_OrdenesDePago.CalcularMontoTotal;
  end;
end;

procedure TfrmOrdenDePagoAE.btnValoresNuevoClick(Sender: TObject);
var
  pant: TfrmCargaValores;
begin
  pant:= TfrmCargaValores.Create (Self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenesDePago.CargarValor (pant.refFormaPago
                                   ,pant.refCheque
                                   ,pant.refBanco
                                   ,pant.Monto
                                   ,pant.Banco
                                   ,pant.NroCheque
                                   );
      edSumaValores.Text:= FormatFloat('$ ############0.00', DM_OrdenesDePago.CalcularValores);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmOrdenDePagoAE.btnQuitarValorClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino el valor seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_OrdenesDePago.EliminarValor;
    edSumaValores.Text:= FormatFloat('$ ############0.00', DM_OrdenesDePago.CalcularValores);
  end;
end;

procedure TfrmOrdenDePagoAE.btnGrabarClick(Sender: TObject);
begin
  DM_OrdenesDePago.CalcularMontoTotal;
  DM_OrdenesDePago.Grabar;
  if  (DM_OrdenesDePago.CalcularValores < DM_OrdenesDePago.tbOrdenesPago.FieldByName('nTotalAPagar').asFloat) then
   ShowMessage ('Esta queriendo pagar menos que el total de la orden de pago!!!');
end;

procedure TfrmOrdenDePagoAE.btnImprimirClick(Sender: TObject);
var
  ruta: string;
begin
  with DM_OrdenesDePago, elReporte do
  begin
    ruta:= LeerDato (SECCION_APP ,RUTA_LISTADOS) ;
    LoadFromFile(ruta+ _PRN_ORDENPAGO_);
    frVariables ['TotalPagos']:= FormatFloat('$ ############0.00', DM_OrdenesDePago.CalcularValores);
    ShowReport;
  end;
end;

procedure TfrmOrdenDePagoAE.btnPagarComprobanteClick(Sender: TObject);
var
  pant: TfrmPagoComprobante;
begin
  pant:= TfrmPagoComprobante.Create (Self);
  pant.idCompra:= DM_Compras.qComprasPorOP.FieldByName('idCompra').asString;
  try
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmOrdenDePagoAE.btnSalirClick(Sender: TObject);
begin
  if ValidarTotales then
   ModalResult:= mrOK
  else
    ShowMessage('Se realizaron cambios que no han sido registrados');
end;

procedure TfrmOrdenDePagoAE.DS_OPComprobantesDataChange(Sender: TObject;
  Field: TField);
begin

end;

end.

