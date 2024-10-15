unit PedidoRepository;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, uDatabaseManager;

type
  TPedidoRepository = class
  private
    FDatabaseConnection: TFDConnection;
    function GetLastAutoIncValue: Integer;
  public
    constructor Create(AConnection: TFDConnection);

    function InserirPedido(ACodigoCliente: Integer; AValorTotal: Double): Integer;
    procedure DeletarPedido(NumeroPedido: Integer);
    function ObterPedido(NumeroPedido: Integer): TFDQuery;
  end;

implementation

{ TPedidoRepository }

constructor TPedidoRepository.Create(AConnection: TFDConnection);
begin
  FDatabaseConnection := AConnection;
end;

function TPedidoRepository.InserirPedido(ACodigoCliente: Integer; AValorTotal: Double): Integer;
begin
  FDatabaseConnection.StartTransaction;
  with TFDQuery.Create(nil) do
  try
    try
      Connection := FDatabaseConnection;
      SQL.Text := 'INSERT INTO Pedidos (DataEmissao, CodigoCliente, ValorTotal) VALUES (:DataEmissao, :CodigoCliente, :ValorTotal)';
      ParamByName('DataEmissao').AsDate := Date;
      ParamByName('CodigoCliente').AsInteger := ACodigoCliente;
      ParamByName('ValorTotal').AsFloat := AValorTotal;
      ExecSQL;

      Result := GetLastAutoIncValue;

      FDatabaseConnection.Commit;
    except
      on E: Exception do
      begin
        FDatabaseConnection.Rollback;
        raise Exception.Create('Ocorreu um erro ao processar a transação: '+E.Message);
      end;
    end;
  finally
    Free;
  end;
end;

procedure TPedidoRepository.DeletarPedido(NumeroPedido: Integer);
begin
  FDatabaseConnection.StartTransaction;
  with TFDQuery.Create(nil) do
  try
    try
      Connection := FDatabaseConnection;
      SQL.Text := 'DELETE FROM Pedidos WHERE NumeroPedido = :NumeroPedido';
      ParamByName('NumeroPedido').AsInteger := NumeroPedido;
      ExecSQL;

      FDatabaseConnection.Commit;
    except
      on E: Exception do
      begin
        FDatabaseConnection.Rollback;
        raise Exception.Create('Ocorreu um erro ao processar a transação: '+E.Message);
      end;
    end;
  finally
    Free;
  end;
end;

function TPedidoRepository.ObterPedido(NumeroPedido: Integer): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FDatabaseConnection;
  Result.SQL.Text := 'SELECT * FROM Pedidos WHERE NumeroPedido = :NumeroPedido';
  Result.ParamByName('NumeroPedido').AsInteger := NumeroPedido;
  Result.Open;
end;

function TPedidoRepository.GetLastAutoIncValue: Integer;
begin
  with TFDQuery.Create(nil) do
  try
    Connection := FDatabaseConnection;
    SQL.Text := 'SELECT LAST_INSERT_ID()';
    Open;

    if not IsEmpty then
      Result := Fields[0].AsInteger
    else
      Result := -1;
  finally
    Free;
  end;
end;

end.

