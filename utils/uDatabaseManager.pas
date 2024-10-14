unit uDatabaseManager;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param;

type
  TTipoConsulta = (tpCliente, tpProduto, tpPedido);

type
  TDatabaseManager = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FDataSourceCliente: TDataSource;
    FDataSourcePedido: TDataSource;
    FDataSourceProduto: TDataSource;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    property Connection: TFDConnection read FConnection;

    function GetDataSourceCliente: TDataSource;
    function ClienteExiste(ACodigoCliente: Integer; out ANomeCliente: string): Boolean;

    function ProdutoExiste(ACodigoProduto: Integer; out AValorUnitario: Double; out ADescricaoProduto:string): Boolean;
    function GetDataSourceProduto: TDataSource;

    function GetDataSourcePedido: TDataSource;

    function GetLastAutoIncValue: Integer;

    procedure AtualizarDados(TipoConsulta: TTipoConsulta);
  end;

implementation

{ TDatabaseManager }

constructor TDatabaseManager.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;

  FDataSourceCliente := TDataSource.Create(nil);
  FDataSourcePedido := TDataSource.Create(nil);
  FDataSourceProduto := TDataSource.Create(nil);
end;

destructor TDatabaseManager.Destroy;
begin
  FDataSourceCliente.Free;
  FDataSourcePedido.Free;
  FDataSourceProduto.Free;

  FQuery.Free;
  inherited;
end;

function TDatabaseManager.GetDataSourceCliente: TDataSource;
begin
  Result := FDataSourceCliente;
end;

function TDatabaseManager.GetDataSourcePedido: TDataSource;
begin
  Result := FDataSourcePedido;
end;

function TDatabaseManager.GetDataSourceProduto: TDataSource;
begin
  Result := FDataSourceProduto;
end;

function TDatabaseManager.GetLastAutoIncValue: Integer;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT LAST_INSERT_ID()';
  FQuery.Open;

  if not FQuery.IsEmpty then
    Result := FQuery.Fields[0].AsInteger
  else
    Result := -1;
end;

procedure TDatabaseManager.AtualizarDados(TipoConsulta: TTipoConsulta);
begin
  if TipoConsulta = tpCliente then
  begin
    FQuery.Close;
    FQuery.SQL.Text := 'SELECT * FROM Clientes';
    FQuery.Open;
    FDataSourceCliente.DataSet := FQuery;
  end
  else
  if TipoConsulta = tpProduto then
  begin
    FQuery.Close;
    FQuery.SQL.Text := 'SELECT * FROM Produtos';
    FQuery.Open;
    FDataSourceProduto.DataSet := FQuery;
  end
  else
  if TipoConsulta = tpPedido then
  begin
    FQuery.Close;
    FQuery.SQL.Text := 'SELECT p.NumeroPedido, p.CodigoCliente, c.Nome, p.DataEmissao, p.ValorTotal ' +
                       'FROM Pedidos p ' +
                       'JOIN Clientes c ON c.Codigo = p.CodigoCliente ';
    FQuery.Open;
    FDataSourcePedido.DataSet := FQuery;
  end;
end;

function TDatabaseManager.ClienteExiste(ACodigoCliente: Integer; out ANomeCliente: string): Boolean;
begin
  Result := False;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT Codigo, Nome FROM Clientes WHERE Codigo = :Codigo';
  FQuery.ParamByName('Codigo').AsInteger := ACodigoCliente;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    ANomeCliente := FQuery.FieldByName('Nome').AsString;
    Result := True;
  end;
end;

function TDatabaseManager.ProdutoExiste(ACodigoProduto: Integer; out AValorUnitario: Double; out ADescricaoProduto:string): Boolean;
begin
  Result := False;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM Produtos WHERE Codigo = :Codigo';
  FQuery.ParamByName('Codigo').AsInteger := ACodigoProduto;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    AValorUnitario := FQuery.FieldByName('PrecoVenda').AsFloat;
    ADescricaoProduto :=  FQuery.FieldByName('Descricao').AsString;
    Result := True;
  end;
end;

end.

