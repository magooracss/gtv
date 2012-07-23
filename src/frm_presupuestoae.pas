unit frm_presupuestoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons, DbCtrls, dbdateedit
  ,dmgeneral
  ;

type

  { TfrmPresupuestoAE }

  TfrmPresupuestoAE = class(TForm)
    btnClientePotencial: TBitBtn;
    btnAgregarCuota: TBitBtn;
    btnEditarCuota: TBitBtn;
    btnEliminarCuota: TBitBtn;
    btnCargaMasiva: TBitBtn;
    btnBuscarCliente: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    btnGrabarySalir: TBitBtn;
    cbEstadoTipo: TComboBox;
    DBEdit3: TDBEdit;
    DS_Cuotas: TDatasource;
    DS_Presupuesto: TDatasource;
    DBCheckBox1: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton13: TSpeedButton;
    StaticText1: TStaticText;
    txMontoTotal: TStaticText;
    procedure btnClientePotencialClick(Sender: TObject);
    procedure btnEditarCuotaClick(Sender: TObject);
    procedure btnAgregarCuotaClick(Sender: TObject);
    procedure btnCargaMasivaClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnEliminarCuotaClick(Sender: TObject);
    procedure btnGrabarySalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idPresupuesto: GUID_ID;
    procedure Inicializar;
    procedure AcomodarCuotas;
    procedure NombreCliente (refCliente: GUID_ID);
  public
    property idPresupuesto: GUID_ID read _idPresupuesto write _idPresupuesto;
    property idCliente: GUID_ID read _idCliente write _idCliente;
  end;

var
  frmPresupuestoAE: TfrmPresupuestoAE;

implementation
{$R *.lfm}
uses
   dmpresupuestos
   ,frm_ediciontugs
   ,dmediciontugs
   ,frm_busquedaclientes
   ,dmclientes
   ,frm_altamasivacuotas
   ,frm_cuotaae
   ,frm_clientespotencialeslistado
   ,dmclientespotenciales
   ;

{ TfrmPresupuestoAE }

procedure TfrmPresupuestoAE.SpeedButton13Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPRESUPUESTOSESTADOS';
      titulo:= 'Tipos estados de un presupuesto';
      AgregarCampo('Estado','Estado');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbEstadoTipo, 'Estado', 'idPresupuestoEstado',DM_Presupuestos.qtugPresupuestosEstados);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmPresupuestoAE.FormShow(Sender: TObject);
begin
 // if _idPresupuesto <>  GUIDNULO then
  begin
    cbEstadoTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbEstadoTipo, DM_Presupuestos.tbPresupuestos.FieldByName ('refEstado').asInteger);
    _idCliente:= DM_Presupuestos.tbPresupuestos.FieldByName('refCliente').asString;
    NombreCliente (_idCliente);
    AcomodarCuotas;
  end;
end;

procedure TfrmPresupuestoAE.btnBuscarClienteClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      _idCliente:= pantBusqueda.idCliente;
      edCliente.Text:= TRIM(DM_Clientes.ClienteNombre(pantBusqueda.idCliente));
    end;
  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmPresupuestoAE.btnEliminarCuotaClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Elimino la cuota seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Presupuestos.EliminarCuota;
    DM_Presupuestos.RenumerarCuotas;
    AcomodarCuotas;
  end;
end;

procedure TfrmPresupuestoAE.btnGrabarySalirClick(Sender: TObject);
begin
  DM_Presupuestos.ActualizarValores (_idCliente
                                    , 0
                                    ,DM_General.obtenerIDIntComboBox(cbEstadoTipo)
                                    );
  DM_Presupuestos.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmPresupuestoAE.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmPresupuestoAE.btnCargaMasivaClick(Sender: TObject);
var
  pant: TfrmAltaMasivaCuotas;
begin
  pant:= TfrmAltaMasivaCuotas.Create(self);
  try
     if pant.ShowModal = mrOK then
       AcomodarCuotas;
  finally
    pant.Free;
  end;
end;

procedure TfrmPresupuestoAE.btnAgregarCuotaClick(Sender: TObject);
var
  pant: TfrmCuotaAE;
begin
  pant:= TfrmCuotaAE.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Presupuestos.AltaCuota( 0
                                ,pant.idTipo
                                ,pant.Vencimiento
                                ,pant.Monto
                                ,pant.idEstado
                                ,pant.FechaPago);
      DM_Presupuestos.RenumerarCuotas;
      AcomodarCuotas;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPresupuestoAE.btnEditarCuotaClick(Sender: TObject);
var
  pant: TfrmCuotaAE;
begin
  pant:= TfrmCuotaAE.Create (self);
  try
     with DS_Cuotas.DataSet do
     begin
       pant.idTipo:= FieldByName('refTipo').asInteger;
       pant.Vencimiento:= FieldByName('fVencimiento').AsDateTime;
       pant.Monto:= FieldByName('nMonto').AsFloat;
       pant.idEstado:= FieldByName('refEstado').asInteger;
       pant.FechaPago:= FieldByName('fPago').AsDateTime;
    end;
    if pant.ShowModal = mrOK then
    begin
      DM_Presupuestos.EditarCuota(pant.idTipo
                                ,pant.Vencimiento
                                ,pant.Monto
                                ,pant.idEstado
                                ,pant.FechaPago);

      DM_Presupuestos.RenumerarCuotas;
      AcomodarCuotas;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPresupuestoAE.btnClientePotencialClick(Sender: TObject);
var
  pantalla: TfrmClientesPotencialesListado;
begin
  pantalla:= TfrmClientesPotencialesListado.Create (self);
  try
    if ((pantalla.ShowModal = mrOK) and (pantalla.idCliente <> GUIDNULO)) then
    begin
      _idCliente:= pantalla.idCliente;
      NombreCliente (pantalla.idCliente);
    end;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmPresupuestoAE.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPresupuestoAE.Inicializar;
begin
  edCliente.Clear;
  DM_General.CargarComboBox(cbEstadoTipo,'Estado','idPresupuestoEstado', DM_Presupuestos.qtugPresupuestosEstados);
  _idPresupuesto:= GUIDNULO;
  _idCliente:= GUIDNULO;
end;

procedure TfrmPresupuestoAE.AcomodarCuotas;
begin
  DM_Presupuestos.OrdenarCuotas;
  txMontoTotal.Caption:= 'Monto Total: ' + FormatFloat('$ ##########00.00', DM_Presupuestos.MontoTotal);
end;

procedure TfrmPresupuestoAE.NombreCliente(refCliente: GUID_ID);
begin
  edCliente.Text:= TRIM(DM_Clientes.ClienteNombre(refCliente));
  if TRIM (edCliente.Text) = EmptyStr then
    edCliente.Text:= TRIM(DM_ClientesPotenciales.ClienteNombre(refCliente));
end;

end.

