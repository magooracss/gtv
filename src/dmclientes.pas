unit dmclientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ,dmConexion, db;

const
  //Estos valores despues los tengo que levantar del archivo de configuracion
  __IVA =21;
  __CONSERVADOR = GUIDNULO;

type

  { TDM_Clientes }

  TDM_Clientes = class(TDataModule)
    qTugPolicias: TZQuery;
    qtugTiposContacto: TZQuery;
    qtugTiposDocumento: TZQuery;
    qtugTiposContactoCliente: TZQuery;
    qAdministradorPorNombre: TZQuery;
    qClienteCodigo: TZQuery;
    tbRespTecnicosDEL: TZQuery;
    tbRespTecnicosINS: TZQuery;
    tbRespTecnicoSEL: TZQuery;
    tbRespTecnicosUPD: TZQuery;
    tbContCliContacto: TRxMemoryData;
    tbAdmDomicilios: TRxMemoryData;
    tbContactosCliente: TRxMemoryData;
    tbContClienteINS: TZQuery;
    tbConservadoresINS: TZQuery;
    tbContClienteSEL: TZQuery;
    tbConservadoresSEL: TZQuery;
    tbContClienteUPD: TZQuery;
    tbContactosDEL: TZQuery;
    tbAdministradores: TRxMemoryData;
    tbAdmContactos: TRxMemoryData;
    tbAdministradoresINS: TZQuery;
    tbContClienteRel: TZQuery;
    tbConservadoresUPD: TZQuery;
    tbDomiciliosDEL: TZQuery;
    tbContactosINS: TZQuery;
    tbConservadoresDEL: TZQuery;
    tbDomiciliosINS: TZQuery;
    tbDomiciliosPorRel: TZQuery;
    tbContactosSEL: TZQuery;
    tbDomiciliosSEL: TZQuery;
    tbContactosUPD: TZQuery;
    tbClientesSEL: TZQuery;
    qtugLocalidades: TZQuery;
    qtugAbonos: TZQuery;
    qListadoRespTecnico: TZQuery;
    qListadoConservadores: TZQuery;
    qtugGruposFacturacion: TZQuery;
    qtugCondicionesFiscales: TZQuery;
    tbClientesINS: TZQuery;
    qListaClientes: TZQuery;
    tbAdministradoresSEL: TZQuery;
    tbClientesUPD: TZQuery;
    tbClientesDEL: TZQuery;
    tbAdministradoresUPD: TZQuery;
    tbContactosPorRel: TZQuery;
    tbDomiciliosUPD: TZQuery;
    tugDestinosCliente: TRxMemoryData;
    tbClientes: TRxMemoryData;
    qtugDestinosCliente: TZQuery;
    tugLocalidades: TRxMemoryData;
    tugAbonos: TRxMemoryData;
    tbRespTecnico: TRxMemoryData;
    tbConservadores: TRxMemoryData;
    tugGruposFacturacion: TRxMemoryData;
    tugCondicionesFiscales: TRxMemoryData;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbContCliContactoAfterInsert(DataSet: TDataSet);
    procedure tbAdmContactosAfterInsert(DataSet: TDataSet);
    procedure tbAdmDomiciliosAfterInsert(DataSet: TDataSet);
    procedure tbAdministradoresAfterInsert(DataSet: TDataSet);
    procedure tbContactosClienteAfterInsert(DataSet: TDataSet);
    procedure tugCondicionesFiscalesAfterInsert(DataSet: TDataSet);
    procedure tbClientesAfterInsert(DataSet: TDataSet);
    procedure tugAbonosAfterInsert(DataSet: TDataSet);
    procedure tbConservadoresAfterInsert(DataSet: TDataSet);
    procedure tugDestinosClienteAfterInsert(DataSet: TDataSet);
    procedure tugGruposFacturacionAfterInsert(DataSet: TDataSet);
    procedure tugLocalidadesAfterInsert(DataSet: TDataSet);
    procedure tbRespTecnicoAfterInsert(DataSet: TDataSet);
  private
    function getClienteID: GUID_ID;
    { private declarations }
  public
    property idCliente: GUID_ID read getClienteID;

    function  ClienteNombre (refCliente: GUID_ID): string;

    procedure ClienteNuevo;
    procedure CargarCombos (refDestino, refLocalidad,  refAbono
                           , refGrupoFacturacion, refCondicionIva, AdmDoc
                           , contDoc, contTipo: integer);
    procedure Grabar;

    procedure ListaClientes;
    function idClienteListadoGral: GUID_ID;

    procedure ClienteEditar (elIdCliente: GUID_ID);
    procedure BorrarCliente (elIdCliente: GUID_ID);

    procedure AcomodarLxContactos (var laTabla:TRxMemoryData );
    procedure TablaContactoAdm (dato: string; idTipo: integer; operacion: TOperacion);
    procedure EliminarTablaContactoAdm;

    procedure AcomodarLxDomicilios (var laTabla:TRxMemoryData );
    procedure TablaDireccionAdm (Direccion: string; idLocalidad: integer; operacion: TOperacion);
    procedure EliminarTablaDireccionAdm;

    procedure TablaContCliente (Dato: string; idTipo: integer; operacion: TOperacion);
    procedure EliminarTablaContCliContacto;

    procedure GrabarConservadores;
    procedure LevantarConservadores;
    procedure eliminarConservadorActual;

    procedure GrabarRespTecnicos;
    procedure LevantarResponstablesTecnicos;
    procedure eliminarResponstableTecnico;

    procedure AdministradorNuevo;
    procedure BuscarAdministradoresPorNombre (elNombre: string);
    procedure AsociarAdministrador (refAdministrador: string);
    procedure LevantarAdministrador (refAdministrador: string);

    function CodigoClienteExistente (refCliente: GUID_ID; refCodigo: string): boolean;
  end; 

