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
    procedure btnNuevoClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    procedure PantallaRecibo (recibo_id: GUID_ID);
  public
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

procedure TfrmRecibosListado.FormShow(Sender: TObject);
begin
  DM_Recibos.LevantarRecibos;
end;

procedure TfrmRecibosListado.PantallaRecibo(recibo_id: GUID_ID);
var
  pant: TfrmRecibosAE;
begin
  pant:= TfrmRecibosAE.Create(self);
  try
    pant.recibo_id:= recibo_id;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

end.

