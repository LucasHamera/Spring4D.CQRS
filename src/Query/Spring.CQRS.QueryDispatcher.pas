unit Spring.CQRS.QueryDispatcher;

interface

uses
  Spring.Services,
  {}
  Spring.CQRS.Query;

type
  TQueryDispatcher = class
  strict private
    FLocator: IServiceLocator;

  public
    constructor Create(const ALocator: IServiceLocator);

    function Dispatch<TQueryResult; TQuery: IQuery<TQueryResult>>(const AQuery: TQuery): TQueryResult; overload;
  end;


implementation

uses
  System.Rtti,
  System.SysUtils,
  {}
  Spring.CQRS.QueryHandler;

{ TQueryDispatcher}

constructor TQueryDispatcher.Create(const ALocator: IServiceLocator);
begin
  FLocator := ALocator;
end;

function TQueryDispatcher.Dispatch<TQueryResult; TQuery>(const AQuery: TQuery): TQueryResult;
var
  lRttiCtx: TRttiContext;
  lQueryHandlerType: TRttiType;

  lHandler: TValue;

begin
  lRttiCtx := TRttiContext.Create();
  lQueryHandlerType := lRttiCtx.GetType(TypeInfo(IQueryHandler<TQueryResult, TQuery>));

  lHandler := FLocator.GetService(lQueryHandlerType.Handle);
  if (lHandler.IsEmpty) then
  begin
    raise Exception.Create('Cannot receive query handler');
  end;
  Result := IQueryHandler<TQueryResult, TQuery>(lHandler.AsInterface).Handle(AQuery);
end;

end.
