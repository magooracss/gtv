unit dmcheques;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral
  , dmConexion
  ;

CONST
   ORDEN_NUMERO = '1';
   ORDEN_BANCO = '2';
   ORDEN_RECIBIDOS_DE = '3';
   ORDEN_ENTREGADOS_A = '4';
   ORDEN_FECHA_COBRO = '5';
   ORDEN_FECHA_RECEPCION = '6';
   ORDEN_FECHA_ENTREGA = '7';
   ORDEN_MONTO = '8';

   EST_ENTREGADO = 0;
   EST_CARTERA = 1;
   EST_TODO = 2;

type

  { TDM_Cheques }

  TDM_Cheques = class(TDataModule)
    qBusChequeBanco: TZQuery;
    qTugBancos: TZQuery;
    qBusChequefCobro: TZQuery;
    qBusChequeEntregadoA: TZQuery;
    qBusChequefRecibido: TZQuery;
    qBusChequeRecibidoDe: TZQuery;
    qBusChequeMontoMayor: TZQuery;
    qBusChequeMontoMenor: TZQuery;
    qBusChequeMontoIgual: TZQuery;
    qBusChequefEntrega: TZQuery;
    qTugBancosBANCO: TStringField;
    qTugBancosBVISIBLE: TSmallintField;
    qTugBancosIDBANCO: TLongintField;
    qTugChequesEstados: TZQuery;
    qTugChequesEstadosBVISIBLE: TSmallintField;
    qTugChequesEstadosCHEQUEESTADO: TStringField;
    qTugChequesEstadosIDCHEQUEESTADO: TLongintField;
    tbChequesbVisible: TLongintField;
    tbChequesfCobro: TDateField;
    tbChequesfEntrega: TDateTimeField;
    tbChequesfRecibido: TDateTimeField;
    tbChequesfVencimiento: TDateField;
    tbChequesidCheque: TStringField;
    tbChequeslxBanco: TStringField;
    tbChequeslxEntregadoA: TStringField;
    tbChequeslxRecibidoDe: TStringField;
    tbChequesnMonto: TFloatField;
    tbChequesNroCheque: TStringField;
    tbChequesrefBanco: TLongintField;
    tbChequesrefEntregadoA: TStringField;
    tbChequesrefEstado: TLongintField;
    tbChequesrefRecibidoDe: TStringField;
    tbChequestxNotas: TStringField;
    tbChequesINS: TZQuery;
    tbChequesSEL: TZQuery;
    tbChequesUPD: TZQuery;
    tbChequesDEL: TZQuery;
    tbResultados: TRxMemoryData;
    qBusChequeNumero: TZQuery;
    tbCheques: TRxMemoryData;
    tbResultadosBanco: TStringField;
    tbResultadosEntregadoA: TStringField;
    tbResultadosfCobro: TDateTimeField;
    tbResultadosfEntrega: TDateTimeField;
    tbResultadosfRecibido: TDateTimeField;
    tbResultadosidCheque: TStringField;
    tbResultadosnMonto: TFloatField;
    tbResultadosNroCheque: TStringField;
    tbResultadosRecibidoDe: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbChequesAfterInsert(DataSet: TDataSet);
    procedure tbResultadosfCobroGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    function getidCheque: GUID_ID;
    { private declarations }
  public
    property idChequeSeleccionado: GUID_ID read getidCheque;
    procedure BuscarCheque (elValor, laConsulta: string; estado: integer);
    procedure OrdenarListado (elCriterio: string);
    procedure BuscarChequeId (refCheque: GUID_ID);


    procedure CambiarEntregadoA(idPersonaEmpresa: GUID_ID);
    procedure CambiarRecibidoDe(idPersonaEmpresa: GUID_ID);
    procedure CambiarFechaEntregadoA(fecha: TDateTime);

    procedure LevantarCheque (elCheque: GUID_ID);
    procedure EliminarCheque (elCheque: GUID_ID);

    procedure Nuevo;
    procedure Grabar;

    procedure AjustarRefCombos (refBanco, refChequeEstado: integer);


  end; 

var
  DM_Cheques: TDM_Cheques;

implementation
{$R *.lfm}
uses
  dmbuscarpersonaempresa
  ;

{ TDM_Cheques }

procedure TDM_Cheques.DataModuleCreate(Sender: TObject);
begin
  DM_General.ConectarConexiones(TDataModule(DM_Cheques));
end;

procedure TDM_Cheques.tbChequesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCheque').asString:= DM_General.CrearGUID;
    FieldByName('nroCheque').asString:= EmptyStr;
    FieldByName('fCobro').AsDateTime:= DM_General.FechaNula;
    FieldByName('fVencimiento').AsDateTime:= DM_General.FechaNula;
    FieldByName('refBanco').AsInteger:= 0;
    FieldByName('refEstado').AsInteger:= 0;
    FieldByName('refRecibidoDe').AsString:= GUIDNULO;
    FieldByName('fRecibido').AsDateTime:= DM_General.FechaNula;
    FieldByName('txNotas').asString:= EmptyStr;
    FieldByName('fEntrega').AsDateTime:= DM_General.FechaNula;
    FieldByName('refEntregadoA').asString:= GUIDNULO;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Cheques.tbResultadosfCobroGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  inherited;
  if (Sender.AsDateTime<>0) then
    //Text := FormatDateTime('dd/mm/yyyy hh:nn',Sender.AsDateTime)
    aText := FormatDateTime('dd/mm/yyyy',Sender.AsDateTime)
  else
    aText := '' ;
