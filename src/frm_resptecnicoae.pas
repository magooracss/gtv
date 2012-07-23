unit frm_resptecnicoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  DbCtrls, StdCtrls, dbdateedit, rxdbcomb
  ,dmgeneral;

type

  { TfrmResponsableTecnicoAE }

  TfrmResponsableTecnicoAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DS_RespTecnico: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    cbPoliciaRX: TRxDBComboBox;
    SpeedButton8: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
  private
    _Operacion: TOperacion;
    procedure CargarCombos;
  public
    property Operacion: TOperacion write _Operacion;
  end; 

var
  frmResponsableTecnicoAE: TfrmResponsableTecnicoAE;

implementation
{$R *.lfm}
uses
  dmclientes
  ,dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmResponsableTecnicoAE }

procedure TfrmResponsableTecnicoAE.btnAceptarClick(Sender: TObject);
begin
  DM_Clientes.GrabarRespTecnicos;
  ModalResult:= mrOK;
end;

procedure TfrmResponsableTecnicoAE.btnCancelarClick(Sender: TObject);
begin
  DM_Clientes.tbRespTecnico.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmResponsableTecnicoAE.FormShow(Sender: TObject);
begin
  CargarCombos;
end;

procedure TfrmResponsableTecnicoAE.SpeedButton8Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPOLICIAS';
      titulo:= 'Nombres de las distintas reparticiones Policiales';
      AgregarCampo('POLICIA','Policía');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    CargarCombos;
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmResponsableTecnicoAE.CargarCombos;
begin
  cbPoliciaRX.Items.Clear;
  cbPoliciaRX.Values.Clear;
  with DM_Clientes.qTugPolicias do
  begin
    if active then close;
    Open;
    While Not EOF do
    begin
      cbPoliciaRX.Items.Add(FieldByName('Policia').AsString);
      cbPoliciaRX.Values.Add(IntToStr(FieldByName('idPolicia').asInteger));
      Next;
    end;
  end;

  case _Operacion of
   nuevo: DM_Clientes.tbRespTecnico.Insert;
   modificar: DM_Clientes.tbRespTecnico.Edit;
  end;

end;

end.

