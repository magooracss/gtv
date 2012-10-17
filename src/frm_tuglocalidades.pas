unit frm_tuglocalidades; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls, DBGrids
  , dmgeneral
  ;

type

  { TfrmTugLocalidades }

  TfrmTugLocalidades = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnNueva: TBitBtn;
    btnEditar: TBitBtn;
    btnBorrar: TBitBtn;
    cbProvincias: TComboBox;
    ds_localidades: TDatasource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton10: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNuevaClick(Sender: TObject);
    procedure cbProvinciasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
  private
    procedure Inicializar;
    procedure CargarLocalidades (refProvincia: integer);
    procedure PantallaLocalidades (operacion: TOperacion);
  public
    { public declarations }
  end; 

var
  frmTugLocalidades: TfrmTugLocalidades;

implementation
{$R *.lfm}
uses
  dmediciontugs
  ,frm_ediciontugs
  ,dmlocalidades
  ,frm_localidadae
  ;

{ TfrmTugLocalidades }

procedure TfrmTugLocalidades.SpeedButton10Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPROVINCIAS';
      titulo:= 'Provincias';
      AgregarCampo('provincia','Nombre de la provincia');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbProvincias, 'Provincia', 'idProvincia', DM_Localidades.qtugProvincias);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmTugLocalidades.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmTugLocalidades.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


procedure TfrmTugLocalidades.cbProvinciasChange(Sender: TObject);
begin
  CargarLocalidades (DM_General.obtenerIDIntComboBox(cbProvincias))
end;

procedure TfrmTugLocalidades.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmTugLocalidades.btnBorrarClick(Sender: TObject);
begin
  if (MessageDlg ('CONFIRMACION', '¿Elimino la localidad seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Localidades.EliminarLocalidad;
  end;

end;

procedure TfrmTugLocalidades.Inicializar;
begin
  DM_General.CargarComboBox(cbProvincias, 'Provincia', 'idProvincia', DM_Localidades.qtugProvincias);
  CargarLocalidades (DM_General.obtenerIDIntComboBox(cbProvincias))
end;

procedure TfrmTugLocalidades.CargarLocalidades(refProvincia: integer);
begin
  DM_Localidades.levantarLocalidadesPorProv(refProvincia);
end;

procedure TfrmTugLocalidades.PantallaLocalidades(operacion: TOperacion);
var
  pant: TfrmLocalidadAE;
begin
  pant:= TfrmLocalidadAE.Create(self);
  if operacion = nuevo then
    DM_Localidades.NuevaLocalidad (DM_General.obtenerIDIntComboBox(cbProvincias))
  else
    DM_Localidades.EditarLocalidad;
  try
    if pant.ShowModal = mrOK then
      DM_Localidades.Grabar
    else
      DM_Localidades.Cancelar;
  finally
    pant.Free;
  end;

end;

procedure TfrmTugLocalidades.btnNuevaClick(Sender: TObject);
begin
  PantallaLocalidades(nuevo);
end;

procedure TfrmTugLocalidades.btnEditarClick(Sender: TObject);
begin
  PantallaLocalidades(modificar);
end;


end.

