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
          FieldName = 'UF'
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
    object memSearchId: TIntegerField
      FieldName = 'id'
    end
    object memSearchNome: TWideStringField
      FieldName = 'nome'
      Size = 255
    end
    object memSearchCidade: TWideStringField
      FieldName = 'cidade'
      Size = 255
    end
    object memSearchUF: TWideStringField
      FieldName = 'UF'
      Size = 255
    end
  end
end
