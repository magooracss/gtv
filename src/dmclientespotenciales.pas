unit dmclientespotenciales;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral;

type

  { TDM_ClientesPotenciales }

  TDM_ClientesPotenciales = class(TDataModule)
    qListaClientesPotenciales: TZQuery;
    tbClientesPotenciales: TRxMemoryData;
    tbClientesPotencialesINS: TZQuery;
    tbClientesPotencialesSEL: TZQuery;
    tbClientesPotencialesUPD: TZQuery;
    tbClientesPotencialesDEL: TZQuery;
    procedure tbClientesPotencialesAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure ListadoClientes;
    function ClienteSeleccionadoListado: GUID_ID;

    procedure NuevoCliente;
    procedure EditarCliente (idCliente: GUID_ID);
    procedure EliminarClientePotencial (refCliente: GUID_ID);

    function ClienteNombre  (idCliente: GUID_ID): string;
    function ClientePotencialSeleccionado: GUID_ID;

    procedure Grabar;
  end; 

var
  DM_ClientesPotenciales: TDM_ClientesPotenciales;

implementation

{$R *.lfm}

{ TDM_ClientesPotenciales }

procedure TDM_ClientesPotenciales.tbClientesPotencialesAfterInsert(
  DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idClientePotencial').asString:= DM_General.CrearGUID;
    FieldByName('fAlta').AsDateTime:= Now;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_ClientesPotenciales.ListadoClientes;
begin
  with qListaClientesPotenciales do
  begin
    if active then close;
    Open;
  end;
end;

function TDM_ClientesPotenciales.ClienteSeleccionadoListado: GUID_ID;
begin
  With qListaClientesPotenciales do
  begin
    if ((Active) and (NOT EOF)) then
      Result:= FieldByName('idClientePotencial').asString
    else
      Result:= GUIDNULO;
  end;
end;

procedure TDM_ClientesPotenciales.NuevoCliente;
begin
  DM_General.ReiniciarTabla(tbClientesPotenciales);
  tbClientesPotenciales.Insert;
end;

procedure TDM_ClientesPotenciales.EditarCliente(idCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbClientesPotenciales);
  tbClientesPotencialesSEL.Close;
  tbClientesPotencialesSEL.ParamByName('idClientePotencial').asString:= idCliente;
  tbClientesPotencialesSEL.Open;
  tbClientesPotenciales.LoadFromDataSet(tbClientesPotencialesSEL, 0, lmAppend);
end;

procedure TDM_ClientesPotenciales.EliminarClientePotencial(refCliente: GUID_ID);
begin
  with tbClientesPotencialesDEL do
  begin
    ParamByName('idClientePotencial').asString:= refCliente;
    ExecSQL;
  end;
end;

function TDM_ClientesPotenciales.ClienteNombre(idCliente: GUID_ID): string;
begin
   with tbClientesPotencialesSEL do
   begin
     Close;
     ParamByName('idClientePotencial').asString:= idCliente;
     Open;
     if RecordCount > 0 then
       Result:= FieldByName('cRazonSocial').asString
     else
       Result:= GUIDNULO;

   end;
end;

function TDM_ClientesPotenciales.ClientePotencialSeleccionado: GUID_ID;
begin
  with qListaClientesPotenciales do
  begin
    if ((Active) AND (RecordCount > 0)) then
      Result:= FieldByName('idClientePotencial').asString
    else
      Result:= GUIDNULO;
  end;
end;

procedure TDM_ClientesPotenciales.Grabar;
begin
  DM_General.GrabarDatos(tbClientesPotencialesSEL, tbClientesPotencialesINS, tbClientesPotencialesUPD, tbClientesPotenciales, 'idClientePotencial');
end;

end.

