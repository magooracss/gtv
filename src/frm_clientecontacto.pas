unit frm_clientecontacto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons
  //Magoo
  ,dmgeneral;

type

  { TfrmContactoCliente }

  TfrmContactoCliente = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbContDoc: TComboBox;
    cbContTipo: TComboBox;
    cbFormaContacto: TComboBox;
    DS_contactosClientes: TDatasource;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Panel10: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    _idContacto: GUID_ID;
    procedure Inicializar;
  public
    property idContacto: GUID_ID read _idContacto write _idContacto;
  end;

var
  frmContactoCliente: TfrmContactoCliente;

implementation
{$R *.lfm}
uses
  frm_ediciontugs
  ,dmediciontugs
  ,dmclientes
  ;


{ TfrmContactoCliente }

procedure TfrmContactoCliente.SpeedButton9Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSCONTACTOCLIENTE';
      titulo:= 'Denominaciones de los contactos en el cliente';
      AgregarCampo('tipocontactocliente','Nombre del tipo de contacto');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbContTipo, 'TipoContactoCliente' ,'idTipoContactoCliente', DM_Clientes.qtugTiposContactoCliente);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmContactoCliente.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmContactoCliente.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmContactoCliente.btnAceptarClick(Sender: TObject);
begin
  DM_Clientes.combosContacto(DM_General.obtenerIDIntComboBox(cbContDoc)
                            , DM_General.obtenerIDIntComboBox(cbContTipo)
                            , DM_General.obtenerIDIntComboBox(cbFormaContacto)
                            );
  ModalResult:= mrOK;
end;

procedure TfrmContactoCliente.SpeedButton10Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSCONTACTO';
      titulo:= 'Formas de contactar al cliente';
      AgregarCampo('tipoContacto','Tipo de Contacto');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbFormaContacto, 'tipoContacto' ,'idTipoContacto', DM_Clientes.qtugTiposContacto);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmContactoCliente.SpeedButton8Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSDOCUMENTO';
      titulo:= 'Denominaciones de los documentos de identidad';
      AgregarCampo('tipoDocumento','Tipo de Documento');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbContDoc, 'TipoDocumento' ,'idTipoDocumento', DM_Clientes.qtugTiposDocumento);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmContactoCliente.Inicializar;
begin
  DM_General.CargarComboBox(cbContDoc,'TipoDocumento' ,'idTipoDocumento', DM_Clientes.qtugTiposDocumento);
  DM_General.CargarComboBox(cbContTipo, 'TipoContactoCliente' ,'idTipoContactoCliente', DM_Clientes.qtugTiposContactoCliente);
  DM_General.CargarComboBox(cbFormaContacto, 'TipoContacto' ,'idTipoContacto', DM_Clientes.qtugTiposContacto);

  if _idContacto = GUIDNULO then
     DM_Clientes.NuevoContactoCliente
  else
      DM_Clientes.LevantarContactoCliente (_idContacto);

  cbContDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbContDoc,DM_Clientes.tbContactosCliente.FieldByName('refTipoDocumento').asInteger );
  cbContTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbContTipo,DM_Clientes.tbContactosCliente.FieldByName('refTipoDocumento').asInteger );
  cbFormaContacto.ItemIndex:= DM_General.obtenerIdxCombo(cbFormaContacto,DM_Clientes.tbContactosCliente.FieldByName('refFormaContacto').asInteger );
end;

end.

