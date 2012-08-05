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
    qTugComprobantePorID: TZQuery;
    qtugCondicionesPago: TZQuery;
    qtugCondicionPagoTiempo: TZQuery;
    qtugLocalidades: TZQuery;
    qtugProvinciaLocalidadID: TZQuery;
    tbProveedores: TRxMemoryData;
    tbProveedoresbVisible: TLongintField;
    tbProveedorescCorreos: TStringField;
    tbProveedorescCUIT: TStringField;
    tbProveedorescDomicilio: TStringField;
    tbProveedorescIngresosBrutos: TStringField;
    tbProveedorescNombreFantasia: TStringField;
    tbProveedorescRazonSocial: TStringField;
    tbProveedorescTelefonos: TStringField;
    tbProveedorescWeb: TStringField;
    tbProveedoresDEL: TZQuery;
    tbProveedoresidProveedor: TStringField;
    tbProveedoresINS: TZQuery;
    tbProveedoresrefComprEntrega: TLongintField;
    tbProveedoresrefComprRecibe: TLongintField;
    tbProveedoresrefCondicionFiscal: TLongintField;
    tbProveedoresrefCondicionPago: TLongintField;
    tbProveedoresrefCondicionPagoTiempo: TLongintField;
    tbProveedoresrefImputacion: TLongintField;
    tbProveedoresrefLocalidad: TLongintField;
    tbProveedoresSEL: TZQuery;
    tbProveedorestxNotas: TStringField;
    tbProveedoresUPD: TZQuery;
    procedure tbProveedoresAfterInsert(DataSet: TDataSet);
  private
    function getIdCondPago: integer;
    function getIdCondPagoTiempo: integer;
    function getIdProveedor: string;
    function getIdTipoComprobante: integer;
    function getNombre: string;
    { private declarations }
  public
    property idTipoComprobante: integer read getIdTipoComprobante;
    property idCondPago: integer read getIdCondPago;
    property idConPagoTiempo: integer read getIdCondPagoTiempo;
    property Nombre: string read getNombre;
    property idProveedor: string read getIdProveedor;

    procedure LevantarProveedores;
    procedure LevantarProveedorID (refProveedor: string);
    procedure Grabar;
    procedure CargarValores (refCondicionFiscal, refCondicionPago, refTiempoPago, refLocalidad: integer);

    procedure NuevoProveedor;
    procedure EditarProveedorLista;
    procedure EliminarProveedorLista;

    function ProveedorNombre (refProveedor: GUID_ID): string;

    function NombreProvinciaPorLocalidad (idLocalidad: integer): string;
    procedure EditarImputacion (refCuenta: integer);
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
    FieldByName('cDomicilio').asString:= EmptyStr;
    FieldByName('txNotas').asString:= EmptyStr;
    FieldByName('bVisible').asInteger:= 1;
    FieldByName('CNOMBREFANTASIA').asString:= EmptyStr;
    FieldByName('REFLOCALIDAD').asInteger:= 0;
    FieldByName('CTELEFONOS').asString:= EmptyStr;
    FieldByName('CCORREOS').asString:= EmptyStr;
    FieldByName('CWEB').asString:= EmptyStr;
    FieldByName('REFIMPUTACION').asInteger:= 0;
    FieldByName('CINGRESOSBRUTOS').asString:= EmptyStr;
    FieldByName('REFCONDICIONPAGO').asInteger:= 0;
    FieldByName('REFCONDICIONPAGOTIEMPO').asInteger:= 0;
  end;
end;

function TDM_Proveedores.getIdCondPago: integer;
begin
  with tbProveedores do
  begin
    if FieldByName('refCondicionPago').IsNull then
      result:= 0
    else
      result:= FieldByName('refCondicionPago').AsInteger;
  end;
end;

function TDM_Proveedores.getIdCondPagoTiempo: integer;
begin
  with tbProveedores do
  begin
    if FieldByName('refCondicionPagoTiempo').IsNull then
      result:= 0
    else
      result:= FieldByName('refCondicionPagoTiempo').AsInteger;
  end;
end;

function TDM_Proveedores.getIdProveedor: string;
begin
  with tbProveedores do
  begin
    if FieldByName('idProveedor').IsNull then
      result:= GUIDNULO
    else
      result:= FieldByName('idProveedor').AsString;
  end;
end;

function TDM_Proveedores.getIdTipoComprobante: integer;
begin
  with qTugComprobantePorID do
  begin
    if active then close;
    ParamByName('idCondicionFiscal').asInteger:= tbProveedores.FieldByName('refCondicionFiscal').asInteger;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('comprRecibe').AsInteger
    else
      Result:= 0;
  end;
end;

function TDM_Proveedores.getNombre: string;
begin
  with tbProveedores do
  begin
    if FieldByName('cRazonSocial').IsNull then
      result:= EmptyStr
    else
      result:= FieldByName('cRazonSocial').AsString;
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

procedure TDM_Proveedores.LevantarProveedorID(refProveedor: string);
begin
  DM_General.ReiniciarTabla(tbProveedores);
  with tbProveedoresSEL do
  begin
    if active then close;
    ParamByName('idProveedor').asString:= refProveedor;
    Open;
    tbProveedores.LoadFromDataSet(tbProveedoresSEL, 0, lmAppend);
  end;
end;

procedure TDM_Proveedores.Grabar;
begin
  DM_General.GrabarDatos(tbProveedoresSEL, tbProveedoresINS, tbProveedoresUPD, tbProveedores, 'idProveedor');
end;

procedure TDM_Proveedores.CargarValores(refCondicionFiscal, refCondicionPago,
  refTiempoPago, refLocalidad: integer);
begin
  with tbProveedores do
  begin
    Edit;
    FieldByName('refCondicionFiscal').asInteger:= refCondicionFiscal;
    FieldByName('refCondicionPago').asInteger:= refCondicionPago;
    FieldByName('refCondicionPagoTiempo').asInteger:= refTiempoPago;
    FieldByName('refLocalidad').asInteger:= refLocalidad;
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

function TDM_Proveedores.NombreProvinciaPorLocalidad(idLocalidad: integer
  ): string;
begin

  with qtugProvinciaLocalidadID do
  begin
    if active then close;
    ParamByName('idLocalidad').asInteger:= idLocalidad;
    Open;
    if RecordCount > 0 then
      Result:= FieldByName('Provincia').asString
    else
      Result:= EmptyStr;
  end;
end;

procedure TDM_Proveedores.EditarImputacion(refCuenta: integer);
begin
  with tbProveedores do
  begin
    Edit;
    FieldByName('refImputacion').asInteger:= refCuenta;
    Post;
  end;
end;

end.


