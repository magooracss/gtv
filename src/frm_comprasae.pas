unit frm_comprasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DbCtrls, DBGrids, dbdateedit
  ,dmgeneral, Grids;

type

  { TfrmComprasAE }

  TfrmComprasAE = class(TForm)
    btnAgregarItem: TBitBtn;
    btnModificarItem: TBitBtn;
    btnEliminarItem: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnBuscarProv: TBitBtn;
    cbTipoComprobante: TComboBox;
    Compra: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    dbMontoTotal: TDBEdit;
    dbCantidad: TDBEdit;
    dbConcepto: TDBEdit;
    dbMontoUnitario: TDBEdit;
    dbPorcentajeIVA: TDBEdit;
    dbMontoIVA: TDBEdit;
    DBGrid1: TDBGrid;
    edImputacion: TEdit;
    GroupBox3: TGroupBox;
    Items: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    edProveedor: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    SpeedButton1: TSpeedButton;
    btnTugTiposComprobantes: TSpeedButton;
    SpeedButton2: TSpeedButton;
    stNeto: TStaticText;
    stIVA: TStaticText;
    stImputacion: TStaticText;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAgregarItemClick(Sender: TObject);
    procedure btnBuscarProvClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEliminarItemClick(Sender: TObject);
    procedure dbCantidadExit(Sender: TObject);
    procedure dbCantidadKeyPress(Sender: TObject; var Key: char);
    procedure dbConceptoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBGrid1SelectEditor(Sender: TObject; Column: TColumn;
      var Editor: TWinControl);
    procedure dbMontoIVAExit(Sender: TObject);
    procedure dbMontoIVAKeyPress(Sender: TObject; var Key: char);
    procedure dbMontoTotalKeyPress(Sender: TObject; var Key: char);
    procedure dbMontoUnitarioExit(Sender: TObject);
    procedure dbMontoUnitarioKeyPress(Sender: TObject; var Key: char);
    procedure dbPorcentajeIVAExit(Sender: TObject);
    procedure dbPorcentajeIVAKeyPress(Sender: TObject; var Key: char);
    procedure edImputacionExit(Sender: TObject);
    procedure edImputacionKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnTugTiposComprobantesClick(Sender: TObject);
  private
    _idCompra: GUID_ID;
    procedure Inicializar;
    function getIdCompra: GUID_ID;
    procedure ActualizarProveedor;
    procedure ActualizarImputacion;
    procedure ActualizarMontos;
    procedure AltaItem;
    procedure CargarImputacion;
  public
    property idCompra: GUID_ID read getIdCompra write _idCompra;
  end; 

var
  frmComprasAE: TfrmComprasAE;

implementation
{$R *.lfm}
uses
   dmcompras
   ,frm_plandecuentaslistado
   ,dmplandecuentas
   ,frm_ediciontugs
   ,dmediciontugs
   ,frm_proveedoreslistado
   ,dmproveedores
   ;

{ TfrmComprasAE }

