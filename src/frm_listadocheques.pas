unit frm_listadocheques;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, Menus, ActnList, DBGrids
  ,dmgeneral
  ;



type

  { TfrmListadoCheques }

  TfrmListadoCheques = class(TForm)
    btnChequeNuevo: TBitBtn;
    btnModificarCheque: TBitBtn;
    btnBorrarCheque: TBitBtn;
    DS_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    panSalir: TAction;
    panBuscar: TAction;
    ActionList1: TActionList;
    btnSalir: TBitBtn;
    btnBuscar: TBitBtn;
    cbCriterioBusqueda: TComboBox;
    cbCriterioOrden: TComboBox;
    edBuscar: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    rgCriterio: TRadioGroup;
    procedure btnBorrarChequeClick(Sender: TObject);
    procedure btnModificarChequeClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnChequeNuevoClick(Sender: TObject);
    procedure cbCriterioOrdenChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure panBuscarExecute(Sender: TObject);
    procedure panSalirExecute(Sender: TObject);
  private
    procedure CargarCriteriosBusqueda;
    procedure CargarCriteriosOrden;
    function getidCheque: GUID_ID;
    procedure Inicializar;

    procedure Buscar;
    procedure pantallaCheque (idCheque: GUID_ID);
  public
    property idCheque: GUID_ID read getidCheque;

  end; 

var
  frmListadoCheques: TfrmListadoCheques;

implementation
{$R *.lfm}
uses
  dmcheques
  ,frm_chequesae
  ;


{ TfrmListadoCheques }

procedure TfrmListadoCheques.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmListadoCheques.panBuscarExecute(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmListadoCheques.panSalirExecute(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoCheques.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;


procedure TfrmListadoCheques.cbCriterioOrdenChange(Sender: TObject);
begin
  DM_Cheques.OrdenarListado(String(cbCriterioBusqueda.Items.Objects[cbCriterioBusqueda.ItemIndex]));
end;

procedure TfrmListadoCheques.CargarCriteriosBusqueda;
const
  MAX_FILAS = 10;
  aCriterioDeBusqueda: array [1..MAX_FILAS,1..2] of string =
    (('Cheque por Número','qBusChequeNumero')
    ,('Cheque por Banco','qBusChequeBanco')
    ,('Cheques recibidos de','qBusChequeRecibidoDe')
    ,('Cheques entregados a','qBusChequeEntregadoA')
    ,('Cheque por fecha cobro igual','qBusChequefCobro')
    ,('Cheque por fecha recepción igual','qBusChequefRecibido')
    ,('Cheque por fecha entrega igual','qBusChequefEntrega')
    ,('Cheque por monto igual','qBusChequeMontoIgual')
    ,('Cheque por monto menor','qBusChequeMontoMenor')
    ,('Cheque por monto mayor','qBusChequeMontoMayor')
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
    ItemIndex := 0;
  end;
end;

procedure TfrmListadoCheques.CargarCriteriosOrden;
const
  MAX_FILAS = 8;
  aCriterioDeOrden: array [1..MAX_FILAS,1..2] of string =
    (('Ordenar por Número', ORDEN_NUMERO)
    ,('Ordenar por Banco', ORDEN_BANCO)
    ,('Ordenar por recibidos de', ORDEN_RECIBIDOS_DE)
    ,('Ordenar por entregados a', ORDEN_ENTREGADOS_A)
    ,('Ordenar por fecha cobro', ORDEN_FECHA_COBRO)
    ,('Ordenar por fecha recepción', ORDEN_FECHA_RECEPCION)
    ,('Ordenar por fecha entrega', ORDEN_FECHA_ENTREGA)
    ,('Ordenar por monto', ORDEN_MONTO)
   );
var
  indice: integer;
begin
  { Preparo los items del combo }
  with cbCriterioOrden do
  begin
    Items.Clear;
    for indice := 1 to Length (aCriterioDeOrden) do
    begin
       Items.AddObject (aCriterioDeOrden[Indice,1],TObject(aCriterioDeOrden[Indice,2]));
     end;
    DropDownCount := Length (aCriterioDeOrden);
    ItemIndex := 0;
  end;
end;

function TfrmListadoCheques.getidCheque: GUID_ID;
begin
  Result:= DM_Cheques.idChequeSeleccionado;
end;

procedure TfrmListadoCheques.Inicializar;
begin
  edBuscar.clear;
  CargarCriteriosBusqueda;
  CargarCriteriosOrden;
  DM_Cheques.BuscarCheque ('0','qBusChequeMontoMayor', EST_CARTERA );
end;

procedure TfrmListadoCheques.Buscar;
begin
  DM_Cheques.BuscarCheque (TRIM(edBuscar.Text), String(cbCriterioBusqueda.Items.Objects[cbCriterioBusqueda.ItemIndex]), rgCriterio.itemIndex);
  DM_Cheques.OrdenarListado(String(cbCriterioBusqueda.Items.Objects[cbCriterioBusqueda.ItemIndex]));
end;

procedure TfrmListadoCheques.pantallaCheque(idCheque: GUID_ID);
var
  pantalla: TfrmChequeAE;
begin
  pantalla:= TfrmChequeAE.Create(self);
  try
    pantalla.idCheque:= idCheque;
    if pantalla.ShowModal = mrOK then
    begin
      if (TRIM(edBuscar.Text) = EmptyStr) then
        DM_Cheques.BuscarCheque ('0','qBusChequeMontoMayor', EST_CARTERA )
      else
        Buscar;
    end;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmListadoCheques.btnChequeNuevoClick(Sender: TObject);
begin
   pantallaCheque(GUIDNULO);
end;

procedure TfrmListadoCheques.btnModificarChequeClick(Sender: TObject);
begin
  pantallaCheque(DM_Cheques.idChequeSeleccionado);
end;

procedure TfrmListadoCheques.btnBorrarChequeClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Cheque seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Cheques.EliminarCheque(DM_Cheques.idChequeSeleccionado);
    if (TRIM(edBuscar.Text) = EmptyStr) then
      DM_Cheques.BuscarCheque ('0','qBusChequeMontoMayor', EST_CARTERA )
    else
      Buscar;
  end;
end;


end.

