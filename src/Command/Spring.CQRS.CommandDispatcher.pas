unit Spring.CQRS.CommandDispatcher;

interface

uses
  Spring.Services,
  {}
  Spring.CQRS.Command;

type
  TCommandDispatcher = class
  private
    FLocator: IServiceLocator;

  public
    constructor Create(const ALocator: IServiceLocator);

    procedure Dispatch<TCommand: ICommand>(const ACommand: TCommand);
  end;

implementation

uses
  System.Rtti,
  System.SysUtils,
  {}
  Spring.CQRS.CommandHandler;

{ TCommandDispatcher }

constructor TCommandDispatcher.Create(const ALocator: IServiceLocator);
begin
  FLocator := ALocator;
end;

procedure TCommandDispatcher.Dispatch<TCommand>(const ACommand: TCommand);
var
  lRttiCtx: TRttiContext;
  lCommandHandlerType: TRttiType;

  lHandler: TValue;

begin
  lRttiCtx := TRttiContext.Create();
  lCommandHandlerType := lRttiCtx.GetType(TypeInfo(ICommandHandler<TCommand>));

  lHandler := FLocator.GetService(lCommandHandlerType.Handle);
  if (lHandler.IsEmpty) then
  begin
    raise Exception.Create('Cannot receive command handler');
  end;
  ICommandHandler<TCommand>(lHandler.AsInterface).Handle(ACommand);
end;

end.
