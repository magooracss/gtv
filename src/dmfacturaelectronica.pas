unit dmfacturaelectronica;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset
  ,dmgeneral
  ,dmfacturas, dbf, db
  ;

type

  { TDM_FacturaElectronica }

  TDM_FacturaElectronica = class(TDataModule)
    comprobaNRO: TLongintField;
    comprobaPTOVTA: TLongintField;
    comprobaTIPO: TLongintField;
    comprobaTIPOREG: TLongintField;
    encabeza: TDbf;
    comproba: TDbf;
    encabezaCAE: TLargeintField;
    encabezaCBTDESDE: TLongintField;
    encabezaCBTHASTA: TLongintField;
    encabezaCONCEPTO: TSmallintField;
    encabezaEMISIONTIP: TStringField;
    encabezaERRCODE: TStringField;
    encabezaERRMSG: TMemoField;
    encabezaFCHVENCCAE: TStringField;
    encabezaFECHACBTE: TStringField;
    encabezaFECHASERVD: TStringField;
    encabezaFECHASERVH: TStringField;
    encabezaFECHAVENCP: TStringField;
    encabezaIMPIVA: TFloatField;
    encabezaIMPNETO: TFloatField;
    encabezaIMPOPEX: TFloatField;
    encabezaIMPTOTAL: TFloatField;
    encabezaIMPTOTCONC: TFloatField;
    encabezaIMPTRIB: TFloatField;
    encabezaMONEDACTZ: TFloatField;
    encabezaMONEDAID: TStringField;
    encabezaMOTIVOSOBS: TMemoField;
    encabezaNOUSAR: TFloatField;
    encabezaNRODOC: TLargeintField;
    encabezaPUNTOVTA: TSmallintField;
    encabezaREPROCESO: TStringField;
    encabezaRESULTADO: TStringField;
    encabezaTIPOCBTE: TSmallintField;
    encabezaTIPODOC: TSmallintField;
    encabezaTIPOREG: TSmallintField;
    qFacturaCLIENTEEMPRESA_ID: TStringField;
    qFacturaCONDICIONVENTA_ID: TLongintField;
    qFacturaESTADO_ID: TLongintField;
    qFacturaFANULACION: TDateField;
    qFacturaFECHA: TDateField;
    qFacturaID: TStringField;
    qFacturaNROFACTURA: TLongintField;
    qFacturaNROPTOVENTA: TLongintField;
    qFacturaOBSERVACIONES: TStringField;
    qFacturaTIPOFACTURA_ID: TLongintField;
    ivaBASEIMP: TFloatField;
    ivaID: TStringField;
    ivaIMPORTE: TFloatField;
    ivaTIPOREG: TLongintField;
    tributo: TDbf;
    iva: TDbf;
    tributoALIC: TFloatField;
    tributoBASEIMP: TFloatField;
    tributoDESC: TStringField;
    tributoID: TStringField;
    tributoIMPORTE: TFloatField;
    tributoTIPOREG: TSmallintField;
  private
    { private declarations }
    procedure CargarDBFs;
    procedure EjecutarRECE;
  public
    procedure Facturar (factura_id: GUID_ID);
  end;

var
  DM_FacturaElectronica: TDM_FacturaElectronica;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  , dmclientes
  , dateutils
  , Process
  , ShellApi
  ;


{ TDM_FacturaElectronica }

procedure TDM_FacturaElectronica.CargarDBFs;
var
  RutaDBF: string;
  montoneto, montoiva, porcIVA: double;
