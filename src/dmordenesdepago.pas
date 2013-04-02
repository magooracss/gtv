unit dmordenesdepago;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, LR_DBSet, LR_Class, ZDataset
  ,dmgeneral
  ;

type

  { TDM_OrdenesDePago }

  TDM_OrdenesDePago = class(TDataModule)
    elReporte: TfrReport;
    frComprobantes: TfrDBDataSet;
    frOrdenPago: TfrDBDataSet;
    frFormasPago: TfrDBDataSet;
    qBusOPFechaIgualFECHA: TDateField;
    qBusOPFechaIgualIDORDENPAGO: TStringField;
    qBusOPFechaIgualMONTO: TFloatField;
    qBusOPFechaIgualNUMEROORDENPAGO: TLongintField;
    qBusOPFechaIgualPROVEEDOR: TStringField;
    qBusOPFechaMayorFECHA: TDateField;
    qBusOPFechaMayorIDORDENPAGO: TStringField;
    qBusOPFechaMayorMONTO: TFloatField;
    qBusOPFechaMayorNUMEROORDENPAGO: TLongintField;
    qBusOPFechaMayorPROVEEDOR: TStringField;
    qBusOPFechaMenorFECHA: TDateField;
    qBusOPFechaMenorIDORDENPAGO: TStringField;
    qBusOPFechaMenorMONTO: TFloatField;
    qBusOPFechaMenorNUMEROORDENPAGO: TLongintField;
    qBusOPFechaMenorPROVEEDOR: TStringField;
    qBusOPNumeroFECHA: TDateField;
    qBusOPNumeroIDORDENPAGO: TStringField;
    qBusOPNumeroMONTO: TFloatField;
    qBusOPNumeroNUMEROORDENPAGO: TLongintField;
    qBusOPNumeroPROVEEDOR: TStringField;
    qBusOPProv: TZQuery;
    qBusOPNumero: TZQuery;
    qBusOPFechaIgual: TZQuery;
    qBusOPFechaMenor: TZQuery;
    qBusOPFechaMayor: TZQuery;
    qBusOPProvFECHA: TDateField;
    qBusOPProvIDORDENPAGO: TStringField;
    qBusOPProvMONTO: TFloatField;
    qBusOPProvNUMEROORDENPAGO: TLongintField;
    qBusOPProvPROVEEDOR: TStringField;
    qComprobantesPorOPBPAGADA: TFloatField;
    qComprobantesPorOPBVISIBLE: TSmallintField;
    qComprobantesPorOPFECHA: TDateField;
    qComprobantesPorOPIDCOMPRA: TStringField;
    qComprobantesPorOPIDOPCOMPROBANTE: TStringField;
    qComprobantesPorOPNROFACTURA: TLongintField;
    qComprobantesPorOPNROPTOVENTA: TLongintField;
    qComprobantesPorOPNTOTAL: TFloatField;
    qComprobantesPorOPPERCEPCAPITAL: TFloatField;
    qComprobantesPorOPPERCEPIVA: TFloatField;
    qComprobantesPorOPPERCEPPROVINCIA: TFloatField;
    qComprobantesPorOPREFCOMPRA: TStringField;
    qComprobantesPorOPREFCONDPAGO: TLongintField;
    qComprobantesPorOPREFCONDPAGOTIEMPO: TLongintField;
    qComprobantesPorOPREFORDENPAGO: TStringField;
    qComprobantesPorOPREFORDENPAGO_1: TStringField;
    qComprobantesPorOPREFPROVEEDOR: TStringField;
    qComprobantesPorOPREFTIPOCOMPROBANTE: TLongintField;
    qEliminarPago: TZQuery;
    qOPBorradas: TZQuery;
    qReactivarCompras: TZQuery;
    qOPFormasPagoBVISIBLE: TSmallintField;
    qOPFormasPagoIDOPFORMADEPAGO: TStringField;
    qOPFormasPagoNMONTO: TFloatField;
    qOPFormasPagoREFBANCO: TLongintField;
    qOPFormasPagoREFCHEQUE: TStringField;
    qOPFormasPagoREFFORMAPAGO: TLongintField;
    qOPFormasPagoREFORDENPAGO: TStringField;
    qPagosComprasIDCOMPRAPAGO: TStringField;
    qPagosComprasLXFORMAPAGO: TStringField;
    qPagosComprasLXNROCHEQUE: TStringField;
    qPagosComprasNMONTO: TFloatField;
    qPagosComprasREFCOMPRA: TStringField;
    qPagosComprasREFOP: TStringField;
    qtbChequesBVISIBLE: TSmallintField;
    qtbChequesFCOBRO: TDateField;
    qtbChequesFENTREGA: TDateField;
    qtbChequesFRECIBIDO: TDateField;
    qtbChequesFVENCIMIENTO: TDateField;
    qtbChequesIDCHEQUE: TStringField;
    qtbChequesNMONTO: TFloatField;
    qtbChequesNROCHEQUE: TStringField;
    qtbChequesREFBANCO: TLongintField;
    qtbChequesREFENTREGADOA: TStringField;
    qtbChequesREFESTADO: TLongintField;
    qtbChequesREFRECIBIDODE: TStringField;
    qtbChequesTXNOTAS: TStringField;
    qtugBancos: TZQuery;
    qtugBancosBANCO: TStringField;
    qtugBancosBVISIBLE: TSmallintField;
    qtugBancosIDBANCO: TLongintField;
    qtugFormasPago: TZQuery;
    qtbCheques: TZQuery;
    qtugFormasPagoAGRUPAMIENTO: TLongintField;
    qtugFormasPagoBVISIBLE: TSmallintField;
    qtugFormasPagoFORMAPAGO: TStringField;
    qtugFormasPagoIDFORMAPAGO: TLongintField;
    qtugFormasPagoREFCUENTA: TLongintField;
    tbOPComprobantesSELIDOPCOMPROBANTE: TStringField;
    tbOPComprobantesSELREFCOMPRA: TStringField;
    tbOPComprobantesSELREFORDENPAGO: TStringField;
    tbOPFormasDePagoDEL: TZQuery;
    tbComprasPagosidCompraPago: TStringField;
    qOPFormasPago: TZQuery;
    tbOPFormasDePagoINS: TZQuery;
    tbComprasPagoslxBanco: TStringField;
    tbComprasPagoslxFormaPago: TStringField;
    tbComprasPagosnMonto: TFloatField;
    tbComprasPagosNroCheque: TStringField;
    tbComprasPagosrefCompra: TStringField;
    tbComprasPagosrefOPFormaDePago: TStringField;
    tbOPFormasDePagolxFechaCheque: TStringField;
    tbOPFormasDePagoSEL: TZQuery;
    tbOPFormasDePagoSELBVISIBLE: TSmallintField;
    tbOPFormasDePagoSELIDOPFORMADEPAGO: TStringField;
    tbOPFormasDePagoSELNMONTO: TFloatField;
    tbOPFormasDePagoSELREFBANCO: TLongintField;
    tbOPFormasDePagoSELREFCHEQUE: TStringField;
    tbOPFormasDePagoSELREFFORMAPAGO: TLongintField;
    tbOPFormasDePagoSELREFORDENPAGO: TStringField;
    tbOPFormasDePagoUPD: TZQuery;
    tbComprobantesDEL: TZQuery;
    tbComprasPagosDel: TZQuery;
    tbComprobantesINS: TZQuery;
    tbComprasPagosINS: TZQuery;
    tbComprobantesUPD: TZQuery;
    tbComprasPagosUPD: TZQuery;
    tbOPComprobantes: TRxMemoryData;
    tbOPComprobantesFecha: TDateField;
    tbOPComprobantesidOPComprobante: TStringField;
    tbOPComprobantesNroComprobante: TStringField;
    tbOPComprobantesnTotal: TFloatField;
    tbOPComprobantesrefCompra: TStringField;
    tbOPComprobantesrefOrdenPago: TStringField;
    qComprobantesPorOP: TZQuery;
    tbOPComprobantesSEL: TZQuery;
    qPagosCompras: TZQuery;
    tbComprasPagosSEL: TZQuery;
    tbOPFormasDePagobVisible: TLongintField;
    tbOPFormasDePagoidOPFormaDePago: TStringField;
    tbOPFormasDePagolxBanco: TStringField;
    tbOPFormasDePagolxFormaDePago: TStringField;
    tbOPFormasDePagolxNroCheque: TStringField;
    tbOPFormasDePagonMonto: TFloatField;
    tbOPFormasDePagoNroCheque: TStringField;
    tbOPFormasDePagorefBanco: TLongintField;
    tbOPFormasDePagorefCheque: TStringField;
    tbOPFormasDePagorefFormaDePago: TLongintField;
    tbOPFormasDePagorefFormaPago: TLongintField;
    tbOPFormasDePagorefOrdenPago: TStringField;
    tbOrdenesPagobVisible: TLongintField;
    tbOrdenesPagoDEL: TZQuery;
    tbOrdenesPagofFecha: TDateField;
    tbOrdenesPagoidOrdenPago: TStringField;
    tbOrdenesPagolxProveedor1: TStringField;
    tbOrdenesPagonPagado: TFloatField;
    tbOrdenesPagonTotalAPagar: TFloatField;
    tbOrdenesPagoNumeroOrdenPago: TLongintField;
    tbOrdenesPagorefProveedor: TStringField;
    tbOrdenesPagoSEL: TZQuery;
    tbOrdenesPagoINS: TZQuery;
    tbOrdenesPagoSELBVISIBLE: TSmallintField;
    tbOrdenesPagoSELFFECHA: TDateField;
    tbOrdenesPagoSELIDORDENPAGO: TStringField;
    tbOrdenesPagoSELLXPROVEEDOR: TStringField;
    tbOrdenesPagoSELNPAGADO: TFloatField;
    tbOrdenesPagoSELNTOTALAPAGAR: TFloatField;
    tbOrdenesPagoSELNUMEROORDENPAGO: TLongintField;
    tbOrdenesPagoSELREFPROVEEDOR: TStringField;
    tbOrdenesPagoSELTXOBSERVACIONES: TBlobField;
    tbOrdenesPagotxObservaciones: TStringField;
    tbOrdenesPagoUPD: TZQuery;
    tbResultados: TRxMemoryData;
    tbOrdenesPago: TRxMemoryData;
    tbOPFormasDePago: TRxMemoryData;
    tbComprasPagos: TRxMemoryData;
    tbResultadosFecha: TDateTimeField;
    tbResultadosidOrdenPago: TStringField;
    tbResultadosMonto: TFloatField;
    tbResultadosNumeroOrdenPago: TLargeintField;
    tbResultadosProveedor: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbComprasPagosAfterInsert(DataSet: TDataSet);
    procedure tbComprasPagosAfterPost(DataSet: TDataSet);
    procedure tbOPComprobantesAfterInsert(DataSet: TDataSet);
    procedure tbOrdenesPagoAfterInsert(DataSet: TDataSet);
    procedure tbOPFormasDePagoAfterInsert(DataSet: TDataSet);
  private
    function getIdOPBusqueda: GUID_ID;
    function getIdOrdenPago: GUID_ID;
    function getIdProveedor: GUID_ID;

    procedure MarcarComprobantes;
    procedure DesmarcarComprobante (refComprobante: GUID_ID);

  public
    property idOPBusqueda: GUID_ID read getIdOPBusqueda;
    property idOrdenPago: GUID_ID read getIdOrdenPago;
    property idProveedor: GUID_ID read getIdProveedor;

    procedure Buscar (criterio, consulta: string);
    procedure Nueva;

    procedure VincularProveedor(refProveedor: GUID_ID);
    procedure VincularCompra (refCompra: GUID_ID);

    procedure CalcularMontoTotal;
    function CalcularValores: double;

    procedure EliminarComprobante (refCompra: string);
    procedure EliminarValor;

    function CargarValor (refFormaPago: integer; refCheque: GUID_ID; refBanco: integer
                           ; Monto: double; Banco, NroCheque: string): GUID_ID;

    procedure RealizarPago (refFormaPago, refCompra: GUID_ID; nMonto: double);

    procedure Grabar;

    procedure LevantarOP (refOP: GUID_ID);

    procedure EliminarOrdenPago (refOP: GUID_ID);

    procedure LevantarComprasPagos (refCompra: GUID_ID);

    function ObtenerBanco (refBanco: integer): string;
    function ObtenerFormaPago (refFormaPago: integer): string;
    function ObtenerNroCheque (refCheque: string):string;
    function ObtenerfVtoCheque (refCheque: string):string;

    procedure EliminarValorSeleccionado;
    procedure EliminarPago (refOP, refCompra: GUID_ID);

    procedure ReactivarComprasOPBorradas;

    procedure EntregarCheques;
  end;