procedure TfrmComprasAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmComprasAE.btnEliminarItemClick(Sender: TObject);
begin
  if (MessageDlg ('CONFIRMACION', '¿Elimino el renglón seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Compras.EliminarItem;
    ActualizarMontos;
  end;
end;

procedure TfrmComprasAE.dbCantidadExit(Sender: TObject);
begin
  ActualizarMontos;
end;

procedure TfrmComprasAE.dbCantidadKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    dbConcepto.SetFocus;
  end;
end;

procedure TfrmComprasAE.dbConceptoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    edImputacion.SetFocus;
  end;
end;

procedure TfrmComprasAE.DBEdit3Exit(Sender: TObject);
begin
  ActualizarMontos;
end;


procedure TfrmComprasAE.DBGrid1SelectEditor(Sender: TObject; Column: TColumn;
  var Editor: TWinControl);
begin
  CargarImputacion;
end;

procedure TfrmComprasAE.dbMontoIVAExit(Sender: TObject);
begin
  ActualizarMontos;
end;

procedure TfrmComprasAE.dbMontoIVAKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    dbMontoTotal.SetFocus;
  end;
end;

procedure TfrmComprasAE.dbMontoTotalKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    ActualizarMontos;
    if (MessageDlg ('CONSULTA', '¿Carga otro renglón?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    begin
      AltaItem;
      dbCantidad.SetFocus;
    end
    else
     btnAceptar.SetFocus;
  end;
end;

procedure TfrmComprasAE.dbMontoUnitarioExit(Sender: TObject);
begin
   ActualizarMontos;
end;

procedure TfrmComprasAE.dbMontoUnitarioKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    dbPorcentajeIVA.SetFocus;
  end;
end;

procedure TfrmComprasAE.dbPorcentajeIVAExit(Sender: TObject);
begin
  ActualizarMontos;
end;

procedure TfrmComprasAE.dbPorcentajeIVAKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    dbMontoIVA.SetFocus;
  end;
end;

procedure TfrmComprasAE.edImputacionExit(Sender: TObject);
begin
  dbMontoUnitario.SetFocus;
  ActualizarImputacion;
end;


procedure TfrmComprasAE.edImputacionKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    dbMontoUnitario.SetFocus;
    ActualizarImputacion;
  end;
end;

procedure TfrmComprasAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idCompra = GUIDNULO then
  begin
    DM_Compras.NuevaCompra;
  end
  else
  begin
    DM_Compras.LevantarCompra (_idCompra);
    ActualizarMontos;
    ActualizarProveedor;
    cbTipoComprobante.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoComprobante,DM_Compras.idTipoComprobante);
  end;
end;


procedure TfrmComprasAE.SpeedButton1Click(Sender: TObject);
var
  pant:TfrmPlanDeCuentasListado;
begin
  pant:= TfrmPlanDeCuentasListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      edImputacion.Text:= pant.CodigoSeleccionado;
      ActualizarImputacion;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmComprasAE.btnTugTiposComprobantesClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'tugTiposComprobantes';
      titulo:= 'Tipos de Comprobantes';
      AgregarCampo('TipoComprobante','Nombre del comprobante');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoComprobante, 'TipoComprobante', 'idTipoComprobante',DM_Compras.qtugTiposComprobantes);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmComprasAE.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoComprobante, 'TipoComprobante', 'idTipoComprobante',DM_Compras.qtugTiposComprobantes);
  btnBuscarProv.SetFocus;
end;


function TfrmComprasAE.getIdCompra: GUID_ID;
begin
  Result:= DM_Compras.idCompraEdicion;
end;

procedure TfrmComprasAE.ActualizarProveedor;
begin
  edProveedor.Text:= DM_Proveedores.ProveedorNombre(DM_Compras.idProveedor);
end;

procedure TfrmComprasAE.ActualizarImputacion;
begin
  if DM_PlanDeCuentas.ExisteCodigoImputacion (TRIM(edImputacion.Text)) then
  begin
    stImputacion.Caption:= DM_PlanDeCuentas.Concepto;
    DM_Compras.CargarImputacion (DM_PlanDeCuentas.idCuenta, DM_PlanDeCuentas.Concepto);
  end
  else
  begin
    ShowMessage ('El código ' + TRIM(edImputacion.Text) + ' no existe');
    edImputacion.Clear;
    edImputacion.SetFocus;
  end;
end;

procedure TfrmComprasAE.ActualizarMontos;
begin
  DM_Compras.actualizarMontosItem;
  DM_Compras.ActualizarMontoTotal;
  stIVA.Caption:= 'Total IVA ' +FormatFloat ('$ ###########0.00', DM_Compras.TotalIVA);
  stNeto.Caption:= 'Total Neto ' +FormatFloat ('$ ###########0.00', DM_Compras.TotalNeto);
end;

procedure TfrmComprasAE.AltaItem;
begin
  edImputacion.Clear;
  stImputacion.Caption:= '-----------';
  DM_Compras.AgregarItem;
end;

procedure TfrmComprasAE.CargarImputacion;
begin
  edImputacion.Text:= DM_Compras.CodigoImputacion;
  ActualizarImputacion;
end;

procedure TfrmComprasAE.btnAgregarItemClick(Sender: TObject);
begin
  AltaItem;
end;

procedure TfrmComprasAE.btnAceptarClick(Sender: TObject);
begin
  DM_Compras.cargarTipoComprobante (DM_General.obtenerIDIntComboBox(cbTipoComprobante));
  DM_Compras.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmComprasAE.btnBuscarProvClick(Sender: TObject);
var
  provBus: TfrmProveedoresListado;
begin
  provBus:= TfrmProveedoresListado.Create (Self);
  try
    if provBus.ShowModal = mrOK then
    begin
      DM_Compras.cargarProveedor (provBus.idProveedor);
      ActualizarProveedor;
    end;
  finally
    provBus.Free;
  end;
end;



end.

