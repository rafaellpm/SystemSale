unit uFunctions;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids;

  procedure pSaveLog(iText: string);
  function fGetCurrentDir(): string;

  function pMoveForm(Sender: TObject; Button: TMouseButton): string;
  function fValueNumeric(iValue: string): Boolean;
  function fGetNumerics(iValue: string): string;

implementation

procedure pSaveLog(iText: string);
var log : TStringList;
    dateNow, dir: string;
begin
  log := TStringList.Create;

  dateNow := FormatDateTime('dd-MM-yyyy', Now);

  dir := fGetCurrentDir + 'log\' + dateNow;

  if not DirectoryExists(dir) then
    ForceDirectories(dir);

  log.LoadFromFile(dir+'\log.txt');

  log.Add(FormatDateTime('dd-MM-yyyy hh:mm:ss', Now) + ' - ' + iText);

  log.SaveToFile(dir+'\log.txt');

end;

function fGetCurrentDir(): string;
begin
  result := ExtractFilePath(ParamStr(0));
end;

function pMoveForm(Sender: TObject; Button: TMouseButton): string;
var position: TPoint;
begin
  if Sender is TForm then
  begin
    if Button = mbLeft then
    begin
      position := Mouse.CursorPos;
      ReleaseCapture;
      (Sender as TForm).Perform(WM_NCLBUTTONDOWN, HTCAPTION, 0);
    end;
  end
  else
    ShowMessage('Não Permitido Mover.');
end;

function fValueNumeric(iValue: string): Boolean;
var index : Integer;
begin
  for index := 1 to Length(iValue) do
  begin
    if not (iValue[index] in ['0'..'9']) then
    begin
      Result := False;
      Break;
    end
  end;
end;

function fGetNumerics(iValue: string): string;
var index : Integer;
begin
  Result := '';
  for index := 1 to Length(iValue) do
  begin
    if (iValue[index] in ['0'..'9']) then
    begin
      Result := Result + iValue[index];
    end;
  end;
end;

end.
