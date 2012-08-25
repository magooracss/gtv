unit dmseleccionlistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Dialogs, rxmemds, ZDataset, db
  //Exportar a XLS
  ,fpspreadsheet, fpsallformats, laz_fpspreadsheet
  ,dateutils
  ;

const
  _GRP_REMITOS_ = 1;
  _GRP_CONTABILIDAD_ = 2;


type

  { TDM_SeleccionListado }

  TDM_SeleccionListado = class(TDataModule)
    tbListados: TRxMemoryData;
    qGrupos: TZQuery;
    qListadoPorGrupo: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qGruposAfterScroll(DataSet: TDataSet);
  private
    GrupoAnterior: integer;
    procedure LevantarGrupos;
    procedure TitulosXLS (var laHoja: TsWorksheet; var laTabla: TRxMemoryData);
    function AcomodarFecha(laFecha: TDateTime): string;
  public
    procedure LevantarListadosGrupo (refGrupo: integer);
    procedure ExportarXLS (laTabla: TRxMemoryData; elArchivo,laHoja: string);
  end; 

var
  DM_SeleccionListado: TDM_SeleccionListado;

implementation
{$R *.lfm}

{ TDM_SeleccionListado }

procedure TDM_SeleccionListado.DataModuleCreate(Sender: TObject);
begin
  GrupoAnterior:= -9999;
  LevantarGrupos;
end;

procedure TDM_SeleccionListado.qGruposAfterScroll(DataSet: TDataSet);
begin
  LevantarListadosGrupo(DataSet.FieldByName('idListadoGrupo').asInteger);
end;

procedure TDM_SeleccionListado.LevantarGrupos;
begin
  with qGrupos do
  begin
    if active then close;
    Open;
  end;
end;



procedure TDM_SeleccionListado.LevantarListadosGrupo(refGrupo: integer);
begin
  if GrupoAnterior <> refGrupo then
  begin
    tbListados.Close;
    with qListadoPorGrupo do
    begin
      if active then close;
      tbListados.Open;
      ParamByName('refgrupo').asInteger:= refGrupo;
      Open;
      tbListados.LoadFromDataSet(qListadoPorGrupo,0,lmAppend);
      Close;
    end;
    GrupoAnterior:= refGrupo;
  end;
end;

function TDM_SeleccionListado.AcomodarFecha(laFecha: TDateTime): string;
begin
 if DateOf(laFecha) < StrToDate('01/01/1901') then
   Result:= FormatDateTime('HH:MM:SS', laFecha)
 else
   Result:= FormatDateTime('dd/mm/yyyy', laFecha) ;

end;

procedure TDM_SeleccionListado.TitulosXLS(var laHoja: TsWorksheet;
  var laTabla: TRxMemoryData);
var
 idx: integer;
begin
  for idx:= 0 to laTabla.FieldCount -1 do
  begin
    if ((Copy (UpperCase(TRIM(laTabla.Fields[idx].FieldName)),1,2)) <> 'ID') and
       ((Copy (UpperCase(TRIM(laTabla.Fields[idx].FieldName)),1,3)) <> 'REF')
         then
      laHoja.WriteUTF8Text(0, idx, AnsiToUTF8(laTabla.Fields[idx].FieldName));
  end;
end;


procedure TDM_SeleccionListado.ExportarXLS(laTabla: TRxMemoryData; elArchivo, laHoja: string);
const
  OUTPUT_FORMAT = sfExcel5;
var
  elWorkbook: TsWorkbook;
  laWorksheet: TsWorksheet;
  idx, campos: integer;
begin
  try
    with laTabla do
    begin
      First;
      elWorkbook := TsWorkbook.Create;
      laWorksheet := elWorkbook.AddWorksheet(lahoja);
      TitulosXLS(laWorksheet, laTabla);
      idx:= 1;
      For idx:= 0 to RecordCount- 1 do
      begin
        for campos:= 0 to Fields.Count - 1 do
        begin
         if (
                ((Copy (UpperCase(TRIM(Fields[campos].FieldName)),1,2)) <> 'ID')
             and((Copy (UpperCase(TRIM(Fields[campos].FieldName)),1,3)) <> 'REF')
            )
            then
         begin

          if Fields[campos].DataType in [ ftSmallint, ftInteger,ftFloat, ftCurrency,ftAutoInc, ftLargeint] then
          begin
            if FieldByName(Fields[campos].FieldName).IsNull then
             laWorksheet.WriteNumber(idx + 1, campos, 0)
            else
             laWorksheet.WriteNumber(idx + 1, campos, FieldByName(Fields[campos].FieldName).Value);
          end
          else
            if Fields[campos].DataType in [ftDate,  ftTime, ftDateTime] then
               laWorksheet.WriteUTF8Text(idx + 1, campos, AnsiToUTF8(AcomodarFecha(FieldByName(Fields[campos].FieldName).AsDateTime)))
            else
              laWorksheet.WriteUTF8Text(idx + 1, campos, AnsiToUTF8(FieldByName(Fields[campos].FieldName).asString));
         end;
        end;
        Next;
      end;
    end;

    //// Grabar datos
    if FileExists(elArchivo) then
      DeleteFile(elArchivo);
    elWorkbook.WriteToFile(elArchivo, OUTPUT_FORMAT);

  finally
    elWorkbook.Free;
  end;
end;

end.

