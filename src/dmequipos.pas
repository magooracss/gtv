unit dmEquipos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmConexion, dmgeneral, db;

const
  MAX_ANEXOS = 3;

type

  { TDM_Equipos }
  ARR_Anexos = ARRAY [1..MAX_ANEXOS] of string;

  TDM_Equipos = class(TDataModule)
    qAnexosEquipos: TZQuery;
    qTUGCUARTOMAQUBICACION: TZQuery;
    qTUGPUERTASAUTOMATICASARRASTRE: TZQuery;
    qTUGPUERTASAUTOMATICASTIPOS: TZQuery;
    qTUGPUERTASAUTOMATICASCORRIENTE: TZQuery;
    qTUGSELECTIVAACUMULATIVATIPOS: TZQuery;
    qTUGTIPOSCONTROLTIPOS: TZQuery;
    qTUGPUERTASMANUALESTIPOS: TZQuery;
    qTugTiposParacaidas: TZQuery;
    qtugTiposEquipos: TZQuery;
    qTUGMOTORESMARCAS: TZQuery;
    qtugTiposMaquinasTraccion: TZQuery;
    qTUGTIPOSMAQPROPHIDRAULICA: TZQuery;
    qTUGTIPOSPARAGOLPES: TZQuery;
    qTUGTIPOSMANIOBRASTIPOS: TZQuery;
    tbEquiposAnexos: TRxMemoryData;
    tbEquiposAnexosbVisible01: TLongintField;
    tbEquiposAnexosbVisible02: TLongintField;
    tbEquiposAnexosbVisible03: TLongintField;
    tbEquiposAnexosCM_Otras01: TStringField;
    tbEquiposAnexosCM_Otras02: TStringField;
    tbEquiposAnexosCM_Otras03: TStringField;
    tbEquiposAnexosCT_KG01: TFloatField;
    tbEquiposAnexosCT_KG02: TFloatField;
    tbEquiposAnexosCT_KG03: TFloatField;
    tbEquiposAnexosCT_Personas01: TLongintField;
    tbEquiposAnexosCT_Personas02: TLongintField;
    tbEquiposAnexosCT_Personas03: TLongintField;
    tbEquiposAnexosidEquipo01: TStringField;
    tbEquiposAnexosidEquipo02: TStringField;
    tbEquiposAnexosidEquipo03: TStringField;
    tbEquiposAnexosMarca01: TStringField;
    tbEquiposAnexosMarca02: TStringField;
    tbEquiposAnexosMarca03: TStringField;
    tbEquiposAnexosM_NroIdentificadores01: TStringField;
    tbEquiposAnexosM_NroIdentificadores02: TStringField;
    tbEquiposAnexosM_NroIdentificadores03: TStringField;
    tbEquiposAnexosM_PotenciaHP01: TStringField;
    tbEquiposAnexosM_PotenciaHP02: TStringField;
    tbEquiposAnexosM_PotenciaHP03: TStringField;
    tbEquiposAnexosM_Velocidad01: TStringField;
    tbEquiposAnexosM_Velocidad02: TStringField;
    tbEquiposAnexosM_Velocidad03: TStringField;
    tbEquiposAnexosnNroEquipo01: TLongintField;
    tbEquiposAnexosnNroEquipo02: TLongintField;
    tbEquiposAnexosnNroEquipo03: TLongintField;
    tbEquiposAnexosNombre01: TStringField;
    tbEquiposAnexosNombre02: TStringField;
    tbEquiposAnexosNombre03: TStringField;
    tbEquiposAnexosPCAutomatica01: TStringField;
    tbEquiposAnexosPCAutomatica02: TStringField;
    tbEquiposAnexosPCAutomatica03: TStringField;
    tbEquiposAnexosPCManual01: TStringField;
    tbEquiposAnexosPCManual02: TStringField;
    tbEquiposAnexosPCManual03: TStringField;
    tbEquiposAnexosPCTipoPuertaManual01: TStringField;
    tbEquiposAnexosPCTipoPuertaManual02: TStringField;
    tbEquiposAnexosPCTipoPuertaManual03: TStringField;
    tbEquiposAnexosPC_AutomaticaOtra01: TStringField;
    tbEquiposAnexosPC_AutomaticaOtra02: TStringField;
    tbEquiposAnexosPC_AutomaticaOtra03: TStringField;
    tbEquiposAnexosPC_ManualOtra01: TStringField;
    tbEquiposAnexosPC_ManualOtra02: TStringField;
    tbEquiposAnexosPC_ManualOtra03: TStringField;
    tbEquiposAnexosPC_Material01: TStringField;
    tbEquiposAnexosPC_Material02: TStringField;
    tbEquiposAnexosPC_Material03: TStringField;
    tbEquiposAnexosPhPistonCentral01: TStringField;
    tbEquiposAnexosPhPistonCentral02: TStringField;
    tbEquiposAnexosPhPistonCentral03: TStringField;
    tbEquiposAnexosPHPistonEnterrado01: TStringField;
    tbEquiposAnexosPHPistonEnterrado02: TStringField;
    tbEquiposAnexosPHPistonEnterrado03: TStringField;
    tbEquiposAnexosPHPistonLateral01: TStringField;
    tbEquiposAnexosPHPistonLateral02: TStringField;
    tbEquiposAnexosPHPistonLateral03: TStringField;
    tbEquiposAnexosPHPistonTelescopico01: TStringField;
    tbEquiposAnexosPHPistonTelescopico02: TStringField;
    tbEquiposAnexosPHPistonTelescopico03: TStringField;
    tbEquiposAnexosPHRelacion2_101: TStringField;
    tbEquiposAnexosPHRelacion2_102: TStringField;
    tbEquiposAnexosPHRelacion2_103: TStringField;
    tbEquiposAnexosPRAutomatica01: TStringField;
    tbEquiposAnexosPRAutomatica02: TStringField;
    tbEquiposAnexosPRAutomatica03: TStringField;
    tbEquiposAnexosPRManual01: TStringField;
    tbEquiposAnexosPRManual02: TStringField;
    tbEquiposAnexosPRManual03: TStringField;
    tbEquiposAnexosPropulsionHidraulica01: TStringField;
    tbEquiposAnexosPropulsionHidraulica02: TStringField;
    tbEquiposAnexosPropulsionHidraulica03: TStringField;
    tbEquiposAnexosPRTipoPuertaManual01: TStringField;
    tbEquiposAnexosPRTipoPuertaManual02: TStringField;
    tbEquiposAnexosPRTipoPuertaManual03: TStringField;
    tbEquiposAnexosPR_ManualOtra01: TStringField;
    tbEquiposAnexosPR_ManualOtra02: TStringField;
    tbEquiposAnexosPR_ManualOtra03: TStringField;
    tbEquiposAnexosPR_Material01: TStringField;
    tbEquiposAnexosPR_Material02: TStringField;
    tbEquiposAnexosPR_Material03: TStringField;
    tbEquiposAnexosPuertaAutomaticaArrastre01: TStringField;
    tbEquiposAnexosPuertaAutomaticaArrastre02: TStringField;
    tbEquiposAnexosPuertaAutomaticaArrastre03: TStringField;
    tbEquiposAnexosPuertaAutomaticaCorriente01: TStringField;
    tbEquiposAnexosPuertaAutomaticaCorriente02: TStringField;
    tbEquiposAnexosPuertaAutomaticaCorriente03: TStringField;
    tbEquiposAnexosPuertaAutomaticaTipo01: TStringField;
    tbEquiposAnexosPuertaAutomaticaTipo02: TStringField;
    tbEquiposAnexosPuertaAutomaticaTipo03: TStringField;
    tbEquiposAnexosP_Otro01: TStringField;
    tbEquiposAnexosP_Otro02: TStringField;
    tbEquiposAnexosP_Otro03: TStringField;
    tbEquiposAnexosrefTipo01: TLongintField;
    tbEquiposAnexosrefTipo02: TLongintField;
    tbEquiposAnexosrefTipo03: TLongintField;
    tbEquiposAnexosR_Accesos01: TLongintField;
    tbEquiposAnexosR_Accesos02: TLongintField;
    tbEquiposAnexosR_Accesos03: TLongintField;
    tbEquiposAnexosR_AccesosOpyAd01: TStringField;
    tbEquiposAnexosR_AccesosOpyAd02: TStringField;
    tbEquiposAnexosR_AccesosOpyAd03: TStringField;
    tbEquiposAnexosR_NroPisos01: TLongintField;
    tbEquiposAnexosR_NroPisos02: TLongintField;
    tbEquiposAnexosR_NroPisos03: TLongintField;
    tbEquiposAnexosR_Paradas01: TLongintField;
    tbEquiposAnexosR_Paradas02: TLongintField;
    tbEquiposAnexosR_Paradas03: TLongintField;
    tbEquiposAnexosSelectivaAcumulativa01: TStringField;
    tbEquiposAnexosSelectivaAcumulativa02: TStringField;
    tbEquiposAnexosSelectivaAcumulativa03: TStringField;
    tbEquiposAnexosTensionTipo01: TStringField;
    tbEquiposAnexosTensionTipo02: TStringField;
    tbEquiposAnexosTensionTipo03: TStringField;
    tbEquiposAnexosTipoControl01: TStringField;
    tbEquiposAnexosTipoControl02: TStringField;
    tbEquiposAnexosTipoControl03: TStringField;
    tbEquiposAnexosTipoManiobra01: TStringField;
    tbEquiposAnexosTipoManiobra02: TStringField;
    tbEquiposAnexosTipoManiobra03: TStringField;
    tbEquiposAnexosTipoParacaidas01: TStringField;
    tbEquiposAnexosTipoParacaidas02: TStringField;
    tbEquiposAnexosTipoParacaidas03: TStringField;
    tbEquiposAnexosTipoParacaidasContrapeso01: TStringField;
    tbEquiposAnexosTipoParacaidasContrapeso02: TStringField;
    tbEquiposAnexosTipoParacaidasContrapeso03: TStringField;
    tbEquiposAnexosTipoParagolpe01: TStringField;
    tbEquiposAnexosTipoParagolpe02: TStringField;
    tbEquiposAnexosTipoParagolpe03: TStringField;
    tbEquiposAnexosTMan_Otra01: TStringField;
    tbEquiposAnexosTMan_Otra02: TStringField;
    tbEquiposAnexosTMan_Otra03: TStringField;
    tbEquiposAnexosTM_Otras01: TStringField;
    tbEquiposAnexosTM_Otras02: TStringField;
    tbEquiposAnexosTM_Otras03: TStringField;
    tbEquiposAnexosTPCab_Otro01: TStringField;
    tbEquiposAnexosTPCab_Otro02: TStringField;
    tbEquiposAnexosTPCab_Otro03: TStringField;
    tbEquiposAnexosTPContr_Otro01: TStringField;
    tbEquiposAnexosTPContr_Otro02: TStringField;
    tbEquiposAnexosTPContr_Otro03: TStringField;
    tbEquiposAnexosTraccion01: TStringField;
    tbEquiposAnexosTraccion02: TStringField;
    tbEquiposAnexosTraccion03: TStringField;
    tbEquiposAnexostxObservaciones01: TStringField;
    tbEquiposAnexostxObservaciones02: TStringField;
    tbEquiposAnexostxObservaciones03: TStringField;
    tbEquiposAnexosT_AlternaControlada01: TStringField;
    tbEquiposAnexosT_AlternaControlada02: TStringField;
    tbEquiposAnexosT_AlternaControlada03: TStringField;
    tbEquiposAnexosT_FrecVariable01: TStringField;
    tbEquiposAnexosT_FrecVariable02: TStringField;
    tbEquiposAnexosT_FrecVariable03: TStringField;
    tbEquiposAnexosUbicacion01: TStringField;
    tbEquiposAnexosUbicacion02: TStringField;
    tbEquiposAnexosUbicacion03: TStringField;
    tbEquiposAnexosV_AltaBaja01: TStringField;
    tbEquiposAnexosV_AltaBaja02: TStringField;
    tbEquiposAnexosV_AltaBaja03: TStringField;
    tbEquiposAnexosV_Unica01: TStringField;
    tbEquiposAnexosV_Unica02: TStringField;
    tbEquiposAnexosV_Unica03: TStringField;
    tbEquiposbVisible: TLongintField;
    tbEquiposCM_Otras: TStringField;
    tbEquiposCM_Ubicacion: TLongintField;
    tbEquiposCT_KG: TFloatField;
    tbEquiposCT_Personas: TLongintField;
    tbEquiposDEL: TZQuery;
    qEquiposCliente: TZQuery;
    tbEquiposidEquipo: TStringField;
    tbEquiposINS: TZQuery;
    tbEquiposlxTipoEquipo: TStringField;
    tbEquiposM_Marca: TLongintField;
    tbEquiposM_NroIdentificadores: TStringField;
    tbEquiposM_PotenciaHP: TStringField;
    tbEquiposM_Velocidad: TStringField;
    tbEquiposnNroEquipo: TLongintField;
    tbEquiposNombre: TStringField;
    tbEquiposPC_Automatica: TLongintField;
    tbEquiposPC_automaticaCorriente: TLongintField;
    tbEquiposPC_AutomaticaOtra: TStringField;
    tbEquiposPC_AutomaticaTipo: TLongintField;
    tbEquiposPC_Manual: TLongintField;
    tbEquiposPC_ManualOtra: TStringField;
    tbEquiposPC_ManualTipo: TLongintField;
    tbEquiposPC_Material: TStringField;
    tbEquiposPh_PistonCentral: TLongintField;
    tbEquiposPH_PistonEnterrado: TLongintField;
    tbEquiposPH_PistonLateral: TLongintField;
    tbEquiposPH_PistonTelescopico: TLongintField;
    tbEquiposPH_Relacion2_1: TLongintField;
    tbEquiposPR_Automatica: TLongintField;
    tbEquiposPR_AutomaticaTipoArrastre: TLongintField;
    tbEquiposPR_Manual: TLongintField;
    tbEquiposPR_ManualOtra: TStringField;
    tbEquiposPR_ManualTipo: TLongintField;
    tbEquiposPR_Material: TStringField;
    tbEquiposP_Otro: TStringField;
    tbEquiposP_Tipo: TLongintField;
    tbEquiposrefCliente: TStringField;
    tbEquiposrefTipo: TLongintField;
    tbEquiposR_Accesos: TLongintField;
    tbEquiposR_AccesosOpyAd: TStringField;
    tbEquiposR_NroPisos: TLongintField;
    tbEquiposR_Paradas: TLongintField;
    tbEquiposSA_tipo: TLongintField;
    tbEquiposSEL: TZQuery;
    tbEquiposTC_tipo: TLongintField;
    tbEquiposTMan_Otra: TStringField;
    tbEquiposTman_tipo: TLongintField;
    tbEquiposTM_Otras: TStringField;
    tbEquiposTM_PropHidraulica: TLongintField;
    tbEquiposTM_Traccion: TLongintField;
    tbEquiposTPCab_Otro: TStringField;
    tbEquiposTPCab_tipo: TLongintField;
    tbEquiposTPContr_Otro: TStringField;
    tbEquiposTPContr_tipo: TLongintField;
    tbEquipostxObservaciones: TStringField;
    tbEquiposT_AlternaControlada: TStringField;
    tbEquiposT_FrecVariable: TStringField;
    tbEquiposT_Tipo: TLongintField;
    tbEquiposUPD: TZQuery;
    tbEquipos: TRxMemoryData;
    qTUGTENSIONESTIPO: TZQuery;
    tbEquiposV_AltaBaja: TStringField;
    tbEquiposV_Unica: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbEquiposAfterInsert(DataSet: TDataSet);
  private
    _idCliente: GUID_ID;
    procedure AgregarColumna(laColumna: integer);
    procedure ImprimirAnexoPapel;
  public
    elCliente: string;
    laDireccion: string;
    procedure NuevoEquipo (refCliente: GUID_ID);
    procedure ModificarEquipo;

    procedure ActualizarValores(cbTipoEquipo,  cbTMTraccion, cbTMPropHidr
                              , cbMMarca, cbCMUbicacion, cbTTipo, cbTPCABTipo
                              , cbTPCONTRTipo, cbPTipo, cbTManTipo, cbSATipo
                              , cbTCTipo, cbPCManualTipo, cbPRManualTipo
                              , cbPCAutomaticaTipo, cbPCAutomaticaCorriente
                              , cbPRAutomaticaArrastre  : integer);
    procedure Grabar;

    procedure LevantarEquiposCliente (refCliente: GUID_ID);

    function idEquipoActual: GUID_ID;
    procedure CargarDatosEquipo (refEquipo: GUID_ID);

    procedure EliminarEquipoSeleccionado;
    procedure Reinicializar;

    procedure ImprimirAnexos (losEquipos: ARR_Anexos);
  end; 

