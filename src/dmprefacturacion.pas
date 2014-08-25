unit dmprefacturacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, db, ZDataset
  ,dmgeneral, dmConexion;



type

  { TDM_Prefacturacion }

  TDM_Prefacturacion = class(TDataModule)
    facturasSELCLIENTEEMPRESA_ID: TStringField;
    facturasSELCONDICIONVENTA_ID: TLongintField;
    facturasSELESTADO_ID: TLongintField;
    facturasSELFANULACION: TDateField;
    facturasSELFECHA: TDateField;
    facturasSELID: TStringField;
    facturasSELIMPIMPUESTOS: TFloatField;
    facturasSELIMPIVA: TFloatField;
    facturasSELIMPNETO: TFloatField;
    facturasSELNROFACTURA: TLongintField;
    facturasSELNROPTOVENTA: TLongintField;
    facturasSELOBSERVACIONES: TStringField;
    facturasSELTIPOFACTURA_ID: TLongintField;
    Prefacturacion: TRxMemoryData;
    PrefacturacionbVisible: TLongintField;
    Prefacturacioncantidad: TFloatField;
    Prefacturacioncliente_id: TStringField;
    Prefacturaciondetalle: TStringField;
    Prefacturaciondocumento_id: TStringField;
    Prefacturacionfecha: TDateTimeField;
    Prefacturacionid: TStringField;
    PrefacturacionlxCliente: TStringField;
    PrefacturacionlxClienteCodigo: TStringField;
    PrefacturacionlxDocumento: TStringField;
    PrefacturacionlxEstado: TStringField;
    PrefacturacionlxNro: TLongintField;
    PrefacturacionnroPreFactura: TLongintField;
    PrefacturacionNroPresupuesto: TLongintField;
    PrefacturacionPrecioTotal: TFloatField;
    PrefacturacionPrecioUnitario: TFloatField;
    PrefacturacionrefEstado: TLongintField;
    PrefacturacionRemitoNro: TLongintField;
    PrefacturacionSELBVISIBLE: TSmallintField;
    PrefacturacionSELCANTIDAD: TFloatField;
    PrefacturacionSELCLIENTE_ID: TStringField;
    PrefacturacionSELDETALLE: TStringField;
    PrefacturacionSELDOCUMENTO_ID: TStringField;
    PrefacturacionSELFECHA: TDateField;
    PrefacturacionSELID: TStringField;
    PrefacturacionSELNROPREFACTURA: TLongintField;
    PrefacturacionSELPRECIOTOTAL: TFloatField;
    PrefacturacionSELPRECIOUNITARIO: TFloatField;
    PrefacturacionSELREFESTADO: TSmallintField;
    PrefacturacionSELTIPODOCUMENTO: TSmallintField;
    PrefacturaciontipoDocumento: TLongintField;
    qDocPrefacturados: TZQuery;
    qNuevoNroPrefacturaNRO: TLargeintField;
    qPrefacturasExistentes: TZQuery;
    qDocPrefacturadosBVISIBLE: TSmallintField;
    qDocPrefacturadosCANTIDAD: TFloatField;
    qDocPrefacturadosCLIENTECODIGO: TStringField;
    qDocPrefacturadosCLIENTENOMBRE: TStringField;
    qDocPrefacturadosCLIENTE_ID: TStringField;
    qDocPrefacturadosDETALLE: TStringField;
    qDocPrefacturadosDOCUMENTO_ID: TStringField;
    qDocPrefacturadosFECHA: TDateField;
    qDocPrefacturadosID: TStringField;
    qDocPrefacturadosNROPREFACTURA: TLongintField;
    qDocPrefacturadosNROPRESUPUESTO: TLongintField;
    qDocPrefacturadosPRECIOTOTAL: TFloatField;
    qDocPrefacturadosPRECIOUNITARIO: TFloatField;
    qDocPrefacturadosPRESUPUESTOCUOTA: TLongintField;
    qDocPrefacturadosPRESUPUESTOMONTO: TFloatField;
    qDocPrefacturadosPRESUPUESTOVENCIMIENTO: TDateField;
    qDocPrefacturadosREFESTADO: TSmallintField;
    qDocPrefacturadosREMITODETALLES: TStringField;
    qDocPrefacturadosREMITOFECHA: TDateField;
    qDocPrefacturadosREMITONRO: TLongintField;
    qDocPrefacturadosTIPODOCUMENTO: TSmallintField;
    qNuevoNroPrefactura: TZQuery;
    qPrefacturasExistentesNROPREFACTURA: TLongintField;
    qPrefacturasExistentesTOTAL: TFloatField;
    qPresupuestosSinPFBACEPTADO: TSmallintField;
    qPresupuestosSinPFBVISIBLE: TLongintField;
    qPresupuestosSinPFBVISIBLE_1: TSmallintField;
    qPresupuestosSinPFCRECEPCIONO: TStringField;
    qPresupuestosSinPFFCAMBIOESTADO: TDateField;
    qPresupuestosSinPFFEMISION: TDateField;
    qPresupuestosSinPFFPAGO: TDateField;
    qPresupuestosSinPFFVENCIMIENTO: TDateField;
    qPresupuestosSinPFIDCUOTAPRESUPUESTO: TStringField;
    qPresupuestosSinPFIDPRESUPUESTO: TStringField;
    qPresupuestosSinPFNMONTO: TFloatField;
    qPresupuestosSinPFNNROCUOTA: TLongintField;
    qPresupuestosSinPFNPRESUPUESTO: TLongintField;
    qPresupuestosSinPFREFCLIENTE: TStringField;
    qPresupuestosSinPFREFEMPLEADO: TLongintField;
    qPresupuestosSinPFREFESTADO: TLongintField;
    qPresupuestosSinPFREFESTADO_1: TLongintField;
    qPresupuestosSinPFREFPRESUPUESTO: TStringField;
    qPresupuestosSinPFREFTIPO: TLongintField;
    qPresupuestosSinPFTXDOCUMENTO: TBlobField;
    qPresupuestosSinPFTXMOTIVO: TStringField;
    qPresupuestosSinPFTXOBSERVACIONES: TStringField;
    qRemitosSinPF: TZQuery;
    qPresupuestosSinPF: TZQuery;
    PrefacturacionSEL: TZQuery;
    PrefacturacionINS: TZQuery;
    PrefacturacionUPD: TZQuery;
    qRemitosSinPFBFACTURADO: TSmallintField;
    qRemitosSinPFBFACTURADO3: TSmallintField;
    qRemitosSinPFBFACTURAR: TSmallintField;
    qRemitosSinPFBFACTURAR3: TSmallintField;
    qRemitosSinPFBPRESENTADO: TSmallintField;
    qRemitosSinPFBPRESENTADO3: TSmallintField;
    qRemitosSinPFBSINCARGO: TSmallintField;
    qRemitosSinPFBSINCARGO3: TSmallintField;
    qRemitosSinPFBVISIBLE: TSmallintField;
    qRemitosSinPFBVISIBLE3: TSmallintField;
    qRemitosSinPFFFECHA: TDateField;
    qRemitosSinPFFFECHA3: TDateField;
    qRemitosSinPFIDREMITO: TStringField;
    qRemitosSinPFIDREMITO3: TStringField;
    qRemitosSinPFNREMITO: TLongintField;
    qRemitosSinPFNREMITO3: TLongintField;
    qRemitosSinPFREFCLIENTE: TStringField;
    qRemitosSinPFREFCLIENTE3: TStringField;
    qRemitosSinPFREFFACTURA: TStringField;
    qRemitosSinPFREFFACTURA3: TStringField;
    qRemitosSinPFREFMOTIVO: TLongintField;
    qRemitosSinPFREFMOTIVO3: TLongintField;
    qRemitosSinPFREFORDENTRABAJO: TStringField;
    qRemitosSinPFREFORDENTRABAJO3: TStringField;
    qRemitosSinPFTXDETALLES: TStringField;
    qRemitosSinPFTXDETALLES3: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure PrefacturacionAfterInsert(DataSet: TDataSet);
  private
    procedure AjustarTablaMemoria;
  public
    procedure LevantarPrefacturacion (documento, estado: integer; idCliente: GUID_ID);
    procedure levantarDocumentosSinPrefacturar;
    procedure Grabar;

    procedure LevantarPrefacturasCliente(cliente_id: GUID_ID);

    procedure AsignarNuevoNroPrefactura;
    procedure CambiarEstado (refEstado: integer);
    procedure AsignarNroPrefactura (nro: integer);
    procedure QuitarNroPrefactura;
  end;

