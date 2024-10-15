unit ItemPedidoRepository;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, uDatabaseManager;

type
  TItemPedidoRepository = class
  private
    FDatabaseConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);

    procedure InserirItem(NumeroPedido: Integer; CodigoProduto: Integer; Quantidade: Double; ValorUnitario: Double; ValorTotal: Double);
    procedure DeletarItensPorPedido(NumeroPedido: Integer);
    function ObterItensPorPedido(NumeroPedido: Integer): TFDQuery;
  end;

implementation

{ TItemPedidoRepository }

constructor TItemPedidoRepository.Create(AConnection: TFDConnection);
begin
  FDatabaseConnection := AConnection;
end;

procedure TItemPedidoRepository.InserirItem(NumeroPedido: Integer; CodigoProduto: Integer; Quantidade: Double; ValorUnitario: Double; ValorTotal: Double);
begin
  FDatabaseConnection.StartTransaction;
  with TFDQuery.Create(nil) do
  try
    try
      Connection := FDatabaseConnection;
      SQL.Text := 'INSERT INTO ItensPedido (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) VALUES (:NumeroPedido, :CodigoProduto, :Quantidade, :ValorUnitario, :ValorTotal)';
      ParamByName('NumeroPedido').AsInteger := NumeroPedido;
      ParamByName('CodigoProduto').AsInteger := CodigoProduto;
      ParamByName('Quantidade').AsFloat := Quantidade;
      ParamByName('ValorUnitario').AsFloat := ValorUnitario;
      ParamByName('ValorTotal').AsFloat := ValorTotal;
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

procedure TItemPedidoRepository.DeletarItensPorPedido(NumeroPedido: Integer);
begin
  FDatabaseConnection.StartTransaction;
  with TFDQuery.Create(nil) do
  try
    try
      Connection := FDatabaseConnection;
      SQL.Text := 'DELETE FROM ItensPedido WHERE NumeroPedido = :NumeroPedido';
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

function TItemPedidoRepository.ObterItensPorPedido(NumeroPedido: Integer): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FDatabaseConnection;
  Result.SQL.Text := 'SELECT i.CodigoProduto, p.Descricao, i.Quantidade, i.ValorUnitario, i.ValorTotal ' +
                     'FROM ItensPedido i ' +
                     'JOIN Produtos p ON p.Codigo = i.CodigoProduto ' +
                     'WHERE i.NumeroPedido = :NumeroPedido';
  Result.ParamByName('NumeroPedido').AsInteger := NumeroPedido;
  Result.Open;
end;

end.

