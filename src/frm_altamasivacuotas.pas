unit frm_altamasivacuotas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, EditBtn;

type

  { TfrmAltaMasivaCuotas }

  TfrmAltaMasivaCuotas = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbTipoCuota: TComboBox;
    cbEstadoCuota: TComboBox;
    edPrimerVencimiento: TDateEdit;
    edCantCuotas: TEdit;
    edMonto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
  private
    procedure Inicializar;
    procedure GenerarCuotas;
  public
    { public declarations }
  end; 

var
  frmAltaMasivaCuotas: TfrmAltaMasivaCuotas;

implementation
{$R *.lfm}
uses
   dmgeneral
   ,dmpresupuestos
   ,dateutils
   ,frm_ediciontugs
   ,dmediciontugs
   ;

{ TfrmAltaMasivaCuotas }

procedure TfrmAltaMasivaCuotas.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmAltaMasivaCuotas.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmAltaMasivaCuotas.SpeedButton13Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'tugTiposCuota';
      titulo:= 'Nombre de los tipos de cuota';
      AgregarCampo('TipoCuota','Tipo');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoCuota, 'TipoCuota', 'idTipoCuota',DM_Presupuestos.qtugTiposCuotas);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmAltaMasivaCuotas.SpeedButton14Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'tugEstadosCuota';
      titulo:= 'Nombre de los distintos estados de una cuota';
      AgregarCampo('EstadoCuota','Estados');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbEstadoCuota, 'Estadocuota', 'idEstadoCuota',DM_Presupuestos.qtugEstadosCuota);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmAltaMasivaCuotas.btnAceptarClick(Sender: TObject);
begin
  if (MessageDlg ('CUIDADO', 'Establezco este plan de cuotas para el presupuesto?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    GenerarCuotas;
    ModalResult:= mrOK;
  end;
end;

procedure TfrmAltaMasivaCuotas.Inicializar;
begin
  edCantCuotas.Text:= '1';
  DM_General.CargarComboBox(cbTipoCuota,'TipoCuota','idTipoCuota', DM_Presupuestos.qtugTiposCuotas);
  DM_General.CargarComboBox(cbEstadoCuota,'EstadoCuota','idEstadoCuota', DM_Presupuestos.qtugEstadosCuota);
  edMonto.Text:= '0';
  edPrimerVencimiento.Date:= Now;
  if cbEstadoCuota.Items.Count >= 2 then
   cbEstadoCuota.ItemIndex:= 1;
  if cbTipoCuota.Items.Count >= 2 then
   cbTipoCuota.ItemIndex:= 1;

end;

procedure TfrmAltaMasivaCuotas.GenerarCuotas;
var
   cantCuotas
  ,idx
  ,refTipo, refEstado
  ,MesBase: Integer;
  valorMonto: double;
  vencimiento: TDateTime;
begin
  cantCuotas:= StrToIntDef(edCantCuotas.Text, 0);
  valorMonto:= StrToFloatDef(edMonto.TExt, 0);
  refTipo:= DM_General.obtenerIDIntComboBox(cbTipoCuota);
  refEstado:= DM_General.obtenerIDIntComboBox(cbEstadoCuota);
  MesBase:= MonthOf(edPrimerVencimiento.Date);
  DM_General.ReiniciarTabla(DM_Presupuestos.tbCuotasPresupuesto);
  for idx:= 1  to cantCuotas do
  begin
    vencimiento:= IncMonth(edPrimerVencimiento.Date, (MesBase + (idx - 1)));
    DM_Presupuestos.AltaCuota (idx, refTipo, vencimiento, valorMonto, refEstado, 0);
  end;
end;

end.

