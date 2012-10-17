unit frm_grupocuentas; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ExtDlgs, EditBtn, Buttons, DBGrids
  ,dmgeneral;

type

  { TfrmGrupoCuentas }

  TfrmGrupoCuentas = class(TForm)
    btnExportarExcel: TBitBtn;
    btnSalir: TBitBtn;
    btnFiltrar: TBitBtn;
    btnBuscar: TBitBtn;
    btnBuscarEmpresa: TBitBtn;
    ckTodasEmpresas: TCheckBox;
    ckTodasCuentas: TCheckBox;
    ds_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    edEmpresa: TEdit;
    edCuenta: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    SD: TSaveDialog;
    stCuenta: TStaticText;
    stTotalEgresos: TStaticText;
    stTotalIngresos: TStaticText;
    stTotalSaldo: TStaticText;
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ds_ResultadosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
     _refEmpresa: GUID_ID;
     _refCuenta: Integer;
     _rutaReporte: string;
     _tipoListado: integer;

     procedure Inicializar;
  public
    property rutaReporte: string write _rutaReporte;
    property tipoListado: integer write _tipoListado;
  end; 

var
  frmGrupoCuentas: TfrmGrupoCuentas;

implementation
{$R *.lfm}
uses
   dmgrupocuentas
  ,frm_proveedoreslistado
  ,frm_plandecuentaslistado
  ,dmseleccionlistado
  ;

{ TfrmGrupoCuentas }

procedure TfrmGrupoCuentas.FormCreate(Sender: TObject);
begin
//  Application.CreateForm(TDM_GrupoCuentas, DM_GrupoCuentas);
  Inicializar;
end;

procedure TfrmGrupoCuentas.FormDestroy(Sender: TObject);
begin
 // DM_GrupoCuentas.Free;
end;

procedure TfrmGrupoCuentas.Inicializar;
begin
  _refCuenta:= 0;
  _refEmpresa:= GUIDNULO;
  edFechaIni.Date:= Now;
  edFechaFin.Date:= Now;
  edEmpresa.Clear;
  ckTodasEmpresas.Checked:= True;
  edCuenta.Clear;
  stCuenta.Caption:= EmptyStr;
  ckTodasCuentas.Checked:= True;
  stTotalIngresos.Caption:= 'Total Ingresos: $ 0.00';
  stTotalEgresos.Caption:= 'Total Egresos: $ 0.00';
  stTotalSaldo.Caption:= 'Total Saldo: $ 0.00';
end;

procedure TfrmGrupoCuentas.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmGrupoCuentas.DBGrid1TitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(Column);
end;

procedure TfrmGrupoCuentas.ds_ResultadosDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure TfrmGrupoCuentas.btnFiltrarClick(Sender: TObject);
begin
  with DM_GrupoCuentas do
  begin
    fechaIni:= edFechaIni.Date;
    fechaFin:= edFechaFin.Date;
    refEmpresa:= _refEmpresa;
    bEmpresasTodas:= ckTodasEmpresas.Checked;
    refCuenta:= _refCuenta;
    bCuentasTodas:= ckTodasCuentas.Checked;

    Filtrar(_tipoListado);

    stTotalIngresos.Caption:= 'Total Ingresos: $ ' + FormatFloat('#############0.00', DM_GrupoCuentas.TotalIngresos);
    stTotalEgresos.Caption:= 'Total Egresos: $ '+ FormatFloat('#############0.00', DM_GrupoCuentas.TotalEgresos);
    stTotalSaldo.Caption:= 'Total Saldo: $ ' + FormatFloat('#############0.00', DM_GrupoCuentas.TotalIngresos - DM_GrupoCuentas.TotalEgresos);
  end;
end;

procedure TfrmGrupoCuentas.btnBuscarEmpresaClick(Sender: TObject);
var
  pant: TfrmProveedoresListado;
begin
  pant:= TfrmProveedoresListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
         edEmpresa.Text:= pant.RazonSocial;
         _refEmpresa:= pant.idProveedor;
         ckTodasEmpresas.Checked:= false;
    end
    else
    begin
        edEmpresa.Text:= EmptyStr;
        _refEmpresa:= GUIDNULO;
        ckTodasEmpresas.Checked:= true;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmGrupoCuentas.btnBuscarClick(Sender: TObject);
var
  pant: TfrmPlanDeCuentasListado;
begin
     pant:= TfrmPlanDeCuentasListado.Create(self);
     try
       if pant.showModal = mrOK then
       begin
            _refCuenta:= pant.idCuenta;
            stCuenta.Caption:= pant.NombreCuentaSeleccionado;
            edCuenta.Text:= pant.CodigoSeleccionado;
            ckTodasCuentas.Checked:= false;
       end
       else
       begin
           _refCuenta:= 0;
           stCuenta.Caption:='--------------';
           edCuenta.Clear;
           ckTodasCuentas.Checked:= true;
       end;
     finally
       pant.Free;
     end;
end;

procedure TfrmGrupoCuentas.btnExportarExcelClick(Sender: TObject);
begin
  if SD.Execute then
   DM_SeleccionListado.ExportarXLS(DM_GrupoCuentas.tbResultados, SD.FileName, 'egresos');
end;

end.

