unit frm_egresosvariosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DbCtrls, StdCtrls, DBGrids, dbdateedit
  ,dmgeneral;

type

  { TfrmEgresoVarioAE }

  TfrmEgresoVarioAE = class(TForm)
    btnAgregarItem: TBitBtn;
    btnEditarItem: TBitBtn;
    btnQuitarValor: TBitBtn;
    btnSalir: TBitBtn;
    btnGrabar: TBitBtn;
    BitBtn3: TBitBtn;
    btnValoresNuevo: TBitBtn;
    btQuitarItem: TBitBtn;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ds_egresosvarios: TDatasource;
    ds_egresosVariosItems: TDatasource;
    DS_FormaPago: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Splitter1: TSplitter;
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAgregarItemClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnQuitarValorClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnValoresNuevoClick(Sender: TObject);
    procedure btQuitarItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idEgresoVario: GUID_ID;
    procedure pantallaEgresos (refEgreso: GUID_ID);
  public
    property idEgresoVario: GUID_ID read _idEgresoVario write _idEgresoVario;
  end; 

var
  frmEgresoVarioAE: TfrmEgresoVarioAE;

implementation
{$R *.lfm}
uses
  dmegresosvarios
  ,frm_egresoae
  ,frm_cargavalores
  ,SD_Configuracion
  ,LR_Class
  ;

{ TfrmEgresoVarioAE }

procedure TfrmEgresoVarioAE.pantallaEgresos(refEgreso: GUID_ID);
var
  pant: TfrmEgresoAE;
begin
  pant:= TfrmEgresoAE.Create (Self);
  try
    pant.idEgreso:= refEgreso;
    if pant.ShowModal = mrOK then
    begin
      DM_EgresosVarios.RecalcularMontos;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmEgresoVarioAE.btnAgregarItemClick(Sender: TObject);
begin
  pantallaEgresos (GUIDNULO);
end;

procedure TfrmEgresoVarioAE.BitBtn3Click(Sender: TObject);
var
  ruta: string;
begin
  with DM_EgresosVarios, elReporte do
  begin
    ruta:= LeerDato (SECCION_APP ,RUTA_LISTADOS) ;
    LoadFromFile(ruta+ _PRN_EGRESOSVARIOS_);
    frVariables ['TotalItems']:= FormatFloat('$ ############0.00', DM_EgresosVarios.MontoItems);
    frVariables ['TotalPago']:= FormatFloat('$ ############0.00', DM_EgresosVarios.MontoPagos);
    ShowReport;
  end;
end;

procedure TfrmEgresoVarioAE.btnEditarItemClick(Sender: TObject);
begin
  pantallaEgresos (DM_EgresosVarios.idEgresoSeleccionado)
end;

procedure TfrmEgresoVarioAE.btnGrabarClick(Sender: TObject);
var
  idEV: GUID_ID;
begin
  idEV:= DM_EgresosVarios.idEgreso;
  DM_EgresosVarios.Grabar;
  DM_EgresosVarios.LevantarEgreso(idEV);
end;

procedure TfrmEgresoVarioAE.btnQuitarValorClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino el valor seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_EgresosVarios.EliminarFormaPago;
  end;
end;

procedure TfrmEgresoVarioAE.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmEgresoVarioAE.btnValoresNuevoClick(Sender: TObject);
var
  pant: TfrmCargaValores;
begin
  pant:= TfrmCargaValores.Create (Self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_EgresosVarios.CargarValor (pant.refFormaPago
                                   ,pant.refCheque
                                   ,pant.refBanco
                                   ,pant.Monto
                                   ,pant.Banco
                                   ,pant.NroCheque
                                   );

 //     edSumaValores.Text:= FormatFloat('$ ############0.00', DM_OrdenesDePago.CalcularValores);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmEgresoVarioAE.btQuitarItemClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Elimino el valor seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_EgresosVarios.eliminarItem;
  end;
end;

procedure TfrmEgresoVarioAE.FormShow(Sender: TObject);
begin
  if _idEgresoVario = GUIDNULO then
    DM_EgresosVarios.NuevoEgresoVario
  else
    begin
     DM_EgresosVarios.LevantarEgreso(_idEgresoVario);
    end;
end;


end.