var
  DM_OrdenesDePago: TDM_OrdenesDePago;

implementation
{$R *.lfm}
uses
  dmproveedores
  ,dmcompras
  ,dmvalores
  ,dmcheques
  ;

{ TDM_OrdenesDePago }

procedure TDM_OrdenesDePago.tbOrdenesPagoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idOrdenPago').asString:= DM_General.CrearGUID;
    FieldByName('NumeroOrdenPago').asInteger:= -1;
    FieldByName('refProveedor').asString:= GUIDNULO;
    FieldByName('fFecha').AsDateTime:= Now;
    FieldByName('nTotalAPagar').asFloat:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_OrdenesDePago.tbOPFormasDePagoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idOPFormaDePago').asString:= DM_General.CrearGUID;
    FieldByName('refFormaPago').AsInteger:= 0;
    FieldByName('refCheque').asString:= GUIDNULO;
    FieldByName('refBanco').asInteger:= 0;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('refOrdenPago').asString:= tbOrdenesPago.FieldByName('idOrdenPago').asString;
    FieldByName('bVisible').asInteger:= 1;
    FieldByName('lxFormaDePago').asString:= EmptyStr;
    FieldByName('lxNroCheque').asString:= '0';
    FieldByName('lxBanco').asString:= '---';
  end;
end;

