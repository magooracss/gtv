unit frm_cajaconceptoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, DbCtrls, dbdateedit
  ,dmgeneral;

type

  { TfrmCajaConceptoAE }

  TfrmCajaConceptoAE = class(TForm)
    btnBuscarEmpresa: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbConceptos: TComboBox;
    cbFormasPago: TComboBox;
    DS_CajaConcepto: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    edEmpresa: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    rbProveedor: TRadioButton;
    rbCliente: TRadioButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cbConceptosChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
  private
    _idEmpresa: GUID_ID;
    _tipoLista: string;
    procedure Inicializar;
    procedure AjustarMonto;
    procedure BuscarCliente;
    procedure BuscarProveedor;
  public
    { public declarations }
  end; 

var
  frmCajaConceptoAE: TfrmCajaConceptoAE;

implementation
{$R *.lfm}
uses
   dmcaja
   ,dmediciontugs
   ,frm_ediciontugs
   ,frm_tugconceptoslistado
   ,frm_busquedaclientes
   ,dmclientes
   ,frm_proveedoreslistado
   ,dmproveedores
   ;

{ TfrmCajaConceptoAE }

procedure TfrmCajaConceptoAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;


procedure TfrmCajaConceptoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCajaConceptoAE.btnAceptarClick(Sender: TObject);
begin
  if rbProveedor.Checked then
    _tipoLista:= _LISTA_PROVEEDORES
  else
    _tipoLista:= _LISTA_CLIENTES;

  DM_CAJA.AjustarDatosConcepto (DM_General.obtenerIDIntComboBox(cbConceptos)
                               ,DM_General.obtenerIDIntComboBox(cbFormasPago)
                               ,_tipoLista
                               ,_idEmpresa);
  DM_CAJA.grabarConcepto;
  ModalResult:= mrOK;
end;

procedure TfrmCajaConceptoAE.btnBuscarEmpresaClick(Sender: TObject);
begin
  if rbCliente.Checked then
    BuscarCliente;
  if rbProveedor.Checked then
    BuscarProveedor;
end;

procedure TfrmCajaConceptoAE.cbConceptosChange(Sender: TObject);
begin
  AjustarMonto;
end;

procedure TfrmCajaConceptoAE.SpeedButton14Click(Sender: TObject);
var
  pant: TfrmTugConceptosListado;
begin
  pant:= TfrmTugConceptosListado.Create (self);
  try
    if pant.ShowModal = mrOK then
      DM_General.CargarComboBox(cbConceptos, 'Concepto', 'idConcepto', DM_CAJA.qTugConceptos);;
  finally
    pant.Free;
  end;
end;

procedure TfrmCajaConceptoAE.SpeedButton15Click(Sender: TObject);
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create (self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmCajaConceptoAE.SpeedButton16Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGFORMASPAGO';
      titulo:= 'Formas de Pago';
      AgregarCampo('FormaPago','Medios de pago');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbFormasPago, 'FormaPago', 'idFormaPago', DM_CAJA.qTugformasPago);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmCajaConceptoAE.Inicializar;
begin
  _idEmpresa:= GUIDNULO;
  _tipoLista:= _LISTA_PROVEEDORES;
  DM_General.CargarComboBox(cbConceptos, 'Concepto', 'idConcepto', DM_CAJA.qTugConceptos);
  DM_General.CargarComboBox(cbFormasPago, 'FormaPago', 'idFormaPago', DM_CAJA.qTugformasPago);

  //Todo esto se carga cuando viene la modificación
  _idEmpresa:= DM_CAJA.tbCajaConceptos.FieldByName('refEmpresa').asString;
  _tipoLista:= DM_CAJA.tbCajaConceptos.FieldByName('refListaEmpresa').asString;;
  cbConceptos.ItemIndex:= DM_General.obtenerIdxCombo(cbConceptos, DM_CAJA.tbCajaConceptos.FieldByName('refConcepto').asInteger);
  cbFormasPago.ItemIndex:= DM_General.obtenerIdxCombo(cbFormasPago, DM_CAJA.tbCajaConceptos.FieldByName('refFormaPago').asInteger);

  if _tipoLista = _LISTA_PROVEEDORES then
  begin
    rbProveedor.Checked:= true;
    edEmpresa.Text:= DM_Proveedores.ProveedorNombre (_idEmpresa);
  end
  else
  begin
    edEmpresa.Text:= DM_Clientes.ClienteNombre(_idEmpresa);
    rbCliente.Checked:= true;
  end;
end;

procedure TfrmCajaConceptoAE.AjustarMonto;
begin
  DM_CAJA.CargarMontoConcepto (DM_General.obtenerIDIntComboBox(cbConceptos));
end;

procedure TfrmCajaConceptoAE.BuscarCliente;
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      edEmpresa.Text:= pantBusqueda.NombreCliente;
      _idEmpresa:= pantBusqueda.idCliente;
    end;
  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmCajaConceptoAE.BuscarProveedor;
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      _idEmpresa:= pant.idProveedor;
      edEmpresa.Text:= pant.RazonSocial;
    end;
  finally
    pant.Free;
  end;
end;

{ TfrmCajaConceptoAE }



end.

