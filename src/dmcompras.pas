unit dmcompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

const
  COMPRAS_IMPAGAS = 0;
  COMPRAS_PAGAS = 1;
  COMPRAS_TODAS = 2;

type

  { TDM_Compras }

  TDM_Compras = class(TDataModule)
    DesmarcarCompra: TZQuery;
    qBusComprasComprobBPAGADA: TFloatField;
    qBusComprasComprobFECHA: TDateField;
    qBusComprasComprobIDCOMPRA: TStringField;
    qBusComprasComprobMONTO: TFloatField;
    qBusComprasComprobNROFACTURA: TLongintField;
    qBusComprasComprobPROVEEDOR: TStringField;
    qBusComprasFechaIgualBPAGADA: TFloatField;
    qBusComprasFechaIgualFECHA: TDateField;
    qBusComprasFechaIgualIDCOMPRA: TStringField;
    qBusComprasFechaIgualMONTO: TFloatField;
    qBusComprasFechaIgualNROFACTURA: TLongintField;
    qBusComprasFechaIgualPROVEEDOR: TStringField;
    qBusComprasFechaMayorBPAGADA: TFloatField;
    qBusComprasFechaMayorFECHA: TDateField;
    qBusComprasFechaMayorIDCOMPRA: TStringField;
    qBusComprasFechaMayorMONTO: TFloatField;
    qBusComprasFechaMayorNROFACTURA: TLongintField;
    qBusComprasFechaMayorPROVEEDOR: TStringField;
    qBusComprasFechaMenorBPAGADA: TFloatField;
    qBusComprasFechaMenorFECHA: TDateField;
    qBusComprasFechaMenorIDCOMPRA: TStringField;
    qBusComprasFechaMenorMONTO: TFloatField;
    qBusComprasFechaMenorNROFACTURA: TLongintField;
    qBusComprasFechaMenorPROVEEDOR: TStringField;
    qBusComprasProv: TZQuery;
    qBusComprasComprob: TZQuery;
    qBusComprasFechaIgual: TZQuery;
    qBusComprasFechaMenor: TZQuery;
    qBusComprasFechaMayor: TZQuery;
    qBusComprasIdProvBPAGADA: TFloatField;
    qBusComprasIdProvFECHA: TDateField;
    qBusComprasIdProvIDCOMPRA: TStringField;
    qBusComprasIdProvMONTO: TFloatField;
    qBusComprasIdProvNROFACTURA: TLongintField;
    qBusComprasIdProvPROVEEDOR: TStringField;
    qBusComprasProvBPAGADA: TFloatField;
    qBusComprasProvFECHA: TDateField;
    qBusComprasProvIDCOMPRA: TStringField;
    qBusComprasProvMONTO: TFloatField;
    qBusComprasProvNROFACTURA: TLongintField;
    qBusComprasProvPROVEEDOR: TStringField;
    qComprasIDProveedor: TZQuery;
    MarcarCompra: TZQuery;
    qComprasIDProveedorBPAGADA: TFloatField;
    qComprasIDProveedorFECHA: TDateField;
    qComprasIDProveedorIDCOMPRA: TStringField;
    qComprasIDProveedorMONTO: TFloatField;
    qComprasIDProveedorNROFACTURA: TLongintField;
    qComprasIDProveedorPROVEEDOR: TStringField;
    qCompraTotalPagada: TZQuery;
    qCompraTotalPagadaTOTAL: TFloatField;
    qFacturaExistenteTOTAL: TLongintField;
    qFormaPagoPorCompra: TZQuery;
    qtugCondicionesPago: TZQuery;
    qtugCondicionPagoTiempo: TZQuery;
    tbComprasCompensada: TFloatField;
    tbComprasPorOPidCompraPago: TStringField;
    tbComprasPorOPINS: TZQuery;
    tbComprasPorOPnMonto: TFloatField;
    tbComprasPorOPrefCompra: TStringField;
    tbComprasPorOPrefOP: TStringField;
    tbComprasPorOPSEL: TZQuery;
    tbComprasPorOPUPD: TZQuery;
    tbComprasPorOP: TRxMemoryData;
    tbComprasItemsDEL: TZQuery;
    qtugTiposComprobantes: TZQuery;
    tbComprasbPagada: TLongintField;
    tbComprasbVisible: TLongintField;
    tbComprasFecha: TDateTimeField;
    tbComprasidCompra: TStringField;
    tbComprasItemsConcepto: TStringField;
    tbComprasDEL: TZQuery;
    tbComprasINS: TZQuery;
    tbComprasItemsSEL: TZQuery;
    tbComprasItemsINS: TZQuery;
    qItemsPorCompra: TZQuery;
    tbComprasnroFactura: TLongintField;
    tbComprasnroPtoVenta: TLongintField;
    tbComprasPercepIVA: TFloatField;
    tbComprasPorOPAPagar: TFloatField;
    tbComprasPorOPFecha: TDateField;
    tbComprasPorOPnroFactura: TLongintField;
    tbComprasPorOPnTotal: TFloatField;
    tbComprasPorOPPagado: TFloatField;
    tbComprasPorOPResta: TFloatField;
    qBuscarCompraPago: TZQuery;
    tbComprasrefCondPago: TLongintField;
    tbComprasrefCondPagoTiempo: TLongintField;
    tbComprasrefOrdenPago: TStringField;
    tbComprasSEL: TZQuery;
    tbComprasItemsUPD: TZQuery;
    tbComprasItemsidCompraItem: TStringField;
    tbComprasItemslxImputacion: TStringField;
    tbComprasItemsnCantidad: TFloatField;
    tbComprasItemsnMontoIVA: TFloatField;
    tbComprasItemsnMontoTotal: TFloatField;
    tbComprasItemsnMontoUnitario: TFloatField;
    tbComprasItemsnPorcentajeIVA: TFloatField;
    tbComprasItemsrefCompra: TStringField;
    tbComprasItemsrefImputacion: TLongintField;
    qComprasPorOP: TZQuery;
    qFacturaExistente: TZQuery;
    qTotalCompras: TZQuery;
    qTotalPagos: TZQuery;
    tbComprasUPD: TZQuery;
    tbComprasnTotal: TFloatField;
    tbComprasPercepCapital: TFloatField;
    tbComprasPercepProvincia: TFloatField;
    tbComprasrefProveedor: TStringField;
    tbComprasrefTipoComprobante: TLongintField;
    tbOPComprobantesFecha: TDateField;
    tbOPComprobantesidOPComprobante: TStringField;
    tbOPComprobantesNroComprobante: TStringField;
    tbOPComprobantesnTotal: TFloatField;
    tbOPComprobantesrefCompra: TStringField;
    tbOPComprobantesrefOrdenPago: TStringField;
    tbComprasFormasDePago: TRxMemoryData;
    tbComprasFormasDePagobVisible: TLongintField;
    tbCFormasDePagoDEL: TZQuery;
    tbComprasFormasDePagoidOPFormaDePago: TStringField;
    tbCFormasDePagoINS: TZQuery;
    tbComprasFormasDePagolxBanco: TStringField;
    tbComprasFormasDePagolxFormaPago: TStringField;
    tbComprasFormasDePagonMonto: TFloatField;
    tbComprasFormasDePagoNroCheque: TStringField;
    tbComprasFormasDePagorefBanco: TLongintField;
    tbComprasFormasDePagorefCheque: TStringField;
    tbComprasFormasDePagorefFormaPago: TLongintField;
    tbComprasFormasDePagorefOrdenPago: TStringField;
    tbCFormasDePagoSEL: TZQuery;
    tbCFormasDePagoUPD: TZQuery;
    tbResultados: TRxMemoryData;
    tbCompras: TRxMemoryData;
    tbComprasItems: TRxMemoryData;
    tbResultadosbPagada: TLongintField;
    tbResultadosCompensada: TFloatField;
    tbResultadosFecha: TDateTimeField;
    tbResultadosidCompra: TStringField;
    tbResultadosMonto: TFloatField;
    tbResultadosnroFactura: TLongintField;
    tbResultadosProveedor: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbComprasAfterInsert(DataSet: TDataSet);
    procedure tbComprasFormasDePagoAfterInsert(DataSet: TDataSet);
    procedure tbComprasFormasDePagoAfterPost(DataSet: TDataSet);
    procedure tbComprasItemsAfterInsert(DataSet: TDataSet);
    procedure tbComprasPorOPAfterInsert(DataSet: TDataSet);
  private
    _TotalNeto: double;
    _TotalIVA: double;
    _TotalCompra: double;
    function getCodImputacion: string;
    function getFechaCompra: TDateTime;
    function getIdCondPago: integer;
    function getIdCondPagoTiempo: integer;
    function getIdProveedor: string;
    function getIdTipoComprobante: integer;
    function getNroComprobante: string;


  public
    property TotalCompra: double read _TotalCompra;
    property TotalIVA: double read _TotalIVA;
    property TotalNeto: double read _TotalNeto;
    property Fecha: TDateTime read getFechaCompra;


    property NroComprobante: string read getNroComprobante;

    property CodigoImputacion: string read getCodImputacion;

    property idProveedor: string read getIdProveedor;
    property idTipoComprobante: integer read getIdTipoComprobante;

    property idCondPago: integer read getIdCondPago;
    property idCondPagoTiempo: integer read getIdCondPagoTiempo;


    procedure Buscar (criterio, consulta: string;filtro: integer);
    function idCompraEdicion: GUID_ID;
    function idCompraListado: GUID_ID;
    procedure NuevaCompra;
    procedure EliminarCompra (refCompra: GUID_ID);

    procedure LevantarCompra (refCompra: GUID_ID);

    procedure LevantarComprasPorOP (refOP: GUID_ID);
    function SumaComprasOP (refOP: GUID_ID):double;
    procedure AsociarOP (refCompra, refOP: GUID_ID);
    procedure DesasociarOP (refCompra: GUID_ID);

    procedure AgregarItem;
    procedure EliminarItem;

    procedure CargarImputacion (idCuenta: integer; Concepto: string);

    procedure ActualizarMontosItem (var montoIVA, montoTotal: double);
    procedure ActualizarMontosItems (montoIVA, montoTotal: double);

    procedure ActualizarMontoTotal;

    procedure CargarProveedor (refProveedor: GUID_ID);
    procedure CargarTipoComprobante (refTipoComprobante: integer);
    procedure CargarCondPago (refCondPago: integer);
    procedure CargarCondPagoTiempo (refCondPagoTiempo: integer);


    procedure ObtenerTotales;

    procedure Grabar;

    procedure MarcarComprobantePagado (refCompra: GUID_ID);
    procedure DesmarcarComprobantePagado (refCompra: GUID_ID);

    function MontoRestante (refCompra: GUID_ID): double;
    function MontoPagado (refCompra: GUID_ID): double;
    function FacturaExistente (suc, nro: integer; proveedor: GUID_ID): boolean;

    function MontoCubiertoFacturas: double;

    procedure LimpiarBlancos;
    function ComprasPorOPMontosOK: boolean;

    procedure GrabarPagosParciales (refOP: GUID_ID);
    function obtenerIdPagoParcial (refCompra, refOP: GUID_ID): GUID_ID;
    procedure GrabarPagosTotales (refOP: GUID_ID);

    function SaldoProveedor (refProveedor: GUID_ID): double;

    procedure LevantarComprasProveedores (refProveedor: GUID_ID; estado: integer);
    procedure AjustarCompensaciones;

  end; 

