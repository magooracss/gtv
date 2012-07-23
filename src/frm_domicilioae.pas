unit frm_domicilioae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons
  ,dmclientes, frm_ediciontugs, dmediciontugs, dmgeneral;

type

  { Tfrm_DomiciliosAE }

  Tfrm_DomiciliosAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbLocalidad: TComboBox;
    edDireccion: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton8: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
  private
    _Direccion: string;
    _laOperacion: TOperacion;
    _Localidad: integer;
    { private declarations }
  public
    property Direccion: string read _Direccion write _Direccion;
    property idLocalidad: integer read _Localidad write _Localidad;
    property operacion: TOperacion read _laOperacion write _laOperacion;
  end; 

var
  frm_DomiciliosAE: Tfrm_DomiciliosAE;

implementation

{$R *.lfm}

{ Tfrm_DomiciliosAE }

procedure Tfrm_DomiciliosAE.SpeedButton8Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGLOCALIDADES';
      titulo:= 'Localidades';
      AgregarCampo('Localidad','Localidad');
      AgregarCampo('cPostal','Codigo Postal');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbLocalidad, 'Localidad', 'idLocalidad', DM_Clientes.qtugLocalidades);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure Tfrm_DomiciliosAE.FormCreate(Sender: TObject);
begin
  DM_General.CargarComboBox(cbLocalidad, 'Localidad', 'idLocalidad', DM_Clientes.qtugLocalidades);
end;

procedure Tfrm_DomiciliosAE.FormShow(Sender: TObject);
begin
  if _laOperacion = modificar then
  begin
   cbLocalidad.ItemIndex:= DM_General.obtenerIdxCombo(cbLocalidad, _Localidad );
   edDireccion.Text:= _Direccion;
  end;
end;

procedure Tfrm_DomiciliosAE.btnAceptarClick(Sender: TObject);
begin
  _Direccion:= TRIM (edDireccion.Text);
  _Localidad:= DM_General.obtenerIDIntComboBox(cbLocalidad);
  ModalResult:= mrOK;
end;

procedure Tfrm_DomiciliosAE.btnCancelarClick(Sender: TObject);
begin
  _Direccion:= EmptyStr;
  _Localidad:= 0;
  ModalResult:= mrCancel;
end;

end.

