unit dmlocalidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmConexion
  ,dmgeneral
  , db;

type

  { TDM_Localidades }

  TDM_Localidades = class(TDataModule)
    qtugProvincias: TZQuery;
    tugLocalidadesINS: TZQuery;
    qLocalidadesProv: TZQuery;
    tugLocalidadesUPD: TZQuery;
    tugLocalidadesSEL: TZQuery;
    tugLocalidades: TRxMemoryData;
    tugLocalidadesDEL: TZQuery;
    procedure tugLocalidadesAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure levantarLocalidadesPorProv (refProvincia: integer);
    procedure Grabar;
    procedure Cancelar;

    procedure NuevaLocalidad(refProvincia: integer);
    procedure EditarLocalidad;
    procedure EliminarLocalidad;

  end; 

var
  DM_Localidades: TDM_Localidades;

implementation

{$R *.lfm}

{ TDM_Localidades }

procedure TDM_Localidades.tugLocalidadesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLocalidad').asInteger:= -1;
    FieldByName('Localidad').asString:= EmptyStr;
    FieldByName('cPostal').asString:= EmptyStr;
    FieldByName('bVisible').asInteger:= 1;
    FieldByName('refProvincia').asInteger:= 0;
  end;
end;

procedure TDM_Localidades.levantarLocalidadesPorProv(refProvincia: integer);
begin
  DM_General.ReiniciarTabla(tugLocalidades);
  with qLocalidadesProv do
  begin
    if active then close;
    ParamByName('refProvincia').asInteger:= refProvincia;
    Open;
    tugLocalidades.LoadFromDataSet(qLocalidadesProv,0,lmAppend);
    close;
  end;
end;

procedure TDM_Localidades.Grabar;
begin
  DM_General.GrabarDatos(tugLocalidadesSEL,tugLocalidadesINS, tugLocalidadesUPD, tugLocalidades, 'idLocalidad');
end;

procedure TDM_Localidades.Cancelar;
begin
  tugLocalidades.Cancel;
end;

procedure TDM_Localidades.NuevaLocalidad (refProvincia: integer);
begin
  tugLocalidades.Insert;
  tugLocalidades.FieldByName('refProvincia').asInteger:= refProvincia;
end;

procedure TDM_Localidades.EditarLocalidad;
begin
  tugLocalidades.Edit;
end;

procedure TDM_Localidades.EliminarLocalidad;
begin
  with tugLocalidadesDEL do
  begin
    ParamByName('idLocalidad').asInteger:= tugLocalidades.FieldByName('idLocalidad').AsInteger;
    ExecSQL;
  end;
  tugLocalidades.Delete;
end;

end.

