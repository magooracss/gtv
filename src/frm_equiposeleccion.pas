unit frm_equiposeleccion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, dmgeneral;

type

  { TfrmEquipoSeleccion }

  TfrmEquipoSeleccion = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBGrid1: TDBGrid;
    DS_Equipos: TDatasource;
    Panel1: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    _idEquipo: GUID_ID;
    { private declarations }
  public
    property idCliente: GUID_ID write _idCliente;
    property idEquipo: GUID_ID read _idEquipo write _idEquipo;
  end; 

var
  frmEquipoSeleccion: TfrmEquipoSeleccion;

implementation
{$R *.lfm}
uses
  dmEquipos
  ;

{ TfrmEquipoSeleccion }

procedure TfrmEquipoSeleccion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmEquipoSeleccion.FormShow(Sender: TObject);
begin
  DM_Equipos.LevantarEquiposCliente(_idCliente);
end;

procedure TfrmEquipoSeleccion.btnAceptarClick(Sender: TObject);
begin
  idEquipo:= DM_Equipos.idEquipoActual;
  ModalResult:= mrOK;
end;

end.

