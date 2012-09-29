program selrpt;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, pack_powerpdf, lazreport, lazreportpdfexport, zcomponent,
  frm_sellistado, dmconexion, SD_Configuracion, frm_busquedaclientes,
  dmbuscarcliente, dmgeneral, frm_proveedoreslistado, frm_proveedoresae,
  dmproveedores, frm_plandecuentasae, dmplandecuentas, frm_plandecuentaslistado,
  dmseleccionlistado, frm_gruporemitos, dmgruporemitos, dmgrupocuentas,
  frm_grupocuentas, frm_grupoproveedores, dmgrupoproveedores,
 frm_grupoprovpendientes, frm_subdiariocompras, frm_subdiariopagos;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM_Conexion, DM_Conexion);
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_SeleccionListado, DM_SeleccionListado);
  Application.CreateForm(TDM_PlanDeCuentas, DM_PlanDeCuentas);
  Application.CreateForm(TDM_Proveedores, DM_Proveedores);
  Application.CreateForm(TDM_GrupoProveedores, DM_GrupoProveedores);
  Application.CreateForm(TDM_GrupoCuentas, DM_GrupoCuentas);
  Application.CreateForm(TDM_BuscarCliente, DM_BuscarCliente);
  Application.CreateForm(TDM_GrupoRemitos, DM_GrupoRemitos);
  Application.CreateForm(TfrmSeleccionListado, frmSeleccionListado);
  Application.Run;
end.

