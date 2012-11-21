unit frm_sellistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons;

type

  { TfrmSeleccionListado }

  TfrmSeleccionListado = class(TForm)
    btnSeleccionar: TBitBtn;
    btnSalir:    TBitBtn;
    DS_Grupos:   TDatasource;
    DS_Listados: TDatasource;
    DBGrid1:     TDBGrid;
    DBGrid2:     TDBGrid;
    Panel1:      TPanel;
    Splitter1:   TSplitter;
    procedure btnSalirClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
  private
    procedure MostrarPantalla(refGrupo, refListado: integer; rutaReporte: string);


    procedure pantallaRemitos(refListado: integer; rutaReporte: string);
    procedure pantallaCuentas(refListado: integer; rutaReporte: string);


    procedure pantComposicionSaldos(refListado: integer; rutaReporte: string);
    procedure pantPendientes(refListado: integer; rutaReporte: string);
    procedure pantallaProveedores(refListado: integer; rutaReporte: string);

    procedure MostrarSubdiarioCompras(refListado: integer; rutaReporte: string);
    procedure MostrarCuentas(refListado: integer; rutaReporte: string);
    procedure MostrarSubDiarioPagos(refListado: integer; rutaReporte: string);
    procedure MostrarDetallesPagos(refListado: integer; rutaReporte: string);
    procedure MostrarComposicionSaldosVentas(refListado: integer; rutaReporte: string);
    procedure MostrarCuentaCorriente(refListado: integer; rutaReporte: string);


  public
    { public declarations }
  end;

var
  frmSeleccionListado: TfrmSeleccionListado;

implementation

{$R *.lfm}
uses
  dmseleccionlistado
  , frm_gruporemitos
  , frm_grupocuentas
  , frm_grupoproveedores
  , frm_grupoprovpendientes
  , frm_subdiariocompras
  , frm_subdiariopagos
  , frm_detallepagos
  , frm_compsaldoscompras
  , frm_proveedorcuentacorriente ;

{ TfrmSeleccionListado }

procedure TfrmSeleccionListado.btnSalirClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfrmSeleccionListado.btnSeleccionarClick(Sender: TObject);
begin
  MostrarPantalla(DS_Listados.DataSet.FieldByName('refGrupo').AsInteger
    , DS_Listados.DataSet.FieldByName('refFormulario').AsInteger
    , DS_Listados.DataSet.FieldByName('rutaReporte').AsString
    );
end;

procedure TfrmSeleccionListado.MostrarPantalla(refGrupo, refListado: integer;
  rutaReporte: string);
begin
  case refGrupo of
    _GRP_REMITOS_: PantallaRemitos(refListado, rutaReporte);
    _GRP_CONTABILIDAD_: PantallaCuentas(refListado, rutaReporte);
    _GRP_PROVEEDORES_: PantallaProveedores(refListado, rutaReporte);
  end;
end;

procedure TfrmSeleccionListado.pantallaRemitos(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmGrupoRemitos;
begin
  pantalla := TfrmGrupoRemitos.Create(self);
  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.pantallaCuentas(refListado: integer;
  rutaReporte: string);
begin

  case refListado of
    5: MostrarSubdiarioCompras(refListado, rutaReporte);
    6: MostrarSubdiarioPagos(refListado, rutaReporte);
    7: MostrarDetallesPagos(refListado, rutaReporte);
    8: MostrarComposicionSaldosVentas(refListado, rutaReporte);
    else
      MostrarCuentas(refListado, rutaReporte);
  end;

end;

procedure TfrmSeleccionListado.pantComposicionSaldos(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmGrupoProveedores;
begin
  pantalla := TfrmGrupoProveedores.Create(self);
  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.pantPendientes(refListado: integer; rutaReporte: string);
var
  pantalla: TfrmGrupoProveedoresPendientes;
begin
  pantalla := TfrmGrupoProveedoresPendientes.Create(self);
  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;

end;

procedure TfrmSeleccionListado.pantallaProveedores(refListado: integer;
  rutaReporte: string);
begin
  case refListado of
    1: pantComposicionSaldos(refListado, rutaReporte);
    2: pantPendientes(refListado, rutaReporte);
    3: MostrarCuentaCorriente(refListado, rutaReporte);
  end;
end;

procedure TfrmSeleccionListado.MostrarSubdiarioCompras(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmSubdiarioCompras;
begin
  pantalla := TfrmSubdiarioCompras.Create(self);
  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.MostrarCuentas(refListado: integer; rutaReporte: string);
var
  pantalla: TfrmGrupoCuentas;
begin
  pantalla := TfrmGrupoCuentas.Create(self);
  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.MostrarSubDiarioPagos(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmSubdiarioDePagos;
begin
  pantalla := TfrmSubdiarioDePagos.Create(self);
  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.MostrarDetallesPagos(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmDetallePagos;
begin
  pantalla := TfrmDetallePagos.Create(self);

  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.MostrarComposicionSaldosVentas(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmCompSaldosCompras;
begin
  pantalla := TfrmCompSaldosCompras.Create(self);

  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmSeleccionListado.MostrarCuentaCorriente(refListado: integer;
  rutaReporte: string);
var
  pantalla: TfrmProveedorCuentaCorriente;
begin
  pantalla := TfrmProveedorCuentaCorriente.Create(self);

  pantalla.rutaReporte := rutaReporte;
  pantalla.tipoListado := refListado;
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;

end.