procedure TDM_OrdenesDePago.tbOPComprobantesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idOPComprobante').asString:= DM_General.CrearGUID;
    FieldByName('refOrdenPago').asString:= tbOrdenesPago.FieldByName('idOrdenPago').asString;
    FieldByName('refCompra').asString:= GUIDNULO;
  end;
end;

procedure TDM_OrdenesDePago.tbComprasPagosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCompraPago').AsString:= DM_General.CrearGUID;
    FieldByName('refcompra').asString:= GUIDNULO;
    FieldByName('refOPFormaDePago').asString:= GUIDNULO;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('lxFormaPago').asString:= EmptyStr;
    FieldByName('NroCheque').asString:= '0';
    FieldByName('lxBanco').asString:= EmptyStr;
  end;
end;

procedure TDM_OrdenesDePago.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(TDataModule(DM_OrdenesDePago), true);
end;

procedure TDM_OrdenesDePago.tbComprasPagosAfterPost(DataSet: TDataSet);
begin
(*
  with DataSet do
  begin
    if FieldByName('lxFormaPago').asString = EmptyStr then
    begin
      Edit;
      FieldByName('lxFormaPago').asString:= DM_Valores.FormaPago (FieldByName('refOPFormaDePago').asString);
      FieldByName('NroCheque').AsString:,frm_cargavalores    = DM_Valores.NroCheque (FieldByName('refCheque').asString);
      FieldByName('lxBanco').AsString:= DM_Valores.Banco (FieldByName('refBanco').AsInteger, FieldByName('refCheque').asString);
      Post;
    end;
  end;
*)
end;



