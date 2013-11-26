unit dmingresos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds;

type

  { TDM_Ingresos }

  TDM_Ingresos = class(TDataModule)
    Ingresos: TRxMemoryData;
    IngresoItems: TRxMemoryData;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_Ingresos: TDM_Ingresos;

implementation

{$R *.lfm}

end.

