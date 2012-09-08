
unit frm_comprasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBCtrls, DBGrids, dbdateedit
  , dmgeneral, Grids;

type

  { TfrmComprasAE }

  TfrmComprasAE = class(TForm)
    btnAgregarItem: TBitBtn;
    btnModificarItem: TBitBtn;
    btnEliminarItem: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnBuscarProv: TBitBtn;
    btnTugTiposComprobantes1: TSpeedButton;
    btnTugTiposComprobantes2: TSpeedButton;
    cbTipoComprobante: TComboBox;
    cbCondPago: TComboBox;
    cbCondPagoTiempo: TComboBox;
    Compra:     TDatasource;
    DBEdit1:    TDBEdit;
    DBEdit5:    TDBEdit;
    DBEdit6:    TDBEdit;
    dbMontoTotal: TDBEdit;
    dbCantidad: TDBEdit;
    dbConcepto: TDBEdit;
    dbMontoUnitario: TDBEdit;
    dbPorcentajeIVA: TDBEdit;
    dbMontoIVA: TDBEdit;
    DBGrid1:    TDBGrid;
    edImputacion: TEdit;
    GroupBox3:  TGroupBox;
    GroupBox4:  TGroupBox;
    Items:      TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit2:    TDBEdit;
    DBEdit3:    TDBEdit;
    DBEdit4:    TDBEdit;
    edProveedor: TEdit;
    GroupBox1:  TGroupBox;
    GroupBox2:  TGroupBox;
    Label1:     TLabel;
    Label10:    TLabel;
    Label11:    TLabel;
    Label12:    TLabel;
    Label13:    TLabel;
    Label14:    TLabel;
    Label15:    TLabel;
    Label2:     TLabel;
    Label3:     TLabel;
    Label4:     TLabel;
    Label5:     TLabel;
    Label6:     TLabel;
    Label7:     TLabel;
    Label8:     TLabel;
    Label9:     TLabel;
    Panel1:     TPanel;
    Panel2:     TPanel;
    Panel3:     TPanel;
    Panel4:     TPanel;
    Panel5:     TPanel;
    SpeedButton1: TSpeedButton;
    btnTugTiposComprobantes: TSpeedButton;
    SpeedButton2: TSpeedButton;
    stTotalNI:  TStaticText;
    stNeto:     TStaticText;
    stIVA:      TStaticText;
    stImputacion: TStaticText;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAgregarItemClick(Sender: TObject);
    procedure btnBuscarProvClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEliminarItemClick(Sender: TObject);
    procedure btnTugTiposComprobantes1Click(Sender: TObject);
    procedure btnTugTiposComprobantes2Click(Sender: TObject);
    procedure dbCantidadExit(Sender: TObject);
    procedure dbCantidadKeyPress(Sender: TObject; var Key: char);
    procedure dbConceptoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit5Exit(Sender: TObject);
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
    procedure Panel5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnTugTiposComprobantesClick(Sender: TObject);
    procedure stImputacionClick(Sender: TObject);
  private
    _idCompra: GUID_ID;
    flagModificando: boolean; //Esto es un invento para que deje de salir el cartel en todo momento
    flagEsItem: boolean; //Seguimos con la chanchada, esto m«as que deuda técnica es papelón
    procedure Inicializar;
    function getIdCompra: GUID_ID;
    procedure ActualizarProveedor;
    procedure ActualizarImputacion;
    procedure ActualizarMontos;
    procedure AltaItem;
    procedure CargarImputacion;
    procedure ActualizarCombos;

    function ValidarCompra: boolean;
    procedure VAlidarNumeroFactura;
  public
    property idCompra: GUID_ID Read getIdCompra Write _idCompra;
  end;

var
  frmComprasAE: TfrmComprasAE;

implementation

{$R *.lfm}
uses
  dmcompras
  , frm_plandecuentaslistado
  , dmplandecuentas
  , frm_ediciontugs
  , dmediciontugs
  , frm_proveedoreslistado
  , dmproveedores;

{ TfrmComprasAE }

procedure TfrmComprasAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmComprasAE.btnEliminarItemClick(Sender: TObject);
begin
  if (MessageDlg('CONFIRMACION', '¿Elimino el renglón seleccionado?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    DM_Compras.EliminarItem;
    ActualizarMontos;
  end;
end;

procedure TfrmComprasAE.btnTugTiposComprobantes1Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos:    TTablaTUG;
begin
  pantalla := TfrmEdicionTugs.Create(self);
  datos    := TTablaTUG.Create;
  try
    with datos do
    begin
      nombre := 'TugCondicionesPago';
      titulo := 'Condiciones de Pago';
      AgregarCampo('CondicionPago', 'Tipo de Condición de Pago');
    end;
    pantalla.laTUG := datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbCondPago, 'CondicionPago',
      'idCondicionPago', DM_Compras.qtugCondicionesPago);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmComprasAE.btnTugTiposComprobantes2Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos:    TTablaTUG;
begin
  pantalla := TfrmEdicionTugs.Create(self);
  datos    := TTablaTUG.Create;
  try
    with datos do
    begin
      nombre := 'TugCondicionPagoTiempos';
      titulo := 'Tiempos de condiciones de Pago';
      AgregarCampo('CondicionPagoTiempo', 'Tiempo de la Condición de Pago');
    end;
    pantalla.laTUG := datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbCondPagoTiempo, 'CondicionPagoTiempo',
      'idCondicionPagoTiempo', DM_Compras.qtugCondicionPagoTiempo);
  finally
    datos.Free;
    pantalla.Free;
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
  flagEsItem:= false;
  ActualizarMontos;
