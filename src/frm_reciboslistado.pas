unit frm_reciboslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids
  ,dmgeneral, db
  ;

type

  { TfrmRecibosListado }

  TfrmRecibosListado = class(TForm)
    btnAceptar: TBitBtn;
    btnAnular: TBitBtn;
    btnModificar: TBitBtn;
    btnNuevo: TBitBtn;
    ds_recibos: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAnularClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    function getReciboSeleccionado: GUID_ID;
    procedure PantallaRecibo (recibo_id: GUID_ID);
  public
    property reciboSeleccionado: GUID_ID read getReciboSeleccionado;
    { public declarations }
  end;

var
  frmRecibosListado: TfrmRecibosListado;

implementation
{$R *.lfm}
uses
  dmrecibos
  ,frm_reciboae
  ;


{ TfrmRecibosListado }

procedure TfrmRecibosListado.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmRecibosListado.btnNuevoClick(Sender: TObject);
begin
  PantallaRecibo(GUIDNULO);
end;

procedure TfrmRecibosListado.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmRecibosListado.btnAnularClick(Sender: TObject);
begin
  if (MessageDlg ('AVISO', '¿Anulo el recibo seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Recibos.AnularRecibo;
    DM_Recibos.LevantarRecibos;
    ShowMessage('El Recibo ha sido anulado, pero si contenía cheques, estos siguen en su cartera');
  end;
end;

procedure TfrmRecibosListado.btnModificarClick(Sender: TObject);
begin
  PantallaRecibo(DM_Recibos.ListadoRecibosSel);
end;

procedure TfrmRecibosListado.FormShow(Sender: TObject);
begin
  DM_Recibos.LevantarRecibos;
end;

function TfrmRecibosListado.getReciboSeleccionado: GUID_ID;
begin
  Result:= DM_Recibos.qListaRecibosID.AsString;
end;

procedure TfrmRecibosListado.PantallaRecibo(recibo_id: GUID_ID);
var
  pant: TfrmRecibosAE;
begin
  pant:= TfrmRecibosAE.Create(self);
  try
    pant.recibo_id:= recibo_id;
    if pant.ShowModal = mrOK then
      DM_Recibos.LevantarRecibos;
  finally
    pant.Free;
  end;
end;

end.

