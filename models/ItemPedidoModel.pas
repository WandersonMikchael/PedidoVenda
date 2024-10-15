unit ItemPedidoModel;

interface

type
  TItemPedido = class
  private
    FIdItem: Integer;
    FCodigoProduto: Integer;
    FDescricaoProduto: string;
    FQuantidade: Double;
    FValorUnitario: Double;
    FValorTotal: Double;

    procedure CalcularValorTotal;

  public
    constructor Create(AIdItem, ACodigoProduto: Integer; ADescricaoProduto: string; AQuantidade: Double; AValorUnitario: Double);

    property IdItem: Integer read FIdItem write FIdItem;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property DescricaoProduto: string read FDescricaoProduto write FDescricaoProduto;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal;

    procedure AtualizarQuantidade(AQuantidade: Double);
  end;

implementation

{ TItemPedido }

constructor TItemPedido.Create(AIdItem, ACodigoProduto: Integer; ADescricaoProduto: string; AQuantidade: Double; AValorUnitario: Double);
begin
  FIdItem := AIdItem;
  FCodigoProduto := ACodigoProduto;
  FDescricaoProduto := ADescricaoProduto;
  FQuantidade := AQuantidade;
  FValorUnitario := AValorUnitario;

  CalcularValorTotal;
end;

procedure TItemPedido.CalcularValorTotal;
begin
  FValorTotal := FQuantidade * FValorUnitario;
end;

procedure TItemPedido.AtualizarQuantidade(AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
  CalcularValorTotal;
end;

end.

