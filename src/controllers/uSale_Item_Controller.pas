unit uSale_Item_Controller;

interface


uses uSale_Item_Model, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,  FireDAC.DApt,
  Data.DB, FireDAC.Comp.Client, uFunctions_DB, uFunctions;

type TSaleItemController = class(TSaleItemModel)
  private
    fdConn : TFDConnection;
  public
    procedure pCadastrar();
    procedure pCarregar();
    procedure pAtualizar();

    function fGetAllSale(): TFDQuery;

    constructor Create(iFdConn:TFDConnection);
end;

implementation

{ TSaleItemController }

constructor TSaleItemController.Create(iFdConn: TFDConnection);
begin
  fdConn := iFdConn;
end;

function TSaleItemController.fGetAllSale: TFDQuery;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM venda_item ');
    qryCons.SQL.Add('WHERE id_venda = :id_venda');
    qryCons.ParamByName('id_venda').AsInteger := IdVenda;

    qryCons.Open();

    Result := qryCons;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Itens da Venda. Id: ' + Id.ToString());
    end;
  end;
end;

procedure TSaleItemController.pAtualizar;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('UPDATE venda_item SET ');
    qryExec.SQL.Add('(id_venda, id_produto, descricao_produto, qtde, vlr_unitario, vlr_total)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:id_venda, :id_produto, :descricao_produto, :qtde, :vlr_unitario, :vlr_total)');
    qryExec.SQL.Add('WHERE id = :id');

    qryExec.ParamByName('id').AsInteger               := Id;
    qryExec.ParamByName('id_venda').AsInteger         := IdVenda;
    qryExec.ParamByName('id_produto').AsInteger       := IdProduto;
    qryExec.ParamByName('descricao_produto').AsString := DescricaoProduto;
    qryExec.ParamByName('qtde').AsFloat               := Qtde;
    qryExec.ParamByName('vlr_unitario').AsFloat       := VlrUnitario;
    qryExec.ParamByName('vlr_total').AsFloat          := VlrTotal;

    qryExec.ExecSQL;

    fdConn.Commit;

  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Atualizar VendaItem: ' + Id.ToString());
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TSaleItemController.pCadastrar;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('INSERT INTO venda_item ');
    qryExec.SQL.Add('(id_venda, id_produto, descricao_produto, qtde, vlr_unitario, vlr_total)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:id_venda, :id_produto, :descricao_produto, :qtde, :vlr_unitario, :vlr_total)');

    qryExec.ParamByName('id_venda').AsInteger   := IdVenda;
    qryExec.ParamByName('id_produto').AsInteger := IdProduto;
    qryExec.ParamByName('descricao_produto').AsString := DescricaoProduto;
    qryExec.ParamByName('qtde').AsFloat         := Qtde;
    qryExec.ParamByName('vlr_unitario').AsFloat := VlrUnitario;
    qryExec.ParamByName('vlr_total').AsFloat    := VlrTotal;

    qryExec.ExecSQL;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Cadastrar venda_item');
    end;
  end;

  try
    Id := fdConn.ExecSQL('SELECT LAST_INSERT_ID();');

    fdConn.Commit;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Capturar ID do venda_item');
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TSaleItemController.pCarregar;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM venda_item ');
    qryCons.SQL.Add('WHERE id = :id');
    qryCons.ParamByName('id').AsInteger := Id;

    qryCons.Open();

    Id               := qryCons.FieldByName('id').AsInteger;
    IdVenda          := qryCons.FieldByName('id_venda').AsInteger;
    IdProduto        := qryCons.FieldByName('id_produto').AsInteger;
    DescricaoProduto := qryCons.FieldByName('descricao_produto').AsString;
    Qtde             := qryCons.FieldByName('qtde').AsFloat;
    VlrUnitario      := qryCons.FieldByName('vlr_unitario').AsFloat;
    VlrTotal         := qryCons.FieldByName('vlr_total').AsFloat;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Carregar venda_item. Id: ' + Id.ToString());
    end;
  end;

  if Assigned(qryCons) then
    FreeAndNil(qryCons);
end;

end.
