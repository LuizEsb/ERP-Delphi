unit ServiceConexao;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Utils,
  StrUtils,
  Forms,
  Math,
  Dialogs,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.UI;

type
  TService_Conexao = class(TDataModule)
    connUsuario: TFDConnection;
    qryLogin: TFDQuery;
    qryLogLogin: TFDQuery;
    WaitCursor: TFDGUIxWaitCursor;
    FBDriverLink: TFDPhysFBDriverLink;
    qryUsuarios: TFDQuery;
    qryUsuariosLOGIN: TStringField;
    qryUsuariosSTATUS: TStringField;
    qryUsuariosSENHA: TStringField;
    qryUsuariosID: TFDAutoIncField;
    qryUsuariosULTIMO_LOG: TSQLTimeStampField;
    qryLogLoginID: TIntegerField;
    qryLogLoginID_USUARIO: TIntegerField;
    qryLogLoginDATA_HORA_LOGIN: TSQLTimeStampField;
    qryLogLoginSUCESSO: TStringField;
    qryLogLoginREGISTRO_MAC_PC: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function validarLogin (ALogin, ASenha : string) : boolean;
    procedure registrarLogLogin (idUsuario: integer; Sucesso: boolean);
    procedure atualizaUltimoLog (idUsuario: integer);

  end;

var
  Service_Conexao: TService_Conexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses CriptografiaHelper;

{$R *.dfm}

{ TDataModule1 }

{$REGION 'Métodos Logs'}

procedure TService_Conexao.registrarLogLogin(IDUsuario: integer; Sucesso: boolean);
begin
  if not connUsuario.Connected then
    connUsuario.Connected := True;

  qryLogLogin.Close;
  qryLogLogin.SQL.Clear;

  qryLogLogin.SQL.Text := 'insert into LOG_LOGIN (ID_USUARIO, DATA_HORA_LOGIN, SUCESSO, REGISTRO_MAC_PC) ' +
  'VALUES (:id_usuario, CURRENT_TIMESTAMP, :sucesso, :registro_mac_pc)';

  qryLogLogin.ParamByName('id_usuario').AsInteger := IDUsuario;
  qryLogLogin.ParamByName('sucesso').AsString := IfThen(Sucesso, 'SIM', 'NAO');
  qryLogLogin.ParamByName('registro_mac_pc').AsString := ObterMACAddr;

  qryLogLogin.ExecSQL;
end;

procedure TService_Conexao.atualizaUltimoLog(idUsuario: integer);
begin
  if not connUsuario.Connected then
    connUsuario.Connected := True;

  try
  begin
    qryLogin.Close;
    qryLogin.SQL.Clear;
    qryLogin.SQL.Text := 'update USUARIOS set ULTIMO_LOG = CURRENT_TIMESTAMP where ID = :id_usuario';

    qryLogin.ParamByName('id_usuario').AsInteger := idUsuario;
    qryLogin.ExecSQL;
    end;
  except
    on E: exception do
    raise Exception.CreateFmt('Erro ao atualizar registro de login mais recente: %s (SQL: %s)', [E.Message, qryLogin.SQL.Text]);
  end;
end;

{$ENDREGION}

{$REGION 'Métodos DataModule/ConexãoDB'}

procedure TService_Conexao.DataModuleCreate(Sender: TObject);
var
  DiretorioSistema: string;
  ArquivoDiretorio: TStringList;
  ConexaoStr: string;
begin
  DiretorioSistema := ExtractFilePath(Application.ExeName);
  ArquivoDiretorio := TStringList.Create;
  try
    ArquivoDiretorio.LoadFromFile(DiretorioSistema + 'Caminho.ini');
    ConexaoStr := ArquivoDiretorio[0].Trim;

    // verifica se é conexão de rede
    if (ConexaoStr.Contains(':\')) and  // drive (C:\)
       (ConexaoStr.IndexOf(':') = ConexaoStr.IndexOf(':\')) then
    begin
      // é um caminho local
      connUsuario.Params.Values['Database'] := ConexaoStr;
    end
    else if (ConexaoStr.CountChar(':') = 2) and  // tem dois ":" (IP:porta:path)
            (ConexaoStr.Contains('/')) then      // tem a barra da porta
    begin
      // é conexão de rede (ex: "127.0.0.1/3050:C:\DB\BANCOPROJ.FDB")
      connUsuario.Params.Values['Server'] := ConexaoStr.Substring(0, ConexaoStr.IndexOf(':'));
      connUsuario.Params.Values['Database'] := ConexaoStr.Substring(ConexaoStr.LastIndexOf(':') + 1);
    end
    else
    begin
      ShowMessage('Formato de conexão inválido no arquivo Caminho.ini');
      raise Exception.Create('Formato de conexão inválido no arquivo Caminho.ini');
    end;

    connUsuario.Connected := True;
  finally
    ArquivoDiretorio.Free;
  end;
end;

{$ENDREGION}

{$REGION 'Métodos Login'}

function TService_Conexao.validarLogin(ALogin, ASenha : string) : boolean;
var
  Hash : string;
  IDUsuario: Integer;
begin
  if not connUsuario.Connected then
    connUsuario.Connected := True;

  qryLogin.Close;
  qryLogin.SQL.Clear;

  qryLogin.SQL.Text := 'select * from USUARIOS where LOGIN = :LOGIN and SENHA = :SENHA and STATUS =''ATIVO''';

  Hash := TCriptografiaHelper.GerarHashSHA256(ASenha);

  qryLogin.ParamByName('LOGIN').DataType := ftString;
  qryLogin.ParamByName('LOGIN').AsString := ALogin;

  qryLogin.ParamByName('SENHA').DataType := ftString;
  qryLogin.ParamByName('SENHA').AsString := Hash;

  try
    qryLogin.Open;
    if not qryLogin.IsEmpty then
    begin
      IDUsuario := qryLogin.FieldByName('ID').AsInteger;
      Result := True;
      atualizaUltimoLog(IDUsuario);
    end
    else
    begin
      IDUsuario := 0;
      Result := False;
    end;

  except
    on E: exception do
    begin
      IDUsuario := 0;
      Result := False;
      raise Exception.CreateFmt('Erro ao validar login: %s (SQL: %s)', [E.Message, qryLogin.SQL.Text]);
    end;
  end;

  registrarLogLogin(IDUsuario, Result);
end;

{$ENDREGION}

end.
