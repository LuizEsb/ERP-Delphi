program ERP;

uses
  Vcl.Forms,
  ViewPrincipal in 'src\views\ViewPrincipal.pas' {View_Principal},
  ViewLogin in 'src\views\ViewLogin.pas' {View_Login},
  ServiceConexao in 'src\services\ServiceConexao.pas' {Service_Conexao: TDataModule},
  CriptografiaHelper in 'src\helpers\CriptografiaHelper.pas',
  ViewClientes in 'src\views\ViewClientes.pas' {View_Clientes},
  Utils in 'src\helpers\Utils.pas',
  ViewLogs in 'src\views\ViewLogs.pas' {View_Logs};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TService_Conexao, Service_Conexao);
  View_Login := TView_Login.Create(nil);
  try
    if View_Login.ShowModal = 1 then
    begin
      Application.CreateForm(TView_Principal, View_Principal);
      Application.Run;
    end;
  finally
    View_Login.Free;
  end;

end.
