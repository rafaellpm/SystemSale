unit uSale_Model;

interface

type TSaleModel = class
  private
    FId         : Integer;
    FValorTotal : Float64;
    FIdCliente  : Integer;
    FData       : TDateTime;
    procedure SetData(const Value: TDateTime);
    procedure SetId(const Value: Integer);
    procedure SetIdCliente(const Value: Integer);
    procedure SetValorTotal(const Value: Float64);
  public
    property Id         : Integer   read FId         write SetId;
    property IdCliente  : Integer   read FIdCliente  write SetIdCliente;
    property Data       : TDateTime read FData       write SetData;
    property ValorTotal : Float64   read FValorTotal write SetValorTotal;
end;

implementation

{ TSaleModel }

procedure TSaleModel.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TSaleModel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TSaleModel.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;

procedure TSaleModel.SetValorTotal(const Value: Float64);
begin
  FValorTotal := Value;
end;

end.
