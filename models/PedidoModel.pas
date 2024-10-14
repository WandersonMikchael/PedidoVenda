unit PedidoModel;

interface

uses
  System.SysUtils, System.Generics.Collections, ItemPedidoModel;

type
  TPedido = class
  private
    FNumeroPedido: Integer;
    FCodigoCliente: Integer;
    FNomeCliente: string;
    FDataEmissao: TDate;
    FValorTotal: Double;
    FItens: TObjectList<TItemPedido>;
    function CalcularValorTotal: Double;

  public
    constructor Create;
    destructor Destroy; override;

    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property NomeCliente: string read FNomeCliente write FNomeCliente;
    property DataEmissao: TDate read FDataEmissao write FDataEmissao;
    property ValorTotal: Double read FValorTotal write FValorTotal;

    property Itens: TObjectList<TItemPedido> read FItens;

    procedure AdicionarItem(AItem: TItemPedido);
    procedure RemoverItem(AItem: TItemPedido);
    procedure AtualizarValorTotal;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  inherited Create;
  FItens := TObjectList<TItemPedido>.Create;
  FDataEmissao := Date;
end;

destructor TPedido.Destroy;
begin
  FItens.Free;
  inherited;
end;

procedure TPedido.AdicionarItem(AItem: TItemPedido);
begin
  FItens.Add(AItem);
  AtualizarValorTotal;
end;

procedure TPedido.RemoverItem(AItem: TItemPedido);
begin
  FItens.Remove(AItem);
  AtualizarValorTotal;
end;

function TPedido.CalcularValorTotal: Double;
var
  Item: TItemPedido;
begin
  Result := 0;
  for Item in FItens do
    Result := Result + Item.ValorTotal;
end;

procedure TPedido.AtualizarValorTotal;
begin
  FValorTotal := CalcularValorTotal;
end;

end.

