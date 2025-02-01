unit uClient_Model;

interface

type TClientModel = class
  private
    FUf     : string;
    FId     : Integer;
    FNome   : string;
    FCidade : string;
    procedure SetCidade(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetUf(const Value: string);
  public
    property Id     : Integer read FId     write SetId;
    property Nome   : string  read FNome   write SetNome;
    property Cidade : string  read FCidade write SetCidade;
    property UF     : string  read FUf     write SetUf;
end;

implementation

{ TClientModel }

procedure TClientModel.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TClientModel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TClientModel.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TClientModel.SetUf(const Value: string);
begin
  FUf := Value;
end;

end.
