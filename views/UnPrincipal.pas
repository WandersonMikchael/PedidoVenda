unit UnPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDmWkPedidoVenda,
  uDatabaseManager, PedidoModel, ItemPedidoModel, PedidoController, ItemPedidoController,
  PedidoRepository, ItemPedidoRepository;

type
  TfrmPedidoVenda = class(TForm)
    pnlPrincipal: TPanel;
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    dbgrdProdutos: TDBGrid;
    pnlTotalizacao: TPanel;
    btnGravar: TButton;
    statOpcoes: TStatusBar;
    edtCliente: TEdit;
    edtProduto: TEdit;
    edtQtde: TEdit;
    edtVlrUnit: TEdit;
    lblCodCliente: TLabel;
    lblProduto: TLabel;
    lblQtde: TLabel;
    lblVlrUnit: TLabel;
    btnCliente: TImage;
    btnProduto: TImage;
    pnlBtnSalvar: TPanel;
    cdsItensPedido: TClientDataSet;
    dsItensPedido: TDataSource;
    Label1: TLabel;
    edtNomeProduto: TEdit;
    edtNomeCliente: TEdit;
    lblNomeCliente: TLabel;
    lblNomeProduto: TLabel;
    strngfldItensPedidoCodigoProduto: TStringField;
    strngfldItensPedidoDescricaoProduto: TStringField;
    fltfldItensPedidoQuantidade: TFloatField;
    fltfldItensPedidoValorUnitario: TFloatField;
    fltfldItensPedidoValorTotal: TFloatField;
    pnlConsultarPedido: TPanel;
    btnConsultarPedido: TSpeedButton;
    pnlExcluirPedido: TPanel;
    btnCancelarPedido: TSpeedButton;
    pnlCancelar: TPanel;
    btnCancelar: TButton;
    btnAdicionar: TButton;
    cdsItensPedidoIdItem: TIntegerField;
    procedure btnClienteClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbgrdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);

    function ConsultarNroPedidoVenda:Integer;
  private
    { Private declarations }
    NroPedido: Integer;
    PedidoManager: TPedidoController;
    DatabaseManager: TDatabaseManager;
    Pedido: TPedido;

    procedure AtualizaTotal;
    procedure BloquearCamposCliente(Acao: Boolean);
    procedure LimparCamposProduto;
    procedure LimparTela;
    procedure CarregarObjetoPedidoItens;
    function RetornarIdItem: Integer;
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
  uConsulta;

{$R *.dfm}

function TfrmPedidoVenda.RetornarIdItem:Integer;
begin
  if cdsItensPedido.RecordCount = 0 then
    Result := 1
  else
  begin
    cdsItensPedido.Last;
    Result := cdsItensPedido.FieldByName('IdItem').AsInteger + 1;
  end;
end;

procedure TfrmPedidoVenda.btnAdicionarClick(Sender: TObject);
begin
  if (edtProduto.Text <> '') and (edtQtde.Text <> '') and (edtVlrUnit.Text <> '') then
  begin

    if cdsItensPedido.State <> dsEdit then
    begin
      var NewID := RetornarIdItem;
      cdsItensPedido.Append;
      cdsItensPedido.FieldByName('IdItem').AsInteger := NewID;
    end;

    cdsItensPedido.FieldByName('CodigoProduto').AsInteger := StrToInt(edtProduto.Text);
    cdsItensPedido.FieldByName('DescricaoProduto').AsString := edtNomeProduto.Text;
    cdsItensPedido.FieldByName('Quantidade').AsFloat := StrToFloat(edtQtde.Text);
    cdsItensPedido.FieldByName('ValorUnitario').AsFloat := StrToFloat(edtVlrUnit.Text);
    cdsItensPedido.FieldByName('ValorTotal').AsFloat := (StrToFloat(edtQtde.Text) * StrToFloat(edtVlrUnit.Text));
    cdsItensPedido.Post;

    AtualizaTotal;
    LimparCamposProduto;
    edtProduto.SetFocus;
  end;
end;

procedure TfrmPedidoVenda.btnClienteClick(Sender: TObject);
begin
  frmConsulta := TfrmConsulta.Create(Self);
  DatabaseManager.AtualizarDados(tpCliente);

  try
    frmConsulta.dbGridConsulta.DataSource := DatabaseManager.GetDataSourceCliente;
    frmConsulta.Caption := 'Consulta de Clientes';
    frmConsulta.ShowModal;

    if frmConsulta.Selecionou then
    begin
      edtCliente.Text := frmConsulta.dbGridConsulta.DataSource.DataSet.FieldByName('Codigo').Value;
      edtNomeCliente.Text := frmConsulta.dbGridConsulta.DataSource.DataSet.FieldByName('Nome').Value;
      BloquearCamposCliente(True);
      Pedido.CodigoCliente := StrToInt(edtCliente.Text);
    end;
  finally
    FreeAndNil(frmConsulta);
  end;
