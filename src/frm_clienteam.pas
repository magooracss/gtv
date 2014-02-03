unit frm_clienteam;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, DbCtrls, StdCtrls, EditBtn, DBGrids, dbdateedit, rxdbcomb
  , dmgeneral,dmediciontugs, types;

type

  { Tfrm_ClientesAM }

  Tfrm_ClientesAM = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnAdmContactoAlta: TBitBtn;
    btnAdmContactoEliminar: TBitBtn;
    btnAdmContactoModificar: TBitBtn;
    btnAdmDomicilioAlta: TBitBtn;
    btnAdmDomicilioEliminar: TBitBtn;
    btnAdmDomicilioModificar: TBitBtn;
    btnAdmNuevo: TBitBtn;
    btnAnexos: TBitBtn;
    btnBuscar: TBitBtn;
    btnContClienteAgregar: TBitBtn;
    btnContClienteBorrar: TBitBtn;
    btnContClienteModificar: TBitBtn;
    btnGrabarSalir: TBitBtn;
    btnModificarEquipo: TBitBtn;
    btnAgregarEquipo: TBitBtn;
    btnEliminarEquipo: TBitBtn;
    cbAdmDoc: TComboBox;
    cbConservadorRX: TRxDBComboBox;
    cbDestino: TComboBox;
    cbLocalidad: TComboBox;
    cbRespTecnicoRX: TRxDBComboBox;
    cbTipoAbono: TComboBox;
    cbGrupoFacturacion: TComboBox;
    cbCondicionIVA: TComboBox;
    DBEdit20: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    ds_conservadores: TDatasource;
    DS_ContactosADM: TDatasource;
    ds_administrador: TDatasource;
    DBDateEdit1: TDBDateEdit;
    ds_cliente: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    GrillaEquipos: TDBGrid;
    DS_ContactosClienteCont: TDatasource;
    DS_EquiposCliente: TDatasource;
    DS_DomiciliosADM: TDatasource;
    DS_ContactosCliente: TDatasource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PCPantalla: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    btnTipoAbono: TSpeedButton;
    SpeedButton5: TSpeedButton;
    btnTUGDestino: TSpeedButton;
    SpeedButton7: TSpeedButton;
    StaticText3: TStaticText;
    tabEdificio: TTabSheet;
    tabPropietario: TTabSheet;
    tabAdministrador: TTabSheet;
    tabContactoCliente: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAdmNuevoClick(Sender: TObject);
    procedure btnAgregarEquipoClick(Sender: TObject);
    procedure btnAdmDomicilioAltaClick(Sender: TObject);
    procedure btnAdmContactoAltaClick(Sender: TObject);
    procedure btnAdmContactoEliminarClick(Sender: TObject);
    procedure btnAdmContactoModificarClick(Sender: TObject);
    procedure btnAdmDomicilioEliminarClick(Sender: TObject);
    procedure btnAdmDomicilioModificarClick(Sender: TObject);
    procedure btnAnexosClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnContClienteAgregarClick(Sender: TObject);
    procedure btnContClienteBorrarClick(Sender: TObject);
    procedure btnContClienteModificarClick(Sender: TObject);
    procedure btnEliminarEquipoClick(Sender: TObject);
    procedure btnGrabarSalirClick(Sender: TObject);
    procedure btnModificarEquipoClick(Sender: TObject);
    procedure btnTipoAbonoClick(Sender: TObject);
    procedure btnTUGDestinoClick(Sender: TObject);
    procedure DBEdit11Exit(Sender: TObject);
    procedure DBEdit11KeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel12Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure tabPropietarioContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    _idCliente: GUID_ID;
    _operacion: TOperacion;
    procedure Inicializar;
    procedure AjustarCombos;

    function ValidarCliente: boolean;

    procedure VerificarCUIT;

    procedure contactoCliente (refContacto: GUID_ID);
  public
    property operacion: TOperacion write _operacion;
    property cliente: GUID_ID read _idCliente write _idCliente;
  end; 