var
  DM_Compras: TDM_Compras;

implementation
{$R *.lfm}
uses
  dmplandecuentas
  ,dialogs
  ,dmvalores
  ,dmcompensaciones
  ;

{ TDM_Compras }
procedure TDM_Compras.tbComprasAfterInsert(DataSet: TDataSet);
begin
  with Dataset do
  begin
    FieldByName('idCompra').asString:= DM_General.CrearGUID;
    FieldByName('refProveedor').asString:= GUIDNULO;
    FieldByName('refTipoComprobante').asInteger:=0;
    FieldByName('nTotal').asFloat:= 0;
    FieldByName('PercepCapital').asFloat:= 0;
    FieldByName('PercepIVA').asFloat:= 0;
    FieldByName('Fecha').AsDateTime:= Now;
    FieldByName('PercepProvincia').asFloat:= 0;
    FieldByName('bPagada').AsInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
    FieldByName('refOrdenPago').asString:= GUIDNULO;
    FieldByName('nroPtoVenta').asInteger:= 1;
    FieldByName('nroFactura').asInteger:= 1;
    FieldByName('refCondPago').asInteger:= 0;
    FieldByName('refCondPagoTiempo').asInteger:= 0;
    FieldByName('compensada').asFloat:= 0;
  end;
end;

