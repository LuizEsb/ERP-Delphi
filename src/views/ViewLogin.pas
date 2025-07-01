unit ViewLogin;

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
  Vcl.Buttons,
  ServiceConexao,
  CriptografiaHelper;

type
  TView_Login = class(TForm)
    pnlPrincipal: TPanel;
    pnlLogin: TPanel;
    lblUser: TLabel;
    lblSenha: TLabel;
    edtUser: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    btnEntrar: TButton;
    lblEsqueciSenha: TLabel;
    btnSair: TSpeedButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure lblEsqueciSenhaClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtUserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);

  private
    Tentativas: integer;
    function validarUser(AUser : string) : boolean;
    function validarSenha(ASenha : string) : boolean;
    function validarCampos : boolean;
    procedure maxTentativas;
  public

  end;

var
  View_Login: TView_Login;

implementation

uses
  ViewPrincipal;

{$R *.dfm}

procedure TView_Login.btnEntrarClick(Sender: TObject);
var
  User, Senha : string;
begin
  User := edtUser.Text;
  Senha := edtSenha.Text;
  if validarCampos then
  begin
    if Service_Conexao.validarLogin(User, Senha) then
    begin
      ModalResult	:= 1;
      if not assigned(View_Principal) then
        Application.CreateForm(TView_Principal, View_Principal);
      View_Principal.Show;
      Self.Hide;
    end
    else
    begin
      Tentativas := Tentativas - 1;
      maxTentativas;
      edtSenha.Text := '';
      edtUser.Text := '';
      edtUser.SetFocus;
    end;
  end;
end;

procedure TView_Login.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TView_Login.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnEntrarClick(Sender);
end;

procedure TView_Login.edtUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edtSenha.SetFocus;
end;

procedure TView_Login.FormCreate(Sender: TObject);
begin
  Service_Conexao := TService_Conexao.Create(Application);
end;

procedure TView_Login.FormShow(Sender: TObject);
begin
  edtUser.Text := '';
  edtSenha.Text := '';
  edtUser.SetFocus;
  Tentativas := 5;
end;

procedure TView_Login.lblEsqueciSenhaClick(Sender: TObject);
begin
  if MessageDlg('Deseja alterar sua senha?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    //
  end;
end;
procedure TView_Login.maxTentativas;
begin
  if Tentativas = 0 then
  begin
    MessageDlg('Número máximo de tentativas excedido.', mtError, [mbOK], 0);
    Application.Terminate;
  end
  else
  MessageDlg('Credenciais inválidas!' + sLineBreak + 'Tentativas restantes: ' + intToStr(Tentativas), mtWarning, [mbOK], 0);
end;

function TView_Login.validarCampos: boolean;
begin
  Result := False;
  if validarUser(trim(edtUser.Text)) and validarSenha(trim(edtSenha.Text)) then
    Result := True;
end;

function TView_Login.validarSenha(ASenha: string): boolean;
begin
  Result := True;
  if ASenha = '' then
  begin
    MessageDlg('Digite uma senha válida!', mtWarning, [mbOK], 0);
    Result := False;
  end;
end;

function TView_Login.validarUser(AUser : string) : boolean;
begin
  Result := True;
  if AUser = '' then
    begin
    MessageDlg('Digite um usuário válido!', mtWarning, [mbOK], 0);
    Result := False;
    end;
end;

end.
