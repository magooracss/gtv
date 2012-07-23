unit frm_cuotaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, EditBtn
  ,dmgeneral
  ;

type

  { TfrmCuotaAE }

  TfrmCuotaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbEstadoCuota: TComboBox;
    cbTipoCuota: TComboBox;
    edMonto: TEdit;
    edVencimiento: TDateEdit;
    edFechaPago: TDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
  private
    _FechaPago: TDateTime;
    _fVencimiento: TdateTime;
    _idEstado: integer;
    _idTipo: integer;
    _Monto: double;

    procedure Inicializar;
    procedure CargarPantalla;
    procedure LevantarPantalla;

  public
    property idTipo: integer read _idTipo write _idTipo;
    property Vencimiento: TdateTime read _fVencimiento write _fVencimiento;
    property idEstado: integer read _idEstado write _idEstado;
    property Monto: double read _Monto write _Monto;
    property FechaPago: TDateTime read _FechaPago write _FechaPago;
  end; 

var
  frmCuotaAE: TfrmCuotaAE;

implementation
{$R *.lfm}
uses
  dmpresupuestos
  ,dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmCuotaAE }

procedure TfrmCuotaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCuotaAE.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmCuotaAE.FormShow(Sender: TObject);
begin
  CargarPantalla;
end;

procedure TfrmCuotaAE.SpeedButton13Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSCUOTA';
      titulo:= 'Distintos tipos de cuotas/conceptos';
      AgregarCampo('TIPOCUOTA','Nombre');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoCuota,'TipoCuota','idTipoCuota', DM_Presupuestos.qtugTiposCuotas);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmCuotaAE.SpeedButton14Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGESTADOSCUOTA';
      titulo:= 'Distintos estados de cuotas/conceptos';
      AgregarCampo('ESTADOCUOTA','Nombre del estado');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbEstadoCuota,'EstadoCuota','idEstadoCuota', DM_Presupuestos.qtugEstadosCuota);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmCuotaAE.Inicializar;
begin
  _FechaPago:= 0;
  _fVencimiento:= Now;
  _idEstado:= 0;
  _idTipo:= 0;
  _Monto:= 0;

  DM_General.CargarComboBox(cbTipoCuota,'TipoCuota','idTipoCuota', DM_Presupuestos.qtugTiposCuotas);
  DM_General.CargarComboBox(cbEstadoCuota,'EstadoCuota','idEstadoCuota', DM_Presupuestos.qtugEstadosCuota);

  if cbEstadoCuota.Items.Count >= 2 then
   _idEstado:= 1;
  if cbTipoCuota.Items.Count >= 2 then
   _idTipo:= 1;
end;

procedure TfrmCuotaAE.CargarPantalla;
begin
  cbTipoCuota.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoCuota, _idTipo);
  cbEstadoCuota.ItemIndex:= DM_General.obtenerIdxCombo(cbEstadoCuota, _idEstado);
  edMonto.Text:= FormatFloat('########00.00', _Monto);
  edFechaPago.Date:= _FechaPago;
  edVencimiento.Date:= _fVencimiento;
end;

procedure TfrmCuotaAE.LevantarPantalla;
begin
  _idTipo:= DM_General.obtenerIDIntComboBox(cbTipoCuota);
  _idEstado:= DM_General.obtenerIDIntComboBox(cbEstadoCuota);
  _Monto:= StrToFloatDef(edMonto.Text, 0);
  _FechaPago:= edFechaPago.Date;
  _fVencimiento:= edVencimiento.Date;
end;

procedure TfrmCuotaAE.btnAceptarClick(Sender: TObject);
begin
  LevantarPantalla;
  ModalResult:= mrOK;
end;

end.

