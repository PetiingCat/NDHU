unit p002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer;

type
  chat = record
    Ath: TIdPeerThread;
    id:string;
    used:boolean;
  end;


  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    procedure TCPSExecute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  All:array[0..9] of chat;

implementation

{$R *.dfm}

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s,id,peerid,msg:string; i,me:integer;
begin
  for i:=0 to 9 do
  begin
    if All[i].used=false then
    begin
      All[i].Ath := Athread; All[i].used:=true;me:=i;
    end;
  end;
 repeat
  Athread.Connection.WriteLn('1. Your name.');
  Athread.Connection.WriteLn('2. Peer IP');
  Athread.Connection.WriteLn('3. Nesssage');
  Athread.Connection.WriteLn('4. Quir');
  Athread.Connection.WriteLn('5. SEE ALL id');
  Athread.Connection.WriteLn('6. return me info');
  s := Athread.Connection.ReadLn();
  if s='1' then
  begin
    id:=Athread.Connection.ReadLn();
    All[me].id:=id;
  end
  else if s='2' then
  begin
    peerid:=Athread.Connection.ReadLn();
  end
  else if s='3' then
  begin
    msg:=Athread.Connection.ReadLn();
    for i:=0 to 9 do
    begin
      if((All[i].used=true)and(All[i].id=peerid)) then
      begin
        All[i].Ath.Connection.WriteLn(msg); break;
      end
    end
  end
  else if s='4' then
  begin
    Athread.Terminate; All[me].used:=false; break;
  end
  else if s='5' then
  begin
    Athread.Connection.WriteLn('------');
       for i:=0 to 9 do
       begin
         Athread.Connection.WriteLn('ID=['+All[i].id+']');
       end;
    Athread.Connection.WriteLn('------');
  end
  else if s='6' then
  begin
    Athread.Connection.WriteLn('My id='+All[me].id);
    Athread.Connection.WriteLn('Peer IP='+peerid);
    if All[me].used=True then
    begin Athread.Connection.WriteLn('1'); end
    else
    begin Athread.Connection.WriteLn('2'); end
  end

 until 1<>1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
     for i:=0 to 9 do All[i].used:=false;
end;

end.
