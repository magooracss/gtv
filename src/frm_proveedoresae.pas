unit frm_proveedoresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls, Buttons
  ,dmgeneral;

type

  { TfrmProveedorAE }

  TfrmProveedorAE = class(TForm)
    btnImputacion: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbCondicionFiscal: TComboBox;
    cbCondicionPago: TComboBox;
    cbTiempoPago: TComboBox;
    cbLocalidades: TComboBox;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    ds_proveedor: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBMemo1: TDBMemo;
    edImputacion: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbImputacion: TLabel;
    lbProvincia: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImputacionClick(Sender: TObject);
    procedure cbLocalidadesChange(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    procedure Inicializar;

  public
    { public declarations }
  end; 

var
  frmProveedorAE: TfrmProveedorAE;

implementation
{$R *.lfm}
uses
  dmproveedores
  ,dmediciontugs
  ,frm_ediciontugs
  ,frm_tuglocalidades
  ,frm_plandecuentaslistado
  ,dmplandecuentas
  ;

{ TfrmProveedorAE }

procedure TfrmProveedorAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmProveedorAE.btnImputacionClick(Sender: TObject);
var
  pant:TfrmPlanDeCuentasListado;
begin
  pant:= TfrmPlanDeCuentasListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
       edImputacion.Text:= pant.CodigoSeleccionado;
       lbImputacion.Caption:= pant.NombreCuentaSeleccionado;
       DM_Proveedores.EditarImputacion (pant.idCuenta);
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmProveedorAE.cbLocalidadesChange(Sender: TObject);
begin
  lbProvincia.Caption:= DM_Proveedores.NombreProvinciaPorLocalidad(DM_General.obtenerIDIntComboBox(cbLocalidades));
end;

procedure TfrmProveedorAE.DBEdit2Exit(Sender: TObject);
begin
  if NOT DM_General.CuitValido(DBEdit2.Text) then
     ShowMessage('Atención, el cuit ingresado podria no ser válido');
end;

procedure TfrmProveedorAE.DBEdit6Exit(Sender: TObject);
begin
   if (TRIM((Sender as TDBEdit).Text) = EmptyStr) then
       ShowMessage('Atención, no debería ingresar un número de Ingresos Brutos?');
end;

procedure TfrmProveedorAE.FormCreate(Sender: TObject);
begin
end;

procedure TfrmProveedorAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmProveedorAE.GroupBox2Click(Sender: TObject);
begin

end;

procedure TfrmProveedorAE.SpeedButton10Click(Sender: TObject);
var
  pantalla: TfrmTugLocalidades;
begin
   pantalla:= TfrmTugLocalidades.Create (self);
   try
     if pantalla.showmodal = mrOK then
     begin
        DM_General.CargarComboBox(cbLocalidades, 'Localidad', 'idLocalidad', DM_Proveedores.qtugLocalidades);
        cbLocalidades.ItemIndex:= DM_General.obtenerIdxCombo(cbLocalidades, DM_Proveedores.tbProveedores.FieldByName('refLocalidad').asInteger);
     end;
   finally
     pantalla.free;
   end;
end;

procedure TfrmProveedorAE.SpeedButton7Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGCONDICIONESFISCALES';
      titulo:= 'Condición Fiscal';
      AgregarCampo('condicionFiscal','Tipo de IVA');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbCondicionFiscal, 'CondicionFiscal', 'idCondicionFiscal', DM_Proveedores.qtugCondicionesFiscales);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmProveedorAE.SpeedButton8Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGCONDICIONESPAGO';
      titulo:= 'Condición de Pago';
      AgregarCampo('CondicionPago','Tipo de Condición');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    cbCondicionPago.ItemIndex:= DM_General.obtenerIdxCombo(cbCondicionPago, DM_Proveedores.tbProveedores.FieldByName('refCondicionPago').asInteger);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmProveedorAE.SpeedButton9Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'tugCondicionPagoTiempos';
      titulo:= 'Tiempos de Pago';
      AgregarCampo('CondicionPagoTiempo','Tiempos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    cbTiempoPago.ItemIndex:= DM_General.obtenerIdxCombo(cbTiempoPago, DM_Proveedores.tbProveedores.FieldByName('refCondicionPagoTiempo').asInteger);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmProveedorAE.Inicializar;
begin
  DM_General.CargarComboBox(cbCondicionFiscal, 'CondicionFiscal', 'idCondicionFiscal', DM_Proveedores.qtugCondicionesFiscales);
  cbCondicionFiscal.ItemIndex:= DM_General.obtenerIdxCombo(cbCondicionFiscal, DM_Proveedores.tbProveedores.FieldByName('refCondicionFiscal').asInteger);

  DM_General.CargarComboBox(cbCondicionPago, 'CondicionPago', 'idCondicionPago', DM_Proveedores.qtugCondicionesPago);
  cbCondicionPago.ItemIndex:= DM_General.obtenerIdxCombo(cbCondicionPago, DM_Proveedores.tbProveedores.FieldByName('refCondicionPago').asInteger);

  DM_General.CargarComboBox(cbTiempoPago, 'CondicionPagoTiempo', 'idCondicionPagoTiempo', DM_Proveedores.qtugCondicionPagoTiempo);
  cbTiempoPago.ItemIndex:= DM_General.obtenerIdxCombo(cbTiempoPago, DM_Proveedores.tbProveedores.FieldByName('refCondicionPagoTiempo').asInteger);

  DM_General.CargarComboBox(cbLocalidades, 'Localidad', 'idLocalidad', DM_Proveedores.qtugLocalidades);
  cbLocalidades.ItemIndex:= DM_General.obtenerIdxCombo(cbLocalidades, DM_Proveedores.tbProveedores.FieldByName('refLocalidad').asInteger);
  lbProvincia.Caption:= DM_Proveedores.NombreProvinciaPorLocalidad(DM_General.obtenerIDIntComboBox(cbLocalidades));

   DM_PlanDeCuentas.CuentaPorID(DM_Proveedores.tbProveedores.FieldByName('refImputacion').asInteger);
   edImputacion.Text:= DM_PlanDeCuentas.Codigo;
   lbImputacion.Caption:= DM_PlanDeCuentas.Concepto;
end;

procedure TfrmProveedorAE.btnAceptarClick(Sender: TObject);
begin
  DM_Proveedores.CargarValores (DM_General.obtenerIDIntComboBox(cbCondicionFiscal)
                                ,DM_General.obtenerIDIntComboBox(cbCondicionPago)
                                ,DM_General.obtenerIDIntComboBox(cbTiempoPago)
                                ,DM_General.obtenerIDIntComboBox(cbLocalidades)
                                );
  DM_Proveedores.Grabar;
  ModalResult:= mrOK;
  DM_Proveedores.tbProveedores.Close;
end;

end.

