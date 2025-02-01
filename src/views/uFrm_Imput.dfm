object frmImputValue: TfrmImputValue
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmImputValue'
  ClientHeight = 124
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 5
    Top = 8
    Width = 282
    Height = 107
    TabOrder = 0
    object btnConfirm: TSpeedButton
      Left = 200
      Top = 66
      Width = 68
      Height = 33
      Caption = 'Confirmar'
      OnClick = btnConfirmClick
    end
    object btnCancel: TSpeedButton
      Left = 128
      Top = 66
      Width = 68
      Height = 33
      Caption = 'Cancelar'
      OnClick = btnCancelClick
    end
    object pnlQtdeProduct: TPanel
      Left = 11
      Top = 19
      Width = 257
      Height = 41
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Shape6: TShape
        Left = 0
        Top = 0
        Width = 4
        Height = 41
        Align = alLeft
        Brush.Color = 14913824
        Pen.Style = psClear
        ExplicitLeft = 8
      end
      object lblTitle: TLabel
        Left = 6
        Top = 1
        Width = 22
        Height = 13
        Caption = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtResult: TEdit
        Left = 6
        Top = 15
        Width = 250
        Height = 23
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5722185
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyDown = edtResultKeyDown
      end
    end
  end
end
