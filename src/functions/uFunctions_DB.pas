unit uFunctions_DB;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, system.SysUtils,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

  function fCreateQuery(iFdConn: TFDConnection): TFDQuery;

implementation

function fCreateQuery(iFdConn: TFDConnection): TFDQuery;
var qry : TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := iFdConn;

    Result := qry;
  except
    on e: exception do
    begin

    end;
  end;
end;

end.