end;

procedure TfrmComprasAE.DBEdit5Exit(Sender: TObject);
begin
  ValidarNumeroFactura;
end;


procedure TfrmComprasAE.DBGrid1SelectEditor(Sender: TObject; Column: TColumn;
  var Editor: TWinControl);
begin
  CargarImputacion;
end;

procedure TfrmComprasAE.dbMontoIVAExit(Sender: TObject);
begin
  flagModificando:= true;
  ActualizarMontos;
end;

procedure TfrmComprasAE.dbMontoIVAKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    flagModificando:= true;
    dbMontoTotal.SetFocus;
  end;
end;

procedure TfrmComprasAE.dbMontoTotalKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    //ActualizarMontos;
    if (MessageDlg('CONSULTA', '¿Carga otro renglón?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes) then
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
    DM_Compras.LevantarCompra(_idCompra);
    DM_Proveedores.LevantarProveedorID(DM_Compras.idProveedor);
    flagEsItem:= false;
    ActualizarMontos;
    ActualizarProveedor;
    ActualizarCombos;
  end;
end;

procedure TfrmComprasAE.Panel5Click(Sender: TObject);
begin

end;


procedure TfrmComprasAE.SpeedButton1Click(Sender: TObject);
var
  pant: TfrmPlanDeCuentasListado;
begin
  pant := TfrmPlanDeCuentasListado.Create(self);
  try
    if pant.ShowModal = mrOk then
    begin
      edImputacion.Text := pant.CodigoSeleccionado;
      ActualizarImputacion;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmComprasAE.btnTugTiposComprobantesClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos:    TTablaTUG;
begin
  pantalla := TfrmEdicionTugs.Create(self);
  datos    := TTablaTUG.Create;
  try
    with datos do
    begin
      nombre := 'tugTiposComprobantes';
      titulo := 'Tipos de Comprobantes';
      AgregarCampo('TipoComprobante', 'Nombre del comprobante');
    end;
    pantalla.laTUG := datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoComprobante, 'TipoComprobante',
      'idTipoComprobante', DM_Compras.qtugTiposComprobantes);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmComprasAE.stImputacionClick(Sender: TObject);
begin

end;

procedure TfrmComprasAE.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoComprobante, 'TipoComprobante',
    'idTipoComprobante', DM_Compras.qtugTiposComprobantes);
  DM_General.CargarComboBox(cbCondPagoTiempo, 'CondicionPagoTiempo',
    'idCondicionPagoTiempo', DM_Compras.qtugCondicionPagoTiempo);
  DM_General.CargarComboBox(cbCondPago, 'CondicionPago',
    'idCondicionPago', DM_Compras.qtugCondicionesPago);
  btnBuscarProv.SetFocus;
  flagModificando:= false;
  flagEsItem:= true;
end;


function TfrmComprasAE.getIdCompra: GUID_ID;
begin
  Result := DM_Compras.idCompraEdicion;
end;

procedure TfrmComprasAE.ActualizarProveedor;
begin
 //  edProveedor.Text := DM_Proveedores.ProveedorNombre(DM_Compras.idProveedor);
    edProveedor.Text := DM_Proveedores.Nombre;

  //Levanto los defaults
    DM_Compras.cargarTipoComprobante(DM_Proveedores.idTipoComprobante);
    DM_Compras.cargarCondPago(DM_Proveedores.idCondPago);
    DM_Compras.cargarCondPagoTiempo(DM_Proveedores.idConPagoTiempo);

    ActualizarCombos;
end;

procedure TfrmComprasAE.ActualizarImputacion;
begin
  if DM_PlanDeCuentas.ExisteCodigoImputacion(TRIM(edImputacion.Text)) then
  begin
    stImputacion.Caption := DM_PlanDeCuentas.Concepto;
    DM_Compras.CargarImputacion(DM_PlanDeCuentas.idCuenta, DM_PlanDeCuentas.Concepto);
  end
  else
  begin
    ShowMessage('El código ' + TRIM(edImputacion.Text) + ' no existe');
    edImputacion.Clear;
    edImputacion.SetFocus;
  end;
end;

procedure TfrmComprasAE.ActualizarMontos;
var
  ivaAct, totalAct, iva, total: double;
