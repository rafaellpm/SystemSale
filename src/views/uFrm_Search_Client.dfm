inherited frmSearchClient: TfrmSearchClient
  Caption = 'frmSearchClient'
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    inherited btnSearch: TSpeedButton
      OnClick = btnSearchClick
    end
    inherited DBGrid1: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Alignment = taCenter
          Title.Caption = 'Nome Completo'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cidade'
          Title.Alignment = taCenter
          Title.Caption = 'Cidade'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'uf'
          Title.Alignment = taCenter
          Width = 60
          Visible = True
        end>
    end
  end
  inherited Panel1: TPanel
    inherited Label3: TLabel
      Left = 244
      Width = 176
      Caption = 'Consulta de Clientes'
      ExplicitLeft = 244
      ExplicitWidth = 176
    end
  end
  inherited memSearch: TFDMemTable
    object memSearchid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object memSearchnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 255
    end
    object memSearchcidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 100
    end
    object memSearchuf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
  end
end