function TDM_OrdenesDePago.getIdOPBusqueda: GUID_ID;
begin
  if ((tbResultados.Active) and (tbResultados.RecordCount > 0)) then
    Result:= tbResultados.FieldByName('idOrdenPago').AsString
  else
    Result:= GUIDNULO;
end;

function TDM_OrdenesDePago.getIdOrdenPago: GUID_ID;
begin
  if ((tbOrdenesPago.Active) and (tbOrdenesPago.RecordCount > 0)) then
    Result:= tbOrdenesPago.FieldByName('idOrdenPago').AsString
  else
    Result:= GUIDNULO;
end;

function TDM_OrdenesDePago.getIdProveedor: GUID_ID;
begin
  With tbOrdenesPago do
  begin
    if (Active and (NOT FieldByName('refProveedor').IsNull)) then
      Result:= FieldByName('refProveedor').asString
    else
      Result:= GUIDNULO;
  end;
end;

procedure TDM_OrdenesDePago.MarcarComprobantes;
begin
  with tbOPComprobantes do
  begin
    if RecordCount > 0 then
      First;
    While Not EOF do
    begin
      DM_Compras.MarcarComprobantePagado (FieldByName('refCompra').asString);
      Next;
    end;
  end;
end;

procedure TDM_OrdenesDePago.DesmarcarComprobante(refComprobante: GUID_ID);
begin

