unit TodoModule.Application.Query.GetTodos;

interface

uses
  Spring.CQRS.Query,
  Spring.Collections,
  Spring.CQRS.QueryHandler,
  {}
  TodoModule.Domain.Todo,
  TodoModule.Domain.TodoRepository;

type
  TGetTodos = class(TInterfacedObject, IQuery<IEnumerable<TTodo>>)
  end;

  TGetTodosHandler = class(TInterfacedObject, IQueryHandler<IEnumerable<TTodo>, TGetTodos>)
  strict private
    FTodoRepository: ITodoRepository;

  public
    constructor Create(const ATodoRepository: ITodoRepository);

    function Handle(const AQuery: TGetTodos): IEnumerable<TTodo>;
  end;

implementation

{ TGetTodosHandler }

constructor TGetTodosHandler.Create(const ATodoRepository: ITodoRepository);
begin
  FTodoRepository := ATodoRepository;
end;

function TGetTodosHandler.Handle(const AQuery: TGetTodos): IEnumerable<TTodo>;
begin
  Result := fTodoRepository.GetAll();
end;

end.
