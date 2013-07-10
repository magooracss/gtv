unit dmcompensaciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmConexion
  ,dmgeneral
  ,dmcompras
  ;

type

  { TDM_Compensaciones }

  TDM_Compensaciones = class(TDataModule)
    qCompensacionesPorCompra: TZQuery;
    qCompensacionesPorCompraFCOMPENSACION: TDateField;
    qCompensacionesPorCompraIDCOMPENSACION: TStringField;
    qCompensacionesPorCompraMONTO: TFloatField;
    qCompensacionesPorCompraREFCOMPRA: TStringField;
    qCompensacionesPorCompraREFOPORIGEN: TStringField;
    qCompensacionPorIDFCOMPENSACION2: TDateField;
    qCompensacionPorIDIDCOMPENSACION2: TStringField;
    qCompensacionPorIDMONTO2: TFloatField;
    qCompensacionPorIDREFCOMPRA2: TStringField;
    qCompensacionPorIDREFOPORIGEN2: TStringField;
    qUPDCompensacion: TZQuery;
    qCompensacionPorIDFCOMPENSACION: TDateField;
    qCompensacionPorIDFCOMPENSACION1: TDateField;
    qCompensacionPorIDIDCOMPENSACION: TStringField;
    qCompensacionPorIDIDCOMPENSACION1: TStringField;
    qCompensacionPorIDMONTO: TFloatField;
    qCompensacionPorIDMONTO1: TFloatField;
    qCompensacionPorIDREFCOMPRA: TStringField;
    qCompensacionPorIDREFCOMPRA1: TStringField;
    qCompensacionPorIDREFOPORIGEN: TStringField;
    qCompensacionPorIDREFOPORIGEN1: TStringField;
    qLevantarCompensaciones: TZQuery;
    qCompensacionPorID: TZQuery;
    qLevantarCompensacionesFFECHA: TDateField;
    qLevantarCompensacionesIDCOMPENSACION: TStringField;
    qLevantarCompensacionesMONTO: TFloatField;
    qLevantarCompensacionesNPAGADO: TFloatField;
    qLevantarCompensacionesNTOTALAPAGAR: TFloatField;
    qLevantarCompensacionesNUMEROORDENPAGO: TLongintField;
    qINSCompensacion: TZQuery;
  private
    _refProveedor: GUID_ID;
  public
    property refProveedor: GUID_ID read _refProveedor write _refProveedor;

    procedure LevantarCompensaciones;
    procedure CompensarCompra (refCompensacion, refCompra: GUID_ID);
    procedure AsentarCompensacion (refOP: GUID_ID; monto: double);

    function montoCompensacion (refCompensacion: GUID_ID): double;
    function idOPCompensacion (refCompensacion: GUID_ID): GUID_ID;
    function montoCompraCompensada (refCompra: GUID_ID): double;

  end;

var
  DM_Compensaciones: TDM_Compensaciones;

implementation
{$R *.lfm}

{ TDM_Compensaciones }

procedure TDM_Compensaciones.LevantarCompensaciones;
begin
  with qLevantarCompensaciones do
  begin
    if active then close;
    ParamByName('idProveedor').asString:= _refProveedor;
    Open;
  end;
end;

procedure TDM_Compensaciones.CompensarCompra(refCompensacion, refCompra: GUID_ID
  );
var
  elMontoCompensacion
 ,elMontoCompra: double;
  laidOPCompensacion: GUID_ID;
begin
  elMontoCompensacion:= montoCompensacion (refCompensacion);
  elMontoCompra:= DM_Compras.MontoRestante (refCompra);
  laidOPCompensacion:= GUIDNULO;

  if (elMontoCompra >= elMontoCompensacion) then
  begin
    with qUPDCompensacion do
    begin
      ParamByName('idCompensacion').asString:= refCompensacion;
      ParamByName('refCompra').asString:= refCompra;
      ParamByName('fCompensacion').AsDateTime:= Now;
      ParamByName('monto').AsFloat:= elMontoCompensacion;
      ExecSQL;
    end;
  end
  else
  begin
    laidOPCompensacion:= idOPCompensacion (refCompensacion);

    with qUPDCompensacion do
    begin
      ParamByName('idCompensacion').asString:= refCompensacion;
      ParamByName('refCompra').asString:= refCompra;
      ParamByName('fCompensacion').AsDateTime:= Now;
      ParamByName('monto').asFloat:= elMontoCompra;
      ExecSQL;
    end;

    with qINSCompensacion do
    begin
      ParamByName('idCompensacion').asString:= DM_General.CrearGUID;
      ParamByName('refOPOrigen').asString:= laidOPCompensacion;
      ParamByName('monto').asFloat:= elMontoCompensacion - elMontoCompra;
      ExecSQL;
    end;
  end;
end;

procedure TDM_Compensaciones.AsentarCompensacion(refOP: GUID_ID; monto: double);
begin
  with qINSCompensacion do
  begin
    ParamByName('idCompensacion').asString:= DM_General.CrearGUID;
    ParamByName('refOPOrigen').asString:= refOP;
    ParamByName('monto').asFloat:= monto;
    ExecSQL;
  end;
end;

function TDM_Compensaciones.montoCompensacion(refCompensacion: GUID_ID): double;
begin
  with qCompensacionPorID do
  begin
    if active then close;
    ParamByName('idCompensacion').asString:= refCompensacion;
    Open;

    if RecordCount > 0 then
      Result:= FieldByName('monto').asFloat
    else
      Result:= 0;
  end;
end;

function TDM_Compensaciones.idOPCompensacion(refCompensacion: GUID_ID): GUID_ID;
begin
  with qCompensacionPorID do
  begin
    if active then close;
    ParamByName('idCompensacion').asString:= refCompensacion;
    Open;

    if RecordCount > 0 then
      Result:= FieldByName('refOPOrigen').AsString
    else
      Result:= GUIDNULO;
  end;
end;

function TDM_Compensaciones.montoCompraCompensada(refCompra: GUID_ID): double;
var
  suma: double;
begin

  suma:= 0;

  with qCompensacionesPorCompra do
  begin
    if active then close;
    ParamByName('refCompra').asString:= refCompra;
    Open;

    if RecordCount > 0 then
    begin
      First;
      while Not EOF do
      begin
        suma:= suma + qCompensacionesPorCompraMONTO.AsFloat;
        Next;
      end;
    end;

    Result:= suma;

  end;
end;


end.