end;

function TDM_Cheques.getidCheque: GUID_ID;
begin
  if (tbResultados.Active) and (tbResultados.RecordCount > 0) then
    Result:= tbResultados.FieldByName('idCheque').asString
  else
    Result:= GUIDNULO;
end;

procedure TDM_Cheques.BuscarCheque(elValor, laConsulta: string; estado: integer
  );
var
  laConsultaTZ: TZQuery;
  cadena: string;
begin
  laConsultaTZ:= (self.FindComponent(laconsulta)as TzQuery);
  cadena:= laConsultaTZ.SQL.Text;

  tbResultados.Close;
  tbResultados.Open;
  if laConsultaTZ <> nil then
  begin
    case estado of
      EST_ENTREGADO : laConsultaTZ.SQL.Add(' AND (refEntregadoA <> ''{00000000-0000-0000-0000-000000000000}'') ');
      EST_CARTERA: laConsultaTZ.SQL.Add(' AND (refEntregadoA LIKE ''{00000000-0000-0000-0000-000000000000}'') ');
    end;

    with (laConsultaTZ as TZQuery) do
    begin
      case ParamByName('parametro').DataType of
        ftString: ParamByName('parametro').AsString:= TRIM(elValor);
        ftSmallint, ftInteger: ParamByName('parametro').asInteger:= StrToIntDef (elValor, 0);
        ftFloat, ftCurrency :ParamByName('parametro').AsFloat:= StrToFloatDef (elValor, 0);
      else
         ParamByName('parametro').Value:= TRIM(elValor);
      end;
      Open;

      if Not EOF then
       tbResultados.LoadFromDataSet((laConsultaTZ as TZQuery), 0, lmAppend);
      Close;

      (laConsultaTZ as TZQuery).SQL.clear;
      laConsultaTZ.SQL.Add (cadena) ;

    end;
  end;
end;

procedure TDM_Cheques.OrdenarListado(elCriterio: string);
var
  idxCriterio: integer;
  elCampo: string;
begin
  idxCriterio:= StrToIntDef(elCriterio, -1);
  Case idxCriterio of
    1: elCampo:= 'NroCheque';
    2: elCampo:= 'Banco';
    3: elCampo:= 'RecibidoDe';
    4: elCampo:= 'EntregadoA';
    5: elCampo:= 'fCobro';
    6: elCampo:= 'fRecibido';
    7: elCampo:= 'fEntrega';
    8: elCampo:= 'nMonto';
  else
     elCampo:= 'NroCheque';
   end;
  if (tbResultados.Active) then
    tbResultados.SortOnFields(elCampo);
end;

procedure TDM_Cheques.BuscarChequeId(refCheque: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbCheques);
  with tbChequesSEL do
  begin
    if active then close;
    ParamByName('idCheque').asString:= refCheque;
    Open;
    tbCheques.LoadFromDataSet(tbChequesSEL, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Cheques.CambiarEntregadoA(idPersonaEmpresa: GUID_ID);
begin
  with tbCheques do
  begin
    Edit;
    FieldByName('refEntregadoA').AsString:= idPersonaEmpresa;
    FieldByName('lxEntregadoA').AsString:= DM_BuscarPersonaEmpresa.NombrePersonaEmpresaPorID(idPersonaEmpresa);
    Post;
  end;
end;

procedure TDM_Cheques.CambiarRecibidoDe(idPersonaEmpresa: GUID_ID);
begin
  with tbCheques do
  begin
    Edit;
    FieldByName('refRecibidoDe').AsString:= idPersonaEmpresa;
    FieldByName('lxRecibidoDe').AsString:= DM_BuscarPersonaEmpresa.NombrePersonaEmpresaPorID(idPersonaEmpresa);
    Post;
  end;
end;

procedure TDM_Cheques.CambiarFechaEntregadoA(fecha: TDateTime);
begin
  with tbCheques do
  begin
    Edit;
    FieldByName('fEntrega').AsDateTime:= fecha;
    Post;
  end;
end;

procedure TDM_Cheques.LevantarCheque(elCheque: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbCheques);
  with tbChequesSEL do
  begin
    if active then close;
    ParamByName('idCheque').asString:= elCheque;
    open;
    tbCheques.LoadFromDataSet(tbChequesSEL, 0, lmAppend);
  end;
  CambiarEntregadoA(tbCheques.FieldByName('refEntregadoA').AsString);
  CambiarRecibidoDe(tbCheques.FieldByName('refrecibidoDe').AsString);
end;

procedure TDM_Cheques.EliminarCheque(elCheque: GUID_ID);
begin
  with tbChequesDEL do
  begin
    ParamByName('idCheque').asString:= elCheque;
    ExecSQL;
  end;
end;

procedure TDM_Cheques.Nuevo;
begin
  DM_General.ReiniciarTabla(tbCheques);
  tbCheques.Insert;
end;

procedure TDM_Cheques.Grabar;
begin
  DM_General.GrabarDatos(tbChequesSEL, tbChequesINS, tbChequesUPD, tbCheques, 'idCheque');
end;

procedure TDM_Cheques.AjustarRefCombos(refBanco, refChequeEstado: integer);
begin
  With tbCheques do
  begin
    Edit;
    FieldByName('refBanco').asInteger:= refBanco;
    FieldByName('refEstado').asInteger:= refChequeEstado;
    Post;
  end;
end;

end.

