unit uSale_Item_Model;

interface
type TSaleItemModel = class
  private
    FVlrTotal    : Float64;
    FIdProduto   : Integer;
    FId          : Integer;
    FQtde        : Integer;
    FIdVenda     : Integer;
    FVlrUnitario : Float64;
    procedure SetId(const Value: Integer);
    procedure SetIdProduto(const Value: Integer);
    procedure SetIdVenda(const Value: Integer);
    procedure SetQtde(const Value: Integer);
    procedure SetVlrTotal(const Value: Float64);
    procedure SetVlrUnitario(const Value: Float64);
  public
    property Id          : Integer read FId          write SetId;
    property IdVenda     : Integer read FIdVenda     write SetIdVenda;
    property IdProduto   : Integer read FIdProduto   write SetIdProduto;
    property Qtde        : Integer read FQtde        write SetQtde;
    property VlrUnitario : Float64 read FVlrUnitario write SetVlrUnitario;
    property VlrTotal    : Float64 read FVlrTotal    write SetVlrTotal;
end;

implementation

{ TSaleItemModel }

procedure TSaleItemModel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TSaleItemModel.SetIdProduto(const Value: Integer);
begin
  FIdProduto := Value;
end;

procedure TSaleItemModel.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TSaleItemModel.SetQtde(const Value: Integer);
begin
  FQtde := Value;
end;

procedure TSaleItemModel.SetVlrTotal(const Value: Float64);
begin
  FVlrTotal := Value;
end;

procedure TSaleItemModel.SetVlrUnitario(const Value: Float64);
begin
  FVlrUnitario := Value;
end;

end.
