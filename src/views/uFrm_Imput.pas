unit uFrm_Imput;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmImputValue = class(TForm)
    GroupBox1: TGroupBox;
    pnlQtdeProduct: TPanel;
    Shape6: TShape;
    edtResult: TEdit;
    lblTitle: TLabel;
    btnConfirm: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtResultKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
  private
    FResult: Variant;
    FTitle: string;
    procedure SetTitle(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property ResultValue: Variant read FResult;
    property Title: string read FTitle write SetTitle;
  end;

function fGetRequest(Title: string): Variant;

var
  frmImputValue: TfrmImputValue;

implementation

uses
  uFunctions;

{$R *.dfm}

{ TForm1 }

procedure TfrmImputValue.edtResultKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnConfirm.Click()
  else
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmImputValue.FormShow(Sender: TObject);
begin
  lblTitle.Caption := Title;
end;

procedure TfrmImputValue.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

procedure TfrmImputValue.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImputValue.btnConfirmClick(Sender: TObject);
begin
  if edtResult.Text <> '' then
  begin
    FResult := edtResult.Text;
    ModalResult := mrOk;
  end
  else
    ShowMessage('Preencha o campo!');
end;

function fGetRequest(Title: string): Variant;
begin
  try
    if not Assigned(frmImputValue) then
      frmImputValue := TfrmImputValue.Create(nil);

    frmImputValue.Title := Title;
    frmImputValue.ShowModal();

    Result := frmImputValue.ResultValue;

    FreeAndNil(frmImputValue);
  except
    on e: exception do
    begin
      pSaveLog(e.Message);
    end;
  end;
end;

end.
