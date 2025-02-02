program SystemSale;

uses
  Vcl.Forms,
  uFrm_Sale in 'src\views\uFrm_Sale.pas' {frmSale},
  uClient_Model in 'src\models\uClient_Model.pas',
  uProduct_Model in 'src\models\uProduct_Model.pas',
  uSale_Model in 'src\models\uSale_Model.pas',
  uSale_Item_Model in 'src\models\uSale_Item_Model.pas',
  daoConnection in 'src\dao\daoConnection.pas' {dm: TDataModule},
  uClient_Controller in 'src\controllers\uClient_Controller.pas',
  uFunctions_DB in 'src\functions\uFunctions_DB.pas',
  uFunctions in 'src\functions\uFunctions.pas',
  uProduct_Controller in 'src\controllers\uProduct_Controller.pas',
  uSale_Controller in 'src\controllers\uSale_Controller.pas',
  uSale_Item_Controller in 'src\controllers\uSale_Item_Controller.pas',
  uFrm_Search_Base in 'src\views\uFrm_Search_Base.pas' {frmSearchBase},
  uFrm_Search_Product in 'src\views\uFrm_Search_Product.pas' {frmSearchProduct},
  uFrm_Search_Client in 'src\views\uFrm_Search_Client.pas' {frmSearchClient},
  uFrm_Search_Sale in 'src\views\uFrm_Search_Sale.pas' {frmSearchSale},
  uFrm_Imput in 'src\views\uFrm_Imput.pas' {frmImputValue};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmSale, frmSale);
  Application.Run;
end.
