unit dmproveedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral;

type

  { TDM_Proveedores }

  TDM_Proveedores = class(TDataModule)
    qListaProveedores: TZQuery;
    qtugCondicionesFiscales: TZQuery;
    tbProveedores: TRxMemoryData;
    tbProveedoresDEL: TZQuery;
    tbProveedoresINS: TZQuery;
    tbProveedoresSEL: TZQuery;
    tbProveedoresUPD: TZQuery;
    procedure tbProveedoresAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarProveedores;
    procedure Grabar;
    procedure CargarValores (refCondicionFiscal: integer);

    procedure NuevoProveedor;
    procedure EditarProveedorLista;
    procedure EliminarProveedorLista;

    function ProveedorNombre (refProveedor: GUID_ID): string;
  end; 

var
  DM_Proveedores: TDM_Proveedores;

implementation
{$R *.lfm}

{ TDM_Proveedores }

procedure TDM_Proveedores.tbProveedoresAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idProveedor').asString:= DM_General.CrearGUID;
    FieldByName('cRazonSocial').asString:= EmptyStr;
    FieldByName('cCUIT').asString:= EmptyStr;
    FieldByName('refCondicionFiscal').asInteger:= 0;
    FieldByName('cContacto').asString:= EmptyStr;
    FieldByName('cDomicilio').asString:= EmptyStr;
    FieldByName('txNotas').asString:= EmptyStr;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Proveedores.LevantarProveedores;
begin
  with qListaProveedores do
  begin
    if active then close;
    open;
  end;
end;

procedure TDM_Proveedores.Grabar;
begin
  DM_General.GrabarDatos(tbProveedoresSEL, tbProveedoresINS, tbProveedoresUPD, tbProveedores, 'idProveedor');
end;

procedure TDM_Proveedores.CargarValores(refCondicionFiscal: integer);
begin
  with tbProveedores do
  begin
    Edit;
    FieldByName('refCondicionFiscal').asInteger:= refCondicionFiscal;
    Post;
  end;
end;

procedure TDM_Proveedores.NuevoProveedor;
begin
  DM_General.ReiniciarTabla(tbProveedores);
  tbProveedores.Insert;
end;

procedure TDM_Proveedores.EditarProveedorLista;
begin
  DM_General.ReiniciarTabla(tbProveedores);
  with tbProveedoresSEL do
  begin
    if active then close;
    ParamByName('idProveedor').asString:= qListaProveedores.FieldByName('idProveedor').asString;
    Open;
    tbProveedores.LoadFromDataSet(tbProveedoresSEL, 0, lmAppend);
  end;
end;

procedure TDM_Proveedores.EliminarProveedorLista;
begin
  with tbProveedoresDEL do
  begin
    ParamByName('idProveedor').asString:= qListaProveedores.FieldByName('idProveedor').asString;
    ExecSQL;
  end;
end;

function TDM_Proveedores.ProveedorNombre(refProveedor: GUID_ID): string;
begin
  with tbProveedoresSEL do
  begin
    if active then close;
    ParamByName('idProveedor').asString:= refProveedor;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('cRazonSocial').asString
    else
      Result:= EmptyStr;
  end;
end;

end.


