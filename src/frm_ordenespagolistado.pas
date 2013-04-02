unit frm_ordenespagolistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids
  ,dmgeneral;

type

  { TfrmOrdenesPagoListado }

  TfrmOrdenesPagoListado = class(TForm)
    btnAceptar: TBitBtn;
    btnBuscar: TBitBtn;
    btnEliminarOP: TBitBtn;
    btnModificarOP: TBitBtn;
    btnNuevaOP: TBitBtn;
    cbCriterio: TComboBox;
    ds_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edDato: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnEliminarOPClick(Sender: TObject);
    procedure btnModificarOPClick(Sender: TObject);
    procedure btnNuevaOPClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edDatoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    function getidOPBusqueda: GUID_ID;
    procedure Inicializar;
    procedure CargarCriteriosBusqueda;
    procedure Buscar;

    procedure pantallaOP (refOrdenPago: GUID_ID);
  public
    property idOPBusqueda: GUID_ID read getidOPBusqueda;
  end; 

var
  frmOrdenesPagoListado: TfrmOrdenesPagoListado;

implementation
{$R *.lfm}
uses
  dmordenesdepago
  ,frm_ordenpagoae
  ;

{ TfrmOrdenesPagoListado }

procedure TfrmOrdenesPagoListado.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmOrdenesPagoListado.btnEliminarOPClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino la orden seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_OrdenesDePago.EliminarOrdenPago (DM_OrdenesDePago.idOPBusqueda);
    Buscar;
  end;
end;

procedure TfrmOrdenesPagoListado.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;


procedure TfrmOrdenesPagoListado.edDatoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
    Buscar;
end;

procedure TfrmOrdenesPagoListado.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmOrdenesPagoListado.getidOPBusqueda: GUID_ID;
begin
  Result:= DM_OrdenesDePago.idOPBusqueda;
end;

procedure TfrmOrdenesPagoListado.Inicializar;
begin
  CargarCriteriosBusqueda;
  edDato.Clear;
  //Buscar;
  DM_OrdenesDePago.ReactivarComprasOPBorradas;
end;

procedure TfrmOrdenesPagoListado.CargarCriteriosBusqueda;
const
  MAX_FILAS = 5;
  aCriterioDeBusqueda: array [1..MAX_FILAS,1..2] of string =
    (('Ordenes de Pago por Proveedor','qBusOPProv')
    ,('Ordenes de Pago por Número','qBusOPNumero')
    ,('Ordenes de Pago con Fecha igual a','qBusOPFechaIgual')
    ,('Ordenes de Pago con Fecha menor a','qBusOPFechaMenor')
    ,('Ordenes de Pago con Fecha mayor a','qBusOPFechaMayor')
   );
var
  indice: integer;
begin
  { Preparo los items del combo }
  with cbCriterio do
  begin
    Items.Clear;
    for indice := 1 to Length (aCriterioDeBusqueda) do
    begin
       Items.AddObject (aCriterioDeBusqueda[Indice,1],TObject(aCriterioDeBusqueda[Indice,2]));
     end;
    DropDownCount := Length (aCriterioDeBusqueda);
    ItemIndex := 0;
  end;
end;

procedure TfrmOrdenesPagoListado.Buscar;
begin
  DM_OrdenesDePago.Buscar(TRIM(edDato.Text)
                         ,String(cbCriterio.Items.Objects[cbCriterio.ItemIndex])
                         );
end;

procedure TfrmOrdenesPagoListado.pantallaOP(refOrdenPago: GUID_ID);
var
  pant: TfrmOrdenDePagoAE;
begin
  pant:= TfrmOrdenDePagoAE.Create (self);
  try
    pant.idOrdenPago := refOrdenPago;
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmOrdenesPagoListado.btnNuevaOPClick(Sender: TObject);
begin
  pantallaOP(GUIDNULO);
end;

procedure TfrmOrdenesPagoListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmOrdenesPagoListado.btnModificarOPClick(Sender: TObject);
begin
  pantallaOP(DM_OrdenesDePago.idOPBusqueda);
end;


end.

