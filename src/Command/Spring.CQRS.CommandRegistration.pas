unit Spring.CQRS.CommandRegistration;

interface

uses
  Spring.Container;

type
  TCommandRegistration = class abstract
  public
    class procedure Register(const AContainer: TContainer); static;
  end;

implementation

uses
  Spring.CQRS.CommandDispatcher;

{ TCommandRegistration }

class procedure TCommandRegistration.Register(const AContainer: TContainer);
begin
  AContainer.RegisterType<TCommandDispatcher>();
end;

end.