var
  DM_Equipos: TDM_Equipos;

implementation
{$R *.lfm}
uses
  dialogs;

{ TDM_Equipos }

procedure TDM_Equipos.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(self, true);
end;

procedure TDM_Equipos.tbEquiposAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('IDEQUIPO').asString:= DM_General.CrearGUID;
    FieldByName('REFCLIENTE').asString:= _idCliente;
    FieldByName('NOMBRE').asString:= '';
    FieldByName('REFTIPO').asInteger:= 0;
    FieldByName('TM_TRACCION').asInteger:= 0;
    FieldByName('TM_PROPHIDRAULICA').asInteger:= 0;
    FieldByName('TM_OTRAS').asInteger:= 0;
    FieldByName('CM_UBICACION').asInteger:= 0;
    FieldByName('CM_OTRAS').asString:= EmptyStr;
    FieldByName('M_MARCA').asInteger:= 0;
    FieldByName('M_VELOCIDAD').asString:= '';
    FieldByName('M_POTENCIAHP').AsString:= '';
    FieldByName('M_NROIDENTIFICADORES').asString:= '';
    FieldByName('T_TIPO').asInteger:= 0;
    FieldByName('T_ALTERNACONTROLADA').AsString:= '';
    FieldByName('T_FRECVARIABLE').AsString:='';
    FieldByName('R_NROPISOS').asInteger:= 0;
    FieldByName('R_PARADAS').asInteger:= 0;
    FieldByName('R_ACCESOS').asInteger:= 0;
    FieldByName('R_ACCESOSOPYAD').asString:= '';
    FieldByName('V_UNICA').AsString:= '';
    FieldByName('V_ALTABAJA').AsString:= '';
    FieldByName('TPCAB_TIPO').asInteger:= 0;
    FieldByName('TPCAB_OTRO').aSString:= '';
    FieldByName('TPCONTR_TIPO').asInteger:= 0;
    FieldByName('TPCONTR_OTRO').AsString:= '';
    FieldByName('P_TIPO').asInteger:= 0;
    FieldByName('P_OTRO').asString:='';
    FieldByName('TMAN_TIPO').asInteger:= 0;
    FieldByName('TMAN_OTRA').AsString:= '';
    FieldByName('SA_TIPO').asInteger:= 0;
    FieldByName('TC_TIPO').asInteger:= 0;
    FieldByName('CT_PERSONAS').asInteger:= 0;
    FieldByName('CT_KG').AsFloat:= 0;
    FieldByName('PC_MATERIAL').asString:= '';
    FieldByName('PC_MANUAL').asInteger:= 0;
    FieldByName('PC_MANUALTIPO').asInteger:= 0;
    FieldByName('PC_MANUALOTRA').AsString:='';
    FieldByName('PC_AUTOMATICA').asInteger:= 0;
    FieldByName('PC_AUTOMATICATIPO').asInteger:= 0;
    FieldByName('PC_AUTOMATICACORRIENTE').asInteger:= 0;
    FieldByName('PC_AUTOMATICAOTRA').AsString:= '';
    FieldByName('PR_MATERIAL').asString:= '';
    FieldByName('PR_MANUAL').asInteger:= 0;
    FieldByName('PR_MANUALTIPO').asInteger:= 0;
    FieldByName('PR_MANUALOTRA').AsString:='';
    FieldByName('PR_AUTOMATICA').asInteger:= 0;
    FieldByName('PR_AUTOMATICATIPOARRASTRE').asInteger:= 0;
    FieldByName('PH_PISTONCENTRAL').asInteger:= 0;
    FieldByName('PH_PISTONLATERAL').asInteger:= 0;
    FieldByName('PH_PISTONENTERRADO').asInteger:= 0;
    FieldByName('PH_PISTONTELESCOPICO').asInteger:= 0;
    FieldByName('PH_RELACION2_1').asInteger:= 0;
    FieldByName('nNroEquipo').asInteger:= 0;
    FieldByName('txObservaciones').AsString:= '';
    FieldByName('BVISIBLE').asInteger:= 1;
  end;
