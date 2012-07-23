unit frm_equipocliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DbCtrls
  , dmgeneral,dmediciontugs;

type

  { TfrmEquipoCliente }

  TfrmEquipoCliente = class(TForm)
    btnGrabarySalir: TBitBtn;
    cbPCAutomaticaTipo: TComboBox;
    cbPCAutomaticaCorriente: TComboBox;
    cbPRAutomaticaArrastre: TComboBox;
    cbPRManualTipo: TComboBox;
    cbSATipo: TComboBox;
    cbTCTipo: TComboBox;
    cbTPCABTipo: TComboBox;
    cbTipoEquipo: TComboBox;
    cbTMTraccion: TComboBox;
    cbTMPropHidr: TComboBox;
    cbCMUbicacion: TComboBox;
    cbMMarca: TComboBox;
    cbTManTipo: TComboBox;
    cbPCManualTipo: TComboBox;
    cbTPCONTRTipo: TComboBox;
    cbPTipo: TComboBox;
    cbTTipo: TComboBox;
    ckPH_PistonLateral1: TCheckBox;
    ckPH_Relacion2_1: TCheckBox;
    ckPH_PistonTelescopico: TCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBEdit20: TDBEdit;
    DBMemo1: TDBMemo;
    DS_Equipo: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    GroupBox19: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox20: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
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
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton9: TSpeedButton;
    procedure btnGrabarySalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure SpeedButton31Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _operacion: TOperacion;
    procedure LevantarCombos;
    procedure PosicionarCombos;
  public
    property operacion: TOperacion read _operacion write _operacion;
    property idCliente: GUID_ID read _idCliente write _idCliente;
  end; 

var
  frmEquipoCliente: TfrmEquipoCliente;

implementation
{$R *.lfm}
uses
   dmEquipos
  ,frm_ediciontugs
  ;

{ TfrmEquipoCliente }

(*******************************************************************************
*** ACCESO A LAS TABLAS DE USO GENERAL
*******************************************************************************)
procedure TfrmEquipoCliente.SpeedButton9Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSEQUIPOS';
      titulo:= 'Tipos de Equipos';
      AgregarCampo('Equipo','Detalle del equipo');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoEquipo, 'Equipo', 'idTipoEquipo',DM_Equipos.qtugTiposEquipos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;



procedure TfrmEquipoCliente.SpeedButton10Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSMAQUINASTRACCION';
      titulo:= 'Tipo de máquina - Tracción';
      AgregarCampo('Traccion','Tipo de Tracción');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTMTraccion, 'Traccion', 'IDTIPOMAQTRACCION',DM_Equipos.qtugTiposMaquinasTraccion);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton11Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSMAQPROPHIDRAULICA';
      titulo:= 'Tipo de máquina - Propulsión hidráulica';
      AgregarCampo('PROPULSIONHIDRAULICA','Tipo de Propulsión hidráulica');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTMPropHidr, 'PROPULSIONHIDRAULICA', 'IDTIPOMAQPROPHIDRAULICA',DM_Equipos.qTUGTIPOSMAQPROPHIDRAULICA);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;


procedure TfrmEquipoCliente.SpeedButton13Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGMOTORESMARCAS';
      titulo:= 'Marcas de motores';
      AgregarCampo('Marca','Marcas');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbMMarca, 'Marca', 'IDMotorMarca',DM_Equipos.qTUGMOTORESMARCAS);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;


