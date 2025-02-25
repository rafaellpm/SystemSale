inherited frmSearchProduct: TfrmSearchProduct
  Caption = 'tfdq'
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    inherited btnSearch: TSpeedButton
      Top = 22
      Height = 24
      OnClick = btnSearchClick
      ExplicitTop = 22
      ExplicitHeight = 24
    end
    inherited DBGrid1: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Width = 420
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlr_venda'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Venda R$'
          Width = 100
          Visible = True
        end>
    end
  end
  inherited Panel1: TPanel
    inherited Label3: TLabel
      Left = 235
      Top = -2
      Width = 188
      Caption = 'Consulta de Produtos'
      ExplicitLeft = 235
      ExplicitTop = -2
      ExplicitWidth = 188
    end
  end
  inherited memSearch: TFDMemTable
    object memSearchid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object memSearchdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object memSearchvlr_venda: TBCDField
      FieldName = 'vlr_venda'
      Origin = 'vlr_venda'
      Required = True
      Precision = 10
      Size = 2
    end
  end
end
