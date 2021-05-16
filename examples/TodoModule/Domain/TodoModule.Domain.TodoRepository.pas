unit TodoModule.Domain.TodoRepository;

interface

uses
  Spring.Collections,
  {}
  TodoModule.Domain.Todo;

type
  ITodoRepository = interface
    ['{4231DC92-3701-4A87-9BC1-47050DF47386}']   
    function GetAll(): IEnumerable<TTodo>;
    function GetById(const AId: TGUID): TTodo;
    procedure Add(const ATodo: TTodo);
  end;

implementation

end.
