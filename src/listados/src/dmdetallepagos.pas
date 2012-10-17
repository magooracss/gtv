unit dmdetallepagos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmgeneral;

type

  { TDM_DetallePagos }

  TDM_DetallePagos = class(TDataModule)
    ds_qOP: TDatasource;
    qFacturasBPAGADA: TFloatField;
    qFacturasBVISIBLE: TSmallintField;
    qFacturasBVISIBLE_1: TSmallintField;
    qFacturasFECHA: TDateField;
    qFacturasIDCOMPRA: TStringField;
    qFacturasIDCOMPRAPAGO: TStringField;
    qFacturasIDTIPOCOMPROBANTE: TLongintField;
    qFacturasNMONTO: TFloatField;
    qFacturasNROFACTURA: TLongintField;
    qFacturasNROPTOVENTA: TLongintField;
    qFacturasNTOTAL: TFloatField;
    qFacturasPERCEPCAPITAL: TFloatField;
    qFacturasPERCEPIVA: TFloatField;
    qFacturasPERCEPPROVINCIA: TFloatField;
    qFacturasREFCOMPRA: TStringField;
    qFacturasREFCONDPAGO: TLongintField;
    qFacturasREFCONDPAGOTIEMPO: TLongintField;
    qFacturasREFOP: TStringField;
    qFacturasREFORDENPAGO: TStringField;
    qFacturasREFPROVEEDOR: TStringField;
    qFacturasREFTIPOCOMPROBANTE: TLongintField;
    qFacturasTIPOCOMPROBANTE: TStringField;
    qOP: TZQuery;
    qFacturas: TZQuery;
    qOPBVISIBLE: TSmallintField;
    qOPBVISIBLE_1: TSmallintField;
    qOPCCONTACTO: TStringField;
    qOPCCORREOS: TStringField;
    qOPCCUIT: TStringField;
    qOPCDOMICILIO: TStringField;
    qOPCINGRESOSBRUTOS: TStringField;
    qOPCNOMBREFANTASIA: TStringField;
    qOPCRAZONSOCIAL: TStringField;
    qOPCTELEFONOS: TStringField;
    qOPCWEB: TStringField;
    qOPFFECHA: TDateField;
    qOPIDORDENPAGO: TStringField;
    qOPIDPROVEEDOR: TStringField;
    qOPNPAGADO: TFloatField;
    qOPNTOTALAPAGAR: TFloatField;
    qOPNUMEROORDENPAGO: TLongintField;
    qOPREFCONDICIONFISCAL: TLongintField;
    qOPREFCONDICIONPAGO: TLongintField;
    qOPREFCONDICIONPAGOTIEMPO: TLongintField;
    qOPREFIMPUTACION: TLongintField;
    qOPREFLOCALIDAD: TLongintField;
    qOPREFPROVEEDOR: TStringField;
    qOPTXNOTAS: TStringField;
    qOPTXOBSERVACIONES: TBlobField;
    qPagos: TZQuery;
    qPagosAGRUPAMIENTO: TLongintField;
    qPagosBANCO: TStringField;
    qPagosBVISIBLE: TSmallintField;
    qPagosBVISIBLE_1: TSmallintField;
    qPagosBVISIBLE_2: TSmallintField;
    qPagosBVISIBLE_3: TSmallintField;
    qPagosFCOBRO: TDateField;
    qPagosFENTREGA: TDateField;
    qPagosFORMAPAGO: TStringField;
    qPagosFRECIBIDO: TDateField;
    qPagosFVENCIMIENTO: TDateField;
    qPagosIDBANCO: TLongintField;
    qPagosIDCHEQUE: TStringField;
    qPagosIDFORMAPAGO: TLongintField;
    qPagosIDOPFORMADEPAGO: TStringField;
    qPagosNMONTO: TFloatField;
    qPagosNMONTO_1: TFloatField;
    qPagosNROCHEQUE: TStringField;
    qPagosREFBANCO: TLongintField;
    qPagosREFBANCO_1: TLongintField;
    qPagosREFCHEQUE: TStringField;
    qPagosREFCUENTA: TLongintField;
    qPagosREFENTREGADOA: TStringField;
    qPagosREFESTADO: TLongintField;
    qPagosREFFORMAPAGO: TLongintField;
    qPagosREFORDENPAGO: TStringField;
    qPagosREFRECIBIDODE: TStringField;
    qPagosTXNOTAS: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure LevantarPagos (laFechaIni, laFechaFin: TDate);
  end; 

var
  DM_DetallePagos: TDM_DetallePagos;

implementation

{$R *.lfm}

{ TDM_DetallePagos }

procedure TDM_DetallePagos.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM_DetallePagos.LevantarPagos(laFechaIni, laFechaFin: TDate);
begin
  with qOP do
  begin
    if active then close;
    ParamByName('fechaIni').AsDate:= laFechaIni;
    ParamByName('fechaFin').AsDate:= laFechaFin;
    Open;
    qFacturas.Open;
    qPagos.Open;
  end;
end;

end.

