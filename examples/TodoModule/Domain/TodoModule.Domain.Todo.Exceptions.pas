unit TodoModule.Domain.Todo.Exceptions;

interface

uses
  System.SysUtils;

type
  TodoAlreadyCompletedException = class(Exception)
  public
    constructor Create(const AId: TGUID);
  end;

implementation

{ TodoAlreadyCompletedException }

constructor TodoAlreadyCompletedException.Create(const AId: TGUID);
const
  EXCEPTION_MESSAGE = 'Todo with id %s already completed.';

begin
  inherited CreateFmt(EXCEPTION_MESSAGE, [AId.ToString]);
end;

end.