end;


procedure TDM_Equipos.NuevoEquipo(refCliente: GUID_ID);
begin
  _idCliente:= refCliente;
  tbEquipos.Insert;
end;

procedure TDM_Equipos.ModificarEquipo;
begin
  tbEquipos.Edit;
end;

procedure TDM_Equipos.ActualizarValores(cbTipoEquipo, cbTMTraccion,
  cbTMPropHidr, cbMMarca, cbCMUbicacion, cbTTipo, cbTPCABTipo, cbTPCONTRTipo,
  cbPTipo, cbTManTipo, cbSATipo, cbTCTipo, cbPCManualTipo, cbPRManualTipo,
  cbPCAutomaticaTipo, cbPCAutomaticaCorriente, cbPRAutomaticaArrastre: integer);
begin
  with tbEquipos do
  begin
    Edit;
    FieldByName('refTipo').asInteger:= cbTipoEquipo;
    FieldByName('TM_Traccion').asInteger:= cbTMTraccion;
    FieldByName('TM_PropHidraulica').asInteger:= cbTMPropHidr;
    FieldByName('M_Marca').asInteger:= cbMMarca;
    FieldByName('CM_Ubicacion').asInteger:= cbCMUbicacion;
    FieldByName('T_Tipo').asInteger:= cbTTipo;
    FieldByName('TPCAB_Tipo').asInteger:= cbTPCABTipo;
    FieldByName('TPContr_Tipo').asInteger:= cbTPCONTRTipo;
    FieldByName('P_Tipo').asInteger:= cbPTipo;
    FieldByName('TMan_Tipo').asInteger:= cbTManTipo;
    FieldByName('SA_Tipo').asInteger:= cbSATipo;
    FieldByName('TC_Tipo').asInteger:= cbTCTipo;
    FieldByName('PC_ManualTipo').asInteger:= cbPCManualTipo;
    FieldByName('PR_ManualTipo').asInteger:= cbPRManualTipo;
    FieldByName('PC_AutomaticaTipo').asInteger:= cbPCAutomaticaTipo ;
    FieldByName('PC_AutomaticaCorriente').asInteger:= cbPCAutomaticaCorriente;
    FieldByName('PR_AutomaticaTipoArrastre').asInteger:= cbPRAutomaticaArrastre;
    Post;
  end;