begin
  ivaAct:= StrToFloatDef(dbMontoIVA.Field.Value,0);
  totalAct:= StrToFloatDef(dbMontoTotal.Field.Value,0);
  iva:= 0;
  total:= 0;
  if flagEsItem then
  begin
    DM_Compras.ActualizarMontosItem(iva, total);
    if ( (flagModificando) and ( iva <> ivaAct) ) then
     begin
          if (MessageDlg('CONFIRMACION', 'El iva calculado difiere del iva cargado. Se toma el iva cargado?',
              mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          begin
              DM_Compras.ActualizarMontosItems (ivaAct, totalAct);
              iva:= ivaAct;
              DM_Compras.ActualizarMontosItem (ivaAct, total);
              DM_Compras.ActualizarMontosItems (iva, total);
           end
           else
               DM_Compras.ActualizarMontosItems (iva, total);
     end
  else
    DM_Compras.ActualizarMontosItems (iva, total);
  end;
  DM_Compras.ActualizarMontoTotal;
  stIVA.Caption     := 'Total IVA ' + FormatFloat('$ ###########0.00', DM_Compras.TotalIVA);
  stNeto.Caption    := 'Total Neto ' + FormatFloat('$ ###########0.00',
    DM_Compras.TotalNeto);
  stTotalNI.Caption := 'Neto + IVA ' + FormatFloat('$ ###########0.00',
    DM_Compras.TotalIVA + DM_Compras.TotalNeto);
  flagModificando:= False;
  flagEsItem:= true;
end;

procedure TfrmComprasAE.AltaItem;
begin
  edImputacion.Clear;
  stImputacion.Caption := '-----------';
  DM_Compras.AgregarItem;
  DM_PlanDeCuentas.CuentaPorID(DM_General.TablaValoresInt(_VAL_IMP_CMPR));
  edImputacion.Caption:= DM_PlanDeCuentas.Codigo;
  ActualizarImputacion;
end;

procedure TfrmComprasAE.CargarImputacion;
begin
  edImputacion.Text := DM_Compras.CodigoImputacion;
  ActualizarImputacion;
end;

procedure TfrmComprasAE.ActualizarCombos;
begin
  cbTipoComprobante.ItemIndex := DM_General.obtenerIdxCombo(cbTipoComprobante, DM_Compras.idTipoComprobante);
  cbCondPago.ItemIndex := DM_General.obtenerIdxCombo(cbCondPago, DM_Compras.idCondPago);
  cbCondPagoTiempo.ItemIndex :=DM_General.obtenerIdxCombo(cbTipoComprobante, DM_Compras.idCondPagoTiempo);
end;

function TfrmComprasAE.ValidarCompra: boolean;
begin //Ya se que es una funcion y que saco valores por pantalla :-P
  Result:= true;

  if DM_Compras.TotalIVA = 0 then
    Result:= (MessageDlg('ATENCION', 'No hay ningún IVA cargado. ¿Eso es correcto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes);

  if (TRIM(DBEdit1.Text)=EmptyStr)
     or (TRIM(DBEdit5.Text)=EmptyStr) then
  begin
     Result:= false;
     ShowMessage('Falta completar el número de factura');
  end;

end;

procedure TfrmComprasAE.VAlidarNumeroFactura;
var
  suc, nro: integer;
begin
  suc:= StrToIntDef(TRIM(DBEdit1.Text), 0);
  nro:= StrToIntDef(TRIM(DBEdit5.Text), 0);
  if (suc <> 0) and (nro <> 0) then
  begin
    if  DM_Compras.FacturaExistente (suc, nro, DM_Proveedores.idProveedor) then
     ShowMessage ('La factura ' + IntToStr(suc) + ' - ' + IntToStr(nro) + ' ya esta cargada en este proveedor');
  end;


end;

procedure TfrmComprasAE.btnAgregarItemClick(Sender: TObject);
begin
  AltaItem;
end;

procedure TfrmComprasAE.btnAceptarClick(Sender: TObject);
begin
  IF ValidarCompra then
  begin
    DM_Compras.cargarTipoComprobante(DM_General.obtenerIDIntComboBox(cbTipoComprobante));
    DM_Compras.cargarCondPago(DM_General.obtenerIDIntComboBox(cbCondPago));
    DM_Compras.cargarCondPagoTiempo(DM_General.obtenerIDIntComboBox(cbCondPagoTiempo));
    DM_Compras.Grabar;
    ModalResult := mrOk;
  end;
end;

procedure TfrmComprasAE.btnBuscarProvClick(Sender: TObject);
var
  provBus: TfrmProveedoresListado;
begin
  provBus := TfrmProveedoresListado.Create(Self);
  try
    if provBus.ShowModal = mrOk then
    begin
      DM_Compras.cargarProveedor(provBus.idProveedor);
      DM_Proveedores.LevantarProveedorID(provBus.idProveedor);
      ActualizarProveedor;
    end;
  finally
    provBus.Free;
  end;
end;



end.

