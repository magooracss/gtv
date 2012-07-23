unit dmbuscarpersonaempresa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_BuscarPersonaEmpresa }

  TDM_BuscarPersonaEmpresa = class(TDataModule)
    qBusAdministradores: TZQuery;
    qBusAdministradoresPorID: TZQuery;
    qBusClientes: TZQuery;
    qBusClientesPorID: TZQuery;
    qBusClientesPotenciales: TZQuery;
    qBusClientesPotencialesPorID: TZQuery;
    qBusConservadores: TZQuery;
    qBusConservadoresPorID: TZQuery;
    qBusProveedores: TZQuery;
    qBusProveedoresPorID: TZQuery;
    qBusResponsablesTecnicos: TZQuery;
    qBusResponsablesTecnicosPorID: TZQuery;
    tbResultados: TRxMemoryData;
    tbResultadosidResultado: TStringField;
    tbResultadoslxTabla: TStringField;
    tbResultadosNombre: TStringField;
    tbResultadosrefTabla: TLongintField;
  private
    function getIdPersonaEmpresa: GUID_ID;
    function nombreTabla (idTabla: integer): string;
    procedure BuscarEnTabla (var consulta: TZQuery; valorABuscar: string);
    procedure AcomodarNombresTablas;
  public
    procedure Inicializar;


    property idPersonaEmpresaSeleccionada: GUID_ID read getIdPersonaEmpresa;
    function NombrePersonaEmpresaPorID (elID: GUID_ID): string;
    procedure Buscar (dato: string);
  end; 

var
  DM_BuscarPersonaEmpresa: TDM_BuscarPersonaEmpresa;

implementation
{$R *.lfm}

const
  MAXTABLAS = 6;
  ListaTablas: ARRAY[1..MAXTABLAS] of String = ('Administrador', 'Cliente', 'Cliente Potencial', 'Conservador', 'Proveedor', 'Responsable Técnico');

{ TDM_BuscarPersonaEmpresa }



function TDM_BuscarPersonaEmpresa.getIdPersonaEmpresa: GUID_ID;
begin
  if ((tbResultados.Active) and (tbResultados.RecordCount > 0)) then
    Result:= tbResultados.FieldByName('idResultado').asString
  else
    Result:= GUIDNULO;
end;

function TDM_BuscarPersonaEmpresa.nombreTabla(idTabla: integer): string;
begin
  Result:= ListaTablas[idTabla];
end;

procedure TDM_BuscarPersonaEmpresa.BuscarEnTabla(var consulta: TZQuery;
  valorABuscar: string);
begin
  with consulta do
  begin
    if active then close;
    ParamByName('parametro').asString:= TRIM(valorABuscar);
    Open;
    tbResultados.LoadFromDataSet(consulta, 0, lmAppend);
  end;
end;

procedure TDM_BuscarPersonaEmpresa.AcomodarNombresTablas;
begin
  with tbResultados do
  begin
    First;
    DisableControls;
    While NOT EOF do
    begin
     Edit;
     FieldByName('lxTabla').asString:= nombreTabla(FieldByName('refTabla').AsInteger);
     Post;
     Next;
    end;
    EnableControls;
  end;

end;

procedure TDM_BuscarPersonaEmpresa.Inicializar;
begin
  DM_General.ReiniciarTabla(tbResultados);
end;

function TDM_BuscarPersonaEmpresa.NombrePersonaEmpresaPorID(elID: GUID_ID
  ): string;
begin
  DM_General.ReiniciarTabla(tbResultados);
  BuscarEnTabla(qBusAdministradoresPorID, elID);
  BuscarEnTabla(qBusClientesPorID, elID);
  BuscarEnTabla(qBusClientesPotencialesPorID, elID);
  BuscarEnTabla(qBusConservadoresPorID, elID);
  BuscarEnTabla(qBusProveedoresPorID, elID);
  BuscarEnTabla(qBusResponsablesTecnicosPorID, elID);
  if tbResultados.RecordCount > 0 then
    Result:= tbResultados.FieldByName('Nombre').asString
  else
    Result:= EmptyStr;
end;

procedure TDM_BuscarPersonaEmpresa.Buscar(dato: string);
begin
  DM_General.ReiniciarTabla(tbResultados);
  BuscarEnTabla(qBusAdministradores, dato);
  BuscarEnTabla(qBusClientes, dato);
  BuscarEnTabla(qBusClientesPotenciales, dato);
  BuscarEnTabla(qBusConservadores, dato);
  BuscarEnTabla(qBusProveedores, dato);
  BuscarEnTabla(qBusResponsablesTecnicos, dato);
  AcomodarNombresTablas;
  tbResultados.SortOnFields('Nombre');
end;


end.