end;

procedure TDM_Equipos.Grabar;
begin
  DM_General.GrabarDatos(tbEquiposSEL, tbEquiposINS, tbEquiposUPD, tbEquipos, 'idEquipo');
end;

procedure TDM_Equipos.LevantarEquiposCliente(refCliente: GUID_ID);
begin
  _idCliente:= refCliente;
  DM_General.ReiniciarTabla(tbEquipos);
  with qEquiposCliente do
  begin
    if active then close;
    ParamByName('idCliente').asString:= _idCliente;
    Open;
    tbEquipos.LoadFromDataSet(qEquiposCliente, 0, lmAppend);

    tbEquipos.First; //Siguen sin andarme los campos lookups
    qtugTiposEquipos.Open;
    while Not tbEquipos.EOF do
    begin
      qtugTiposEquipos.First;
      if qtugTiposEquipos.Locate('idTipoEquipo', tbEquipos.FieldByName('refTipo').asInteger, []) then
      begin
        tbEquipos.Edit;
        tbEquipos.FieldByName('lxTipoEquipo').asString:= qtugTiposEquipos.FieldByName('Equipo').asString;
        tbEquipos.Next;
      end;
    end;


  end;
end;

function TDM_Equipos.idEquipoActual: GUID_ID;
begin
  if ((tbEquipos.Active) and (tbEquipos.RecordCount > 0)) then
    Result:= tbEquipos.FieldByName('idEquipo').asString
  else
    Result:= GUIDNULO;
