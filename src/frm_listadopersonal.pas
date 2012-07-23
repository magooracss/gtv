unit frm_listadopersonal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, ZDataset
  ,dmConexion;

type

  { TfrmListadoPersonal }

  TfrmListadoPersonal = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnTugTecnicos: TSpeedButton;
    DS_ListadoPersonal: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    qListadoPersonal: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnTugTecnicosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idEmpleado: integer;
    _nombreEmpleado: string;
    procedure CargarDatos;
  public
    property idEmpleado: integer read _idEmpleado;
    property NombreEmpleado: string read _nombreEmpleado;
  end; 

var
  frmListadoPersonal: TfrmListadoPersonal;

implementation
{$R *.lfm}
uses
  dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmListadoPersonal }

procedure TfrmListadoPersonal.btnTugTecnicosClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGEMPLEADOS';
      titulo:= 'Empleados y técnicos de la empresa';
      AgregarCampo('Empleado','Apellido y Nombres');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    CargarDatos;
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmListadoPersonal.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmListadoPersonal.BitBtn1Click(Sender: TObject);
begin
  _idEmpleado:= qListadoPersonal.FieldByName('idEmpleado').asInteger;
  _nombreEmpleado:= qListadoPersonal.FieldByName('Empleado').asString;
  ModalResult:= mrOK;
end;

procedure TfrmListadoPersonal.FormShow(Sender: TObject);
begin
  CargarDatos;
end;

procedure TfrmListadoPersonal.CargarDatos;
begin
  with qListadoPersonal do
  begin
    if active then close;
    open;
  end;
end;

end.


