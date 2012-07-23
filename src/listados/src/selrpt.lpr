program selrpt;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, pack_powerpdf, lazreport, lazreportpdfexport, zcomponent,
  frm_sellistado, dmconexion, SD_Configuracion, frm_busquedaclientes,
  dmbuscarcliente, dmgeneral, dmseleccionlistado, frm_gruporemitos,
  dmgruporemitos;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM_Conexion, DM_Conexion);
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_SeleccionListado, DM_SeleccionListado);
  Application.CreateForm(TfrmSeleccionListado, frmSeleccionListado);
  Application.Run;
end.