end;

procedure TDM_Equipos.CargarDatosEquipo(refEquipo: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbEquipos);
  with tbEquiposSEL do
  begin
    if active then close;
    ParamByName('idEquipo').asString:= refEquipo;
    Open;
    tbEquipos.LoadFromDataSet(tbEquiposSEL, 0, lmAppend);

    tbEquipos.First; //Siguen sin andarme los campos lookups
    qtugTiposEquipos.Open;
    while Not tbEquipos.EOF do
    begin
      qtugTiposEquipos.First;
      if qtugTiposEquipos.Locate('idTipoEquipo', tbEquipos.FieldByName('refTipo').asInteger, []) then
      begin
        tbEquipos.Edit;
        tbEquipos.FieldByName('lxTipoEquipo').asString:= qtugTiposEquipos.FieldByName('Equipo').asString;
        tbEquipos.Next;
      end;
    end;

  end;
end;

procedure TDM_Equipos.EliminarEquipoSeleccionado;
begin
  with tbEquiposDEL do
  begin
    ParamByName('idEquipo').asString:= tbEquipos.FieldByName('idEquipo').asString;
    ExecSQL;
  end;
end;

procedure TDM_Equipos.Reinicializar;
begin
  DM_General.ReiniciarTabla(tbEquipos);
end;


