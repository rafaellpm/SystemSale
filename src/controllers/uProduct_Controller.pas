unit uProduct_Controller;

interface


uses uProduct_Model, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.DApt,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, uFunctions_DB, uFunctions;

type TProductController = class(TProductModel)
  private
    fdConn : TFDConnection;
  public
    procedure pCreate();
    procedure pLoad();
    procedure pUpdate();

    function fGetAll(): TFDQuery;

    constructor Create(iFdConn:TFDConnection);
end;

implementation

{ TProductController }

constructor TProductController.Create(iFdConn: TFDConnection);
begin
  fdConn := iFdConn;
end;

function TProductController.fGetAll: TFDQuery;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM produtos');

    if Id > 0 then
    begin
      qryCons.SQL.Add('WHERE id = :id');
      qryCons.ParamByName('id').AsInteger := Id;
    end
    else
    begin
      qryCons.SQL.Add('WHERE descricao LIKE :descricao');
      qryCons.ParamByName('descricao').AsString := '%' + descricao + '%';
    end;

    qryCons.Open();

    Result := qryCons;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Produtos. Id: ' + Id.ToString());
    end;
  end;
end;

procedure TProductController.pUpdate;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('UPDATE produtos SET ');
    qryExec.SQL.Add('(descricao, vlr_venda)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:descricao, :vlr_venda)');
    qryExec.SQL.Add('WHERE id = :id');

    qryExec.ParamByName('id').AsInteger       := Id;
    qryExec.ParamByName('descricao').AsString := Descricao;
    qryExec.ParamByName('vlr_venda').AsFloat  := VlrVenda;

    qryExec.ExecSQL;

    fdConn.Commit;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Atualizar Produto: ' + Id.ToString());
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TProductController.pCreate;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;
    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('INSERT INTO produtos ');
    qryExec.SQL.Add('(descricao, vlr_venda)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:descricao, :vlr_venda)');

    qryExec.ParamByName('descricao').AsString := Descricao;
    qryExec.ParamByName('vlr_venda').AsFloat  := VlrVenda;

    qryExec.ExecSQL;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Cadastrar Produto');
    end;
  end;

  try
    Id := fdConn.ExecSQLScalar('SELECT LAST_INSERT_ID();');

    fdConn.Commit;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Capturar ID do Produto');
    end;
  end;


  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TProductController.pLoad;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM produtos ');
    qryCons.SQL.Add('WHERE id = :id');
    qryCons.ParamByName('id').AsInteger := Id;

    qryCons.Open();

    Id        := qryCons.FieldByName('id').AsInteger;
    Descricao := qryCons.FieldByName('descricao').AsString;
    VlrVenda  := qryCons.FieldByName('vlr_venda').AsFloat;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Produto. Id: ' + Id.ToString());
    end;
  end;

  if Assigned(qryCons) then
    FreeAndNil(qryCons);
end;

end.
