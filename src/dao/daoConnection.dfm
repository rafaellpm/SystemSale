object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object fdConn: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 184
    Top = 184
  end
  object driveConn: TFDPhysMySQLDriverLink
    Left = 304
    Top = 224
  end
end
