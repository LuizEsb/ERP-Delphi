unit ViewClientes;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  Vcl.ComCtrls,
  Vcl.DBCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.WinXCtrls,
  Vcl.WinXPanels,
  ServiceConexao,
  CriptografiaHelper;

type
  TView_Clientes = class(TForm)
    pnlLinhaFundo: TPanel;
    CardPanel_Listas: TCardPanel;
    card_pesquisa: TCard;
    pnlTituloPesquisa: TPanel;
    lblTituloPesquisa: TLabel;
    edtPesquisa: TSearchBox;
    card_cadastro: TCard;
    lblCodigo: TLabel;
    lblSenha: TLabel;
    lblStatus: TLabel;
    lblNome: TLabel;
    pnlTituloCadCliente: TPanel;
    lblTituloCadastro: TLabel;
    pnlRodape: TPanel;
    spdbtnExcluir: TSpeedButton;
    spdbtnNovo: TSpeedButton;
    spdbtnEditar: TSpeedButton;
    spdbtnCancelar: TSpeedButton;
    spdbtnSalvar: TSpeedButton;
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    pnlIcone: TPanel;
    Image1: TImage;
    pnlFechar: TPanel;
    btnSair: TSpeedButton;
    dsDados: TDataSource;
    dbgDados: TDBGrid;
    edtSenha: TDBEdit;
    edtLogin: TDBEdit;
    edtID: TDBEdit;
    edtStatus: TDBComboBox;
    cbxFiltro: TComboBox;
    lblFiltro: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdbtnNovoClick(Sender: TObject);
    procedure spdbtnEditarClick(Sender: TObject);
    procedure spdbtnCancelarClick(Sender: TObject);
    procedure spdbtnSalvarClick(Sender: TObject);
    procedure spdbtnExcluirClick(Sender: TObject);
    procedure CardPanel_ListasCardChange(Sender: TObject; PrevCard,
  NextCard: TCard);
    procedure FormCreate(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function validarPesquisa(aPesquisa: string) : boolean;
    procedure pesquisarDados(aPesquisa: string);
    procedure pesquisarPorID(aPesquisa: string);
    procedure pesquisarPorLogin(aPesquisa: string);
    procedure pesquisaDefault;
  public
    { Public declarations }
  end;

var
  View_Clientes: TView_Clientes;
  Service_Conexao: TService_Conexao;

implementation

{$R *.dfm}


procedure TView_Clientes.btnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja fechar a aba Clientes?' + sLineBreak + 'Todas as alterações não salvas serão descartadas.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Self.Close;
    end;
end;

procedure TView_Clientes.CardPanel_ListasCardChange(Sender: TObject; PrevCard,
  NextCard: TCard);
begin
  if CardPanel_Listas.ActiveCard = card_cadastro then
    SelectFirst;
end;

procedure TView_Clientes.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    pesquisarDados(Trim(edtPesquisa.Text));
  end;
end;

procedure TView_Clientes.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  Align := alClient;
  ParentBackground := False;
end;

procedure TView_Clientes.FormShow(Sender: TObject);
begin  //show
   CardPanel_Listas.ActiveCard := card_pesquisa;
   pesquisaDefault;
end;

procedure TView_Clientes.pesquisaDefault;
begin
  Service_Conexao.qryUsuarios.DisableControls;
   try
     Service_Conexao.qryUsuarios.Close;
     Service_Conexao.qryUsuarios.SQL.Text := 'SELECT * FROM usuarios ORDER BY id DESC';
     Service_Conexao.qryUsuarios.Open;
   finally
     Service_Conexao.qryUsuarios.EnableControls;
   end;
end;

procedure TView_Clientes.pesquisarDados(aPesquisa: string);
begin
  if validarPesquisa(aPesquisa) then
  begin
    if cbxFiltro.Text = 'ID' then
      pesquisarPorID(aPesquisa)
    else
      pesquisarPorLogin(aPesquisa)
  end;
end;

procedure TView_Clientes.pesquisarPorID(aPesquisa: string);
begin
  try
    begin
      Service_Conexao.qryUsuarios.DisableControls;

      Service_Conexao.qryUsuarios.Close;
      Service_Conexao.qryUsuarios.SQL.Clear;

      Service_Conexao.qryUsuarios.SQL.Text := 'select * from USUARIOS where ID like :pesquisa';
      Service_Conexao.qryUsuarios.ParamByName('pesquisa').AsInteger := StrToInt(aPesquisa);

      Service_Conexao.qryUsuarios.Open;
      Service_Conexao.qryUsuarios.EnableControls;
    end;
    except
      on E: exception do
      raise Exception.CreateFmt('Erro ao pesquisar: %s (SQL: %s)', [E.Message, Service_Conexao.qryUsuarios.SQL.Text]);
    end;
end;

procedure TView_Clientes.pesquisarPorLogin(aPesquisa: string);
begin
  try
    begin
      Service_Conexao.qryUsuarios.DisableControls;

      Service_Conexao.qryUsuarios.Close;
      Service_Conexao.qryUsuarios.SQL.Clear;

      Service_Conexao.qryUsuarios.SQL.Text := 'select * from USUARIOS where upper(LOGIN) like :pesquisa';
      Service_Conexao.qryUsuarios.ParamByName('pesquisa').AsString := '%' + UpperCase(aPesquisa) + '%';

      Service_Conexao.qryUsuarios.Open;
      Service_Conexao.qryUsuarios.EnableControls;
    end;
    except
      on E: exception do
      raise Exception.CreateFmt('Erro ao pesquisar: %s (SQL: %s)', [E.Message, Service_Conexao.qryUsuarios.SQL.Text]);
    end;
end;

procedure TView_Clientes.spdbtnCancelarClick(Sender: TObject);
begin  //Cancelar
  if Service_Conexao.qryUsuarios.State in dsEditModes then
  Service_Conexao.qryUsuarios.Cancel;
  CardPanel_Listas.ActiveCard := card_pesquisa;
end;

procedure TView_Clientes.spdbtnEditarClick(Sender: TObject);
begin  //Editar
  CardPanel_Listas.ActiveCard := card_cadastro;
  Service_Conexao.qryUsuarios.Edit;
  edtSenha.Text := '';
end;

procedure TView_Clientes.spdbtnExcluirClick(Sender: TObject);
begin  //Excluir
  if not Service_Conexao.qryUsuarios.IsEmpty then
  begin
    if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Service_Conexao.qryUsuarios.Delete;
      ShowMessage('Cliente excluído com sucesso!');
      CardPanel_Listas.ActiveCard := card_pesquisa;
    end;
  end
  else
  ShowMessage('Nenhum registro selecionado para exclusão.');
end;

procedure TView_Clientes.spdbtnNovoClick(Sender: TObject);
begin  //Novo
  if dsDados.DataSet.State in dsEditModes then
  Service_Conexao.qryUsuarios.Cancel;
  CardPanel_Listas.ActiveCard := card_cadastro;
  Service_Conexao.qryUsuarios.Insert;
  if dsDados.DataSet.State in [dsInsert] then
  edtID.Text := '';
end;

procedure TView_Clientes.spdbtnSalvarClick(Sender: TObject);
begin  //Salvar
  if dsDados.DataSet.State in dsEditModes then
  begin
    Service_Conexao.qryUsuariosSENHA.AsString := TCriptografiaHelper.gerarHashSHA256(edtSenha.Text);
    Service_Conexao.qryUsuarios.Post;
    CardPanel_Listas.ActiveCard := card_pesquisa;
    ShowMessage('Dados salvos com sucesso!');
  end;
end;

function TView_Clientes.validarPesquisa(aPesquisa: string): boolean;
begin
  if aPesquisa = '' then
  begin
    Result := False;
    pesquisaDefault;
    ShowMessage('Insira uma pesquisa válida.');
  end
  else
    Result := True;

end;

end.
