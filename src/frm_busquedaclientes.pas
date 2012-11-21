unit frm_busquedaclientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons
  ,dmgeneral;

type

  { TfrmBuscarCliente }

  TfrmBuscarCliente = class(TForm)
    BitBtn1: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbCriterioBusqueda: TComboBox;
    DS_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edDato: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edDatoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _NombreCliente: string;
    procedure Inicializar;
    procedure Buscar;
  public
    property idCliente: GUID_ID read _idCliente;
    property NombreCliente: string read _NombreCliente;
  end; 

var
  frmBuscarCliente: TfrmBuscarCliente;

implementation
{$R *.lfm}
uses
  dmbuscarcliente
  ;

{ TfrmBuscarCliente }

procedure TfrmBuscarCliente.btnAceptarClick(Sender: TObject);
begin
  _idCliente:= DM_BuscarCliente.DevolverIdCliente;
  _NombreCliente:= DM_BuscarCliente.DevolverNombreCliente;
  ModalResult:= mrOK;
end;

procedure TfrmBuscarCliente.BitBtn1Click(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBuscarCliente.btnCancelarClick(Sender: TObject);
begin
  _idCliente:= GUIDNULO;
  _NombreCliente:= EmptyStr;
  ModalResult:= mrCancel;
end;

procedure TfrmBuscarCliente.edDatoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   Buscar;
end;

procedure TfrmBuscarCliente.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmBuscarCliente.Inicializar;
const
  MAX_FILAS = 3;
  aCriterioDeBusqueda: array [1..MAX_FILAS,1..2] of string =
    (('Cliente por Nombre','qBusCliPorNombre')
    ,('Cliente por Código','qBusCliPorCodigo')
    ,('Cliente por Domicilio','qBusCliPorDomicilio')
   );
var
  indice: integer;
begin
  { Preparo los items del combo }
  with cbCriterioBusqueda do
  begin
    Items.Clear;
    for indice := 1 to Length (aCriterioDeBusqueda) do
    begin
       Items.AddObject (aCriterioDeBusqueda[Indice,1],TObject(aCriterioDeBusqueda[Indice,2]));
     end;
    DropDownCount := Length (aCriterioDeBusqueda);
    ItemIndex := 1;
  end;

  //Limpio las tablas de resultados
  DM_General.CambiarEstadoTablas(TDataModule(DM_BuscarCliente), false);
end;

procedure TfrmBuscarCliente.Buscar;
begin
  DM_BuscarCliente.Buscar(String(cbCriterioBusqueda.Items.Objects[cbCriterioBusqueda.ItemIndex]), TRIM (edDato.text));
end;


end.

