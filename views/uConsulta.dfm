object frmConsulta: TfrmConsulta
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta'
  ClientHeight = 295
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRodape: TPanel
    Left = 0
    Top = 208
    Width = 423
    Height = 87
    Align = alBottom
    TabOrder = 0
    object lblOrdem: TLabel
      Left = 8
      Top = 4
      Width = 32
      Height = 13
      Caption = 'Ordem'
    end
    object lblPesquisa: TLabel
      Left = 176
      Top = 4
      Width = 46
      Height = 13
      Caption = 'Pesquisar'
    end
    object btnSeleciona: TBitBtn
      Left = 176
      Top = 49
      Width = 112
      Height = 31
      Caption = 'Selecionar'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnSelecionaClick
    end
    object btnCancela: TBitBtn
      Left = 303
      Top = 49
      Width = 112
      Height = 31
      Caption = 'Cancelar'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object cbxOrdem: TComboBox
      Left = 8
      Top = 20
      Width = 136
      Height = 21
      TabOrder = 2
      OnChange = cbxOrdemChange
      OnClick = cbxOrdemClick
    end
    object edtPesquisa: TEdit
      Left = 176
      Top = 20
      Width = 239
      Height = 21
      TabOrder = 3
      OnKeyUp = edtPesquisaKeyUp
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 423
    Height = 208
    Align = alClient
    TabOrder = 1
    object dbGridConsulta: TDBGrid
      Left = 1
      Top = 1
      Width = 421
      Height = 206
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbGridConsultaCellClick
    end
  end
end
