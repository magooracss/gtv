unit frm_asignarpagofactura;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons
  , dmgeneral;

type

  { TfrmAsignarPagoFacturas }

  TfrmAsignarPagoFacturas = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnCancelar: TBitBtn;
    DBGrid1: TDBGrid;
    ds_Facturas: TDatasource;
    edMontoCubierto: TEdit;
    edMontoRestante: TEdit;
    edMontoACubrir: TEdit;
    Label2:  TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1:  TPanel;
    Panel2:  TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ds_FacturasDataChange(Sender: TObject; Field: TField);
    procedure ds_FacturasUpdateData(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idOP: GUID_ID;
    _montoACubrir
    ,_montoCubierto: double;

    procedure Inicializar;
    procedure Totales;

    function ValidarTotales: boolean;

  public
    property MontoACubrir: double Read _montoACubrir Write _montoACubrir;
    property idOP: GUID_ID Read _idOP Write _idOP;

  end;

var
  frmAsignarPagoFacturas: TfrmAsignarPagoFacturas;

implementation
{$R *.lfm}
uses
  dmcompras
  ;

{ TfrmAsignarPagoFacturas }

procedure TfrmAsignarPagoFacturas.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmAsignarPagoFacturas.FormCreate(Sender: TObject);
begin
  _idOP:= GUIDNULO;
  _montoACubrir:= 0;
  _montoCubierto:= 0;
  DM_Compras.tbComprasPorOP.Edit;
end;

procedure TfrmAsignarPagoFacturas.ds_FacturasDataChange(Sender: TObject;
  Field: TField);
begin
end;

procedure TfrmAsignarPagoFacturas.ds_FacturasUpdateData(Sender: TObject);
begin
end;

procedure TfrmAsignarPagoFacturas.BitBtn1Click(Sender: TObject);
begin
  Totales;
end;

procedure TfrmAsignarPagoFacturas.BitBtn2Click(Sender: TObject);
begin
  Totales;
  if ValidarTotales then
  begin
    DM_Compras.GrabarPagosParciales (idOP);
    ModalResult:= mrOK;
  end
  else
   ShowMessage('Para grabar se tiene que distribuir todo el monto restante y ninguna factura puede pagarse en exceso');
end;

procedure TfrmAsignarPagoFacturas.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmAsignarPagoFacturas.Inicializar;
begin
  edMontoACubrir.Text := FormatFloat('$ ########0.00', _MontoACubrir);
end;

procedure TfrmAsignarPagoFacturas.Totales;
begin
  DM_Compras.LimpiarBlancos;
  _montoCubierto:= DM_Compras.MontoCubiertoFacturas;
  edMontoCubierto.Text := FormatFloat('$ ########0.00', _montoCubierto);
  edMontoRestante.Text:= FormatFloat('$ ########0.00', (_MontoACubrir - _montoCubierto));
end;

function TfrmAsignarPagoFacturas.ValidarTotales: boolean;
begin
   Result:= ( DM_General.CmpIgualdadFloat ((_montoACubrir-_montoCubierto), 0)
              and (DM_Compras.ComprasPorOPMontosOK));

end;


end.