var
  DM_Clientes: TDM_Clientes;

implementation

{$R *.lfm}

{ TDM_Clientes }

procedure TDM_Clientes.tbClientesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCliente').asString:= DM_General.CrearGUID;
    FieldByName('cCodigo').asString:= '0';
    FieldByName('cNombre').asString:= '';
    FieldByName('fInicio').asDateTime:= Now;
    FieldByName('refAbono').asInteger:= 0;
    FieldByName('refRespTecnico').asString:= GUIDNULO;
    FieldByName('refGrupoFacturacion').asInteger:= 0;
    FieldByName('refCondicionFiscal').asInteger:= 0;
    FieldByName('cCUIT').asString:= '';
    FieldByName('nIVA').AsFloat:= __IVA;
    FieldByName('cDomicilio').asString:= '';
    FieldByName('cEntreCalle1').asString:= '';
    FieldByName('cEntreCalle2').asString:= '';
    FieldByName('cNroCasa').asString:= '';
    FieldByName('cSeccion').asString:= '';
    FieldByName('cManzana').asString:= '';
    FieldByName('cParcela').asString:= '';
    FieldByName('refLocalidad').AsInteger:= 0;
    FieldByName('refDestino').AsInteger:= 0;
    FieldByName('UnidadFuncional').AsInteger:= 0;
    FieldByName('refAdministrador').asString:= GUIDNULO;
    FieldByName('refConservador').asString:= __CONSERVADOR;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Clientes.tugCondicionesFiscalesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idCondicionFiscal').AsInteger:= -1;
    FieldByName('CondicionFiscal').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tbAdministradoresAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idAdministrador').asString:= DM_General.CrearGUID;
    FieldByName('cRazonSocial').asString:= '';
    FieldByName('CUIT').asString:= '';
    FieldByName('refTipoDocumento').AsInteger:= 0;
    FieldByName('cDocumento').asString:= '';
    FieldByName('txNotas').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tbContactosClienteAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idContactoCliente').asString:= DM_General.CrearGUID;
    FieldByName('refCliente').asString:= tbClientes.FieldByName('idCliente').asString;
    FieldByName('Denominacion').asString:= '';
    FieldByName('refTipoContacto').AsInteger:= 0;
    FieldByName('refTipoDocumento').AsInteger:= 0;
    FieldByName('cDocumento').asString:= '';
    FieldByName('cCargo').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;


