inherited frmSearchSale: TfrmSearchSale
  Caption = ''
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    inherited btnSearch: TSpeedButton
      Left = 565
      Width = 72
      OnClick = btnSearchClick
      ExplicitLeft = 565
      ExplicitWidth = 72
    end
    inherited DBGrid1: TDBGrid
      TabOrder = 3
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Alignment = taCenter
          Title.Caption = 'Nr Venda'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id_cliente'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'd. Cliente'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome_cliente'
          Title.Alignment = taCenter
          Title.Caption = 'Nome Cliente'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlr_total'
          Title.Alignment = taCenter
          Title.Caption = 'Vlr Total'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data'
          Title.Alignment = taCenter
          Title.Caption = 'Data Emiss'#227'o'
          Width = 130
          Visible = True
        end>
    end
    inherited Panel4: TPanel
      Left = 232
      Width = 329
      TabOrder = 2
      ExplicitLeft = 232
      ExplicitWidth = 329
    end
    object Panel2: TPanel
      Left = 8
      Top = 9
      Width = 107
      Height = 41
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 4
        Height = 41
        Align = alLeft
        Brush.Color = 10905621
        Pen.Style = psClear
      end
      object Label2: TLabel
        Left = 7
        Top = 1
        Width = 58
        Height = 15
        Caption = 'Data Inicial'
      end
      object dtStart: TDateTimePicker
        Left = 7
        Top = 15
        Width = 90
        Height = 23
        Date = 45688.000000000000000000
        Time = 0.979609722220629900
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 120
      Top = 9
      Width = 106
      Height = 41
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object Shape3: TShape
        Left = 0
        Top = 0
        Width = 4
        Height = 41
        Align = alLeft
        Brush.Color = 10905621
        Pen.Style = psClear
      end
      object Label4: TLabel
        Left = 7
        Top = 1
        Width = 58
        Height = 15
        Caption = 'Data Inicial'
      end
      object dtEnd: TDateTimePicker
        Left = 7
        Top = 15
        Width = 90
        Height = 23
        Date = 45688.000000000000000000
        Time = 0.979609722220629900
        TabOrder = 0
      end
    end
  end
  inherited Panel1: TPanel
    inherited Label3: TLabel
      Left = 247
      Width = 170
      Caption = 'Consulta de Vendas'
      ExplicitLeft = 247
      ExplicitWidth = 170
    end
  end
  inherited memSearch: TFDMemTable
    object memSearchid: TIntegerField
      FieldName = 'id'
    end
    object memSearchnome_cliente: TWideStringField
      FieldName = 'nome_cliente'
      Size = 255
    end
    object memSearchid_cliente: TIntegerField
      FieldName = 'id_cliente'
    end
    object memSearchvlr_total: TBCDField
      FieldName = 'vlr_total'
      Size = 2
    end
    object memSearchdata: TSQLTimeStampField
      FieldName = 'data'
    end
  end
end
