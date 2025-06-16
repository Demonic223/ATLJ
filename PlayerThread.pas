unit PlayerThread;

{$O+}

interface

uses
  System.Classes, Windows, SysUtils, Winsock2, DateUtils, System.Threading,
  System.SyncObjs, Math;

type
  PSocket = ^TSocket;

  PPlayerThreadMobsUpdate = ^TPlayerThreadMobsUpdate;
  TPlayerThreadMobsUpdate = class(TThread)
  private
    Channel: BYTE;
    fCritSect: TCriticalSection;
    function UpdateMobsForMe: Boolean;
  protected
    procedure Execute; override;
  public
    Term: Boolean;
    ClientID: Integer;
    constructor Create(const ClientID: Integer; const Socket: TSocket; Channel: BYTE); virtual;
    destructor Destroy; override;
    procedure Terminate; reintroduce;
  end;

  PPlayerThread = ^TPlayerThread;
  TPlayerThread = class(TThread)
  private
    FDset: TFDSet;
    Channel: BYTE;
    fCritSect: TCriticalSection;
    DownNetTimes: Integer;

    function RecvPackets: Boolean;
    function CheckSocket: Boolean;
    function UpdateMobsForMe: Boolean;
  protected
    procedure Execute; override;
  public
    Term: Boolean;
    ClientID: Integer;

    constructor Create(const ClientID: Integer; const Socket: TSocket; Channel: BYTE); virtual;
    destructor Destroy; override;
    procedure Terminate; reintroduce;
  end;

implementation

uses
  GlobalDefs, Log, Packets, Player, EncDec, ItemFunctions, PlayerData,
  EntityMail, BaseMob;

{ TPlayerThread }

constructor TPlayerThread.Create(const ClientID: Integer; const Socket: TSocket; Channel: BYTE);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  fCritSect := TCriticalSection.Create;

  Self.ClientID := ClientID;
  Self.Channel := Channel;
  Self.Term := False;

  Servers[Channel].Players[ClientID].Create(ClientID, Channel);
  Servers[Channel].Players[ClientID].Base.TimeForGoldTime := Now;

  Inc(PlayersThreads);
end;

destructor TPlayerThread.Destroy;
begin
  fCritSect.Free;
  inherited;
end;

procedure TPlayerThread.Terminate;
begin
  if not Term then
  begin
    Servers[Channel].Disconnect(Servers[Channel].Players[ClientID]);
    Servers[Channel].Players[ClientID].PlayerThreadActive := False;
    Dec(PlayersThreads);
    Term := True;
  end;

  FillChar(Servers[Channel].Players[ClientID], SizeOf(TPlayer), 0);
  Servers[Channel].Players[ClientID].xdisconnected := True;

  inherited Terminate;
end;

function TPlayerThread.UpdateMobsForMe: Boolean;
var
  i, j: Integer;
  MyBase: PBaseMob;
begin
  Result := False;
  MyBase := @Servers[Channel].Players[ClientID].Base;

  for i := 0 to 449 do
  begin
    for j := 1 to 49 do
    begin
      if Servers[Channel].MOBS.TMobS[i].MobsP[j].Index = 0 then
        Continue;

      if InRange(Servers[Channel].MOBS.TMobS[i].MobsP[j].Index, 3340, 3369) then
        Continue;

      try
        Servers[Channel].MOBS.TMobS[i].MobsP[j].UpdateSpawnToPlayers(i, j, ClientID);
      except
        Continue;
      end;

      try
        if Servers[Channel].MOBS.TMobS[i].MobsP[j].CurrentPos.InRange(MyBase.PlayerCharacter.LastPos, 30) then
        begin
          Servers[Channel].MOBS.TMobS[i].MobsP[j].MobMoviment(ClientID);
          Servers[Channel].MOBS.TMobS[i].MobsP[j].MobHandler(ClientID);
        end;
      except
        Continue;
      end;
    end;
  end;
end;

procedure TPlayerThread.Execute;
var
  MPlayer: PPlayer;
begin
  DownNetTimes := 0;
  MPlayer := @Servers[Channel].Players[ClientID];

  MPlayer^.LastTimeSaved := Now;
  MPlayer^.xdisconnected := False;

  while not Term and not MPlayer^.xdisconnected do
  begin
    Sleep(5);

    fCritSect.Enter;
    try
      if not CheckSocket or not RecvPackets or MPlayer^.SocketClosed then
      begin
        Servers[Channel].Disconnect(MPlayer^);
        Servers[Channel].Players[ClientID].PlayerThreadActive := False;
        Dec(PlayersThreads);
        Term := True;
        Break;
      end;
    finally
      fCritSect.Release;
    end;

    Sleep(1);
  end;

  Terminate;
end;

function TPlayerThread.RecvPackets: Boolean;
var
  RecvBuffer: array[0..21999] of Byte;
  RecvBuffer2: array[0..21999] of Byte;
  initialOffset: Integer;
  HeaderSize, RecvBytes: Integer;
  Header2: TPacketHeader;
