unit TodoModule.Application.Exceptions;

interface

uses
  System.SysUtils;

type
  TodoNotFoundException = class(Exception)
  public
    constructor Create(const AId: TGUID);
  end;

implementation

{ TodoNotFoundException }

constructor TodoNotFoundException.Create(const AId: TGUID);
const
  EXCEPTION_MESSAGE = 'Todo with id %s already completed.';

begin
  inherited CreateFmt(EXCEPTION_MESSAGE, [AId.ToString]);
end;

end.
