unit dmgruporemitos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_GrupoRemitos }

  TDM_GrupoRemitos = class(TDataModule)
    qGruposFacturacion: TZQuery;
    qResultados: TZQuery;
    qEquiposCliente: TZQuery;
    tbResultados: TRxMemoryData;
  private
    _bFacturado: boolean;
    _bPresentado: boolean;
    _bSinCargo: boolean;
    _bTodos: boolean;
    _fDesde: Tdate;
    _fHasta: Tdate;
    _refEdificio: GUID_ID;
    _refGrupoFacturacion: integer;
    procedure ArmarEncabezadoSQL;
    procedure ArmarWhereSQL;

    function EquiposRemitoStr (refRemito: GUID_ID): string;
    procedure AcomodarEquipos;


  public
    property bFacturado: boolean read _bFacturado write _bFacturado;
    property bSinCargo: boolean read _bSinCargo write _bSinCargo;
    property bPresentado: boolean read _bPresentado write _bPresentado;
    property bTodos: boolean read _bTodos write _bTodos;
    property fDesde: Tdate read _fDesde write _fDesde;
    property fHasta: Tdate read _fHasta write _fHasta;
    property refEdificio: GUID_ID read _refEdificio write _refEdificio;
    property refGrupoFacturacion: integer read _refGrupoFacturacion write _refGrupoFacturacion;

    procedure Filtrar;

  end; 

var
  DM_GrupoRemitos: TDM_GrupoRemitos;

implementation

{$R *.lfm}

{ TDM_GrupoRemitos }

procedure TDM_GrupoRemitos.ArmarEncabezadoSQL;
begin
  with qResultados do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add ('SELECT R.idRemito, R.refCliente, R.fFecha as Fecha, R.nRemito, R.txDetalles as Detalles, R.bFacturado as Facturado ');
    SQL.Add ('       ,R.bPresentado as Presentado, R.bSinCargo as SinCargo ');
    SQL.Add ('       ,''('' ||  C.cCodigo  || '') '' || C.cNombre as Edificio');
    SQL.Add ('       ,GF.GrupoFacturacion');
    SQL.Add ('FROM tbRemitos R');
    SQL.Add ('     LEFT JOIN tbClientes C ON C.idCliente = R.refCliente');
    SQL.Add ('     LEFT JOIN tugGruposFacturacion GF ON C.refGrupoFacturacion = GF.idGrupoFacturacion');
  end;
end;

procedure TDM_GrupoRemitos.ArmarWhereSQL;
begin
  with qResultados do
  begin
    SQL.Add (' WHERE (R.bVisible = 1)');

    if _bTodos = False then
    begin
      if _bFacturado then
        SQL.Add (' AND (R.bFacturado = 1)')
      else
        SQL.Add (' AND (R.bFacturado = 0)');

      if _bPresentado then
        SQL.Add (' AND (R.bPresentado = 1)')
      else
        SQL.Add (' AND (R.bPresentado = 0)');

      if _bSinCargo then
        SQL.Add (' AND (R.bSinCargo = 1)')
      else
        SQL.Add (' AND (R.bSinCargo = 0)');
    end;

    SQL.Add (' AND ((R.fFecha >= :FechaIni) AND (R.fFecha <= :FechaFin))');

    if _refEdificio <> GUIDNULO then
     SQL.Add( ' AND (R.refCliente = '''+ _refEdificio + ''')');

    if _refGrupoFacturacion >= 0 then
     SQL.Add (' AND (C.refGrupoFacturacion = ' + IntToSTR (_refGrupoFacturacion)+')');

  end;
end;

function TDM_GrupoRemitos.EquiposRemitoStr(refRemito: GUID_ID): string;
var
  Cad: string;
begin
  Cad:= EmptyStr;
  with qEquiposCliente do
  begin
    if active then close;
    ParamByName('refRemito').asString:= refRemito;
    open;
    if RecordCount > 0 then
    begin
      First;
      cad:= IntToStr (FieldByName('nNroEquipo').asInteger) + ' - ' + TRIM (FieldByName('Nombre').asString);
      Next;
    end;
    While Not EOF do
    begin
      cad:= cad + ' / ' +IntToStr (FieldByName('nNroEquipo').asInteger) + ' - ' + TRIM (FieldByName('Nombre').asString);
      Next;
    end;
  end;
  Result:= Cad;
end;

procedure TDM_GrupoRemitos.AcomodarEquipos;
begin
  with tbResultados do
  begin
    DisableControls;
    if RecordCount > 0 then
     First;
    While Not EOF do
    begin
      Edit;
      FieldByName('Equipos').asString:= EquiposRemitoStr(FieldByName('idRemito').asString);
      Post;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_GrupoRemitos.Filtrar;
begin
  DM_General.ReiniciarTabla(tbResultados);
  ArmarEncabezadoSQL;
  ArmarWhereSQL;
  with qResultados do
  begin
    ParamByName('FechaIni').AsDate:= _fDesde;
    ParamByName('FechaFin').asDate:= _fHasta;
    Open;
    tbResultados.LoadFromDataSet(qResultados, 0, lmAppend);
    close;
  end;
  AcomodarEquipos;
end;

end.