(*******************************************************************************
***  ANEXOS
*******************************************************************************)

procedure TDM_Equipos.AgregarColumna (laColumna: integer);
var
  idx: integer;
  colstr:string;
  elCampo: string;
begin
  colstr:= '0' + IntToStr(laColumna);
  if NOT (tbEquiposAnexos.State in dsWriteModes) then
    tbEquiposAnexos.Edit;
  for idx:= 0 to qAnexosEquipos.Fields.Count -1 do
  begin
    elCampo:= qAnexosEquipos.Fields[idx].FieldName+colstr;
    if tbEquiposAnexos.FindField(elCampo) <> nil then
      tbEquiposAnexos.FieldByName(elCampo).Value:= qAnexosEquipos.Fields[idx].Value;
  end;
  tbEquiposAnexos.Post;
end;

procedure TDM_Equipos.ImprimirAnexoPapel;
begin
  DM_General.LevantarReporte(_PRN_ANEXO_, tbEquiposAnexos);

  DM_General.AgregarVariableReporte ('Direccion', laDireccion);
  DM_General.AgregarVariableReporte('Cliente', elCliente);
  DM_General.EjecutarReporte;
end;

procedure TDM_Equipos.ImprimirAnexos(losEquipos: ARR_Anexos);
var
  idx: integer;
begin
  DM_General.ReiniciarTabla(tbEquiposAnexos);
  tbEquiposAnexos.Insert;
  for idx:= 1 to MAX_ANEXOS do
  begin
    if losEquipos[idx] <> GUIDNULO then
    begin
      with qAnexosEquipos do
      begin
        if active then close;
        ParamByName('idEquipo').asString:= losEquipos[idx];
        Open;
        if RecordCount > 0 then
          AgregarColumna (idx);
      end;

    end;

  end;
  ImprimirAnexoPapel;
end;

end.

