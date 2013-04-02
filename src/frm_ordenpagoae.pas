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
    edSaldoCliente: TEdit;
    edSumaValores: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
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
    procedure SaldoProveedor;
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
  ,LR_Class
  ,frm_asignarpagofactura
  ,dmcompensaciones
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
    SaldoProveedor;
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

procedure TfrmOrdenDePagoAE.SaldoProveedor;
var
  elSaldo: double;
begin
  elSaldo:=  DM_Compras.SaldoProveedor (DM_OrdenesDePago.idProveedor);
  if elSaldo < 0 then
     edSaldoCliente.Font.Color:= clRed
  else
     edSaldoCliente.Font.Color:= clBlack;

  edSaldoCliente.Text:= FormatFloat('$ #########0.00', elSaldo);
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
      SaldoProveedor;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmOrdenDePagoAE.btnAgregarComprobanteClick(Sender: TObject);
var
  pant: TfrmComprasListado;
  idx: integer;
begin
  pant:= TfrmComprasListado.Create (Self);
  try
    if pant.BuscarProveedorImpago(DM_OrdenesDePago.idProveedor) then
    begin
      if pant.ShowModal = mrOK then
      begin
        idx:= 0;
        if pant.Seleccion.Count > 0 then
        begin
          for idx:= 0 to pant.Seleccion.Count - 1 do
            DM_OrdenesDePago.VincularCompra (pant.Seleccion[idx])
        end
        else
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
    DM_OrdenesDePago.EliminarComprobante (DS_OPComprobantes.DataSet.FieldByName('refCompra').asString);
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
var
  idOP: GUID_ID;
  pant: TfrmAsignarPagoFacturas;
  mnt: double;
  compensacion, montoACubrir: double;
begin
  idOP:= DM_OrdenesDePago.idOrdenPago;
  pant:= TfrmAsignarPagoFacturas.Create(self);

  DM_OrdenesDePago.CalcularMontoTotal;
  DM_OrdenesDePago.Grabar;

  DM_OrdenesDePago.EntregarCheques;


  mnt:=DM_OrdenesDePago.CalcularValores;
  montoACubrir:= DM_Compras.SumaComprasOP (DM_OrdenesDePago.tbOrdenesPago.FieldByName('idOrdenPago').asString);
  compensacion:= mnt-montoACubrir;

  if (compensacion > 1) then
    DM_Compensaciones.AsentarCompensacion (DM_OrdenesDePago.tbOrdenesPago.FieldByName('idOrdenPago').asString
                                           ,compensacion
                                          );

  if  ((mnt < DM_OrdenesDePago.tbOrdenesPago.FieldByName('nTotalAPagar').asFloat)
        and (NOT DM_General.CmpIgualdadFloat(mnt, DM_OrdenesDePago.tbOrdenesPago.FieldByName('nTotalAPagar').asFloat))
       ) then
  begin
    try
      pant.idOP:= idOP;
      pant.MontoACubrir:= DM_OrdenesDePago.CalcularValores;
      pant.ShowModal;
    finally
      pant.Free;
    end;
  end
  else
  begin
    DM_Compras.GrabarPagosTotales (idOP);
  end;

  DM_OrdenesDePago.LevantarOP(DM_OrdenesDePago.idOrdenPago);

  btnGrabar.Enabled:= False;
  btnSalir.Enabled:= True;
  btnImprimir.Enabled:= True;
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
//  if ValidarTotales then
   ModalResult:= mrOK
//  else
//    ShowMessage('Se realizaron cambios que no han sido registrados');
end;

procedure TfrmOrdenDePagoAE.DS_OPComprobantesDataChange(Sender: TObject;
  Field: TField);
begin

end;

end.

