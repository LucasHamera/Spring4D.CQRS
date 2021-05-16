unit TodoModule.Registration;

interface

uses
  Spring.Container;

type
  TTodoModuleRegistration = class abstract
  public
    class procedure Register(const AContainer: TContainer); static;
  end;

implementation

uses
  TodoModule.Application.Registration,
  TodoModule.Infrastructure.Registration;

{ TTodoModuleRegistration }

class procedure TTodoModuleRegistration.Register(const AContainer: TContainer);
begin
  TTodoModuleApplicationRegistration.Register(AContainer);
  TTodoModuleInfrastructureRegistration.Register(AContainer);
end;

end.
