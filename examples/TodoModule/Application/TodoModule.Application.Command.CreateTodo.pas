unit TodoModule.Application.Command.CreateTodo;

interface

uses
  Spring.CQRS.Command,
  Spring.CQRS.CommandHandler,
  TodoModule.Domain.TodoRepository;

type
  TCreateTodo = class(TInterfacedObject, ICommand)
  strict private
    FId: TGUID;
    FName: string;

  public
    constructor Create(const AId: TGUID; const AName: string);

    property Id: TGUID read FId;
    property Name: string read FName;
  end;

  TCreateTodoHandler = class(TInterfacedObject, ICommandHandler<TCreateTodo>)
  strict private
    FTodoRepository: ITodoRepository;

  public
    constructor Create(const ATodoRepository: ITodoRepository);

    procedure Handle(const ACommand: TCreateTodo);
  end;

implementation

uses
  TodoModule.Domain.Todo,
  {}
  System.SysUtils;

{ TCreateTodo }

constructor TCreateTodo.Create(const AId: TGUID; const AName: string);
begin
  FId := AId;
  FName := AName;
end;

{ TCreateTodoHandler }

constructor TCreateTodoHandler.Create(const ATodoRepository: ITodoRepository);
begin
  FTodoRepository := ATodoRepository;
end;

procedure TCreateTodoHandler.Handle(const ACommand: TCreateTodo);
var
  LTodo: TTodo;

begin
  LTodo := TTodo.Create(ACommand.Id, ACommand.Name);
  try
    FTodoRepository.Add(LTodo);
  finally
    FreeAndNil(LTodo);
  end;
end;

end.
