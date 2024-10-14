object ConexaoBanco: TConexaoBanco
  Height = 480
  Width = 640
  object cnxBancoDeDados: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    UpdateOptions.AssignedValues = [uvUpdateMode]
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object drvBancoDeDados: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Facilitadores\WkPedidoVenda\Win32\Debug\libmysql.dll'
    Left = 40
    Top = 80
  end
  object wtcBancoDeDados: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 136
  end
end
