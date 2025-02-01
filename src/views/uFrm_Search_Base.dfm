object frmSearchBase: TfrmSearchBase
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmSearchBase'
  ClientHeight = 429
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 31
    Width = 650
    Height = 391
    TabOrder = 0
    object btnSearch: TSpeedButton
      Left = 559
      Top = 9
      Width = 78
      Height = 41
      Caption = 'Pesquisar'
    end
    object lblTotalRegistro: TLabel
      Left = 11
      Top = 371
      Width = 104
      Height = 13
      Caption = 'Total de Registros: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 53
      Width = 629
      Height = 316
      DataSource = dsSearch
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
    end
    object Panel4: TPanel
      Left = 8
      Top = 9
      Width = 545
      Height = 41
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 4
        Height = 41
        Align = alLeft
        Brush.Color = 10905621
        Pen.Style = psClear
      end
      object Label1: TLabel
        Left = 9
        Top = 1
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object edtSearch: TEdit
        Left = 5
        Top = 15
        Width = 533
        Height = 23
        BorderStyle = bsNone
        TabOrder = 0
        OnKeyDown = edtSearchKeyDown
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 666
    Height = 29
    Align = alTop
    Color = 13159893
    ParentBackground = False
    TabOrder = 1
    OnMouseDown = Panel1MouseDown
    object btnClose: TSpeedButton
      Left = 635
      Top = 2
      Width = 23
      Height = 22
      Caption = 'X'
      OnClick = btnCloseClick
    end
    object Label3: TLabel
      Left = 303
      Top = 0
      Width = 50
      Height = 28
      Caption = 'Titulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5722185
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnMouseDown = Label3MouseDown
    end
  end
  object memSearch: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 320
    Top = 198
  end
  object dsSearch: TDataSource
    DataSet = memSearch
    Left = 432
    Top = 192
  end
end
