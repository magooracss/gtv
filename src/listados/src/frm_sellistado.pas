unit frm_sellistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons;

type

  { TfrmSeleccionListado }

  TfrmSeleccionListado = class(TForm)
    btnSeleccionar: TBitBtn;
    btnSalir: TBitBtn;
    DS_Grupos: TDatasource;
    DS_Listados: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    Splitter1: TSplitter;
    procedure btnSalirClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
  private
    procedure MostrarPantalla (refGrupo, refListado: integer; rutaReporte: string);


    procedure pantallaRemitos (refListado: integer; rutaReporte: string);
  public
    { public declarations }
  end; 

var
  frmSeleccionListado: TfrmSeleccionListado;

implementation
{$R *.lfm}
uses
  dmseleccionlistado
  ,frm_gruporemitos
  ;

{ TfrmSeleccionListado }

procedure TfrmSeleccionListado.btnSalirClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfrmSeleccionListado.btnSeleccionarClick(Sender: TObject);
begin
  MostrarPantalla(DS_Grupos.DataSet.FieldByName('idListadoGrupo').asInteger
                 ,DS_Listados.DataSet.FieldByName('refFormulario').asInteger
                 ,DS_Listados.DataSet.FieldByName('rutaReporte').asString
                 );
end;

procedure TfrmSeleccionListado.MostrarPantalla(refGrupo, refListado: integer;
  rutaReporte: string);
begin
  case refGrupo of
       _GRP_REMITOS_ : PantallaRemitos (refListado, rutaReporte);
  end;
end;

procedure TfrmSeleccionListado.pantallaRemitos(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmGrupoRemitos;
begin
  pantalla:= TfrmGrupoRemitos.Create(self);
  pantalla.rutaReporte:= rutaReporte;
  pantalla.tipoListado:= refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;



end.

