unit uProduct_Model;

interface

type TProductModel = class
  private
    FDescricao : string;
    FId        : integer;
    FVlrVenda  : Float64;
    procedure SetDescricao(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetVlrVenda(const Value: Float64);
  public
    property Id        : integer read FId        write SetId;
    property Descricao : string  read FDescricao write SetDescricao;
    property VlrVenda  : Float64 read FVlrVenda  write SetVlrVenda;
end;

implementation

{ TProductModel }

procedure TProductModel.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProductModel.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TProductModel.SetVlrVenda(const Value: Float64);
begin
  FVlrVenda := Value;
end;

end.
