unit ItemPedidoController;

interface

uses
  ItemPedidoModel, ItemPedidoRepository;

type
  TItemPedidoController = class
  private
    FItemPedidoRepo: TItemPedidoRepository;
  public
    constructor Create(AItemPedidoRepo: TItemPedidoRepository);

    procedure AdicionarItem(NumeroPedido: Integer; AItem: TItemPedido);
    procedure DeletarItensPorPedido(NumeroPedido: Integer);
  end;

implementation

{ TItemPedidoController }

constructor TItemPedidoController.Create(AItemPedidoRepo: TItemPedidoRepository);
begin
  FItemPedidoRepo := AItemPedidoRepo;
end;

procedure TItemPedidoController.AdicionarItem(NumeroPedido: Integer; AItem: TItemPedido);
begin
  FItemPedidoRepo.InserirItem(NumeroPedido, AItem.CodigoProduto, AItem.Quantidade, AItem.ValorUnitario, AItem.ValorTotal);
end;

procedure TItemPedidoController.DeletarItensPorPedido(NumeroPedido: Integer);
begin
  FItemPedidoRepo.DeletarItensPorPedido(NumeroPedido);
end;

end.