procedure TDM_Clientes.tbAdmContactosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idContacto').asString:= DM_General.CrearGUID;
    FieldByName('refRelacion').asString:= tbClientes.FieldByName('refAdministrador').asString;
    FieldByName('Contacto').asString:= '';
    FieldByName('refTipoContacto').AsInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tbAdmDomiciliosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idDomicilio').asString:= DM_General.CrearGUID;
    FieldByName('refRelacion').asString:= tbClientes.FieldByName('refAdministrador').asString;
    FieldByName('Domicilio').asString:= '';
    FieldByName('refLocalidad').AsInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(TDatamodule(DM_Clientes), true);
end;

procedure TDM_Clientes.tbContCliContactoAfterInsert(DataSet: TDataSet);
begin
   with DataSet do
  begin
    FieldByName('idContacto').asString:= DM_General.CrearGUID;
    FieldByName('refRelacion').asString:= tbContactosCliente.FieldByName('idContactoCliente').asString;
    FieldByName('Contacto').asString:= '';
    FieldByName('refTipoContacto').AsInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tugAbonosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idAbono').AsInteger:= -1;
    FieldByName('Abono').asString:= '';
    FieldByName('Monto').AsFloat:= 0;
    FieldByName('bVisible').AsInteger:= 1;
  end
end;

procedure TDM_Clientes.tbConservadoresAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idConservador').AsString:= DM_General.CrearGUID;
    FieldByName('cRazonSocial').asString:= '';
    FieldByName('cDomicilio').asString:= '';
    FieldByName('cCodPostal').asString:= '';
    FieldByName('cTelefono').asString:= '';
    FieldByName('NroPermiso').asString:= '';
    FieldByName('CUIT').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tugDestinosClienteAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idDestinoCliente').AsInteger:= -1;
    FieldByName('Destino').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tugGruposFacturacionAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idGrupoFacturacion').AsInteger:= -1;
    FieldByName('GrupoFacturacion').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tugLocalidadesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLocalidad').AsInteger:= -1;
    FieldByName('Localidad').asString:= '';
    FieldByName('cPostal').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Clientes.tbRespTecnicoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idResponsableTecnico').AsString:= DM_General.CrearGUID;
    FieldByName('cNombre').asString:= '';
    FieldByName('cDomicilio').asString:= '';
    FieldByName('cTelefono').asString:= '';
    FieldByName('HabilitacionExp').asString:= '';
    FieldByName('HabilitacionFecha').AsDateTime:= Now;
    FieldByName('CedulaIdentidad').asString:= '';
    FieldByName('refPolicia').asInteger:= 0;
    FieldByName('DNI').asString:= '';
    FieldByName('Matricula').asString:= '';
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

function TDM_Clientes.getClienteID: GUID_ID;
begin
  if (tbClientes.State = dsInsert) then
  begin
    tbClientes.Post;
  end;

  if (tbClientes.Active) and (tbClientes.RecordCount > 0) then
   Result := tbClientes.FieldByName('idCliente').asString
  else
    Result := GUIDNULO;
end;

function TDM_Clientes.ClienteNombre(refCliente: GUID_ID): string;
begin
  ClienteEditar(refCliente);
  Result:= tbClientes.FieldByName('cNombre').asString;
end;

procedure TDM_Clientes.ClienteNuevo;
begin
  DM_General.ReiniciarTabla(tbClientes);
  tbClientes.Insert;
end;

procedure TDM_Clientes.CargarCombos(refDestino, refLocalidad,
  refAbono, refGrupoFacturacion, refCondicionIva, AdmDoc,
  contDoc, contTipo: integer);
