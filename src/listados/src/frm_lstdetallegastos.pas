unit frm_lstdetallegastos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, PReport;

type

  { TForm1 }

  Tfrm_LstPDFDetalleGastos = class(TForm)
    pdfDetalleGastos: TPReport;
    PRLabel1: TPRLabel;
    edPeriodo: TPRLabel;
    PRLayoutPanel1: TPRLayoutPanel;
    PRPage1: TPRPage;
    procedure PRPage1PrintPage(Sender: TObject; ACanvas: TPRCanvas);
  private
    { private declarations }
  public
    procedure AjustarPeriodo (fechaIni, fechaFin: TDate);
  end; 

var
  frm_LstPDFDetalleGastos: Tfrm_LstPDFDetalleGastos;

implementation

{$R *.lfm}

{ TForm1 }


{ TForm1 }

procedure Tfrm_LstPDFDetalleGastos.PRPage1PrintPage(Sender: TObject; ACanvas: TPRCanvas);
begin
end;

procedure Tfrm_LstPDFDetalleGastos.AjustarPeriodo(fechaIni, fechaFin: TDate);
begin
  edPeriodo.Caption:= 'Periodo: ' + DateToStr(fechaIni) + ' - ' + DateToStr(fechaFin);
end;

end.

