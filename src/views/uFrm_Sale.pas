unit uFrm_Sale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uFrm_Search_Product,
  Vcl.ComCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, uProduct_Controller, daoConnection,
  uFunctions, uSale_Controller, uFrm_Search_Client, uClient_Controller;

type
  TfrmSale = class(TForm)
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    btnInsertProduct: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    memProducts: TFDMemTable;
    dsProducts: TDataSource;
    Label13: TLabel;
    pnlCodProduct: TPanel;
    edtCodProduct: TEdit;
    Label5: TLabel;
    btnSearchProduct: TSpeedButton;
    pnlDescProduct: TPanel;
    edtDescProduct: TEdit;
    Label6: TLabel;
    pnlQtdeProduct: TPanel;
    Label7: TLabel;
    edtQtdeProduct: TEdit;
    GroupBox2: TGroupBox;
    pnlCodSale: TPanel;
    Label4: TLabel;
    btnSearchSale: TSpeedButton;
    edtCodSale: TEdit;
    pnlNameClient: TPanel;
    Label2: TLabel;
    edtNameClient: TEdit;
    pnlCondPayment: TPanel;
    Label12: TLabel;
    cbbCondPayment: TComboBox;
    pnlCodClient: TPanel;
    Label1: TLabel;
    btnSearcClient: TSpeedButton;
    edtCodClient: TEdit;
    pnlVlrUnitProduct: TPanel;
    Label8: TLabel;
    edtVlrUnitProduc: TEdit;
    pnlVlrTotalProduct: TPanel;
    Label9: TLabel;
    edtVlrTotalProduct: TEdit;
    pnlDateSale: TPanel;
    Label3: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    pnlVlrTotalSale: TPanel;
    Label14: TLabel;
    Shape11: TShape;
    lblTotalSale: TLabel;
    memProductsid: TIntegerField;
    memProductsIdVenda: TIntegerField;
    memProductsIdProduto: TIntegerField;
    memProductsQtde: TBCDField;
    memProductsVlrUnitario: TBCDField;
    memProductsVlrTotal: TBCDField;
    memProductsDescricaoProduto: TWideStringField;
    Panel12: TPanel;
    btnSaveSale: TSpeedButton;
    btnExit: TSpeedButton;
    memProductsIndex: TIntegerField;
    lblDateSale: TLabel;
    btnClear: TSpeedButton;
    btnCancelSale: TSpeedButton;
    btnImport: TSpeedButton;
    procedure btnSearchProductClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodProductKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSearcClientClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodClientKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInsertProductClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveSaleClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtVlrUnitProducExit(Sender: TObject);
    procedure edtVlrUnitProducKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSearchSaleClick(Sender: TObject);
    procedure edtCodSaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdeProductExit(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnCancelSaleClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }
    Sale : TSaleController;

    procedure pLoadProductSelected;
    procedure pClearProdSelected;
    procedure pSearchProductAll;

    procedure pLoadClientSelected;
    procedure pSearchClientAll;

    procedure pCalcTotalProd;
    procedure pInsertItem;
    procedure pEditProduct;
    procedure pDeleteProduct;
    
    procedure pInitialize();
    procedure pSearchSaleAll;
    procedure pImportSale;
    procedure pUpdateTotalSale;

  public
    { Public declarations }
  end;

var
  frmSale: TfrmSale;

implementation

uses
  uFrm_Search_View, uFrm_Imput;

{$R *.dfm}

procedure TfrmSale.edtCodClientKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    pLoadClientSelected();
end;

procedure TfrmSale.edtCodProductKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    pLoadProductSelected();
end;

procedure TfrmSale.edtCodSaleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    pImportSale();
  end;
end;

procedure TfrmSale.edtQtdeProductExit(Sender: TObject);
begin
  pCalcTotalProd();
end;

procedure TfrmSale.edtVlrUnitProducExit(Sender: TObject);
begin
  pCalcTotalProd();
end;

procedure TfrmSale.edtVlrUnitProducKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    pCalcTotalProd();

    if StrToCurrDef(edtCodProduct.Text, 0) > 0 then
    begin
      btnInsertProduct.Click();
      pClearProdSelected();
    end;
  end;
