unit frm_presupuestoseleccion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmgeneral;

type

  { TFrmPresupuestoSeleccion }

  TFrmPresupuestoSeleccion = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DS_SeleccionPresupuesto: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idPresupuesto: GUID_ID;
    { private declarations }
  public
    property idPresupuesto: GUID_ID read _idPresupuesto;
    property idCliente: GUID_ID read _idCliente write _idCliente;
  end; 

var
  FrmPresupuestoSeleccion: TFrmPresupuestoSeleccion;

implementation
{$R *.lfm}
uses
  dmpresupuestos
  ;

{ TFrmPresupuestoSeleccion }

procedure TFrmPresupuestoSeleccion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFrmPresupuestoSeleccion.FormShow(Sender: TObject);
begin
  DM_Presupuestos.LevantarPresupuestos(_idCliente, _TODOS_LOS_ESTADOS_);
end;

procedure TFrmPresupuestoSeleccion.btnAceptarClick(Sender: TObject);
begin
  _idPresupuesto:= DM_Presupuestos.idPresupuestoListadoActual;
  ModalResult:= mrOK;
end;

end.