var
  frm_ClientesAM: Tfrm_ClientesAM;

implementation
 {$R *.lfm}

 uses
    dmclientes
   ,frm_ediciontugs
   ,frm_contactosAE
   ,frm_domicilioae
   ,frm_equipocliente
   ,frm_conservadoreslistado
   ,frm_resptecnicoslistado
   ,dmEquipos
   ,frm_administradoressel
   ,frm_clientecontacto
    ;

{ Tfrm_ClientesAM }

procedure Tfrm_ClientesAM.FormShow(Sender: TObject);
begin
  case _operacion of
   nuevo:
   begin
    _idCliente := DM_Clientes.ClienteNuevo;
    DM_Equipos.Reinicializar;
    //DM_Equipos.LevantarEquiposCliente(EmptyStr);
   end;
   modificar:
   begin
     DM_Clientes.ClienteEditar (_idCliente);
     AjustarCombos;
     DM_Equipos.LevantarEquiposCliente(_idCliente);
   end;
  end;
end;

procedure Tfrm_ClientesAM.Panel12Click(Sender: TObject);
begin

end;

procedure Tfrm_ClientesAM.SpeedButton1Click(Sender: TObject);
var
  pant: TfrmResponsablesTecnicosListado;
begin
  pant:= TfrmResponsablesTecnicosListado.Create (self);
  try
    if pant.ShowModal =  mrOK then
     DM_General.CargarComboBoxRxTb(cbRespTecnicoRX, 'cNombre', 'idResponsableTecnico', DM_Clientes.tbRespTecnico); ;
  finally
    pant.Free;
  end;
end;

procedure Tfrm_ClientesAM.SpeedButton2Click(Sender: TObject);
var
  pant: TFrmConservadoresListado;
begin
  pant:= TFrmConservadoresListado.Create (self);
  try
    if pant.ShowModal =  mrOK then
     DM_General.CargarComboBoxRxTb(cbConservadorRX, 'cRazonSocial', 'idConservador', DM_Clientes.tbConservadores); ;
  finally
    pant.Free;
  end;
end;

procedure Tfrm_ClientesAM.Inicializar;
begin
  _idCliente:= GUIDNULO;
  DM_General.LevantarTugsATablas(TDataModule(DM_Clientes));
  DM_Clientes.LevantarConservadores;
  DM_Clientes.LevantarResponstablesTecnicos;
  DM_General.CargarComboBox(cbDestino,'Destino', 'idDestinoCliente', DM_Clientes.qtugDestinosCliente);
  DM_General.CargarComboBox(cbLocalidad, 'Localidad', 'idLocalidad', DM_Clientes.qtugLocalidades);
  DM_General.CargarComboBox(cbTipoAbono, 'Abono', 'idAbono',DM_Clientes.qtugAbonos);
  DM_General.CargarComboBoxRxTb(cbRespTecnicoRX, 'cNombre', 'idResponsableTecnico', DM_Clientes.tbRespTecnico);
  //DM_General.CargarComboBoxTb(cbConservador, 'cRazonSocial','idConservador', DM_Clientes.tbConservadores);
  DM_General.CargarComboBoxRxTb(cbConservadorRX, 'cRazonSocial','idConservador', DM_Clientes.tbConservadores);
  DM_General.CargarComboBox(cbGrupoFacturacion, 'GrupoFacturacion', 'idGrupoFacturacion', DM_Clientes.qtugGruposFacturacion);
  DM_General.CargarComboBox(cbCondicionIVA, 'CondicionFiscal' ,'idCondicionFiscal', DM_Clientes.qtugCondicionesFiscales);
  DM_General.CargarComboBox(cbAdmDoc, 'TipoDocumento' ,'idTipoDocumento', DM_Clientes.qtugTiposDocumento);

  PCPantalla.ActivePage:= tabEdificio;
end;

