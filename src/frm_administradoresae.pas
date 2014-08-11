unit frm_administradoresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids
  , dmgeneral, db
  ;

type

  { TfrmAdministradorAE }

  TfrmAdministradorAE = class(TForm)
    btnGrabarySalir: TBitBtn;
    btnAdmContactoAlta: TBitBtn;
    btnAdmContactoEliminar: TBitBtn;
    btnAdmContactoModificar: TBitBtn;
    btnAdmDomicilioAlta: TBitBtn;
    btnAdmDomicilioEliminar: TBitBtn;
    btnAdmDomicilioModificar: TBitBtn;
    cbAdmDoc: TComboBox;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    ds_administrador: TDatasource;
    DS_ContactosADM: TDatasource;
    DS_DomiciliosADM: TDatasource;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton10: TSpeedButton;
    procedure btnAdmContactoAltaClick(Sender: TObject);
    procedure btnAdmContactoEliminarClick(Sender: TObject);
    procedure btnAdmContactoModificarClick(Sender: TObject);
    procedure btnAdmDomicilioAltaClick(Sender: TObject);
    procedure btnAdmDomicilioEliminarClick(Sender: TObject);
    procedure btnAdmDomicilioModificarClick(Sender: TObject);
    procedure btnGrabarySalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
  private
    _idAdministrador: GUID_ID;
    procedure Inicializar;
  public
    property administrador_id: GUID_ID read _idAdministrador write _idAdministrador;
  end;

var
  frmAdministradorAE: TfrmAdministradorAE;

implementation
{$R *.lfm}
uses
    frm_contactosAE
  , dmclientes
  , frm_domicilioae
  , frm_ediciontugs
  , dmediciontugs
  ;

{ TfrmAdministradorAE }


(*******************************************************************************
*** Contactos del Administrador
*******************************************************************************)


procedure TfrmAdministradorAE.btnAdmContactoAltaClick(Sender: TObject);
var
  pantContacto: TfrmContactosAE;
begin
  pantContacto:= TfrmContactosAE.Create (Self);
  try
    pantContacto.operacion:= nuevo;
    if pantContacto.ShowModal = mrOK then
      DM_Clientes.TablaContactoAdm (pantContacto.Dato
                                    ,pantContacto.idFormaContacto
                                    ,pantContacto.operacion);
  finally
    pantContacto.Free;
  end;
end;

procedure TfrmAdministradorAE.btnAdmContactoEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el contacto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Clientes.EliminarTablaContactoAdm;
end;

procedure TfrmAdministradorAE.btnAdmContactoModificarClick(Sender: TObject);
var
  pantContacto: TfrmContactosAE;
begin
  pantContacto:= TfrmContactosAE.Create (Self);
  try
    pantContacto.operacion:= modificar;
    pantContacto.Dato:= DM_Clientes.tbAdmContactos.FieldByName('contacto').asString;
    pantContacto.idFormaContacto:= DM_Clientes.tbAdmContactos.FieldByName('refTipoContacto').AsInteger;
    if pantContacto.ShowModal = mrOK then
      DM_Clientes.TablaContactoAdm (pantContacto.Dato
                                    ,pantContacto.idFormaContacto
                                    ,pantContacto.operacion);
  finally
    pantContacto.Free;
  end;
end;


(*******************************************************************************
*** Domicilios del Administrador
*******************************************************************************)


procedure TfrmAdministradorAE.btnAdmDomicilioAltaClick(Sender: TObject);
var
  pantDir: Tfrm_DomiciliosAE;
begin
  pantDir:= Tfrm_DomiciliosAE.Create (Self);
  try
    pantDir.operacion:= nuevo;
    if pantDir.ShowModal = mrOK then
      DM_Clientes.TablaDireccionAdm (pantDir.Direccion
                                    ,pantDir.idLocalidad
                                    ,pantDir.operacion);
  finally
    pantDir.Free;
  end;
end;



procedure TfrmAdministradorAE.btnAdmDomicilioModificarClick(Sender: TObject);
var
  pantDir: Tfrm_DomiciliosAE;
begin
  pantDir:= Tfrm_DomiciliosAE.Create (Self);
  try
    pantDir.operacion:= modificar;
    pantDir.Direccion:= DM_Clientes.tbAdmDomicilios.FieldByName('Domicilio').asString;
    pantDir.idLocalidad:= DM_Clientes.tbAdmDomicilios.FieldByName('refLocalidad').AsInteger;
    if pantDir.ShowModal = mrOK then
      DM_Clientes.TablaDireccionAdm (pantDir.Direccion
                                    ,pantDir.idLocalidad
                                    ,pantDir.operacion);
  finally
    pantDir.Free;
  end;
end;

procedure TfrmAdministradorAE.SpeedButton10Click(Sender: TObject);
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
    DM_General.CargarComboBox(cbAdmDoc, 'TipoDocumento' ,'idTipoDocumento', DM_Clientes.qtugTiposDocumento);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmAdministradorAE.btnAdmDomicilioEliminarClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el domicilio seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
     DM_Clientes.EliminarTablaDireccionAdm;
end;


(*******************************************************************************
*** Funciones Generales
*******************************************************************************)

procedure TfrmAdministradorAE.Inicializar;
begin
  DM_General.CargarComboBox(cbAdmDoc, 'TipoDocumento' ,'idTipoDocumento', DM_Clientes.qtugTiposDocumento);
  if _idAdministrador = GUIDNULO then
  begin
    DM_Clientes.AdministradorNuevo;
  end
  else
  begin
    DM_Clientes.LevantarAdministrador(_idAdministrador);
    cbAdmDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbAdmDoc,DM_Clientes.tbAdministradores.FieldByName('refTipoDocumento').asInteger );
  end;
end;



procedure TfrmAdministradorAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;


procedure TfrmAdministradorAE.btnGrabarySalirClick(Sender: TObject);
begin

  with DM_Clientes.tbAdministradores do
  begin
    Edit;
    FieldByName('refTipoDocumento').asInteger:= DM_General.obtenerIDIntComboBox(cbAdmDoc);
    Post;
  end;

  DM_Clientes.grabarAdministrador;
  ModalResult:= mrOK;
end;

end.

