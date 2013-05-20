unit frm_chequesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, StdCtrls, Buttons, dbdateedit, dmgeneral, dmcheques
  ;

type

  { TfrmChequeAE }

  TfrmChequeAE = class(TForm)
    btnBuscarEntregadoA: TBitBtn;
    btnBuscarRecibidoDe: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugTecnicos: TSpeedButton;
    btnTugTecnicos1: TSpeedButton;
    cbBancos: TComboBox;
    cbChequesEstados: TComboBox;
    ds_Cheque: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBDateEdit3: TDBDateEdit;
    DBDateEdit4: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    procedure btnBuscarEntregadoAClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarRecibidoDeClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnTugTecnicos1Click(Sender: TObject);
    procedure btnTugTecnicosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCheque: GUID_ID;
    procedure Inicializar;
  public
    property idCheque: GUID_ID read _idCheque write _idCheque;

    procedure EditarCheque;
  end; 

var
  frmChequeAE: TfrmChequeAE;

implementation
{$R *.lfm}

uses
  frm_ediciontugs
 ,dmediciontugs
 ,frm_busquedapersonasempresas
 ;

{ TfrmChequeAE }


procedure TfrmChequeAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idCheque = GUIDNULO then
   DM_Cheques.Nuevo
  else
    EditarCheque;
end;

procedure TfrmChequeAE.btnTugTecnicosClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGBANCOS';
      titulo:= 'Bancos';
      AgregarCampo('Banco','Nombre del Banco');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbBancos, 'Banco', 'idBanco', DM_Cheques.qTugBancos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmChequeAE.FormCreate(Sender: TObject);
begin

end;

procedure TfrmChequeAE.btnTugTecnicos1Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGCHEQUESESTADOS';
      titulo:= 'Estados de los cheques';
      AgregarCampo('ChequeEstado','Estados disponibles');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbChequesEstados, 'ChequeEstado', 'idChequeEstado', DM_Cheques.qTugChequesEstados);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmChequeAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmChequeAE.btnAceptarClick(Sender: TObject);
begin
  DM_Cheques.AjustarRefCombos (DM_General.obtenerIDIntComboBox(cbBancos), DM_General.obtenerIDIntComboBox(cbChequesEstados));
  DM_Cheques.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmChequeAE.btnBuscarRecibidoDeClick(Sender: TObject);
var
  pantalla: TfrmBusquedaPersonasEmpresas;
begin
  pantalla:= TfrmBusquedaPersonasEmpresas.Create (self);
  try
    if pantalla.ShowModal = mrOK then
    begin
      DM_Cheques.CambiarRecibidoDe(pantalla.idPersonaEmpresa);
    end;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmChequeAE.btnBuscarEntregadoAClick(Sender: TObject);
var
  pantalla: TfrmBusquedaPersonasEmpresas;
begin
  pantalla:= TfrmBusquedaPersonasEmpresas.Create (self);
  try
    if pantalla.ShowModal = mrOK then
    begin
      DM_Cheques.CambiarEntregadoA(pantalla.idPersonaEmpresa);
    end;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmChequeAE.Inicializar;
begin
  DM_General.CargarComboBox(cbBancos,'Banco', 'idBanco', DM_Cheques.qTugBancos);
  DM_General.CargarComboBox(cbChequesEstados, 'ChequeEstado', 'idChequeEstado', DM_Cheques.qTugChequesEstados);
end;

procedure TfrmChequeAE.EditarCheque;
begin
  DM_Cheques.LevantarCheque (_idCheque);
  cbBancos.ItemIndex:= DM_General.obtenerIdxCombo(cbBancos, DM_Cheques.tbCheques.FieldByName('refBanco').asInteger);
  cbChequesEstados.ItemIndex:= DM_General.obtenerIdxCombo(cbChequesEstados, DM_Cheques.tbCheques.FieldByName('refEstado').asInteger);
end;

end.