procedure Tfrm_ClientesAM.AjustarCombos;
begin
  cbDestino.ItemIndex:= DM_General.obtenerIdxCombo(cbDestino,DM_Clientes.tbClientes.FieldByName('refDestino').asInteger );
  cbLocalidad.ItemIndex:= DM_General.obtenerIdxCombo(cbLocalidad,DM_Clientes.tbClientes.FieldByName('refLocalidad').asInteger );
  cbTipoAbono.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoAbono,DM_Clientes.tbClientes.FieldByName('refAbono').asInteger );
  cbGrupoFacturacion.ItemIndex:= DM_General.obtenerIdxCombo(cbGrupoFacturacion,DM_Clientes.tbClientes.FieldByName('refGrupoFacturacion').asInteger );
  cbCondicionIVA.ItemIndex:= DM_General.obtenerIdxCombo(cbCondicionIVA,DM_Clientes.tbClientes.FieldByName('refCondicionFiscal').asInteger );
//  cbRespTecnico.ItemIndex:= DM_General.obtenerIdxComboTb(cbRespTecnico,DM_Clientes.tbClientes.FieldByName('refRespTecnico').asString );
 // cbConservador.ItemIndex:= DM_General.obtenerIdxComboTb(cbConservador,DM_Clientes.tbClientes.FieldByName('refConservador').asString );
  cbAdmDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbAdmDoc,DM_Clientes.tbAdministradores.FieldByName('refTipoDocumento').asInteger );
end;

function Tfrm_ClientesAM.ValidarCliente: boolean;
var
  resultado: boolean;
begin
  resultado:= true;

  //Valido el Código de cliente
  if DM_Clientes.CodigoClienteExistente(ds_cliente.DataSet.FieldByName('idCliente').asString
                                        ,ds_cliente.DataSet.FieldByName('cCodigo').asString
                                        ) then
  begin
    if (MessageDlg ('ATENCION', 'El código de cliente ya está cargado en otro cliente. Continúa y lo almacena duplicado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
      resultado:= true
    else
      resultado:= False
  end;

  Result:= resultado;
end;

procedure Tfrm_ClientesAM.VerificarCUIT;
begin
  if NOT DM_General.CuitValido(DBEdit11.Text) then
    ShowMessage('Atención, el CUIT parece no ser válido.');
end;

procedure Tfrm_ClientesAM.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure Tfrm_ClientesAM.btnGrabarSalirClick(Sender: TObject);
begin
 if ValidarCliente then
 begin
   DM_Clientes.CargarCombos (DM_General.obtenerIDIntComboBox(cbDestino)
                            ,DM_General.obtenerIDIntComboBox(cbLocalidad)
                            ,DM_General.obtenerIDIntComboBox(cbTipoAbono)
                            ,DM_General.obtenerIDIntComboBox(cbGrupoFacturacion)
                            ,DM_General.obtenerIDIntComboBox(cbCondicionIVA)
                            ,DM_General.obtenerIDIntComboBox(cbAdmDoc)
                            ,0 //DM_General.obtenerIDIntComboBox(cbContDoc)
                            ,0 //DM_General.obtenerIDIntComboBox(cbContTipo)
                           );
    Application.ProcessMessages;
    DM_Clientes.Grabar;
    ModalResult:= mrOK;
 end;
end;


procedure Tfrm_ClientesAM.DBEdit11Exit(Sender: TObject);
begin
  VerificarCUIT;
end;

procedure Tfrm_ClientesAM.DBEdit11KeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   VerificarCUIT;
end;

(*******************************************************************************
*** GESTION DE TABLAS DE USO GENERAL
*******************************************************************************)

procedure Tfrm_ClientesAM.btnTipoAbonoClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGABONOS';
      titulo:= 'Tipos de Abono';
      AgregarCampo('Abono','Tipo Abono');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoAbono, 'Abono', 'idAbono',DM_Clientes.qtugAbonos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure Tfrm_ClientesAM.btnTUGDestinoClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGDESTINOSCLIENTE';
      titulo:= 'Destinos del cliente';
      AgregarCampo('Destino','Destino Cliente');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbDestino,'Destino', 'idDestinoCliente', DM_Clientes.qtugDestinosCliente);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;


procedure Tfrm_ClientesAM.DBGrid1DblClick(Sender: TObject);
begin

end;

procedure Tfrm_ClientesAM.SpeedButton3Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGGRUPOSFACTURACION';
      titulo:= 'Grupo de Facturación';
      AgregarCampo('GrupoFacturacion','Nombre del Grupo');
      AgregarCampo('DiaFacturacion','Dia de Facturacion');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbGrupoFacturacion, 'GrupoFacturacion', 'idGrupoFacturacion', DM_Clientes.qtugGruposFacturacion);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure Tfrm_ClientesAM.SpeedButton5Click(Sender: TObject);
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

