unit uConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Datasnap.DBClient;

type
  TfrmConsulta = class(TForm)
    pnlRodape: TPanel;
    pnlGrid: TPanel;
    dbGridConsulta: TDBGrid;
    btnSeleciona: TBitBtn;
    btnCancela: TBitBtn;
    cbxOrdem: TComboBox;
    lblOrdem: TLabel;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    procedure btnSelecionaClick(Sender: TObject);
    procedure edtPesquisaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cbxOrdemClick(Sender: TObject);
    procedure cbxOrdemChange(Sender: TObject);
    procedure dbGridConsultaCellClick(Column: TColumn);
  private
    function ReturnFieldName(aTable: TDataSet;
      aFieldName: String): String;
    procedure PreencherComboIndex(aCds: TDataSet; aCombo: TComboBox);
    procedure Atualiza_Indice;
    { Private declarations }
  public
    { Public declarations }
    Selecionou : Boolean;
  end;

var
  frmConsulta: TfrmConsulta;

implementation

{$R *.dfm}

procedure TfrmConsulta.btnSelecionaClick(Sender: TObject);
begin
  Selecionou := True;
end;

procedure TfrmConsulta.cbxOrdemChange(Sender: TObject);
begin
  edtPesquisa.Clear;
end;

procedure TfrmConsulta.cbxOrdemClick(Sender: TObject);
begin
   Atualiza_Indice;
   edtPesquisa.Clear;
end;

procedure TfrmConsulta.dbGridConsultaCellClick(Column: TColumn);
begin
  Selecionou := True;
  Close;
end;

procedure TfrmConsulta.edtPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not dbGridConsulta.DataSource.DataSet.IsEmpty then
  begin
    dbGridConsulta.DataSource.DataSet.Locate(ReturnFieldName(dbGridConsulta.DataSource.DataSet, cbxOrdem.Text), TEdit(Sender).Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TfrmConsulta.FormShow(Sender: TObject);
begin
  PreencherComboIndex(dbGridConsulta.DataSource.DataSet,cbxOrdem);
  dbGridConsulta.DataSource.DataSet.First;
end;

function TfrmConsulta.ReturnFieldName(aTable: TDataSet; aFieldName: String): String;
var
  I: Integer;
begin
  for I := 0 to aTable.Fields.Count - 1 do
  begin
    if aTable.Fields[I].DisplayLabel = aFieldName then
    begin
      Result := aTable.Fields[I].FieldName;
      Break;
    end;
  end;
end;

procedure TfrmConsulta.PreencherComboIndex(aCds: TDataSet; aCombo: TComboBox);
var
  I: Integer;
begin
  aCombo.Items.Clear;
  for I := 0 to aCds.Fields.Count - 1 do
  begin
    aCombo.Items.Add(aCds.Fields[I].DisplayLabel);
  end;
  aCombo.ItemIndex := 0;
end;

procedure TfrmConsulta.Atualiza_Indice;
var
  sNomeIndice, sOrigem: String;
  I, iCol: Integer;
begin
  edtPesquisa.SetFocus;

  for I := 0 to dbGridConsulta.DataSource.DataSet.FieldCount - 1 do
  begin
    if (dbGridConsulta.DataSource.DataSet.Fields[I].DisplayLabel = cbxOrdem.Text) then
    begin
      sNomeIndice := dbGridConsulta.DataSource.DataSet.Fields[I].FieldName;
      sOrigem     := dbGridConsulta.DataSource.DataSet.Fields[I].Origin;
      Break;
    end;
  end;

  iCol := -1;
  for I := 0 to dbGridConsulta.DataSource.DataSet.FieldCount - 1 do begin
    if dbGridConsulta.DataSource.DataSet.Fields[I].Tag = -1 then begin
      Inc(iCol);
      dbGridConsulta.Columns[iCol].FieldName := dbGridConsulta.DataSource.DataSet.Fields[I].FieldName;
      dbGridConsulta.Columns[iCol].Width     := 5;
      dbGridConsulta.Columns[iCol].Visible   := True;
      Break;
    end;
  end;
end;
end.
