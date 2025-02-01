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
    Panel1: TPanel;
    edtCodProduct: TEdit;
    Label5: TLabel;
    btnSearchProduct: TSpeedButton;
    Panel2: TPanel;
    edtDescProduct: TEdit;
    Label6: TLabel;
    Panel7: TPanel;
    Label7: TLabel;
    edtQtdeProduct: TEdit;
    GroupBox2: TGroupBox;
    Panel4: TPanel;
    Label4: TLabel;
    btnImportSale: TSpeedButton;
    SpeedButton4: TSpeedButton;
    edtImportSale: TEdit;
    Panel5: TPanel;
    Label2: TLabel;
    edtNameClient: TEdit;
    Panel6: TPanel;
    Label12: TLabel;
    cbbCondPayment: TComboBox;
    Panel3: TPanel;
    Label1: TLabel;
    btnSearcClient: TSpeedButton;
    edtCodClient: TEdit;
    Panel8: TPanel;
    Label8: TLabel;
    edtVlrUnitProduc: TEdit;
    Panel9: TPanel;
    Label9: TLabel;
    edtVlrTotalProduct: TEdit;
    Panel10: TPanel;
    Label3: TLabel;
    dtDateSale: TDateTimePicker;
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
    Panel11: TPanel;
    Label14: TLabel;
    Shape11: TShape;
    Label15: TLabel;
    memProductsid: TIntegerField;
    memProductsIdVenda: TIntegerField;
    memProductsIdProduto: TIntegerField;
    memProductsQtde: TBCDField;
    memProductsVlrUnitario: TBCDField;
    memProductsVlrTotal: TBCDField;
    memProductsDescricaoProduto: TWideStringField;
    Panel12: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    memProductsIndex: TIntegerField;
    procedure btnSearchProductClick(Sender: TObject);
    procedure edtQtdeProductKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtQtdeProductExit(Sender: TObject);
    procedure edtCodProductKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSearcClientClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodClientKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInsertProductClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
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

  public
    { Public declarations }
  end;

var
  frmSale: TfrmSale;

implementation

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

procedure TfrmSale.edtQtdeProductExit(Sender: TObject);
begin
  pCalcTotalProd();
end;

procedure TfrmSale.edtQtdeProductKeyDown(Sender: TObject; var Key: Word;
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
  edtCodClient.SetFocus();
end;

procedure TfrmSale.pCalcTotalProd;
begin
  edtVlrTotalProduct.Text := formatFloat('#,##0.00', strToCurrDef(edtVlrUnitProduc.Text, 0) * strToCurrDef(edtQtdeProduct.Text, 0));
end;

procedure TfrmSale.pClearProdSelected;
begin
  edtDescProduct.Text     := '';
  edtCodProduct.Text      := '';
  edtVlrUnitProduc.Text   := '0,00';
  edtVlrTotalProduct.Text := '0,00';
  edtQtdeProduct.Text     := '1,00';

  edtCodProduct.SetFocus();
end;

procedure TfrmSale.pInsertItem;
var index: integer;
begin
  try
    if not memProducts.Active then
      memProducts.Open;

    memProducts.Append;
    memProductsIdProduto.AsInteger := StrToInt(edtCodProduct.Text);
    memProductsQtde.AsFloat        := StrToCurr(edtQtdeProduct.Text);
    memProductsVlrUnitario.AsFloat := StrToCurr(edtVlrUnitProduc.Text);
    memProductsVlrTotal.AsFloat    := StrToCurr(edtVlrTotalProduct.Text);

    index := Sale.pNewItem;

    sale.Items[index].IdProduto   := memProductsIdProduto.AsInteger;
    sale.Items[index].Qtde        := memProductsQtde.AsFloat;
    sale.Items[index].VlrUnitario := memProductsVlrUnitario.AsFloat;
    sale.Items[index].VlrTotal    := memProductsVlrTotal.AsFloat;

    memProductsIndex.AsInteger := index;

    memProducts.Post;

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
  if fGetNumerics(edtCodProduct.Text) = '' then
  begin
    pSearchProductAll();
    Exit;
  end;

  try
    product := TProductController.Create(dm.fdConn);

    product.Id := StrToIntDef(edtCodProduct.Text, 0);
    product.pCarregar;

    if product.Id > 0 then
    begin
      edtDescProduct.Text     := product.Descricao;
      edtVlrUnitProduc.Text   := formatFloat('#,##0.00', Product.VlrVenda);
      edtVlrTotalProduct.Text := formatFloat('#,##0.00', Product.VlrVenda);

      edtQtdeProduct.SetFocus;
      edtQtdeProduct.SelectAll;
    end
    else
      ShowMessage('Produto não Localizado!');

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
    client.pCarregar;

    if client.Id > 0 then
    begin
      edtNameClient.Text := client.Nome;
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

procedure TfrmSale.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSale.SpeedButton4Click(Sender: TObject);
var
  index: Integer;
begin
  try
    Sale.Id := StrToIntDef(edtImportSale.Text, 0);
    Sale.pCarregar();

    memProducts.Close;
    memProducts.Open;

    for index := 0 to Sale.Items.Count -1 do
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

      memProducts.Post
    end;

  except
    on e: exception do
    begin
      pSaveLog(e.Message);
    end;
  end;
end;

procedure TfrmSale.btnSearchProductClick(Sender: TObject);
begin
  pSearchProductAll();
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