var
  DM_Prefacturacion: TDM_Prefacturacion;

implementation
{$R *.lfm}
uses
  dateutils
  ,dmclientes
  ;

const
   TD_LIBRE = 0; //Tipo de documento libre
   TD_REMITO = 1; //Tipo de documento remito
   TD_PRESUPUESTO = 2; //Tipo de documento presupuesto

   EP_NULO = -1; //Estado nulo
   EP_PARAFACTURAR = 0;//Estado prefacturacion: Para facturar: No esta prefacturado
   EP_PREFACTURADO = 1;//Estado Prefacturacion: Ya paso por la prefacturacion y tiene Nro
   EP_FACTURADO = 2;  //Estado Prefacturacion: Ya tiene asociada una factura legal

{ TDM_Prefacturacion }

procedure TDM_Prefacturacion.PrefacturacionAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
     Prefacturacionid.AsString:= DM_General.CrearGUID;
     Prefacturacioncliente_id.asString:= GUIDNULO;
     Prefacturacionfecha.AsDateTime:= Now;
     Prefacturaciondocumento_id.AsString:= GUIDNULO;
     PrefacturaciontipoDocumento.AsInteger:= TD_LIBRE;
     Prefacturacioncantidad.AsFloat:= 0;
     Prefacturaciondetalle.asString:= EmptyStr;
     PrefacturacionPrecioUnitario.AsFloat:= 0;
     PrefacturacionPrecioTotal.AsFloat:= 0;
     PrefacturacionrefEstado.AsInteger:= EP_PARAFACTURAR;
     PrefacturacionnroPreFactura.AsInteger:= 0;
     PrefacturacionbVisible.AsInteger:= 1;
  end;