end;

procedure TfrmSale.FormCreate(Sender: TObject);
begin
  Sale := TSaleController.Create(dm.fdConn);
end;

procedure TfrmSale.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Perform(WM_NextDlgCtl,0,0);
end;

procedure TfrmSale.FormShow(Sender: TObject);
begin
  pInitialize();
end;

procedure TfrmSale.pCalcTotalProd;
begin
  edtVlrTotalProduct.Text := formatFloat('#,##0.00', strToCurrDef(edtVlrUnitProduc.Text, 0) * strToCurrDef(edtQtdeProduct.Text, 0));
end;

procedure TfrmSale.pInitialize;
begin
  edtDescProduct.Text     := '';
  edtCodProduct.Text      := '';
  edtVlrUnitProduc.Text   := '0,00';
  edtVlrTotalProduct.Text := '0,00';
  edtQtdeProduct.Text     := '1,00';

  edtCodClient.Enabled := True;
  edtCodClient.Text    := '';
  edtNameClient.Text   := '';
  edtCodClient.SetFocus();

  memProducts.Close;

  lblTotalSale.Caption     := '0,00';
  lblDateSale.Caption      := FormatDateTime('dd/MM/yyyy hh:mm:ss', Now());
  cbbCondPayment.ItemIndex := 0;
  edtCodSale.Enabled       := True;
  edtCodSale.Text          := '';

  btnSearchSale.Visible := True;
  pnlCodSale.Enabled    := True;
  btnCancelSale.Visible := True;
  btnImport.Visible     := True;

  Sale.pClear;
end;

procedure TfrmSale.pSearchSaleAll;
begin
  try
    frmSearchSale := TfrmSearchSale.Create(nil);
    frmSearchSale.ShowModal;
  finally
    if frmSearchSale.ModalResult = mrOk then
    begin
      edtCodSale.Text := frmSearchSale.returnId.ToString;
      pImportSale();
    end;
    FreeAndNil(frmSearchSale);
  end;
end;

procedure TfrmSale.pImportSale;
var
  index: Integer;
begin
  if StrToIntDef(edtCodSale.Text, 0) = 0 then
    Exit;

  try
    if Sale.Id = 0 then
    begin
      Sale.Id := StrToIntDef(edtCodSale.Text, 0);
      Sale.pLoad;

      if Sale.Id = 0 then
      begin
        ShowMessage('Venda Não Localizada!');
        edtCodSale.Text := '';
        edtCodClient.SetFocus;
        exit;
      end;

      edtCodSale.Enabled   := Sale.Id = 0;
      edtCodClient.Enabled := True;
      edtCodClient.Text    := Sale.IdCliente.ToString;
      edtNameClient.Text   := Sale.NomeCliente;
      lblDateSale.Caption  := FormatDateTime('dd/MM/yyyy hh:mm:ss', Sale.Data);

      pUpdateTotalSale();

      memProducts.Close;
      memProducts.Open;

      for index := 0 to Sale.Items.Count - 1 do
      begin
        memProducts.Append;

        memProductsId.AsInteger              := Sale.Items[index].Id;
        memProductsIdVenda.AsInteger         := Sale.Items[index].IdVenda;
        memProductsIdProduto.AsInteger       := Sale.Items[index].IdProduto;
        memProductsDescricaoProduto.AsString := Sale.Items[index].DescricaoProduto;
        memProductsQtde.AsFloat              := Sale.Items[index].Qtde;
        memProductsVlrUnitario.AsFloat       := Sale.Items[index].VlrUnitario;
        memProductsVlrTotal.AsFloat          := Sale.Items[index].VlrTotal;
        memProductsIndex.AsInteger           := index;

        memProducts.Post;
      end;
      edtCodProduct.SetFocus;
    end
    else
      ShowMessage('Venda Já em Andamento!');
  except
    on e: exception do
    begin
      pSaveLog(e.Message);
    end;
  end;
end;

procedure TfrmSale.pUpdateTotalSale;
begin
  lblTotalSale.Caption := FormatFloat('#,##0.00', Sale.fGetTotalSale);
end;

