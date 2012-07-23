unit frm_cajalistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, EditBtn, StdCtrls, Buttons
  ,dmgeneral, dmcaja
  ;

type

  { TfrmCajaListado }

  TfrmCajaListado = class(TForm)
    btnFiltrar: TBitBtn;
    btnAgregarConcepto: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnSalir: TBitBtn;
    DS_Caja: TDatasource;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    DBGrid1: TDBGrid;
    edSaldoTotal: TStaticText;
    edSaldoDia: TStaticText;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    edSaldoInicial: TStaticText;
    rgEmpresa: TRadioGroup;
    rgConceptos: TRadioGroup;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAgregarConceptoClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgEmpresaClick(Sender: TObject);
  private
    procedure Inicializar;
    procedure CargarTotales;
    procedure LevantarConceptos;
    function ObtenerIdCliente: GUID_ID;
    function ObtenerIdProveedor: GUID_ID;
    function ObtenerIdConcepto: integer;
  public
    { public declarations }
  end; 

var
  frmCajaListado: TfrmCajaListado;

implementation
{$R *.lfm}
uses
    frm_cajaconceptoae
   ,frm_busquedaclientes
   ,dmclientes
   ,frm_proveedoreslistado
   ,dmproveedores
   ,frm_tugconceptoslistado
  ;


{ TfrmCajaListado }

procedure TfrmCajaListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCajaListado.btnAgregarConceptoClick(Sender: TObject);
var
  pant: TfrmCajaConceptoAE;
begin
  pant:= TfrmCajaConceptoAE.Create(self);
  try
    DM_CAJA.insertarConceptoCaja;
    if pant.ShowModal = mrOK then
    begin
      DM_CAJA.LevantarCaja(edFechaIni.Date, edFechaFin.Date);
      CargarTotales;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmCajaListado.btnFiltrarClick(Sender: TObject);
begin
  LevantarConceptos;
end;

procedure TfrmCajaListado.BitBtn2Click(Sender: TObject);
var
  pant: TfrmCajaConceptoAE;
begin
  pant:= TfrmCajaConceptoAE.Create(self);
  try
    DM_CAJA.ModificarConceptoCaja;
    if pant.ShowModal = mrOK then
    begin
      DM_CAJA.LevantarCaja(edFechaIni.Date, edFechaFin.Date);
      CargarTotales;
    end;

   finally
      pant.Free;
   end;
end;

procedure TfrmCajaListado.BitBtn3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el concepto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_CAJA.eliminarConcepto;
    DM_CAJA.LevantarCaja(edFechaIni.Date, edFechaFin.Date);
    CargarTotales;
  end;
end;

procedure TfrmCajaListado.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmCajaListado.rgEmpresaClick(Sender: TObject);
begin

end;


procedure TfrmCajaListado.Inicializar;
begin
  edFechaIni.Date:= Now;
  edFechaFin.Date:= Now;
  DM_CAJA.LevantarCaja(Now, Now);
  CargarTotales;
end;

procedure TfrmCajaListado.CargarTotales;
var
  sInicial, sPeriodo: double;
begin
  sInicial:= DM_Caja.SaldoInicial (edFechaIni.Date);
  sPeriodo:= DM_Caja.SaldoPeriodo;
  edSaldoInicial.Caption:= 'Saldo al '+ FormatDateTime('dd/mm/yyyy', edFechaIni.Date)  + ': ' + FormatFloat ('$ ##########0.00', sInicial);
  edSaldoDia.Caption:= 'Saldo grilla: ' + FormatFloat ('$ ##########0.00', sPeriodo);
  edSaldoTotal.Caption:= 'Saldo Total: ' + FormatFloat ('$ ##########0.00', sInicial + sPeriodo);
end;

procedure TfrmCajaListado.LevantarConceptos;
var
  refEmpresa: GUID_ID;
  refConcepto: Integer;
begin
  case rgEmpresa.ItemIndex of
   0: refEmpresa:= GUIDNULO;
   1: refEmpresa:= ObtenerIdCliente;
   2: refEmpresa:= ObtenerIdProveedor;
  end;

  case rgConceptos.ItemIndex of
   0: refConcepto:= -1;
   1: refConcepto:= ObtenerIdConcepto;
   2: refConcepto:= -1;
   3: refConcepto:= -1;
  end;

  DM_CAJA.LevantarCajaFiltrada ( edFechaIni.Date
                               , edFechaFin.Date
                               , rgEmpresa.ItemIndex
                               , refEmpresa
                               , rgConceptos.ItemIndex
                               , refConcepto
                               );
  CargarTotales;
end;

function TfrmCajaListado.ObtenerIdCliente: GUID_ID;
var
  pantBusqueda: TfrmBuscarCliente;
begin
  Result:= GUIDNULO;
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      Result:= pantBusqueda.NombreCliente;
    end;
  finally
    pantBusqueda.Free;
  end;
end;

function TfrmCajaListado.ObtenerIdProveedor: GUID_ID;
var
  pant: TfrmProveedoresListado;
begin
  Result:= GUIDNULO;
  pant:= TfrmProveedoresListado.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      Result:= pant.idProveedor;
    end;
  finally
    pant.Free;
  end;
end;

function TfrmCajaListado.ObtenerIdConcepto: integer;
var
  pant: TfrmTugConceptosListado;
begin
  Result:= -1;
  pant:= TfrmTugConceptosListado.Create (self);
  try
    if pant.ShowModal = mrOK then
      Result:= pant.idConcepto;
  finally
    pant.Free;
  end;
end;

end.

