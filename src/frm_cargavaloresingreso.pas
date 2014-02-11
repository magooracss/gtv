unit frm_cargavaloresIngreso;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ComCtrls, curredit;

type

  { TfrmCargaValoresIngreso }

  TfrmCargaValoresIngreso = class(TForm)
    btnAceptar: TBitBtn;
    btnBuscarCheque: TBitBtn;
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
    edMontoChequeP: TCurrencyEdit;
    edMontoChequeP1: TCurrencyEdit;
    edNumeroChequeP: TEdit;
    edNumeroChequeP1: TEdit;
    edTransferenciaMonto: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    PCFormasPago: TPageControl;
    tabCheque: TTabSheet;
    tabChequePropio: TTabSheet;
    tabChequePropio1: TTabSheet;
    tabEfectivo: TTabSheet;
    tabTransferencia: TTabSheet;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCargaValoresIngreso: TfrmCargaValoresIngreso;

implementation

{$R *.lfm}

end.

