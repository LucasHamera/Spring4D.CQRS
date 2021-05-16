unit TodoModule.Infrastructure.Registration;

interface

uses
  Spring.Container;

type
  TTodoModuleInfrastructureRegistration = class abstract
  public
    class procedure Register(const AContainer: TContainer); static;
  end;

implementation

uses
  TodoModule.Domain.TodoRepository,
  TodoModule.Infrastructure.InMemoryTodoRepository;

{ TTodoModuleInfrastructureRegistration }

class procedure TTodoModuleInfrastructureRegistration.Register(const AContainer: TContainer);
begin
  AContainer.RegisterType<ITodoRepository, TTodoRepositoryInMemory>().AsSingleton();
end;

end.
