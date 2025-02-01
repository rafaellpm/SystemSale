unit uFrm_Search_Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, uFunctions;

type
  TfrmSearchBase = class(TForm)
    GroupBox1: TGroupBox;
    edtSearch: TEdit;
    btnSearch: TSpeedButton;
    memSearch: TFDMemTable;
    dsSearch: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    btnClose: TSpeedButton;
    Label1: TLabel;
    lblTotalRegistro: TLabel;
    Label3: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure SetResult;
    { Private declarations }
  public
    { Public declarations }
    returnId: Integer;

  end;

var
  frmSearchBase: TfrmSearchBase;

implementation

{$R *.dfm}

procedure TfrmSearchBase.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSearchBase.DBGrid1DblClick(Sender: TObject);
begin
  SetResult();
end;

procedure TfrmSearchBase.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SetResult();
end;

procedure TfrmSearchBase.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnSearch.Click();
end;

procedure TfrmSearchBase.SetResult;
begin
  returnId := memSearch.FieldByName('id').AsInteger;
  ModalResult := mrOk;
end;

procedure TfrmSearchBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
  else if Key = VK_RETURN then
    Perform(WM_NextDlgCtl,0,0);
end;

procedure TfrmSearchBase.Label3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pMoveForm(Self, Button);
end;

procedure TfrmSearchBase.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pMoveForm(Self, Button);
end;

end.