begin
  with tbAdministradores do
  begin
    Edit;
    FieldByName('refTipoDocumento').asInteger:= AdmDoc;
    Post;
  end;

  with tbClientes do
  begin
    Edit;
    //Aprovecho la volada y vinculo el administrador al cliente
    FieldByName('refAdministrador').AsString:= tbAdministradores.FieldByName('idAdministrador').asString;

    FieldByName('refDestino').asInteger:= refDestino;
    FieldByName('refLocalidad').asInteger:= refLocalidad;
    FieldByName('refAbono').asInteger:= refAbono;
    FieldByName('refGrupoFacturacion').asInteger:= refGrupoFacturacion;
    FieldByName('refCondicionFiscal').asInteger:= refCondicionIva;
    Post;
  end;

  with tbContactosCliente do
  begin
    Edit;
    FieldByName('refCliente').asString:= tbClientes.FieldByName('idCliente').asString;

    FieldByName('refTipoDocumento').asInteger:= contDoc;
    FieldByName('refTipoContacto').asInteger:= contTipo;
    Post;
  end;

end;

procedure TDM_Clientes.Grabar;
begin
  DM_General.GrabarDatos(tbAdministradoresSEL, tbAdministradoresINS, tbAdministradoresUPD, tbAdministradores , 'idAdministrador');
  DM_General.GrabarDatos(tbClientesSEL, tbClientesINS, tbClientesUPD, tbClientes, 'idCliente');
  DM_General.GrabarDatos(tbContactosSEL, tbContactosINS, tbContactosUPD, tbAdmContactos, 'idContacto');
  DM_General.GrabarDatos(tbDomiciliosSEL, tbDomiciliosINS, tbDomiciliosUPD, tbAdmDomicilios, 'idDomicilio');
  DM_General.GrabarDatos(tbContClienteSEL, tbContClienteINS, tbContClienteUPD, tbContactosCliente, 'idContactoCliente');
  DM_General.GrabarDatos(tbContactosSEL, tbContactosINS, tbContactosUPD, tbContCliContacto, 'idContacto');
end;

procedure TDM_Clientes.ListaClientes;
var
  marca: TBookmark;
begin
  marca:= qListaClientes.GetBookmark;
  with qListaClientes do
  begin
    if active then close;
    Open;
    GotoBookmark(marca);
    FreeBookmark(marca);
  end;
end;

function TDM_Clientes.idClienteListadoGral: GUID_ID;
begin
  if (qListaClientes.Active) and (NOT qListaClientes.EOF) then
    Result:= qListaClientes.FieldByName('idCliente').asString
  else
    Result:= GUIDNULO;
end;



procedure TDM_Clientes.ClienteEditar(elIdCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbClientes);

  with tbClientesSEL do
  begin
    if active then close;
    ParamByName('idCliente').asString:= elIdCliente;
    open;
    tbClientes.LoadFromDataSet(tbClientesSEL, 0, lmAppend);
  end;

  LevantarAdministrador(tbClientes.FieldByName('refAdministrador').asString);

  DM_General.ReiniciarTabla(tbContactosCliente);
  with tbContClienteRel do
  begin
    if active then close;
    ParamByName('refCliente').asString:= tbClientes.FieldByName('idCliente').asString;
    open;
    tbContactosCliente.LoadFromDataSet(tbContClienteRel, 0, lmAppend);
  end;

  DM_General.ReiniciarTabla(tbContCliContacto);
  with tbContactosPorRel do
  begin
    if active then close;
    ParamByName('refRelacion').asString:= tbContactosCliente.FieldByName('idContactoCliente').asString;
    open;
    tbContCliContacto.LoadFromDataSet(tbContactosPorRel, 0, lmAppend);
    AcomodarLxContactos (tbContCliContacto);
  end;


end;

procedure TDM_Clientes.BorrarCliente(elIdCliente: GUID_ID);
begin
  with tbClientesDEL do
  begin
    ParamByName('idCliente').asString:= elIdCliente;
    ExecSQL;
  end;
