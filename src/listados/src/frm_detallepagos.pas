unit frm_detallepagos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, EditBtn, DBGrids, StdCtrls, PReport
  ,dmgeneral
  ;

const
  _BLANCO_ =' ';
  _LINEA_ = 80; //Longitud de caracteres


type

  { TfrmDetallePagos }

  TfrmDetallePagos = class(TForm)
    btnListado: TBitBtn;
    btnListado1: TBitBtn;
    btnSalir: TBitBtn;
    edFFin: TDateEdit;
    edFIni: TDateEdit;
    elMemo: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    procedure btnListado1Click(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    _rutaReporte: string;
    _tipoListado: integer;
    procedure CabeceraGeneral;
    procedure CabeceraPago(tipo: string; nro: integer; fecha: TDate; Monto: double; Proveedor: string);
    procedure Gasto (Detalle: string; Monto: double);
    procedure Pagos (formaPago, cheque, banco: string; Monto: double);

  public
    property rutaReporte: string write _rutaReporte;
    property tipoListado: integer write _tipoListado;
  end; 

var
  frmDetallePagos: TfrmDetallePagos;

implementation
{$R *.lfm}
uses
  dmdetallepagos
  ,dateutils
  , frm_lstdetallegastos
  , strutils
  ;

{ TfrmDetallePagos }

procedure TfrmDetallePagos.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmDetallePagos.btnListadoClick(Sender: TObject);
var
  lst: Tfrm_LstPDFDetalleGastos;
  idOP: GUID_ID;
begin
  DM_DetallePagos.LevantarPagos (edFIni.date, edFFin.Date);
  CabeceraGeneral;
  with DM_DetallePagos do
  begin
    qOP.First;
    idOP:= GUIDNULO;
    While Not qOP.EOF do
    begin
      if (idOP <> qOP.FieldByName('idOrdenPago').asString) then
      begin
         elMemo.Append(_BLANCO_);
         CabeceraPago('OP'
                     ,qOP.FieldByName('numeroOrdenPago').asInteger
                     ,qOP.FieldByName('fFecha').AsDateTime
                     ,qOP.FieldByName('nTotalAPagar').AsFloat
                     ,qOP.FieldByName('cRazonSocial').AsString
                     );
         idOP:= qOP.FieldByName('idOrdenPago').asString;
      end;

      elMemo.Append(_BLANCO_);
      while Not qFacturas.EOF do
      begin
        Gasto( qFacturas.FieldByName('TipoComprobante').asString
               + ' - '
               + AddChar('0',IntToStr(qFacturas.FieldByName('NroPtoVenta').asInteger),4)
               + ' - '
               + AddChar('0',IntToStr(qFacturas.FieldByName('NroFactura').asInteger),8)
             , qFacturas.FieldByName('nMonto').asFloat
             );
        qFacturas.Next;
      end;

      while Not qPagos.EOF do
      begin
        Pagos( qPagos.FieldByName('FormaPago').asString
               ,qPagos.FieldByName('NroCheque').asString
               ,qPagos.FieldByName('Banco').asString
               , qPagos.FieldByName('nMonto').asFloat
              );
         qPagos.Next;
       end;

      qOP.Next;
    end;
  end;
  elMemo.SelStart := 0;
  elMemo.SelLength := 0;

  (*
  lst:= Tfrm_LstPDFDetalleGastos.Create(self);
  try
    lst.pdfDetalleGastos.BeginDoc;

    lst.pdfDetalleGastos.EndDoc;
  finally
     lst.Free;
  end;



  DM_General.LevantarReporte(_rutaReporte,DM_DetallePagos.qOP);
  DM_General.AgregarVariableReporte('Periodo', DateToStr(edFIni.Date) + ' - ' + DateToStr(edFFin.Date));
  DM_General.EditarReporte;
  *)
end;

procedure TfrmDetallePagos.btnListado1Click(Sender: TObject);
begin
  if SD.Execute then
     elMemo.Lines.SaveToFile(sd.FileName);
end;

procedure TfrmDetallePagos.FormCreate(Sender: TObject);
begin
  DM_DetallePagos:= TDM_DetallePagos.Create(self);
  edFIni.Date:= StartOfTheMonth(Now);
  edFFin.Date:=  EndOfTheMonth(Now);
end;

procedure TfrmDetallePagos.FormDestroy(Sender: TObject);
begin
  DM_DetallePagos.Free;
end;

procedure TfrmDetallePagos.CabeceraGeneral;
var
  strTmp: string;
begin
  elMemo.Clear;
  elMemo.Append(AddChar(_BLANCO_,DateToStr(Now),_LINEA_ ));
  elMemo.Append(_BLANCO_);
  strTmp:= 'DETALLE DE COMPRAS';
  elMemo.Append(AddChar(_BLANCO_, strTmp, ((_LINEA_ - Length(strTmp))div 2+Length(strTmp)) ));
  elMemo.Append(AddChar('_','',_LINEA_));
end;

procedure TfrmDetallePagos.CabeceraPago(tipo: string; nro: integer;
  fecha: TDate; Monto: double; Proveedor: string);
var
  renglon: string;
begin
  renglon:= 'TIPO: ' + tipo;
  renglon:= renglon + ' NÚMERO: ' + IntToStr(Nro);
  renglon:= AddCharR(_BLANCO_,renglon,_LINEA_ - 40); //40 es la longitud de fecha + monto
  renglon:= renglon + ' FECHA: ' + DateToStr(fecha);
  renglon:= renglon + ' MONTO: $' + FormatFloat('##########0.00',monto);
  elMemo.Append(_BLANCO_);
  elMemo.Append(renglon);
  elMemo.Append(Proveedor);
end;

procedure TfrmDetallePagos.Gasto(Detalle: string; Monto: double);
var
  renglon: string;
begin
  renglon:= 'GASTO: ' + Detalle;
  renglon:= AddCharR(_BLANCO_,renglon,_LINEA_ - 22); //22 es la longitud de monto
  renglon:= renglon + ' MONTO: $' + FormatFloat('##########0.00',monto);
  elMemo.Append(renglon);
end;

procedure TfrmDetallePagos.Pagos(formaPago, cheque, banco: string; Monto: double
  );
var
  renglon
  ,renglon2: string;
begin
  renglon:= 'FORMA DE PAGO: ' + formaPago;
  renglon2:= EmptyStr;

  if Trim(cheque) <> EmptyStr then
  begin
     renglon2:= ' NRO CHEQUE: ' + cheque;
  end;

  if Trim(banco) <> EmptyStr then
  begin
     renglon2:= renglon2 + ' BANCO: ' + banco;
  end;

  renglon:= AddCharR(_BLANCO_,renglon,_LINEA_ - 22); //22 es la longitud de monto
  renglon:= renglon + ' MONTO: $' + FormatFloat('##########0.00',monto);
  elMemo.Append(renglon);
  if renglon2 <> EmptyStr then
    elMemo.Append(renglon2);
end;


end.

