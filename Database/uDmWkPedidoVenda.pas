unit uDmWkPedidoVenda;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, Vcl.Dialogs, UIniUtils;

type
  TConexaoBanco = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
  private
    procedure ConfigurarConexao;
  public
    { Public declarations }
  end;

var
  ConexaoBanco: TConexaoBanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmWkPedidoVenda }

procedure TConexaoBanco.ConfigurarConexao;
begin
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.SERVIDOR_BANCO);
    Params.Values['User_Name'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.USUARIO_BANCO);
    Params.Values['Password'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.SENHA_BANCO);
    Params.Values['DriverID'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.DRIVER_ID);
    Params.Values['Port'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.PORTA_BANCO);
    Params.Values['Database'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.NOME_BANCO);
  end;

  drvBancoDeDados.VendorLib := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.CAMINHO_LIB);
end;

procedure TConexaoBanco.DataModuleCreate(Sender: TObject);
begin
  try
    ConfigurarConexao;
    if not cnxBancoDeDados.Connected then
      cnxBancoDeDados.Connected := True;
  except
    on E: Exception do
      ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);
  end;
end;

procedure TConexaoBanco.cnxBancoDeDadosBeforeConnect(Sender: TObject);
begin
  ConfigurarConexao;
end;

end.
