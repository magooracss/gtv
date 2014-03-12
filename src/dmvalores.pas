unit dmvalores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmgeneral;

CONST
   IDX_AGRUPAMIENTO_EFECTIVO = 1;
   IDX_AGRUPAMIENTO_TRASNFERENCIA = 2;
   IDX_AGRUPAMIENTO_CHEQUETERCEROS = 3;
   IDX_AGRUPAMIENTO_CHEQUEPROPIO = 4;

   IDX_AGRUPAMIENTO_COBRO_EFECTIVO = 1;
   IDX_AGRUPAMIENTO_COBRO_TRASNFERENCIA = 2;
   IDX_AGRUPAMIENTO_COBRO_CHEQUE = 3;



type

  { TDM_Valores }

  TDM_Valores = class(TDataModule)
    BancoPorID: TZQuery;
    BancoPorIDBANCO: TStringField;
    BancoPorIDBVISIBLE: TSmallintField;
    BancoPorIDIDBANCO: TLongintField;
    qAgrupamientoCobro: TZQuery;
    qAgrupamientoAGRUPAMIENTO: TLongintField;
    qAgrupamientoBVISIBLE: TSmallintField;
    qAgrupamientoCobroAGRUPAMIENTO: TLongintField;
    qAgrupamientoCobroBVISIBLE: TSmallintField;
    qAgrupamientoCobroFORMACOBRO: TStringField;
    qAgrupamientoCobroIDFORMACOBRO: TLongintField;
    qAgrupamientoCobroREFCUENTA: TLongintField;
    qAgrupamientoFORMAPAGO: TStringField;
    qAgrupamientoIDFORMAPAGO: TLongintField;
    qAgrupamientoREFCUENTA: TLongintField;
    qChequePorIDBANCO: TStringField;
    qChequePorIDBVISIBLE: TSmallintField;
    qChequePorIDBVISIBLE_1: TSmallintField;
    qChequePorIDFCOBRO: TDateField;
    qChequePorIDFENTREGA: TDateField;
    qChequePorIDFRECIBIDO: TDateField;
    qChequePorIDFVENCIMIENTO: TDateField;
    qChequePorIDIDBANCO: TLongintField;
    qChequePorIDIDCHEQUE: TStringField;
    qChequePorIDNMONTO: TFloatField;
    qChequePorIDNROCHEQUE: TStringField;
    qChequePorIDREFBANCO: TLongintField;
    qChequePorIDREFENTREGADOA: TStringField;
    qChequePorIDREFESTADO: TLongintField;
    qChequePorIDREFRECIBIDODE: TStringField;
    qChequePorIDTXNOTAS: TStringField;
    tugBancosBANCO: TStringField;
    tugBancosBVISIBLE: TSmallintField;
    tugBancosIDBANCO: TLongintField;
    tugFormaCobroPorIDAGRUPAMIENTO: TLongintField;
    tugFormaCobroPorIDBVISIBLE: TSmallintField;
    tugFormaCobroPorIDFORMACOBRO: TStringField;
    tugFormaCobroPorIDIDFORMACOBRO: TLongintField;
    tugFormaCobroPorIDREFCUENTA: TLongintField;
    tugFormaPagoPorID: TZQuery;
    qChequePorID: TZQuery;
    tugFormaCobroPorID: TZQuery;
    tugFormaPagoPorIDAGRUPAMIENTO: TLongintField;
    tugFormaPagoPorIDBVISIBLE: TSmallintField;
    tugFormaPagoPorIDFORMAPAGO: TStringField;
    tugFormaPagoPorIDIDFORMAPAGO: TLongintField;
    tugFormaPagoPorIDREFCUENTA: TLongintField;
    tugFormasCobroAGRUPAMIENTO: TLongintField;
    tugFormasCobroBVISIBLE: TSmallintField;
    tugFormasCobroFORMACOBRO: TStringField;
    tugFormasCobroIDFORMACOBRO: TLongintField;
    tugFormasCobroREFCUENTA: TLongintField;
    tugFormasPago: TZQuery;
    qAgrupamiento: TZQuery;
    tugBancos: TZQuery;
    tugFormasCobro: TZQuery;
  private
    { private declarations }
  public
    function Agrupamiento (refFormaPago: integer): integer;
    function AgrupamientoCobro (refFormaCobro: integer): integer;


    function FormaPago (refFormaPago: integer): string;
    function FormaCobro (refFormaCobro: integer): string;


    procedure DatosCheque (idCheque: GUID_ID; var monto: double; var Banco, NroCheque: string; var idBanco: integer);
    function NroCheque (idCheque: GUID_ID): string;
    function Banco (refBanco: integer; refCheque: String):string;
  end;

var
  DM_Valores: TDM_Valores;

implementation

{$R *.lfm}

{ TDM_Valores }

function TDM_Valores.Agrupamiento(refFormaPago: integer): integer;
begin
  with qAgrupamiento do
  begin
    if active then close;
    ParamByName('idFormaPago').asInteger:= refFormaPago;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('Agrupamiento').asInteger
    else
      Result:= 0;
  end;
end;

function TDM_Valores.AgrupamientoCobro(refFormaCobro: integer): integer;
begin
  with qAgrupamientoCobro do
  begin
    if active then close;
    ParamByName('idFormaCobro').asInteger:= refFormaCobro;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('Agrupamiento').asInteger
    else
      Result:= 0;
  end;
end;

function TDM_Valores.FormaPago(refFormaPago: integer): string;
begin
  with tugFormaPagoPorID do
  begin
    if Active then close;
    ParamByName('idFormaPago').asInteger:= refFormaPago;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('FormaPago').asString
    else
      Result:= EmptyStr;
  end;
end;

function TDM_Valores.FormaCobro(refFormaCobro: integer): string;
begin
  with tugFormaCobroPorID do
  begin
    if Active then close;
    ParamByName('idFormaCobro').asInteger:= refFormaCobro;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('FormaCobro').asString
    else
      Result:= EmptyStr;
  end;

end;


procedure TDM_Valores.DatosCheque(idCheque: GUID_ID; var monto: double; var Banco,
  NroCheque: string; var idBanco: integer);
begin
  with qChequePorID do
  begin
    if active then close;
    ParamByName('idCheque').asString:= idCheque;
    Open;

    if RecordCount > 0 then
    begin
      monto:= FieldByName('nMonto').asFloat;
      Banco:= FieldByName('Banco').asString;
      NroCheque:= FieldByName('NroCheque').asString;
      idBanco:= FieldByName('refBanco').AsInteger;
    end
    else
    begin
      monto:= 0;
      idBanco:= 0;
      Banco:= EmptyStr;
      NroCheque:= EmptyStr;
    end;
  end;
end;

function TDM_Valores.NroCheque(idCheque: GUID_ID): string;
var
  monto: double;
  elBanco, elNroCheque: string;
  idBanco: integer;
begin
  DatosCheque(idCheque, monto, elBanco, elNroCheque, idBanco);
  Result:= elNroCheque;
end;

function TDM_Valores.Banco(refBanco: integer; refCheque: String): string;
var
  monto: double;
  elBanco, elNroCheque: string;
  idBanco: integer;
begin
  if refBanco = 0 then
  begin
    DatosCheque(refCheque, monto, elBanco, elNroCheque, idBanco);
    Result:= elBanco;
  end
  else
  begin
    with BancoPorID do
    begin
      if active then close;
      ParamByName('idBanco').asInteger:= refBanco;
      Open;
      if RecordCount > 0 then
        Result:= FieldByName('Banco').asString
      else
        Result:= EmptyStr;
    end;
  end;


end;

end.

