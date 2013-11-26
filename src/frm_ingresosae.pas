unit frm_ingresosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, DbCtrls, StdCtrls, ComCtrls, Buttons, DBZVDateTimePicker, db;

type

  { TfrmIngresoAE }

  TfrmIngresoAE = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ds_ingreso: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    DBZVDateTimePicker1: TDBZVDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmIngresoAE: TfrmIngresoAE;

implementation

{$R *.lfm}

end.