procedure TDM_Compras.DataModuleCreate(Sender: TObject);
begin
  DM_General.ReiniciarTabla(tbResultados);
  DM_General.ReiniciarTabla(tbCompras);
  DM_General.ReiniciarTabla(tbComprasItems);
  DM_General.ReiniciarTabla(tbComprasFormasDePago);
end;

procedure TDM_Compras.tbComprasFormasDePagoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCompraFormaDePago').asString:= DM_General.CrearGUID;
    FieldByName('refCompra').asString:= tbCompras.FieldByName('idCompra').asString;
    FieldByName('refFormaPago').asInteger:= 0;
    FieldByName('refCheque').asString:= GUIDNULO;
    FieldByName('refBanco').asInteger:= 0;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('bVisible').asInteger:= 1;
    FieldByName('lxFormaPago').asString:= EmptyStr;
    FieldByName('NroCheque').asString:= '0';
    FieldByName('lxBanco').asString:= EmptyStr;
  end;
end;

procedure TDM_Compras.tbComprasFormasDePagoAfterPost(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if FieldByName('lxFormaPago').asString = EmptyStr then
    begin
      Edit;
      FieldByName('lxFormaPago').asString:= DM_Valores.FormaPago (FieldByName('refFormaPago').asInteger);
      FieldByName('NroCheque').AsString:= DM_Valores.NroCheque (FieldByName('refCheque').asString);
      FieldByName('lxBanco').AsString:= DM_Valores.Banco (FieldByName('refBanco').AsInteger, FieldByName('refCheque').asString);
      Post;
    end;
  end;
end;

procedure TDM_Compras.tbComprasItemsAfterInsert(DataSet: TDataSet);
var
  refImputacion: integer;
  refIva: double;
begin
  refIVA:= DM_General.TablaValoresInt(_VAL_IVA);
  refImputacion:= DM_General.TablaValoresInt(_VAL_IMP_CMPR);


  with DataSet do
  begin
    FieldByName('idCompraItem').asString:= DM_General.CrearGUID;
    FieldByName('refCompra').asString:= tbCompras.FieldByName('idCompra').asString;
    FieldByName('nCantidad').asFloat:= 1;
    FieldByName('refImputacion').asInteger:= refImputacion;
    FieldByName('nMontoUnitario').asFloat:= 0;
    FieldByName('nPorcentajeIVA').asFloat:= refIVA;
    FieldByName('nMontoIVA').asFloat:= 0;
    FieldByName('nMontoTotal').asFloat:= 0;
  end;
end;

procedure TDM_Compras.tbComprasPorOPAfterInsert(DataSet: TDataSet);
begin
  With DataSet do
  begin
    FieldByName('nTotal').asFloat:= 0;
    FieldByName('Pagado').asFloat:= 0;
    FieldByName('Resta').asFloat:= 0;
    FieldByName('APagar').asFloat:= 0;
  end;
end;

function TDM_Compras.getCodImputacion: string;
begin
  with tbComprasItems do
  begin
    DM_PlanDeCuentas.CuentaPorID (FieldByName('refImputacion').AsInteger);
    Result:= DM_PlanDeCuentas.Codigo;
  end;
end;

function TDM_Compras.getFechaCompra: TDateTime;
begin
  with tbCompras do
  begin
    if FieldByName('Fecha').IsNull then
      Result:= 0
    else
      Result:= FieldByName('Fecha').AsDateTime;
  end;

end;

function TDM_Compras.getIdCondPago: integer;
begin
  with tbCompras do
  begin
    if FieldByName('refCondPago').IsNull then
      Result:= 0
    else
      Result:= FieldByName('refCondPago').asInteger;
  end;
end;

function TDM_Compras.getIdCondPagoTiempo: integer;
begin
  with tbCompras do
  begin
    if FieldByName('refCondPagoTiempo').IsNull then
      Result:= 0
    else
      Result:= FieldByName('refCondPagoTiempo').asInteger;
  end;
end;

function TDM_Compras.getIdProveedor: string;
begin
  if tbCompras.FieldByName('refProveedor').IsNull then
    Result:= GUIDNULO
  else
    Result:= tbCompras.FieldByName('refProveedor').AsString;
end;

function TDM_Compras.getIdTipoComprobante: integer;
begin
  with tbCompras do
  begin
    if FieldByName('refTipoComprobante').IsNull then
      Result:= 0
    else
      Result:= FieldByName('refTipoComprobante').asInteger;
  end;
end;

function TDM_Compras.getNroComprobante: string;
begin
  with tbCompras do
  begin
    if FieldByName('nroFactura').IsNull then
      Result:= EmptyStr
    else
      Result:=rightStr('0000'+ IntToStr(FieldByName('nroPtoVenta').AsInteger), 4 )
             + '-'
             + rightStr('00000000'+ IntToStr(FieldByName('nroFactura').AsInteger), 8 );
  end;
end;


function TDM_Compras.obtenerIdPagoParcial(refCompra, refOP: GUID_ID): GUID_ID;
begin
 with qBuscarCompraPago do
 begin
   if active then close;
   ParamByName('refCompra').AsString:= refCompra;
   ParamByName('refOp').asString:= refOP;
   Open;
   if RecordCount > 0 then
      Result:= FieldByName('idCompraPago').asString
   else
     Result:= DM_General.CrearGUID;
 end;
end;

procedure TDM_Compras.GrabarPagosTotales(refOP: GUID_ID);
var
  refID: GUID_ID;
begin
  with tbComprasPorOP do
  begin
    DisableControls;
    First;
    While Not EOF do
    begin
      refId:= ObtenerIdPagoParcial (FieldByName('refCompra').asString, refOP);
      Edit;
      FieldByName('idCompraPago').asString:= refId;
      FieldByName('refOP').asString:= refOP;
      FieldByName('nMonto').asFloat:= FieldByName('resta').asFloat;
      Post;
      MarcarComprobantePagado(FieldByName('refCompra').asString);
      Next;
    end;
    DM_General.GrabarDatos(tbComprasPorOPSEL, tbComprasPorOPINS, tbComprasPorOPUPD, tbComprasPorOP, 'idCompraPago');
    EnableControls;
  end;
end;

function TDM_Compras.SaldoProveedor(refProveedor: GUID_ID): double;
var
  compras, pagos: double;
begin
  with qTotalCompras do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= refProveedor;
    Open;
    if RecordCount > 0 then
       compras:= FieldByName('Total').asFloat
    else
        compras:= 0;
    close;
  end;

  with qTotalPagos do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= refProveedor;
    Open;
    if RecordCount > 0 then
       pagos:= FieldByName('Pagado').asFloat
    else
        pagos:= 0;
    close;
  end;

  Result:= pagos - compras;
end;

procedure TDM_Compras.LevantarComprasProveedores(refProveedor: GUID_ID;
  estado: integer);
begin
  DM_General.ReiniciarTabla(tbResultados);
  with qComprasIDProveedor do
  begin
    if active then close;
    ParamByName('parametro').asString:= refProveedor;
    ParamByName('filtro').asInteger:= estado;
    Open;
    tbResultados.LoadFromDataSet(qComprasIDProveedor, 0,lmAppend);
  end;
end;

procedure TDM_Compras.AjustarCompensaciones;
begin
  with tbResultados do
  begin
    First;
    While Not EOF do
    begin
      Edit;
      tbResultadosCompensada.asFloat:= DM_Compensaciones.montoCompraCompensada(tbResultadosidCompra.asString);
      Post;
      Next;
    end;
  end;
end;

procedure TDM_Compras.GrabarPagosParciales (refOP: GUID_ID);
var
  refID: GUID_ID;
begin
  with tbComprasPorOP do
  begin
    DisableControls;
    First;
    While Not EOF do
    begin
      refId:= ObtenerIdPagoParcial (FieldByName('refCompra').asString, refOP);
      Edit;
      FieldByName('idCompraPago').asString:= refId;
      FieldByName('refOP').asString:= refOP;
      FieldByName('nMonto').asFloat:= FieldByName('APagar').asFloat;
      Post;
      if DM_General.CmpIgualdadFloat(FieldByName('APagar').asFloat, FieldByName('resta').asFloat) then
         MarcarComprobantePagado(FieldByName('refCompra').asString);
      Next;
    end;
    DM_General.GrabarDatos(tbComprasPorOPSEL, tbComprasPorOPINS, tbComprasPorOPUPD, tbComprasPorOP, 'idCompraPago');
    EnableControls;
  end;
end;


procedure TDM_Compras.ObtenerTotales;
var
  marca: TBookmark;
begin
  with tbComprasItems do
  begin
    DisableControls;
    if State in dsWriteModes then
     Post;
    marca:= GetBookmark;
    First;

    _TotalCompra:= 0;
    _TotalIVA:= 0;
    _TotalNeto:= 0;

    While Not EOF do
    begin
      if NOT FieldByName('nMontoTotal').IsNull then
        _TotalCompra := _TotalCompra + FieldByName('nMontoTotal').asFloat;

      if NOT FieldByName('nMontoIVA').IsNull then
        _TotalIVA := _TotalIVA + FieldByName('nMontoIVA').asFloat;

       if ((NOT FieldByName('nCantidad').IsNull)
            and
           (NOT FieldByName('nMontoUnitario').IsNull)
           ) then
        _TotalNeto := _TotalNeto + (FieldByName('nCantidad').asFloat
                                    *
                                    FieldByName('nMontoUnitario').asFloat
                                   );



      Next;
    end;
    GotoBookmark(marca);
    FreeBookmark(marca);
    _TotalIVA:= _TotalIVA + tbCompras.FieldByName('percepIVA').asFloat;
    _TotalCompra:= _TotalCompra
                   + tbCompras.FieldByName('percepCapital').asFloat
                   + tbCompras.FieldByName('percepProvincia').asFloat
                   + tbCompras.FieldByName('percepIVA').asFloat;
    EnableControls;
  end;
end;

procedure TDM_Compras.Grabar;
begin
  DM_General.GrabarDatos(tbComprasSEL, tbComprasINS, tbComprasUPD, tbCompras, 'idCompra');
  with tbComprasItems do
  begin
    if RecordCount > 0 then
    begin
      DisableControls;
      First;
      While Not EOF do
      begin
        if FieldByName('refCompra').IsNull then
        begin
          Edit;
          FieldByName('refCompra').asString:= tbCompras.FieldByName('idCompra').asString;
          Post;
        end;
        Next;
      end;
      DM_General.GrabarDatos(tbComprasItemsSEL, tbComprasItemsINS, tbComprasItemsUPD, tbComprasItems, 'idCompraItem');
      EnableControls;
    end;
  end;
  DM_General.GrabarDatos(tbCFormasDePagoSEL, tbCFormasDePagoINS, tbCFormasDePagoUPD, tbComprasFormasDePago, 'idCompraFormaDePago');
end;

procedure TDM_Compras.MarcarComprobantePagado(refCompra: GUID_ID);
begin
  with MarcarCompra do
  begin
    ParamByName('idCompra').asString:= refCompra;
    ExecSQL;
  end;
end;

procedure TDM_Compras.DesmarcarComprobantePagado(refCompra: GUID_ID);
begin
  with DesmarcarCompra do
  begin
    ParamByName('idCompra').asString:= refCompra;
    ExecSQL;
  end;
end;

function TDM_Compras.MontoRestante(refCompra: GUID_ID): double;
var
  elMontoCompra
  ,elMontoCompensado: double;
begin

  elMontoCompensado:= DM_Compensaciones.montoCompraCompensada (refCompra);
  LevantarCompra(refCompra);

  with qCompraTotalPagada do
  begin
    if active then close;
    ParamByName ('idCompra').asString:= refCompra;
    Open;

    if RecordCount > 0 then
      elMontoCompra:= FieldByName('TOTAL').asFloat
    else
      elMontoCompra:= 0;
  end;

  Result:= (tbComprasnTotal.AsFloat - (elMontoCompra + elMontoCompensado));

end;

function TDM_Compras.MontoPagado(refCompra: GUID_ID): double;
var
  elMontoCompra
  ,elMontoCompensado: double;
begin

  elMontoCompensado:= DM_Compensaciones.montoCompraCompensada (refCompra);

  with qCompraTotalPagada do
  begin
    if active then close;
    ParamByName ('idCompra').asString:= refCompra;
    Open;

    if RecordCount > 0 then
      elMontoCompra:= FieldByName('TOTAL').asFloat
    else
      elMontoCompra:= 0;
  end;

  Result:= (elMontoCompra + elMontoCompensado);

end;

function TDM_Compras.FacturaExistente(suc, nro: integer; proveedor: GUID_ID
  ): boolean;
begin
  with qFacturaExistente do
  begin
    if active then close;
    ParamByName('refProveedor').asString:= proveedor;
    ParamByName('nroPtoVenta').asInteger:= suc;
    ParamByName('nroFactura').asInteger:= nro;
    Open;

    Result:= (qFacturaExistenteTOTAL.AsInteger > 0);
    close;
  end;
end;

function TDM_Compras.MontoCubiertoFacturas: double;
var
  marca: TBookmark;
  suma: double;
begin
  with tbComprasPorOP do
  begin
    marca:= GetBookmark;
    First;
    suma:= 0;
    while not eof do
    begin
      suma:= suma + FieldByName('APagar').asFloat;
      Next;
    end;
    GotoBookmark(marca);
    FreeBookmark(marca);
  end;
  Result:= suma;
end;

procedure TDM_Compras.LimpiarBlancos;
begin
  with tbComprasPorOP do
  begin
    First;
    While not eof do
    begin
      if FieldByName('refCompra').asString = EmptyStr then
        Delete
      else
        Next;
    end;
  end;
end;

function TDM_Compras.ComprasPorOPMontosOK: boolean;
var
  montoOK: Boolean;
begin
  with tbComprasPorOP do
  begin
    First;
    montoOK:= true;
    While ((montoOK) and (not eof)) do
    begin
      montoOK:= ( (FloattoCurr(FieldByName('Resta').asFloat) > FloattoCurr(FieldByName('APagar').asFloat))
                 or (DM_General.CmpIgualdadFloat (FieldByName('Resta').asFloat, FieldByName('APagar').asFloat))
                  );

      Next;
    end;
  end;
  Result:= montoOK;
end;

procedure TDM_Compras.Buscar(criterio, consulta: string;
  filtro: integer);
var
  laConsulta: TZQuery;
begin
  DM_General.ReiniciarTabla(tbResultados);
  With laConsulta do
  begin
    laConsulta:= TzQuery(DM_Compras.FindComponent(consulta));
    if Active then close;
    ParamByName('parametro').asString:= criterio;
    if filtro <> COMPRAS_TODAS then
      ParamByName('filtro').asInteger:= filtro
    else
      ParamByName('filtro').asInteger:= COMPRAS_IMPAGAS;
    Open;
    tbResultados.LoadFromDataSet(laConsulta, 0, lmAppend);
    if Filtro = COMPRAS_TODAS Then
    begin
      if Active then close;
      ParamByName('parametro').asString:= criterio;
      ParamByName('filtro').asInteger:= COMPRAS_PAGAS;
      Open;
      tbResultados.LoadFromDataSet(laConsulta, 0, lmAppend);
    end;
  end;
end;

function TDM_Compras.idCompraEdicion: GUID_ID;
begin
  if (tbCompras.Active = false) or (tbCompras.FieldByName('idCompra').IsNull) then
    Result:= GUIDNULO
  else
    Result:= tbCompras.FieldByName('idCompra').asString;
end;

function TDM_Compras.idCompraListado: GUID_ID;
begin
  if (tbResultados.Active = false) or (tbResultados.FieldByName('idCompra').IsNull) then
    Result:= GUIDNULO
  else
    Result:= tbResultados.FieldByName('idCompra').asString;
end;

procedure TDM_Compras.NuevaCompra;
begin
  DM_General.ReiniciarTabla(tbCompras);
  DM_General.ReiniciarTabla(tbComprasItems);
  tbCompras.Insert;
end;

procedure TDM_Compras.EliminarCompra(refCompra: GUID_ID);
begin
  with tbComprasDEL do
  begin
    ParamByName('idCompra').AsString:= refCompra;
    ExecSQL;
  end;
end;

procedure TDM_Compras.LevantarCompra(refCompra: GUID_ID);
begin

  DM_General.ReiniciarTabla(tbCompras);
  DM_General.ReiniciarTabla(tbComprasItems);

  with tbComprasSEL do
  begin
    if active then close;
    ParamByName('idCompra').asString:= refCompra;
    Open;
    tbCompras.LoadFromDataSet(tbComprasSEL, 0, lmAppend);
  end;

  with qItemsPorCompra do
  begin
    if active then close;
    ParamByName('refCompra').AsString:= refCompra;
    Open;
    tbComprasItems.LoadFromDataSet(qItemsPorCompra, 0, lmAppend);
    close;
  end;

  with tbComprasItems do
  begin
    if RecordCount > 0 then
      First;
    While not EOF do
    begin
      DM_PlanDeCuentas.CuentaPorID(FieldByName('refImputacion').AsInteger);

      Edit;
      FieldByName('lxImputacion').asString:= DM_PlanDeCuentas.Concepto;
      Post;
      Next;
    end;
  end;
  ActualizarMontoTotal;
end;

procedure TDM_Compras.LevantarComprasPorOP(refOP: GUID_ID);
var
 idCompra: string;
 fFecha: TDate;
 NroFactura: integer;
 Monto, Pagado: double;
begin
  DM_General.ReiniciarTabla(tbComprasPorOP);
  with qComprasPorOP do
  begin
    if active then close;
    ParamByName('refOP').AsString:= refOP;
    Open;

    while not EOF do
    begin

      idCompra:= FieldByName('refCompra').asString;
      fFecha:= FieldByName('Fecha').asDateTime;
      NroFactura:= FieldByName('nroFactura').asInteger;
      Monto:= FieldByName('nTotal').asFloat;
//      Pagado:= 0;
      Pagado:= MontoPagado(idCompra);

      While ((idCompra = FieldByName('refCompra').asString)
              and (not EOF)) do
      begin
     //   Pagado:= Pagado + FieldByName('nMonto').AsFloat;
        Next;
      end;

      tbComprasPorOP.Insert;
      tbComprasPorOP.FieldByName('refCompra').asString:= idCompra;
      tbComprasPorOP.FieldByName('Fecha').AsDateTime:= fFecha;
      tbComprasPorOP.FieldByName('nroFactura').asInteger:= NroFactura;
      tbComprasPorOP.FieldByName('nTotal').asFloat:= Monto;
      tbComprasPorOP.FieldByName('Pagado').asFloat:= Pagado;
      tbComprasPorOP.FieldByName('Resta').asFloat:= Monto - Pagado;

      tbComprasPorOP.Post;

    end;
  end;

end;

procedure TDM_Compras.AsociarOP(refCompra,refOP: GUID_ID);
begin
  LevantarCompra(refCompra);
  with tbCompras do
  begin
    Edit;
    FieldByName('refOrdenPago').asString:= refOP;
    Post;
  end;
  Grabar;
end;

procedure TDM_Compras.DesasociarOP(refCompra: GUID_ID);
begin
  LevantarCompra (refCompra);
  with tbCompras do
  begin
    Edit;
    FieldByName('refOrdenPago').asString:= GUIDNULO;
    FieldByName('bPagada').asInteger:= 0;
    Post;
  end;
  Grabar;
end;

function TDM_Compras.SumaComprasOP(refOP: GUID_ID): double;
var
  sumaTotal, sumaPagada: double;
begin
  sumaTotal:= 0;
  sumaPagada:= 0;
  with tbComprasPorOP do
  begin
    DisableControls;

    LevantarComprasPorOP(refOP);
    if not eof then
      First;

    while (not eof) do
    begin
      sumaTotal:= sumaTotal + FieldByName('nTotal').asFloat;
      sumaPagada:= sumaPagada + FieldByName('Pagado').asFloat;
      Next;
    end;

    EnableControls;
  end;
  Result:= (sumaTotal - sumaPagada);
end;

procedure TDM_Compras.AgregarItem;
begin
  tbComprasItems.Insert;
end;

procedure TDM_Compras.EliminarItem;
begin
  if tbComprasItems.RecordCount > 0 then
  begin
    with tbComprasItemsDEL do
    begin
      ParamByName('idCompraItem').asString:= tbComprasItems.FieldByName('idCompraItem').asString;
      ExecSQL;
      tbComprasItems.Delete;
    end;
  end;
end;

procedure TDM_Compras.CargarImputacion(idCuenta: integer; Concepto: string);
begin
  with tbComprasItems do
  begin
    If NOT (State IN dsEditModes) then
      Edit;
    FieldByName('refImputacion').asInteger:= idCuenta;
    FieldByName('lxImputacion').asString:= Concepto;
  end;
end;

procedure TDM_Compras.ActualizarMontosItem (var montoIVA, montoTotal: double);
var   //TODO: Ojo, modificaciones en el camino para poder facturar
  cantidad, costoUnitario, porcIVA, MontoNeto, bakIVA: double;
begin
  bakIVA:= montoIVA;
  MontoNeto:= 0;
  MontoTotal:= 0;
  MontoIVA:= 0;


  with tbComprasItems do
  begin
    if (state IN dsEditModes) then
      Post;

    if FieldByName('nCantidad').IsNull then
     cantidad:= 0
    else
      Cantidad:= FieldByName('nCantidad').asFloat;
    if FieldByName('nMontoUnitario').IsNull then
     costoUnitario:= 0
    else
      costoUnitario:= FieldByName('nMontoUnitario').asFloat;
    if FieldByName('nPorcentajeIVA').IsNull then
     porcIVA:= 0
    else
      porcIVA:= FieldByName('nPorcentajeIVA').asFloat;

    MontoNeto:= cantidad * costoUnitario;
    MontoIVA:= MontoNeto * (porcIVA / 100);

    if bakIVA > 0 then
      MontoTotal:= MontoNeto + bakIVA
    else
      MontoTotal:= MontoNeto + MontoIVA;
  end;
end;

procedure TDM_Compras.ActualizarMontosItems (montoIVA, montoTotal: double);
begin
  with tbComprasItems do
  begin
    Edit;
    FieldByName('nMontoIVA').AsFloat:= MontoIVA;
    FieldByName('nMontoTotal').AsFloat:= MontoTotal;
    Post;
  end;
end;

procedure TDM_Compras.ActualizarMontoTotal;
begin
  ObtenerTotales;
  With tbCompras do
  begin
    if State in dsWriteModes then
    Post;
    Edit;
    FieldByName('nTotal').asFloat:= TotalCompra;
    Post;
  end;
end;

procedure TDM_Compras.CargarProveedor(refProveedor: GUID_ID);
begin
  with tbCompras do
  begin
    Edit;
    FieldByName('refProveedor').asString:= refProveedor;
    Post;
  end;
end;

procedure TDM_Compras.CargarTipoComprobante(refTipoComprobante: integer);
begin
  with tbCompras do
  begin
    Edit;
    FieldByName('refTipoComprobante').AsInteger:= refTipoComprobante;
    Post;
  end;
end;

procedure TDM_Compras.CargarCondPago(refCondPago: integer);
begin
  with tbCompras do
  begin
    Edit;
    FieldByName('refCondPago').AsInteger:= refCondPago;
    Post;
  end;

end;

procedure TDM_Compras.CargarCondPagoTiempo(refCondPagoTiempo: integer);
begin
  with tbCompras do
  begin
    Edit;
    FieldByName('refCondPagoTiempo').AsInteger:= refCondPagoTiempo;
    Post;
  end;
end;

end.