end;

procedure TDM_Clientes.AcomodarLxContactos(var laTabla: TRxMemoryData);
var
  lx: string;
begin
  with laTabla do
  begin
    if RecordCount > 0 then
      First;
    qtugTiposContacto.Open;
    while not eof do
    begin
      qtugTiposContacto.First;
      if  qtugTiposContacto.Locate('idTipoContacto',(FieldByName('refTipoContacto').asInteger), []) then
      begin
        lx:= qtugTiposContacto.FieldByName('TipoContacto').AsString;
        Edit;
        FieldByName('lxTipoContacto').asString:= lx;
      end;
      next;
    end;
  end;
end;

procedure TDM_Clientes.TablaContactoAdm(dato: string; idTipo: integer;
  operacion: TOperacion);
begin
  with tbAdmContactos do
  begin
    if operacion = nuevo then
      Insert
    else
      Edit;

    FieldByName('Contacto').asString:= Dato;
    FieldByName('refTipoContacto').asInteger:= idTipo;
    Post;
    AcomodarLxContactos(tbAdmContactos);
  end;
end;

procedure TDM_Clientes.EliminarTablaContactoAdm;
begin
  with tbContactosDEL do
  begin
    ParamByName('idContacto').asString:= tbAdmContactos.FieldByName('idContacto').asString;
    ExecSQL;
  end;
  tbAdmContactos.Delete;
end;

procedure TDM_Clientes.AcomodarLxDomicilios(var laTabla: TRxMemoryData);
begin
  with laTabla do
  begin
    if RecordCount > 0 then
      First;
    qtugLocalidades.Open;
    while not eof do
    begin
      qtugLocalidades.First;
      if  qtugLocalidades.Locate('idLocalidad',(FieldByName('refLocalidad').asInteger), []) then
      begin
        Edit;
        FieldByName('lxLocalidad').asString:= qtugLocalidades.FieldByName('Localidad').AsString;
      end;
      next;
    end;
  end;
end;

procedure TDM_Clientes.TablaDireccionAdm(Direccion: string;
  idLocalidad: integer; operacion: TOperacion);
begin
   with tbAdmDomicilios do
  begin
    if operacion = nuevo then
      Insert
    else
      Edit;

    FieldByName('Domicilio').asString:= Direccion;
    FieldByName('refLocalidad').asInteger:= idLocalidad;
    Post;
    AcomodarLxDomicilios(tbAdmDomicilios);
  end;
end;

procedure TDM_Clientes.EliminarTablaDireccionAdm;
begin
  with tbDomiciliosDEL do
  begin
    ParamByName('idDomicilio').asString:= tbAdmDomicilios.FieldByName('idDomicilio').asString;
    ExecSQL;
  end;
  tbAdmDomicilios.Delete;
end;

procedure TDM_Clientes.TablaContCliente(Dato: string;
  idTipo: integer; operacion: TOperacion);
begin
  with tbContCliContacto do
  begin
    if operacion = nuevo then
      Insert
    else
      Edit;

    FieldByName('Contacto').asString:= Dato;
    FieldByName('refTipoContacto').asInteger:= idTipo;
    Post;
    AcomodarLxContactos(tbContCliContacto);
  end;
end;

procedure TDM_Clientes.EliminarTablaContCliContacto;
begin
   with tbContactosDEL do
  begin
    ParamByName('idContacto').asString:= tbContCliContacto.FieldByName('idContacto').asString;
    ExecSQL;
  end;
  tbContCliContacto.Delete;
end;

procedure TDM_Clientes.GrabarConservadores;
begin
  DM_General.GrabarDatos(tbConservadoresSEL,tbConservadoresINS, tbConservadoresUPD, tbConservadores, 'idConservador');
end;