end;

procedure TDM_Prefacturacion.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(TDataModule(self) , true);
end;

procedure TDM_Prefacturacion.AjustarTablaMemoria;
var
  clienteActual: GUID_ID;
begin
  with Prefacturacion do
  begin
    First;
    clienteActual:= GUIDNULO;
    While Not EOF do
    begin
      if (clienteActual <> Prefacturacioncliente_id.AsString) then
      begin
        clienteActual:= Prefacturacioncliente_id.AsString;
        DM_Clientes.ClienteEditar(clienteActual);
      end;
      Edit;
      PrefacturacionlxCliente.AsString:= DM_Clientes.tbClientescNombre.AsString;
      PrefacturacionlxClienteCodigo.AsString:= DM_Clientes.tbClientescCodigo.AsString;
      case PrefacturaciontipoDocumento.asInteger of
        TD_LIBRE: PrefacturacionlxDocumento.asString:= 'SIN DOCUMENTO';
        TD_REMITO:
        begin
          PrefacturacionlxDocumento.asString:= 'REMITO';
          PrefacturacionlxNro.AsInteger:= PrefacturacionRemitoNro.AsInteger;
        end;
        TD_PRESUPUESTO:
        begin
          PrefacturacionlxDocumento.asString:= 'PRESUPUESTO';
          PrefacturacionlxNro.AsInteger:= PrefacturacionNroPresupuesto.AsInteger;
        end;
      end;
      case PrefacturacionrefEstado.AsInteger of
       EP_NULO: PrefacturacionlxEstado.AsString:= '-';
       EP_PARAFACTURAR: PrefacturacionlxEstado.AsString:= 'PARA FACTURAR';
       EP_PREFACTURADO: PrefacturacionlxEstado.AsString:= 'PREFACTURADO';
       EP_FACTURADO: PrefacturacionlxEstado.AsString:= 'FACTURADO';
      end;

      Post;
      Next;
    end;
  end;
end;

procedure TDM_Prefacturacion.LevantarPrefacturacion(documento, estado: integer; idCliente: GUID_ID);
var
  consulta: string;