procedure Tfrm_ClientesAM.SpeedButton6Click(Sender: TObject);
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

procedure Tfrm_ClientesAM.SpeedButton7Click(Sender: TObject);
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
    DM_General.CargarComboBox(cbCondicionIVA, 'CondicionFiscal', 'idCondicionFiscal', DM_Clientes.qtugCondicionesFiscales);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure Tfrm_ClientesAM.SpeedButton9Click(Sender: TObject);
begin

end;

procedure Tfrm_ClientesAM.tabPropietarioContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

(*******************************************************************************
*** Contactos del Administrador
*******************************************************************************)

procedure Tfrm_ClientesAM.btnAdmContactoAltaClick(Sender: TObject);
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



procedure Tfrm_ClientesAM.btnAdmContactoEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el contacto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Clientes.EliminarTablaContactoAdm;
end;

procedure Tfrm_ClientesAM.btnAdmContactoModificarClick(Sender: TObject);
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


procedure Tfrm_ClientesAM.btnAdmDomicilioAltaClick(Sender: TObject);
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



procedure Tfrm_ClientesAM.btnAdmDomicilioModificarClick(Sender: TObject);
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


procedure Tfrm_ClientesAM.btnAdmDomicilioEliminarClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el domicilio seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
     DM_Clientes.EliminarTablaDireccionAdm;
end;



(*******************************************************************************
*** Datos de contacto del Contacto en el Cliente
*******************************************************************************)

procedure Tfrm_ClientesAM.btnContClienteAgregarClick(Sender: TObject);
var
  pantContacto: TfrmContactosAE;
begin
  pantContacto:= TfrmContactosAE.Create (Self);
  try
    pantContacto.operacion:= nuevo;
    if pantContacto.ShowModal = mrOK then
      DM_Clientes.TablaContCliente (pantContacto.Dato
                                    ,pantContacto.idFormaContacto
                                    ,pantContacto.operacion);
  finally
    pantContacto.Free;
  end;
end;

procedure Tfrm_ClientesAM.btnContClienteBorrarClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el contacto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
      DM_Clientes.EliminarTablaContCliContacto;
end;

procedure Tfrm_ClientesAM.btnContClienteModificarClick(Sender: TObject);
var
  pantContacto: TfrmContactosAE;
begin
  pantContacto:= TfrmContactosAE.Create (Self);
  try
    pantContacto.operacion:= modificar;
    pantContacto.Dato:= DM_Clientes.tbContCliContacto.FieldByName('contacto').asString;
    pantContacto.idFormaContacto:= DM_Clientes.tbContCliContacto.FieldByName('refTipoContacto').AsInteger;
    if pantContacto.ShowModal = mrOK then
      DM_Clientes.TablaContCliente (pantContacto.Dato
                                    ,pantContacto.idFormaContacto
                                    ,pantContacto.operacion);
  finally
    pantContacto.Free;
  end;

end;



(*******************************************************************************
*** Datos de los Equipos en el Cliente
*******************************************************************************)


procedure Tfrm_ClientesAM.btnAgregarEquipoClick(Sender: TObject);
var
  pant: TfrmEquipoCliente;
