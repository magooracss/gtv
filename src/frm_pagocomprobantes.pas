unit frm_pagocomprobantes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids, StdCtrls, DbCtrls
  ,dmgeneral
  ;

type

  { TfrmPagoComprobante }

  TfrmPagoComprobante = class(TForm)
    btnQuitarValor: TBitBtn;
    btnSalir: TBitBtn;
    btnValoresNuevo: TBitBtn;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    ds_ComprobantesPago: TDatasource;
    ds_OrdenPago: TDatasource;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    ds_Comprobantes: TDatasource;
    edMontoAPagar: TEdit;
    edFaltaCubrir: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbFaltaCubrir: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure btnQuitarValorClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnValoresNuevoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    MontoPagado
    ,MontoACubrir: double;
    _idCompra: GUID_ID;
    procedure Inicializar;
    function CalcularMontoAPagar (elMonto: double): double; //Devuelve el monto a cubrir del total cargado (p/e cuando se paga con un cheque con monto mayor al de la deuda)
  public
    property idCompra: GUID_ID read _idCompra write _idCompra;
    procedure calcularTotalAPagar;
  end; 

var
  frmPagoComprobante: TfrmPagoComprobante;

implementation
{$R *.lfm}
uses
   dmordenesdepago
   ,dmcompras
  ,frm_cargavalores
  ;

{ TfrmPagoComprobante }

procedure TfrmPagoComprobante.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPagoComprobante.btnQuitarValorClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino el valor seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_OrdenesDePago.EliminarValorSeleccionado;
    calcularTotalAPagar;
  end;
end;

procedure TfrmPagoComprobante.btnValoresNuevoClick(Sender: TObject);
var
  pant: TfrmCargaValores;
  montoAPagar: double;
  idFormaPago: GUID_ID;
begin
  pant:= TfrmCargaValores.Create (Self);
  try
    if pant.ShowModal = mrOK then
    begin
      idFormaPago:= DM_OrdenesDePago.CargarValor (pant.refFormaPago
                                                  ,pant.refCheque
                                                  ,pant.refBanco
                                                  ,pant.Monto
                                                  ,pant.Banco
                                                  ,pant.NroCheque
                                                 );
      montoAPagar:= CalcularMontoAPagar (pant.Monto);
      DM_OrdenesDePago.RealizarPago(idFormaPago
                                   ,ds_Comprobantes.DataSet.FieldByName('idCompra').asString
                                   ,montoAPagar
                                   );

  //    edSumaValores.Text:= FormatFloat('$ ############0.00', DM_OrdenesDePago.CalcularValores);
    end;
  finally
    pant.Free;
  end;
  calcularTotalAPagar;
end;

procedure TfrmPagoComprobante.FormCreate(Sender: TObject);
begin
  MontoPagado:= 0;
end;

procedure TfrmPagoComprobante.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPagoComprobante.Inicializar;
begin
  MontoACubrir:= ds_Comprobantes.DataSet.FieldByName('nTotal').asFloat;
  MontoPagado:= DM_Compras.MontoPagado (ds_Comprobantes.DataSet.FieldByName('idCompra').asString);
  DM_OrdenesDePago.LevantarComprasPagos(_idCompra);
  calcularTotalAPagar;
end;

function TfrmPagoComprobante.CalcularMontoAPagar(elMonto: double): double;
var
  falta: double;
begin
  falta:= MontoACubrir - MontoPagado;

  if Falta >= elMonto  then
    Result:= elMonto
  else
    Result:= Falta;
end;

procedure TfrmPagoComprobante.calcularTotalAPagar;
var
  montoTotal: double;
  Marca: TBookmark;
begin
  montoTotal:= 0;
  With ds_ComprobantesPago.DataSet do
  begin
    DisableControls;
    Marca:= GetBookmark;
    First;
    While Not eof do
    begin
      montoTotal:= montoTotal + FieldByName('nMonto').asFloat;
      Next;
    end;
    GotoBookmark(Marca);
    FreeBookmark(Marca);
    EnableControls;
  end;
  edMontoAPagar.Text:= FormatFloat ('$########0.00',montoTotal) ;
  edFaltaCubrir.Text:= FormatFloat ('$########0.00',DM_Compras.qComprasPorOP.FieldByName('nTotal').asFloat - montoTotal) ;
  if (montoTotal > DM_Compras.qComprasPorOP.FieldByName('nTotal').asFloat) then
  begin
    edFaltaCubrir.Color:= clYellow;
    lbFaltaCubrir.Caption:= 'Exceso!!';
    ShowMessage('Atención, el monto cargado para pagar es superior al monto a cubrir');
  end
  else
  begin
    lbFaltaCubrir.Caption:= 'Falta cubrir: ';
    edFaltaCubrir.Color:= clMoneyGreen;
  end;
end;


end.

