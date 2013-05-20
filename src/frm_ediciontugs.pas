unit frm_ediciontugs; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons, dmediciontugs
  ;

type

  { TfrmEdicionTugs }

  TfrmEdicionTugs = class(TForm)
    btnBorrar: TBitBtn;
    btnSalir: TBitBtn;
    ds_Resultados: TDatasource;
    laGrilla: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    stTitulo: TStaticText;
    procedure btnBorrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
  private
    _laTug: TTablaTUG;
    procedure CargarTug (value: TTablaTUG);
    procedure ConfigurarGrilla;
    procedure AgregarColumna (laColumna: TColumn; campo, titulo: string);
  public
    property laTUG: TTablaTUG write CargarTug;
  end; 

var
  frmEdicionTugs: TfrmEdicionTugs;

implementation

{$R *.lfm}

{ TfrmEdicionTugs }

procedure TfrmEdicionTugs.btnBorrarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el item seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   DM_EdicionTUGs.EliminarFila;
end;

procedure TfrmEdicionTugs.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmEdicionTugs.CargarTug(value: TTablaTUG);
begin
  _laTug:= value;
  stTitulo.Caption:= 'Edición de la tabla: ' + _laTug.titulo;
  DM_EdicionTUGs.LevantarTabla (_laTug.nombre);
  ConfigurarGrilla;
end;

procedure TfrmEdicionTugs.AgregarColumna(laColumna: TColumn; campo,
  titulo: string);
var
  elCampo: TField;
begin
  laColumna.FieldName:= campo;
  laColumna.Title.Caption:= titulo;
  elCampo:= DM_EdicionTUGs.DevolverTField(campo);
  laColumna.Field.DisplayWidth:= 100;
  ShowMessage(campo + ': ' + IntToStr (elCampo.Size));
  if elCampo.DataType in [ftFloat, ftCurrency] then
   laColumna.DisplayFormat:= '#######0.00';
end;


procedure TfrmEdicionTugs.ConfigurarGrilla;
var
  idx: integer;
  elCampo: TCampoTUG;
begin
  laGrilla.Columns.Clear;
  for idx:= 0 to _laTug.CantidadCampos - 1 do
  begin
    elCampo:=  _laTug.DevolverCampo(idx);
    laGrilla.Columns.Add;
    AgregarColumna(TColumn(laGrilla.Columns[idx])
                  ,elCampo.campo
                  ,elCampo.titulo
                  );
  end;

end;


end.

