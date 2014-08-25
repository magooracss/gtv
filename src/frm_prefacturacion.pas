unit frm_prefacturacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons, DbCtrls
  ,dmgeneral;

type

  { TfrmPrefacturacion }

  TfrmPrefacturacion = class(TForm)
    BitBtn1: TBitBtn;
    btnSalir: TBitBtn;
    btnFiltrar: TBitBtn;
    btnBuscar: TBitBtn;
    ckTodosLosClientes: TCheckBox;
    DBMemo1: TDBMemo;
    ds_Grilla: TDatasource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    rgTipoDocumento: TRadioGroup;
    rgFiltroEstados: TRadioGroup;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ckTodosLosClientesChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    _idCliente: GUID_ID;
    procedure Inicializar;
  public
    procedure Buscar;
  end;

var
  frmPrefacturacion: TfrmPrefacturacion;

implementation
{$R *.lfm}
uses
  dmprefacturacion
  ,frm_busquedaclientes
  ,frm_prefacturacionae
  , dmfacturas
  ;

{ TfrmPrefacturacion }

procedure TfrmPrefacturacion.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPrefacturacion.Label1Click(Sender: TObject);
begin

end;

procedure TfrmPrefacturacion.btnBuscarClick(Sender: TObject);
var
  pant: TfrmBuscarCliente;
begin
  pant := TfrmBuscarCliente.Create(self);
  try
    if (pant.ShowModal = mrOK) then
    begin
      _idCliente:= pant.idCliente;
      edCliente.Text:= pant.NombreCliente;
      ckTodosLosClientes.Checked:= false;
    end
    else
     ckTodosLosClientes.Checked:= true;
  finally
     pant.Free;
  end;
end;

procedure TfrmPrefacturacion.BitBtn1Click(Sender: TObject);
begin
  DM_Facturas.levantarDocumentosSinPrefacturar;
end;

procedure TfrmPrefacturacion.btnFiltrarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmPrefacturacion.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPrefacturacion.ckTodosLosClientesChange(Sender: TObject);
begin
  if ckTodosLosClientes.Checked then
  begin
    _idCliente:= GUIDNULO;
    edCliente.Clear;
  end;
end;

procedure TfrmPrefacturacion.DBGrid1DblClick(Sender: TObject);
var
  pant: TfrmPrefacturacionAE;
begin
  pant:= TfrmPrefacturacionAE.Create(self);
  try
    pant.ShowModal;
  finally
     pant.Free;
  end;
  DM_Prefacturacion.Grabar;
  Buscar;
end;

procedure TfrmPrefacturacion.Inicializar;
begin
  _idCliente:= GUIDNULO;
  DM_Prefacturacion.levantarDocumentosSinPrefacturar;
  DM_Prefacturacion.Grabar;
  DM_Prefacturacion.LevantarPrefacturacion(TD_LIBRE, EP_PARAFACTURAR, GUIDNULO);
end;

procedure TfrmPrefacturacion.Buscar;
begin
  DM_Facturas.LevantarDocumentos(rgTipoDocumento.ItemIndex, rgFiltroEstados.ItemIndex -1, _idCliente);
end;

end.

