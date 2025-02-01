unit uSale_Controller;

interface

uses uSale_Model, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils, System.Generics.Collections,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,  FireDAC.DApt,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, uFunctions_DB, uFunctions, uSale_Item_Controller;

type TSaleController = class(TSaleModel)
  private
    fdConn : TFDConnection;
    procedure pGravarItems;
    function pLoadItems: Integer;
  public
    Items : TList<TSaleItemController>;

    procedure pCadastrar();
    procedure pCarregar();
    procedure pAtualizar();


    function fGetAll(dataInicial, dataFinal: TDateTime; nomeCliente: string = ''): TFDQuery;
    function pNewItem(): Integer;

    constructor Create(iFdConn:TFDConnection);
end;

implementation

{ TSaleController }

constructor TSaleController.Create(iFdConn: TFDConnection);
begin
  fdConn := iFdConn;
  Items  := TList<TSaleItemController>.Create;
end;

function TSaleController.fGetAll(dataInicial, dataFinal: TDateTime; nomeCliente: string = ''): TFDQuery;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM venda AS v');
    qryCons.SQL.Add('INNER JOIN clientes AS c ON v.id_cliente = c.id ');
    qryCons.SQL.Add('WHERE (v.data BETWEEN :dataInicial AND :dataFinal)');
    qryCons.ParamByName('dataInicial').AsDate := dataInicial;
    qryCons.ParamByName('dataFinal').AsDate := dataFinal;

    if Id > 0 then
    begin
      qryCons.SQL.Add('AND id = :id');
      qryCons.ParamByName('id').AsInteger := Id;
    end
    else
    begin
      qryCons.SQL.Add('AND c.nome LIKE :nome');
      qryCons.ParamByName('nome').AsString := '%' + nomeCliente + '%';
    end;

    qryCons.Open();

    Result := qryCons;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Vendas. Id: ' + Id.ToString());
    end;
  end;
end;

procedure TSaleController.pAtualizar;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('UPDATE venda SET ');
    qryExec.SQL.Add('(id_cliente, data, vlr_total)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:id_cliente, :data, :vlr_total)');
    qryExec.SQL.Add('WHERE id = :id');

    qryExec.ParamByName('id').AsInteger         := Id;
    qryExec.ParamByName('id_cliente').AsInteger := IdCliente;
    qryExec.ParamByName('data').AsDateTime      := Data;
    qryExec.ParamByName('vlr_total').AsFloat    := VlrTotal;

    qryExec.ExecSQL;

    fdConn.Commit;

  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Atualizar Venda: ' + Id.ToString());
    end;
  end;


  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TSaleController.pCadastrar;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('INSERT INTO venda ');
    qryExec.SQL.Add('(id_cliente, data, vlr_total)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:id_cliente, :data, :vlr_total)');

    qryExec.ParamByName('id_cliente').AsInteger := IdCliente;
    qryExec.ParamByName('data').AsDateTime      := Data;
    qryExec.ParamByName('vlr_total').AsFloat    := VlrTotal;

    qryExec.ExecSQL;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Cadastrar Venda');
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
      Raise Exception.Create('Erro ao Capturar ID do Venda');
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TSaleController.pCarregar;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM venda ');
    qryCons.SQL.Add('WHERE id = :id');
    qryCons.ParamByName('id').AsInteger := Id;

    qryCons.Open();

    Id         := qryCons.FieldByName('id').AsInteger;
    IdCliente  := qryCons.FieldByName('id_cliente').AsInteger;
    Data       := qryCons.FieldByName('data').AsDateTime;
    VlrTotal   := qryCons.FieldByName('vlr_total').AsFloat;

  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Carregar Venda. Id: ' + Id.ToString());
    end;
  end;

  if Assigned(qryCons) then
    FreeAndNil(qryCons);
end;

function TSaleController.pLoadItems: Integer;
var qryCons : TFDQuery;
    item    : TSaleItemController;
    index   : integer;
begin
  try
    Items.Clear;

    item := TSaleItemController.Create(fdConn);

    item.IdVenda := Id;
    qryCons := item.fGetAllSale();

    qryCons.First;

    while not qryCons.Eof do
    begin
      index := pNewItem();

      Items[index].Id               := qryCons.FieldByName('id').AsInteger;
      Items[index].IdVenda          := qryCons.FieldByName('id_venda').AsInteger;
      Items[index].IdProduto        := qryCons.FieldByName('id_produto').AsInteger;
      Items[index].DescricaoProduto := qryCons.FieldByName('descricao_produto').AsString;
      Items[index].Qtde             := qryCons.FieldByName('qtde').AsFloat;
      Items[index].VlrUnitario      := qryCons.FieldByName('vlr_unitario').AsFloat;
      Items[index].VlrTotal         := qryCons.FieldByName('vlr_total').AsFloat;

      qryCons.Next;
    end;
  except
    on e: exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Itens da Venda.');
    end;
  end;
end;

function TSaleController.pNewItem: Integer;
begin
  Result := Items.Add(TSaleItemController.Create(fdConn));
end;

procedure TSaleController.pGravarItems();
var
  i: Integer;
  total : Float64;
begin
  for i := 0 to Items.Count -1 do
  begin
    total := Total + Items[i].VlrTotal;

    if Items[i].IdVenda = 0 then
        Items[i].idVenda := Id;

    if Items[i].Id = 0 then
      Items[i].pCadastrar
    else
      Items[i].pAtualizar;
  end;
  VlrTotal := total;
end;

end.
