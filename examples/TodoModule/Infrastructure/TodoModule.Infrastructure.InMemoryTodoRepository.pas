unit TodoModule.Infrastructure.InMemoryTodoRepository;

interface

uses
  TodoModule.Domain.Todo,
  TodoModule.Domain.TodoRepository,
  {}
  Spring.Collections;

type
  // Infrastructure layer
  TTodoRepositoryInMemory = class(TInterfacedObject, ITodoRepository)
  strict private
    FTodos: IList<TTodo>;

  public
    constructor Create();

    function GetAll(): IEnumerable<TTodo>;
    function GetById(const AId: TGUID): TTodo;
    procedure Add(const ATodo: TTodo);
  end;

implementation

{ TTodoRepositoryInMemory }

constructor TTodoRepositoryInMemory.Create();
begin
  FTodos := Tcollections.CreateObjectList<TTodo>(True);
end;

function TTodoRepositoryInMemory.GetAll: IEnumerable<TTodo>;
begin
  Result := FTodos;
end;

function TTodoRepositoryInMemory.GetById(const AId: TGUID): TTodo;
begin
  Result := FTodos.FirstOrDefault(
    function (const lTodo: TTodo): Boolean
    begin
      Result := lTodo.Id = AId;
    end
  );
end;

procedure TTodoRepositoryInMemory.Add(const ATodo: TTodo);
begin
  // I know, no id uniqueness check
  // Adding a copy of the object
  FTodos.Add(
    TTodo.Create(ATodo.Id, ATodo.Name, ATodo.IsComplete)
  );
end;

end.
