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
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbCondicionFiscal: TComboBox;
    ds_proveedor: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    SpeedButton7: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
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
  ;

{ TfrmProveedorAE }

procedure TfrmProveedorAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmProveedorAE.FormShow(Sender: TObject);
begin
  Inicializar;
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

procedure TfrmProveedorAE.Inicializar;
begin
  DM_General.CargarComboBox(cbCondicionFiscal, 'CondicionFiscal', 'idCondicionFiscal', DM_Proveedores.qtugCondicionesFiscales);
  cbCondicionFiscal.ItemIndex:= DM_General.obtenerIdxCombo(cbCondicionFiscal, DM_Proveedores.tbProveedores.FieldByName('refCondicionFiscal').asInteger);
end;

procedure TfrmProveedorAE.btnAceptarClick(Sender: TObject);
begin
  DM_Proveedores.CargarValores (DM_General.obtenerIDIntComboBox(cbCondicionFiscal));
  DM_Proveedores.Grabar;
  ModalResult:= mrOK;
end;

end.