begin
  RutaDBF:= LeerDato(SECCION_FACTURACION, RUTA_DBF);
  DM_Clientes.ClienteEditar(DM_Facturas.FacturasclienteEmpresa_id.AsString);
  montoneto:= DM_Facturas.FacturasimpNeto.AsFloat;
  montoiva:= DM_Facturas.FacturasimpIVA.AsFloat;
  porcIVA:= DM_Clientes.tbClientesnIVA.AsFloat;

  encabeza.Active:= false;
  encabeza.FilePathFull:= RutaDBF;
  encabeza.TableName := 'encabeza.dbf';
  encabeza.Open;
  encabeza.Zap;
  encabeza.Insert;

  encabezaTIPOREG.AsInteger:= 0;
  encabezaFECHACBTE.AsString:= FormatDateTime('YYYYMMDD', DM_Facturas.FacturasFecha.AsDateTime);
  encabezaPUNTOVTA.AsInteger:= DM_Facturas.FacturasnroPtoVenta.AsInteger;
  encabezaCBTDESDE.AsString:= FormatDateTime('YYYYMMDD', DM_Facturas.FacturasFecha.AsDateTime);
  encabezaCBTHASTA.AsString:= FormatDateTime('YYYYMMDD', DM_Facturas.FacturasFecha.AsDateTime);
  encabezaCONCEPTO.AsInteger:= 3; //3 = Productos y servicios
  encabezaTIPODOC.AsInteger:= 80; //80 = CUIT
  encabezaNRODOC.AsInteger:= DM_General.CuitANro (DM_Clientes.tbClientescCUIT.AsString);
  encabezaIMPTOTAL.AsFloat:= montoneto + montoiva;
  encabezaIMPTOTCONC.asFloat:= 0;
  encabezaIMPNETO.AsFloat:= montoneto;
  encabezaIMPIVA.AsFloat:= montoiva;
  encabezaIMPTRIB.AsFloat:= 0;
  encabezaIMPOPEX.asFloat:= 0;
  encabezaMONEDAID.AsString:= 'PES'; //Moneda PESOS
  encabezaMONEDACTZ.AsString:= '0';
  encabezaFECHAVENCP.AsString:= FormatDateTime('YYYYMMDD', IncDay (DM_Facturas.FacturasFecha.AsDateTime, 30));

  encabeza.Post;
  encabeza.Close;

  tributo.Active:= false;
  tributo.FilePathFull:= RutaDBF;
  tributo.TableName := 'tributo.dbf';
  tributo.Active:= true;
  tributo.Zap;
  tributo.Insert;

  tributo.close;

  iva.Active:= false;
  iva.FilePathFull:= RutaDBF;
  iva.TableName := 'iva.dbf';
  iva.Open;
  iva.Zap;
  iva.Insert;
  ivaTIPOREG.AsInteger:= 0;
  if porcIVA = 10.5 then
    ivaID.asString:= '4'
  else
    if porcIVA = 0 then
      ivaID.AsString:= '2'
    else // iva = 21
      ivaID.AsString:= '5';
  ivaBASEIMP.AsFloat:= montoneto;    //Total al que se le aplica el iva
  ivaIMPORTE.AsFloat:= montoiva; // (montoneto * (montoIVA / 100));    // Monto del iva calculado

  iva.Post;
  iva.close;

  (** TABLA PARA COMPROBANTES ASOCIADOS, REMITOS / NOTAS DE CREDITO o DEBITO**)
  comproba.Active:= false;
  comproba.FilePathFull:= RutaDBF;
  comproba.TableName := 'comproba.dbf';
  comproba.Open;
  comproba.Zap;
  comproba.Insert;
(*
  comprobaTIPOREG.AsInteger:= 0;
  case DM_Facturas.FacturastipoFactura_id of
   FACTURA_A : comprobaTIPO.AsInteger:= 1;
   FACTURA_B : comprobaTIPO.AsInteger:= 6;
   FACTURA_C : comprobaTIPO.AsInteger:= 11;
  end;
  comprobaPTOVTA.asInteger:= DM_Facturas.FacturasnroPtoVenta.AsInteger;
  comprobaNRO.asInteger:= DM_Facturas.FacturasnroFactura.AsInteger;
*)
  comproba.close;

end;

procedure TDM_FacturaElectronica.EjecutarRECE;
var
  elProceso: TProcess;
  rutaRECE: string;
begin
  rutaRECE:= LeerDato(SECCION_FACTURACION, RUTA_RECE);
  //SysUtils.ExecuteProcess('C:\Archivos de programa\PyAfipWs\RECE1.EXE', '', []);

  ShellExecute(0, PChar ('open'), PChar('cmd'), PChar('/c '+  rutaRECE), nil, 1);
 (*
  elProceso := TProcess.Create(nil);
  try
//    elProceso.Executable := 'C:\Archivos de programa\PyAfipWs\RECE1.EXE';
//    elProceso.Parameters.Add(' /dbf');
    elProceso.CommandLine:= 'C:\Archivos de programa\PyAfipWs\RECE1.EXE /dbf';
    //rutaRECE;
     // Definimos una opción de comportamiento de 'TProccess'
     // La opción poWaitOnExit hará que nuestro programa
     // se detenga hasta que termine el programa lanzado
     elProceso.Options := elProceso.Options + [poNewConsole, poWaitOnExit];
     elProceso.Execute;
     Sleep (10000);
  finally
    elProceso.Free;
  end;
  *)
end;

procedure TDM_FacturaElectronica.Facturar(factura_id: GUID_ID);
begin
  DM_Facturas.LevantarFacturaID(factura_id);
  //CargarDBFs;
  EjecutarRECE;
end;

end.