procedure TfrmEquipoCliente.SpeedButton12Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGCUARTOMAQUBICACION';
      titulo:= 'Ubicaciones cuarto de máquinas';
      AgregarCampo('Ubicacion','Ubicación');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbCMUbicacion, 'Ubicacion', 'IDCUARTOMAQUBICACION',DM_Equipos.qTUGCUARTOMAQUBICACION);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton16Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTENSIONESTIPO';
      titulo:= 'Tipos de tensiones';
      AgregarCampo('TensionTipo','Tensión');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTTipo, 'TensionTipo', 'IDTensionTipo',DM_Equipos.qTUGTENSIONESTIPO);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton21Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSPARACAIDAS';
      titulo:= 'Tipos de Paracaídas';
      AgregarCampo('tipoParacaidas','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTPCABTipo, 'TipoParacaidas', 'IDTipoParacaidas',DM_Equipos.qTugTiposParacaidas);
    DM_General.CargarComboBox(cbTPCONTRTipo, 'TipoParacaidas', 'IDTipoParacaidas',DM_Equipos.qTugTiposParacaidas);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton23Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSPARAGOLPES';
      titulo:= 'Tipos de Paragolpes';
      AgregarCampo('tipoParagolpe','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbPTipo, 'TipoParagolpe', 'IDTIPOPARAGOLPE',DM_Equipos.qTUGTIPOSPARAGOLPES);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton24Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSMANIOBRASTIPOS';
      titulo:= 'Tipos de Maniobras';
      AgregarCampo('TIPOMANIOBRA','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTManTipo, 'TIPOMANIOBRA', 'IDTIPOMANIOBRATIPO',DM_Equipos.qTUGTIPOSMANIOBRASTIPOS);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton25Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGSELECTIVAACUMULATIVATIPOS';
      titulo:= 'Tipos de Selectiva Acumulativa';
      AgregarCampo('SELECTIVAACUMULATIVA','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbSATipo, 'SELECTIVAACUMULATIVA', 'IDSELECTIVAACUMULATIVATIPO',DM_Equipos.qTUGSELECTIVAACUMULATIVATIPOS);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton26Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSCONTROLTIPOS';
      titulo:= 'Tipos de Control';
      AgregarCampo('TIPOCONTROL','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTCTipo, 'TIPOCONTROL', 'IDTIPOCONTROLTIPO',DM_Equipos.qTUGTIPOSCONTROLTIPOS);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton27Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPUERTASMANUALESTIPOS';
      titulo:= 'Tipos de Puertas Manuales';
      AgregarCampo('TIPOPUERTAMANUAL','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbPCManualTipo, 'TIPOPUERTAMANUAL', 'IDPUERTAMANUALTIPO',DM_Equipos.qTUGPUERTASMANUALESTIPOS);
    DM_General.CargarComboBox(cbPRManualTipo, 'TIPOPUERTAMANUAL', 'IDPUERTAMANUALTIPO',DM_Equipos.qTUGPUERTASMANUALESTIPOS);

  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton28Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPUERTASAUTOMATICASTIPOS';
      titulo:= 'Tipos de Puertas Automáticas';
      AgregarCampo('PUERTAAUTOMATICATIPO','Tipos');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbPCAutomaticaTipo, 'PUERTAAUTOMATICATIPO', 'IDPUERTAAUTOMATICATIPO',DM_Equipos.qTUGPUERTASAUTOMATICASTIPOS);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton31Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPUERTASAUTOMATICASCORRIENTE';
      titulo:= 'Corriente de las Puertas Automáticas';
      AgregarCampo('PUERTAAUTOMATICACORRIENTE','Corrientes');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbPCAutomaticaCorriente, 'PUERTAAUTOMATICACORRIENTE', 'IDPUERTAAUTOMATICACORRIENTE',DM_Equipos.qTUGPUERTASAUTOMATICASCORRIENTE);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmEquipoCliente.SpeedButton30Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPUERTASAUTOMATICASARRASTRE';
      titulo:= 'Tipo de arrastre de las Puertas Automáticas';
      AgregarCampo('PUERTAAUTOMATICAARRASTRE','Arrastre');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbPRAutomaticaArrastre, 'PUERTAAUTOMATICAARRASTRE', 'IDPUERTAAUTOMATICAARRASTRE',DM_Equipos.qTUGPUERTASAUTOMATICASARRASTRE);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

(*******************************************************************************
*** LEVANTA Y GRABA LOS DATOS EN LA BASE
*******************************************************************************)

procedure TfrmEquipoCliente.LevantarCombos;
begin
  DM_General.CargarComboBox(cbTipoEquipo, 'Equipo', 'idTipoEquipo',DM_Equipos.qtugTiposEquipos);
  DM_General.CargarComboBox(cbTMTraccion, 'Traccion', 'IDTIPOMAQTRACCION',DM_Equipos.qtugTiposMaquinasTraccion);
  DM_General.CargarComboBox(cbTMPropHidr, 'PROPULSIONHIDRAULICA', 'IDTIPOMAQPROPHIDRAULICA',DM_Equipos.qTUGTIPOSMAQPROPHIDRAULICA);
  DM_General.CargarComboBox(cbMMarca, 'Marca', 'IDMotorMarca',DM_Equipos.qTUGMOTORESMARCAS);
  DM_General.CargarComboBox(cbCMUbicacion, 'Ubicacion', 'IDCUARTOMAQUBICACION',DM_Equipos.qTUGCUARTOMAQUBICACION);
  DM_General.CargarComboBox(cbTTipo, 'TensionTipo', 'IDTensionTipo',DM_Equipos.qTUGTENSIONESTIPO);
  DM_General.CargarComboBox(cbTPCABTipo, 'TipoParacaidas', 'IDTipoParacaidas',DM_Equipos.qTugTiposParacaidas);
  DM_General.CargarComboBox(cbTPCONTRTipo, 'TipoParacaidas', 'IDTipoParacaidas',DM_Equipos.qTugTiposParacaidas);
  DM_General.CargarComboBox(cbPTipo, 'TipoParagolpe', 'IDTIPOPARAGOLPE',DM_Equipos.qTUGTIPOSPARAGOLPES);
  DM_General.CargarComboBox(cbTManTipo, 'TIPOMANIOBRA', 'IDTIPOMANIOBRATIPO',DM_Equipos.qTUGTIPOSMANIOBRASTIPOS);
  DM_General.CargarComboBox(cbSATipo, 'SELECTIVAACUMULATIVA', 'IDSELECTIVAACUMULATIVATIPO',DM_Equipos.qTUGSELECTIVAACUMULATIVATIPOS);
  DM_General.CargarComboBox(cbTCTipo, 'TIPOCONTROL', 'IDTIPOCONTROLTIPO',DM_Equipos.qTUGTIPOSCONTROLTIPOS);
  DM_General.CargarComboBox(cbPCManualTipo, 'TIPOPUERTAMANUAL', 'IDPUERTAMANUALTIPO',DM_Equipos.qTUGPUERTASMANUALESTIPOS);
  DM_General.CargarComboBox(cbPRManualTipo, 'TIPOPUERTAMANUAL', 'IDPUERTAMANUALTIPO',DM_Equipos.qTUGPUERTASMANUALESTIPOS);
  DM_General.CargarComboBox(cbPCAutomaticaTipo, 'PUERTAAUTOMATICATIPO', 'IDPUERTAAUTOMATICATIPO',DM_Equipos.qTUGPUERTASAUTOMATICASTIPOS);
  DM_General.CargarComboBox(cbPCAutomaticaCorriente, 'PUERTAAUTOMATICACORRIENTE', 'IDPUERTAAUTOMATICACORRIENTE',DM_Equipos.qTUGPUERTASAUTOMATICASCORRIENTE);
  DM_General.CargarComboBox(cbPRAutomaticaArrastre, 'PUERTAAUTOMATICAARRASTRE', 'IDPUERTAAUTOMATICAARRASTRE',DM_Equipos.qTUGPUERTASAUTOMATICASARRASTRE);
end;

procedure TfrmEquipoCliente.PosicionarCombos;
begin
  cbTipoEquipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoEquipo,DM_Equipos.tbEquipos.FieldByName('refTipo').asInteger );
  cbTMTraccion.ItemIndex:= DM_General.obtenerIdxCombo(cbTMTraccion,DM_Equipos.tbEquipos.FieldByName('TM_Traccion').asInteger );
  cbTMPropHidr.ItemIndex:= DM_General.obtenerIdxCombo(cbTMPropHidr,DM_Equipos.tbEquipos.FieldByName('TM_PropHidraulica').asInteger );
  cbMMarca.ItemIndex:= DM_General.obtenerIdxCombo(cbMMarca,DM_Equipos.tbEquipos.FieldByName('M_Marca').asInteger );
  cbCMUbicacion.ItemIndex:= DM_General.obtenerIdxCombo(cbCMUbicacion,DM_Equipos.tbEquipos.FieldByName('CM_Ubicacion').asInteger );
  cbTTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTTipo,DM_Equipos.tbEquipos.FieldByName('T_Tipo').asInteger );
  cbTPCABTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTPCABTipo,DM_Equipos.tbEquipos.FieldByName('TPCAB_Tipo').asInteger );
  cbTPCONTRTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTPCONTRTipo,DM_Equipos.tbEquipos.FieldByName('TPContr_Tipo').asInteger );
  cbPTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbPTipo,DM_Equipos.tbEquipos.FieldByName('P_Tipo').asInteger );
  cbTManTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTManTipo,DM_Equipos.tbEquipos.FieldByName('TMan_Tipo').asInteger );
  cbSATipo.ItemIndex:= DM_General.obtenerIdxCombo(cbSATipo,DM_Equipos.tbEquipos.FieldByName('SA_Tipo').asInteger );
  cbTCTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTCTipo,DM_Equipos.tbEquipos.FieldByName('TC_Tipo').asInteger );
  cbPCManualTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbPCManualTipo,DM_Equipos.tbEquipos.FieldByName('PC_ManualTipo').asInteger );
  cbPRManualTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbPRManualTipo,DM_Equipos.tbEquipos.FieldByName('PR_ManualTipo').asInteger );
  cbPCAutomaticaTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbPCAutomaticaTipo,DM_Equipos.tbEquipos.FieldByName('PC_AutomaticaTipo').asInteger );
  cbPCAutomaticaCorriente.ItemIndex:= DM_General.obtenerIdxCombo(cbPCAutomaticaCorriente,DM_Equipos.tbEquipos.FieldByName('PC_AutomaticaCorriente').asInteger );
  cbPRAutomaticaArrastre.ItemIndex:= DM_General.obtenerIdxCombo(cbPRAutomaticaArrastre,DM_Equipos.tbEquipos.FieldByName('PR_AutomaticaTipoArrastre').asInteger );
