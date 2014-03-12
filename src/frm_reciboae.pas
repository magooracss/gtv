unit frm_reciboae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, DbCtrls, StdCtrls, Buttons, PairSplitter, dbdateedit, db
  ,dmgeneral
  ;

type

  { TfrmRecibosAE }

  TfrmRecibosAE = class(TForm)
    btnAgregarCobro: TBitBtn;
    btnQuitarCobro: TBitBtn;
    btnClientesBuscar: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btnClientesAgregar: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    ds_recibos: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Splitter1: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure btnAgregarCobroClick(Sender: TObject);
    procedure btnClientesAgregarClick(Sender: TObject);
    procedure btnClientesBuscarClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    idRecibo: GUID_ID;
    { private declarations }
  public
    property recibo_id: GUID_ID read idRecibo write idRecibo;
  end;

var
  frmRecibosAE: TfrmRecibosAE;

implementation
{$R *.lfm}
uses
    dmrecibos
  , frm_busquedaclientes
  , frm_clienteam
  , dmclientes
  , frm_cargavaloresIngreso
  ;

{ TfrmRecibosAE }

procedure TfrmRecibosAE.BitBtn4Click(Sender: TObject);
begin
  DM_Recibos.Grabar;
  ModalResult:= mrOK;
end;


procedure TfrmRecibosAE.btnClientesAgregarClick(Sender: TObject);
var
  pant: Tfrm_ClientesAM;
begin
  pant:= Tfrm_ClientesAM.Create (self);
  try
    pant.operacion:= nuevo;
    if pant.ShowModal = mrOK then
    begin
      DM_Recibos.CargarCliente(pant.cliente);
      edCliente.Text:= TRIM(DM_Clientes.ClienteNombre(pant.cliente));
    end;
  finally
    pant.free;
  end;
end;

procedure TfrmRecibosAE.btnAgregarCobroClick(Sender: TObject);
var
  pant: TfrmCargaValoresIngreso;
begin
  pant:= TfrmCargaValoresIngreso.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmRecibosAE.btnClientesBuscarClick(Sender: TObject);
var
  pantBusqueda: TfrmBuscarCliente;
begin
  pantBusqueda:= TfrmBuscarCliente.Create(self);
  try
    if (pantBusqueda.ShowModal = mrOK) and (pantBusqueda.idCliente <> GUIDNULO) then
    begin
      DM_Recibos.CargarCliente(pantBusqueda.idCliente);
      edCliente.Text:= TRIM(pantBusqueda.NombreCliente);
    end;
  finally
    pantBusqueda.Free;
  end;
end;

procedure TfrmRecibosAE.FormShow(Sender: TObject);
begin
  if (idRecibo = GUIDNULO) then
    DM_Recibos.NuevoRecibo
  else
  begin
    DM_Recibos.LevantarReciboID (idRecibo);
  end;
end;

end.

