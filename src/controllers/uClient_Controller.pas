unit uClient_Controller;

interface

uses uClient_Model, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,   FireDAC.DApt,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, uFunctions_DB, uFunctions;

type TClientController = class(TClientModel)
  private
    fdConn : TFDConnection;
  public
    procedure pCadastrar();
    procedure pCarregar();
    procedure pAtualizar();

    function fGetAll(): TFDQuery;

    constructor Create(iFdConn:TFDConnection);

end;

implementation

{ TClientController }

constructor TClientController.Create(iFdConn: TFDConnection);
begin
  fdConn := iFdConn;
end;

function TClientController.fGetAll: TFDQuery;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM clientes ');

    if Id > 0 then
    begin
      qryCons.SQL.Add('WHERE id = :id');
      qryCons.ParamByName('id').AsInteger := Id;
    end
    else
    begin
      qryCons.SQL.Add('WHERE nome LIKE :nome');
      qryCons.ParamByName('nome').AsString := '%' + nome + '%';
    end;

    qryCons.Open();

    Result := qryCons;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Cliente. Id: ' + Id.ToString());
    end;
  end;
end;

procedure TClientController.pAtualizar;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;

    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('UPDATE clientes SET ');
    qryExec.SQL.Add('(nome, cidade, uf)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:nome, :cidade, :uf)');
    qryExec.SQL.Add('WHERE id = :id');

    qryExec.ParamByName('id').AsInteger    := Id;
    qryExec.ParamByName('nome').AsString   := Nome;
    qryExec.ParamByName('cidade').AsString := Cidade;
    qryExec.ParamByName('uf').AsString     := UF;

    qryExec.ExecSQL;

    fdConn.Commit;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Atualizar Cliente: ' + Id.ToString());
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TClientController.pCadastrar;
var qryExec : TFDQuery;
begin
  try
    fdConn.StartTransaction;

    qryExec := fCreateQuery(fdConn);

    qryExec.SQL.Add('INSERT INTO clientes ');
    qryExec.SQL.Add('(nome, cidade, uf)');
    qryExec.SQL.Add('VALUES');
    qryExec.SQL.Add('(:nome, :cidade, :uf)');

    qryExec.ParamByName('nome').AsString   := Nome;
    qryExec.ParamByName('cidade').AsString := Cidade;
    qryExec.ParamByName('uf').AsString     := UF;

    qryExec.ExecSQL;
  except
    on e:exception do
    begin
      fdConn.Rollback;
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Cadastrar Cliente');
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
      raise Exception.Create('Erro ao Capturar ID do Cliente');
    end;
  end;

  if Assigned(qryExec) then
    FreeAndNil(qryExec);

end;

procedure TClientController.pCarregar;
var qryCons : TFDQuery;
begin
  try
    qryCons := fCreateQuery(fdConn);

    qryCons.SQL.Add('SELECT * FROM clientes ');
    qryCons.SQL.Add('WHERE id = :id');
    qryCons.ParamByName('id').AsInteger    := Id;

    qryCons.Open();

    Id     := qryCons.FieldByName('id').AsInteger;
    Nome   := qryCons.FieldByName('nome').AsString;
    Cidade := qryCons.FieldByName('cidade').AsString;
    UF     := qryCons.FieldByName('uf').AsString;
  except
    on e:exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Carregar Cliente. Id: ' + Id.ToString());
    end;
  end;

  if Assigned(qryCons) then
    FreeAndNil(qryCons);
end;

end.

