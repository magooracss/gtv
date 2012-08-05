program gtv;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazreport, rxnew, zvdatetimectrls, zcomponent, frm_principal,
  dmconexion, dmgeneral, SD_Configuracion, versioninfo, frm_clienteam,
  dmclientes, dmediciontugs, frm_ediciontugs, frm_busquedaclientes,
  dmbuscarcliente, frm_contactosAE, frm_domicilioae, frm_equipocliente,
  dmEquipos, frm_presupuestoslistado, dmpresupuestos, frm_presupuestoae,
  frm_altamasivacuotas, frm_cuotaae, dmordenestrabajo,
  frm_ordenestrabajolistado, frm_ordentrabajoae, frm_equiposeleccion,
  frm_presupuestoseleccion, frm_conservadorae, frm_conservadoreslistado,
  frm_resptecnicoslistado, frm_resptecnicoae, frm_administradoressel,
  frm_reclamosam, dmreclamos, frm_reclamoslistado, frm_remitoslistado,
  dmremitos, frm_remitosae, frm_listadopersonal, frm_cajalistado, dmcaja,
  frm_cajaconceptoae, frm_conceptoae, frm_tugconceptoslistado, dmproveedores,
  frm_proveedoreslistado, frm_proveedoresae, frm_clientespotencialeslistado,
  dmclientespotenciales, frm_clientespotencialesae, frm_listadocheques,
  dmcheques, frm_chequesae, dmbuscarpersonaempresa,
  frm_busquedapersonasempresas, dmcompras, frm_compraslistado, frm_comprasae,
  dmplandecuentas, frm_plandecuentaslistado, frm_plandecuentasae,
  frm_ordenespagolistado, dmordenesdepago, frm_ordenpagoae, frm_cargavalores,
  dmvalores, frm_pagocomprobantes, frm_tuglocalidades, dmlocalidades, 
frm_localidadae;

{$R *.res}

begin
  Application.Title:='Gestión de Transportes Verticales';
  Application.Initialize;
  Application.CreateForm(TDM_Conexion, DM_Conexion);
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Clientes, DM_Clientes);
  Application.CreateForm(TDM_EdicionTUGs, DM_EdicionTUGs);
  Application.CreateForm(TDM_BuscarCliente, DM_BuscarCliente);
  Application.CreateForm(TDM_Equipos, DM_Equipos);
  Application.CreateForm(TDM_Presupuestos, DM_Presupuestos);
  Application.CreateForm(TDM_OrdenesTrabajo, DM_OrdenesTrabajo);
  Application.CreateForm(Tdm_reclamos, dm_reclamos);
  Application.CreateForm(TDM_Remitos, DM_Remitos);
  Application.CreateForm(TDM_CAJA, DM_CAJA);
  Application.CreateForm(TDM_Proveedores, DM_Proveedores);
  Application.CreateForm(TDM_ClientesPotenciales, DM_ClientesPotenciales);
  Application.CreateForm(TDM_BuscarPersonaEmpresa, DM_BuscarPersonaEmpresa);
  Application.CreateForm(TDM_Cheques, DM_Cheques);
  Application.CreateForm(TDM_Compras, DM_Compras);
  Application.CreateForm(TDM_PlanDeCuentas, DM_PlanDeCuentas);
  Application.CreateForm(TDM_OrdenesDePago, DM_OrdenesDePago);
  Application.CreateForm(TDM_Valores, DM_Valores);
  Application.CreateForm(TDM_Localidades, DM_Localidades);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