procedure TfrmSale.pClearProdSelected;
begin
  edtDescProduct.Text     := '';
  edtCodProduct.Text      := '';
  edtCodProduct.Enabled   := True;
  edtVlrUnitProduc.Text   := '0,00';
  edtVlrTotalProduct.Text := '0,00';
  edtQtdeProduct.Text     := '1,00';

  edtCodProduct.SetFocus;
end;

procedure TfrmSale.pDeleteProduct;
begin
  if MessageDlg('Tem Certeza que deseja Excluir o Item?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    Sale.Items[memProductsIndex.AsInteger].DeleteProd := True;
    memProducts.Delete;

    pUpdateTotalSale;
  end;
end;

procedure TfrmSale.pEditProduct;
begin
  if memProducts.Active then
  begin
    edtCodProduct.Tag       := memProductsIndex.AsInteger;
    edtCodProduct.Text      := IntToStr(memProductsIdProduto.AsInteger);
    edtCodProduct.Enabled   := False;
    edtDescProduct.Text     := memProductsDescricaoProduto.AsString;
    edtVlrUnitProduc.Text   := FormatFloat('#,##0.00', memProductsVlrUnitario.AsFloat);
    edtVlrTotalProduct.Text := FormatFloat('#,##0.00', memProductsVlrTotal.AsFloat);
    edtQtdeProduct.Text     := FormatFloat('#,##0.00', memProductsQtde.AsFloat);

    edtQtdeProduct.SetFocus;
  end;
end;

procedure TfrmSale.pInsertItem;
var index: integer;
begin
  try
    if not memProducts.Active then
      memProducts.Open;

    if edtCodProduct.Tag = 0 then
    begin
      index := Sale.pNewItem;
      memProducts.Append;

      memProductsIdProduto.AsInteger       := StrToInt(edtCodProduct.Text);
      memProductsDescricaoProduto.AsString := edtDescProduct.Text;

      sale.Items[index].IdProduto        := memProductsIdProduto.AsInteger;
      sale.Items[index].DescricaoProduto := memProductsDescricaoProduto.AsString;

    end
    else
    begin
      index := edtCodProduct.Tag;
      memProducts.Edit;
    end;

    memProductsQtde.AsFloat              := StrToCurr(edtQtdeProduct.Text);
    memProductsVlrUnitario.AsFloat       := StrToCurr(edtVlrUnitProduc.Text);
    memProductsVlrTotal.AsFloat          := StrToCurr(edtVlrTotalProduct.Text);


    sale.Items[index].Qtde             := memProductsQtde.AsFloat;
    sale.Items[index].VlrUnitario      := memProductsVlrUnitario.AsFloat;
    sale.Items[index].VlrTotal         := memProductsVlrTotal.AsFloat;

    pUpdateTotalSale;

    memProductsIndex.AsInteger := index;

    memProducts.Post;

    edtCodProduct.Enabled := true;
    edtCodProduct.Tag     := 0;

  except
    on e: exception do
    begin
      pSaveLog(e.Message);
    end;
  end;
end;

procedure TfrmSale.pLoadProductSelected;
var product : TProductController;
begin
  if fGetNumerics(edtCodClient.Text) = '' then
  begin
    ShowMessage('Selecione o Cliente antes de Continuar!');
    edtCodClient.SetFocus;
    Abort;
  end;

  if fGetNumerics(edtCodProduct.Text) = '' then
  begin
    pSearchProductAll();
    Exit;
  end;

  try
    product := TProductController.Create(dm.fdConn);
    product.Id := StrToIntDef(edtCodProduct.Text, 0);
    product.pLoad;

    if product.Id > 0 then
    begin
      edtDescProduct.Text     := product.Descricao;
      edtVlrUnitProduc.Text   := formatFloat('#,##0.00', Product.VlrVenda);
      edtVlrTotalProduct.Text := formatFloat('#,##0.00', Product.VlrVenda);

      edtQtdeProduct.SetFocus;
      edtQtdeProduct.SelectAll;
    end
    else
    begin
      ShowMessage('Produto não Localizado!');
      edtCodProduct.SetFocus;
      edtCodProduct.SelectAll;
    end;

  finally
    FreeAndNil(product);
  end;
end;

procedure TfrmSale.pLoadClientSelected;
var client : TClientController;
begin
  if fGetNumerics(edtCodClient.Text) = '' then
  begin
    pSearchClientAll();
    Exit;
  end;

  try
    client := TClientController.Create(dm.fdConn);

    client.Id := StrToIntDef(edtCodClient.Text, 0);
    client.pLoad;

    if client.Id > 0 then
    begin
      edtNameClient.Text := client.Nome;
      Sale.IdCliente     := client.Id;
      Sale.NomeCliente   := client.Nome;

      btnSearchSale.Visible := false;
      pnlCodSale.Enabled    := false;
      btnCancelSale.Visible := False;
      btnImport.Visible     := False;
    end
    else
      ShowMessage('Cliente não Localizado!');

  finally
    FreeAndNil(client);
  end;
end;

procedure TfrmSale.pSearchClientAll;
begin
  try
    frmSearchClient := TfrmSearchClient.Create(nil);
    frmSearchClient.ShowModal;
  finally
    if frmSearchClient.ModalResult = mrOk then
    begin
      edtCodClient.Text := frmSearchClient.returnId.ToString;
      pLoadClientSelected;
    end;
    FreeAndNil(frmSearchClient);
  end;
end;

procedure TfrmSale.pSearchProductAll;
begin
  if fGetNumerics(edtCodClient.Text) = '' then
  begin
    ShowMessage('Selecione o Cliente antes de Continuar!');
    edtCodClient.SetFocus;
    Abort;
  end;

  try
    frmSearchProduct := TfrmSearchProduct.Create(nil);
    frmSearchProduct.ShowModal;
  finally
    if frmSearchProduct.ModalResult = mrOk then
    begin
      edtCodProduct.Text := frmSearchProduct.returnId.ToString;
      pLoadProductSelected;
    end;
    FreeAndNil(frmSearchProduct);
  end;
end;

procedure TfrmSale.btnSaveSaleClick(Sender: TObject);
begin
  if Sale.Id > 0 then
    Sale.pUpdate()
  else
    Sale.pCreate();

  ShowMessage('Venda Realizada! Nr: ' + Sale.Id.ToString);
  pInitialize;
end;

procedure TfrmSale.btnCancelSaleClick(Sender: TObject);
var nrSale : string;
begin
  nrSale := fGetRequest('Digite o Numero do Pedido a Ser Cancelado!');
  if (nrSale <> '') AND (StrToIntDef(nrSale, 0) > 0) then
  begin
    if MessageDlg('Processo Irreversível. Pedido: . ' + nrSale + #13 + 'Deseja Continuar?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      Sale.Id := StrToIntDef(nrSale, 0);
      Sale.pDelete;
    end;
  end;
end;

procedure TfrmSale.btnClearClick(Sender: TObject);
begin
  if Sale.Id > 0 then
  begin
    if MessageDlg('Pedido em andamento! Pedido/Alterações serão perdidas. ' + #13 + 'Deseja Continuar?', mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes then
      Abort;
  end;

  pInitialize;
end;

procedure TfrmSale.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSale.btnSearchProductClick(Sender: TObject);
begin
  pSearchProductAll();
end;

procedure TfrmSale.DBGrid1DblClick(Sender: TObject);
begin
  pEditProduct();
end;

procedure TfrmSale.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    pEditProduct()
  else
  if Key = VK_DELETE then
    pDeleteProduct();
end;

procedure TfrmSale.btnSearchSaleClick(Sender: TObject);
begin
  pSearchSaleAll();
end;

procedure TfrmSale.btnImportClick(Sender: TObject);
var nrSale : string;
begin
  nrSale := fGetRequest('Digite o Numero do Pedido a Ser Importado!');
  if (nrSale <> '') AND (StrToIntDef(nrSale, 0) > 0) then
  begin
    edtCodSale.Text := nrSale;
    pImportSale();
  end;
end;

procedure TfrmSale.btnInsertProductClick(Sender: TObject);
begin
  if StrToCurrDef(edtCodProduct.Text, 0) > 0 then
  begin
    pInsertItem();
  end;
end;

procedure TfrmSale.btnSearcClientClick(Sender: TObject);
begin
  pSearchClientAll();
end;

end.
