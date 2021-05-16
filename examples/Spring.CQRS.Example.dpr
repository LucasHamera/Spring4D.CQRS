program Spring.CQRS.Example;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Spring.CQRS.Example.ContainerBuilder in 'Spring.CQRS.Example.ContainerBuilder.pas',
  TodoModule.Registration in 'TodoModule\TodoModule.Registration.pas',
  TodoModule.Domain.Todo in 'TodoModule\Domain\TodoModule.Domain.Todo.pas',
  TodoModule.Domain.Todo.Exceptions in 'TodoModule\Domain\TodoModule.Domain.Todo.Exceptions.pas',
  TodoModule.Application.Command.CreateTodo in 'TodoModule\Application\TodoModule.Application.Command.CreateTodo.pas',
  TodoModule.Domain.TodoRepository in 'TodoModule\Domain\TodoModule.Domain.TodoRepository.pas',
  TodoModule.Infrastructure.InMemoryTodoRepository in 'TodoModule\Infrastructure\TodoModule.Infrastructure.InMemoryTodoRepository.pas',
  TodoModule.Application.Registration in 'TodoModule\Application\TodoModule.Application.Registration.pas',
  TodoModule.Infrastructure.Registration in 'TodoModule\Infrastructure\TodoModule.Infrastructure.Registration.pas',
  TodoModule.Application.Query.GetTodos in 'TodoModule\Application\TodoModule.Application.Query.GetTodos.pas',
  TodoModule.Application.Command.CompleteTodo in 'TodoModule\Application\TodoModule.Application.Command.CompleteTodo.pas',
  TodoModule.Application.Exceptions in 'TodoModule\Application\TodoModule.Application.Exceptions.pas',
  {}
  System.SysUtils,
  Spring.Container,
  Spring.Collections,
  Spring.CQRS.Query,
  Spring.CQRS.Command,
  Spring.CQRS.QueryDispatcher,
  Spring.CQRS.CommandDispatcher;

const
  TODO_NAME = 'Test';

var
  LContainerBuilder: TContainerBuilder;
  LContainer: TContainer;

  LQueryDispatcher: TQueryDispatcher;
  LCommandDispatcher: TCommandDispatcher;

  LTodoId: TGUID;
  LCreateTodo: TCreateTodo;
  LCompleteTodo: TCompleteTodo;

  LGetTodos: TGetTodos;
  LTodos: IEnumerable<TTodo>;

begin
  try
    LContainerBuilder := TContainerBuilder.Create();
    try
      LContainer := LContainerBuilder.Build();
    finally
      FreeAndNil(LContainerBuilder);
    end;

    LQueryDispatcher := LContainer.Resolve<TQueryDispatcher>();
    LCommandDispatcher := LContainer.Resolve<TCommandDispatcher>();

    LTodoId := TGUID.NewGuid();
    LCreateTodo := TCreateTodo.Create(LTodoId, TODO_NAME);
    try
      LCommandDispatcher.Dispatch<TCreateTodo>(LCreateTodo);
    finally
      FreeAndNil(LCreateTodo);
    end;

    LCompleteTodo := TCompleteTodo.Create(LTodoId);
    try
      LCommandDispatcher.Dispatch<TCompleteTodo>(LCompleteTodo);
    finally
      FreeAndNil(LCompleteTodo);
    end;

    LGetTodos := TGetTodos.Create();
    try
      LTodos := LQueryDispatcher.Dispatch<IEnumerable<TTodo>, TGetTodos>(LGetTodos);
    finally
      FreeAndNil(LGetTodos);
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