end;

procedure TfrmEquipoCliente.btnGrabarySalirClick(Sender: TObject);
begin
  DM_Equipos.ActualizarValores(
                               DM_General.obtenerIDIntComboBox(cbTipoEquipo)
                              ,DM_General.obtenerIDIntComboBox(cbTMTraccion)
                              ,DM_General.obtenerIDIntComboBox(cbTMPropHidr)
                              ,DM_General.obtenerIDIntComboBox(cbMMarca)
                              ,DM_General.obtenerIDIntComboBox(cbCMUbicacion)
                              ,DM_General.obtenerIDIntComboBox(cbTTipo)
                              ,DM_General.obtenerIDIntComboBox(cbTPCABTipo)
                              ,DM_General.obtenerIDIntComboBox(cbTPCONTRTipo)
                              ,DM_General.obtenerIDIntComboBox(cbPTipo)
                              ,DM_General.obtenerIDIntComboBox(cbTManTipo)
                              ,DM_General.obtenerIDIntComboBox(cbSATipo)
                              ,DM_General.obtenerIDIntComboBox(cbTCTipo)
                              ,DM_General.obtenerIDIntComboBox(cbPCManualTipo)
                              ,DM_General.obtenerIDIntComboBox(cbPRManualTipo)
                              ,DM_General.obtenerIDIntComboBox(cbPCAutomaticaTipo)
                              ,DM_General.obtenerIDIntComboBox(cbPCAutomaticaCorriente)
                              ,DM_General.obtenerIDIntComboBox(cbPRAutomaticaArrastre)
                              );
  DM_Equipos.Grabar;

  modalResult:= mrOK;
end;

procedure TfrmEquipoCliente.FormCreate(Sender: TObject);
begin
  LevantarCombos;
  _idCliente:= GUIDNULO;
end;

procedure TfrmEquipoCliente.FormShow(Sender: TObject);
begin
  case _operacion of
   nuevo: DM_Equipos.NuevoEquipo (_idCliente);
   modificar:
   begin
     PosicionarCombos;
     DM_Equipos.ModificarEquipo;
   end;
  end;
end;

end.

