unit frm_cargavalores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Buttons, StdCtrls, curredit
  ,dmgeneral
  ;

type

  { TfrmCargaValores }

  TfrmCargaValores = class(TForm)
    btnBuscarCheque: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugBancos: TSpeedButton;
    btnTugTiposComprobantes: TSpeedButton;
    cbBanco: TComboBox;
    cbFormaPago: TComboBox;
    cbBancoChequeP: TComboBox;
    edEfectivo: TCurrencyEdit;
    edMontoChequeP: TCurrencyEdit;
    edNumeroChequeP: TEdit;
    edTransferenciaMonto: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    PCFormasPago: TPageControl;
    Panel1: TPanel;
    edChequeNumero: TStaticText;
    edChequeBanco: TStaticText;
    edChequeMonto: TStaticText;
    tabEfectivo: TTabSheet;
    tabCheque: TTabSheet;
    tabChequePropio: TTabSheet;
    tabTransferencia: TTabSheet;
    procedure btnBuscarChequeClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnTugBancosClick(Sender: TObject);
    procedure cbFormaPagoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _Agrupamiento: integer;
    _idBanco: integer;
    _idCheque: GUID_ID;
    _monto: double;
    _banco: string;
    _NroCheque: string;
    function getFormaPago: integer;
    procedure MostrarTab;
    procedure Inicializar;
    procedure CargarCombos;
  public
    property refAgrupamiento: integer read _Agrupamiento;
    property refFormaPago: integer read getFormaPago;
    property Monto: double read _monto;
    property refCheque: GUID_ID read _idCheque;
    property refBanco: integer read _idBanco;
    property Banco: string read _banco;
    property NroCheque: string read _NroCheque;
  end;

var
  frmCargaValores: TfrmCargaValores;

implementation
{$R *.lfm}
uses
   dmvalores
  ,frm_listadocheques
  ,frm_ediciontugs
  ,dmediciontugs
  ,dmcheques
  ;

{ TfrmCargaValores }

procedure TfrmCargaValores.cbFormaPagoChange(Sender: TObject);
begin
  _Agrupamiento:= DM_Valores.Agrupamiento(DM_General.obtenerIDIntComboBox(cbFormaPago));
  MostrarTab;
end;

procedure TfrmCargaValores.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCargaValores.btnTugBancosClick(Sender: TObject);
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
    DM_General.CargarComboBox(cbBancoChequeP, 'Banco', 'idBanco', DM_Cheques.qTugBancos);
    DM_General.CargarComboBox(cbBanco, 'Banco', 'idBanco', DM_Cheques.qTugBancos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmCargaValores.btnAceptarClick(Sender: TObject);
begin
  case _Agrupamiento of
    IDX_AGRUPAMIENTO_EFECTIVO:
      begin
        _monto:= edEfectivo.Value;
      end;
    IDX_AGRUPAMIENTO_TRASNFERENCIA:
      begin
        _idBanco:= DM_General.obtenerIDIntComboBox(cbBanco);
        _Banco:= cbBanco.Text;
        _monto:= edTransferenciaMonto.Value;
      end;
    IDX_AGRUPAMIENTO_CHEQUETERCEROS:
      begin
        DM_Valores.DatosCheque(_idCheque, _monto,_banco, _nroCheque, _idBanco);
      end;
    IDX_AGRUPAMIENTO_CHEQUEPROPIO:
      begin
        _idBanco:= DM_General.obtenerIDIntComboBox(cbBancoChequeP);
        _Banco:= cbBancoChequeP.Text;
        _NroCheque:= TRIM(edNumeroChequeP.Text);
        _monto:= edMontoChequeP.Value;
      end;
  end;
  ModalResult:= mrOK;
end;

procedure TfrmCargaValores.btnBuscarChequeClick(Sender: TObject);
var
  pant: TfrmListadoCheques;
  elMonto: double;
  elBanco, elNumero: string;
begin
  pant:= TfrmListadoCheques.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Valores.DatosCheque(pant.idCheque
                            ,elMonto
                            ,elBanco
                            ,elNumero
                            ,_idBanco
                            );
      _idCheque:= pant.idCheque;

      edChequeMonto.Caption:= 'Monto: ' + FormatFloat('$ ##########0.00', elMonto);
      edChequeBanco.Caption:= 'Banco: ' + elBanco;
      edChequeNumero.Caption:= 'Número: ' + elNumero;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmCargaValores.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmCargaValores.MostrarTab;
begin
  case _Agrupamiento of
    IDX_AGRUPAMIENTO_EFECTIVO:
        PCFormasPago.ActivePage:= tabEfectivo;
    IDX_AGRUPAMIENTO_TRASNFERENCIA:
      PCFormasPago.ActivePage:= tabTransferencia;
    IDX_AGRUPAMIENTO_CHEQUETERCEROS:
      PCFormasPago.ActivePage:= tabCheque;
    IDX_AGRUPAMIENTO_CHEQUEPROPIO:
      PCFormasPago.ActivePage:= tabChequePropio;
  end;
end;

function TfrmCargaValores.getFormaPago: integer;
begin
  Result:= DM_General.obtenerIDIntComboBox(cbFormaPago);
end;

procedure TfrmCargaValores.Inicializar;
begin
  _Agrupamiento:= 0;
  _idBanco:= 0;
  _idCheque:= GUIDNULO;
  _monto:= 0;
  CargarCombos;
  MostrarTab;
end;

procedure TfrmCargaValores.CargarCombos;
begin
  DM_General.CargarComboBox(cbFormaPago, 'FormaPago', 'idFormaPago', DM_Valores.tugFormasPago);
  cbFormaPago.ItemIndex:= IDX_AGRUPAMIENTO_EFECTIVO;
  _Agrupamiento:= DM_Valores.Agrupamiento(DM_General.obtenerIDIntComboBox(cbFormaPago));
  DM_General.CargarComboBox(cbBanco, 'Banco', 'idBanco', DM_Valores.tugBancos);
  DM_General.CargarComboBox(cbBancoChequeP, 'Banco', 'idBanco', DM_Valores.tugBancos);
end;

end.

