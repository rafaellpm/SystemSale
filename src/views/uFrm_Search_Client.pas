unit uFrm_Search_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrm_Search_Base, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, uClient_Controller, daoConnection,
  FireDAC.Stan.Async, FireDAC.DApt;

type
  TfrmSearchClient = class(TfrmSearchBase)
    memSearchid: TFDAutoIncField;
    memSearchnome: TStringField;
    memSearchcidade: TStringField;
    memSearchuf: TStringField;
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchClient: TfrmSearchClient;

implementation

{$R *.dfm}

procedure TfrmSearchClient.btnSearchClick(Sender: TObject);
var client : TClientController;
    qryCons  : TFDquery;
begin
  try
    inherited;

    client := TClientController.Create(dm.fdConn);
    client.Nome := edtSearch.Text;

    qryCons := client.fGetAll();

    memSearch.CloneCursor(qryCons);

    lblTotalRegistro.Caption := 'Total de Registros: ' + qryCons.RecordCount.ToString();

    FreeAndnil(qryCons);
  except
    on e:exception do
    begin
     ShowMessage(e.Message);
    end;
  end;
end;

end.
