unit frm_cargavaloresIngreso;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ComCtrls, curredit, types
  , dmgeneral
  ;

type

  { TfrmCargaValoresIngreso }

  TfrmCargaValoresIngreso = class(TForm)
    btnAceptar: TBitBtn;
    btnBuscarCheque: TBitBtn;
    btnChequeNuevo: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugTiposComprobantes: TSpeedButton;
    cbBanco: TComboBox;
    cbBancoChequeP: TComboBox;
    cbBancoChequeP1: TComboBox;
    cbFormaCobro: TComboBox;
    edChequeBanco: TStaticText;
    edChequeMonto: TStaticText;
    edChequeNumero: TStaticText;
    edEfectivo: TCurrencyEdit;
    edTransferenciaMonto: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    PCFormasPago: TPageControl;
    tabCheque: TTabSheet;
    tabEfectivo: TTabSheet;
    tabTransferencia: TTabSheet;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarChequeClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnChequeNuevoClick(Sender: TObject);
    procedure btnTugTiposComprobantesClick(Sender: TObject);
    procedure cbFormaCobroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _Agrupamiento: integer;
    _banco: string;
    _idBanco: integer;
    _idCheque: GUID_ID;
    _monto: double;
    _NroCheque: string;
    function getFormaCobro: integer;
    procedure Initialize;

    procedure MostrarTab;
  public
    property refAgrupamiento: integer Read _Agrupamiento;
    property refFormaCobro: integer Read getFormaCobro;
    property Monto: double Read _monto;
    property refCheque: GUID_ID Read _idCheque;
    property refBanco: integer Read _idBanco;
    property Banco: string Read _banco;
    property NroCheque: string Read _NroCheque;
  end;

var
  frmCargaValoresIngreso: TfrmCargaValoresIngreso;

implementation
{$R *.lfm}
uses
  dmvalores
  , frm_listadocheques
  , frm_ediciontugs
  , dmediciontugs
  , dmcheques
  , frm_chequesae
  ;

{ TfrmCargaValoresIngreso }


procedure TfrmCargaValoresIngreso.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCargaValoresIngreso.btnChequeNuevoClick(Sender: TObject);
var
  pantalla: TfrmChequeAE;
  elMonto: double;
  elBanco, elNumero: string;
begin
  pantalla:= TfrmChequeAE.Create(self);
  try
    pantalla.idCheque:= GUIDNULO;
    if pantalla.ShowModal = mrOK then
    begin
       DM_Valores.DatosCheque(pantalla.idCheque
        , elMonto
        , elBanco
        , elNumero
        , _idBanco
        );
       _idCheque := pantalla.idCheque;

      edChequeMonto.Caption  := 'Monto: ' + FormatFloat('$ ##########0.00', elMonto);
      edChequeBanco.Caption  := 'Banco: ' + elBanco;
      edChequeNumero.Caption := 'Número: ' + elNumero;

    end;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmCargaValoresIngreso.btnTugTiposComprobantesClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos:    TTablaTUG;
begin
  pantalla := TfrmEdicionTugs.Create(self);
  datos    := TTablaTUG.Create;
  try
    with datos do
    begin
      nombre := 'TUGBANCOS';
      titulo := 'Bancos';
      AgregarCampo('Banco', 'Nombre del Banco');
    end;
    pantalla.laTUG := datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbBanco, 'Banco', 'idBanco', DM_Cheques.qTugBancos);
    DM_Cheques.qTugBancos.open;
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmCargaValoresIngreso.cbFormaCobroChange(Sender: TObject);
begin
  _Agrupamiento := DM_Valores.AgrupamientoCobro(DM_General.obtenerIDIntComboBox(cbFormaCobro));
  MostrarTab;
end;

procedure TfrmCargaValoresIngreso.btnAceptarClick(Sender: TObject);
begin
  case _Agrupamiento of
     IDX_AGRUPAMIENTO_EFECTIVO:
     begin
       _monto := edEfectivo.Value;
     end;
     IDX_AGRUPAMIENTO_TRASNFERENCIA:
     begin
       _idBanco := DM_General.obtenerIDIntComboBox(cbBanco);
       _Banco   := cbBanco.Text;
       _monto   := edTransferenciaMonto.Value;
     end;
     IDX_AGRUPAMIENTO_CHEQUETERCEROS:
     begin
       DM_Valores.DatosCheque(_idCheque, _monto, _banco, _nroCheque, _idBanco);
     end;
   end;
   ModalResult := mrOk;
end;

procedure TfrmCargaValoresIngreso.btnBuscarChequeClick(Sender: TObject);
var
  pant:    TfrmListadoCheques;
  elMonto: double;
  elBanco, elNumero: string;
begin
  pant := TfrmListadoCheques.Create(self);
  try
    if pant.ShowModal = mrOk then
    begin
      DM_Valores.DatosCheque(pant.idCheque
        , elMonto
        , elBanco
        , elNumero
        , _idBanco
        );
      _idCheque := pant.idCheque;

      edChequeMonto.Caption  := 'Monto: ' + FormatFloat('$ ##########0.00', elMonto);
      edChequeBanco.Caption  := 'Banco: ' + elBanco;
      edChequeNumero.Caption := 'Número: ' + elNumero;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmCargaValoresIngreso.FormShow(Sender: TObject);
begin
  Initialize;
end;

function TfrmCargaValoresIngreso.getFormaCobro: integer;
begin
  Result := DM_General.obtenerIDIntComboBox(cbFormaCobro);
end;

procedure TfrmCargaValoresIngreso.Initialize;
begin
   _Agrupamiento := 0;
  _idBanco := 0;
  _idCheque := GUIDNULO;
  _monto := 0;
  DM_General.CargarComboBox(cbFormaCobro, 'FormaCobro', 'idFormaCobro',
    DM_Valores.tugFormasCobro);
  cbFormaCobro.ItemIndex := IDX_AGRUPAMIENTO_COBRO_EFECTIVO - 1;
  _Agrupamiento := DM_Valores.AgrupamientoCobro(DM_General.obtenerIDIntComboBox(cbFormaCobro));
  DM_General.CargarComboBox(cbBanco, 'Banco', 'idBanco', DM_Valores.tugBancos);
  MostrarTab;
end;

procedure TfrmCargaValoresIngreso.MostrarTab;
begin
    case _Agrupamiento of
    IDX_AGRUPAMIENTO_COBRO_EFECTIVO:
      PCFormasPago.ActivePage := tabEfectivo;
    IDX_AGRUPAMIENTO_COBRO_TRASNFERENCIA:
      PCFormasPago.ActivePage := tabTransferencia;
    IDX_AGRUPAMIENTO_COBRO_CHEQUE:
      PCFormasPago.ActivePage := tabCheque;
  end;
end;

end.

