unit Spring.CQRS.Example.ContainerBuilder;

interface

uses
  Spring.Container;

type
  TContainerBuilder = class
  strict private
    procedure RegisterServices(const AContainer: TContainer);
    procedure RegisterModules(const AContainer: TContainer);

  public
    function Build(): TContainer;
  end;

implementation

uses
  Spring.CQRS.Registration,
  TodoModule.Registration;

{ TContainerBuilder }

function TContainerBuilder.Build: TContainer;
begin
  Result := GlobalContainer;

  RegisterServices(Result);
  RegisterModules(Result);

  Result.Build();
end;

procedure TContainerBuilder.RegisterServices(const AContainer: TContainer);
begin
  AContainer.RegisterInstance<TContainer>(AContainer);
  AContainer.RegisterType<TServiceLocatorAdapter>;
end;

procedure TContainerBuilder.RegisterModules(const AContainer: TContainer);
begin
  TCQRSRegistration.Register(AContainer);
  TTodoModuleRegistration.Register(AContainer);
end;

end.
