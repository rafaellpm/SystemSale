unit uSale_Controller;

interface

uses uSale_Model, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils, System.Generics.Collections,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,  FireDAC.DApt,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, uFunctions_DB, uFunctions, uSale_Item_Controller, uClient_Controller;

type TSaleController = class(TSaleModel)
  private
    fdConn : TFDConnection;
    procedure pLoadItems;
    procedure pSaveItems;
  public
    Items : TList<TSaleItemController>;
    Client : TClientController;

    procedure pCreate();
    procedure pLoad();
    procedure pClear();
    procedure pUpdate();
    procedure pDelete;


    function fGetTotalSale: Float64;
    function fGetAll(nomeCliente: string= ''): TFDQuery;
    function pNewItem(): Integer;

    constructor Create(iFdConn:TFDConnection);
end;

implementation

{ TSaleController }

constructor TSaleController.Create(iFdConn: TFDConnection);
begin
  fdConn := iFdConn;
  Items  := TList<TSaleItemController>.Create;
  Client := TClientController.Create(iFdConn);
end;

function TSaleController.fGetAll(nomeCliente: string = ''): TFDQuery;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT v.*, c.nome FROM venda AS v FORCE INDEX (idx_id_cliente) ');
    qryCons.SQL.Add('INNER JOIN clientes AS c ON c.id = v.id_cliente ');
    qryCons.SQL.Add('WHERE (CAST(v.data AS DATE) BETWEEN :dataInicial AND :dataFinal)');
    qryCons.ParamByName('dataInicial').AsDate := DateStart;
    qryCons.ParamByName('dataFinal').AsDate := DateEnd;

    if Id > 0 then
    begin
      qryCons.SQL.Add('AND v.id = :id');
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

function TSaleController.fGetTotalSale: Float64;
var
  i: Integer;
begin
  VlrTotal := 0.00;
  for i := 0 to Items.Count -1 do
  begin
    if not items[i].DeleteProd then
      VlrTotal := VlrTotal + items[i].VlrTotal;
  end;

  Result := VlrTotal;
end;

procedure TSaleController.pUpdate;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('UPDATE venda SET ');
    qryExec.SQL.Add('id_cliente = :id_cliente, vlr_total = :vlr_total');
    qryExec.SQL.Add('WHERE id = :id');

    qryExec.ParamByName('id').AsInteger          := Id;
    qryExec.ParamByName('id_cliente').AsInteger  := IdCliente;
    qryExec.ParamByName('vlr_total').AsFloat     := VlrTotal;

    qryExec.ExecSQL;

    pSaveItems();

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

procedure TSaleController.pClear;
begin
  Id          := 0;
  IdCliente   := 0;
  Data        := Now();
  VlrTotal    := 0;

  Items.Clear;
end;

procedure TSaleController.pCreate;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('INSERT INTO venda ');
    qryExec.SQL.Add('(id_cliente, data, vlr_total)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:id_cliente, :data, :vlr_total)');

    qryExec.ParamByName('id_cliente').AsInteger  := IdCliente;
    qryExec.ParamByName('data').AsDateTime       := Now();
    qryExec.ParamByName('vlr_total').AsFloat     := VlrTotal;

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
    Id := fdConn.ExecSQLScalar('SELECT LAST_INSERT_ID();');

    pSaveItems();

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

procedure TSaleController.pDelete;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('DELETE FROM venda_item');
    qryExec.SQL.Add('WHERE id_venda = :id');
    qryExec.ParamByName('id').AsInteger := Id;

    qryExec.ExecSQL;

    qryExec.Close;
    qryExec.SQL.Clear;
    qryExec.SQL.Add('DELETE FROM venda');
    qryExec.SQL.Add('WHERE id = :id');
    qryExec.ParamByName('id').AsInteger := Id;

    qryExec.ExecSQL;

    fdConn.Commit;

  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      Raise Exception.Create('Erro ao Deletar Venda: ' + Id.ToString());
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);
end;

procedure TSaleController.pLoad;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM venda ');
    qryCons.SQL.Add('WHERE id = :id');
    qryCons.ParamByName('id').AsInteger := Id;

    qryCons.Open();

    Id          := qryCons.FieldByName('id').AsInteger;
    IdCliente   := qryCons.FieldByName('id_cliente').AsInteger;
    Data        := qryCons.FieldByName('data').AsDateTime;
    VlrTotal    := qryCons.FieldByName('vlr_total').AsFloat;

    pLoadItems();

    Client.Id := IdCliente;
    Client.pLoad;

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

procedure TSaleController.pLoadItems;
var qryCons : TFDQuery;
    item    : TSaleItemController;
    index   : integer;
    total   : Float64;
begin
  try
    total := 0.00;
    Items.Clear;

    item := TSaleItemController.Create(fdConn);

    item.IdVenda := Id;
    qryCons := item.fGetAllSale();

    qryCons.First;

    while not qryCons.Eof do
    begin
      index := pNewItem();

      Items[index].Id := qryCons.FieldByName('id').AsInteger;
      Items[index].pLoad;

      total := total + Items[index].VlrTotal;

      qryCons.Next;
    end;

    VlrTotal := total;
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

procedure TSaleController.pSaveItems();
var
  i: Integer;
begin
  for i := 0 to Items.Count -1 do
  begin
    if Items[i].IdVenda = 0 then
        Items[i].idVenda := Id;


    if (Items[i].Id = 0) and (not Items[i].DeleteProd) then
      Items[i].pCreate
    else
    if (Items[i].Id > 0) and Items[i].DeleteProd then
      Items[i].pDelete
    else
      Items[i].pUpdate;
  end;
end;


end.
