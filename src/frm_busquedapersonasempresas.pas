unit frm_busquedapersonasempresas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids
  ,dmbuscarpersonaempresa, dmgeneral;

type

  { TfrmBusquedaPersonasEmpresas }

  TfrmBusquedaPersonasEmpresas = class(TForm)
    btnBuscar: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ds_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edNombre: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure edNombreKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    function getidPersonaEmpresaSeleccionada: GUID_ID;
    procedure Buscar;
  public
    property idPersonaEmpresa: GUID_ID read getidPersonaEmpresaSeleccionada;
  end; 

var
  frmBusquedaPersonasEmpresas: TfrmBusquedaPersonasEmpresas;

implementation

{$R *.lfm}

{ TfrmBusquedaPersonasEmpresas }

procedure TfrmBusquedaPersonasEmpresas.BitBtn3Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaPersonasEmpresas.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBusquedaPersonasEmpresas.edNombreKeyPress(Sender: TObject;
  var Key: char);
begin
  if Key = #13 then
   Buscar;
end;

procedure TfrmBusquedaPersonasEmpresas.FormShow(Sender: TObject);
begin
  DM_BuscarPersonaEmpresa.Inicializar;
  edNombre.SetFocus;
end;

procedure TfrmBusquedaPersonasEmpresas.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

function TfrmBusquedaPersonasEmpresas.getidPersonaEmpresaSeleccionada: GUID_ID;
begin
  result:= DM_BuscarPersonaEmpresa.idPersonaEmpresaSeleccionada;
end;

procedure TfrmBusquedaPersonasEmpresas.Buscar;
begin
  DM_BuscarPersonaEmpresa.Buscar(edNombre.Text);
end;

end.