end;

procedure TfrmPedidoVenda.btnConsultarPedidoClick(Sender: TObject);
begin
  NroPedido := ConsultarNroPedidoVenda;
  try
    LimparTela;
    Pedido := PedidoManager.CarregarPedido(NroPedido);
    edtCliente.Text := IntToStr(Pedido.CodigoCliente);
    edtNomeCliente.Text := Pedido.NomeCliente;
    BloquearCamposCliente(True);

    for var Item in Pedido.Itens do
    begin
      cdsItensPedido.Append;
      cdsItensPedido.FieldByName('IdItem').AsInteger := Item.IdItem;
      cdsItensPedido.FieldByName('CodigoProduto').AsInteger := Item.CodigoProduto;
      cdsItensPedido.FieldByName('DescricaoProduto').AsString := Item.DescricaoProduto;
      cdsItensPedido.FieldByName('Quantidade').AsFloat := Item.Quantidade;
      cdsItensPedido.FieldByName('ValorUnitario').AsFloat := Item.ValorUnitario;
      cdsItensPedido.FieldByName('ValorTotal').AsFloat := Item.ValorTotal;
      cdsItensPedido.Post;
    end;

    AtualizaTotal;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar o pedido: ' + E.Message);
  end;
end;

procedure TfrmPedidoVenda.CarregarObjetoPedidoItens;
begin
  cdsItensPedido.First;

  while not cdsItensPedido.Eof do
  begin
    var NovoItem := TItemPedido.Create(cdsItensPedido.FieldByName('IdItem').AsInteger,
                                      cdsItensPedido.FieldByName('CodigoProduto').AsInteger,
                                      cdsItensPedido.FieldByName('DescricaoProduto').AsString,
                                      cdsItensPedido.FieldByName('Quantidade').AsFloat,
                                      cdsItensPedido.FieldByName('ValorUnitario').AsFloat);

    Pedido.AdicionarItem(NovoItem);
    cdsItensPedido.Next;
  end;

end;

procedure TfrmPedidoVenda.btnGravarClick(Sender: TObject);
begin
  try
    CarregarObjetoPedidoItens;
    var NroPedido := PedidoManager.CriarPedido(Pedido);
    LimparTela;
    BloquearCamposCliente(False);
    ShowMessage('Pedido de Venda Nro. '+IntToStr(NroPedido)+' gravado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao gravar o pedido: ' + E.Message);
  end;

  cdsItensPedido.EmptyDataSet;
  AtualizaTotal;
end;

procedure TfrmPedidoVenda.btnProdutoClick(Sender: TObject);
begin
  frmConsulta := TfrmConsulta.Create(Self);
  DatabaseManager.AtualizarDados(tpProduto);
  try
    frmConsulta.dbGridConsulta.DataSource := DatabaseManager.GetDataSourceProduto;
    frmConsulta.Caption := 'Consulta de Produtos';
    frmConsulta.ShowModal;

    if frmConsulta.Selecionou then
    begin
      edtProduto.Text := frmConsulta.dbGridConsulta.DataSource.DataSet.FieldByName('Codigo').Value;
      edtNomeProduto.Text := frmConsulta.dbGridConsulta.DataSource.DataSet.FieldByName('Descricao').Value;
      edtVlrUnit.Text := FloatToStr(frmConsulta.dbGridConsulta.DataSource.DataSet.FieldByName('PrecoVenda').Value);
    end;

  finally
    FreeAndNil(frmConsulta);
  end;
end;

function TfrmPedidoVenda.ConsultarNroPedidoVenda: Integer;
begin
  frmConsulta := TfrmConsulta.Create(Self);
  DatabaseManager.AtualizarDados(tpPedido);
  try
    frmConsulta.dbGridConsulta.DataSource := DatabaseManager.GetDataSourcePedido;
    frmConsulta.Caption := 'Consulta de Pedido de Venda';
    frmConsulta.ShowModal;

    if frmConsulta.Selecionou then
    begin
      Result := frmConsulta.dbGridConsulta.DataSource.DataSet.FieldByName('NumeroPedido').Value;
    end;

  finally
    FreeAndNil(frmConsulta);
  end;
end;

