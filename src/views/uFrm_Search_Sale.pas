unit uFrm_Search_Sale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrm_Search_Base, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, FireDAC.Stan.Async,
  FireDAC.DApt;

type
  TfrmSearchSale = class(TfrmSearchBase)
    Panel2: TPanel;
    Shape2: TShape;
    dtStart: TDateTimePicker;
    Label2: TLabel;
    Panel3: TPanel;
    Shape3: TShape;
    Label4: TLabel;
    dtEnd: TDateTimePicker;
    memSearchid: TFDAutoIncField;
    memSearchid_cliente: TIntegerField;
    memSearchdata: TSQLTimeStampField;
    memSearchvlr_total: TBCDField;
    memSearchnome: TStringField;
    procedure btnSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchSale: TfrmSearchSale;

implementation

uses
  uSale_Controller, daoConnection, uFunctions;

{$R *.dfm}


procedure TfrmSearchSale.btnSearchClick(Sender: TObject);
var sale : TSaleController;
    qryCons  : TFDquery;
begin
  try
    inherited;

    sale := TSaleController.Create(dm.fdConn);
    sale.DateStart := dtStart.Date;
    sale.DateEnd := dtEnd.Date;

    qryCons := sale.fGetAll;

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

procedure TfrmSearchSale.FormShow(Sender: TObject);
begin
  inherited;
  dtStart.DateTime := fGetFirstDayOfMonth;
  dtEnd.DateTime   := fGetLastDayOfMonth();

  dtStart.SetFocus;
end;

end.
