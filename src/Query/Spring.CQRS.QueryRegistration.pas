unit Spring.CQRS.QueryRegistration;

interface

uses
  Spring.Container;

type
  TQueryRegistration = class abstract
  public
    class procedure Register(const AContainer: TContainer); static;
  end;

implementation

uses
  Spring.CQRS.QueryDispatcher;

{ TQueryRegistration }

class procedure TQueryRegistration.Register(const AContainer: TContainer);
begin
  AContainer.RegisterType<TQueryDispatcher>();
end;

end.
