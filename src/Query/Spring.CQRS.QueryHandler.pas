unit Spring.CQRS.QueryHandler;

interface

uses
  Spring.CQRS.Query;

type
  IQueryHandler<TQueryResult; TQuery: IQuery<TQueryResult>> = interface
    ['{BB74104A-D9FA-43F6-A772-92089BD5C8B5}']
    function Handle(const AQuery: TQuery): TQueryResult;
  end;

implementation

end.
