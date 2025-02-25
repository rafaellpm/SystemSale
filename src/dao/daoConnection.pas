unit daoConnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, IniFiles, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, uFunctions;

type
  Tdm = class(TDataModule)
    fdConn: TFDConnection;
    driveConn: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure pCriarIniLocal;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
var ini : TIniFile;
    Database, Username, Server, Port, Password, Dll: string;
    dir : string;
begin
   dir := fGetCurrentDir();
  if not FileExists(dir + 'system.ini') then
    pCriarIniLocal;

  ini := TIniFile.Create(dir + 'system.ini');

  Database := ini.ReadString('CONECTION', 'Database', 'sistema');
  Username := ini.ReadString('CONECTION', 'Username', 'usuario');
  Server   := ini.ReadString('CONECTION', 'Server', 'localhost');
  Port     := ini.ReadString('CONECTION', 'Port', '3306');
  Password := ini.ReadString('CONECTION', 'Password', 'master');
  Dll      := ini.ReadString('CONECTION', 'Dll', dir+'libmysql.dll');

  driveConn.VendorLib := Dll;

  with fdConn do
  begin
    Params.DriverID           := 'MySQL';
    Params.Values['Database'] := Database;
    Params.Values['User Name'] := Username;
    Params.Values['Server']   := Server;
    Params.Values['Port']     := Port;
    Params.Values['Password'] := Password;

    try
       Connected := true;
    except
      on e: exception do
      begin
        pSaveLog(e.Message);
        raise Exception.Create('Erro ao Conectar no Banco de Dados!');
      end;
    end;
  end;
end;


procedure Tdm.pCriarIniLocal();
var ini : TIniFile;
    dir : string;
begin
  try
    dir := fGetCurrentDir();
    ini := TIniFile.Create(dir + 'system.ini');

    ini.WriteString('CONECTION', 'Database', 'sistema');
    ini.WriteString('CONECTION', 'Username', 'usuario');
    ini.WriteString('CONECTION', 'Server', 'localhost');
    ini.WriteString('CONECTION', 'Port', '3306');
    ini.WriteString('CONECTION', 'Password', 'master');
    ini.WriteString('CONECTION', 'Dll', dir+'libmysql.dll');

  except
    on e: exception do
    begin
      pSaveLog(e.Message);
      raise Exception.Create('Erro ao Criar Arquivo INI.');
    end;
  end;

  if Assigned(ini) then
    FreeAndNil(ini);
end;

end.
