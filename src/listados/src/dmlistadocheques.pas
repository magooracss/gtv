unit dmlistadocheques;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset;

type

  { TDM_ListadoCheques }

  TDM_ListadoCheques = class(TDataModule)
    qChequesPorOP: TZQuery;
    qChequesPorOPCCUIT: TStringField;
    qChequesPorOPCRAZONSOCIAL: TStringField;
    qChequesPorOPFACTURACOMPRA: TStringField;
    qChequesPorOPFCOBRO: TDateField;
    qChequesPorOPFECHACOMPRA: TDateField;
    qChequesPorOPFECHAOP: TDateField;
    qChequesPorOPFVENCIMIENTO: TDateField;
    qChequesPorOPNMONTO: TFloatField;
    qChequesPorOPNROCHEQUE: TStringField;
    qChequesPorOPNUMEROORDENPAGO: TLongintField;
    qChequesPorOPTOTALCOMPRA: TFloatField;
    tbResultados: TRxMemoryData;
    tbResultadoscCUIT: TStringField;
    tbResultadoscRazonSocial: TStringField;
    tbResultadosFacturaCompra: TStringField;
    tbResultadosfCobro: TDateTimeField;
    tbResultadosFechaCompra: TDateTimeField;
    tbResultadosFechaOp: TDateTimeField;
    tbResultadosfVencimiento: TDateTimeField;
    tbResultadosnMonto: TFloatField;
    tbResultadosNroCheque: TStringField;
    tbResultadosNumeroOrdenPago: TLongintField;
    tbResultadosTotalCompra: TFloatField;
  private
    { private declarations }
  public
     procedure LevantarChequesOP (fIni, fFin: TDateTime);
  end;

var
  DM_ListadoCheques: TDM_ListadoCheques;

implementation
{$R *.lfm}
uses
  dmgeneral
  ;

{ TDM_ListadoCheques }

procedure TDM_ListadoCheques.LevantarChequesOP(fIni, fFin: TDateTime);
begin
   DM_General.ReiniciarTabla(tbResultados);
   with qChequesPorOP do
   begin
     if active then close;
     ParamByName('fIni').AsDate:= fIni;
     ParamByName('fFIn').AsDate:= fFin;
     Open;
     tbResultados.LoadFromDataSet(qChequesPorOP, 0,lmAppend);
  //   close;
   end;
end;

end.

