unit ItemPedidoRepository;

interface

uses
  FireDAC.Comp.Client, uDatabaseManager;

type
  TItemPedidoRepository = class
  private
    FDatabaseConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);

    procedure InserirItem(NumeroPedido: Integer; CodigoProduto: Integer; Quantidade: Double; ValorUnitario: Double; ValorTotal: Double);
    procedure AtualizarItem(NumeroPedido: Integer; CodigoProduto: Integer; Quantidade: Double; ValorUnitario: Double; ValorTotal: Double);
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
  with TFDQuery.Create(nil) do
  try
    Connection := FDatabaseConnection;
    SQL.Text := 'INSERT INTO ItensPedido (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) VALUES (:NumeroPedido, :CodigoProduto, :Quantidade, :ValorUnitario, :ValorTotal)';
    ParamByName('NumeroPedido').AsInteger := NumeroPedido;
    ParamByName('CodigoProduto').AsInteger := CodigoProduto;
    ParamByName('Quantidade').AsFloat := Quantidade;
    ParamByName('ValorUnitario').AsFloat := ValorUnitario;
    ParamByName('ValorTotal').AsFloat := ValorTotal;
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TItemPedidoRepository.AtualizarItem(NumeroPedido: Integer; CodigoProduto: Integer; Quantidade: Double; ValorUnitario: Double; ValorTotal: Double);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := FDatabaseConnection;
    SQL.Text := 'UPDATE ItensPedido SET Quantidade = :Quantidade, ValorUnitario = :ValorUnitario, ValorTotal = :ValorTotal ' +
                'WHERE NumeroPedido = :NumeroPedido AND CodigoProduto = :CodigoProduto';
    ParamByName('NumeroPedido').AsInteger := NumeroPedido;
    ParamByName('CodigoProduto').AsInteger := CodigoProduto;
    ParamByName('Quantidade').AsFloat := Quantidade;
    ParamByName('ValorUnitario').AsFloat := ValorUnitario;
    ParamByName('ValorTotal').AsFloat := ValorTotal;
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TItemPedidoRepository.DeletarItensPorPedido(NumeroPedido: Integer);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := FDatabaseConnection;
    SQL.Text := 'DELETE FROM ItensPedido WHERE NumeroPedido = :NumeroPedido';
    ParamByName('NumeroPedido').AsInteger := NumeroPedido;
    ExecSQL;
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

