unit Spring.CQRS.Registration;

interface

uses
  Spring.Container;

type
  TCQRSRegistration = class abstract
  public
    class procedure Register(const AContainer: TContainer); static;
  end;

implementation

uses
  Spring.CQRS.QueryRegistration,
  Spring.CQRS.CommandRegistration;

{ TCQRSRegistration }

class procedure TCQRSRegistration.Register(const AContainer: TContainer);
begin
  TQueryRegistration.Register(AContainer);
  TCommandRegistration.Register(AContainer);
end;

end.
