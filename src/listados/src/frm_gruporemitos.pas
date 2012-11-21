unit frm_gruporemitos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, EditBtn, Buttons, DBGrids
  ,dmgeneral
  ;

type

  { TfrmGrupoRemitos }

  TfrmGrupoRemitos = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnImprimir: TBitBtn;
    btnBuscarEdificio: TBitBtn;
    ckFacturados: TCheckBox;
    ckTodos: TCheckBox;
    ckSinCargo: TCheckBox;
    ckPresentados: TCheckBox;
    cbGrupoFacturacion: TComboBox;
    ds_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    edEdificio: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    SpeedButton1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btnBuscarEdificioClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    elTipoListado: integer;
    laRutaReporte: string;
    idEdificio: GUID_ID;
    procedure Inicializar;

    procedure CargarCbGrupoFacturacion;

  public
    property tipoListado: integer read elTipoListado write elTipoListado;
    property rutaReporte: string read laRutaReporte write laRutaReporte;
  end; 

var
  frmGrupoRemitos: TfrmGrupoRemitos;

implementation
{$R *.lfm}
uses
  dmgruporemitos

  ,dmbuscarcliente
  ,frm_busquedaclientes
  ,dmseleccionlistado
  ,LR_Class
  ;

{ TfrmGrupoRemitos }

procedure TfrmGrupoRemitos.FormCreate(Sender: TObject);
begin
//  Application.CreateForm(TDM_GrupoRemitos, DM_GrupoRemitos);
  idEdificio:= GUIDNULO;
end;

procedure TfrmGrupoRemitos.btnBuscarEdificioClick(Sender: TObject);
var
  pant: TfrmBuscarCliente;
begin
  try
//    Application.CreateForm(TDM_BuscarCliente, DM_BuscarCliente);
    pant:= TfrmBuscarCliente.Create(self);
    try
      if pant.ShowModal = mrOK then
      begin
        edEdificio.Text:= pant.NombreCliente;
        idEdificio:= pant.idCliente;
      end;
    finally
      pant.Free;
    end;
  finally
   // DM_BuscarCliente.Free;
  end;
end;

procedure TfrmGrupoRemitos.btnImprimirClick(Sender: TObject);
begin

  DM_General.LevantarReporte(rutaReporte, DM_GrupoRemitos.tbResultados);
  DM_General.EjecutarReporte;
end;

procedure TfrmGrupoRemitos.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmGrupoRemitos.BitBtn1Click(Sender: TObject);
begin
   with DM_GrupoRemitos do
  begin
    bFacturado:= ckFacturados.Checked;
    bSinCargo:= ckSinCargo.Checked;
    bPresentado:= ckPresentados.Checked;
    bTodos:= ckTodos.Checked;
    fDesde:= edFechaIni.Date;
    fHasta:= edFechaFin.Date;
    refEdificio:= idEdificio;
    if cbGrupoFacturacion.ItemIndex = 0 then
      refGrupoFacturacion:= -1
    else
      refGrupoFacturacion:= DM_General.obtenerIDIntComboBox(cbGrupoFacturacion);
    Filtrar;
  end;

end;

procedure TfrmGrupoRemitos.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmGrupoRemitos.BitBtn3Click(Sender: TObject);
begin
  if SD.Execute then
   DM_SeleccionListado.ExportarXLS(DM_GrupoRemitos.tbResultados, SD.FileName, 'Remitos');
end;

procedure TfrmGrupoRemitos.BitBtn4Click(Sender: TObject);
begin
  DM_General.LevantarReporte(rutaReporte, DM_GrupoRemitos.tbResultados);
  if SD.Execute then
    DM_General.ReporteAPDF (SD.FileName);
end;

procedure TfrmGrupoRemitos.FormDestroy(Sender: TObject);
begin
//  DM_GrupoRemitos.Free;
end;

procedure TfrmGrupoRemitos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmGrupoRemitos.SpeedButton1Click(Sender: TObject);
begin
  idEdificio:= GUIDNULO;
  edEdificio.Clear;
end;

procedure TfrmGrupoRemitos.Inicializar;
begin
  CargarCbGrupoFacturacion;
  edEdificio.Clear;
  ckFacturados.Checked:= false;
  ckPresentados.Checked:= false;
  ckSinCargo.Checked:= false;
  edFechaIni.Date:=StrToDate('01/01/2000');
  edFechaFin.Date:= Now;
  idEdificio:= GUIDNULO;
end;

procedure TfrmGrupoRemitos.CargarCbGrupoFacturacion;
begin
  DM_General.CargarComboBox(cbGrupoFacturacion,'GrupoFacturacion', 'idGrupoFacturacion', DM_GrupoRemitos.qGruposFacturacion);
  cbGrupoFacturacion.Items.Insert(0, 'TODOS LOS GRUPOS');
  cbGrupoFacturacion.ItemIndex:= 0;
end;

end.

