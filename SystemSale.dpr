program SystemSale;

uses
  Vcl.Forms,
  uFrmSale in 'src\views\uFrmSale.pas' {frmSale},
  uClient_Model in 'src\models\uClient_Model.pas',
  uProduct_Model in 'src\models\uProduct_Model.pas',
  uSale_Model in 'src\models\uSale_Model.pas',
  uSale_Item_Model in 'src\models\uSale_Item_Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSale, frmSale);
  Application.Run;
end.