procedure TDM_Clientes.LevantarConservadores;
begin
  DM_General.ReiniciarTabla(tbConservadores);
  with qListadoConservadores do
   begin
     if active then close;
     open;
     tbConservadores.LoadFromDataSet(qListadoConservadores, 0,lmAppend );
     close;
   end;
end;

procedure TDM_Clientes.eliminarConservadorActual;
begin
  if tbConservadores.RecordCount >  0 then
  begin
    with tbConservadoresDEL do
    begin
      ParamByName('idConservador').asString:= tbConservadores.FieldByName('idConservador').asString;
      ExecSQL;
      tbConservadores.Delete;
    end;
  end;
end;

procedure TDM_Clientes.GrabarRespTecnicos;
begin
  DM_General.GrabarDatos(tbRespTecnicoSEL, tbRespTecnicosINS, tbRespTecnicosUPD, tbRespTecnico, 'idResponsableTecnico');
end;

procedure TDM_Clientes.LevantarResponstablesTecnicos;
begin
  DM_General.ReiniciarTabla(tbRespTecnico);
  with qListadoRespTecnico do
  begin
    if Active then Close;
    Open;
    tbRespTecnico.LoadFromDataSet(qListadoRespTecnico, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Clientes.eliminarResponstableTecnico;
begin
   if tbRespTecnico.RecordCount >  0 then
  begin
    with tbRespTecnicosDEL do
    begin
      ParamByName('idResponsableTecnico').asString:= tbRespTecnico.FieldByName('idResponsableTecnico').asString;
      ExecSQL;
      tbRespTecnico.Delete;
    end;
  end;
end;

procedure TDM_Clientes.AdministradorNuevo;
begin
  DM_General.ReiniciarTabla(tbAdministradores);
  DM_General.ReiniciarTabla(tbAdmContactos);
  DM_General.ReiniciarTabla(tbAdmDomicilios);
  tbAdministradores.Insert;
end;

procedure TDM_Clientes.BuscarAdministradoresPorNombre(elNombre: string);
begin
  with qAdministradorPorNombre do
  begin
    if active then close;
    ParamByName('cRazonSocial').asString:= elNombre;
    Open;
  end;
end;

procedure TDM_Clientes.AsociarAdministrador(refAdministrador: string);
begin
  with tbClientes do
  begin
    Edit;
    FieldByName ('refAdministrador').asString:= refAdministrador;
    Post;
  end;
  LevantarAdministrador(refAdministrador);
end;

procedure TDM_Clientes.LevantarAdministrador(refAdministrador: string);
begin
  DM_General.ReiniciarTabla(tbAdministradores);
  with tbAdministradoresSEL do
  begin
    if active then close;
    ParamByName('idAdministrador').asString:= refAdministrador;
    open;
    tbAdministradores.LoadFromDataSet(tbAdministradoresSEL, 0, lmAppend);
  end;

  DM_General.ReiniciarTabla(tbAdmContactos);
  with tbContactosPorRel do
  begin
    if active then close;
    ParamByName('refRelacion').asString:= refAdministrador;
    open;
    tbAdmContactos.LoadFromDataSet(tbContactosPorRel, 0, lmAppend);
    AcomodarLxContactos (tbAdmContactos);
  end;

  DM_General.ReiniciarTabla(tbAdmDomicilios);
  with tbDomiciliosPorRel do
  begin
    if active then close;
    ParamByName('refRelacion').asString:= refAdministrador;
    open;
    tbAdmDomicilios.LoadFromDataSet(tbDomiciliosPorRel, 0, lmAppend);
    AcomodarLxDomicilios (tbAdmDomicilios);
  end;
end;

function TDM_Clientes.CodigoClienteExistente(refCliente: GUID_ID;
  refCodigo: string): boolean;
begin
  with qClienteCodigo do
  begin
    if active then close;
    ParamByName('idCliente').asString:= refCliente;
    ParamByName('cCodigo').asString:= TRIM(refCodigo);
    Open;
    Result:= (RecordCount > 0);
    close;
  end;
end;



end.

