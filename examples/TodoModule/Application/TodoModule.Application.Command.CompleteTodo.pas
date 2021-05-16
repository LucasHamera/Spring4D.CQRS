unit TodoModule.Application.Command.CompleteTodo;

interface

uses
  TodoModule.Domain.TodoRepository,
  {}
  Spring.CQRS.Command,
  Spring.CQRS.CommandHandler;

type
  TCompleteTodo = class(TInterfacedObject, ICommand)
  strict private
    FId: TGUID;

  public
    constructor Create(const AId: TGUID);

    property Id: TGUID read FId;
  end;

  TCompleteTodoHandler = class(TInterfacedObject, ICommandHandler<TCompleteTodo>)
  strict private
    fTodoRepository: ITodoRepository;

  public
    constructor Create(const ATodoRepository: ITodoRepository);

    procedure Handle(const ACommand: TCompleteTodo);
  end;

implementation

uses
  TodoModule.Domain.Todo,
  TodoModule.Application.Exceptions;

{ TCompleteTodo }

constructor TCompleteTodo.Create(const AId: TGUID);
begin
  FId := AId;
end;

{ TCompleteTodoHandler }

constructor TCompleteTodoHandler.Create(const ATodoRepository: ITodoRepository);
begin
  FTodoRepository := ATodoRepository;
end;

procedure TCompleteTodoHandler.Handle(const ACommand: TCompleteTodo);
var
  LTodo: TTodo;

begin
  LTodo := FTodoRepository.GetById(ACommand.Id);
  if (not Assigned(LTodo)) then
  begin
    raise TodoNotFoundException.Create(ACommand.Id);
  end;

  // I know, it is a reference. I don't use the update method as this is usually done with UoW pattern in the decorator.
  LTodo.Complete();
end;

end.
