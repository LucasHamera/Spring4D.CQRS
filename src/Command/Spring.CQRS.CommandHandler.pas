unit Spring.CQRS.CommandHandler;

interface

uses
  Spring.CQRS.Command;

type
  ICommandHandler<TCommand: ICommand> = interface
    ['{C1078347-ED99-4CAF-BFBE-CACE81C94B93}']
    procedure Handle(const ACommand: TCommand);
  end;

implementation

end.
