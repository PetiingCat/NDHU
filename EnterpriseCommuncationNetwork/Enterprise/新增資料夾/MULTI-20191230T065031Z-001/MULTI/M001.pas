unit M001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    procedure TCPSExecute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; cnt:integer;

implementation

{$R *.dfm}

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s:string;
begin
 repeat
   Athread.Connection.WriteLn('');
   Athread.Connection.WriteLn('(1) Get time!');
   Athread.Connection.WriteLn('(2) Get Date');
   Athread.Connection.WriteLn('(3) Quit');
   Athread.Connection.Write(':');

   s:=Athread.Connection.ReadLn();
   Athread.Connection.WriteLn('');
   if s ='1' then
   begin
     Athread.Connection.WriteLn( FormatDatetime('hh:mm:ss',now));
     Athread.Connection.WriteLn('');
   end
   else if s ='2' then
   begin
     Athread.Connection.WriteLn( FormatDatetime('yyyy/mm/dd',now));
     Athread.Connection.WriteLn('');
   end
   else if s ='3' then
   begin
     Athread.Terminate;
     break;
    end
 until 1<>1;
end;

end.
