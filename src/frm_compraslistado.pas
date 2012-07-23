unit frm_compraslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DBGrids
  ,dmcompras, dmgeneral;

type

  { TfrmComprasListado }

  TfrmComprasListado = class(TForm)
    btnAceptar: TBitBtn;
    btnNuevaCompra: TBitBtn;
    btnModificarCompra: TBitBtn;
    btnEliminarCompra: TBitBtn;
    btnBuscar: TBitBtn;
    cbCriterio: TComboBox;
    ds_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edDato: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgPagadas: TRadioGroup;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnEliminarCompraClick(Sender: TObject);
    procedure btnModificarCompraClick(Sender: TObject);
    procedure btnNuevaCompraClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edDatoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _buscandoProveedor: GUID_ID;

    procedure CargarCriteriosBusqueda;
    function getCompraSeleccionada: GUID_ID;
    procedure Inicializar;

    procedure PantallaCompras (refCompra: GUID_ID);
  public
    property CompraSeleccionada: GUID_ID read getCompraSeleccionada;
    procedure Buscar;
    Function BuscarProveedorImpago (refProveedor: GUID_ID): boolean;

  end; 

var
  frmComprasListado: TfrmComprasListado;

implementation
{$R *.lfm}
uses
  frm_comprasae
  ,dmproveedores
  ;

{ TfrmComprasListado }

procedure TfrmComprasListado.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmComprasListado.btnBuscarClick(Sender: TObject);
begin
  Buscar
end;

procedure TfrmComprasListado.btnEliminarCompraClick(Sender: TObject);
begin
  if (MessageDlg ('CONFIRMACION', '¿Elimino la compra seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Compras.EliminarCompra (DM_Compras.idCompraListado);
    Buscar;
  end;
end;

procedure TfrmComprasListado.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmComprasListado.edDatoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
     Buscar;
end;

procedure TfrmComprasListado.FormCreate(Sender: TObject);
begin
   _buscandoProveedor:= GUIDNULO;
end;

procedure TfrmComprasListado.CargarCriteriosBusqueda;
const
  MAX_FILAS = 5;
  aCriterioDeBusqueda: array [1..MAX_FILAS,1..2] of string =
    (('Compras por Proveedor','qBusComprasProv')
    ,('Compras por Comprobante','qBusComprasComprob')
    ,('Compras con Fecha igual a','qBusComprasFechaIgual')
    ,('Compras con Fecha menor a','qBusComprasFechaMenor')
    ,('Compras con Fecha mayor a','qBusComprasFechaMayor')
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

function TfrmComprasListado.getCompraSeleccionada: GUID_ID;
begin
  Result:= DM_Compras.idCompraListado;
end;

procedure TfrmComprasListado.Inicializar;
begin
  CargarCriteriosBusqueda;
  edDato.Clear;
  edDato.SetFocus;
  if _buscandoProveedor <> GUIDNULO then
  begin
    edDato.Text:= DM_Proveedores.ProveedorNombre(_buscandoProveedor);
    cbCriterio.ItemIndex:= 0;
    rgPagadas.ItemIndex:= COMPRAS_IMPAGAS;
  end;
  Buscar;
end;

procedure TfrmComprasListado.Buscar;
begin
  DM_Compras.Buscar ( TRIM(edDato.Text)
                     ,String(cbCriterio.Items.Objects[cbCriterio.ItemIndex])
                     ,rgPagadas.ItemIndex
                    );
end;

function TfrmComprasListado.BuscarProveedorImpago(refProveedor: GUID_ID
  ): boolean;
begin
  DM_Compras.Buscar ( refProveedor
                     ,'qComprasIDProveedor'
                     , COMPRAS_IMPAGAS
                    );
  _buscandoProveedor:= refProveedor;
  Result:= ds_Resultados.DataSet.RecordCount > 0;
end;

(*******************************************************************************
***  ABM COMPRAS
*******************************************************************************)

procedure TfrmComprasListado.PantallaCompras(refCompra: GUID_ID);
var
  pant: TfrmComprasAE;
begin
  pant:= TfrmComprasAE.Create(self);
  pant.idCompra:= refCompra;
  try
    if pant.ShowModal = mrOK then
    begin
      Buscar;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmComprasListado.btnNuevaCompraClick(Sender: TObject);
begin
  PantallaCompras(GUIDNULO);
end;

procedure TfrmComprasListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmComprasListado.btnModificarCompraClick(Sender: TObject);
begin
  PantallaCompras(DM_Compras.idCompraListado);
end;

end.

