unit CriptografiaHelper;

interface

uses
  System.Hash;

type
  TCriptografiaHelper = class
  public
    class function gerarHashSHA256(const ATexto : string) : string;

  private

end;

implementation

{ TCriptografiaHelper }

class function TCriptografiaHelper.gerarHashSHA256(const ATexto: string): string;
begin
  Result := THashSHA2.GetHashString(ATexto);
end;

end.
