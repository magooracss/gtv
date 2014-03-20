unit frm_about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, ZDataset, db;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    qVersionBDIDVALOR: TLongintField;
    qVersionBDNOMBRE: TStringField;
    qVersionBDVALORINT: TLongintField;
    qVersionBDVALORSTR: TStringField;
    SpeedButton1: TSpeedButton;
    Version: TStaticText;
    qVersionBD: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    function VersionBD: String;
  public
    { public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation
{$R *.lfm}
uses
 versioninfo

 ;

{ TfrmAbout }

procedure TfrmAbout.FormShow(Sender: TObject);
Var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  Version.Caption := ' Versiones >>> PRG: ' + NroVersion + '  BD: ' + VersionBD;
end;

procedure TfrmAbout.SpeedButton1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
  close;
end;

function TfrmAbout.VersionBD: String;
begin
  with qVersionBD do
  begin
    if active then close;
    Open;
    if RecordCount > 0 then
      Result:= IntToStr (qVersionBDVALORINT.AsInteger)
    else
      Result:= '--';
    close;
  end;
end;

end.

