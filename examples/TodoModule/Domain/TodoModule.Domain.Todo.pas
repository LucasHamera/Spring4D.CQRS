unit TodoModule.Domain.Todo;

interface

type
  TTodo = class
  strict private
    FId: TGUID;
    FName: string;
    FIsComplete: Boolean;
  
  public 
    constructor Create(const AId: TGUID; const AName: string; const AIsCompleted: Boolean = False);

    property Id: TGUID read FId;
    property Name: string read FName;
    property IsComplete: Boolean read FIsComplete;

    procedure Complete();
  end;

implementation

uses
  TodoModule.Domain.Todo.Exceptions;

{ TTodo }
        
constructor TTodo.Create(const AId: TGUID; const AName: string; const AIsCompleted: Boolean);
begin
  FId := AId;
  FName := AName;
  FIsComplete := AIsCompleted;
end;

procedure TTodo.Complete;
begin
  if (FIsComplete) then
  begin
    raise TodoAlreadyCompletedException.Create(fId);
  end;
  FIsComplete := True;
end;


end.