begin
  Result := False;

  if ServerHasClosed or Servers[Channel].Players[ClientID].SocketClosed then
    Exit;

  FillChar(RecvBuffer, SizeOf(RecvBuffer), 0);
  RecvBytes := Recv(Servers[Channel].Players[ClientID].Socket, RecvBuffer, 22000, 0);

  if (RecvBytes <= 0) or (WSAGetLastError = WSAEWOULDBLOCK) then
  begin
    Servers[Channel].Players[ClientID].SocketClosed := True;
    Exit;
  end;

  if (RecvBytes >= SizeOf(TPacketHeader)) and (RecvBytes <= 22000) then
  begin
    initialOffset := 0;

    if Servers[Channel].Players[ClientID].RecvPackets = 0 then
    begin
      if RecvBytes > 60 then
      begin
        initialOffset := 4;
        Move(RecvBuffer[initialOffset], RecvBuffer, 22000);
        Servers[Channel].Players[ClientID].RecvPackets := 1;
      end;
    end;

    Move(RecvBuffer, RecvBuffer2, 22000);
    TEncDec.Decrypt(RecvBuffer, 22000);

    FillChar(Header2, SizeOf(Header2), 0);
    Move(RecvBuffer, Header2, SizeOf(Header2));
    HeaderSize := Header2.Size;

    if Servers[Channel].Players[ClientID].Base.ClientID = 0 then
      Exit;

    fCritSect.Enter;
    try
      Servers[Channel].PacketControl(Servers[Channel].Players[ClientID], HeaderSize, RecvBuffer, initialOffset);
    finally
      fCritSect.Release;
    end;

    Result := True;
  end;
end;

function TPlayerThread.CheckSocket: Boolean;
begin
  Result := True;

  if (Servers[Channel].Sock = INVALID_SOCKET) or
     (Servers[Channel].Players[ClientID].Socket = INVALID_SOCKET) then
  begin
    if not Servers[Channel].Players[ClientID].xdisconnected then
    begin
      Dec(PlayersThreads);
      Servers[Channel].Disconnect(Servers[Channel].Players[ClientID]);
    end;
    Result := False;
  end;
end;

{ TPlayerThreadMobsUpdate }

constructor TPlayerThreadMobsUpdate.Create(const ClientID: Integer;
  const Socket: TSocket; Channel: BYTE);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  fCritSect := TCriticalSection.Create;

  Self.ClientID := ClientID;
  Self.Channel := Channel;
  Self.Term := False;
end;

destructor TPlayerThreadMobsUpdate.Destroy;
begin
  fCritSect.Free;
  inherited;
end;

procedure TPlayerThreadMobsUpdate.Execute;
var
  MPlayer: PPlayer;
begin
  MPlayer := @Servers[Channel].Players[ClientID];

  while not Servers[Channel].Players[ClientID].SocketClosed do
  begin
    Sleep(600);
    if Servers[Channel].Players[ClientID].IsInstantiated then
    begin
      UpdateMobsForMe;
    end;
  end;
end;

procedure TPlayerThreadMobsUpdate.Terminate;
begin
  inherited;
end;

function TPlayerThreadMobsUpdate.UpdateMobsForMe: Boolean;
var
  i, j: Integer;
  MyBase: PBaseMob;
begin
  Result := False;
  MyBase := @Servers[Channel].Players[ClientID].Base;

  for i := 0 to 449 do
  begin
    if Servers[Channel].MOBS.TMobS[i].IntName = 0 then
      Continue;

    for j := 1 to 49 do
    begin
      if Servers[Channel].MOBS.TMobS[i].MobsP[j].Index = 0 then
        Continue;

      if InRange(Servers[Channel].MOBS.TMobS[i].MobsP[j].Index, 3340, 3369) then
        Continue;

      if not Servers[Channel].Players[ClientID].IsInstantiated then
        Continue;

      try
        Servers[Channel].MOBS.TMobS[i].MobsP[j].UpdateSpawnToPlayers(i, j, ClientID);
      except
        Continue;
      end;

      if not(MyBase.BuffExistsByIndex(77) or MyBase.BuffExistsByIndex(53) or MyBase.BuffExistsByIndex(153)) and
         not MyBase.IsDead and
         (Servers[Channel].Players[ClientID].Status >= Playing) then
      begin
        try
          MyBase.LureMobsInRange;
        except
          Continue;
        end;
      end;

      try
        if Servers[Channel].MOBS.TMobS[i].MobsP[j].CurrentPos.InRange(MyBase.PlayerCharacter.LastPos, 30) then
        begin
          Servers[Channel].MOBS.TMobS[i].MobsP[j].MobHandler(ClientID);
        end;
      except
        Continue;
      end;
    end;
  end;

  if SecondsBetween(Now, MyBase.LastTimeGarbaged) >= 10 then
  begin
    MyBase.LastTimeGarbaged := Now;
    MyBase.TargetGarbageService;
  end;
end;

end.
