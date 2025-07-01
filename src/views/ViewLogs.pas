unit ViewLogs;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.WinXCtrls,
  Vcl.WinXPanels,
  ServiceConexao;

type
  TView_Logs = class(TForm)
    dsDados: TDataSource;
    pnlLinhaFundo: TPanel;
    CardPanel_Listas: TCardPanel;
    card_pesquisa: TCard;
    pnlTituloPesquisa: TPanel;
    lblTituloPesquisa: TLabel;
    edtPesquisa: TSearchBox;
    DBG_dados: TDBGrid;
    pnlRodape: TPanel;
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    pnlIcone: TPanel;
    Image1: TImage;
    pnlFechar: TPanel;
    btnSair: TSpeedButton;
    cbxFiltro: TComboBox;
    lblFiltro: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pesquisarPorID(aPesquisa: string);
    procedure pesquisarPorIDUser(aPesquisa: string);
    procedure pesquisaDefault;
    procedure pesquisarDados(aPesquisa: string);
    function validarPesquisa(aPesquisa: string): boolean;
  public
    { Public declarations }
  end;

var
  View_Logs: TView_Logs;
  Service_Conexao: TService_Conexao;

implementation

{$R *.dfm}

procedure TView_Logs.btnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TView_Logs.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    pesquisarDados(Trim(edtPesquisa.Text))
end;

procedure TView_Logs.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  Align := alClient;
  ParentBackground := False;
end;

procedure TView_Logs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
  Self.Close;
end;

procedure TView_Logs.FormShow(Sender: TObject);
begin
  pesquisaDefault;
end;

procedure TView_Logs.pesquisaDefault;
begin
  Service_Conexao.qryLogLogin.DisableControls;
   try
     Service_Conexao.qryLogLogin.Close;
     Service_Conexao.qryLogLogin.SQL.Text := 'SELECT * FROM log_login ORDER BY id DESC';
     Service_Conexao.qryLogLogin.Open;
   finally
     Service_Conexao.qryLogLogin.EnableControls;
   end;
end;

procedure TView_Logs.pesquisarDados(aPesquisa: string);
begin
  if validarPesquisa(aPesquisa) then
  begin
    if cbxFiltro.Text = 'ID' then
      pesquisarPorID(aPesquisa)
    else
      pesquisarPorIDUser(aPesquisa);
  end;
end;

procedure TView_Logs.pesquisarPorID(aPesquisa: string);
begin
  try
    begin
      Service_Conexao.qryLogLogin.DisableControls;

      Service_Conexao.qryLogLogin.Close;
      Service_Conexao.qryLogLogin.SQL.Clear;

      Service_Conexao.qryLogLogin.SQL.Text := 'select * from LOG_LOGIN where ID like :pesquisa';
      Service_Conexao.qryLogLogin.ParamByName('pesquisa').AsInteger := StrToInt(aPesquisa);

      Service_Conexao.qryLogLogin.Open;
      Service_Conexao.qryLogLogin.EnableControls;
    end;
    except
      on E: exception do
      raise Exception.CreateFmt('Erro ao pesquisar: %s (SQL: %s)', [E.Message, Service_Conexao.qryLogLogin.SQL.Text]);
  end;
end;

procedure TView_Logs.pesquisarPorIDUser(aPesquisa: string);
begin
  try
    begin
      Service_Conexao.qryLogLogin.DisableControls;

      Service_Conexao.qryLogLogin.Close;
      Service_Conexao.qryLogLogin.SQL.Clear;

      Service_Conexao.qryLogLogin.SQL.Text := 'select * from LOG_LOGIN where ID_USUARIO like :pesquisa order by ID desc';
      Service_Conexao.qryLogLogin.ParamByName('pesquisa').AsInteger := StrToInt(aPesquisa);

      Service_Conexao.qryLogLogin.Open;
      Service_Conexao.qryLogLogin.EnableControls;
    end;
    except
      on E: exception do
      raise Exception.CreateFmt('Erro ao pesquisar: %s (SQL: %s)', [E.Message, Service_Conexao.qryLogLogin.SQL.Text]);
  end;
end;

function TView_Logs.validarPesquisa(aPesquisa: string): boolean;
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
