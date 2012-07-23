unit frm_contactosAE;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls
  ,dmclientes, frm_ediciontugs, dmediciontugs, dmgeneral;

type

  { TfrmContactosAE }

  TfrmContactosAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbFormaContacto: TComboBox;
    edDato: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    SpeedButton8: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
  private
    _Dato: string;
    _FormaContacto: integer;
    _laOperacion: TOperacion;
  public
    property Dato: string read _Dato write _Dato;
    property idFormaContacto: integer read _FormaContacto write _FormaContacto;
    property operacion: TOperacion read _laOperacion write _laOperacion;
  end; 

var
  frmContactosAE: TfrmContactosAE;

implementation

{$R *.lfm}

{ TfrmContactosAE }

procedure TfrmContactosAE.SpeedButton8Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSContacto';
      titulo:= 'Tipos de contacto';
      AgregarCampo('TipoContacto','Forma de contacto');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbFormaContacto, 'Tipocontacto', 'idTipoContacto',DM_Clientes.qtugTiposContacto);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmContactosAE.FormCreate(Sender: TObject);
begin
  DM_General.CargarComboBox(cbFormaContacto, 'Tipocontacto', 'idTipoContacto',DM_Clientes.qtugTiposContacto);
end;

procedure TfrmContactosAE.btnAceptarClick(Sender: TObject);
begin
  _Dato:= TRIM (edDato.Text);
  _FormaContacto:= DM_General.obtenerIDIntComboBox(cbFormaContacto);
  ModalResult:= mrOK;
end;

procedure TfrmContactosAE.btnCancelarClick(Sender: TObject);
begin
  _Dato:= EmptyStr;
  _FormaContacto:= 0;
  ModalResult:= mrCancel;
end;

procedure TfrmContactosAE.FormShow(Sender: TObject);
begin
  if _laOperacion = modificar then
  begin
   cbFormaContacto.ItemIndex:= DM_General.obtenerIdxCombo(cbFormaContacto, _FormaContacto );
   edDato.Text:= _Dato;
  end;
end;

end.

