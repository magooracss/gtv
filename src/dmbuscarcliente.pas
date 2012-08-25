unit dmbuscarcliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral, dmConexion, db
  ;

type

  { TDM_BuscarCliente }

  TDM_BuscarCliente = class(TDataModule)
    tbResultados: TRxMemoryData;
    qBusCliPorNombre: TZQuery;
    qBusCliPorCodigo: TZQuery;
    qBusCliPorDomicilio: TZQuery;
  private
    { private declarations }
  public
    function DevolverIdCliente: GUID_ID;
    function DevolverNombreCliente: string;
    procedure Buscar (consulta, dato: string);

    function BuscarClientePorCodigo (codCliente: string): boolean;
    function BuscarClientePorNombre (nombre: string): boolean;
  end; 

var
  DM_BuscarCliente: TDM_BuscarCliente;

implementation

{$R *.lfm}

{ TDM_BuscarCliente }

function TDM_BuscarCliente.DevolverIdCliente: GUID_ID;
begin
  if (tbResultados.Active) and (NOT tbResultados.EOF) then
  begin
    Result:= tbResultados.FieldByName('idCliente').asString;
  end
  else
    Result:= GUIDNULO;
end;

function TDM_BuscarCliente.DevolverNombreCliente: string;
begin
  if (tbResultados.Active) and (NOT tbResultados.EOF) then
  begin
    Result:= tbResultados.FieldByName('cNombre').asString;
  end
  else
    Result:= GUIDNULO;
end;

procedure TDM_BuscarCliente.Buscar(consulta, dato: string);
var
  laConsulta: TZQuery;
begin
  laConsulta:= (self.FindComponent(consulta)as TzQuery);
  tbResultados.Close;
  tbResultados.Open;
  if laConsulta <> nil then
  begin
    with (laConsulta as TZQuery) do
    begin
      case ParamByName('parametro').DataType of
        ftString: ParamByName('parametro').AsString:= TRIM(Dato);
        ftSmallint, ftInteger: ParamByName('parametro').asInteger:= StrToIntDef (dato, 0);
      else
         ParamByName('parametro').Value:= TRIM(dato);
      end;
      Open;
      if Not EOF then
       tbResultados.LoadFromDataSet((laConsulta as TZQuery), 0, lmAppend);
      Close;
    end;
  end;
end;

function TDM_BuscarCliente.BuscarClientePorCodigo(codCliente: string): boolean;
begin
  Buscar ('qBusCliPorCodigo', codCliente);
  Result := (tbResultados.RecordCount > 0 );
end;

function TDM_BuscarCliente.BuscarClientePorNombre(nombre: string): boolean;
begin
  Buscar ('qBusCliPorNombre', nombre);
  Result := (tbResultados.RecordCount > 0 );
end;

end.