end;

function TDM_OrdenesDePago.ObtenerBanco(refBanco: integer): string;
begin
  with qtugBancos do
  begin
    if active then close;
    ParamByName('idBanco').asInteger:= refBanco;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('Banco').asString
    else
      Result:= '***';
  end;
end;

function TDM_OrdenesDePago.ObtenerFormaPago(refFormaPago: integer): string;
begin
  with qtugFormasPago do
  begin
    if active then close;
    ParamByName('idFormaPago').asInteger:= refFormaPago;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('FormaPago').asString
    else
      Result:= '***';
  end;
end;

function TDM_OrdenesDePago.ObtenerNroCheque(refCheque: string): string;
begin
  with qtbCheques do
  begin
    if active then close;
    ParamByName('idCheque').asString:= refCheque;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('NroCheque').asString
    else
      Result:= '***';
  end;
end;

function TDM_OrdenesDePago.ObtenerfVtoCheque(refCheque: string): string;
begin
  with qtbCheques do
  begin
    if active then close;
    ParamByName('idCheque').asString:= refCheque;
    Open;
    if RecordCount > 0 then
      Result:= DateToStr(FieldByName('fVencimiento').AsDateTime)
    else
      Result:= '***';
  end;
end;

procedure TDM_OrdenesDePago.EliminarValorSeleccionado;
begin
  with tbOPFormasDePago do
  begin;
    if RecordCount > 0 then
      Delete;

  end;
end;

procedure TDM_OrdenesDePago.EliminarPago(refOP, refCompra: GUID_ID);
begin
  with qEliminarPago do
  begin
    FieldByName('refOP').asString:= refOP;
    FieldByName('refCompra').asString:= refCompra;
    ExecSQL;
  end;
end;

procedure TDM_OrdenesDePago.ReactivarComprasOPBorradas;
begin
  if qOPBorradas.Active then qOPBorradas.Close;
  qOPBorradas.open;

  while Not qOPBorradas.EOF do
  begin
    qReactivarCompras.ParamByName('refOrdenPago').asString:= qOPBorradas.FieldByName('idOrdenPago').asString;
    qReactivarCompras.ExecSQL;
    qOPBorradas.Next;
  end;

end;

procedure TDM_OrdenesDePago.EntregarCheques;
begin
   with tbOPFormasDePago do
   begin
     First;
     while not EOF do
     begin
       if (tbOPFormasDePagorefCheque.AsString <> GUIDNULO) then
       begin
         DM_Cheques.BuscarChequeId(tbOPFormasDePagorefCheque.AsString);
         DM_Cheques.CambiarEntregadoA(tbOrdenesPagorefProveedor.AsString);
         DM_Cheques.CambiarFechaEntregadoA(tbOrdenesPagofFecha.AsDateTime);

         DM_Cheques.Grabar;
       end;
       Next;
     end;

   end;
