unit uFrm_Search_Product;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrm_Search_Base, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids, uFunctions,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, uProduct_Controller, daoConnection;

type
  TfrmSearchProduct = class(TfrmSearchBase)
    memSearchId: TIntegerField;
    memSearchDescricao: TWideStringField;
    memSearchVlrVenda: TBCDField;
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchProduct: TfrmSearchProduct;

implementation

{$R *.dfm}

procedure TfrmSearchProduct.btnSearchClick(Sender: TObject);
var products : TProductController;
    qryCons  : TFDquery;
begin
  try
    inherited;

    products := TProductController.Create(dm.fdConn);
    products.Descricao := edtSearch.Text;

    qryCons := products.fGetAll();

    memSearch.CloneCursor(qryCons);

    lblTotalRegistro.Caption := 'Total de Registros: ' + qryCons.RecordCount.ToString();

    FreeAndnil(qryCons);
  except
    on e:exception do
    begin
     ShowMessage(e.Message);
    end;
  end;
end;

end.
