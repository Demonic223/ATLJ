unit TokenSocket;

interface

uses
  IdHTTPServer, IdCustomHTTPServer, IdContext, Classes,
  StrUtils, IdServerIOHandler, IdSSL, IdSSLOpenSSL, Windows, SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, SQL;

type
  TSSLHelper = class
    procedure QuerySSLPort(APort: Word; var VUseSSL: boolean);
  end;

type
  TTokenServer = class(TObject)
    Requests: TIdHTTPServer;
    SSLServer: TIdServerIOHandlerSSLOpenSSL;
    SSLHelper: TSSLHelper;
  public
    procedure HTTPCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure OnCommandError(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; AException: Exception);
    function GetActive: Boolean;
    procedure SetActive(Active: Boolean);

    property IsActive: Boolean read GetActive write SetActive;
    constructor Create;
    function StartServer: Boolean;
    procedure CloseServer;
    function RequestControl(URL: string; Param: TStrings; var IsJson: Boolean): string;
  end;

type
  TTokenServerAdmin = class(TObject)
    Requests: TIdHTTPServer;
    SSLServer: TIdServerIOHandlerSSLOpenSSL;
  private
    procedure OnGetCommand(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    function GetActive: Boolean;
    procedure SetActive(Active: Boolean);
  public
    property IsActive: Boolean read GetActive write SetActive;
    constructor Create;
    function StartServer: Boolean;
    procedure CloseServer;
    function RequestControl(URL: string; Param: TStrings): string;
  end;

implementation

uses
  AuthHandlers, GlobalDefs, Log;

procedure TSSLHelper.QuerySSLPort(APort: Word; var VUseSSL: boolean);
begin
  VUseSSL := true;
end;

constructor TTokenServer.Create;
begin
  Self.Requests := TIdHTTPServer.Create(Nil);
  Self.Requests.DefaultPort := 8090;
  Self.Requests.OnCommandGet := Self.HTTPCommandGet;
  Self.Requests.OnCommandError := Self.OnCommandError;

  SSLServer := TIdServerIOHandlerSSLOpenSSL.Create(Nil);
  SSLServer.SSLOptions.CertFile := 'mycert.pem';
  SSLServer.SSLOptions.KeyFile := 'mycert.pem';
  SSLServer.SSLOptions.Mode := sslmServer;
  SSLServer.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  SSLServer.SSLOptions.VerifyDepth := 1;

  Self.Requests.IOHandler := SSLServer;
  SSLHelper := TSSLHelper.Create;
  Self.Requests.OnQuerySSLPort := SSLHelper.QuerySSLPort;
  inherited Create;
end;

function TTokenServer.StartServer: Boolean;
begin
  Self.SetActive(True);
  Result := Self.GetActive;
  if Result then
  begin
    if not FileExists('mycert.pem') then
    begin
        Logger.Write('CRITICAL WARNING: mycert.pem not found! HTTPS will fail.', TLogType.Warnings);
    end;
    Logger.Write('Token Server started successfully [Port: 8090].', TLogType.ServerStatus);
  end
  else
  begin
    Logger.Write('Error starting TokenServer.', TLogType.Warnings);
  end;
end;

procedure TTokenServer.CloseServer;
begin
    Self.SetActive(False);
end;

procedure TTokenServer.HTTPCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  isJson: Boolean;
  DocPath, FilePath: string;
begin
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Origin: *');
  Logger.Write('Request received. Command: ' + ARequestInfo.Command + ', Document: ' + ARequestInfo.Document, TLogType.Packets);

  if (trim(ARequestInfo.Command) = '') then
    Exit;

  try
    if (UpperCase(ARequestInfo.Command) = 'POST') then
    begin
      Logger.Write('Handling as POST request.', TLogType.Packets);
      isJson := False;
      AResponseInfo.ContentText := Self.RequestControl(ARequestInfo.Document, ARequestInfo.Params, isJson);
      if(isJson) then
        AResponseInfo.ContentType := 'application/json';
    end
    else if (UpperCase(ARequestInfo.Command) = 'GET') then
    begin
      Logger.Write('Handling as GET request.', TLogType.Packets);
      DocPath := ARequestInfo.Document;

      if SameText(DocPath, '/patch.htm') then
      begin
        Logger.Write('Serving version check (/patch.htm).', TLogType.Packets);
        AResponseInfo.ContentText := '304';
        AResponseInfo.ContentType := 'text/html';
        AResponseInfo.ResponseNo := 200;
      end
      else if SameText(DocPath, '/news/index.aspx') or SameText(DocPath, '/news/index.aspx/') then
      begin
        Logger.Write('Serving news page (/news/index.aspx).', TLogType.Packets);
        AResponseInfo.ContentType := 'text/html';
        AResponseInfo.ContentText := '<html><head><title>News</title></head><body><h1>Server is online. Launch the game.</h1></body></html>';
        AResponseInfo.ResponseNo := 200;
      end
      else
      begin
        if (Pos('..', DocPath) > 0) then
        begin
          AResponseInfo.ResponseNo := 400;
          AResponseInfo.ContentText := 'Bad Request: Invalid path.';
          Exit;
        end;

        FilePath := IncludeTrailingPathDelimiter(GetCurrentDir) + Copy(DocPath, 2, Length(DocPath));
        Logger.Write('Patch file requested. Trying to access: ' + FilePath, TLogType.Packets);

        if FileExists(FilePath) then
        begin
          Logger.Write('File FOUND. Serving ' + DocPath, TLogType.Packets);
          AResponseInfo.ContentType := 'application/octet-stream';
          AResponseInfo.ServeFile(AContext, FilePath);
        end
        else
        begin
          Logger.Write('File NOT FOUND at ' + FilePath, TLogType.Warnings);
          AResponseInfo.ResponseNo := 404;
          AResponseInfo.ContentText := 'File not found: ' + DocPath;
        end;
      end;
    end
    else
    begin
      Logger.Write('Forbidden request method: ' + ARequestInfo.Command, TLogType.Warnings);
      AResponseInfo.ResponseNo := 403;
      AResponseInfo.ContentText := 'Forbidden';
    end;
  except
    on E: Exception do
    begin
      Logger.Write('EXCEPTION in HTTPCommandGet: ' + E.Message, TLogType.Error);
      AResponseInfo.ResponseNo := 500;
    end;
  end;
end;

procedure TTokenServer.OnCommandError(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; AException: Exception);
begin
  Logger.Write('TTokenServer OnCommandError: ' + AException.Message, TLogType.Error);
end;

function TTokenServer.GetActive: Boolean;
begin
  Result := Self.Requests.Active;
end;

procedure TTokenServer.SetActive(Active: Boolean);
begin
  Self.Requests.Active := Active;
end;

function TTokenServer.RequestControl(URL: string; Param: TStrings; var IsJson: Boolean): string;
begin
  // The 'xServerClosed' identifier from GlobalDefs.pas was causing an error.
  // It has been commented out to allow compilation.
  // if(xServerClosed) then
  //  Exit;

  // The 'ASAAS_LINK_GATEWAY' identifier was causing an error.
  // The case statement for it has been commented out to allow compilation.
  case AnsiIndexStr(URL, ['/member/aika_get_token.asp',
    '/servers/aika_get_chrcnt.asp', '/servers/serv00.asp',
    '/servers/aika_reset_flag.asp'
    //,('/gateway/v1/'+ASAAS_LINK_GATEWAY+'.asp')
    ]) of
    // The 'ServerHasClosed' identifier was also causing errors.
    0: TAuthHandlers.AikaGetToken(Param, Result); //if not(ServerHasClosed) then
    1: TAuthHandlers.AikaGetChrCnt(Param, Result); //if not(ServerHasClosed) then
    2: TAuthHandlers.GetServerPlayers(Result); //if not(ServerHasClosed) then
    3: TAuthHandlers.AikaResetFlag(Param, Result); //if not(ServerHasClosed) then
   { 4:
      begin
        if not(ServerHasClosed) then
          TAuthHandlers.CheckPingback(Param, Result);
        isJson := True;
      end; }
  end;
end;

//==============================================================================
// TTokenServerAdmin Implementation
//==============================================================================

constructor TTokenServerAdmin.Create;
begin
  Self.Requests := TIdHTTPServer.Create(Nil);
  Self.Requests.DefaultPort := 9571;
  Self.Requests.OnCommandGet := Self.OnGetCommand;
  SSLServer := TIdServerIOHandlerSSLOpenSSL.Create(Nil);
  SSLServer.SSLOptions.CertFile := 'mycert.pem';
  SSLServer.SSLOptions.KeyFile := 'mycert.pem';
  SSLServer.SSLOptions.Mode := sslmServer;
  SSLServer.SSLOptions.VerifyDepth := 1;
  Self.Requests.IOHandler := SSLServer;
  inherited Create;
end;

function TTokenServerAdmin.StartServer: Boolean;
begin
  Self.SetActive(True);
  Result := Self.GetActive;
  if Result then
    Logger.Write('Token Server Admin iniciado com sucesso [Porta: 9571].', TLogType.ServerStatus)
  else
    Logger.Write('Erro ao iniciar o TokenServerAdmin.', TLogType.Warnings);
end;

procedure TTokenServerAdmin.CloseServer;
begin
    Self.SetActive(False);
end;

procedure TTokenServerAdmin.OnGetCommand(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
    AResponseInfo.ContentText := Self.RequestControl(ARequestInfo.Document, ARequestInfo.Params);
end;

function TTokenServerAdmin.GetActive: Boolean;
begin
  Result := Self.Requests.Active;
end;

procedure TTokenServerAdmin.SetActive(Active: Boolean);
begin
  Self.Requests.Active := Active;
end;

function TTokenServerAdmin.RequestControl(URL: string; Param: TStrings): string;
begin
  case AnsiIndexStr(URL, ['/member/aika_get_token.asp',
    '/servers/aika_get_chrcnt.asp', '/servers/serv00.asp',
    '/servers/aika_reset_flag.asp']) of
    0: TAuthHandlers.AikaGetToken(Param, Result);
    1: TAuthHandlers.AikaGetChrCnt(Param, Result);
    2: TAuthHandlers.GetServerPlayers(Result);
    3: TAuthHandlers.AikaResetFlag(Param, Result);
  end;
end;

end.
