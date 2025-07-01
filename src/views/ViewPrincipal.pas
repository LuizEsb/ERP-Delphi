unit ViewPrincipal;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.jpeg,
  System.Actions,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ToolWin,
  Vcl.ActnCtrls,
  Vcl.ActnMenus,
  Vcl.Imaging.pngimage,
  Vcl.Buttons,
  ViewClientes,
  ViewLogs, ServiceConexao;

type
  TView_Principal = class(TForm)
    pnlPrincipal: TPanel;
    pnlBackPrincipal: TPanel;
    pnlRodape: TPanel;
    pnlLicenciado: TPanel;
    pnlConteudoLicenca: TPanel;
    lblLicenciado: TLabel;
    lblTitLicenciado: TLabel;
    pnlLineLicenca: TPanel;
    pnlConteudo: TPanel;
    pnlMenu: TPanel;
    pnlSair: TPanel;
    btnSair: TSpeedButton;
    pnlShapeMenu: TPanel;
    ShapeMenu: TShape;
    pnlDadosMenu: TPanel;
    btnLogs: TSpeedButton;
    btnFornecedores: TSpeedButton;
    btnCaixa: TSpeedButton;
    btnUsuarios: TSpeedButton;
    btnProdutos: TSpeedButton;
    pnlTopo: TPanel;
    pnlLogo: TPanel;
    pnlLineLogo: TPanel;
    pnlConteudoLogo: TPanel;
    lblTituloEmpresa: TLabel;
    lblDescricaoEmpresa: TLabel;
    pnlVersao: TPanel;
    lblVersaoTitulo: TLabel;
    lblVersao: TLabel;
    pnlUsuario: TPanel;
    pnlLineUsuario: TPanel;
    pnlImagemUsuario: TPanel;
    imgUsusarioLaranja: TImage;
    imgUsuarioBranca: TImage;
    pnlDadosDoUsuario: TPanel;
    lblUsuario: TLabel;
    lblPerfil: TLabel;
    tmrSessao: TTimer;
    procedure btnSairClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCaixaClick(Sender: TObject);
    procedure btnFornecedoresClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnLogsClick(Sender: TObject);
    procedure tmrSessaoTimer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    procedure GET_ShapeMENU(Sender: TObject);
    procedure CriarViewClientes;
    procedure CriarViewLogs;

  public

  end;

var
  View_Principal: TView_Principal;
  Service_Conexao: TService_Conexao;
  TempoInativo: integer;
  TempoLimite: integer;

implementation
uses
  ViewLogin;

{$R *.dfm}

procedure TView_Principal.btnCaixaClick(Sender: TObject);
begin
  GET_ShapeMENU(Sender);
end;

procedure TView_Principal.btnUsuariosClick(Sender: TObject);
begin
  GET_ShapeMENU(Sender);
  CriarViewClientes;
end;

procedure TView_Principal.CriarViewClientes;
begin
  if not Assigned(View_Clientes) then
    Application.CreateForm(TView_Clientes, View_Clientes);

  View_Clientes.BorderStyle := bsNone;
  View_Clientes.Align := alClient;
  View_Clientes.Parent := pnlConteudo;
  View_Clientes.Visible := True;
  View_Clientes.BringToFront;
  View_Clientes.SetFocus;

end;

procedure TView_Principal.CriarViewLogs;
begin
  if not Assigned(View_Logs) then
    Application.CreateForm(TView_Logs, View_Logs);

  View_Logs.BorderStyle := bsNone;
  View_Logs.Align := alClient;
  View_Logs.Parent := pnlConteudo;
  View_Logs.Visible := True;
  View_Logs.BringToFront;
  View_Logs.SetFocus;
end;

procedure TView_Principal.btnLogsClick(Sender: TObject);
begin
  GET_ShapeMENU(Sender);
  CriarViewLogs;
end;

procedure TView_Principal.btnFornecedoresClick(Sender: TObject);
begin
  GET_ShapeMENU(Sender);
end;

procedure TView_Principal.btnProdutosClick(Sender: TObject);
begin
  GET_ShapeMENU(Sender);
end;

procedure TView_Principal.btnSairClick(Sender: TObject);
begin
  if MessageDlg('Deseja sair da aplicação?' + sLineBreak + 'Todas as alterações não salvas serão descartadas.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Application.Terminate;
    end;
end;

procedure TView_Principal.FormActivate(Sender: TObject);
begin
  TempoInativo := 0;
end;

procedure TView_Principal.FormCreate(Sender: TObject);
begin
  tmrSessao.Enabled := True;
end;

procedure TView_Principal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Service_Conexao);
end;

procedure TView_Principal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TempoInativo := 0;
end;

procedure TView_Principal.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TempoInativo := 0;
end;

procedure TView_Principal.FormShow(Sender: TObject);
begin  //show
  TempoLimite := 5;
  GET_ShapeMENU(btnUsuarios);

  if not Assigned(Service_Conexao) then
    Service_Conexao := TService_Conexao.Create(Application);

  try
    if not Assigned(Service_Conexao.connUsuario) then
    begin
      ShowMessage('Erro: Componente de conexão não foi criado!');
      Exit;
    end;

    if not Service_Conexao.connUsuario.Connected then
    begin
      try
        Service_Conexao.connUsuario.Connected := True;
      except
        on E: Exception do
          ShowMessage('Erro ao conectar: ' + E.Message);
      end;
    end;

  except
    on E: Exception do
      ShowMessage('Erro crítico: ' + E.Message);
  end;
end;

procedure TView_Principal.GET_ShapeMENU(Sender: TObject);
begin
  ShapeMenu.Left    := 0;
  ShapeMenu.Height  := TSpeedButton(Sender).Height;
  ShapeMenu.Top     := TSpeedButton(Sender).Top;
  pnlShapeMenu.Repaint;
end;

procedure TView_Principal.tmrSessaoTimer(Sender: TObject);
begin
  Inc(TempoInativo);

  if TempoInativo >= TempoLimite then
  begin
    View_Principal.tmrSessao.Enabled := False;
    ShowMessage('Sessão expirada por inatividade.');
    Application.Terminate;
  end;
end;

end.