begin
  pant:= TfrmEquipoCliente.Create (self);
  try
    pant.operacion:= nuevo;
    pant.idCliente:= DM_Clientes.idCliente;
    if pant.ShowModal = mrOK then
      DM_Equipos.LevantarEquiposCliente(DM_clientes.idCliente);
  finally
    pant.free;
  end;
end;


procedure Tfrm_ClientesAM.btnModificarEquipoClick(Sender: TObject);
var
  pant: TfrmEquipoCliente;
begin
  pant:= TfrmEquipoCliente.Create (self);
  try
    pant.operacion:= modificar;
    pant.idCliente:= DM_Clientes.idCliente;
    if pant.ShowModal = mrOK then
      DM_Equipos.LevantarEquiposCliente(DM_clientes.idCliente);
  finally
    pant.free;
  end;
end;


procedure Tfrm_ClientesAM.btnEliminarEquipoClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Borro el equipo seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
 begin
   DM_Equipos.EliminarEquipoSeleccionado;
   DM_Equipos.LevantarEquiposCliente(DM_clientes.idCliente);
 end;
end;

(*******************************************************************************
****  MANEJO ADMINISTRADOR
********************************************************************************)

procedure Tfrm_ClientesAM.btnAdmNuevoClick(Sender: TObject);
begin
  DM_Clientes.AdministradorNuevo;
end;


procedure Tfrm_ClientesAM.btnBuscarClick(Sender: TObject);
var
  pant: TfrmAdministradoresSel;
begin
  pant:= TfrmAdministradoresSel.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Clientes.asociarAdministrador (pant.idAdministrador);
    end;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
****  ANEXOS
********************************************************************************)

procedure Tfrm_ClientesAM.btnAnexosClick(Sender: TObject);
var
  idx, idxAnexos: integer;
  elBookmark: TBookmark;
  idAnexos: ARR_Anexos;
begin
  idxAnexos:= 1;
  for idx:= 1 to MAX_ANEXOS do
  begin
    idAnexos[idx]:= GUIDNULO;
  end;
  if DS_EquiposCliente.DataSet.RecordCount = 1 then
     idAnexos[idxAnexos]:= DS_EquiposCliente.DataSet.FieldByName('idEquipo').AsString;
  With GrillaEquipos.SelectedRows do
  begin
    for idx:= 0 to Count - 1 do
    begin
      if (idxAnexos <= MAX_ANEXOS) then
      begin
        DS_EquiposCliente.DataSet.GotoBookmark(Pointer(Items[idx]));
        idAnexos[idxAnexos]:= DS_EquiposCliente.DataSet.FieldByName('idEquipo').AsString;
        Inc(idxAnexos);
      end;
    end;
  end;
  DM_Equipos.elCliente:= TRIM(DBEdit2.Text);
  DM_Equipos.laDireccion:= TRIM(DBEdit3.Text) + ' ' + TRIM(DBEdit6.Text);
  DM_Equipos.ImprimirAnexos (idAnexos);
end;



(*******************************************************************************
****  CONTACTO CLIENTE
********************************************************************************)

procedure Tfrm_ClientesAM.contactoCliente(refContacto: GUID_ID);
var
  pant: TfrmContactoCliente;
begin
  pant:= TfrmContactoCliente.Create(self);
  try
    pant.idContacto:= refContacto;
    if pant.ShowModal = mrOK then
    begin
      DM_Clientes.grabarContactosCliente;
      DM_Clientes.ListaContactosCliente;
    end;
  finally
    pant.Free;
  end;

end;

procedure Tfrm_ClientesAM.BitBtn1Click(Sender: TObject);
begin
  contactoCliente(GUIDNULO);
end;

procedure Tfrm_ClientesAM.BitBtn2Click(Sender: TObject);
begin
  contactoCliente(DM_Clientes.tbContactosCliente.FieldByName('idcontactoCliente').asString);
end;

procedure Tfrm_ClientesAM.BitBtn3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el contacto seleccionado ?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Clientes.EliminarTablaContactoCliente;

end;

end.

