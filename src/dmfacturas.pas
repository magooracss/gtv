unit dmfacturas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, rxmemds
  ,dmgeneral, db
  ;

type

  { TDM_Facturas }

  TDM_Facturas = class(TDataModule)
    qListaRecibos: TZQuery;
    qListaRecibosBVISIBLE: TSmallintField;
    qListaRecibosBVISIBLE_1: TSmallintField;
    qListaRecibosCCODIGO: TStringField;
    qListaRecibosCCUIT: TStringField;
    qListaRecibosCDOMICILIO: TStringField;
    qListaRecibosCENTRECALLE1: TStringField;
    qListaRecibosCENTRECALLE2: TStringField;
    qListaRecibosCLIENTEEMPRESA_ID: TStringField;
    qListaRecibosCMANZANA: TStringField;
    qListaRecibosCNOMBRE: TStringField;
    qListaRecibosCNROCASA: TStringField;
    qListaRecibosCPARCELA: TStringField;
    qListaRecibosCSECCION: TStringField;
    qListaRecibosDETALLE: TStringField;
    qListaRecibosESTADO: TStringField;
    qListaRecibosESTADO_ID: TLongintField;
    qListaRecibosFANULACION: TDateField;
    qListaRecibosFECHA: TDateField;
    qListaRecibosFINICIO: TDateField;
    qListaRecibosHABILITACIONEXP: TStringField;
    qListaRecibosHABILITACIONFECHA: TDateField;
    qListaRecibosID: TStringField;
    qListaRecibosIDCLIENTE: TStringField;
    qListaRecibosIDRECIBOESTADO: TLongintField;
    qListaRecibosNIVA: TFloatField;
    qListaRecibosNMONTOABONO: TFloatField;
    qListaRecibosNROPTOVENTA: TLongintField;
    qListaRecibosNRORECIBO: TLongintField;
    qListaRecibosREFABONO: TLongintField;
    qListaRecibosREFADMINISTRADOR: TStringField;
    qListaRecibosREFCONDICIONFISCAL: TLongintField;
    qListaRecibosREFCONSERVADOR: TStringField;
    qListaRecibosREFDESTINO: TLongintField;
    qListaRecibosREFGRUPOFACTURACION: TLongintField;
    qListaRecibosREFLOCALIDAD: TLongintField;
    qListaRecibosREFRESPTECNICO: TStringField;
    qListaRecibosUNIDADFUNCIONAL: TLongintField;
    Facturas: TRxMemoryData;
    FacturasclienteEmpresa_id: TStringField;
    FacturasDetalle: TStringField;
    Facturasestado_id: TLongintField;
    FacturasfAnulacion: TDateTimeField;
    FacturasFecha: TDateTimeField;
    Facturasid: TStringField;
    RecibosINS: TZQuery;
    FacturaslxEstado: TStringField;
    FacturasnroPtoVenta: TLongintField;
    FacturasnroRecibo: TLongintField;
    RecibosSEL: TZQuery;
    RecibosSELCLIENTEEMPRESA_ID: TStringField;
    RecibosSELDETALLE: TStringField;
    RecibosSELESTADO_ID: TLongintField;
    RecibosSELFANULACION: TDateField;
    RecibosSELFECHA: TDateField;
    RecibosSELID: TStringField;
    RecibosSELLXESTADO: TStringField;
    RecibosSELNROPTOVENTA: TLongintField;
    RecibosSELNRORECIBO: TLongintField;
    RecibosUPD: TZQuery;
    tbReclamosDEL: TZQuery;
  private
    { private declarations }
  public
    procedure LevantarFacturas;

    procedure CargarCliente (idCliente: GUID_ID);

    procedure NuevaFactura;
  end;

var
  DM_Facturas: TDM_Facturas;

implementation

{$R *.lfm}

{ TDM_Facturas }

procedure TDM_Facturas.LevantarFacturas;
begin

end;

procedure TDM_Facturas.CargarCliente(idCliente: GUID_ID);
begin

end;

procedure TDM_Facturas.NuevaFactura;
begin

end;

end.

