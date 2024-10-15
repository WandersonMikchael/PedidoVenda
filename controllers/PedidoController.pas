unit PedidoController;

interface

uses
  PedidoModel, ItemPedidoModel, PedidoRepository, ItemPedidoRepository,
  System.SysUtils, System.Generics.Collections, Data.DB, FireDAC.Comp.Client;

type
  TPedidoController = class
  private
    FPedidoRepo: TPedidoRepository;
    FItemPedidoRepo: TItemPedidoRepository;

    function CalcularValorTotal(AItens: TObjectList<TItemPedido>): Double;

  public
    constructor Create(APedidoRepo: TPedidoRepository; AItemPedidoRepo: TItemPedidoRepository);

    function CriarPedido(APedido: TPedido): Integer;
    procedure DeletarPedido(NumeroPedido: Integer);
    function CarregarPedido(NumeroPedido: Integer): TPedido;
  end;

implementation

{ TPedidoController }

constructor TPedidoController.Create(APedidoRepo: TPedidoRepository; AItemPedidoRepo: TItemPedidoRepository);
begin
  FPedidoRepo := APedidoRepo;
  FItemPedidoRepo := AItemPedidoRepo;
end;

function TPedidoController.CalcularValorTotal(AItens: TObjectList<TItemPedido>): Double;
var
  Item: TItemPedido;
begin
  Result := 0;
  for Item in AItens do
    Result := Result + Item.ValorTotal;
end;

function TPedidoController.CriarPedido(APedido: TPedido): Integer;
var
  NumeroPedido: Integer;
  Item: TItemPedido;
begin
  APedido.AtualizarValorTotal;

  NumeroPedido := FPedidoRepo.InserirPedido(APedido.CodigoCliente, APedido.ValorTotal);

  for Item in APedido.Itens do
  begin
    FItemPedidoRepo.InserirItem(NumeroPedido, Item.CodigoProduto, Item.Quantidade, Item.ValorUnitario, Item.ValorTotal);
  end;

  Result := NumeroPedido;
end;

procedure TPedidoController.DeletarPedido(NumeroPedido: Integer);
begin
  FItemPedidoRepo.DeletarItensPorPedido(NumeroPedido);
  FPedidoRepo.DeletarPedido(NumeroPedido);
end;

function TPedidoController.CarregarPedido(NumeroPedido: Integer): TPedido;
var
  Pedido: TPedido;
  Item: TItemPedido;
  QryPedido, QryItens: TFDQuery;
  i:Integer;
begin
  QryPedido := FPedidoRepo.ObterPedido(NumeroPedido);
  try
    if not QryPedido.IsEmpty then
    begin
      Pedido := TPedido.Create;
      Pedido.NumeroPedido := NumeroPedido;
      Pedido.CodigoCliente := QryPedido.FieldByName('CodigoCliente').AsInteger;
      Pedido.ValorTotal := QryPedido.FieldByName('ValorTotal').AsFloat;
      Pedido.DataEmissao := QryPedido.FieldByName('DataEmissao').AsDateTime;

      QryItens := FItemPedidoRepo.ObterItensPorPedido(NumeroPedido);
      try
        i := 0;
        while not QryItens.Eof do
        begin
          Inc(i);
          Item := TItemPedido.Create(i, QryItens.FieldByName('CodigoProduto').AsInteger, QryItens.FieldByName('Descricao').AsString,
            QryItens.FieldByName('Quantidade').AsInteger, QryItens.FieldByName('ValorUnitario').AsFloat);
          Pedido.AdicionarItem(Item);
          QryItens.Next;
        end;
      finally
        QryItens.Free;
      end;
    end
    else
      raise Exception.Create('Pedido não encontrado.');
  finally
    QryPedido.Free;
  end;
  Result := Pedido;
end;

end.

