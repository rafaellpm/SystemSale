unit uSale_Item_Model;

interface
type TSaleItemModel = class
  private
    FVlrTotal    : Float64;
    FIdProduto   : Integer;
    FId          : Integer;
    FQtde        : Float64;
    FIdVenda     : Integer;
    FVlrUnitario : Float64;
    FDeleteProd  : Boolean;
    procedure SetId(const Value: Integer);
    procedure SetIdProduto(const Value: Integer);
    procedure SetIdVenda(const Value: Integer);
    procedure SetQtde(const Value: Float64);
    procedure SetVlrTotal(const Value: Float64);
    procedure SetVlrUnitario(const Value: Float64);
    procedure SetDeleteProd(const Value: Boolean);
  public
    property Id               : Integer read FId               write SetId;
    property IdVenda          : Integer read FIdVenda          write SetIdVenda;
    property IdProduto        : Integer read FIdProduto        write SetIdProduto;
    property Qtde             : Float64 read FQtde             write SetQtde;
    property VlrUnitario      : Float64 read FVlrUnitario      write SetVlrUnitario;
    property VlrTotal         : Float64 read FVlrTotal         write SetVlrTotal;
    property DeleteProd       : Boolean read FDeleteProd       write SetDeleteProd;
end;

implementation

{ TSaleItemModel }

procedure TSaleItemModel.SetDeleteProd(const Value: Boolean);
begin
  FDeleteProd := Value;
end;

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

procedure TSaleItemModel.SetQtde(const Value: Float64);
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
