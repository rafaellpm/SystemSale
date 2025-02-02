unit uSale_Model;

interface

type TSaleModel = class
  private
    FId         : Integer;
    FVlrTotal   : Float64;
    FIdCliente  : Integer;
    FData       : TDateTime;
    FDtEnd      : TDateTime;
    FDtStart    : TDateTime;
    procedure SetData(const Value: TDateTime);
    procedure SetId(const Value: Integer);
    procedure SetIdCliente(const Value: Integer);
    procedure SetVlrTotal(const Value: Float64);
    procedure SetDtEnd(const Value: TDateTime);
    procedure SetDtStart(const Value: TDateTime);
  public
    property Id          : Integer   read FId          write SetId;
    property IdCliente   : Integer   read FIdCliente   write SetIdCliente;
    property Data        : TDateTime read FData        write SetData;
    property VlrTotal    : Float64   read FVlrTotal    write SetVlrTotal;

    property DateStart : TDateTime read FDtStart write SetDtStart;
    property DateEnd   : TDateTime read FDtEnd   write SetDtEnd;
end;

implementation

{ TSaleModel }

procedure TSaleModel.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TSaleModel.SetDtEnd(const Value: TDateTime);
begin
  FDtEnd := Value;
end;

procedure TSaleModel.SetDtStart(const Value: TDateTime);
begin
  FDtStart := Value;
end;

procedure TSaleModel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TSaleModel.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;

procedure TSaleModel.SetVlrTotal(const Value: Float64);
begin
  FVlrTotal := Value;
end;

end.