begin
  consulta:= 'SELECT P.ID, P.CLIENTE_ID, P.FECHA, P.DOCUMENTO_ID, P.TIPODOCUMENTO '
           + ', P.CANTIDAD, P.DETALLE, P.PRECIOUNITARIO, P.PRECIOTOTAL, P.REFESTADO '
           + ', P.NROPREFACTURA, P.BVISIBLE, C.cCodigo as ClienteCodigo '
           + ', C.cNombre as ClienteNombre, CPR.nNroCuota as PresupuestoCuota '
           + ', CPR.nMonto as PresupuestoMonto, CPR.fVencimiento as PresupuestoVencimiento '
           + ', R.nRemito as RemitoNro, R.fFecha as RemitoFecha, R.txDetalles as RemitoDetalles '
           + ', PR.nPresupuesto as NroPresupuesto '
           + ' FROM '
           + '      Prefacturacion P '
           + '	 LEFT JOIN tbClientes C ON C.idCliente = P.cliente_id '
           + '	 LEFT JOIN tbCuotasPresupuesto CPR ON CPR.idCuotaPresupuesto = P.DOCUMENTO_ID '
           + '	 LEFT JOIN tbRemitos R ON R.idRemito = P.DOCUMENTO_ID '
           + '	 LEFT JOIN tbPresupuestos PR ON CPR.refPresupuesto = PR.idPresupuesto  '
           ;

  consulta:= consulta + ' WHERE (P.bVisible = 1) ';
  if (documento <> TD_LIBRE) then
    consulta:= consulta + ' AND (P.TipoDocumento ='+ intToStr(documento)+') ';

  if (estado <> EP_NULO) then
    consulta:= consulta + ' AND (P.refEstado = ' + intToStr(estado) + ') ' ;

  if (idCliente <> GUIDNULO) then
    consulta:= consulta + ' AND (P.cliente_id = ''' + idCliente + ''') ';

  with qDocPrefacturados do
  begin
    DM_General.ReiniciarTabla(Prefacturacion);
    if active then close;
    SQL.Clear;
    SQL.Add(consulta);
    Open;
    Prefacturacion.LoadFromDataSet(qDocPrefacturados, 0, lmAppend);
    close;
  end;

  AjustarTablaMemoria;
  Prefacturacion.SortOnFields('lxClienteCodigo;fecha');
  Prefacturacion.First;

end;

procedure TDM_Prefacturacion.levantarDocumentosSinPrefacturar;
const
   _CONF_CORTEMES = 20;
var
  y,m,d: word;
begin
  //Levanto los remitos que no estan cargados en la tabla de Prefacturacion
  with qRemitosSinPF do
  begin
     if Active then Close;
     Open;
     while NOT EOF do
     begin
       Prefacturacion.Insert;
       Prefacturacioncliente_id.AsString:= qRemitosSinPFREFCLIENTE.AsString;
       Prefacturacionfecha.AsDateTime:= qRemitosSinPFFFECHA.AsDateTime;
       Prefacturaciondocumento_id.AsString:= qRemitosSinPFIDREMITO.AsString;
       PrefacturaciontipoDocumento.AsInteger:= TD_REMITO;
       PrefacturacionlxNro.AsInteger:= qRemitosSinPFNREMITO.AsInteger;
       Prefacturaciondetalle.AsString:= qRemitosSinPFTXDETALLES.AsString;
       Prefacturacion.Post;
       Next;
     end;
  end;

  //Levanto las cuotas impagas de los presupuestos
  with qPresupuestosSinPF do
  begin
    if Active then Close;

       // Aplico un corte de mes para saber si calculo el vencimiento a partir de el mes corriente o del siguiente
    DecodeDate(Now, y, m, d);
    if (d >= _CONF_CORTEMES) then
      IncAMonth(d, m, y, 1);

    ParamByName('Vencimiento').AsDate:= EndOfAMonth(y, m);
    Open;

    while NOT EOF do
    begin
      Prefacturacion.Insert;
      Prefacturacioncliente_id.AsString:= qPresupuestosSinPFREFCLIENTE.AsString;
      Prefacturacionfecha.AsDateTime:= qPresupuestosSinPFFVENCIMIENTO.AsDateTime;
      Prefacturaciondocumento_id.AsString:= qPresupuestosSinPFIDCUOTAPRESUPUESTO.AsString;
      PrefacturaciontipoDocumento.AsInteger:= TD_PRESUPUESTO;
      PrefacturacionlxNro.AsInteger:= qPresupuestosSinPFNPRESUPUESTO.AsInteger;
      Prefacturaciondetalle.AsString:= 'CUOTA: ' + IntToStr(qPresupuestosSinPFNNROCUOTA.AsInteger);
      PrefacturacionPrecioUnitario.AsFloat:= qPresupuestosSinPFNMONTO.AsFloat;
      PrefacturacionPrecioTotal.AsFloat:= qPresupuestosSinPFNMONTO.AsFloat;
      Prefacturacion.Post;
      Next;
    end;
  end;

 AjustarTablaMemoria;
 Prefacturacion.SortOnFields('lxClienteCodigo;fecha');
 Prefacturacion.First;
end;

procedure TDM_Prefacturacion.Grabar;
begin
  DM_General.GrabarDatos(PrefacturacionSEL, PrefacturacionINS, PrefacturacionUPD, Prefacturacion, 'id');
end;

procedure TDM_Prefacturacion.LevantarPrefacturasCliente(cliente_id: GUID_ID);
begin
  with qPrefacturasExistentes do
  begin
    if Active then Close;
    ParamByName('elCliente').AsString:= cliente_id;
    Open;
  end;
end;

procedure TDM_Prefacturacion.AsignarNuevoNroPrefactura;
var
  nroNuevo: integer;
begin
  with qNuevoNroPrefactura do
  begin
    if Active then Close;
    Open;
    nroNuevo:=qNuevoNroPrefacturaNRO.AsInteger;
    Close;
  end;

  With Prefacturacion do
  begin
    Edit;
    PrefacturacionnroPreFactura.AsInteger:= nroNuevo;
    Post;
  end;
end;

procedure TDM_Prefacturacion.CambiarEstado(refEstado: integer);
begin
  With Prefacturacion do
  begin
    Edit;
    PrefacturacionrefEstado.AsInteger:= refEstado;
    Post;
  end;
end;

procedure TDM_Prefacturacion.AsignarNroPrefactura(nro: integer);
begin
  With Prefacturacion do
  begin
    Edit;
    PrefacturacionnroPreFactura.AsInteger:= nro;
    Post;
  end;
end;

procedure TDM_Prefacturacion.QuitarNroPrefactura;
begin
  AsignarNroPrefactura(0);
end;

end.

