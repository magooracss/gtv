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
    qBusComprasProv: TZQuery;
    qBusComprasComprob: TZQuery;
    qBusComprasFechaIgual: TZQuery;
    qBusComprasFechaMenor: TZQuery;
    qBusComprasFechaMayor: TZQuery;
    qComprasIDProveedor: TZQuery;
    MarcarCompra: TZQuery;
    qComprasPorOPNROFACTURA: TLongintField;
    qComprasPorOPNROPTOVENTA: TLongintField;
    qComprasPorOPPERCEPIVA: TFloatField;
    qCompraTotalPagada: TZQuery;
    qComprasPorOPBPAGADA: TFloatField;
    qComprasPorOPBVISIBLE: TSmallintField;
    qComprasPorOPFECHA: TDateField;
    qComprasPorOPIDCOMPRA: TStringField;
    qComprasPorOPNROCOMPROBANTE: TStringField;
    qComprasPorOPNTOTAL: TFloatField;
    qComprasPorOPPERCEPCAPITAL: TFloatField;
    qComprasPorOPPERCEPPROVINCIA: TFloatField;
    qComprasPorOPREFORDENPAGO: TStringField;
    qComprasPorOPREFPROVEEDOR: TStringField;
    qComprasPorOPREFTIPOCOMPROBANTE: TLongintField;
    qCompraTotalPagadaTOTAL: TFloatField;
    qFormaPagoPorCompra: TZQuery;
    qtugCondicionesPago: TZQuery;
    qtugCondicionPagoTiempo: TZQuery;
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
    procedure ActualizarMontosItem;
    procedure ActualizarMontoTotal;

    procedure CargarProveedor (refProveedor: GUID_ID);
    procedure CargarTipoComprobante (refTipoComprobante: integer);
    procedure CargarCondPago (refCondPago: integer);
    procedure CargarCondPagoTiempo (refCondPagoTiempo: integer);


    procedure ObtenerTotales;

    procedure Grabar;

    procedure MarcarComprobantePagado (refCompra: GUID_ID);
    procedure DesmarcarComprobantePagado (refCompra: GUID_ID);

    function MontoPagado (refCompra: GUID_ID): double;
    function FacturaExistente (suc, nro: integer; proveedor: GUID_ID): boolean;
  end; 

var
  DM_Compras: TDM_Compras;

implementation
{$R *.lfm}
uses
  dmplandecuentas
  ,dialogs
  ,dmvalores
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

function TDM_Compras.MontoPagado(refCompra: GUID_ID): double;
begin
  with qCompraTotalPagada do
  begin
    if active then close;
    ParamByName ('idCompra').asString:= refCompra;
    Open;
    if RecordCount > 0 then
       Result:= FieldByName('TOTAL').asFloat
    else
      Result:= 0;
  end;
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

    Result:= (RecordCount > 0);
    close;
  end;
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
begin
  with qComprasPorOP do
  begin
    if active then close;
    ParamByName('refOP').AsString:= refOP;
    Open;
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
  suma: double;
begin
  suma:= 0;
  with qComprasPorOP do
  begin
    DisableControls;

    LevantarComprasPorOP(refOP);
    if not eof then
      First;

    while (not eof) do
    begin
      suma:= suma + FieldByName('nTotal').asFloat;
      Next;
    end;

    EnableControls;
  end;
  Result:= suma;
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

procedure TDM_Compras.ActualizarMontosItem;
var
  cantidad, costoUnitario, porcIVA, MontoIVA, MontoNeto
  ,MontoTotal: double;
begin
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
    MontoTotal:= MontoNeto + MontoIVA;

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

