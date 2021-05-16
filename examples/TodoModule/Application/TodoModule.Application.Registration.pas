unit TodoModule.Application.Registration;

interface

uses
  Spring.Container;

type
  TTodoModuleApplicationRegistration = class abstract
  public
    class procedure Register(const AContainer: TContainer); static;
  end;

implementation

uses
  TodoModule.Domain.Todo,
  TodoModule.Application.Query.GetTodos,
  TodoModule.Application.Command.CreateTodo,
  TodoModule.Application.Command.CompleteTodo,
  {}
  Spring.Collections,
  Spring.CQRS.QueryHandler,
  Spring.CQRS.CommandHandler;

{ TTodoModuleApplicationRegistration }

class procedure TTodoModuleApplicationRegistration.Register(const AContainer: TContainer);
begin
  AContainer.RegisterType<IQueryHandler<IEnumerable<TTodo>, TGetTodos>, TGetTodosHandler>();
  AContainer.RegisterType<ICommandHandler<TCreateTodo>, TCreateTodoHandler>();
  AContainer.RegisterType<ICommandHandler<TCompleteTodo>, TCompleteTodoHandler>();
end;

end.