end;

procedure TDM_OrdenesDePago.Buscar(criterio, consulta: string);
var
  laConsulta: TZQuery;
begin
  DM_General.ReiniciarTabla(tbResultados);
  With laConsulta do
  begin
    laConsulta:= TzQuery(DM_OrdenesDePago.FindComponent(consulta));
    if Active then close;
    ParamByName('parametro').asString:= criterio;
    Open;
    tbResultados.LoadFromDataSet(laConsulta, 0, lmAppend);
  end;
end;

procedure TDM_OrdenesDePago.Nueva;
begin
  DM_General.ReiniciarTabla(tbOrdenesPago);
  DM_General.ReiniciarTabla(tbOPComprobantes);
  DM_General.ReiniciarTabla(DM_Compras.tbComprasPorOP);
  DM_General.ReiniciarTabla(tbOPFormasDePago);
  tbOrdenesPago.Insert;
end;

procedure TDM_OrdenesDePago.VincularProveedor(refProveedor: GUID_ID);
begin
  with tbOrdenesPago do
  begin
    Edit;
    FieldByName('refProveedor').asString:= refProveedor;
    FieldByName('lxProveedor').asString:= DM_Proveedores.ProveedorNombre(refProveedor);
    Post;
  end;
end;

procedure TDM_OrdenesDePago.VincularCompra(refCompra: GUID_ID);
begin
  DM_Compras.AsociarOP (refCompra, tbOrdenesPago.FieldByName('idOrdenPago').asString);
  CalcularMontoTotal;
end;

procedure TDM_OrdenesDePago.CalcularMontoTotal;
var
  acumular: double;
begin
  acumular:= DM_Compras.SumaComprasOP (tbOrdenesPago.FieldByName('idOrdenPago').asString);

  With tbOrdenesPago do
  begin
    Edit;
    FieldByName('nTotalAPagar').asFloat:= acumular;
    FieldByName('nPagado').asFloat:= CalcularValores;
    Post;
  end;
end;

function TDM_OrdenesDePago.CalcularValores: double;
var
  acum: double;
begin
 // Result:= DM_Compras.SumaComprasOP (tbOrdenesPago.FieldByName('idOrdenPago').asString);
  with tbOPFormasDePago do
  begin
    DisableControls;
    First;
    acum:= 0;
    While NOT eof do
    begin
      acum:= acum + FieldByName('nMonto').asFloat;
      Next;
    end;
    EnableControls;
    Result:= acum;
  end;
end;

procedure TDM_OrdenesDePago.EliminarComprobante(refCompra: string);
begin
  with DM_Compras do
  begin
    DM_Compras.DesasociarOP(refCompra);
  end;
end;

procedure TDM_OrdenesDePago.EliminarValor;
begin
  if (tbOPFormasDePago.RecordCount > 0) then
  begin
    with tbOPFormasDePagoDEL do
    begin
      ParamByName('idOPFormaDePago').asString:= tbOPFormasDePago.FieldByName('idOPFormaDePago').AsString;
      ExecSQL;
    end;
    tbOPFormasDePago.Delete;
  end;
end;

function TDM_OrdenesDePago.CargarValor(refFormaPago: integer;
  refCheque: GUID_ID; refBanco: integer; Monto: double; Banco, NroCheque: string
  ): GUID_ID;
var
  elID: GUID_ID;
begin
  elID:= DM_General.CrearGUID;
  with tbOPFormasDePago do
  begin
    Insert;
    FieldByName('idOPFormaDePago').asString:= elID;
    FieldByName('refFormaPago').asInteger:= refFormaPago;
    FieldByName('refCheque').asString:= refCheque;
    FieldByName('refBanco').asInteger:= refBanco;
    FieldByName('nMonto').asFloat:= Monto;
    FieldByName('lxBanco').asString:= ObtenerBanco (refBanco);
    FieldByName('lxFormaDePago').AsString:= ObtenerFormaPago (refFormaPago);
    FieldByName('lxNroCheque').asString:= NroCheque;
    FieldByName('lxFechaCheque').asString:= ObtenerfVtoCheque (FieldByName('refCheque').asString);
    Post;
  end;
  Result:= elID;
