object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Pedido Venda'
  ClientHeight = 567
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 214
    Top = 67
    Width = 88
    Height = 15
    Caption = 'C'#243'digo Produto:'
  end
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 707
    Height = 567
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Roboto'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 707
      Height = 201
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lblCodCliente: TLabel
        Left = 24
        Top = 11
        Width = 82
        Height = 14
        Caption = 'C'#243'digo Cliente:'
      end
      object lblProduto: TLabel
        Left = 24
        Top = 67
        Width = 89
        Height = 14
        Caption = 'C'#243'digo Produto:'
      end
      object lblQtde: TLabel
        Left = 24
        Top = 123
        Width = 66
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblVlrUnit: TLabel
        Left = 169
        Top = 123
        Width = 67
        Height = 14
        Caption = 'Vlr. Unit'#225'rio:'
      end
      object btnCliente: TImage
        Left = 185
        Top = 32
        Width = 24
        Height = 24
        Hint = 'Clique para consultar o cadastro de clientes'
        ParentShowHint = False
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
          00180806000000E0773DF8000000097048597300000B1300000B1301009A9C18
          000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000001
          874944415478DAC5952B4C03411086E72C0A512C1C1247936A02AE2808484202
          0A792079242D0901492B51900092862A40F1D0245415D916DB0A4CB165FE9B1E
          574A776E813B98E4CCE666BFF9E7B54E878D1234E7FF0077CF44E547A24BFEEA
          2D399B1C932FB748E4A67E08787D23DABD202A5CEB9EEB59010D0F7D0380CB67
          F6882A0D71F46689A627E483E1BCC8E0938750D1ED8E0AF90CD83895C8211F8E
          EEC860AF7A530241EAA0E470D902809FC73D39AD15CC97F742D2DBACBA2DC104
          2A8D80D52391BE324574BC665540BF56F992AA2204A4B724C74FFB925B1B43A7
          2155500BD52AC0599293CEB9DDE51F37E87E7F0870B9C08D965AB02F5679E1D4
          6E724A4739B5071180A045F30B32403666D118212028188606D144AD02CBB6EE
          1BB4335671253FFB8396325FEE0F5A33B2ADCDAB0206672F1BB62D54DE573988
          1B1930BF767A3086655712259A015CEE6E5A05625ED7900F10D4048A70C17C86
          682E239DD6BB930C90DF3F381190785E340512DF93D90FE9EEA678DFE40002AB
          1513000CB0C401EF83D403C80C4944980000000049454E44AE426082}
        ShowHint = True
        OnClick = btnClienteClick
      end
      object btnProduto: TImage
        Left = 183
        Top = 88
        Width = 24
        Height = 24
        Hint = 'Clique para consultar o cadastro de produtos'
        ParentShowHint = False
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
          00180806000000E0773DF8000000097048597300000B1300000B1301009A9C18
          000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000001
          874944415478DAC5952B4C03411086E72C0A512C1C1247936A02AE2808484202
          0A792079242D0901492B51900092862A40F1D0245415D916DB0A4CB165FE9B1E
          574A776E813B98E4CCE666BFF9E7B54E878D1234E7FF0077CF44E547A24BFEEA
          2D399B1C932FB748E4A67E08787D23DABD202A5CEB9EEB59010D0F7D0380CB67
          F6882A0D71F46689A627E483E1BCC8E0938750D1ED8E0AF90CD83895C8211F8E
          EEC860AF7A530241EAA0E470D902809FC73D39AD15CC97F742D2DBACBA2DC104
          2A8D80D52391BE324574BC665540BF56F992AA2204A4B724C74FFB925B1B43A7
          2155500BD52AC0599293CEB9DDE51F37E87E7F0870B9C08D965AB02F5679E1D4
          6E724A4739B5071180A045F30B32403666D118212028188606D144AD02CBB6EE
          1BB4335671253FFB8396325FEE0F5A33B2ADCDAB0206672F1BB62D54DE573988
          1B1930BF767A3086655712259A015CEE6E5A05625ED7900F10D4048A70C17C86
          682E239DD6BB930C90DF3F381190785E340512DF93D90FE9EEA678DFE40002AB
          1513000CB0C401EF83D403C80C4944980000000049454E44AE426082}
        ShowHint = True
        OnClick = btnProdutoClick
      end
      object lblNomeCliente: TLabel
        Left = 215
        Top = 11
        Width = 74
        Height = 14
        Caption = 'Nome Cliente:'
      end
      object lblNomeProduto: TLabel
        Left = 215
        Top = 67
        Width = 120
        Height = 14
        Caption = 'Descri'#231#227'o do Produto:'
      end
      object btnAdicionar: TButton
        Left = 312
        Top = 133
        Width = 232
        Height = 33
        Caption = 'Adicionar Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5898495
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnAdicionarClick
      end
      object edtCliente: TEdit
        Left = 24
        Top = 32
        Width = 160
        Height = 22
        TabOrder = 0
        OnExit = edtClienteExit
      end
      object edtProduto: TEdit
        Left = 24
        Top = 88
        Width = 160
        Height = 22
        TabOrder = 1
        OnExit = edtProdutoExit
      end
      object edtQtde: TEdit
        Left = 24
        Top = 144
        Width = 121
        Height = 22
        TabOrder = 2
      end
      object edtVlrUnit: TEdit
        Left = 169
        Top = 144
        Width = 121
        Height = 22
        TabOrder = 3
      end
      object edtNomeProduto: TEdit
        Left = 213
        Top = 88
        Width = 331
        Height = 22
        Enabled = False
        TabOrder = 5
        OnExit = edtProdutoExit
      end
      object edtNomeCliente: TEdit
        Left = 215
        Top = 32
        Width = 331
        Height = 22
        Enabled = False
        TabOrder = 6
        OnExit = edtProdutoExit
      end
      object pnlConsultarPedido: TPanel
        Left = 568
        Top = 26
        Width = 129
        Height = 33
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 7
        object btnConsultarPedido: TSpeedButton
          Left = 0
          Top = 0
          Width = 129
          Height = 33
          Align = alClient
          Caption = 'Consultar '#13'Pedido de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5898495
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          OnClick = btnConsultarPedidoClick
          ExplicitTop = 5
        end
      end
      object pnlExcluirPedido: TPanel
        Left = 568
        Top = 70
        Width = 129
        Height = 33
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 8
        object btnCancelarPedido: TSpeedButton
          Left = 0
          Top = 0
          Width = 129
          Height = 33
          Align = alClient
          Caption = 'Excluir'#13'Pedido de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5898495
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          OnClick = btnCancelarPedidoClick
          ExplicitTop = -5
        end
      end
    end
    object pnlRodape: TPanel
      Left = 0
      Top = 504
      Width = 707
      Height = 63
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object pnlBtnSalvar: TPanel
        Left = 510
        Top = 8
        Width = 185
        Height = 45
        Align = alCustom
        AutoSize = True
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object btnGravar: TButton
          Left = 0
          Top = 0
          Width = 185
          Height = 45
          Align = alClient
          Caption = 'Gravar Pedido de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5898495
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnGravarClick
        end
      end
      object pnlCancelar: TPanel
        Left = 10
        Top = 8
        Width = 185
        Height = 45
        Align = alCustom
        AutoSize = True
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object btnCancelar: TButton
          Left = 0
          Top = 0
          Width = 185
          Height = 45
          Align = alClient
          Caption = 'Cancelar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5898495
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnCancelarClick
        end
      end
    end
    object dbgrdProdutos: TDBGrid
      Left = 0
      Top = 201
      Width = 707
      Height = 236
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsItensPedido
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnKeyDown = dbgrdProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CodigoProduto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DescricaoProduto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorUnitario'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorTotal'
          Visible = True
        end>
    end
    object pnlTotalizacao: TPanel
      Left = 0
      Top = 456
      Width = 707
      Height = 48
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Valor Total do Pedido: R$ 100,00'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object statOpcoes: TStatusBar
      Left = 0
      Top = 437
      Width = 707
      Height = 19
      Color = clWhite
      Panels = <
        item
          Alignment = taCenter
          BiDiMode = bdRightToLeft
          ParentBiDiMode = False
          Text = 'Alterar <Enter>'
          Width = 329
        end
        item
          Alignment = taCenter
          Text = 'Excluir <Del>'
          Width = 329
        end>
    end
  end
  object cdsItensPedido: TClientDataSet
    PersistDataPacket.Data = {
      AC0000009619E0BD010000001800000006000000000003000000AC0006496449
      74656D04000100000000000D436F6469676F50726F6475746F01004900000001
      000557494454480200020014001044657363726963616F50726F6475746F0100
      4900000001000557494454480200020014000A5175616E746964616465080004
      00000000000D56616C6F72556E69746172696F08000400000000000A56616C6F
      72546F74616C08000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IdItem'
        DataType = ftInteger
      end
      item
        Name = 'CodigoProduto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DescricaoProduto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Quantidade'
        DataType = ftFloat
      end
      item
        Name = 'ValorUnitario'
        DataType = ftFloat
      end
      item
        Name = 'ValorTotal'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 600
    Top = 184
    object cdsItensPedidoIdItem: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'IdItem'
      Visible = False
    end
    object strngfldItensPedidoCodigoProduto: TStringField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'CodigoProduto'
    end
    object strngfldItensPedidoDescricaoProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o Produto'
      FieldName = 'DescricaoProduto'
    end
    object fltfldItensPedidoQuantidade: TFloatField
      FieldName = 'Quantidade'
    end
    object fltfldItensPedidoValorUnitario: TFloatField
      DisplayLabel = 'Vlr. Unit'#225'rio'
      FieldName = 'ValorUnitario'
    end
    object fltfldItensPedidoValorTotal: TFloatField
      DisplayLabel = 'Vlr. Total'
      FieldName = 'ValorTotal'
    end
  end
  object dsItensPedido: TDataSource
    DataSet = cdsItensPedido
    Left = 584
    Top = 264
  end
end