procedure TfrmPedidoVenda.dbgrdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if MessageDlg('Deseja excluir o produto selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      cdsItensPedido.Delete;
      AtualizaTotal;
    end;
  end
  else if Key = VK_RETURN then
  begin
    cdsItensPedido.Edit;
    edtProduto.Text := cdsItensPedido.FieldByName('CodigoProduto').AsString;
    edtNomeProduto.Text := cdsItensPedido.FieldByName('DescricaoProduto').AsString;
    edtQtde.Text := FloatToStr(cdsItensPedido.FieldByName('Quantidade').AsFloat);
    edtVlrUnit.Text := FloatToStr(cdsItensPedido.FieldByName('ValorUnitario').AsFloat);

    //Foco no campo Quantidade
    edtQtde.SetFocus;
  end;
end;

procedure TfrmPedidoVenda.BloquearCamposCliente(Acao: Boolean);
begin
  if Acao then
  begin
    edtCliente.Enabled := False;
    edtNomeCliente.Enabled := False;
    btnCliente.Enabled := False;
    pnlConsultarPedido.Visible := False;
    pnlExcluirPedido.Visible := False;
  end
  else
  begin
    edtCliente.Enabled := True;
    edtNomeCliente.Enabled := True;
    btnCliente.Enabled := True;
    pnlConsultarPedido.Visible := True;
    pnlExcluirPedido.Visible := True;
    edtCliente.SetFocus;
  end;
end;

procedure TfrmPedidoVenda.LimparCamposProduto;
begin
  edtProduto.Clear;
  edtQtde.Clear;
  edtVlrUnit.Clear;
  edtNomeProduto.Clear;
end;

procedure TfrmPedidoVenda.LimparTela;
begin
  edtCliente.Clear;
  edtNomeCliente.Clear;
  edtProduto.Clear;
  edtQtde.Clear;
  edtVlrUnit.Clear;
  edtNomeProduto.Clear;
  pnlTotalizacao.Caption := EmptyStr;
  cdsItensPedido.EmptyDataSet;
  Pedido.Free;
  Pedido := TPedido.Create;
end;

procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  LimparTela;
  BloquearCamposCliente(False);
end;

procedure TfrmPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
begin
  NroPedido := ConsultarNroPedidoVenda;
  try
    LimparTela;
    PedidoManager.DeletarPedido(NroPedido);
    BloquearCamposCliente(False);
    ShowMessage('Pedido de Venda deletado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao cancelar o pedido: ' + E.Message);
  end;
end;

procedure TfrmPedidoVenda.edtClienteExit(Sender: TObject);
var
  NomeCliente: string;
begin
  if edtCliente.Text <> '' then
  begin
    if not DatabaseManager.ClienteExiste(StrToInt(edtCliente.Text), NomeCliente) then
    begin
      ShowMessage('Cliente não encontrado.');
      edtCliente.Clear;
    end
    else
    begin
      edtNomeCliente.Text := NomeCliente;
      BloquearCamposCliente(True);
      Pedido.CodigoCliente := StrToInt(edtCliente.Text);
    end;
  end;
end;

procedure TfrmPedidoVenda.edtProdutoExit(Sender: TObject);
var
  ValorUnitario: Double;
  DescricaoProduto: string;
begin
  if edtProduto.Text <> '' then
  begin
    if not DatabaseManager.ProdutoExiste(StrToInt(edtProduto.Text), ValorUnitario, DescricaoProduto) then
    begin
      ShowMessage('Produto não encontrado.');
      edtProduto.Clear;
      edtVlrUnit.Clear;
      edtProduto.SetFocus;
    end
    else
    begin
      edtVlrUnit.Text := FloatToStr(ValorUnitario);
      edtNomeProduto.Text := DescricaoProduto;
    end;
  end;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  try
    ConexaoBanco.DataModuleCreate(Self);
    DatabaseManager := TDatabaseManager.Create(ConexaoBanco.cnxBancoDeDados); // Conexão do DataModule
    PedidoManager := TPedidoController.Create(TPedidoRepository.Create(ConexaoBanco.cnxBancoDeDados),
                                               TItemPedidoRepository.Create(ConexaoBanco.cnxBancoDeDados));
    Pedido := TPedido.Create;
  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao conectar ao banco de dados: ' + E.Message);
  end;
end;

procedure TfrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DatabaseManager);
  FreeAndNil(PedidoManager);
  FreeAndNil(Pedido);
end;

procedure TfrmPedidoVenda.FormShow(Sender: TObject);
begin
  LimparTela;
end;

procedure TfrmPedidoVenda.AtualizaTotal;
var
  Total: Double;
begin
  Total := 0;
  cdsItensPedido.DisableControls;
  try
    cdsItensPedido.First;
    while not cdsItensPedido.Eof do
    begin
      Total := Total + cdsItensPedido.FieldByName('ValorTotal').AsFloat;
      cdsItensPedido.Next;
    end;
  finally
    cdsItensPedido.EnableControls;
  end;
  pnlTotalizacao.Caption := 'Valor Total do Pedido: ' + FormatFloat('R$ ,0.00', Total);
end;

end.