end;

procedure TDM_OrdenesDePago.RealizarPago(refFormaPago, refCompra: GUID_ID;
  nMonto: double);
begin
  with tbComprasPagos do
  begin
    Insert;
    FieldByName('refCompra').asString:= refCompra;
    FieldByName('refOPFormaDePago').asString:= refFormaPago;
    FieldByName('nMonto').asFloat:= nMonto;
    Post;
  end;
end;

procedure TDM_OrdenesDePago.Grabar;
begin
  MarcarComprobantes;
  DM_General.GrabarDatos(tbOrdenesPagoSEL, tbOrdenesPagoINS, tbOrdenesPagoUPD, tbOrdenesPago, 'idOrdenPago');
  DM_General.GrabarDatos(tbOPComprobantesSEL, tbComprobantesINS, tbComprobantesUPD, tbOPComprobantes, 'idOPComprobante');
  DM_General.GrabarDatos(tbOPFormasDePagoSEL, tbOPFormasDePagoINS, tbOPFormasDePagoUPD, tbOPFormasDePago, 'idOpFormaDePago');
end;

procedure TDM_OrdenesDePago.LevantarOP(refOP: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbOrdenesPago);
  DM_General.ReiniciarTabla(tbOPComprobantes);
  DM_General.ReiniciarTabla(tbResultados);
  DM_General.ReiniciarTabla(tbOPFormasDePago);

  with tbOrdenesPagoSEL do
  begin
    if active then close;
    ParamByName('idOrdenPago').asString:= refOP;
    Open;

    tbOrdenesPago.LoadFromDataSet(tbOrdenesPagoSEL, 0, lmAppend);
  end;

  with qComprobantesPorOP do
  begin
    if active then close;
    ParamByName('refOrdenPago').asString:= refOP;
    Open;

    tbOPComprobantes.LoadFromDataSet(qComprobantesPorOP, 0, lmAppend);
  end;

  with qOPFormasPago do
  begin
    if active then close;
    ParamByName('refOrdenPago').asString:= refOP;
    Open;

    tbOPFormasDePago.LoadFromDataSet(qOPFormasPago, 0, lmAppend);
  end;
  with tbOPFormasDePago do
  begin
    if RecordCount > 0 then
      First;
    While NOT eof do
    begin
      Edit;
      FieldByName('lxNroCheque').asString:= ObtenerNroCheque (FieldByName('refCheque').asString);
      FieldByName('lxFechaCheque').asString:= ObtenerfVtoCheque (FieldByName('refCheque').asString);
      FieldByName('lxBanco').asString:= ObtenerBanco (FieldByName('refBanco').asInteger);
      FieldByName('lxFormaDePago').asString:= ObtenerFormaPago (FieldByName('refFormaPago').asInteger);
      Post;
      Next;
    end;

  end;
  DM_Compras.LevantarComprasPorOP(refOP);
end;

procedure TDM_OrdenesDePago.EliminarOrdenPago(refOP: GUID_ID);
begin
  LevantarOP(refOP);
  With tbOPComprobantes do
  begin
    if RecordCount > 0 then
      First;
    While NOT EOF do
    begin
      DM_Compras.DesmarcarComprobantePagado(FieldByName('refCompra').asString);
      EliminarPago(refOP, FieldByName('refCompra').asString);
      Next;
    end;
  end;

  with tbOrdenesPagoDEL do
  begin
    ParamByName('idOrdenPago').asString:= refOP;
    ExecSQL;
  end;
end;

procedure TDM_OrdenesDePago.LevantarComprasPagos(refCompra: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbComprasPagos);
  with qPagosCompras do
  begin
    if active then close;
    ParamByName('refCompra').asString:= refCompra;
    Open;
    tbComprasPagos.LoadFromDataSet(qPagosCompras, 0, lmAppend);
    Close;
  end;
end;


end.

