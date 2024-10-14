program WkPedidoVenda;

uses
  Vcl.Forms,
  UnPrincipal in 'views\UnPrincipal.pas' {frmPedidoVenda},
  uConsulta in 'views\uConsulta.pas' {frmConsulta},
  uDmWkPedidoVenda in 'Database\uDmWkPedidoVenda.pas' {ConexaoBanco: TDataModule},
  UiniUtils in 'utils\UiniUtils.pas',
  UresourceUtils in 'utils\UresourceUtils.pas',
  PedidoModel in 'models\PedidoModel.pas',
  ItemPedidoModel in 'models\ItemPedidoModel.pas',
  PedidoController in 'controllers\PedidoController.pas',
  ItemPedidoController in 'controllers\ItemPedidoController.pas',
  PedidoRepository in 'repositories\PedidoRepository.pas',
  ItemPedidoRepository in 'repositories\ItemPedidoRepository.pas',
  uDatabaseManager in 'utils\uDatabaseManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConexaoBanco, ConexaoBanco);
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.Run;
end.
